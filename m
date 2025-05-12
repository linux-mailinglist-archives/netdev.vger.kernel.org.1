Return-Path: <netdev+bounces-189705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B38F3AB33B1
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 11:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A011893844
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 09:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27731267F66;
	Mon, 12 May 2025 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="aXAQ0/BI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3184E25B673;
	Mon, 12 May 2025 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042116; cv=none; b=u8PdrAe1A2olrTB4bk/IqdwjrwdeNB/EbldTVvrgDAARmX0ysJvMZGN5l0d1s0SzoMcdcaYddlONlOi11tIAR7HDrOsEwY7+m+WebTKLRwbGnpNEOdpULfUJQ72vS4bJ/mJhMuAKfYQptQhUab4QPuWWCuKrkhzO+lrWAId86Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042116; c=relaxed/simple;
	bh=cNkbbNYAu3E2YQ3WWnJW9VRv2t9jFvmiKeEEfPTdN+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e+N/kLzAt/T7kMRG8yAlFyGqOhwLxZyZPsAPMJNXI4EhRe77TQ9v8tfzDTNRBrG042r8dYHwQjotshR/iv8DJD0SYUs9DvZKi3RKyiU8KJX0pOHsNjYB7J1CTO02vum6sQiutDqxPMZp1Hv6MYUPMdAJlunJcMy0zSId037eAxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=aXAQ0/BI; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from localhost.localdomain (unknown [202.119.23.198])
	by smtp.qiye.163.com (Hmail) with ESMTP id 14bbcd7cc;
	Mon, 12 May 2025 17:28:23 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: steffen.klassert@secunet.com
Cc: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [RFC PATCH] xfrm: use kfree_sensitive() for SA secret zeroization
Date: Mon, 12 May 2025 09:28:08 +0000
Message-Id: <20250512092808.3741865-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGEkZVkhPHkwYQ01KTRodGVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJS0lVSkpCVUlIVUpCQ1lXWRYaDxIVHRRZQVlPS0hVSktISk9ITFVKS0tVSk
	JLS1kG
X-HM-Tid: 0a96c3d2f00103a1kunm14bbcd7cc
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KzI6Dzo5AzIMCU42AyELDw1J
	TB4KCktVSlVKTE9MS09JSktPSENPVTMWGhIXVQESFxIVOwgeDlUeHw5VGBVFWVdZEgtZQVlJS0lV
	SkpCVUlIVUpCQ1lXWQgBWUFJTEtLNwY+
DKIM-Signature:a=rsa-sha256;
	b=aXAQ0/BI3bFwwB5lD31oisUrYB6qQVfOSo3SeH/kgoHwJBGF5gY4irwt9WV35rwVJ8ydAldJkOfcqauGqAo5gddXpIzqMB+mJjiKdzH8Qc9Uq/1gmoWIWBgCJnVzTvCho0bNFqgKXFAC70aXNeJBRhnM4isUjY4UI9S4jK6s23k=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=hmJRuMzyBhlQWaUGR3p9QNP0/0HLCHwLe2ozxI7s9ps=;
	h=date:mime-version:subject:message-id:from;

The XFRM subsystem supports redaction of Security Association (SA)
secret material when CONFIG_SECURITY lockdown for XFRM secrets is active.
High-level copy_to_user_* APIs already omit secret fields, but the
state destruction path still invokes plain kfree(), which does not zero
the underlying memory before freeing. This can leave SA keys and
other confidential data in memory, risking exposure via post-free
vulnerabilities.

This patch modifies __xfrm_state_destroy() so that, if SA secret
redaction is enabled, it calls kfree_sensitive() on the aead, aalg and
ealg structs, ensuring secure zeroization prior to deallocation. When
redaction is disabled, the existing kfree() behavior is preserved.

Note that xfrm_redact() is the identical helper function as implemented
in net/xfrm/xfrm_user.c. And this patch is an RFC to seek feedback on
whether this change is appropriate and if there is a better patch method.

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 net/xfrm/xfrm_state.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 341d79ecb5c2..b6f2c329ea9d 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -593,15 +593,28 @@ void xfrm_state_free(struct xfrm_state *x)
 }
 EXPORT_SYMBOL(xfrm_state_free);
 
+static bool xfrm_redact(void)
+{
+	return IS_ENABLED(CONFIG_SECURITY) &&
+		security_locked_down(LOCKDOWN_XFRM_SECRET);
+}
+
 static void ___xfrm_state_destroy(struct xfrm_state *x)
 {
+	bool redact_secret = xfrm_redact();
 	if (x->mode_cbs && x->mode_cbs->destroy_state)
 		x->mode_cbs->destroy_state(x);
 	hrtimer_cancel(&x->mtimer);
 	timer_delete_sync(&x->rtimer);
-	kfree(x->aead);
-	kfree(x->aalg);
-	kfree(x->ealg);
+	if (redact_secret) {
+		kfree_sensitive(x->aead);
+		kfree_sensitive(x->aalg);
+		kfree_sensitive(x->ealg);
+	} else {
+		kfree(x->aead);
+		kfree(x->aalg);
+		kfree(x->ealg);
+	}
 	kfree(x->calg);
 	kfree(x->encap);
 	kfree(x->coaddr);
-- 
2.34.1


