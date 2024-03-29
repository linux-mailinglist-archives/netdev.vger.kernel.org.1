Return-Path: <netdev+bounces-83387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5EC892188
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 17:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 332E92878D9
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3F485925;
	Fri, 29 Mar 2024 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5mYIRFy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18564E1BE
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711729330; cv=none; b=dib1nzdWMrN2AtPg4/5WjmvsDP3MXa5ElSNgT0CoWoyZzUqpYAgwJzyBLKnk/zUSN0BJTIO6tVhDx7Z2y6feIb+gW5wEdiJNJJigOqQzW5+TYseyeoM3yqxosD92gmPT8laVIyz+ok2VmZ/vlWb8jQT6lMc8+UcQt2J8EnhG9x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711729330; c=relaxed/simple;
	bh=riODE1dPTaLbQpz/0beewzGEpd2nIe52VyxmuEiuHaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBa5v4Ve/Sqmi1YDVhfJ726IZjXGw2JE1nFxrnSFXleu9VoUU1ZOlE+TY2kxJW29WoaDfxzEMae5gXbMuhvIw7zw6K/B0Se9Y7qgyOnHjJ+nPh65OfUhQtygYehr1XAfDx/wyHb3ub0m1b6m2RxEQiQRr9Rh5yAPygxRfrC+faU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5mYIRFy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711729327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fmEyRcPuEinvJiX6Dq129jlFJ6SCvYGxlVcOYHlmNDQ=;
	b=Z5mYIRFysSKKhXSsiWcg2tj7AzXJCNCgb3TiuUYiVFy3QmUBQSiB63Nh8M/YEQoUTiCekF
	6LIOVq/R9D/ebdKobrHe1mIn7zQRHwsDeKRg4A/WtkqUp/tu1A6ywlFUoAg/o6Pfx0/f8q
	Xyvk+mgkR35fTovgn1YY7JrrCOHK/ko=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-2dA5FpKtOjmjx222IXZLhg-1; Fri, 29 Mar 2024 12:22:06 -0400
X-MC-Unique: 2dA5FpKtOjmjx222IXZLhg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-341cdbcbd62so616441f8f.1
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 09:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711729325; x=1712334125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmEyRcPuEinvJiX6Dq129jlFJ6SCvYGxlVcOYHlmNDQ=;
        b=udVYRwd31x9lhfyY23fDcfiTpVvPmSrQp6vesSdsvPiADwf7SBAMl69c1JoqqDbjR4
         MbYAyRlCbjZYY5JugbWt2IxB+B+TejS+nS+iygBFG6dSJcP0yY2VLHJVv/k0PnfYFkkY
         +e1/eGu6RA5WD8I1IRsia2irCk2DScf/p/l3p87zKG57BnzKi8JvvBeHvm7kASeD6/CW
         Ppea2jyr7PaS6D5kpsQT/QPRscbT8K98NXKympLiW1INXGwmIKcGDqZ77pWL3OrSBEfw
         6YtlLFfthZA8uzTssRTBRxfNyu+8OLaWaHNbcysd+06GvXBKSE8f8kpKHYj97P6KT93R
         /RmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJU787T8oRvb3rVvwhMVR837cbvNDDEVwA/pQWFwqbOnuL+xSAtvEdIkTfaNbAZafBzSZjgVVgK2Ps1VGJ13y5TeG+58BA
X-Gm-Message-State: AOJu0Yy/BjeLEUUshKALtHHmKMuNetENt1DDbINgMcD9imgXTu3dEWOq
	CoFnUVGdaxzECboOqa9bjpCfzLPCm3qs1PMxbNFzb0Eg67zQPYOsxUlcBU8PfHOSa7U/MFnPFeU
	XFGEbnS98ICm22KEOyvkxeEsbyh6CZPGz37+H/hc3+vMkPm6Dvi4C3g==
X-Received: by 2002:adf:f810:0:b0:33e:7750:781d with SMTP id s16-20020adff810000000b0033e7750781dmr1813661wrp.56.1711729325173;
        Fri, 29 Mar 2024 09:22:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbg6+AHNtlfHpBhKeqnWBXMq04cVofQNecZMc0Hx1QL8O3mLHrvSVma3HCLwksp4G60St5Bw==
X-Received: by 2002:adf:f810:0:b0:33e:7750:781d with SMTP id s16-20020adff810000000b0033e7750781dmr1813641wrp.56.1711729324802;
        Fri, 29 Mar 2024 09:22:04 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id u4-20020adff884000000b00341d9e8cc62sm4478654wrp.100.2024.03.29.09.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 09:22:04 -0700 (PDT)
Date: Fri, 29 Mar 2024 17:22:00 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Marco Pinna <marco.pinn95@gmail.com>
Cc: stefanha@redhat.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, ggarcia@deic.uab.cat, jhansen@vmware.com, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vge.kernel.org
Subject: Re: [PATCH net v2] vsock/virtio: fix packet delivery to tap device
Message-ID: <tglqxtqa47wu53idfssswmrb6ulhnkdlavt27qoxhp2hniwgxc@j3fmzh5wowbc>
References: <20240329161259.411751-1-marco.pinn95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240329161259.411751-1-marco.pinn95@gmail.com>

On Fri, Mar 29, 2024 at 05:12:59PM +0100, Marco Pinna wrote:
>Commit 82dfb540aeb2 ("VSOCK: Add virtio vsock vsockmon hooks") added
>virtio_transport_deliver_tap_pkt() for handing packets to the
>vsockmon device. However, in virtio_transport_send_pkt_work(),
>the function is called before actually sending the packet (i.e.
>before placing it in the virtqueue with virtqueue_add_sgs() and checking
>whether it returned successfully).
>Queuing the packet in the virtqueue can fail even multiple times.
>However, in virtio_transport_deliver_tap_pkt() we deliver the packet
>to the monitoring tap interface only the first time we call it.
>This certainly avoids seeing the same packet replicated multiple times
>in the monitoring interface, but it can show the packet sent with the
>wrong timestamp or even before we succeed to queue it in the virtqueue.
>
>Move virtio_transport_deliver_tap_pkt() after calling virtqueue_add_sgs()
>and making sure it returned successfully.
>
>Fixes: 82dfb540aeb2 ("VSOCK: Add virtio vsock vsockmon hooks")
>Cc: stable@vge.kernel.org
>Signed-off-by: Marco Pinna <marco.pinn95@gmail.com>
>---
> net/vmw_vsock/virtio_transport.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 1748268e0694..ee5d306a96d0 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -120,7 +120,6 @@ virtio_transport_send_pkt_work(struct work_struct *work)
> 		if (!skb)
> 			break;
>
>-		virtio_transport_deliver_tap_pkt(skb);
> 		reply = virtio_vsock_skb_reply(skb);
> 		sgs = vsock->out_sgs;
> 		sg_init_one(sgs[out_sg], virtio_vsock_hdr(skb),
>@@ -170,6 +169,8 @@ virtio_transport_send_pkt_work(struct work_struct *work)
> 			break;
> 		}
>
>+		virtio_transport_deliver_tap_pkt(skb);
>+
> 		if (reply) {
> 			struct virtqueue *rx_vq = vsock->vqs[VSOCK_VQ_RX];
> 			int val;
>-- 
>2.44.0
>


