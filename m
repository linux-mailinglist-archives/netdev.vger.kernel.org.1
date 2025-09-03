Return-Path: <netdev+bounces-219685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01CCB42A09
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 21:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B25D7B711B
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 19:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3903A3629AC;
	Wed,  3 Sep 2025 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocaVzao4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14D02C18A;
	Wed,  3 Sep 2025 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756928181; cv=none; b=ndt3RZhfYgjZsb67SmWap6oCzHILQakFNQuoPDbY6rjNx+gKbH/KVz7mFxahfs9T8H8KjjTFArtkHC5SoyQABR0sADydvPZeCIBPsPSxODoTPDhdTchN1uwfbCVDLPxy2piTEr2nOM7GBf3wtZ0tNqgMaQdzriISvWuQAzu89w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756928181; c=relaxed/simple;
	bh=J5VDjAzU4bP2iNAyELFb3jm1tCgK9MjUGPIE6C22Gdg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u3rU247m8p6EeBeU9o817R75aAV5ckOgzc6GzfM4io+UXXBAKRkzb5EHh46R5fKTbYf2KT/fppZSZV4k324/wkSINpkUkRWvsxugJw7FGtbv+lT2ujpayeDXXx6/giaDMWwzRo0v9iXj4BKA4qcbjiFJvSGbvzbTai/C3IPOEaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocaVzao4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3982C4CEE7;
	Wed,  3 Sep 2025 19:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756928180;
	bh=J5VDjAzU4bP2iNAyELFb3jm1tCgK9MjUGPIE6C22Gdg=;
	h=Date:From:To:Cc:Subject:From;
	b=ocaVzao4pHj7eKEMcbd5Gjt92N6UK53kmHR2XF447/zhQoXmw8ED4iAm8ilUtAevr
	 vKKdTzgnJB9FZ1a+PVsxADdMDORDhph18ZzFI/AdYmCUQTYzzC/Cz/GKlZS9k1Zp9e
	 NUT1+eg71S5VoVdEIEVAU4AaUwVtZPQXN2u+rLVMtT5EMAtSknA7fwUlQx8dAotCLT
	 U9zjAzodQ6z5ATB5gzCWpsQe4EnD+a1Dzt2oh3l4QiKDfzIiGjs5jXyKiKt1azlZ9F
	 L5BJUGaHOfxeUz/4t2P+LZ3uQGRmemu7XC5xnuUYUudbHtyjsMRq9/ZdI0Zq9DwdS5
	 /SI2PRaNEUmdQ==
Date: Wed, 3 Sep 2025 21:36:13 +0200
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] virtio_net: Fix alignment and avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <aLiYrQGdGmaDTtLF@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use the new TRAILING_OVERLAP() helper to fix the following warning:

drivers/net/virtio_net.c:429:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

This helper creates a union between a flexible-array member (FAM)
and a set of members that would otherwise follow it (in this case
`u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];`). This
overlays the trailing members (rss_hash_key_data) onto the FAM
(hash_key_data) while keeping the FAM and the start of MEMBERS aligned.
The static_assert() ensures this alignment remains, and it's
intentionally placed inmediately after `struct virtnet_info` (no
blank line in between).

Notice that due to tail padding in flexible `struct
virtio_net_rss_config_trailer`, `rss_trailer.hash_key_data`
(at offset 83 in struct virtnet_info) and `rss_hash_key_data` (at
offset 84 in struct virtnet_info) are misaligned by one byte. See
below:

struct virtio_net_rss_config_trailer {
        __le16                     max_tx_vq;            /*     0     2 */
        __u8                       hash_key_length;      /*     2     1 */
        __u8                       hash_key_data[];      /*     3     0 */

        /* size: 4, cachelines: 1, members: 3 */
        /* padding: 1 */
        /* last cacheline: 4 bytes */
};

struct virtnet_info {
...
        struct virtio_net_rss_config_trailer rss_trailer; /*    80     4 */

        /* XXX last struct has 1 byte of padding */

        u8                         rss_hash_key_data[40]; /*    84    40 */
...
        /* size: 832, cachelines: 13, members: 48 */
        /* sum members: 801, holes: 8, sum holes: 31 */
        /* paddings: 2, sum paddings: 5 */
};

After changes, those members are correctly aligned at offset 795:

struct virtnet_info {
...
        union {
                struct virtio_net_rss_config_trailer rss_trailer; /*   792     4 */
                struct {
                        unsigned char __offset_to_hash_key_data[3]; /*   792     3 */
                        u8         rss_hash_key_data[40]; /*   795    40 */
                };                                       /*   792    43 */
        };                                               /*   792    44 */
...
        /* size: 840, cachelines: 14, members: 47 */
        /* sum members: 801, holes: 8, sum holes: 35 */
        /* padding: 4 */
        /* paddings: 1, sum paddings: 4 */
        /* last cacheline: 8 bytes */
};

As a last note `struct virtio_net_rss_config_hdr *rss_hdr;` is also
moved to the end, since it seems those three members should stick
around together. :)

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---

This should probably include the following tag:

	Fixes: ed3100e90d0d ("virtio_net: Use new RSS config structs")

but I'd like to hear some feedback, first.

Thanks!

 drivers/net/virtio_net.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 975bdc5dab84..f4964a18a214 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -425,9 +425,6 @@ struct virtnet_info {
 	u16 rss_indir_table_size;
 	u32 rss_hash_types_supported;
 	u32 rss_hash_types_saved;
-	struct virtio_net_rss_config_hdr *rss_hdr;
-	struct virtio_net_rss_config_trailer rss_trailer;
-	u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
 
 	/* Has control virtqueue */
 	bool has_cvq;
@@ -493,7 +490,16 @@ struct virtnet_info {
 	struct failover *failover;
 
 	u64 device_stats_cap;
+
+	struct virtio_net_rss_config_hdr *rss_hdr;
+
+	/* Must be last --ends in a flexible-array member. */
+	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer, hash_key_data,
+		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
+	);
 };
+static_assert(offsetof(struct virtnet_info, rss_trailer.hash_key_data) ==
+	      offsetof(struct virtnet_info, rss_hash_key_data));
 
 struct padded_vnet_hdr {
 	struct virtio_net_hdr_v1_hash hdr;
-- 
2.43.0


