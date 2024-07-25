Return-Path: <netdev+bounces-113118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A7493CAD6
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 00:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC2E282E75
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 22:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE9E149018;
	Thu, 25 Jul 2024 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfrKB/Xb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4BC149006
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721946246; cv=none; b=Jpq550VzL9Or9irIHDgerRkoWyuuenzaZUn39rhtcbFTlVaGxIc0aHbvpQLDXn8vxxS0RcCP+8j8rBhvP7QIoHOLENGtgAdivDVBwVtq3eLz9eF//ZRvmUMb8h1zbaqjCgt9dWupMlRrft+Ydu6KSupgJzu1npptxuGdE6nk7dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721946246; c=relaxed/simple;
	bh=82QFFfsRm7da6OHnWNDXEfSYrmq7Bhmr00IHPzW0VOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEbIeaJaCxr64hg1LCubqhihd/uUlU0r1y8qR0es625frgKCkGCkbB7agovyIVmYkbDU971h1k5QJjj0i6oFEiJch1TQGJr2C8xIzEKfUiaIYD5ICHqw6pnUvdj8FG5DvvMibtJaOvaddL4FByPQ7RzODBsz4MLu9fLxqEa68p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfrKB/Xb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D20C4AF0F;
	Thu, 25 Jul 2024 22:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721946246;
	bh=82QFFfsRm7da6OHnWNDXEfSYrmq7Bhmr00IHPzW0VOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZfrKB/Xb37HnaRgqZgQbwjZst7TpEAJvxiE6nhWDlSzR0a2U+Z3p7+MU7tbSrPHKk
	 opPCVajaQk5H0sWpYNkv9FnejbUXmxZM+/oWPdpkDeXIprX/aO58RjzNuDMX+AK1Y6
	 MLazOT0TdzLzE8cXUqBlC1j3Lmht0iXJg6DaRN1pCqJgjycdVtx8FlfP+lEkZVVyrg
	 KQu5IAe1mm/KvgoXqeMalq3/GRKTCoaoUK6VzlsAmaH61eUQe3pQ6OmUSD3g7a1Rcj
	 6xWf+1M+1FdSafxSUS0DFMs2I0948XK4ge1k6CCvr1f4u1ihME3uPXbX3kIEYzrS7r
	 Z/oWXRRnoo1GQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	shuah@kernel.org,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	ahmed.zaki@intel.com,
	andrew@lunn.ch,
	willemb@google.com,
	pavan.chebbi@broadcom.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 3/5] ethtool: fix setting key and resetting indir at once
Date: Thu, 25 Jul 2024 15:23:51 -0700
Message-ID: <20240725222353.2993687-4-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725222353.2993687-1-kuba@kernel.org>
References: <20240725222353.2993687-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The indirection table and the key follow struct ethtool_rxfh
in user memory.

To reset the indirection table user space calls SET_RXFH with
table of size 0 (OTOH to say "no change" it should use -1 / ~0).
The logic for calculating the offset where they key sits is
incorrect in this case, as kernel would still offset by the full
table length, while for the reset there is no indir table and
key is immediately after the struct.

  $ ethtool -X eth0 default hkey 01:02:03...
  $ ethtool -x eth0
  [...]
  RSS hash key:
00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00
  [...]

Fixes: 3de0b592394d ("ethtool: Support for configurable RSS hash key")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/ioctl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 983fee76f5cf..a37ba113610a 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1331,13 +1331,13 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	u32 rss_cfg_offset = offsetof(struct ethtool_rxfh, rss_config[0]);
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	u32 dev_indir_size = 0, dev_key_size = 0, i;
+	u32 user_indir_len = 0, indir_bytes = 0;
 	struct ethtool_rxfh_param rxfh_dev = {};
 	struct ethtool_rxfh_context *ctx = NULL;
 	struct netlink_ext_ack *extack = NULL;
 	struct ethtool_rxnfc rx_rings;
 	struct ethtool_rxfh rxfh;
 	bool locked = false; /* dev->ethtool->rss_lock taken */
-	u32 indir_bytes = 0;
 	bool create = false;
 	u8 *rss_config;
 	int ret;
@@ -1400,6 +1400,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	 */
 	if (rxfh.indir_size &&
 	    rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE) {
+		user_indir_len = indir_bytes;
 		rxfh_dev.indir = (u32 *)rss_config;
 		rxfh_dev.indir_size = dev_indir_size;
 		ret = ethtool_copy_validate_indir(rxfh_dev.indir,
@@ -1426,7 +1427,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		rxfh_dev.key_size = dev_key_size;
 		rxfh_dev.key = rss_config + indir_bytes;
 		if (copy_from_user(rxfh_dev.key,
-				   useraddr + rss_cfg_offset + indir_bytes,
+				   useraddr + rss_cfg_offset + user_indir_len,
 				   rxfh.key_size)) {
 			ret = -EFAULT;
 			goto out;
-- 
2.45.2


