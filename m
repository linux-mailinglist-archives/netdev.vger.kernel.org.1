Return-Path: <netdev+bounces-42637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784A27CFAB4
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 15:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4DC81C20AF6
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1422A22EE5;
	Thu, 19 Oct 2023 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="evznZ03x"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59758179B1
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 13:17:21 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C8998;
	Thu, 19 Oct 2023 06:17:15 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8106F240002;
	Thu, 19 Oct 2023 13:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1697721434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7kubKUOdyt7koTXOXKhU8wFECVMZDVp8kCAlvbhKcUI=;
	b=evznZ03xPa0BEwhJfOpNDV6d3q5E4Ku96L8mhZfSmZ0WUAyqSyXEHUqqaCyyVLtItEGvJG
	iI6qrODCXFvYvK78X9EaXwnN1EdVV5EAKy2i+nJLs5gM8vPTgBk+GtMRLOzf8QBS83sGmg
	gmdd5uackLlA7rCLXeUjimx1JzlpafuKGeeXAcKIKTRILR+l8WSVFibee3PrOXIX+c03pf
	niu31RkRhCXonSiGBCR+L6uJv25Lt15MaLuEN70pGQBMMk0ytJ5KRB5B/bXiQK13Mhdo/s
	PYa9WxihA5q8z5ZuHkvs1Bbj0fK9rMBqAZ7Tw05nMfPXahSVtClavHN/lPGQhQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 19 Oct 2023 15:16:41 +0200
Subject: [PATCH net] Revert "ethtool: Fix mod state of verbose no_mask
 bitset"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231019-feature_ptp_bitset_fix-v1-1-70f3c429a221@bootlin.com>
X-B4-Tracking: v=1; b=H4sIADgsMWUC/x2M0QqEIBQFfyXuc0ImFfUrEZJ13L0vJnqLhejfV
 3qcgZmbMhIj01TdlHBx5iMU0HVF23cNHyjeC1PbtEY3elQeq5wJNkq0jiVDrOef6p0fun7Qzhh
 QiWNC0e94pgCh5Xn+yXvplG0AAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
 Simon Horman <horms@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Simon Horman <horms@kernel.org>, Michal Kubecek <mkubecek@suse.cz>, 
 stable@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>, 
 Oleksij Rempel <linux@rempel-privat.de>
X-Mailer: b4 0.12.3
X-GND-Sasl: kory.maincent@bootlin.com

This reverts commit 108a36d07c01edbc5942d27c92494d1c6e4d45a0.

It was reported that this fix breaks the possibility to remove existing WoL
flags. For example:
~$ ethtool lan2
...
        Supports Wake-on: pg
        Wake-on: d
...
~$ ethtool -s lan2 wol gp
~$ ethtool lan2
...
        Wake-on: pg
...
~$ ethtool -s lan2 wol d
~$ ethtool lan2
...
        Wake-on: pg
...

This worked correctly before this commit because we were always updating
a zero bitmap (since commit 6699170376ab ("ethtool: fix application of
verbose no_mask bitset"), that is) so that the rest was left zero
naturally. But now the 1->0 change (old_val is true, bit not present in
netlink nest) no longer works.

Reported-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reported-by: Michal Kubecek <mkubecek@suse.cz>
Closes: https://lore.kernel.org/netdev/20231019095140.l6fffnszraeb6iiw@lion.mk-sys.cz/
Cc: stable@vger.kernel.org
Fixes: 108a36d07c01 ("ethtool: Fix mod state of verbose no_mask bitset")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

This patch is reverted for now as we are approaching the end of the
merge-window. The real fix that fix the mod value will be sent later
on the next merge-window.
---
 net/ethtool/bitset.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/net/ethtool/bitset.c b/net/ethtool/bitset.c
index 883ed9be81f9..0515d6604b3b 100644
--- a/net/ethtool/bitset.c
+++ b/net/ethtool/bitset.c
@@ -431,10 +431,8 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
 			      ethnl_string_array_t names,
 			      struct netlink_ext_ack *extack, bool *mod)
 {
-	u32 *orig_bitmap, *saved_bitmap = NULL;
 	struct nlattr *bit_attr;
 	bool no_mask;
-	bool dummy;
 	int rem;
 	int ret;
 
@@ -450,22 +448,8 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
 	}
 
 	no_mask = tb[ETHTOOL_A_BITSET_NOMASK];
-	if (no_mask) {
-		unsigned int nwords = DIV_ROUND_UP(nbits, 32);
-		unsigned int nbytes = nwords * sizeof(u32);
-
-		/* The bitmap size is only the size of the map part without
-		 * its mask part.
-		 */
-		saved_bitmap = kcalloc(nwords, sizeof(u32), GFP_KERNEL);
-		if (!saved_bitmap)
-			return -ENOMEM;
-		memcpy(saved_bitmap, bitmap, nbytes);
-		ethnl_bitmap32_clear(bitmap, 0, nbits, &dummy);
-		orig_bitmap = saved_bitmap;
-	} else {
-		orig_bitmap = bitmap;
-	}
+	if (no_mask)
+		ethnl_bitmap32_clear(bitmap, 0, nbits, mod);
 
 	nla_for_each_nested(bit_attr, tb[ETHTOOL_A_BITSET_BITS], rem) {
 		bool old_val, new_val;
@@ -474,14 +458,13 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
 		if (nla_type(bit_attr) != ETHTOOL_A_BITSET_BITS_BIT) {
 			NL_SET_ERR_MSG_ATTR(extack, bit_attr,
 					    "only ETHTOOL_A_BITSET_BITS_BIT allowed in ETHTOOL_A_BITSET_BITS");
-			ret = -EINVAL;
-			goto out;
+			return -EINVAL;
 		}
 		ret = ethnl_parse_bit(&idx, &new_val, nbits, bit_attr, no_mask,
 				      names, extack);
 		if (ret < 0)
-			goto out;
-		old_val = orig_bitmap[idx / 32] & ((u32)1 << (idx % 32));
+			return ret;
+		old_val = bitmap[idx / 32] & ((u32)1 << (idx % 32));
 		if (new_val != old_val) {
 			if (new_val)
 				bitmap[idx / 32] |= ((u32)1 << (idx % 32));
@@ -491,10 +474,7 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
 		}
 	}
 
-	ret = 0;
-out:
-	kfree(saved_bitmap);
-	return ret;
+	return 0;
 }
 
 static int ethnl_compact_sanity_checks(unsigned int nbits,

---
base-commit: a602ee3176a81280b829c9f0cf259450f7982168
change-id: 20231019-feature_ptp_bitset_fix-6bf75671b33e

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


