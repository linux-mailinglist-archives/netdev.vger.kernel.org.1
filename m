Return-Path: <netdev+bounces-270272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGEWGEEhv2kJvwMAu9opvQ
	(envelope-from <netdev+bounces-270272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 23:52:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3EA2E78C2
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 23:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 902BA300C90A
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 22:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C307D3093A6;
	Sat, 21 Mar 2026 22:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKIApFtH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D74926B0A9;
	Sat, 21 Mar 2026 22:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774133564; cv=none; b=pvwekYKxBAkb5cW7GXe5HbePrVPbPgYcX/JM0tIf1RPFAm2SyPp3NgSDClaQJzi5S4jEF6ANe9QuZHwMLXQpXM19ikUVZhHc4biNTTHsm303SKMJKnStDSvMMeCRZ4jKXoq4p93sBxbD9sFe+wBP/vmQc+bsCPsoaMxn3KHfKaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774133564; c=relaxed/simple;
	bh=2aKzxC+k2pI4FTAVYim2QauXA53/pjsaeaaj+e3qTJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VO8uSsbstV4FvEI6sLfebD3kSdj1R62hRyZfbtmMK9RSlE67FThFgJIn35fS9Wi0qiSNDm5uUihM3bSluLbBAa8TTvBSqpISmV0bsVtmAuJO0wnTeZ7n7/CceHIXzZKe1SYf4s9Rh+ErJfay0zgLxAI84eFUWg7tBhkHU8yQBUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKIApFtH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3E1C19421;
	Sat, 21 Mar 2026 22:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774133564;
	bh=2aKzxC+k2pI4FTAVYim2QauXA53/pjsaeaaj+e3qTJk=;
	h=From:To:Cc:Subject:Date:From;
	b=VKIApFtH2KKCf9twUH/K/hEn0I4W6EzjXYy3V5rzbA19HcttuW8VGj8R4qnGv8rfn
	 St1vkZD/kWiD2U/4OycdhHuPZlVmqFykp0N/23E6veIo1DIRkLZM/aSW4yzA68LpnQ
	 2lCfinictrqm+pl3cQhVxj6YuIdBAQxx27KlXB5RwsuUBRgyT7lz0layda90dvMv4r
	 G4VA26nGykH6UjWf55EjBoPqbqe4OeBtuIo2AfsY9Vy3H5w+jyCrNxo5wT1/LKhBS4
	 LPvqDHbthSs++UiuL6YcYFojWyPFsHNGlduUQyfAHC3w/zXciMj3ygkU3X3dHrREtJ
	 6G1cMTRogXyKg==
From: Eric Biggers <ebiggers@kernel.org>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] octeontx2-pf: macsec: Use AES library instead of ecb(aes) skcipher
Date: Sat, 21 Mar 2026 15:52:08 -0700
Message-ID: <20260321225208.64508-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-270272-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC3EA2E78C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cn10k_ecb_aes_encrypt() just encrypts a single block with AES.  That is
much more easily and efficiently done with the AES library than
crypto_skcipher.  Use the AES library instead.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 .../net/ethernet/marvell/octeontx2/Kconfig    |  1 +
 .../marvell/octeontx2/nic/cn10k_macsec.c      | 53 +++++--------------
 2 files changed, 13 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/Kconfig b/drivers/net/ethernet/marvell/octeontx2/Kconfig
index 35c4f5f64f58..47e549c581f0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/Kconfig
+++ b/drivers/net/ethernet/marvell/octeontx2/Kconfig
@@ -31,10 +31,11 @@ config NDC_DIS_DYNAMIC_CACHING
 config OCTEONTX2_PF
 	tristate "Marvell OcteonTX2 NIC Physical Function driver"
 	select OCTEONTX2_MBOX
 	select NET_DEVLINK
 	select PAGE_POOL
+	select CRYPTO_LIB_AES if MACSEC
 	depends on (64BIT && COMPILE_TEST) || ARM64
 	select DIMLIB
 	depends on PCI
 	depends on PTP_1588_CLOCK_OPTIONAL
 	depends on MACSEC || !MACSEC
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
index 4649996dc7da..2cc1bdfd9b2e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
@@ -2,11 +2,11 @@
 /* Marvell MACSEC hardware offload driver
  *
  * Copyright (C) 2022 Marvell.
  */
 
-#include <crypto/skcipher.h>
+#include <crypto/aes.h>
 #include <linux/rtnetlink.h>
 #include <linux/bitfield.h>
 #include "otx2_common.h"
 
 #define MCS_TCAM0_MAC_DA_MASK		GENMASK_ULL(47, 0)
@@ -44,55 +44,26 @@
 #define MCS_TCI_C			0x04 /* changed text */
 
 #define CN10K_MAX_HASH_LEN		16
 #define CN10K_MAX_SAK_LEN		32
 
-static int cn10k_ecb_aes_encrypt(struct otx2_nic *pfvf, u8 *sak,
-				 u16 sak_len, u8 *hash)
+static int cn10k_ecb_aes_encrypt(struct otx2_nic *pfvf, const u8 *sak,
+				 u16 sak_len, u8 hash[CN10K_MAX_HASH_LEN])
 {
-	u8 data[CN10K_MAX_HASH_LEN] = { 0 };
-	struct skcipher_request *req = NULL;
-	struct scatterlist sg_src, sg_dst;
-	struct crypto_skcipher *tfm;
-	DECLARE_CRYPTO_WAIT(wait);
-	int err;
-
-	tfm = crypto_alloc_skcipher("ecb(aes)", 0, 0);
-	if (IS_ERR(tfm)) {
-		dev_err(pfvf->dev, "failed to allocate transform for ecb-aes\n");
-		return PTR_ERR(tfm);
-	}
-
-	req = skcipher_request_alloc(tfm, GFP_KERNEL);
-	if (!req) {
-		dev_err(pfvf->dev, "failed to allocate request for skcipher\n");
-		err = -ENOMEM;
-		goto free_tfm;
-	}
+	static const u8 zeroes[CN10K_MAX_HASH_LEN];
+	struct aes_enckey aes;
 
-	err = crypto_skcipher_setkey(tfm, sak, sak_len);
-	if (err) {
-		dev_err(pfvf->dev, "failed to set key for skcipher\n");
-		goto free_req;
+	if (aes_prepareenckey(&aes, sak, sak_len) != 0) {
+		dev_err(pfvf->dev, "invalid AES key length: %d\n", sak_len);
+		return -EINVAL;
 	}
 
-	/* build sg list */
-	sg_init_one(&sg_src, data, CN10K_MAX_HASH_LEN);
-	sg_init_one(&sg_dst, hash, CN10K_MAX_HASH_LEN);
-
-	skcipher_request_set_callback(req, 0, crypto_req_done, &wait);
-	skcipher_request_set_crypt(req, &sg_src, &sg_dst,
-				   CN10K_MAX_HASH_LEN, NULL);
+	static_assert(CN10K_MAX_HASH_LEN == AES_BLOCK_SIZE);
+	aes_encrypt(&aes, hash, zeroes);
 
-	err = crypto_skcipher_encrypt(req);
-	err = crypto_wait_req(err, &wait);
-
-free_req:
-	skcipher_request_free(req);
-free_tfm:
-	crypto_free_skcipher(tfm);
-	return err;
+	memzero_explicit(&aes, sizeof(aes));
+	return 0;
 }
 
 static struct cn10k_mcs_txsc *cn10k_mcs_get_txsc(struct cn10k_mcs_cfg *cfg,
 						 struct macsec_secy *secy)
 {

base-commit: fb78a629b4f0eb399b413f6c093a3da177b3a4eb
-- 
2.53.0


