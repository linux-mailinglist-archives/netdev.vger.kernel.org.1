Return-Path: <netdev+bounces-228355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F23BC8822
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 12:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D3E19E7D47
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 10:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38F628D82A;
	Thu,  9 Oct 2025 10:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhOSvMnq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5567E2C15B0
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760005870; cv=none; b=TUIilXgWCt5JxhNn0M/pA0kCWuvKRrEV1KQZrDvaTLOrnl0lTJzb93Mzx5TVklIXlWmtpLf6+fpe7QB+KSmgXSIa52DQO/tEeTfTJEEWdMIGpW7Us/A1TBv8gx4txDIYD/AQDH9hEigLzJumv3eQ3DtDytlQaLlvr8/ubnF37BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760005870; c=relaxed/simple;
	bh=vgAod7crx7R4xXAIc9s1jZIP1TAXz3XkbhEUFIzMc8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gL4sKxxxwf+nba4gxznFXkeZeJw7w4x7lxHx//b8vVsjWHh02jddvOlgexgD2cvfaSXOVusCn0xfFSgrqgwiU6tUIO2EfCh6Ao6Zbfvx+nJvqt1Y/haTO+GGpd56arlMU5fnzJZkRqPuLkmYEBekFuD5E7E6PLNYlzOZ6C0YnJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhOSvMnq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760005868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3xwzUfSGmIaE1JMs7cPjjEDpCSBNoPpYVvArzBqo+h8=;
	b=RhOSvMnqLwM44wzM6z1eivY9Af0or4RVpGdqJ9oIkuFzfgzkd6YqesiANl3r46eImxR9QN
	+Ulk1cMbU9Gt99f8HTVz3QoWuWX2gDHyrzUDRI3hLyB60+B3gQ4BTu0c3N9lthnO/eVfJ5
	rSKY79FsLpWIQa/jAespIIUJjx1XrJo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-jAhAAmS5MyGU1G3Sr8jb-Q-1; Thu, 09 Oct 2025 06:31:07 -0400
X-MC-Unique: jAhAAmS5MyGU1G3Sr8jb-Q-1
X-Mimecast-MFC-AGG-ID: jAhAAmS5MyGU1G3Sr8jb-Q_1760005867
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8776a952dd4so27929746d6.3
        for <netdev@vger.kernel.org>; Thu, 09 Oct 2025 03:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760005867; x=1760610667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xwzUfSGmIaE1JMs7cPjjEDpCSBNoPpYVvArzBqo+h8=;
        b=C5CCa+0MnP7rZyA2DP0ooLok6+fNT02EVmpbpKoTYhP0VyvD6lViImYic7GUISXl2J
         Qdhbc2N8AhjRF0bCBeWAVylrmMmWj2xyxdSMrfYn+nqmt8a+cFmax4+Egff1bpWhx7j+
         G/cjfG/lgjPpYY7QC71NY9xs7l2LLmSa+KcL6BbcflX4Md1Rzw9u7PVaXSM7pVDgYTNe
         LZNFC7gnMyLGlNdqjan/WeN/+1GUdSstKHG8mWxVGZoYpm0209gRqBVF0eftyqlZwjTM
         uXaoveDLsUurPqZtNuR0o79aS2QP3nBaL9yCClV1a2kdso5Y+qn7wPSwMVNLRd666l7j
         c+Xg==
X-Gm-Message-State: AOJu0YwBSzTMmAFn+CbLjnf9FlOAMCxH0fplNf1Q3s2Oxoz/C81Dhh0l
	HxdRqaNwxxeYRmiYo2+QmoQiEBt2UprWNXABWiOKvSTEYHh+glXBqrCf8GxWe2/kEGY8gmbokAy
	S7geKVyigQbhBAPfsmz5VNi8alwgc+0HxI7CUATrHCPagWoJ76L9lX3Bhgw==
X-Gm-Gg: ASbGncsdQ5lvtoBXggA33EQd1C/X2Y2Sb69Hhy8U2IF/pKHE+aFTLoRX+vbMvYI5mSe
	v5JnkbI3noT0gtSWtDazo1kk+K9LGlOvSL0jjxKwDzGUYvFQCqOkvDBS+tQQmcQ0HZE8y2pwZOm
	9CeQ3cjLqUDiG+sTVY+EDZuIbmvHA1sw4FirxCiC5fEWc1SgWu+DT6nJBGEY9Lg8dWAYXeixGLu
	/YooWgayI2yxlFMWSnNRxg0xWvUIPA6TGYiafMYCssqSs8gm6gPfO/bwU2ep7SSnSsemiMOEPka
	HPEiS0qfufro3WZT6x8p3PMwkf+JH/e6p20=
X-Received: by 2002:ad4:5f0f:0:b0:797:cef:c862 with SMTP id 6a1803df08f44-87b210a21c1mr74474956d6.29.1760005866609;
        Thu, 09 Oct 2025 03:31:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb59BlWNtrd9ASVIv5OrEtZDxeNHD6M5rLTvtfko0iTPAMDChI1SFbi2QmoEXT3T4ySUiwVg==
X-Received: by 2002:ad4:5f0f:0:b0:797:cef:c862 with SMTP id 6a1803df08f44-87b210a21c1mr74474576d6.29.1760005866091;
        Thu, 09 Oct 2025 03:31:06 -0700 (PDT)
Received: from redhat.com ([138.199.52.81])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bd786769sm181429956d6.31.2025.10.09.03.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 03:31:05 -0700 (PDT)
Date: Thu, 9 Oct 2025 06:31:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kommula Shiva Shankar <kshankar@marvell.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	parav@nvidia.com, jerinj@marvell.com, ndabilpuram@marvell.com,
	sburla@marvell.com, schalla@marvell.com
Subject: Re: [PATCH v2 net-next  3/3] vhost/net: enable outer nw header
 offset support
Message-ID: <20251009062720-mutt-send-email-mst@kernel.org>
References: <20251008110004.2933101-1-kshankar@marvell.com>
 <20251008110004.2933101-4-kshankar@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008110004.2933101-4-kshankar@marvell.com>

On Wed, Oct 08, 2025 at 04:30:04PM +0530, Kommula Shiva Shankar wrote:
> apprise vhost net about the virtio net header size.
> 
> Signed-off-by: Kommula Shiva Shankar <kshankar@marvell.com>
> ---
>  drivers/vhost/net.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 35ded4330431..8d055405746d 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -78,6 +78,7 @@ static const u64 vhost_net_features[VIRTIO_FEATURES_DWORDS] = {
>  	(1ULL << VIRTIO_F_IN_ORDER),
>  	VIRTIO_BIT(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
>  	VIRTIO_BIT(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO),
> +	VIRTIO_BIT(VIRTIO_NET_F_OUT_NET_HEADER),
>  };
>  
>  enum {


How does this even work?
VIRTIO_FEATURES_DWORDS is 2, you can't really
add more elements.

Pls include info on testing done in your next
submission.


> @@ -1655,6 +1656,9 @@ static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
>  		  sizeof(struct virtio_net_hdr_mrg_rxbuf) :
>  		  sizeof(struct virtio_net_hdr);
>  
> +	if (virtio_features_test_bit(features,
> +				     VIRTIO_NET_F_OUT_NET_HEADER))
> +		hdr_len = sizeof(struct virtio_net_hdr_v1_hash_tunnel_out_net_hdr);
>  	if (virtio_features_test_bit(features,
>  				     VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO) ||
>  	    virtio_features_test_bit(features,
> -- 
> 2.48.1


