Return-Path: <netdev+bounces-233538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E05C15324
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 15:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29E118946C7
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 14:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C4833509B;
	Tue, 28 Oct 2025 14:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHL8TrA6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050033376A3
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662313; cv=none; b=EJsV1oWpVjrn5+8Te+s+li/zheH++QTlU08wUm4EkmWt7d4vhpkFDJFnGmlronGEzYwGGlloY0bgy/SR8HF5PJ/ljQ2b/kZbaJkBCHZLZ5y6bVXNHWWyADJTyFONXA5C1yabNoXSGAlKoBTZtBOJeOH36z0FRLSP6MBa6KfjRdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662313; c=relaxed/simple;
	bh=tVgZHcpk2/8FCFKXjKO9Ef0kvqTf63pD2EKQHrmtnzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3lClgCnde9+ppvpJ23g+fstWHLrBb1qqPh5wPfqGWRfNshn6xzwH7sCgO/FK3x+Q7b9YUSnm3P7QT+m7TJbLAgMQSItDTaGRd+q9CXuqEKCyziapBeUKD74uCrWGoAcvtdpp5NWkSuyWSR3AZW2Pm2NuVY9/Hwnj0xAN4GZJhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VHL8TrA6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761662311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+GBHHTiKTgP5Cw8Ob+J+fQoanuj4YwsG3gMCqElf5I=;
	b=VHL8TrA6Fxq9NMw+Kyc+RXygodnnQ74WOi9TQHJOfFCgisySkipM+SDzHllaV0+bj7sK2u
	ROeOWrNRFMI0/KfTi+9wR0GicZWrlH1IADbFCbVt3We2Rwtox9f4injMykEeUek5ZjvQDf
	22LEjbuPpfFmIDzSx1ZmSKPGMRY/kR0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-Ky7cXYb6PYuiNN3rN_-0ug-1; Tue, 28 Oct 2025 10:38:29 -0400
X-MC-Unique: Ky7cXYb6PYuiNN3rN_-0ug-1
X-Mimecast-MFC-AGG-ID: Ky7cXYb6PYuiNN3rN_-0ug_1761662308
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b6d42c454c2so344775466b.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 07:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761662308; x=1762267108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+GBHHTiKTgP5Cw8Ob+J+fQoanuj4YwsG3gMCqElf5I=;
        b=cU8q+U3TbFFSpY4F77RBOskz3OjYtJKvRoqv9ueYjnxNr0QzhyAeexnv7h+LcpnQjM
         wfpvCJaedfvVxaeLiM8Dp/kMCT/M767VEiAFgV+mCt7S5aAGme7r/C1OUOIpBWELUkrP
         WW9DurEqaCyEFjsvhh0X+OSdomWjZL6zdCC/TCJ1i2/ErY9LsclcGS22eTFlV/0nx2Ga
         uyXZgsISG9Q5DcK6X3u6e8E5jgu50HUx371eP7NdVK7dAMIj5KIOp6WeNO6BZXf+NK5X
         /L0mf3DdZ0ZIOPM3yldTMJLWx7QQQY44MeQKGoc3SxYzLyfQklqDBj4GO8dUt9mCU+Ny
         qetA==
X-Forwarded-Encrypted: i=1; AJvYcCV8aWSmmW4KUKKfCPzWbCy2cVigIj2h9/fgvHeAV4XE6dZU8Eduex0SRhsjV4ZhdOrZVO4bXsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf6J+wjyoR91KnaguBqphCAOjBBkYFQR5T41/Cc69npeJGs53p
	YuAoP6DJ+OFZfm5yv1cMImfaQr/vl2ZMdaxCWMw58zsX1wjLfN60JpZoj67OnciBPWSs2OO6nzB
	wTlm4HgJyBI8gH23/f7qAgQZ2SiSk7MAJLj4jelt4SI4N/76SOJLDtNtSPw==
X-Gm-Gg: ASbGncv9qT+hvqST1IqQb1rnVJVHjH0YXWtVCFbsf6NONXGI3BX0hZ88CqS+qXt3g67
	xOOgZQo193rXnl97W0uimYlIfUsms4Mx9idMqlFySyh+wUn6nPBgfy5lojXkZsfjhS1OlPWc0E0
	gHRQqSz9f1Bcu7bsVAW6HkBK4GblOCFCpqN6oZGYEh98TtbEIJtUlk52poJfF8ivE9rwYLI6BP8
	LIDcQG0AVsJRQZgimgcztQUxd2fQnAkVeojPYlQBpNLKrhIvnSuMMsM+30PDYsLdYftEp3HINjM
	zhIDqsKqCBSodh7cvdiCrmZ1t3yOE4fZUQZpXYU2sPxJsIAZHn0F/S2aZ1P/amuB
X-Received: by 2002:a17:907:972a:b0:b04:830f:822d with SMTP id a640c23a62f3a-b6dba5e2eacmr406988966b.63.1761662308139;
        Tue, 28 Oct 2025 07:38:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ7gaoowOrDxQE7SKxipOwlENzJhDMgw5n2DRygPTmZfMSZlW8c820N7yX20yj84I/xNwkKQ==
X-Received: by 2002:a17:907:972a:b0:b04:830f:822d with SMTP id a640c23a62f3a-b6dba5e2eacmr406985566b.63.1761662307596;
        Tue, 28 Oct 2025 07:38:27 -0700 (PDT)
Received: from redhat.com ([31.187.78.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef6bfd7sm8957970a12.4.2025.10.28.07.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 07:38:27 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:38:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] virtio-net: calculate header alignment mask based on
 features
Message-ID: <20251028101144-mutt-send-email-mst@kernel.org>
References: <20251028030341.46023-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028030341.46023-1-jasowang@redhat.com>

On Tue, Oct 28, 2025 at 11:03:41AM +0800, Jason Wang wrote:
> Commit 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
> switches to check the alignment of the virtio_net_hdr_v1_hash_tunnel
> even when doing the transmission even if the feature is not
> negotiated. This will cause 


you mean this causes

>a series performance degradation of pktgen
> as the skb->data can't satisfy the alignment requirement due to the
> increase of the header size then virtio-net must prepare at least 2
> sgs with indirect descriptors which will introduce overheads in the


introduces, accordinglt

> device.
> 
> Fixing this by calculate the header alignment during probe so when
> tunnel gso is not negotiated, we can less strict.
> 
> Pktgen in guest + XDP_DROP on TAP + vhost_net shows the TX PPS is
> recovered from 2.4Mpps to 4.45Mpps.
> 
> Note that we still need a way to recover the performance when tunnel
> gso is enabled, probably a new vnet header format.

you mean improve, not recover as such


> 
> Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/virtio_net.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 31bd32bdecaf..5b851df749c0 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -441,6 +441,9 @@ struct virtnet_info {
>  	/* Packet virtio header size */
>  	u8 hdr_len;
>  
> +	/* header alignment */
> +	size_t hdr_align;
> +

It makes no sense to have u8 for length but size_t for alignment,
and u8 would fit in a memory hole we have, anyway.

>  	/* Work struct for delayed refilling if we run low on memory. */
>  	struct delayed_work refill;
>  
> @@ -3308,8 +3311,9 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
>  	pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
>  
>  	can_push = vi->any_header_sg &&
> -		!((unsigned long)skb->data & (__alignof__(*hdr) - 1)) &&
> +		!((unsigned long)skb->data & (vi->hdr_align - 1)) &&


So let me get it straight.
We use the alignment check to be able to cast to the correct type.
The issue is that alignment for the header changed. 

virtio_net_hdr_v1 has 2 byte alignment, but:



struct virtio_net_hdr_v1_hash {
        struct virtio_net_hdr_v1 hdr; 
        __le32 hash_value;
#define VIRTIO_NET_HASH_REPORT_NONE            0
#define VIRTIO_NET_HASH_REPORT_IPv4            1
#define VIRTIO_NET_HASH_REPORT_TCPv4           2
#define VIRTIO_NET_HASH_REPORT_UDPv4           3
#define VIRTIO_NET_HASH_REPORT_IPv6            4
#define VIRTIO_NET_HASH_REPORT_TCPv6           5
#define VIRTIO_NET_HASH_REPORT_UDPv6           6
#define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
#define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
#define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
        __le16 hash_report; 
        __le16 padding;
};      


has 4 byte due to hash_value, and accordingly:


struct virtio_net_hdr_v1_hash_tunnel {
        struct virtio_net_hdr_v1_hash hash_hdr;
        __le16 outer_th_offset;                                
        __le16 inner_nh_offset;
};              


now is 4 byte aligned so everything is messed up:
net tends not to be 4 byte aligned.




>  		!skb_header_cloned(skb) && skb_headroom(skb) >= hdr_len;
> +
>  	/* Even if we can, don't push here yet as this would skew
>  	 * csum_start offset below. */
>  	if (can_push)
> @@ -6926,15 +6930,20 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	}
>  
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) ||
> -	    virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO))
> +	    virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO)) {
>  		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash_tunnel);
> -	else if (vi->has_rss_hash_report)
> +		vi->hdr_align = __alignof__(struct virtio_net_hdr_v1_hash_tunnel);
> +	} else if (vi->has_rss_hash_report) {
>  		vi->hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
> -	else if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF) ||
> -		 virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
> +		vi->hdr_align = __alignof__(struct virtio_net_hdr_v1_hash);
> +	} else if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF) ||
> +		virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>  		vi->hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
> -	else
> +		vi->hdr_align = __alignof__(struct virtio_net_hdr_mrg_rxbuf);
> +	} else {
>  		vi->hdr_len = sizeof(struct virtio_net_hdr);
> +		vi->hdr_align = __alignof__(struct virtio_net_hdr);
> +	}
>  
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM))
>  		vi->rx_tnl_csum = true;

So how about just fixing the root cause then?
Like this (untested, if you agree pls take over this):

---

virtio_net: fix alignment for virtio_net_hdr_v1_hash


changing alignment of header would mean it's no longer safe to cast a 2
byte aligned pointer between formats. Use two 16 bit fields to make it 2
byte aligned as previously.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

-- 

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 31bd32bdecaf..02ce5316f47d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2535,6 +2535,13 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	return NULL;
 }
 
+static inline u16
+virtio_net_hash_value(const struct virtio_net_hdr_v1_hash *hdr_hash)
+{
+	return __le16_to_cpu(hdr_hash->hash_value_lo) |
+		(__le16_to_cpu(hdr_hash->hash_value_hi) << 16);
+}
+
 static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
 				struct sk_buff *skb)
 {
@@ -2561,7 +2568,7 @@ static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
 	default:
 		rss_hash_type = PKT_HASH_TYPE_NONE;
 	}
-	skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_value), rss_hash_type);
+	skb_set_hash(skb, virtio_net_hash_value(hdr_hash), rss_hash_type);
 }
 
 static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
@@ -3307,6 +3314,10 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 
 	pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
 
+	/* Make sure it's safe to cast between formats */
+	BUILD_BUG_ON(__alignof__(*hdr) != __alignof__(hdr->hash_hdr));
+	BUILD_BUG_ON(__alignof__(*hdr) != __alignof__(hdr->hash_hdr.hdr));
+
 	can_push = vi->any_header_sg &&
 		!((unsigned long)skb->data & (__alignof__(*hdr) - 1)) &&
 		!skb_header_cloned(skb) && skb_headroom(skb) >= hdr_len;
@@ -6755,7 +6766,7 @@ static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
 		hash_report = VIRTIO_NET_HASH_REPORT_NONE;
 
 	*rss_type = virtnet_xdp_rss_type[hash_report];
-	*hash = __le32_to_cpu(hdr_hash->hash_value);
+	*hash = virtio_net_hash_value(hdr_hash);
 	return 0;
 }
 
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 8bf27ab8bcb4..1db45b01532b 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -193,7 +193,8 @@ struct virtio_net_hdr_v1 {
 
 struct virtio_net_hdr_v1_hash {
 	struct virtio_net_hdr_v1 hdr;
-	__le32 hash_value;
+	__le16 hash_value_lo;
+	__le16 hash_value_hi;
 #define VIRTIO_NET_HASH_REPORT_NONE            0
 #define VIRTIO_NET_HASH_REPORT_IPv4            1
 #define VIRTIO_NET_HASH_REPORT_TCPv4           2


