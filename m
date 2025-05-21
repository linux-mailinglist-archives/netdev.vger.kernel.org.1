Return-Path: <netdev+bounces-192250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BE2ABF1BC
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 12:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80FC74E2F23
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 10:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996D225F7A5;
	Wed, 21 May 2025 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEn7KR3a"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C7425F793
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747823654; cv=none; b=DTas92TeTN6E6yFkQB86AaCajFgfxeV7FAKXtj8LWsZ0mcujSuCOp1nELww4dQWsuNDbqlQ9xxgJ5JXx1L1uB8NUzoL4bS37a2ejEZwZCYlG0qGLKVWv7+feL9HSob8W1zUkiwaPoiKHX5JhfWPsXsLiZzIcDxR8dLfL5n64cHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747823654; c=relaxed/simple;
	bh=hjMc8xIzyyavLtzFjZaFsSK1u7jdwwBC1Ulanh9R564=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWpQ7x0PyWr4RgmQW+HaL6XuK78TydYdbLgoiX0LJNX6lSLJFiS2VD/V2CXdXM4Akf2RZhJ/Z9VsdxDF6s4OGTRVYtVVJsVU2gTR4NVQS3LTopQ6KfMIHxWN/OhwsnjFkGASSFxhsb9z+zGkYKbadVRgEP/8zvhEa99VBO27xwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEn7KR3a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747823651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iciaD5oF7XaG45LTuImQwlNaPEzRvBejyVWObagonII=;
	b=XEn7KR3aUbKmrGBdSo0H72QR3M36nd4Kmcee5HWBT6Pg8umQpR+icYSDZzsWbMzfzuGhiw
	1Xxtzk0djizNCR230Tos9Sel2fkHpIoSJsgNQEzbjYgzIVi8V4AZO9Yih5NWf9PCvLto3g
	S4rOauzWvT1U0CpqTFZx8KFfvwLTQZE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-lMsh8nlZMAWIAA7u5MGXlQ-1; Wed,
 21 May 2025 06:34:06 -0400
X-MC-Unique: lMsh8nlZMAWIAA7u5MGXlQ-1
X-Mimecast-MFC-AGG-ID: lMsh8nlZMAWIAA7u5MGXlQ_1747823644
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D00D3180045C;
	Wed, 21 May 2025 10:34:04 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.39])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 255D1195608F;
	Wed, 21 May 2025 10:34:00 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH net-next 7/8] tun: enable gso over UDP tunnel support.
Date: Wed, 21 May 2025 12:32:41 +0200
Message-ID: <bb441f9ccadc27bf41eb1937101d1d30fa827af5.1747822866.git.pabeni@redhat.com>
In-Reply-To: <cover.1747822866.git.pabeni@redhat.com>
References: <cover.1747822866.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add new tun features to represent the newly introduced virtio
GSO over UDP tunnel offload. Allows detection and selection of
such features via the existing TUNSETOFFLOAD ioctl, store the
tunnel offload configuration in the highest bit of the tun flags
and compute the expected virtio header size and tunnel header
offset using such bits, so that we can plug almost seamless the
the newly introduced virtio helpers to serialize the extended
virtio header.

As the tun features and the virtio hdr size are configured
separately, the data path need to cope with (hopefully transient)
inconsistent values.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/tun.c           | 77 ++++++++++++++++++++++++++++++++-----
 drivers/net/tun_vnet.h      | 74 ++++++++++++++++++++++++++++-------
 include/uapi/linux/if_tun.h |  9 +++++
 3 files changed, 137 insertions(+), 23 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 7babd1e9a378b..ef8cef48b66f5 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -186,7 +186,8 @@ struct tun_struct {
 	struct net_device	*dev;
 	netdev_features_t	set_features;
 #define TUN_USER_FEATURES (NETIF_F_HW_CSUM|NETIF_F_TSO_ECN|NETIF_F_TSO| \
-			  NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4)
+			  NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4 | \
+			  NETIF_F_GSO_UDP_TUNNEL | NETIF_F_GSO_UDP_TUNNEL_CSUM)
 
 	int			align;
 	int			vnet_hdr_sz;
@@ -925,6 +926,7 @@ static int tun_net_init(struct net_device *dev)
 	dev->hw_features = NETIF_F_SG | NETIF_F_FRAGLIST |
 			   TUN_USER_FEATURES | NETIF_F_HW_VLAN_CTAG_TX |
 			   NETIF_F_HW_VLAN_STAG_TX;
+	dev->hw_enc_features = dev->hw_features;
 	dev->features = dev->hw_features;
 	dev->vlan_features = dev->features &
 			     ~(NETIF_F_HW_VLAN_CTAG_TX |
@@ -1698,7 +1700,8 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	struct sk_buff *skb;
 	size_t total_len = iov_iter_count(from);
 	size_t len = total_len, align = tun->align, linear;
-	struct virtio_net_hdr gso = { 0 };
+	char buf[TUN_VNET_TNL_SIZE];
+	struct virtio_net_hdr *gso;
 	int good_linear;
 	int copylen;
 	int hdr_len = 0;
@@ -1708,6 +1711,15 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	int skb_xdp = 1;
 	bool frags = tun_napi_frags_enabled(tfile);
 	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
+	unsigned int flags = tun->flags & ~TUN_VNET_TNL_MASK;
+
+	/*
+	 * Keep it easy and always zero the whole buffer, even if the
+	 * tunnel-related field will be touched only when the feature
+	 * is enabled and the hdr size id compatible.
+	 */
+	memset(buf, 0, sizeof(buf));
+	gso = (void *)buf;
 
 	if (!(tun->flags & IFF_NO_PI)) {
 		if (len < sizeof(pi))
@@ -1720,8 +1732,16 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 
 	if (tun->flags & IFF_VNET_HDR) {
 		int vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
+		int parsed_size;
 
-		hdr_len = tun_vnet_hdr_get(vnet_hdr_sz, tun->flags, from, &gso);
+		if (vnet_hdr_sz < TUN_VNET_TNL_SIZE) {
+			parsed_size = vnet_hdr_sz;
+		} else {
+			parsed_size = TUN_VNET_TNL_SIZE;
+			flags |= TUN_VNET_TNL_MASK;
+		}
+		hdr_len = __tun_vnet_hdr_get(vnet_hdr_sz, parsed_size,
+					     flags, from, gso);
 		if (hdr_len < 0)
 			return hdr_len;
 
@@ -1755,7 +1775,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		 * (e.g gso or jumbo packet), we will do it at after
 		 * skb was created with generic XDP routine.
 		 */
-		skb = tun_build_skb(tun, tfile, from, &gso, len, &skb_xdp);
+		skb = tun_build_skb(tun, tfile, from, gso, len, &skb_xdp);
 		err = PTR_ERR_OR_ZERO(skb);
 		if (err)
 			goto drop;
@@ -1799,7 +1819,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		}
 	}
 
-	if (tun_vnet_hdr_to_skb(tun->flags, skb, &gso)) {
+	if (tun_vnet_hdr_to_skb(flags, skb, gso)) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		err = -EINVAL;
 		goto free_skb;
@@ -2050,13 +2070,26 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	}
 
 	if (vnet_hdr_sz) {
-		struct virtio_net_hdr gso;
+		char buf[TUN_VNET_TNL_SIZE];
+		struct virtio_net_hdr *gso;
+		int flags = tun->flags;
+		int parsed_size;
+
+		gso = (void *)buf;
+		parsed_size = tun_vnet_parse_size(tun->flags);
+		if (unlikely(vnet_hdr_sz < parsed_size)) {
+			/* Inconsistent hdr size and (tunnel) offloads:
+			 * strips the latter
+			 */
+			flags &= ~TUN_VNET_TNL_MASK;
+			parsed_size = sizeof(struct virtio_net_hdr);
+		};
 
-		ret = tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, &gso);
+		ret = tun_vnet_hdr_from_skb(flags, tun->dev, skb, gso);
 		if (ret)
 			return ret;
 
-		ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
+		ret = __tun_vnet_hdr_put(vnet_hdr_sz, parsed_size, iter, gso);
 		if (ret)
 			return ret;
 	}
@@ -2366,6 +2399,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 	int metasize = 0;
 	int ret = 0;
 	bool skb_xdp = false;
+	unsigned int flags;
 	struct page *page;
 
 	if (unlikely(datasize < ETH_HLEN))
@@ -2426,7 +2460,16 @@ static int tun_xdp_one(struct tun_struct *tun,
 	if (metasize > 0)
 		skb_metadata_set(skb, metasize);
 
-	if (tun_vnet_hdr_to_skb(tun->flags, skb, gso)) {
+	/* Assume tun offloads are enabled if the provided hdr is large
+	 * enough.
+	 */
+	if (READ_ONCE(tun->vnet_hdr_sz) >= TUN_VNET_TNL_SIZE &&
+	    xdp->data - xdp->data_hard_start >= TUN_VNET_TNL_SIZE)
+		flags = tun->flags | TUN_VNET_TNL_MASK;
+	else
+		flags = tun->flags & ~TUN_VNET_TNL_MASK;
+
+	if (tun_vnet_hdr_to_skb(flags, skb, gso)) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		kfree_skb(skb);
 		ret = -EINVAL;
@@ -2812,6 +2855,8 @@ static void tun_get_iff(struct tun_struct *tun, struct ifreq *ifr)
 
 }
 
+#define PLAIN_GSO (NETIF_F_GSO_UDP_L4 | NETIF_F_TSO | NETIF_F_TSO6)
+
 /* This is like a cut-down ethtool ops, except done via tun fd so no
  * privs required. */
 static int set_offload(struct tun_struct *tun, unsigned long arg)
@@ -2841,6 +2886,17 @@ static int set_offload(struct tun_struct *tun, unsigned long arg)
 			features |= NETIF_F_GSO_UDP_L4;
 			arg &= ~(TUN_F_USO4 | TUN_F_USO6);
 		}
+
+		/* Tunnel offload is allowed only if some plain offload is
+		 * available, too.
+		 */
+		if (features & PLAIN_GSO && arg & TUN_F_UDP_TUNNEL_GSO) {
+			features |= NETIF_F_GSO_UDP_TUNNEL;
+			if (arg & TUN_F_UDP_TUNNEL_GSO_CSUM)
+				features |= NETIF_F_GSO_UDP_TUNNEL_CSUM;
+			arg &= ~(TUN_F_UDP_TUNNEL_GSO |
+				 TUN_F_UDP_TUNNEL_GSO_CSUM);
+		}
 	}
 
 	/* This gives the user a way to test for new features in future by
@@ -2852,7 +2908,8 @@ static int set_offload(struct tun_struct *tun, unsigned long arg)
 	tun->dev->wanted_features &= ~TUN_USER_FEATURES;
 	tun->dev->wanted_features |= features;
 	netdev_update_features(tun->dev);
-
+	tun_set_vnet_tnl(&tun->flags, !!(features & NETIF_F_GSO_UDP_TUNNEL),
+			 !!(features & NETIF_F_GSO_UDP_TUNNEL_CSUM));
 	return 0;
 }
 
diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
index 58b9ac7a5fc40..ab2d4396941ca 100644
--- a/drivers/net/tun_vnet.h
+++ b/drivers/net/tun_vnet.h
@@ -5,6 +5,12 @@
 /* High bits in flags field are unused. */
 #define TUN_VNET_LE     0x80000000
 #define TUN_VNET_BE     0x40000000
+#define TUN_VNET_TNL		0x20000000
+#define TUN_VNET_TNL_CSUM	0x10000000
+#define TUN_VNET_TNL_MASK	(TUN_VNET_TNL | TUN_VNET_TNL_CSUM)
+
+#define TUN_VNET_TNL_SIZE (sizeof(struct virtio_net_hdr_v1) + \
+			   sizeof(struct virtio_net_hdr_tunnel))
 
 static inline bool tun_vnet_legacy_is_little_endian(unsigned int flags)
 {
@@ -45,6 +51,13 @@ static inline long tun_set_vnet_be(unsigned int *flags, int __user *argp)
 	return 0;
 }
 
+static inline void tun_set_vnet_tnl(unsigned int *flags, bool tnl, bool tnl_csum)
+{
+	*flags = (*flags & ~TUN_VNET_TNL_MASK) |
+		 tnl * TUN_VNET_TNL |
+		 tnl_csum * TUN_VNET_TNL_CSUM;
+}
+
 static inline bool tun_vnet_is_little_endian(unsigned int flags)
 {
 	return flags & TUN_VNET_LE || tun_vnet_legacy_is_little_endian(flags);
@@ -107,16 +120,33 @@ static inline long tun_vnet_ioctl(int *vnet_hdr_sz, unsigned int *flags,
 	}
 }
 
-static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
-				   struct iov_iter *from,
-				   struct virtio_net_hdr *hdr)
+static inline unsigned int tun_vnet_parse_size(unsigned int flags)
+{
+	if (!(flags & TUN_VNET_TNL))
+		return sizeof(struct virtio_net_hdr);
+
+	return TUN_VNET_TNL_SIZE;
+}
+
+static inline unsigned int tun_vnet_tnl_offset(unsigned int flags)
+{
+	if (!(flags & TUN_VNET_TNL))
+		return 0;
+
+	return sizeof(struct virtio_net_hdr_v1);
+}
+
+static inline int __tun_vnet_hdr_get(int sz, int parsed_size,
+				     unsigned int flags,
+				     struct iov_iter *from,
+				     struct virtio_net_hdr *hdr)
 {
 	u16 hdr_len;
 
 	if (iov_iter_count(from) < sz)
 		return -EINVAL;
 
-	if (!copy_from_iter_full(hdr, sizeof(*hdr), from))
+	if (!copy_from_iter_full(hdr, parsed_size, from))
 		return -EFAULT;
 
 	hdr_len = tun_vnet16_to_cpu(flags, hdr->hdr_len);
@@ -129,30 +159,47 @@ static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
 	if (hdr_len > iov_iter_count(from))
 		return -EINVAL;
 
-	iov_iter_advance(from, sz - sizeof(*hdr));
+	iov_iter_advance(from, sz - parsed_size);
 
 	return hdr_len;
 }
 
-static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
-				   const struct virtio_net_hdr *hdr)
+static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
+				   struct iov_iter *from,
+				   struct virtio_net_hdr *hdr)
+{
+	return __tun_vnet_hdr_get(sz, sizeof(*hdr), flags, from, hdr);
+}
+
+static inline int __tun_vnet_hdr_put(int sz, int parsed_size,
+				     struct iov_iter *iter,
+				     const struct virtio_net_hdr *hdr)
 {
 	if (unlikely(iov_iter_count(iter) < sz))
 		return -EINVAL;
 
-	if (unlikely(copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr)))
+	if (unlikely(copy_to_iter(hdr, parsed_size, iter) != parsed_size))
 		return -EFAULT;
 
-	if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
+	if (iov_iter_zero(sz - parsed_size, iter) != sz - parsed_size)
 		return -EFAULT;
 
 	return 0;
 }
 
+static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
+				   const struct virtio_net_hdr *hdr)
+{
+	return __tun_vnet_hdr_put(sz, sizeof(*hdr), iter, hdr);
+}
+
 static inline int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
 				      const struct virtio_net_hdr *hdr)
 {
-	return virtio_net_hdr_to_skb(skb, hdr, tun_vnet_is_little_endian(flags));
+	return virtio_net_hdr_tnl_to_skb(skb, hdr,
+					 tun_vnet_tnl_offset(flags),
+					 !!(flags & TUN_VNET_TNL_CSUM),
+					 tun_vnet_is_little_endian(flags));
 }
 
 static inline int tun_vnet_hdr_from_skb(unsigned int flags,
@@ -161,10 +208,11 @@ static inline int tun_vnet_hdr_from_skb(unsigned int flags,
 					struct virtio_net_hdr *hdr)
 {
 	int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
+	int tnl_offset = tun_vnet_tnl_offset(flags);
 
-	if (virtio_net_hdr_from_skb(skb, hdr,
-				    tun_vnet_is_little_endian(flags), true,
-				    vlan_hlen)) {
+	if (virtio_net_hdr_tnl_from_skb(skb, hdr, tnl_offset,
+					tun_vnet_is_little_endian(flags),
+					vlan_hlen)) {
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
 
 		if (net_ratelimit()) {
diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 287cdc81c9390..a25a5e7a08ffa 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -93,6 +93,15 @@
 #define TUN_F_USO4	0x20	/* I can handle USO for IPv4 packets */
 #define TUN_F_USO6	0x40	/* I can handle USO for IPv6 packets */
 
+#define TUN_F_UDP_TUNNEL_GSO		0x080 /* I can handle TSO/USO for UDP
+					       * tunneled packets
+					       */
+#define TUN_F_UDP_TUNNEL_GSO_CSUM	0x100 /* I can handle TSO/USO for UDP
+					       * tunneled packets requiring
+					       * csum offload for the outer
+					       * header
+					       */
+
 /* Protocol info prepended to the packets (when IFF_NO_PI is not set) */
 #define TUN_PKT_STRIP	0x0001
 struct tun_pi {
-- 
2.49.0


