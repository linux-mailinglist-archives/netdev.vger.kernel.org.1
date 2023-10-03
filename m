Return-Path: <netdev+bounces-37601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814EE7B64C2
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 10:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 25C0F28160A
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 08:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2C6DDC7;
	Tue,  3 Oct 2023 08:57:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9698DDAE
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 08:56:59 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28B1AB;
	Tue,  3 Oct 2023 01:56:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 913DDE0013;
	Tue,  3 Oct 2023 08:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1696323415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QaHAw0oOg3N4EaBCbSIugnNCx1RIAAViIQYceCqX5qo=;
	b=bvU+uBKiddQYey6J9aL8CgiYG7+l5qeB9oA4jiLCBlnTZxElTiEW8jjH7GYRh7CswgJ0tc
	q56Yqse/oOuKuUXkLSSdPMD+ajvWn9/SAVuh5oUSt7vpkQZg3nUsidNhZbANNXmygE/cV3
	dWic6PwwVhk5+h06AEQ7AtvHJplmRCDT0T15KpZ0yjMBTfYwH5EE8XG5Ugtdr82YVLrYhc
	FUqpBWInTu1zHIDgx9BpwZmJj7oeHgdXRbnzeeDcZaFf8u+tGrRDo/w8X9qWIkLXtppV/h
	z/FkQRXYXy9kdNHvCyQjgK8vMGMkUc2uStg/LMxUhqnw2KTwWKcd70dpJ6LiDA==
From: =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
To: Michal Kubecek <mkubecek@suse.cz>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	stable@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 1/1] ethtool: Fix mod state of verbose no_mask bitset
Date: Tue,  3 Oct 2023 10:56:52 +0200
Message-Id: <20231003085653.3104411-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kory Maincent <kory.maincent@bootlin.com>

A bitset without mask in a _SET request means we want exactly the bits in
the bitset to be set. This works correctly for compact format but when
verbose format is parsed, ethnl_update_bitset32_verbose() only sets the
bits present in the request bitset but does not clear the rest. The commit
6699170376ab fixes this issue by clearing the whole target bitmap before we
start iterating. The solution proposed brought an issue with the behavior
of the mod variable. As the bitset is always cleared the old val will
always differ to the new val.

Fix it by adding a new temporary variable which save the state of the old
bitmap.

Fixes: 6699170376ab ("ethtool: fix application of verbose no_mask bitset")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Cc: stable@vger.kernel.org
---
 net/ethtool/bitset.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/net/ethtool/bitset.c b/net/ethtool/bitset.c
index 0515d6604b3b..95f11b0a38b4 100644
--- a/net/ethtool/bitset.c
+++ b/net/ethtool/bitset.c
@@ -432,7 +432,9 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
 			      struct netlink_ext_ack *extack, bool *mod)
 {
 	struct nlattr *bit_attr;
+	u32 *tmp = NULL;
 	bool no_mask;
+	bool dummy;
 	int rem;
 	int ret;
 
@@ -448,8 +450,11 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
 	}
 
 	no_mask = tb[ETHTOOL_A_BITSET_NOMASK];
-	if (no_mask)
-		ethnl_bitmap32_clear(bitmap, 0, nbits, mod);
+	if (no_mask) {
+		tmp = kcalloc(nbits, sizeof(u32), GFP_KERNEL);
+		memcpy(tmp, bitmap, nbits);
+		ethnl_bitmap32_clear(bitmap, 0, nbits, &dummy);
+	}
 
 	nla_for_each_nested(bit_attr, tb[ETHTOOL_A_BITSET_BITS], rem) {
 		bool old_val, new_val;
@@ -458,13 +463,18 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
 		if (nla_type(bit_attr) != ETHTOOL_A_BITSET_BITS_BIT) {
 			NL_SET_ERR_MSG_ATTR(extack, bit_attr,
 					    "only ETHTOOL_A_BITSET_BITS_BIT allowed in ETHTOOL_A_BITSET_BITS");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 		ret = ethnl_parse_bit(&idx, &new_val, nbits, bit_attr, no_mask,
 				      names, extack);
 		if (ret < 0)
-			return ret;
-		old_val = bitmap[idx / 32] & ((u32)1 << (idx % 32));
+			goto out;
+		if (no_mask)
+			old_val = tmp[idx / 32] & ((u32)1 << (idx % 32));
+		else
+			old_val = bitmap[idx / 32] & ((u32)1 << (idx % 32));
+
 		if (new_val != old_val) {
 			if (new_val)
 				bitmap[idx / 32] |= ((u32)1 << (idx % 32));
@@ -474,7 +484,10 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
 		}
 	}
 
-	return 0;
+	ret = 0;
+out:
+	kfree(tmp);
+	return ret;
 }
 
 static int ethnl_compact_sanity_checks(unsigned int nbits,
-- 
2.25.1


