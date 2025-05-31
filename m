Return-Path: <netdev+bounces-194470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A627AC99A3
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 08:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2A297A9446
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 06:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9202C1DE2A8;
	Sat, 31 May 2025 06:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="epil0ubd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC7F8479
	for <netdev@vger.kernel.org>; Sat, 31 May 2025 06:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748673502; cv=none; b=JjhXIsDmro1FEewKAnEOAVCh/Kp5mjhpPU5SXZIzdkuHTFm988nObNz9h0z6Qv3tXDr1RyutPYghyYoCEaIm0JCca2He2b1Te6RY46q/NohEYRp65iiNbjshbNYz5Mg0qhTKrS6rWUgKYsrJEocXt1kvas+p55WMYj6rxp7j+jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748673502; c=relaxed/simple;
	bh=VVubUS/RfQgh2cpsHBM1tm7QHYiZtj4jEfCICl6D01w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0oSx/YZIGjf0+fPug5sRgaZmc2AOG0ZzmOzmiBCwWZ2tTWhlI2yqYZu4IMoth+ym1Q6QG6U7LnawF8liWSF9zJOo0+wm1sOAFY2IBCG9GKOxZNz9uLQfxCVyPPD7tJbLt+NmoGknhkvksmXtPffzZoLjHO92klnmP9W82gqVRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=epil0ubd; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-73972a54919so2419739b3a.3
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 23:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748673499; x=1749278299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W+LvEuU7AHZxBp200CYOZJBsdwxmYbCcdu1h9MN4MGQ=;
        b=epil0ubda5gWWUtiVX7fch0W+hATxFD/9idkTTJHETy8Fpy0RCJ+7sXiyvxf7eVm8k
         QeUtyuaZEKrT2mnLD0Tll9hSupCC/i2hZgOPyhqVL8N1YpojYnb7lyVsdv1MVKmhOLke
         UszHa2wwLZVTz6Jk7ZSIcYol+1EzrbXXB1r8JBsoItYsy6vTL8QQ4fv/+hP2fCaUhoBz
         6M/b2bnF4r8T4aE5Vx83CJRhu4TNhpjRUf8jQNq1PODcKlgP+fVUUIcLKpSbSsUKDU4o
         bl69c8golIO1QyMK1xDlQkNjj7+Ghga+vovVkrg0esxCCuK4DzdTEamvqaNjTp1qVFC2
         pdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748673499; x=1749278299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+LvEuU7AHZxBp200CYOZJBsdwxmYbCcdu1h9MN4MGQ=;
        b=R7GUjFou/AtxzCSiB0beGM+mIyZflZU9D97yzMyrdrJt+eAquypy98BhsUNgw3h+ru
         Zy61F6l91/WMGcc/gp7DpIAfs6gGJo7su9DlDDbxnt8N/NPoJz8Qe1Ep5e3IVZYcMm8n
         dWxBq4VAgzLofBi3gZ5Jza1MNZxIA8RUwAaukMdq2WM2mHScqMIG5k0D4f+dd6WgE/rB
         AkqSKp+kbgoLI0bG9LtRDguzeBhitawBAIJ8nj9tg+L5lHSnTQY/DcvLR8XfjUZJ6Uun
         +3BnSkbQZ2wsTZ4A1P+C9u+98wOiVu/6nTgEW4RRl4YRD1VWBlPBsDNEjX9X5n7tKEOM
         Wh1A==
X-Forwarded-Encrypted: i=1; AJvYcCUgSM3svS31pg0mJZuZhyEDJj9Sn/eZgdPekGdG496jO/X0sF5KDPMW9FGSdyR+nNd0O92yIMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyipdChNv+KwNbcODQBiTGYN/7nTQOTSytJYqgjOhiFNs6TreDc
	3eMlPCoU3zAW6tmfMLYhIt6fIYR9HHnEXrndS/ePeJczqJNgb7hpo8TLT5UPt9oePkI=
X-Gm-Gg: ASbGncvbVvddrio1ZQV9jBoZI9VOW4nAL1aSukEtVnwxiCo2+o+xq1wE8dDl+YRr3Q0
	z6ulN/vFUq5ZuOVUkZtfbvFmGjlQ2qNeVVaV105qO2mulP5HboGF15zhDD3OVL08cxO0PmvU7dF
	DWtui+10RoWoD7NCJnhoK5K0ZKG4qPaqOqDjiEiHeFvuy/ZXWUZFGsdXNSwLBVwSh1/6ooRdQ61
	p0bQffJpx85sG9WzeyBd+OzgboEgQLpAsuOCu3ud5eqks2RV+ZQkUTd9bIYc9l8V71BRHGipl0b
	ygWaOzXeDjtZOBbUILQgl00StsaJayVj3gjrjwbKeVwjNm5tTXuORm6/K0ubWg==
X-Google-Smtp-Source: AGHT+IHUpj/Jf2NDxJPc3GeAeqsDYPp7XI19O1z/GZYCOyGSi3Oc30RxNcYIn5479pO4lWFbO8lNVw==
X-Received: by 2002:a17:902:e805:b0:234:eadc:c0b4 with SMTP id d9443c01a7336-2355f77769dmr15411365ad.44.1748673499502;
        Fri, 30 May 2025 23:38:19 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cfcbb9sm37459595ad.208.2025.05.30.23.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 23:38:19 -0700 (PDT)
Message-ID: <2f6f81f0-f2df-4d30-a34f-8b1902909b9c@daynix.com>
Date: Sat, 31 May 2025 15:38:16 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 7/8] tun: enable gso over UDP tunnel support.
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>
References: <cover.1748614223.git.pabeni@redhat.com>
 <cf277d3e2e72b1b6643f3ebea780f44552b8da7f.1748614223.git.pabeni@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <cf277d3e2e72b1b6643f3ebea780f44552b8da7f.1748614223.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/05/30 23:49, Paolo Abeni wrote:
> Add new tun features to represent the newly introduced virtio
> GSO over UDP tunnel offload. Allows detection and selection of
> such features via the existing TUNSETOFFLOAD ioctl, store the
> tunnel offload configuration in the highest bit of the tun flags
> and compute the expected virtio header size and tunnel header
> offset using such bits, so that we can plug almost seamless the
> the newly introduced virtio helpers to serialize the extended
> virtio header.
> 
> As the tun features and the virtio hdr size are configured
> separately, the data path need to cope with (hopefully transient)
> inconsistent values.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Note that this semantically conflicts with the hash report series, one,
> the other or both should be adjusted to fit.
> ---
>   drivers/net/tun.c           | 77 ++++++++++++++++++++++++++++++++-----
>   drivers/net/tun_vnet.h      | 74 ++++++++++++++++++++++++++++-------
>   include/uapi/linux/if_tun.h |  9 +++++
>   3 files changed, 137 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 1207196cbbed..2977aff5bc46 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -186,7 +186,8 @@ struct tun_struct {
>   	struct net_device	*dev;
>   	netdev_features_t	set_features;
>   #define TUN_USER_FEATURES (NETIF_F_HW_CSUM|NETIF_F_TSO_ECN|NETIF_F_TSO| \
> -			  NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4)
> +			  NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4 | \
> +			  NETIF_F_GSO_UDP_TUNNEL | NETIF_F_GSO_UDP_TUNNEL_CSUM)
>   
>   	int			align;
>   	int			vnet_hdr_sz;
> @@ -925,6 +926,7 @@ static int tun_net_init(struct net_device *dev)
>   	dev->hw_features = NETIF_F_SG | NETIF_F_FRAGLIST |
>   			   TUN_USER_FEATURES | NETIF_F_HW_VLAN_CTAG_TX |
>   			   NETIF_F_HW_VLAN_STAG_TX;
> +	dev->hw_enc_features = dev->hw_features;
>   	dev->features = dev->hw_features;
>   	dev->vlan_features = dev->features &
>   			     ~(NETIF_F_HW_VLAN_CTAG_TX |
> @@ -1698,7 +1700,8 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>   	struct sk_buff *skb;
>   	size_t total_len = iov_iter_count(from);
>   	size_t len = total_len, align = tun->align, linear;
> -	struct virtio_net_hdr gso = { 0 };
> +	char buf[TUN_VNET_TNL_SIZE];
> +	struct virtio_net_hdr *gso;
>   	int good_linear;
>   	int copylen;
>   	int hdr_len = 0;
> @@ -1708,6 +1711,15 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>   	int skb_xdp = 1;
>   	bool frags = tun_napi_frags_enabled(tfile);
>   	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
> +	unsigned int flags = tun->flags & ~TUN_VNET_TNL_MASK;
> +
> +	/*
> +	 * Keep it easy and always zero the whole buffer, even if the
> +	 * tunnel-related field will be touched only when the feature
> +	 * is enabled and the hdr size id compatible.
> +	 */
> +	memset(buf, 0, sizeof(buf));
> +	gso = (void *)buf;

buf may be unaligned.

>   
>   	if (!(tun->flags & IFF_NO_PI)) {
>   		if (len < sizeof(pi))
> @@ -1720,8 +1732,16 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>   
>   	if (tun->flags & IFF_VNET_HDR) {
>   		int vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
> +		int parsed_size;
>   
> -		hdr_len = tun_vnet_hdr_get(vnet_hdr_sz, tun->flags, from, &gso);
> +		if (vnet_hdr_sz < TUN_VNET_TNL_SIZE) {
> +			parsed_size = vnet_hdr_sz;
> +		} else {
> +			parsed_size = TUN_VNET_TNL_SIZE;
> +			flags |= TUN_VNET_TNL_MASK;
> +		}
> +		hdr_len = __tun_vnet_hdr_get(vnet_hdr_sz, parsed_size,
> +					     flags, from, gso);
>   		if (hdr_len < 0)
>   			return hdr_len;
>   
> @@ -1755,7 +1775,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>   		 * (e.g gso or jumbo packet), we will do it at after
>   		 * skb was created with generic XDP routine.
>   		 */
> -		skb = tun_build_skb(tun, tfile, from, &gso, len, &skb_xdp);
> +		skb = tun_build_skb(tun, tfile, from, gso, len, &skb_xdp);
>   		err = PTR_ERR_OR_ZERO(skb);
>   		if (err)
>   			goto drop;
> @@ -1799,7 +1819,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>   		}
>   	}
>   
> -	if (tun_vnet_hdr_to_skb(tun->flags, skb, &gso)) {
> +	if (tun_vnet_hdr_to_skb(flags, skb, gso)) {
>   		atomic_long_inc(&tun->rx_frame_errors);
>   		err = -EINVAL;
>   		goto free_skb;
> @@ -2050,13 +2070,26 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>   	}
>   
>   	if (vnet_hdr_sz) {
> -		struct virtio_net_hdr gso;
> +		char buf[TUN_VNET_TNL_SIZE];
> +		struct virtio_net_hdr *gso;
> +		int flags = tun->flags;
> +		int parsed_size;
> +
> +		gso = (void *)buf;
> +		parsed_size = tun_vnet_parse_size(tun->flags);
> +		if (unlikely(vnet_hdr_sz < parsed_size)) {
> +			/* Inconsistent hdr size and (tunnel) offloads:
> +			 * strips the latter
> +			 */
> +			flags &= ~TUN_VNET_TNL_MASK;
> +			parsed_size = sizeof(struct virtio_net_hdr);
> +		};
>   
> -		ret = tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, &gso);
> +		ret = tun_vnet_hdr_from_skb(flags, tun->dev, skb, gso);
>   		if (ret)
>   			return ret;
>   
> -		ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
> +		ret = __tun_vnet_hdr_put(vnet_hdr_sz, parsed_size, iter, gso);
>   		if (ret)
>   			return ret;
>   	}
> @@ -2366,6 +2399,7 @@ static int tun_xdp_one(struct tun_struct *tun,
>   	int metasize = 0;
>   	int ret = 0;
>   	bool skb_xdp = false;
> +	unsigned int flags;
>   	struct page *page;
>   
>   	if (unlikely(datasize < ETH_HLEN))
> @@ -2426,7 +2460,16 @@ static int tun_xdp_one(struct tun_struct *tun,
>   	if (metasize > 0)
>   		skb_metadata_set(skb, metasize);
>   
> -	if (tun_vnet_hdr_to_skb(tun->flags, skb, gso)) {
> +	/* Assume tun offloads are enabled if the provided hdr is large
> +	 * enough.
> +	 */
> +	if (READ_ONCE(tun->vnet_hdr_sz) >= TUN_VNET_TNL_SIZE &&
> +	    xdp->data - xdp->data_hard_start >= TUN_VNET_TNL_SIZE)
> +		flags = tun->flags | TUN_VNET_TNL_MASK;
> +	else
> +		flags = tun->flags & ~TUN_VNET_TNL_MASK;
> +
> +	if (tun_vnet_hdr_to_skb(flags, skb, gso)) {
>   		atomic_long_inc(&tun->rx_frame_errors);
>   		kfree_skb(skb);
>   		ret = -EINVAL;
> @@ -2812,6 +2855,8 @@ static void tun_get_iff(struct tun_struct *tun, struct ifreq *ifr)
>   
>   }
>   
> +#define PLAIN_GSO (NETIF_F_GSO_UDP_L4 | NETIF_F_TSO | NETIF_F_TSO6)
> +
>   /* This is like a cut-down ethtool ops, except done via tun fd so no
>    * privs required. */
>   static int set_offload(struct tun_struct *tun, unsigned long arg)
> @@ -2841,6 +2886,17 @@ static int set_offload(struct tun_struct *tun, unsigned long arg)
>   			features |= NETIF_F_GSO_UDP_L4;
>   			arg &= ~(TUN_F_USO4 | TUN_F_USO6);
>   		}
> +
> +		/* Tunnel offload is allowed only if some plain offload is
> +		 * available, too.
> +		 */
> +		if (features & PLAIN_GSO && arg & TUN_F_UDP_TUNNEL_GSO) {
> +			features |= NETIF_F_GSO_UDP_TUNNEL;
> +			if (arg & TUN_F_UDP_TUNNEL_GSO_CSUM)
> +				features |= NETIF_F_GSO_UDP_TUNNEL_CSUM;
> +			arg &= ~(TUN_F_UDP_TUNNEL_GSO |
> +				 TUN_F_UDP_TUNNEL_GSO_CSUM);
> +		}
>   	}
>   
>   	/* This gives the user a way to test for new features in future by
> @@ -2852,7 +2908,8 @@ static int set_offload(struct tun_struct *tun, unsigned long arg)
>   	tun->dev->wanted_features &= ~TUN_USER_FEATURES;
>   	tun->dev->wanted_features |= features;
>   	netdev_update_features(tun->dev);
> -
> +	tun_set_vnet_tnl(&tun->flags, !!(features & NETIF_F_GSO_UDP_TUNNEL),
> +			 !!(features & NETIF_F_GSO_UDP_TUNNEL_CSUM));
>   	return 0;
>   }
>   
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index 58b9ac7a5fc4..ab2d4396941c 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -5,6 +5,12 @@
>   /* High bits in flags field are unused. */
>   #define TUN_VNET_LE     0x80000000
>   #define TUN_VNET_BE     0x40000000
> +#define TUN_VNET_TNL		0x20000000
> +#define TUN_VNET_TNL_CSUM	0x10000000
> +#define TUN_VNET_TNL_MASK	(TUN_VNET_TNL | TUN_VNET_TNL_CSUM)
> +
> +#define TUN_VNET_TNL_SIZE (sizeof(struct virtio_net_hdr_v1) + \
> +			   sizeof(struct virtio_net_hdr_tunnel))
>   
>   static inline bool tun_vnet_legacy_is_little_endian(unsigned int flags)
>   {
> @@ -45,6 +51,13 @@ static inline long tun_set_vnet_be(unsigned int *flags, int __user *argp)
>   	return 0;
>   }
>   
> +static inline void tun_set_vnet_tnl(unsigned int *flags, bool tnl, bool tnl_csum)
> +{
> +	*flags = (*flags & ~TUN_VNET_TNL_MASK) |
> +		 tnl * TUN_VNET_TNL |
> +		 tnl_csum * TUN_VNET_TNL_CSUM;
> +}
> +
>   static inline bool tun_vnet_is_little_endian(unsigned int flags)
>   {
>   	return flags & TUN_VNET_LE || tun_vnet_legacy_is_little_endian(flags);
> @@ -107,16 +120,33 @@ static inline long tun_vnet_ioctl(int *vnet_hdr_sz, unsigned int *flags,
>   	}
>   }
>   
> -static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
> -				   struct iov_iter *from,
> -				   struct virtio_net_hdr *hdr)
> +static inline unsigned int tun_vnet_parse_size(unsigned int flags)
> +{
> +	if (!(flags & TUN_VNET_TNL))
> +		return sizeof(struct virtio_net_hdr);
> +
> +	return TUN_VNET_TNL_SIZE;
> +}
> +
> +static inline unsigned int tun_vnet_tnl_offset(unsigned int flags)
> +{
> +	if (!(flags & TUN_VNET_TNL))
> +		return 0;
> +
> +	return sizeof(struct virtio_net_hdr_v1);
> +}
> +
> +static inline int __tun_vnet_hdr_get(int sz, int parsed_size,
> +				     unsigned int flags,
> +				     struct iov_iter *from,
> +				     struct virtio_net_hdr *hdr)
>   {
>   	u16 hdr_len;
>   
>   	if (iov_iter_count(from) < sz)
>   		return -EINVAL;
>   
> -	if (!copy_from_iter_full(hdr, sizeof(*hdr), from))
> +	if (!copy_from_iter_full(hdr, parsed_size, from))
>   		return -EFAULT;
>   
>   	hdr_len = tun_vnet16_to_cpu(flags, hdr->hdr_len);
> @@ -129,30 +159,47 @@ static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
>   	if (hdr_len > iov_iter_count(from))
>   		return -EINVAL;
>   
> -	iov_iter_advance(from, sz - sizeof(*hdr));
> +	iov_iter_advance(from, sz - parsed_size);
>   
>   	return hdr_len;
>   }
>   
> -static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
> -				   const struct virtio_net_hdr *hdr)
> +static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
> +				   struct iov_iter *from,
> +				   struct virtio_net_hdr *hdr)
> +{
> +	return __tun_vnet_hdr_get(sz, sizeof(*hdr), flags, from, hdr);
> +}
> +
> +static inline int __tun_vnet_hdr_put(int sz, int parsed_size,
> +				     struct iov_iter *iter,
> +				     const struct virtio_net_hdr *hdr)
>   {
>   	if (unlikely(iov_iter_count(iter) < sz))
>   		return -EINVAL;
>   
> -	if (unlikely(copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr)))
> +	if (unlikely(copy_to_iter(hdr, parsed_size, iter) != parsed_size))
>   		return -EFAULT;
>   
> -	if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
> +	if (iov_iter_zero(sz - parsed_size, iter) != sz - parsed_size)
>   		return -EFAULT;
>   
>   	return 0;
>   }
>   
> +static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
> +				   const struct virtio_net_hdr *hdr)
> +{
> +	return __tun_vnet_hdr_put(sz, sizeof(*hdr), iter, hdr);
> +}
> +
>   static inline int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
>   				      const struct virtio_net_hdr *hdr)
>   {
> -	return virtio_net_hdr_to_skb(skb, hdr, tun_vnet_is_little_endian(flags));
> +	return virtio_net_hdr_tnl_to_skb(skb, hdr,
> +					 tun_vnet_tnl_offset(flags),
> +					 !!(flags & TUN_VNET_TNL_CSUM),
> +					 tun_vnet_is_little_endian(flags));
>   }
>   
>   static inline int tun_vnet_hdr_from_skb(unsigned int flags,
> @@ -161,10 +208,11 @@ static inline int tun_vnet_hdr_from_skb(unsigned int flags,
>   					struct virtio_net_hdr *hdr)
>   {
>   	int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
> +	int tnl_offset = tun_vnet_tnl_offset(flags);
>   
> -	if (virtio_net_hdr_from_skb(skb, hdr,
> -				    tun_vnet_is_little_endian(flags), true,
> -				    vlan_hlen)) {
> +	if (virtio_net_hdr_tnl_from_skb(skb, hdr, tnl_offset,
> +					tun_vnet_is_little_endian(flags),
> +					vlan_hlen)) {
>   		struct skb_shared_info *sinfo = skb_shinfo(skb);
>   
>   		if (net_ratelimit()) {
> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
> index 287cdc81c939..a25a5e7a08ff 100644
> --- a/include/uapi/linux/if_tun.h
> +++ b/include/uapi/linux/if_tun.h
> @@ -93,6 +93,15 @@
>   #define TUN_F_USO4	0x20	/* I can handle USO for IPv4 packets */
>   #define TUN_F_USO6	0x40	/* I can handle USO for IPv6 packets */
>   
> +#define TUN_F_UDP_TUNNEL_GSO		0x080 /* I can handle TSO/USO for UDP
> +					       * tunneled packets
> +					       */
> +#define TUN_F_UDP_TUNNEL_GSO_CSUM	0x100 /* I can handle TSO/USO for UDP
> +					       * tunneled packets requiring
> +					       * csum offload for the outer
> +					       * header
> +					       */


Documentation/process/coding-style.rst says multiline comments starts a 
line only with "/*". I also feel a bit difficult to read the comments 
with multiple short lines. So I sugguest:

/*
  * I can handle TSO/USO for UDP tunneled packets requiring csum offload
  * for the outer header
  */
#define TUN_F_UDP_TUNNEL_GSO_CSUM	0x080


> +
>   /* Protocol info prepended to the packets (when IFF_NO_PI is not set) */
>   #define TUN_PKT_STRIP	0x0001
>   struct tun_pi {


