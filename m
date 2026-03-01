Return-Path: <netdev+bounces-262400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGWlDBpIpGk0cQUAu9opvQ
	(envelope-from <netdev+bounces-262400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 15:07:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9411D0229
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 15:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29B613006001
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 14:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9B1317141;
	Sun,  1 Mar 2026 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b="JwonDg1n"
X-Original-To: netdev@vger.kernel.org
Received: from sonic307-54.consmr.mail.ir2.yahoo.com (sonic307-54.consmr.mail.ir2.yahoo.com [87.248.110.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAE441C71
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 14:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.248.110.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772374014; cv=none; b=AFPucUK5axlZrnfGERABVc8DtKGCNhy3kyMsO8uYtzDgIrsqrdh0DzEbwrbxEdbBiZ4jEQ5oDtq/cIsOAAWcjWCtz00pid3ovVaZ9n/DdMyMR5ApdCeytr4/xPqukXmZYZfxrIBa5lYah6UF9RPESazDIsxESzoMMVUwzV4luh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772374014; c=relaxed/simple;
	bh=i4H5OPIALoajCcINbTsjmpuKcfw2zVtRCm3NdJXip/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=iyZNX/HvQMTYKUez2AOnlXRG/CU2Rf8M1WtOvGiWqEzkRa/rJoJlZYBuyOlqawn2fyUxRbtp8ihJwfNBYglvGekTHb1NBSXQ2ghsvqPJwAikhxPCVpJ0jD5dCEJVntxJbbFMLS8vEnarVBFg2p2bOl90GEdZdIJKwa9lvzWnO6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl; spf=pass smtp.mailfrom=yahoo.pl; dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b=JwonDg1n; arc=none smtp.client-ip=87.248.110.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048; t=1772374006; bh=zhhGTUWkJKcVqJkFMLukzF0Eie7oa0SIWc2PvG8js5g=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=JwonDg1nl25Hmsu5ILqT03FqWvGHVQ+7RLGYT2h6EkC7JJO6whbQJ3WcihSpUTruc4q7dZCHw9QEu5xQMWIG2hkjjCi+8XyXNmdm6mVZp5NxuGnXVUzzjs1bETmnYDCYMGBiNG8w/jBLwum6QQHtm/lrgtbwUj5hvvsnceDaIi/3+kUyvAKbZU/mPyGDcJfTmnWp20/l2yQtxSshbU0yDdQXhrixLAYNY7wFK2VH828UZJPmLtC5OgzmGJybNthngGmwbrdEVAKecHbx0/i5XQgvQu5xwJzm2dmAo25zKmGI7n2q+KIDwJWUIOQO0phCYq9DCV/QGrDgAElTn5uk/g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1772374006; bh=IK2kp3DaiTfnPUzWXb71Cqu6tBWeqJM/StExl/9eAfP=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=lXFaTvaQBO/G6M6xN1sMhkIT6hyDrqHilS8qWgj/vO0ZoBPyMpaLbvNJdzdWGIjFJuCDbRh1B8Mps3z3i3lFey/jiXmVnr6ZZUnaEULuGKvGE1Gt1I2O0VAfqBgJtKps77uTxXi841y9BjrGlW8/moVy8ceIRixbcjWeYwRfQYFb5PXX4DxJCY3/FHyNx7/S+CGfKoXlazHwkgIMCjRQuZiUwrUSmM3LTLOTmoipDlA0LJrK8NoCU8sqMK3dQmfCFen1cGegMsGw0J9ZNgy/xQYf7O9JJ/btZMJU7m9+35n/nSkNCSnZccn30uIy3W/5pM1TIc1N8lb4WxIeZWKgkQ==
X-YMail-OSG: ThOzNmUVM1k5FV7FXH84YnP5bGvE5ywU6ZdqxX5r.egBgmMEt1W13K9MjH4VDzu
 X0O4fbv28Rt3v7jjNqutPmsgG2KzYaudeEv0NpSUXOKEyWFFhhgVzVVVgFWwq.25lTs8sCBRBM6y
 VfjkEyvLc9l8hUoGWpp86xzLNGIiR9kI016OemzlTtKO4qGJfLPmxY4LjxLER1RVnsyt6gQzDZ2f
 uw3C0RVqANhtO3MsZCgjimlq0SOYD6x7WixX5J2lzJ2nl13Uv6ViuBKgLT3Bgr.AGzDaxvpGpA86
 tcySLD5DNnQwVjc7pL8gF9mePXxjanXxh45UQOMofyGrulIsINP4q7TgRuYJoPWU6teCZ7aDmPFq
 liwruAjaBzCCFtnuDpfmQr76311AyPGD8U24m_jUQltSIYfrqsM_BldlSjUlYikl_8GSqBySiZaV
 Khw48EM4_3TUJC8FL5QTfep1rOLdFV5M8TCaUOR8VoLOYxuqnwY.X4fchS5KkiXVxwXeTKd_CG3n
 t5WYdLivDMu8raV.NQrIYm6k48kU27Z4ecGd6EnA8A0f5.0g9DYQ_W9QZL28nwj.OhoMmdccQYcB
 b9.B4wvnTBQKmDEiH3pC8nB2krWedWKnjWEVtFtNnycpbYW5m3eiUfyqhGLkLsKgiqKdG4lG1OwS
 DPkAoWj_R6HDWkQRI7nUvew5ntpAER86llBNtoy1duFaCpL5iFPyv7YjoFLBrk6NudiL.2vGVxh0
 I6PNEnWcQBEWta4LH06oYRhIP899_ojeuIzK8bw86OfAac1jvrNSo4pHZM3AktRmlSBMbsvUxazX
 0cNwtjn3gK2uULl2ma5uD22ar3rW80kBBOq2PukQmoYq9jQ57kaAu3EOK3gVxIF1FWIxgfUIBa8X
 TCblzRsbl_tanRvWsOIGHVo7RyC9Iz7tr3zUux8.8HgqQS1B64IwjFhv.YpjtIJDz2QBlRkh_nhf
 J0Px2KILbnXF0kh.DxSHssnUL3JCyLch6ujThUw.VKGC3THyua45UA.yKABtaYs9GPm.YP2taUBu
 IVXzTg4vqYzGFQuIHyXh6ggw8J2B7oUWX4u8wpkc4MVUSXrkRh6..Bojnuzzb5HWMB3Nps7oYcOv
 hOFgw5b9Mg2KubG8dyRBMyO3QhsHCdNyR8gNd3SeO9E3kh5d2sWextXN8vEIsGVyP_pGEiarCzhg
 H6Mcajhvc1YIIiCh2UyEHmu6uILtNOs_ZAMwzOpicXp4PRM4DBksjJfenJhRBVNenCXh_NRofTd6
 sJ8XBa4WqDs2_sGbpJWEntYOcDdmalArkV9TmVcISc1lSyYdGkJ9mMfqCVvNzHaqGTXY7uw0HwHx
 LieZeL.OuEtgs7yYcAILqd9NuWqrhkzgwY6txZOJrBMPmaZ09B9PGMc9.ln7mQriA.orNFvddyA8
 AQWtklHYNCNBVz._OP8oZqlDJD1mJgAN.NGH2TaouANyZnkkK5_uHtAUmQUJKrhBkc5D4.olYowd
 a1hITxIIX4ZyJdFvuwjjR6._JAxlajPvNoW3RTZniadjs8bvjWzXRf6KyBuUZBrNZrHj6FCKp8BY
 POB.qCPWf8jckqsuEcNCAaViPEhfUASLpD4F25IUJ_iwz6PXE7v_.p_P1fin..9Me9VCnlU31j1.
 vIffkhGztSK9O7thJiyDsD.3Z95N5jffT4DFI6Xzw19u9auxmHHyXJBC6YqiOT_dNriCLd_pcT08
 KMXnCvK0ydHRhxbgRe15XiZ9DPrJ9rLHA6dMvClbJmVOc3pTJb0MylGUqlKHkHhruV2IqAtsK_e7
 Buop4sN_KjR6nHu.GjvS2DEA8.7NhijN5OruFP_RlBnlF0p2Tv2tR6ACYryDWONsClV77SI7eprn
 ocyiMxL_1agvguTs5DrLlOAcBVkRSTdyScg3TsAEedWaLEjxoNT3FxcsGakEGdoRtetPf2vv6co6
 Cjekr0uBJz_gJgwj2xOQo2lMDgefBWgUFZdea3WZ4xGQCmAD9hDafhEw2aOu1M_PK3COmjMIBJJI
 exkxU5U9ojUnSKOET6y8dOuEUjVi3ZHpKrNKv3HhKRxEZ5qRXMCE13qSvwEBae7Xl4zvZLI7_j4j
 4IW1sNNBXwZswdzjOR2aOkQPT_XEgLfI7e2obBTwBw6JB.67qpzKIKUobKNBw31EntuNfwizVIqJ
 FR5x0mnNMpXQfvJUzJ6gGlZIASX3wcePoo6PYdfwI53Y7UmRCPRzn9Oj7vO4OBXFDm.U2iKfXT9n
 BYgC9eakWVCzqid.1uU1pDRbSZRxiJCi5NLe3OYa1IeBVROGMu565iH1n..Q-
X-Sonic-MF: <tomasz.unger@yahoo.pl>
X-Sonic-ID: 209d709a-ec78-4530-9249-138f12c970a3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Sun, 1 Mar 2026 14:06:46 +0000
Received: by hermes--production-ir2-bbcfb4457-d9ssk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c79d8117a70c015ed57ec99a8c51618c;
          Sun, 01 Mar 2026 13:56:36 +0000 (UTC)
From: tomasz.unger@yahoo.pl
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Tomasz Unger <tomasz.unger@yahoo.pl>
Subject: [PATCH net-next v1] NFC: nxp-nci: Replace strcpy() with strscpy()
Date: Sun,  1 Mar 2026 14:56:33 +0100
Message-ID: <20260301135633.214497-1-tomasz.unger@yahoo.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260301135633.214497-1-tomasz.unger.ref@yahoo.pl>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.pl,reject];
	R_DKIM_ALLOW(-0.20)[yahoo.pl:s=s2048];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.pl];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-262400-lists,netdev=lfdr.de];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tomasz.unger@yahoo.pl,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.pl:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[yahoo.pl];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E9411D0229
X-Rspamd-Action: no action

From: Tomasz Unger <tomasz.unger@yahoo.pl>

Replace strcpy() with strscpy() which limits the copy to the size of
the destination buffer. Since fw_info->name is an array, the
two-argument variant of strscpy() is used - the compiler deduces
the buffer size automatically.

This is a defensive cleanup replacing the deprecated strcpy()
with the preferred strscpy().

Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
---
Testing:
- checkpatch.pl: 0 errors, 0 warnings
- make M=drivers/nfc/nxp-nci/: compiled successfully, 0 errors, 0 warnings
- Module loaded successfully in QEMU (x86_64) with buildroot:
  modprobe nxp-nci - no errors, confirmed via lsmod

 drivers/nfc/nxp-nci/firmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/nxp-nci/firmware.c b/drivers/nfc/nxp-nci/firmware.c
index 381b5bb75477..a9533977aff8 100644
--- a/drivers/nfc/nxp-nci/firmware.c
+++ b/drivers/nfc/nxp-nci/firmware.c
@@ -211,7 +211,7 @@ int nxp_nci_fw_download(struct nci_dev *ndev, const char *firmware_name)
 		goto fw_download_exit;
 	}
 
-	strcpy(fw_info->name, firmware_name);
+	strscpy(fw_info->name, firmware_name);
 
 	r = request_firmware(&fw_info->fw, firmware_name,
 			     ndev->nfc_dev->dev.parent);
-- 
2.53.0


