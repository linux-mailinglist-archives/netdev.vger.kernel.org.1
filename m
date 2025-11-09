Return-Path: <netdev+bounces-237089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC04C447D5
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 22:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B14F18897DC
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 21:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E14238166;
	Sun,  9 Nov 2025 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDzG6XDT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPw7pW7u"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E971A0BD6
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762724280; cv=none; b=J9egcb879+TSr7IRK8Jk4SAi4REr5SogSp56KLc1luH6evt5J8fCLhW/+Mr+uZL5gbBYgtuQ14ES82u77+VMaFX56K/g7HZvuW5Te21xLtHIt0FClRzRnIwf3TO5wwt+1zzbRzeCP5qS1cNfeki5EHfhRUeHCMvwYdGT8SiDYvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762724280; c=relaxed/simple;
	bh=DIzUN1s4DEuSCXVSJ04xr/mRIfhhQkl1RR8veyzoBXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRPIBYy6QYrzPVCcerR6xOueBCIEfRliwEX2fLWJq25SkLoM5M/z0nJwgSwbqpMaSpOQZfTUGMcsm8oA1LG/g85bZAYU3NB0ra16WEyIQRwyYai4K1985Ct1UM0hm+MDeQhnrsh0/7f9+uN4zUdCANQJ0NrTgjlQrs/nThIv8wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MDzG6XDT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HPw7pW7u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762724277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xvyjmhDZgnpP4TOu14SeMoSyT/sv3kAnEbdVl0JxBi4=;
	b=MDzG6XDTmEw57mCw+646QNFD42SN2taAVFOoqYEx0Knxu9VzjeEBE5dZXIyvcxV7DQuf7A
	QSrqQuZUTTITSKwEf9uq9x97nbr3NQ6BZ+DW7K1tfkjTuCKQvHs3SkcsDK/lia3VPMPUaB
	3Z2wYUJvP7lEW1gmbAKCDTMneXDBbaI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-0pBWXalqN8SaHPVnWYT9Wg-1; Sun, 09 Nov 2025 16:37:56 -0500
X-MC-Unique: 0pBWXalqN8SaHPVnWYT9Wg-1
X-Mimecast-MFC-AGG-ID: 0pBWXalqN8SaHPVnWYT9Wg_1762724275
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4777b03b90fso2382815e9.1
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 13:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762724275; x=1763329075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xvyjmhDZgnpP4TOu14SeMoSyT/sv3kAnEbdVl0JxBi4=;
        b=HPw7pW7uSAPitgA7MwjsweuywC4tEQRSPaAEzqqR35yZL4p6oJnRstvYiJIr3pAup8
         Dbq9SUwQplMqN07KIDT8wvsxQ0/E4gIznlEyb3XVRRmFBnyL2YzwvsuyZWYMskkE4gBY
         tbeNjZrJOsoZAuLoRFllX5vrSrFCv1IW5hNhzFZVtB4nFkFiWLWvyuSNT3t/Dp3zSe+A
         8mmdEKotqHgCir79PdUzxb2YpuKf/tYC0vbUqlRv//o1QWxuWcI5oF5icoe8rty6sZ4V
         E0l2DrOG8jp6WDZxmpy7tV4XYA5y8fpw9ngrEIYTwdOSGGHfGaAdWAGOZ/0YaWqjKWFP
         xZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762724275; x=1763329075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvyjmhDZgnpP4TOu14SeMoSyT/sv3kAnEbdVl0JxBi4=;
        b=RwIu3Nx7Bgb1vUZE1vy0bYhgqaRwkUcU7R1I6uBeWsVmEaOHilwRizIGMLkrcfu+gh
         yRmbsIgrEzVo+lQb3aHVG7SoPsv/o12xdQ+g+CiTwOMh+XcNjbm6LTqacTKNw7s1t3e+
         JZi95Gl3hf763bkpIqisXIS4L7QYmutKXSvTVMN//hTMrnvU6sAY1GjEHmsPrRK82Ql7
         4MaDpEWh2qz5gj8sNm0L35nm4NeW2NdWrrsssAqP9bw76N85BjxETTExgcbXwiSDZFK6
         fXLBw4GDtuKdGhWnj+OjcFVxKihZ+P3nwq5iOFlgRI55Ot1nrLdM7R2kSF9z919eTQ+s
         BI1w==
X-Gm-Message-State: AOJu0Yxqiur5uRp8rLVPPV/0V3p5I0t5gRQs4vYFglRTb6gW9dAsYxHH
	RXbsGaqJw08BBAoEq5uuX2pCWkeGr+gf27tawjy1gsvfj/Ez+PbXEDbPmWdbA2rn9+XpVEIfWpL
	4enybbnLSsxfYVOrgdGH9vxERdBdCFO6cg5mgDF1lptoazqCul7geewia5w==
X-Gm-Gg: ASbGnctuToz2cClC7kIvZleeFaLOGO2QsfufEJGepa3ofq8RgKYv4PR1MLr8SEMRJ8R
	9gsvEiWn3Ys0pOp7o4NbcM1Nd1TaNrHddi2oMQl7HXtrhhQ/4J1OFwmEoE+D++TtnbvhVysp8LU
	unQNL67fj0VHEtWycoJe3nYQE8zj2a2kn5dXYHlFl7O8/fcqWLh+fneFXxJmCAg9kNVA7jrjsC/
	hly8RFA3xii/ZgHgNFAWWVHJROubZyb8CpNb3Ryh8GTyi64XOqO2/RSHewMKYlapvMxpLmsngHo
	8LDr0csBriLjfd8oIsb9kDTIYyjtSjaQ+YMkoVpKaI6TbaRigybck8zja+QmQQcEujM=
X-Received: by 2002:a05:600c:46d5:b0:477:4345:7c5c with SMTP id 5b1f17b1804b1-47773297851mr52784205e9.38.1762724275287;
        Sun, 09 Nov 2025 13:37:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0U/SG3m1x4dqg/u2TGOQBny95vM3jKF8Mmr9odg5lF81Z80qmr88J50kweLcG41uASeevvA==
X-Received: by 2002:a05:600c:46d5:b0:477:4345:7c5c with SMTP id 5b1f17b1804b1-47773297851mr52784095e9.38.1762724274820;
        Sun, 09 Nov 2025 13:37:54 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce20ff3sm282270195e9.10.2025.11.09.13.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 13:37:53 -0800 (PST)
Date: Sun, 9 Nov 2025 16:37:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heng Qi <hengqi@linux.alibaba.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v4 2/4] virtio-net: Ensure hdr_len is not set unless
 the header is forwarded to the device.
Message-ID: <20251109163644-mutt-send-email-mst@kernel.org>
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
 <20251029030913.20423-3-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029030913.20423-3-xuanzhuo@linux.alibaba.com>

On Wed, Oct 29, 2025 at 11:09:11AM +0800, Xuan Zhuo wrote:
> Although `virtio_net_hdr_from_skb` is used in several places outside of
> `virtio-net.c`, the `hdr_len` field is only utilized by the device
> according to the specification. Therefore, we do not need to set
> `hdr_len` unless the header is actually passed to the device.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

maybe ...  but what is this patch trying to achieve?
it does not seem harmful to set it ...


> ---
>  include/linux/virtio_net.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 4d1780848d0e..710ae0d2d336 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -218,9 +218,14 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>  	if (skb_is_gso(skb)) {
>  		struct skb_shared_info *sinfo = skb_shinfo(skb);
>  
> -		/* This is a hint as to how much should be linear. */
> -		hdr->hdr_len = __cpu_to_virtio16(little_endian,
> -						 skb_headlen(skb));
> +		/* In certain code paths (such as the af_packet.c receive path),
> +		 * this function may be called without a transport header.
> +		 * In this case, we do not need to set the hdr_len.
> +		 */
> +		if (skb_transport_header_was_set(skb))
> +			hdr->hdr_len = __cpu_to_virtio16(little_endian,
> +							 skb_headlen(skb));
> +
>  		hdr->gso_size = __cpu_to_virtio16(little_endian,
>  						  sinfo->gso_size);
>  		if (sinfo->gso_type & SKB_GSO_TCPV4)
> -- 
> 2.32.0.3.g01195cf9f


