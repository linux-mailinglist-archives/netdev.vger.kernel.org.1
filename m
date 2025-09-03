Return-Path: <netdev+bounces-219468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECC5B41714
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E86C3AF9F5
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 07:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F522E03EB;
	Wed,  3 Sep 2025 07:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkPoJrS7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7832DFA46
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885526; cv=none; b=nfY35FQnIJe3vQ1w9qg6+lESz7kRxj9sCIgjVAApxKFfuG0KykNJN4Mw2+7XnAxDrrOWOmSLbW1//VyxYoB16ggsl0rdtbJ1pyiQd9u9km4NsqmhuvWzvXoAWAKGtW2NiLuN9XPWFQ/3jg3J6yP7To4LJlCJ5neoNc3wNeX4Ggk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885526; c=relaxed/simple;
	bh=iGLShheV0evvQrSxU5mykGe76BHZFg90srQWlu2KTZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V607BdjLD6aQ0/f3JtUPJs1jEtHWGbtzBmYrsWFozfG9h6LgxlDRtNCpzYw+2VroCiD1b3h9d8RdeUWYXPxaRDt45YFFTvRtfcQ5Ezu4zHUA1avn/9Ht+Vu/yksrTAxGUZMfY4V9TwmsqeYurwpG6Ad+yinRwG9gCW5fs0d2WSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CkPoJrS7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756885523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ruFQmAIIIiTeLpCxAfAa6mQkq6URjSMn5OJDIl/aHrg=;
	b=CkPoJrS74HfNLM2D0GY6fBuWmRrzArWpbat6RbYSfNTuaXbqjTEOnWZ2H6Rp8ASP0/OmF/
	NC7bdD4eatzz1pC564G/pagmVGomAvGYKznn/oLdd9ibnPWYIE7EuXbvZbNtNyVTosIkK+
	Wo6ivx2KtWhx6HTeIJWlKKEsHUeMwqA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-Ow3XlDffOmeThQO-xYR-dA-1; Wed,
 03 Sep 2025 03:45:18 -0400
X-MC-Unique: Ow3XlDffOmeThQO-xYR-dA-1
X-Mimecast-MFC-AGG-ID: Ow3XlDffOmeThQO-xYR-dA_1756885516
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 808131956096;
	Wed,  3 Sep 2025 07:45:16 +0000 (UTC)
Received: from renaissance-vector.mxp.redhat.com (unknown [10.32.181.15])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 37CBE300018D;
	Wed,  3 Sep 2025 07:45:14 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH iproute2-next] tc: gred: fix debug print
Date: Wed,  3 Sep 2025 09:44:56 +0200
Message-ID: <6a4fdec8d262cab7efcedd2587a3b2b9bb1c3604.1756885444.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When build with -DDEBUG, tc build fails with:
q_gred.c: In function ‘init_gred’:
q_gred.c:53:17: error: passing argument 2 of ‘fprintf’ from incompatible pointer type [-Wincompatible-pointer-types]
   53 |                 DPRINTF(stderr, "init_gred: invoked with %s\n", *argv);
      |                 ^~~~~~~
      |                 |
      |                 FILE *

This is due to the DPRINTF macro call. Indeed DPRINTF is defined as a
two-args macro when -DDEBUG is used, while it uses 3 args in this call.

Fix it simply dropping the useless first arg.

Fixes: aba5acdfdb34 ("(Logical change 1.3)")
Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
---
 tc/q_gred.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tc/q_gred.c b/tc/q_gred.c
index 84fc9124..95573218 100644
--- a/tc/q_gred.c
+++ b/tc/q_gred.c
@@ -50,7 +50,7 @@ static int init_gred(const struct qdisc_util *qu, int argc, char **argv,
 	opt.def_DP = MAX_DPs;
 
 	while (argc > 0) {
-		DPRINTF(stderr, "init_gred: invoked with %s\n", *argv);
+		DPRINTF("init_gred: invoked with %s\n", *argv);
 		if (strcmp(*argv, "vqs") == 0 ||
 		    strcmp(*argv, "DPs") == 0) {
 			NEXT_ARG();
-- 
2.51.0


