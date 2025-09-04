Return-Path: <netdev+bounces-220133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11493B44898
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 23:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0140AA11D7
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 21:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B02B2C235A;
	Thu,  4 Sep 2025 21:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+2oi2qJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38AB2C032C
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 21:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021593; cv=none; b=GO1May5zu7xX1MZ1Qudk3/Py6bQSuh2Q79ri4EmDKlf7MdxSUjnj0mt2y8/9gAW29EoPjqUyQi0C81Ovnjmr+CfoiWOvPiDu5l330eem4YKuNMhKZT+qAG62yGRiEFleRxKxmOxyToaeUSlM0hmAbqoJ2NI5u1sCQvz3A+KfPNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021593; c=relaxed/simple;
	bh=9MiI5ZvuCO1wq15mMD/fHkYQx414pGpbtnQ0zoGU7d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oajoiGghyVgixdE1vlItyxIH/7kP/6iaTCioFD+6WV8KO4P3nCvWxaBmLN3ZeUBZk5gGP1yZ8aly3+26xiY9tS/9djnpkCcBIj/jW0DkbkkWWyGp67ifu38fzN59SdDxbGfyAkPS9QLmnGjCpbAgFEnYfOYezB3mDpgk2W95cE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+2oi2qJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757021590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G12ZvoIGncdc5q9Oz1isjoS1D9PWqRfwj3EJGyQfxdc=;
	b=O+2oi2qJ3+Anm9jMzwN7/PwtY4fw8MTbzOUVOhQHBt0ScbkhBHMZooxBU/YkANeJAfFiTi
	pzWWYJ8IDenSiwubOJHetHK4XxilicS+RGfvXpzqlTi2AXQrf8s/PBJuPBLw84iibZP3SI
	38OJgcjL26RGljioOymvE/w39vYrtgI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-YCAK9JsWNLCOwIlvaspmFw-1; Thu, 04 Sep 2025 17:33:02 -0400
X-MC-Unique: YCAK9JsWNLCOwIlvaspmFw-1
X-Mimecast-MFC-AGG-ID: YCAK9JsWNLCOwIlvaspmFw_1757021582
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3dbc72f8d32so666709f8f.3
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 14:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757021581; x=1757626381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G12ZvoIGncdc5q9Oz1isjoS1D9PWqRfwj3EJGyQfxdc=;
        b=Sg1Y46kCgZWeutoO9Sn6Z+Q2v64DqBl+UOCK832/yqjnwxMVXNQSGJqUFMQYyi2uqH
         kuOMQ2Maqq6oQMjQiWza/59nJSdYHyDkk5mlswmFFrPqsBmxYauvEct88ho1MfKyClHq
         hAQuf9zB56vf6XfvSAuH/l74ZVneOw4y/taYVhuN/H9w+rE+DgMZXe50Mbf72mo3l00h
         I5AsNPU+dnYL6oHMRKp2L+3ktE/utjpcKkMpUTnElRsadrBS1CX2NR9K2w7MXp2jnk+v
         t4Oq9ynCXtdomfaLQ81UruYN9IIRIV4lAjR+1zqp0Upw0Uq3lSWOcBhk6ltPnpT9s4+u
         gpmg==
X-Forwarded-Encrypted: i=1; AJvYcCVoofckGg9MjC6Q5wGLFE4lYhmiVcy/Ipkt31f20bb4sas5Fmw1XYPlFMchoha3/xHbACqCxs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr+H4yPZERMgxehEIoUJy939QW7+FhCn0zamByn7oKdiYEPVk6
	iCrKK0gbndR0Nti8MaqCbsSB3cF3mtt9ecYav81ni5x/yKrMjJlb+6/eMPs2HBQ2HLVvNKSO28/
	EWnI92PxOs6gSGN6NYQggROYoq/q5yh+rB/j6SfuPQluyM47GrvLtRaQfKw==
X-Gm-Gg: ASbGncvOEBh4XRQ2CgiJvpAuQUMalDCR2SGl/NpZKNN1at42fXVzC0o6yjv+NQ2Q83u
	Rg/EuYJiTUGRoO7+DffztqsyZCIAP3EwI3w9Acr6l27OF+ZEjdEcYf40TgonXgQxUiRsQx2IobS
	PsL0S1eO4euBL9bwg7rYqIz1j5tJp2VnfWwQfe3sCCVHgNNDZOp6TdY1T+9u/8m2UHjpdIzSYiG
	E/Kh7ueMgrNc9gGao6q/J4qhdWROruPxcYEXQb1Xrd9XNej/Ei6uPKnx263xmE6njojx3LnICpA
	Er/YW4DsvME1uxsp6UDqBczFvXHnxfGRltCa/96fq7oSc10V5l5dEgElH6d3EJXlQQ==
X-Received: by 2002:a05:6000:2703:b0:3d3:6525:e35a with SMTP id ffacd0b85a97d-3d36525e8edmr9572277f8f.4.1757021581607;
        Thu, 04 Sep 2025 14:33:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfw63CZFozF8s+C6cWdSgHCPxbPiLm75XGfmKwvUvkmtLdSrYut8mMraqSLccxduV85Qv9AQ==
X-Received: by 2002:a05:6000:2703:b0:3d3:6525:e35a with SMTP id ffacd0b85a97d-3d36525e8edmr9572266f8f.4.1757021581097;
        Thu, 04 Sep 2025 14:33:01 -0700 (PDT)
Received: from redhat.com (93-51-222-138.ip268.fastwebnet.it. [93.51.222.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e50e30asm302706375e9.24.2025.09.04.14.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 14:33:00 -0700 (PDT)
Date: Thu, 4 Sep 2025 17:32:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] virtio_net: Fix alignment and avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <20250904173150-mutt-send-email-mst@kernel.org>
References: <aLiYrQGdGmaDTtLF@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLiYrQGdGmaDTtLF@kspp>

On Wed, Sep 03, 2025 at 09:36:13PM +0200, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the new TRAILING_OVERLAP() helper to fix the following warning:
> 
> drivers/net/virtio_net.c:429:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> This helper creates a union between a flexible-array member (FAM)
> and a set of members that would otherwise follow it (in this case
> `u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];`). This
> overlays the trailing members (rss_hash_key_data) onto the FAM
> (hash_key_data) while keeping the FAM and the start of MEMBERS aligned.
> The static_assert() ensures this alignment remains, and it's
> intentionally placed inmediately after `struct virtnet_info` (no
> blank line in between).
> 
> Notice that due to tail padding in flexible `struct
> virtio_net_rss_config_trailer`, `rss_trailer.hash_key_data`
> (at offset 83 in struct virtnet_info) and `rss_hash_key_data` (at
> offset 84 in struct virtnet_info) are misaligned by one byte. See
> below:
> 
> struct virtio_net_rss_config_trailer {
>         __le16                     max_tx_vq;            /*     0     2 */
>         __u8                       hash_key_length;      /*     2     1 */
>         __u8                       hash_key_data[];      /*     3     0 */
> 
>         /* size: 4, cachelines: 1, members: 3 */
>         /* padding: 1 */
>         /* last cacheline: 4 bytes */
> };
> 
> struct virtnet_info {
> ...
>         struct virtio_net_rss_config_trailer rss_trailer; /*    80     4 */
> 
>         /* XXX last struct has 1 byte of padding */
> 
>         u8                         rss_hash_key_data[40]; /*    84    40 */
> ...
>         /* size: 832, cachelines: 13, members: 48 */
>         /* sum members: 801, holes: 8, sum holes: 31 */
>         /* paddings: 2, sum paddings: 5 */
> };
> 
> After changes, those members are correctly aligned at offset 795:
> 
> struct virtnet_info {
> ...
>         union {
>                 struct virtio_net_rss_config_trailer rss_trailer; /*   792     4 */
>                 struct {
>                         unsigned char __offset_to_hash_key_data[3]; /*   792     3 */
>                         u8         rss_hash_key_data[40]; /*   795    40 */
>                 };                                       /*   792    43 */
>         };                                               /*   792    44 */
> ...
>         /* size: 840, cachelines: 14, members: 47 */
>         /* sum members: 801, holes: 8, sum holes: 35 */
>         /* padding: 4 */
>         /* paddings: 1, sum paddings: 4 */
>         /* last cacheline: 8 bytes */
> };
> 
> As a last note `struct virtio_net_rss_config_hdr *rss_hdr;` is also
> moved to the end, since it seems those three members should stick
> around together. :)
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> 
> This should probably include the following tag:
> 
> 	Fixes: ed3100e90d0d ("virtio_net: Use new RSS config structs")
> 
> but I'd like to hear some feedback, first.
> 
> Thanks!
> 


I would add:

as a result, the RSS key passed to the device is shifted by 1
byte: the last byte is cut off, and instead a (possibly uninitialized) byte
is added at the beginning.

>  drivers/net/virtio_net.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 975bdc5dab84..f4964a18a214 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -425,9 +425,6 @@ struct virtnet_info {
>  	u16 rss_indir_table_size;
>  	u32 rss_hash_types_supported;
>  	u32 rss_hash_types_saved;
> -	struct virtio_net_rss_config_hdr *rss_hdr;
> -	struct virtio_net_rss_config_trailer rss_trailer;
> -	u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
>  
>  	/* Has control virtqueue */
>  	bool has_cvq;
> @@ -493,7 +490,16 @@ struct virtnet_info {
>  	struct failover *failover;
>  
>  	u64 device_stats_cap;
> +
> +	struct virtio_net_rss_config_hdr *rss_hdr;
> +
> +	/* Must be last --ends in a flexible-array member. */
> +	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer, hash_key_data,
> +		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> +	);
>  };
> +static_assert(offsetof(struct virtnet_info, rss_trailer.hash_key_data) ==
> +	      offsetof(struct virtnet_info, rss_hash_key_data));
>  
>  struct padded_vnet_hdr {
>  	struct virtio_net_hdr_v1_hash hdr;
> -- 
> 2.43.0


