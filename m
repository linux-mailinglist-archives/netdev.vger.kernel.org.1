Return-Path: <netdev+bounces-82741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC0B88F8A4
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 08:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24F21C23193
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 07:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709924086A;
	Thu, 28 Mar 2024 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFEApc/Q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8AE13ACC
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 07:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711610838; cv=none; b=XZHE3DBepFdE2otT2NKzVSeMJz6wyQtoQisieDUHxum0Ctd5cafkJuFyAyWT+njBrF2ewX3/MYF/IV/xPjSzsZsFAXbrrBSftZaP/BTcX3lxYn6Bn0xBgNvUA3c2AYs6/BwZhaZAd4S7vXH7LLRbQqJpikiGfN+41++kSXtGV50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711610838; c=relaxed/simple;
	bh=FGOCHa3EhFa3HIyJ/PFKeDbO5GhEkKXAXND/mfhQ5pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=td8rc26nHtQztDpwzsK0z06ZhpAiJRKQkh6QGbLkAtc7yoUCiGzeL/DoeZ5HHJkDxSferymy+81tT2HU++cCQBHlJ2tczaQhry3fay8UKoaCHKPXyJL7ab6YYDfcqfg/4kllnioHrdMZNMdaMi0U/SOS6I58wHSp7PCdgCTNHUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WFEApc/Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711610835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KJsf2Zq8ihabw+fkEvplCz/+JnMA4uyfwf4KQrKrSy0=;
	b=WFEApc/QF+lrZTKsA79FaVeZETqRaLGYNxJi0FadEMCquqAFxfBv2orXP9Lkm3xly3eUDp
	Tzdn+TX/VCZa5YFaCsoXOPt/w7b2XRZZ8n+WUh2gCzwkzulANPdDyyg2197jXZIfnGjuDj
	UNZhNMDE6BWfC88Vhtxv2SOKHwKZ8dA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-BzKpjRoJNJ2dkLxFTJ1fbA-1; Thu, 28 Mar 2024 03:27:11 -0400
X-MC-Unique: BzKpjRoJNJ2dkLxFTJ1fbA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5158a57abd4so417232e87.3
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 00:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711610829; x=1712215629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJsf2Zq8ihabw+fkEvplCz/+JnMA4uyfwf4KQrKrSy0=;
        b=Anqli48L+K5l4gSFBm3nNu8++ZrPdrZ0fCvmHz03QnAef2N41pUnzBUyoo60hlnvFt
         L+ec9Pwg8CWnY3+WB1Yi7ZN8fRhN/Ig2p9KDkFz0huzAW7/st0XVPaRkpobyQICn8ndV
         yAc7a3CUBFvPI8tJcgd7PelfHjw/gXgkZ2z9jyylsWNikDD50XwOewqUEPEW6IbrQi9U
         +Q83pK07ehvViGrw/JGbm7xktLfIIi5QRTS8w/l+s0+mTLbk5Amg21LBNd8EfjvwMNPl
         D+cQMh5IhoQT+uBUa+bPgG8Orxg69uRbFcbZ1hjRi+57X6n48NERxoTkIGflGLzkBe+K
         SjdQ==
X-Gm-Message-State: AOJu0Yx+puUr1CB8yEMs2O7t9D5VjQ2nSNvGduyu4CCh8Rol9Yik3Aja
	uhbIxVqNE2b9WEhIcR+PtKMp1uUhaiDwfy0TiQJxmwDZf43hZQdZ++p7twVM+VdlDrSfkYE6x9j
	oqDe6t31DCzFbF6Ga3VUqLWjmJst4+sQ0OaJx41pjZGddhUxfCOxX/w==
X-Received: by 2002:ac2:47e3:0:b0:515:ad59:d46a with SMTP id b3-20020ac247e3000000b00515ad59d46amr1337981lfp.21.1711610829524;
        Thu, 28 Mar 2024 00:27:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfVqZFjbVnnpCY1gucIL320hz2IsqZ+CfIoaRXCeWu7IcUMtHjxAZk3eLcHOqKKTNkP6JiMg==
X-Received: by 2002:ac2:47e3:0:b0:515:ad59:d46a with SMTP id b3-20020ac247e3000000b00515ad59d46amr1337963lfp.21.1711610828980;
        Thu, 28 Mar 2024 00:27:08 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:5969:7af8:be53:dc56:3ccc])
        by smtp.gmail.com with ESMTPSA id d23-20020a50fb17000000b0056c051e59bfsm501076edq.9.2024.03.28.00.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 00:27:08 -0700 (PDT)
Date: Thu, 28 Mar 2024 03:27:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 2/2] virtio-net: support dim profile
 fine-tuning
Message-ID: <20240328032636-mutt-send-email-mst@kernel.org>
References: <1711531146-91920-1-git-send-email-hengqi@linux.alibaba.com>
 <1711531146-91920-3-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711531146-91920-3-git-send-email-hengqi@linux.alibaba.com>

On Wed, Mar 27, 2024 at 05:19:06PM +0800, Heng Qi wrote:
> Virtio-net has different types of back-end device
> implementations. In order to effectively optimize
> the dim library's gains for different device
> implementations, let's use the new interface params
> to fine-tune the profile list.
> 
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e709d44..9b6c727 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -57,6 +57,16 @@
>  
>  #define VIRTNET_DRIVER_VERSION "1.0.0"
>  
> +/* This is copied from NET_DIM_RX_EQE_PROFILES in DIM library */

So maybe move it to a header and reuse?


> +#define VIRTNET_DIM_RX_PKTS 256
> +static struct dim_cq_moder rx_eqe_conf[] = {
> +	{.usec = 1,   .pkts = VIRTNET_DIM_RX_PKTS,},
> +	{.usec = 8,   .pkts = VIRTNET_DIM_RX_PKTS,},
> +	{.usec = 64,  .pkts = VIRTNET_DIM_RX_PKTS,},
> +	{.usec = 128, .pkts = VIRTNET_DIM_RX_PKTS,},
> +	{.usec = 256, .pkts = VIRTNET_DIM_RX_PKTS,}
> +};
> +
>  static const unsigned long guest_offloads[] = {
>  	VIRTIO_NET_F_GUEST_TSO4,
>  	VIRTIO_NET_F_GUEST_TSO6,
> @@ -3584,7 +3594,10 @@ static void virtnet_rx_dim_work(struct work_struct *work)
>  		if (!rq->dim_enabled)
>  			continue;
>  
> -		update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
> +		if (dim->profile_ix >= ARRAY_SIZE(rx_eqe_conf))
> +			dim->profile_ix = ARRAY_SIZE(rx_eqe_conf) - 1;
> +
> +		update_moder = rx_eqe_conf[dim->profile_ix];
>  		if (update_moder.usec != rq->intr_coal.max_usecs ||
>  		    update_moder.pkts != rq->intr_coal.max_packets) {
>  			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
> @@ -3627,6 +3640,34 @@ static int virtnet_should_update_vq_weight(int dev_flags, int weight,
>  	return 0;
>  }
>  
> +static int virtnet_update_profile(struct virtnet_info *vi,
> +				  struct kernel_ethtool_coalesce *kc)
> +{
> +	int i;
> +
> +	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
> +		for (i = 0; i < NET_DIM_PARAMS_NUM_PROFILES; i++)
> +			if (kc->rx_eqe_profs[i].comps)
> +				return -EINVAL;
> +	} else {
> +		for (i = 0; i < NET_DIM_PARAMS_NUM_PROFILES; i++) {
> +			if (kc->rx_eqe_profs[i].usec != rx_eqe_conf[i].usec ||
> +			    kc->rx_eqe_profs[i].pkts != rx_eqe_conf[i].pkts ||
> +			    kc->rx_eqe_profs[i].comps)
> +				return -EINVAL;
> +		}
> +
> +		return 0;
> +	}
> +
> +	for (i = 0; i < NET_DIM_PARAMS_NUM_PROFILES; i++) {
> +		rx_eqe_conf[i].usec = kc->rx_eqe_profs[i].usec;
> +		rx_eqe_conf[i].pkts = kc->rx_eqe_profs[i].pkts;
> +	}
> +
> +	return 0;
> +}
> +
>  static int virtnet_set_coalesce(struct net_device *dev,
>  				struct ethtool_coalesce *ec,
>  				struct kernel_ethtool_coalesce *kernel_coal,
> @@ -3653,6 +3694,10 @@ static int virtnet_set_coalesce(struct net_device *dev,
>  		}
>  	}
>  
> +	ret = virtnet_update_profile(vi, kernel_coal);
> +	if (ret)
> +		return ret;
> +
>  	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL))
>  		ret = virtnet_send_notf_coal_cmds(vi, ec);
>  	else
> @@ -3689,6 +3734,10 @@ static int virtnet_get_coalesce(struct net_device *dev,
>  			ec->tx_max_coalesced_frames = 1;
>  	}
>  
> +	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> +		memcpy(kernel_coal->rx_eqe_profs, rx_eqe_conf,
> +		       sizeof(rx_eqe_conf));
> +
>  	return 0;
>  }
>  
> @@ -3868,7 +3917,8 @@ static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
>  
>  static const struct ethtool_ops virtnet_ethtool_ops = {
>  	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
> -		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
> +		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
> +		ETHTOOL_COALESCE_RX_EQE_PROFILE,
>  	.get_drvinfo = virtnet_get_drvinfo,
>  	.get_link = ethtool_op_get_link,
>  	.get_ringparam = virtnet_get_ringparam,
> -- 
> 1.8.3.1


