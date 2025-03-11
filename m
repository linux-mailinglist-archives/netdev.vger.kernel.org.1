Return-Path: <netdev+bounces-174051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 117BDA5D2A9
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 23:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D06617A365
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 22:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BF7265603;
	Tue, 11 Mar 2025 22:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RH5kDlGd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17F71C6FFD;
	Tue, 11 Mar 2025 22:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741733061; cv=none; b=adSaJPG4/6fRod+5oH7zlBs0Msxx0qhbv33mHOS+KRtiAvkaYq7BfPxn3aMoORDYQhevSrcB6nlnlrvyCTdP6BhTcwm5L+d3xjLHTo7gNAvMci1QlMU0XVQgddGlcx5p+K9kj1SEORbciWHIuDnpVETIFTP8vLcrGYCPmmlX/Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741733061; c=relaxed/simple;
	bh=R2t2dsZHE8G4DvXieL1oM1sFlGJJH5yJg2LKNxJRjaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bPZIzW2Rc/kYz8pb22o8jvaaoomLk63v7aLYwFcJnU/+FFuwU9aUdOO4YDDsyULWVoTjmRfq3gSlf4FP10HiKZDUaXIZ8yBW4tESerJCL8XAwY9ue/PI9usQ5X857m4H3SoPsYob9girvbGcNH9jD3ATmQ9HgvDcfesV4Iq34n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RH5kDlGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE3FC4CEE9;
	Tue, 11 Mar 2025 22:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741733061;
	bh=R2t2dsZHE8G4DvXieL1oM1sFlGJJH5yJg2LKNxJRjaQ=;
	h=From:To:Cc:Subject:Date:From;
	b=RH5kDlGdaNtO7pSD+oJ2ybLDVedsQ/IDghWHoQOcchWbxVFt9s/ubDO9zrSPmYn0M
	 5/WfmrGHl0htrSPrqmw9f53ViVyYIvW+GAsc1uD6cH4i00IYh6t1/V7yNC6hhKC8r2
	 g1NJ+BdZ8r+J5Ohwu3tdAYxkcMgPviltuZjzpA3M8sSQ7FiYYy59NerE6dXUqdh8Yx
	 S+l5T2LBU8eOK7/txzQKm7sUU6Nff+iIYINudsMLpuJTkUJLNXwbYnkHiLSjavoY0X
	 PuykQSpcT/yg62zfBJZKbz5gVlYCOHzvytRf8tonhzpvSGD6FFYiCfDAq29pxkb31w
	 A77uvWAozNoyQ==
From: Kees Cook <kees@kernel.org>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Kees Cook <kees@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] net: macb: Add __nonstring annotations for unterminated strings
Date: Tue, 11 Mar 2025 15:44:16 -0700
Message-Id: <20250311224412.it.153-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1882; i=kees@kernel.org; h=from:subject:message-id; bh=R2t2dsZHE8G4DvXieL1oM1sFlGJJH5yJg2LKNxJRjaQ=; b=owGbwMvMwCVmps19z/KJym7G02pJDOkX9uzv3Kopyu9jm6Dj+oQlYSLjI/N3OxVeL//4+uXWB bIf2h0XdpSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEwkhY3hf2U019YbpVdSf/pv CHoVucz25Qf3qojnMg1TOKXbWvQ85jH8j5llayTVNfXORF6vt9eeq5SYsMcH3vYx4fqUc2iu3Vx DPgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When a character array without a terminating NUL character has a static
initializer, GCC 15's -Wunterminated-string-initialization will only
warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
with __nonstring to and correctly identify the char array as "not a C
string" and thereby eliminate the warning.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v1: https://lore.kernel.org/lkml/20250310222415.work.815-kees@kernel.org/
 v2: switch to __nonstring annotation
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
---
 drivers/net/ethernet/cadence/macb.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 2847278d9cd4..003483073223 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1027,7 +1027,7 @@ struct gem_stats {
  * this register should contribute to.
  */
 struct gem_statistic {
-	char stat_string[ETH_GSTRING_LEN];
+	char stat_string[ETH_GSTRING_LEN] __nonstring;
 	int offset;
 	u32 stat_bits;
 };
@@ -1068,6 +1068,7 @@ static const struct gem_statistic gem_statistics[] = {
 	GEM_STAT_TITLE(TX512CNT, "tx_512_1023_byte_frames"),
 	GEM_STAT_TITLE(TX1024CNT, "tx_1024_1518_byte_frames"),
 	GEM_STAT_TITLE(TX1519CNT, "tx_greater_than_1518_byte_frames"),
+
 	GEM_STAT_TITLE_BITS(TXURUNCNT, "tx_underrun",
 			    GEM_BIT(NDS_TXERR)|GEM_BIT(NDS_TXFIFOERR)),
 	GEM_STAT_TITLE_BITS(SNGLCOLLCNT, "tx_single_collision_frames",
-- 
2.34.1


