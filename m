Return-Path: <netdev+bounces-199504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCD4AE08FB
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 16:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2F6E5A3E26
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54894226D17;
	Thu, 19 Jun 2025 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Wdh0T2VY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EDB223DC6
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344172; cv=none; b=UxN5W3h6uWMfVPzPjd9SAmyv8lKPNjl8ybccaZ5zzbZqiFGkJeo8aGRxdbdKBCOVovsXJ93NkxLqYTyFU2+mYQBYEYOn1ebsjbn8vi/BEV/1hkM32YxIGHSgqYNvDXhOSs2hqrXhIgJ/F3Qf7kcI4U6IVCjV6cp1Ml7gxDhf6SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344172; c=relaxed/simple;
	bh=wtSD6dSBAcN1LnfLg//tt07sRzJRnvoP7e/QM8dKSO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aaMMkGkQEBh3jclGAgcUQolnOkr9lCKd30YO2ZffVWhB2zxm/fsFd6bEYR4NSiP7yAVN6QCWZh00X7OxHP00JBxT1YPVTVwaNUqs1qHL19BMJoDq0LTCFYpDDbdTq1EwXDbFkuEYBmQZ9cBMswvHgp40sB1TRlZHDZE00R5Bf4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=Wdh0T2VY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234f17910d8so8268645ad.3
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 07:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1750344169; x=1750948969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V8iGGm8ffOx5o57Uc4RE9MQlh1TQvtv5GWB5EzIE+Pw=;
        b=Wdh0T2VYY1nkao1kS28Taz41ZzwSI5OZXYbjTH7dTEkCFLiPWgx8TsK8xw4jeT37AH
         2gdKBIHvRDuspNAKXFvQEaQb5GM/AhctG46rCtcmgRcVE4k8OdRjolXmtXCdqmiYJ6Gu
         se5nHveOUbIImOmOIWWn/DOgaS3kfQ+X7mXbOLC4P4UWNLUIQbaGWxe/O7V6EP/Esar0
         CPisYyw+Wpfv/tz9p5n9Tusyj/RPiCghEH5yoD4+LxxB752cRKZ3yyxo/UUbHNqj2qGX
         llccs4AHc1Ok0UIaHAJPgzZjM8LZ2c7CI/b7fWWZB5dcd1Fa/5Xh+Max4o8Fnpjk8FUa
         7khA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750344169; x=1750948969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V8iGGm8ffOx5o57Uc4RE9MQlh1TQvtv5GWB5EzIE+Pw=;
        b=IHv5jCZutEvoNGs+2ilA/OFL7QAIik+DLaEbi7RqeSQA3XnPfDM6xKKggzHrGF2lpd
         udKNYbZXrLkyljN14dwpatTW27x+Zj3pZaDy6WfhM+lnjts0olqIqrt+G1Vk3mDxG1ne
         JJMmrBpALb1Laad7YfazpkdNnTPMqXGGGoJ8jI2jxLhf9ABVtX1y0wSxBWZNhgXKuwXs
         q3+I2YheZzqJU27ax/mkxniBrhROqBvxVf4TbmZRqUu3mFjNefYdvIfpNCYwZXc+puHM
         +7pXZRA/VnNPxVnxp6IKfIEYFzMkl0I6fytml1pFvLjnSpaN00wFkCn3M23kVPxd4FVh
         X+RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVryydltJPflPj8AMDnkVistyR2nHe9HI4ujEe7RwSEeTHojO1+6HbizmGE5b9mILVzzYwgj9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxNzMzJ4lrwnqI9Fhp5nIryxfr4G5djNv6ZQqlGaEl7feIqCBW
	k4e1P+TUK4KECYJjysxcysVdJrFNLFHJ1OOJR3LrOKzz7m5lpYweHhjRrSD865Alg7o=
X-Gm-Gg: ASbGncv5199xYgGVcjniPbAFuOoI8r9+Ka8caY/oZw9nMso1rnNia+gx3bu509uSEDN
	BaIGCF/v/ahST72SSXtEQyQeon429dMNxf7ZqaLBvMkX7golcnzlB3VN0eiHklo88EE9KXtto+i
	cvkLMur5tT3WxKCCDCo0Oafhg6O6csqLITNFKCLRDwPj2QbNLtFxB7n++1Nh2C3LuJou7cAFDiL
	Bporx0LCYkiWm5VLKBxNFeTwdnDkzJHQ48diEL/9H/YCOqq8XNK/79TXOroAn8pcolw8w8xksII
	JuoD1HxHe80oiuX0aCJMeJnINEO790lxibLHkLM4YfK/fxj5PJbeH9A7ZISLcur4YXK4Arh8Yjo
	=
X-Google-Smtp-Source: AGHT+IGr+gIpoKJD6b8lcl9A8oNZc5M03gfZgsf2RD7m8Jq+eHo1C4qX5ljLDO1otc/IdkvVwGd3sw==
X-Received: by 2002:a17:903:2ace:b0:234:9068:ed99 with SMTP id d9443c01a7336-2366b14d37amr358772165ad.24.1750344169164;
        Thu, 19 Jun 2025 07:42:49 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deca344sm120790745ad.203.2025.06.19.07.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 07:42:48 -0700 (PDT)
Message-ID: <6505a764-a3d2-4c98-b2b3-acc2bb7b1aae@daynix.com>
Date: Thu, 19 Jun 2025 23:42:44 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 7/8] tun: enable gso over UDP tunnel support.
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>
References: <cover.1750176076.git.pabeni@redhat.com>
 <1c6ffd4bd0480ecc4c8442cef7c689fbfb5e0e56.1750176076.git.pabeni@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <1c6ffd4bd0480ecc4c8442cef7c689fbfb5e0e56.1750176076.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/06/18 1:12, Paolo Abeni wrote:
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
>    - virtio tnl-related fields are at fixed offset, cleanup
>      the code accordingly.
>    - use netdev features instead of flags bit to check for
>      the configured offload
>    - drop packet in case of enabled features/configured hdr
>      size mismatch
> 
> v2 -> v3:
>    - cleaned-up uAPI comments
>    - use explicit struct layout instead of raw buf.
> ---
>   drivers/net/tun.c           | 70 ++++++++++++++++++++++++-----
>   drivers/net/tun_vnet.h      | 88 +++++++++++++++++++++++++++++++++----
>   include/uapi/linux/if_tun.h |  9 ++++
>   3 files changed, 148 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index f8c5e2fd04df..bae0370a8152 100644
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
> +	struct virtio_net_hdr_v1_hash_tunnel hdr;
> +	struct virtio_net_hdr *gso;
>   	int good_linear;
>   	int copylen;
>   	int hdr_len = 0;
> @@ -1708,6 +1711,15 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>   	int skb_xdp = 1;
>   	bool frags = tun_napi_frags_enabled(tfile);
>   	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
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
>   	if (!(tun->flags & IFF_NO_PI)) {
>   		if (len < sizeof(pi))
> @@ -1721,7 +1733,12 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>   	if (tun->flags & IFF_VNET_HDR) {
>   		int vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
>   
> -		hdr_len = tun_vnet_hdr_get(vnet_hdr_sz, tun->flags, from, &gso);
> +		if (vnet_hdr_sz >= TUN_VNET_TNL_SIZE)
> +			features = NETIF_F_GSO_UDP_TUNNEL |
> +				   NETIF_F_GSO_UDP_TUNNEL_CSUM;

I think you should use tun->set_features instead of tun->vnet_hdr_sz to 
tell if these features are enabled.

> +
> +		hdr_len = __tun_vnet_hdr_get(vnet_hdr_sz, tun->flags,
> +					     features, from, gso);
>   		if (hdr_len < 0)
>   			return hdr_len;
>   
> @@ -1755,7 +1772,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>   		 * (e.g gso or jumbo packet), we will do it at after
>   		 * skb was created with generic XDP routine.
>   		 */
> -		skb = tun_build_skb(tun, tfile, from, &gso, len, &skb_xdp);
> +		skb = tun_build_skb(tun, tfile, from, gso, len, &skb_xdp);
>   		err = PTR_ERR_OR_ZERO(skb);
>   		if (err)
>   			goto drop;
> @@ -1799,7 +1816,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>   		}
>   	}
>   
> -	if (tun_vnet_hdr_to_skb(tun->flags, skb, &gso)) {
> +	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
>   		atomic_long_inc(&tun->rx_frame_errors);
>   		err = -EINVAL;
>   		goto free_skb;
> @@ -2050,13 +2067,21 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>   	}
>   
>   	if (vnet_hdr_sz) {
> -		struct virtio_net_hdr gso;
> +		struct virtio_net_hdr_v1_hash_tunnel hdr;
> +		struct virtio_net_hdr *gso;
>   
> -		ret = tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, &gso);
> +		ret = tun_vnet_hdr_tnl_from_skb(tun->flags, tun->dev, skb,
> +						&hdr);
>   		if (ret)
>   			return ret;
>   
> -		ret = tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
> +		/*
> +		 * Drop the packet if the configured header size is too small
> +		 * WRT the enabled offloads.
> +		 */
> +		gso = (struct virtio_net_hdr *)&hdr;
> +		ret = __tun_vnet_hdr_put(vnet_hdr_sz, tun->dev->features,
> +					 iter, gso);
>   		if (ret)
>   			return ret;
>   	}
> @@ -2357,7 +2382,9 @@ static int tun_xdp_one(struct tun_struct *tun,
>   {
>   	unsigned int datasize = xdp->data_end - xdp->data;
>   	struct tun_xdp_hdr *hdr = xdp->data_hard_start;
> +	struct virtio_net_hdr_v1_hash_tunnel *tnl_hdr;
>   	struct virtio_net_hdr *gso = &hdr->gso;
> +	netdev_features_t features = 0;
>   	struct bpf_prog *xdp_prog;
>   	struct sk_buff *skb = NULL;
>   	struct sk_buff_head *queue;
> @@ -2426,7 +2453,17 @@ static int tun_xdp_one(struct tun_struct *tun,
>   	if (metasize > 0)
>   		skb_metadata_set(skb, metasize);
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
>   		atomic_long_inc(&tun->rx_frame_errors);
>   		kfree_skb(skb);
>   		ret = -EINVAL;
> @@ -2812,6 +2849,8 @@ static void tun_get_iff(struct tun_struct *tun, struct ifreq *ifr)
>   
>   }
>   
> +#define PLAIN_GSO (NETIF_F_GSO_UDP_L4 | NETIF_F_TSO | NETIF_F_TSO6)
> +
>   /* This is like a cut-down ethtool ops, except done via tun fd so no
>    * privs required. */
>   static int set_offload(struct tun_struct *tun, unsigned long arg)
> @@ -2841,6 +2880,18 @@ static int set_offload(struct tun_struct *tun, unsigned long arg)
>   			features |= NETIF_F_GSO_UDP_L4;
>   			arg &= ~(TUN_F_USO4 | TUN_F_USO6);
>   		}
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
>   	}
>   
>   	/* This gives the user a way to test for new features in future by
> @@ -2852,7 +2903,6 @@ static int set_offload(struct tun_struct *tun, unsigned long arg)
>   	tun->dev->wanted_features &= ~TUN_USER_FEATURES;
>   	tun->dev->wanted_features |= features;
>   	netdev_update_features(tun->dev);
> -

This line deletion is irrlevant.

>   	return 0;
>   }
>   
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index 58b9ac7a5fc4..7450fc153bb4 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -6,6 +6,8 @@
>   #define TUN_VNET_LE     0x80000000
>   #define TUN_VNET_BE     0x40000000
>   
> +#define TUN_VNET_TNL_SIZE	sizeof(struct virtio_net_hdr_v1_hash_tunnel)
> +
>   static inline bool tun_vnet_legacy_is_little_endian(unsigned int flags)
>   {
>   	bool be = IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
> @@ -107,16 +109,26 @@ static inline long tun_vnet_ioctl(int *vnet_hdr_sz, unsigned int *flags,
>   	}
>   }
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
>   {
> +	unsigned int parsed_size = tun_vnet_parse_size(features);
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
> @@ -129,32 +141,59 @@ static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
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
> +	return __tun_vnet_hdr_get(sz, flags, 0, from, hdr);
> +}
> +
> +static inline int __tun_vnet_hdr_put(int sz, netdev_features_t features,
> +				     struct iov_iter *iter,
> +				     const struct virtio_net_hdr *hdr)
>   {
> +	unsigned int parsed_size = tun_vnet_parse_size(features);
> +
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
> +	return __tun_vnet_hdr_put(sz, 0, iter, hdr);
> +}
> +
>   static inline int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
>   				      const struct virtio_net_hdr *hdr)
>   {
>   	return virtio_net_hdr_to_skb(skb, hdr, tun_vnet_is_little_endian(flags));
>   }
>   
> +static inline int
> +tun_vnet_hdr_tnl_to_skb(unsigned int flags, netdev_features_t features,
> +			struct sk_buff *skb,
> +			const struct virtio_net_hdr_v1_hash_tunnel *hdr)
> +{
> +	return virtio_net_hdr_tnl_to_skb(skb, hdr,
> +					 !!(features & NETIF_F_GSO_UDP_TUNNEL),
> +					 !!(features & NETIF_F_GSO_UDP_TUNNEL_CSUM),
> +					 tun_vnet_is_little_endian(flags));
> +}
> +
>   static inline int tun_vnet_hdr_from_skb(unsigned int flags,
>   					const struct net_device *dev,
>   					const struct sk_buff *skb,
> @@ -183,4 +222,35 @@ static inline int tun_vnet_hdr_from_skb(unsigned int flags,
>   	return 0;
>   }
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
>   #endif /* TUN_VNET_H */
> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
> index 287cdc81c939..79d53c7a1ebd 100644
> --- a/include/uapi/linux/if_tun.h
> +++ b/include/uapi/linux/if_tun.h
> @@ -93,6 +93,15 @@
>   #define TUN_F_USO4	0x20	/* I can handle USO for IPv4 packets */
>   #define TUN_F_USO6	0x40	/* I can handle USO for IPv6 packets */
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
>   /* Protocol info prepended to the packets (when IFF_NO_PI is not set) */
>   #define TUN_PKT_STRIP	0x0001
>   struct tun_pi {


