Return-Path: <netdev+bounces-199808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E0DAE1D9A
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 16:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511CA5A8165
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 14:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A301528C2AC;
	Fri, 20 Jun 2025 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oqv0CJaL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABFE28FD
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750430418; cv=none; b=DtRm1LBaLVJ2uV0PDxP2lsHHirDJyswt8aLjq2SHr8aFYqAsYPS3h6I6sy1lHh8q1kuDBrTrMs8JS8mx1k9YsD1HXBsYP96x/f8yqSjzz/PE8CQddi9JNmUyXR7zGGxoz7a8emkTqJ9+DK05xcat+d3QHUWRMwRBRkCq8r3W38E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750430418; c=relaxed/simple;
	bh=xtwT2EWrvvmYUpwqeWcSF2sXj1NGRiBQEMX1XltU/AU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=essQYLmc8bsGLlcSjGEDKpYeiWLU2xg78NK54clBJJBiJw1RkXXkFkIpVVu7djVVE2x6IBeSM3s5fHFr9/RENZVXlIsY4qCu2GemiFqklCqQm9Y3Qg6RYiL9C63tKw5cL0L8fo63BZGPbdJNjJa45umIAdTectLaGZJV0lIXOy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oqv0CJaL; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e81749142b3so1794653276.3
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 07:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750430415; x=1751035215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3Tfvz1NcjdDpSPETE+a7PHSVa7G2BCRiMDg7VZwuEY=;
        b=Oqv0CJaLCcN/92N7BDp1+YYfkJIbGbpJUcVDypq9A4MJZ9IGja8Vsizmz9L2YG169B
         AQw+8UFJjqK54LFzVzD1oFOIZyv2FWhuqb8d81mcCrEJDV4fkwXdnc76fDx7mQe7PTD1
         E7G9sR1DSW6ywn0GqBVz+Jq7gnoJzTWnFZ80Jnlkbz9ysH+vGGX58ngZzhOAY03GLhad
         06y0/DonvAhqxmWfBO1wxXWlaLO6lAQNliDj6odSnmmR2k0P4KIYVAh+2ZKOHkTam1BZ
         pG7Q5yQ9zbYzAkSnMP3FnDuQwfg7Ec96M7sNxbv+k3NOLM5p0Y4DW5AiUozPFKueIMNO
         y8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750430415; x=1751035215;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x3Tfvz1NcjdDpSPETE+a7PHSVa7G2BCRiMDg7VZwuEY=;
        b=fd+c9Xt+0jbVlc1XMiE+lIR7NXxfbFBMp65+PCmnd98b1MlmBAEwE3mPa7hiUiozpW
         a34SGEjlKzvJZtOP71+CStayqqkCOhyFLUqA5dzP0fPDtP22pRupKn7Np4dg6AdEiYYO
         Bf8l3lWWG2f0poRa6+hQLJOFFFP3uGqavJcSPuAvriOwH+juz4NCEz3+qgnelfnzaXxP
         gAmjJrokokOkIHyUZLPNEWbTFU5R01eAq1VaJkAyL3LLI2RTwTqZpiWGGI+u4jbeegfy
         h/qpQ9aIRoqyQlmmprjg8s7VFduWAh0bd+ccwBX1Wt2l+JteDrX93rOKsuAjfWWIqFeU
         MDhg==
X-Forwarded-Encrypted: i=1; AJvYcCV4hAG0h29IVjqVbWN7FYlVdwdJQX7+7Wk7/RdlV01vfRpZsi5sIYx4z6nklFMMJyquiT3Hq6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLr+LpNS0RZpywmGP7NqfpGNpqhVle3kYEXVS+7+xVZqu4heQO
	Yx3WunmSKi0SF/h+ysnN87Jj/sgrVdMq1dIpGPKZcjXEHdaYCtOAc2hq
X-Gm-Gg: ASbGncswdCrdM9ulC9xkjHrkrlPT237EYpg7i41xW9n19B9pG3fQgQsikVxnwq1yB6k
	yYaksg7tvrQByrFbotVQbKEbtqP2E9Iq2PJEHLX5KuyTL1SlLN182XmsmVPT9My8TlCrdpmC50Y
	oNeLqjFuwLLWDSg30jM0+ziveLh7LHa4bnCxo4y9N9DArldLHfiQEIgJZTHbA/Z7JC3rIQuM0Gn
	lz6t1IxW8tx0OCU0qy4UyFYVFKiWMkI71HCQ2ssuvSfWTgH3ulNQ9iullpCWzOwgwSIJYGykuaQ
	6wd8Wrg1pMpcFPQTMxVGPN6xkhcCm56XtzfJF7SyjwVuEX9MtSshC45mng4UvIrGY5yjkQNZMMc
	xQArXmdAa/QVyrMRsCRj/BBRKSd/yoYO2Brua/oMxYg==
X-Google-Smtp-Source: AGHT+IESzkT52HId6R+eupj1aIuCSRVBXpXsuxwzVz0HBym1H8P9+1oZadVEdebCJnrFotXYYk/kqQ==
X-Received: by 2002:a05:6902:2208:b0:e82:b04f:4b5c with SMTP id 3f1490d57ef6-e842bc77943mr3889060276.5.1750430415240;
        Fri, 20 Jun 2025 07:40:15 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e842acb1fadsm663110276.50.2025.06.20.07.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 07:40:14 -0700 (PDT)
Date: Fri, 20 Jun 2025 10:40:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <685572ce376c8_164a2946a@willemb.c.googlers.com.notmuch>
In-Reply-To: <1c6ffd4bd0480ecc4c8442cef7c689fbfb5e0e56.1750176076.git.pabeni@redhat.com>
References: <cover.1750176076.git.pabeni@redhat.com>
 <1c6ffd4bd0480ecc4c8442cef7c689fbfb5e0e56.1750176076.git.pabeni@redhat.com>
Subject: Re: [PATCH v4 net-next 7/8] tun: enable gso over UDP tunnel support.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> Add new tun features to represent the newly introduced virtio
> GSO over UDP tunnel offload. Allows detection and selection of
> such features via the existing TUNSETOFFLOAD ioctl and compute
> the expected virtio header size and tunnel header offset using
> the current netdev features, so that we can plug almost seamless
> the newly introduced virtio helpers to serialize the extended
> virtio header.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v3 -> v4:
>   - virtio tnl-related fields are at fixed offset, cleanup
>     the code accordingly.
>   - use netdev features instead of flags bit to check for
>     the configured offload
>   - drop packet in case of enabled features/configured hdr
>     size mismatch
> 
> v2 -> v3:
>   - cleaned-up uAPI comments
>   - use explicit struct layout instead of raw buf.
> ---
>  drivers/net/tun.c           | 70 ++++++++++++++++++++++++-----
>  drivers/net/tun_vnet.h      | 88 +++++++++++++++++++++++++++++++++----
>  include/uapi/linux/if_tun.h |  9 ++++
>  3 files changed, 148 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index f8c5e2fd04df..bae0370a8152 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -186,7 +186,8 @@ struct tun_struct {
>  	struct net_device	*dev;
>  	netdev_features_t	set_features;
>  #define TUN_USER_FEATURES (NETIF_F_HW_CSUM|NETIF_F_TSO_ECN|NETIF_F_TSO| \
> -			  NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4)
> +			  NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4 | \
> +			  NETIF_F_GSO_UDP_TUNNEL | NETIF_F_GSO_UDP_TUNNEL_CSUM)
>  
>  	int			align;
>  	int			vnet_hdr_sz;
> @@ -925,6 +926,7 @@ static int tun_net_init(struct net_device *dev)
>  	dev->hw_features = NETIF_F_SG | NETIF_F_FRAGLIST |
>  			   TUN_USER_FEATURES | NETIF_F_HW_VLAN_CTAG_TX |
>  			   NETIF_F_HW_VLAN_STAG_TX;
> +	dev->hw_enc_features = dev->hw_features;
>  	dev->features = dev->hw_features;
>  	dev->vlan_features = dev->features &
>  			     ~(NETIF_F_HW_VLAN_CTAG_TX |
> @@ -1698,7 +1700,8 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  	struct sk_buff *skb;
>  	size_t total_len = iov_iter_count(from);
>  	size_t len = total_len, align = tun->align, linear;
> -	struct virtio_net_hdr gso = { 0 };
> +	struct virtio_net_hdr_v1_hash_tunnel hdr;

Not for this series.

But one day virtio will need a policy on how multiple optional
features can be composed, and simple APIs to get to those optional
headers. Perhaps something like skb extensions.

Now, each new extention means adding yet another struct and updating
all sites that access it.

A minimal rule may be that options can be entirely independent, but
if they exist at least their headers are always in a fixed order.
Which is already implied by the current extensions, i.e., hash comes
before tunnel if present.

> +	struct virtio_net_hdr *gso;
>  	int good_linear;
>  	int copylen;
>  	int hdr_len = 0;
> @@ -1708,6 +1711,15 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  	int skb_xdp = 1;
>  	bool frags = tun_napi_frags_enabled(tfile);
>  	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
> +	netdev_features_t features = 0;
> +
> +	/*
> +	 * Keep it easy and always zero the whole buffer, even if the
> +	 * tunnel-related field will be touched only when the feature
> +	 * is enabled and the hdr size id compatible.
> +	 */
> +	memset(&hdr, 0, sizeof(hdr));
> +	gso = (struct virtio_net_hdr *)&hdr;
>  
>  	if (!(tun->flags & IFF_NO_PI)) {
>  		if (len < sizeof(pi))
> @@ -1721,7 +1733,12 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  	if (tun->flags & IFF_VNET_HDR) {
>  		int vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
>  
> -		hdr_len = tun_vnet_hdr_get(vnet_hdr_sz, tun->flags, from, &gso);
> +		if (vnet_hdr_sz >= TUN_VNET_TNL_SIZE)
> +			features = NETIF_F_GSO_UDP_TUNNEL |
> +				   NETIF_F_GSO_UDP_TUNNEL_CSUM;

Maybe a helper virtio_net_has_opt_tunnel(), to encapsulate whatever
conditions have to be met. As those conditions are not obvious.

Especially if needed in multiple locations. Not sure if that is the
case here, I have not checked that.

> +
> +		hdr_len = __tun_vnet_hdr_get(vnet_hdr_sz, tun->flags,
> +					     features, from, gso);
>  		if (hdr_len < 0)
>  			return hdr_len;
>  
> @@ -1755,7 +1772,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  		 * (e.g gso or jumbo packet), we will do it at after
>  		 * skb was created with generic XDP routine.
>  		 */
> -		skb = tun_build_skb(tun, tfile, from, &gso, len, &skb_xdp);
> +		skb = tun_build_skb(tun, tfile, from, gso, len, &skb_xdp);
>  		err = PTR_ERR_OR_ZERO(skb);
>  		if (err)
>  			goto drop;
> @@ -1799,7 +1816,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  		}
>  	}
>  
> -	if (tun_vnet_hdr_to_skb(tun->flags, skb, &gso)) {
> +	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
>  		atomic_long_inc(&tun->rx_frame_errors);
>  		err = -EINVAL;
>  		goto free_skb;
> @@ -2050,13 +2067,21 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  	}
>  
>  	if (vnet_hdr_sz) {
> -		struct virtio_net_hdr gso;
> +		struct virtio_net_hdr_v1_hash_tunnel hdr;
> +		struct virtio_net_hdr *gso;
>  
> -		ret = tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, &gso);
> +		ret = tun_vnet_hdr_tnl_from_skb(tun->flags, tun->dev, skb,
> +						&hdr);
>  		if (ret)
>  			return ret;
>  
> -		ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
> +		/*
> +		 * Drop the packet if the configured header size is too small
> +		 * WRT the enabled offloads.
> +		 */
> +		gso = (struct virtio_net_hdr *)&hdr;
> +		ret = __tun_vnet_hdr_put(vnet_hdr_sz, tun->dev->features,
> +					 iter, gso);
>  		if (ret)
>  			return ret;
>  	}
> @@ -2357,7 +2382,9 @@ static int tun_xdp_one(struct tun_struct *tun,
>  {
>  	unsigned int datasize = xdp->data_end - xdp->data;
>  	struct tun_xdp_hdr *hdr = xdp->data_hard_start;
> +	struct virtio_net_hdr_v1_hash_tunnel *tnl_hdr;
>  	struct virtio_net_hdr *gso = &hdr->gso;
> +	netdev_features_t features = 0;
>  	struct bpf_prog *xdp_prog;
>  	struct sk_buff *skb = NULL;
>  	struct sk_buff_head *queue;
> @@ -2426,7 +2453,17 @@ static int tun_xdp_one(struct tun_struct *tun,
>  	if (metasize > 0)
>  		skb_metadata_set(skb, metasize);
>  
> -	if (tun_vnet_hdr_to_skb(tun->flags, skb, gso)) {
> +	/*
> +	 * Assume tunnel offloads are enabled if the received hdr is large
> +	 * enough.
> +	 */
> +	if (READ_ONCE(tun->vnet_hdr_sz) >= TUN_VNET_TNL_SIZE &&
> +	    xdp->data - xdp->data_hard_start >= TUN_VNET_TNL_SIZE)
> +		features = NETIF_F_GSO_UDP_TUNNEL |
> +			   NETIF_F_GSO_UDP_TUNNEL_CSUM;
> +
> +	tnl_hdr = (struct virtio_net_hdr_v1_hash_tunnel *)gso;
> +	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr)) {
>  		atomic_long_inc(&tun->rx_frame_errors);
>  		kfree_skb(skb);
>  		ret = -EINVAL;
> @@ -2812,6 +2849,8 @@ static void tun_get_iff(struct tun_struct *tun, struct ifreq *ifr)
>  
>  }
>  
> +#define PLAIN_GSO (NETIF_F_GSO_UDP_L4 | NETIF_F_TSO | NETIF_F_TSO6)
> +

Minor/subjective: prefer const unsigned int at function scope over untyped
file scope macros.

>  /* This is like a cut-down ethtool ops, except done via tun fd so no
>   * privs required. */
>  static int set_offload(struct tun_struct *tun, unsigned long arg)
> @@ -2841,6 +2880,18 @@ static int set_offload(struct tun_struct *tun, unsigned long arg)
>  			features |= NETIF_F_GSO_UDP_L4;
>  			arg &= ~(TUN_F_USO4 | TUN_F_USO6);
>  		}
> +
> +		/*
> +		 * Tunnel offload is allowed only if some plain offload is
> +		 * available, too.
> +		 */
> +		if (features & PLAIN_GSO && arg & TUN_F_UDP_TUNNEL_GSO) {
> +			features |= NETIF_F_GSO_UDP_TUNNEL;
> +			if (arg & TUN_F_UDP_TUNNEL_GSO_CSUM)
> +				features |= NETIF_F_GSO_UDP_TUNNEL_CSUM;
> +			arg &= ~(TUN_F_UDP_TUNNEL_GSO |
> +				 TUN_F_UDP_TUNNEL_GSO_CSUM);
> +		}
>  	}
>  
>  	/* This gives the user a way to test for new features in future by
> @@ -2852,7 +2903,6 @@ static int set_offload(struct tun_struct *tun, unsigned long arg)
>  	tun->dev->wanted_features &= ~TUN_USER_FEATURES;
>  	tun->dev->wanted_features |= features;
>  	netdev_update_features(tun->dev);
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index 58b9ac7a5fc4..7450fc153bb4 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -6,6 +6,8 @@
>  #define TUN_VNET_LE     0x80000000
>  #define TUN_VNET_BE     0x40000000
>  
> +#define TUN_VNET_TNL_SIZE	sizeof(struct virtio_net_hdr_v1_hash_tunnel)
> +
>  static inline bool tun_vnet_legacy_is_little_endian(unsigned int flags)
>  {
>  	bool be = IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
> @@ -107,16 +109,26 @@ static inline long tun_vnet_ioctl(int *vnet_hdr_sz, unsigned int *flags,
>  	}
>  }
>  
> -static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
> -				   struct iov_iter *from,
> -				   struct virtio_net_hdr *hdr)
> +static inline unsigned int tun_vnet_parse_size(netdev_features_t features)
> +{
> +	if (!(features & NETIF_F_GSO_UDP_TUNNEL))
> +		return sizeof(struct virtio_net_hdr);
> +
> +	return TUN_VNET_TNL_SIZE;
> +}
> +
> +static inline int __tun_vnet_hdr_get(int sz, unsigned int flags,
> +				     netdev_features_t features,
> +				     struct iov_iter *from,
> +				     struct virtio_net_hdr *hdr)
>  {
> +	unsigned int parsed_size = tun_vnet_parse_size(features);
>  	u16 hdr_len;
>  
>  	if (iov_iter_count(from) < sz)
>  		return -EINVAL;
>  
> -	if (!copy_from_iter_full(hdr, sizeof(*hdr), from))
> +	if (!copy_from_iter_full(hdr, parsed_size, from))
>  		return -EFAULT;
>  
>  	hdr_len = tun_vnet16_to_cpu(flags, hdr->hdr_len);
> @@ -129,32 +141,59 @@ static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
>  	if (hdr_len > iov_iter_count(from))
>  		return -EINVAL;
>  
> -	iov_iter_advance(from, sz - sizeof(*hdr));
> +	iov_iter_advance(from, sz - parsed_size);
>  
>  	return hdr_len;
>  }
>  
> -static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
> -				   const struct virtio_net_hdr *hdr)
> +static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
> +				   struct iov_iter *from,
> +				   struct virtio_net_hdr *hdr)
> +{
> +	return __tun_vnet_hdr_get(sz, flags, 0, from, hdr);
> +}
> +
> +static inline int __tun_vnet_hdr_put(int sz, netdev_features_t features,
> +				     struct iov_iter *iter,
> +				     const struct virtio_net_hdr *hdr)
>  {
> +	unsigned int parsed_size = tun_vnet_parse_size(features);
> +
>  	if (unlikely(iov_iter_count(iter) < sz))
>  		return -EINVAL;
>  
> -	if (unlikely(copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr)))
> +	if (unlikely(copy_to_iter(hdr, parsed_size, iter) != parsed_size))
>  		return -EFAULT;
>  
> -	if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
> +	if (iov_iter_zero(sz - parsed_size, iter) != sz - parsed_size)
>  		return -EFAULT;
>  
>  	return 0;
>  }
>  
> +static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
> +				   const struct virtio_net_hdr *hdr)
> +{
> +	return __tun_vnet_hdr_put(sz, 0, iter, hdr);
> +}
> +
>  static inline int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
>  				      const struct virtio_net_hdr *hdr)
>  {
>  	return virtio_net_hdr_to_skb(skb, hdr, tun_vnet_is_little_endian(flags));
>  }
>  
> +static inline int
> +tun_vnet_hdr_tnl_to_skb(unsigned int flags, netdev_features_t features,
> +			struct sk_buff *skb,
> +			const struct virtio_net_hdr_v1_hash_tunnel *hdr)
> +{
> +	return virtio_net_hdr_tnl_to_skb(skb, hdr,
> +					 !!(features & NETIF_F_GSO_UDP_TUNNEL),
> +					 !!(features & NETIF_F_GSO_UDP_TUNNEL_CSUM),

Double exclamation points not needed. Compiler does the right thing
when arguments are of type bool.

> +					 tun_vnet_is_little_endian(flags));
> +}
> +
>  static inline int tun_vnet_hdr_from_skb(unsigned int flags,
>  					const struct net_device *dev,
>  					const struct sk_buff *skb,
> @@ -183,4 +222,35 @@ static inline int tun_vnet_hdr_from_skb(unsigned int flags,
>  	return 0;
>  }
>  
> +static inline int
> +tun_vnet_hdr_tnl_from_skb(unsigned int flags,
> +			  const struct net_device *dev,
> +			  const struct sk_buff *skb,
> +			  struct virtio_net_hdr_v1_hash_tunnel *tnl_hdr)
> +{
> +	bool has_tnl_offload = !!(dev->features & NETIF_F_GSO_UDP_TUNNEL);
> +	int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
> +
> +	if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
> +					tun_vnet_is_little_endian(flags),
> +					vlan_hlen)) {
> +		struct virtio_net_hdr_v1 *hdr = &tnl_hdr->hash_hdr.hdr;
> +		struct skb_shared_info *sinfo = skb_shinfo(skb);
> +
> +		if (net_ratelimit()) {
> +			netdev_err(dev, "unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
> +				   sinfo->gso_type, tun_vnet16_to_cpu(flags, hdr->gso_size),
> +				   tun_vnet16_to_cpu(flags, hdr->hdr_len));
> +			print_hex_dump(KERN_ERR, "tun: ",
> +				       DUMP_PREFIX_NONE,
> +				       16, 1, skb->head,
> +				       min(tun_vnet16_to_cpu(flags, hdr->hdr_len), 64), true);
> +		}
> +		WARN_ON_ONCE(1);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  #endif /* TUN_VNET_H */
> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
> index 287cdc81c939..79d53c7a1ebd 100644
> --- a/include/uapi/linux/if_tun.h
> +++ b/include/uapi/linux/if_tun.h
> @@ -93,6 +93,15 @@
>  #define TUN_F_USO4	0x20	/* I can handle USO for IPv4 packets */
>  #define TUN_F_USO6	0x40	/* I can handle USO for IPv6 packets */
>  
> +/* I can handle TSO/USO for UDP tunneled packets */
> +#define TUN_F_UDP_TUNNEL_GSO		0x080
> +
> +/*
> + * I can handle TSO/USO for UDP tunneled packets requiring csum offload for
> + * the outer header
> + */
> +#define TUN_F_UDP_TUNNEL_GSO_CSUM	0x100
> +
>  /* Protocol info prepended to the packets (when IFF_NO_PI is not set) */
>  #define TUN_PKT_STRIP	0x0001
>  struct tun_pi {
> -- 
> 2.49.0
> 



