Return-Path: <netdev+bounces-231637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5A6BFBD56
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 14:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4B056382A
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 12:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D09314A8B;
	Wed, 22 Oct 2025 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8MoGJE2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A2C33EB10
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 12:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761135793; cv=none; b=TPz35uT50XwGCNTWm2K6TCHPg1zFTVc5ehcLsdzWM78WybGV3JoT7ClIfrcN2Fxtj84xc8ojBGsMmGXWZJmlpzpEuehxqNDBYfYglYtI3/h4T+U3p974oo4xwz1Iaactjzr035ONLN4+58m80l8+RF+KOTEQuQGja/adViY7J38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761135793; c=relaxed/simple;
	bh=HbeFBwtgzquCzF8PTJMvgwZfmjwm0zMaLYvKCsuZUnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RK9ysuUr/wvo/ouoF05zwsi65d6/b8DZG/31Tsgq6mMRyRmsC5ruMpCtBxrXQWbEcid5G+5AIZdNVSCDj68lFgGk3FxgADZGF2rue2p0KCljBfFLoe31gJNjMtlxQ55EP0OXFkFxucmOalkhFAf8xzzVrqh+kjUE6VBzSbNyJnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L8MoGJE2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761135788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Udv/fmgj5IzxIAQ59j8QIxSocwUXj3+ehFUJn9q19yA=;
	b=L8MoGJE2ISv5kZDQndsnSt+vwYS6446UmuU0fIUz12frOAIyy3Qk/BTbI3ilaNSU7PHmuj
	JCgfCNTlZE0KlLIWub5FaL4cao4snd2h2+62KTYcK1cK4d/qExlBUpU9ymNlAWQaI4G5cI
	itYCbR+e4aA3nL6LS6+czSndDQfb3Lw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-8dkaZ0OjMuiCmI6LhkR1BA-1; Wed,
 22 Oct 2025 08:23:07 -0400
X-MC-Unique: 8dkaZ0OjMuiCmI6LhkR1BA-1
X-Mimecast-MFC-AGG-ID: 8dkaZ0OjMuiCmI6LhkR1BA_1761135786
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1164818001C6;
	Wed, 22 Oct 2025 12:23:06 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.69])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2122119560B4;
	Wed, 22 Oct 2025 12:23:03 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH iproute2] devlink: fix devlink flash error reporting
Date: Wed, 22 Oct 2025 14:23:02 +0200
Message-ID: <20251022122302.71766-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Currently, devlink silently exits when a non-existent device is specified
for flashing or when the user lacks sufficient permissions. This makes it
hard to diagnose the problem.

Print an appropriate error message in these cases to improve user feedback.

Prior:
$ devlink dev flash foo/bar file test
$ sudo devlink dev flash foo/bar file test
$

After patch:
$ devlink/devlink dev flash foo/bar file test
devlink answers: Operation not permitted
$ sudo devlink/devlink dev flash foo/bar file test
devlink answers: No such device

Fixes: 9b13cddfe268 ("devlink: implement flash status monitoring")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 devlink/devlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 171b85327be3..b162cf4050f9 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -4594,6 +4594,8 @@ static int cmd_dev_flash(struct dl *dl)
 	} while (!ctx.flash_done || (ctx.not_first && !ctx.received_end));
 
 	err = mnlu_gen_socket_recv_run(&dl->nlg, NULL, NULL);
+	if (err < 0)
+		pr_err("devlink answers: %s\n", strerror(errno));
 
 out:
 	close(pipe_r);
-- 
2.51.0


