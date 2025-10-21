Return-Path: <netdev+bounces-231378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1840DBF841B
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 21:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F8DC4F7D72
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 19:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF698350A02;
	Tue, 21 Oct 2025 19:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOpGIq4P"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F33351FBA
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761074842; cv=none; b=D22lutgVKnUM+WWn/lls6I2UkNoZefMcI6xkPUjxGM8XcS5qhGGGnIRV7OlQVbCXpicJsn9JEKN4hsTVb3SkkYw6pqUkc9LDJiAyw23pmbLWsLmNYDLxYD+Nh7YkMTofHKmR/U3xIAxcVdC5A+/NgWiFZ8ZBYLcTPPQ3zFhQtew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761074842; c=relaxed/simple;
	bh=9UgYe/0f+3rcA+q8AP5EODPI4RbFaRpNKrFT10nq72s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cs21bMGPRjCSi8CCQlNNs6qhQT0bT3Uvp/w3nGYfH27kgkM8jx68NV/m1u+GVKU/KFaMwSrCOggUx/t+3KCE+f77k/1xaUwvsgrbWtRTHcgcUK8d/zpFL6g+YJxL390cOw5PQ5xcsndzgUTtdxBtSyfBGcXMsSq2lWi57UdOeIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DOpGIq4P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761074840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=in20bsy0LyeSLyKceu9LCiOtBDOnLlwPQlHz1p/+9SU=;
	b=DOpGIq4PNdnGpsBGQap5eKGb+wy2k0TTcmlOudLe+5v6EmmrfQ7dZia5DRLXMmJbV8RcZX
	Uhum9AsDhQ2wBPItVMi2+cIYg+Wcawofwn+ujSaHmF8gMW6XTG/t8LzsNv0XeSFD6uDbqj
	7848vnWF0kTzcGAI+bP5z/t3WXKoP1k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-fpPgyTI_NguhSWdu_WzlEA-1; Tue,
 21 Oct 2025 15:27:13 -0400
X-MC-Unique: fpPgyTI_NguhSWdu_WzlEA-1
X-Mimecast-MFC-AGG-ID: fpPgyTI_NguhSWdu_WzlEA_1761074832
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D375618002F9;
	Tue, 21 Oct 2025 19:27:11 +0000 (UTC)
Received: from tc2.redhat.com (unknown [10.44.32.244])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1642E19560B0;
	Tue, 21 Oct 2025 19:27:09 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH iproute2-next] mptcp: add implicit flag to the 'ip mptcp' inline help
Date: Tue, 21 Oct 2025 21:26:56 +0200
Message-ID: <0a81085b8be2bee69cf217d2379e87730c28b1c1.1761074697.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

ip mptcp supports the implicit flag since commit 3a2535a41854 ("mptcp:
add support for implicit flag"), however this flag is not listed in the
command inline help.

Add the implicit flag to the inline help.

Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
---
 ip/ipmptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 2415cac8..6bfdc7bb 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -32,7 +32,7 @@ static void usage(void)
 		"	ip mptcp limits show\n"
 		"	ip mptcp monitor\n"
 		"FLAG-LIST := [ FLAG-LIST ] FLAG\n"
-		"FLAG  := [ signal | subflow | backup | fullmesh ]\n"
+		"FLAG  := [ signal | subflow | backup | fullmesh | implicit ]\n"
 		"CHANGE-OPT := [ backup | nobackup | fullmesh | nofullmesh ]\n");
 
 	exit(-1);
-- 
2.51.0


