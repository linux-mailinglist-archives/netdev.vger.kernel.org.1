Return-Path: <netdev+bounces-39096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C3D7BE00A
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9CE1C20979
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 13:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B442E63E;
	Mon,  9 Oct 2023 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mV5Xpggp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28721182A4
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 13:36:54 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BABE0;
	Mon,  9 Oct 2023 06:36:49 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 699C0FF805;
	Mon,  9 Oct 2023 13:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1696858608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ecp+PzDuojrF4dVn0YXTODlKCvKpXLTXA6CoVDUgfhU=;
	b=mV5XpggpxwV309tZ+u4iSdRAQN+OqPXFAuLCjisPIGfNJ8DmhxJl1H869NCu75zzo8uC0T
	bXu+/A/NZ66wzxM97X1EPXCi8iXKv/m1z9BKDUM2Zg1XOEAjJL3JEO/IMxe8CsQScXozj6
	83jXpfepGYkCvIDGXXQBmb9x1qNCtjL35Vlqkduc4Z24MnjR099sMqUmYN9OhNP2yPgESk
	08yhPDf2mJU+GrwT2ZPJeXDCaGBgbjtoPC7Ljj9Mk3SIOarRvt7GfkCXPQ3M+Aq83NsAed
	uho0IF2jtm/AfAVH4z/Gmx5m9+MXOJD9dN7RlZL1UFriyObgxKhtUheIRMiNbw==
From: =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
To: Michal Kubecek <mkubecek@suse.cz>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net v3 1/1] ethtool: Fix mod state of verbose no_mask bitset
Date: Mon,  9 Oct 2023 15:36:45 +0200
Message-Id: <20231009133645.44503-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
---

Changes in v2:
- Fix the allocated size.

Changes in v3:
- Add comment.
- Updated variable naming.
- Add orig_bitmap variable to avoid n_mask condition in the
  nla_for_each_nested() loop.
---
 net/ethtool/bitset.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/net/ethtool/bitset.c b/net/ethtool/bitset.c
index 0515d6604b3b..883ed9be81f9 100644
--- a/net/ethtool/bitset.c
+++ b/net/ethtool/bitset.c
@@ -431,8 +431,10 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
 			      ethnl_string_array_t names,
 			      struct netlink_ext_ack *extack, bool *mod)
 {
+	u32 *orig_bitmap, *saved_bitmap = NULL;
 	struct nlattr *bit_attr;
 	bool no_mask;
+	bool dummy;
 	int rem;
 	int ret;
 
@@ -448,8 +450,22 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
 	}
 
 	no_mask = tb[ETHTOOL_A_BITSET_NOMASK];
-	if (no_mask)
-		ethnl_bitmap32_clear(bitmap, 0, nbits, mod);
+	if (no_mask) {
+		unsigned int nwords = DIV_ROUND_UP(nbits, 32);
+		unsigned int nbytes = nwords * sizeof(u32);
+
+		/* The bitmap size is only the size of the map part without
+		 * its mask part.
+		 */
+		saved_bitmap = kcalloc(nwords, sizeof(u32), GFP_KERNEL);
+		if (!saved_bitmap)
+			return -ENOMEM;
+		memcpy(saved_bitmap, bitmap, nbytes);
+		ethnl_bitmap32_clear(bitmap, 0, nbits, &dummy);
+		orig_bitmap = saved_bitmap;
+	} else {
+		orig_bitmap = bitmap;
+	}
 
 	nla_for_each_nested(bit_attr, tb[ETHTOOL_A_BITSET_BITS], rem) {
 		bool old_val, new_val;
@@ -458,13 +474,14 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
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
+		old_val = orig_bitmap[idx / 32] & ((u32)1 << (idx % 32));
 		if (new_val != old_val) {
 			if (new_val)
 				bitmap[idx / 32] |= ((u32)1 << (idx % 32));
@@ -474,7 +491,10 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
 		}
 	}
 
-	return 0;
+	ret = 0;
+out:
+	kfree(saved_bitmap);
+	return ret;
 }
 
 static int ethnl_compact_sanity_checks(unsigned int nbits,
-- 
2.25.1


