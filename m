Return-Path: <netdev+bounces-248678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D6CD0D301
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 09:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AF1F301516C
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 08:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284432E7F07;
	Sat, 10 Jan 2026 08:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+/Jm+MC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0478221A434;
	Sat, 10 Jan 2026 08:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768032446; cv=none; b=WnVptZ1+ijMz34TNXs+zbdD23AQ8R4Aw/FMQTQ8gjLOYStjEV66ZlAF6BSHvU+HznwttloKAfy50RJWlunLuH+0+zIVOyEoW7kcl88uN2yYPxh1vpWKmWRmcbtUD8GrzXGh6fZArS7GjR2SkC88Mmwhqm/Tuvjv/R6ZFTXoV6MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768032446; c=relaxed/simple;
	bh=AwPIq0Wza+Ceg8Z80rRSSkUlWG5Kc4uDAuGiYngcc3M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ebuhtC8SxDgdMsb5UINAeVzEDRaW90dU3rwLJzeJsgbDEZrPGtkZVQmg9TGcjzxu8SWZthwTZcGMhm/uj/XYIwkl/UlhuFKVw1l8IJtppptS/sV4Dm9YkELSRDHbEpmU0syq3rq11PT2dwpyGK80bfMk2eH2W/cj9CqBlWI71I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+/Jm+MC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80898C4CEF1;
	Sat, 10 Jan 2026 08:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768032445;
	bh=AwPIq0Wza+Ceg8Z80rRSSkUlWG5Kc4uDAuGiYngcc3M=;
	h=Date:From:To:Cc:Subject:From;
	b=f+/Jm+MCs+sTcBRSN9lnwRJ5PbjQTbAmDTWPlpwallGeJSUR2Nc2s+JmRFYouhaZW
	 +UnfXg9rNBNdNmJTP4rfIw9EYlfZsL1Fuq4j94u9ozP1YIpJxtsKsoMyFsMwLs23P7
	 DP9xb420UCl+08ivStzeBfwrVEkPb7R2ZuzSKTFaxoafou4nVBaw3zmVC03cikyiJE
	 qndMRiEgeo/Enyp5qEURBKvEJzfZoj+tydEDXAMj+g8zrgElnO75gWZi01PP8hAQe2
	 Trqeb+C5ld/TL5OV4a+R4GqO/CEYm0C9HAQphnVjrP57xyDNhNFOEQWAonhhsWiHgD
	 7W3QaUsRk3siw==
Date: Sat, 10 Jan 2026 17:07:17 +0900
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: [PATCH v2][next] virtio_net: Fix misalignment bug in struct
 virtnet_info
Message-ID: <aWIItWq5dV9XTTCJ@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use the new TRAILING_OVERLAP() helper to fix a misalignment bug
along with the following warning:

drivers/net/virtio_net.c:429:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

This helper creates a union between a flexible-array member (FAM)
and a set of members that would otherwise follow it (in this case
`u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];`). This
overlays the trailing members (rss_hash_key_data) onto the FAM
(hash_key_data) while keeping the FAM and the start of MEMBERS aligned.
The static_assert() ensures this alignment remains.

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

As a result, the RSS key passed to the device is shifted by 1
byte: the last byte is cut off, and instead a (possibly
uninitialized) byte is added at the beginning.

As a last note `struct virtio_net_rss_config_hdr *rss_hdr;` is also
moved to the end, since it seems those three members should stick
around together. :)

Cc: stable@vger.kernel.org
Fixes: ed3100e90d0d ("virtio_net: Use new RSS config structs")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Update subject and changelog text (include feedback from Simon and
   Michael --thanks folks)
 - Add Fixes tag and CC -stable.

v1:
 - Link: https://lore.kernel.org/linux-hardening/aLiYrQGdGmaDTtLF@kspp/

 drivers/net/virtio_net.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 22d894101c01..5cbcc9926a23 100644
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
+	/* Must be last as it ends in a flexible-array member. */
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


