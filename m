Return-Path: <netdev+bounces-103640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CF6908DA7
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A8F1F24298
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA4FEAE5;
	Fri, 14 Jun 2024 14:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R455ZXUY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951931426C
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718376017; cv=none; b=KmetQEdLfvEWG7vc96SJeZc65AgD55RW7kZo9ZW5RmdMD/yWlVYuzTfQhxz/aR2wpXiYXD5gweqMxgDayO3l51GpB1GSQfb5VRbfPn/Z+tlmmq4/TPYpGaRLGpnJZBIE9aJJ4DR+iE8F8mrREDX57nSVFdponohaRdtK1P5iFRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718376017; c=relaxed/simple;
	bh=V+j0eTBGfNMTjfAN5fGbwz4kgOLveZl9pdrHD3yNXXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqYW98e1Rxya8VWMn1nCK/pj1xqGVXBZUpIyv2vr5rrYrPmtyNcIxlFh882dwu4VqiPXcaHmBuwKChyr/ESBgn1nb6vWwAkEcLXF2gWw57bxa4O7bqY3paL3WLXvNqrvCihc29xqYB2Bccux1GtapqddvvYstXqEUGhZC4QeMdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R455ZXUY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718376014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qt5NcoDJbY+6/rjcnHVm1O4k+qFDbB1MVLu9nqhSjFs=;
	b=R455ZXUY2YHKCJDQc6Vx4AP3cCExBHf5DRSCSyNV5VpCCN0huQgrzcbaVaGwC4eIUZma1V
	ZQc6eP3Bk3w1pcOi1LdiW80XaP6lviC6mMpvy7suIkysFs32LDU/VXHD1jRr1JTZENZuxU
	30/S4sFGwiTmnnmLAxuevqpBACo+wbQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-IMKyp1K4OCKJpOqsTpB8dw-1; Fri, 14 Jun 2024 10:40:10 -0400
X-MC-Unique: IMKyp1K4OCKJpOqsTpB8dw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52c8ddc2ef9so1873573e87.1
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 07:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718376008; x=1718980808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qt5NcoDJbY+6/rjcnHVm1O4k+qFDbB1MVLu9nqhSjFs=;
        b=mn1F/EI9DgFvRvVarye7U04g9YM+lBT9iVdVeje3xjc2ezaXFuoxhtdVxEjKNy3hWR
         Be4fyvyObpwKLFcB34mPOlh4q5aspQUSGbuARGUtGOsQwSbgIosxtwYkeltF4ffWmTz7
         H5puI9YB4lRaNaP3rhW09UQG3THEejO56HG/LrwlmW28uCdBfQqlid60bRrJ/c0UoRPl
         x3F2alOaZy/+8MA4CxK6u2Va642fF+WqKydV7+p1i2Fa30cnAFAx65HvOVbIvjNLTF1v
         /ryu+WS76XhicoQ33vu7+wPsQAFSgRVz0JEH6DGkbmF0XNlB1C4iFmVXdKVZSRxMPHNn
         tt4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7HilAhun5zTgAXSYsz6To8/BS1VgkC3ht1v7DFRoC/p4JvtV3cGcAe22vYR6xQ/Xa2S+MV2Nzdq5SL/mmjYu3T/1Ufw9U
X-Gm-Message-State: AOJu0YzYnDvHX+Am33+fkLpZ76Nje3JVNlbywzUyBBK47+TIm4H/iakL
	c0+asUmQ1XQy1pznN/0nITt6k6pZuYjAZ3K8/6f9/MPtNo+JPw7qKvoLjyJqfGzDKO1Qewaks2x
	Cty1IAr3yZnl7dGRA9OI6Y+8ZGUD+IIzymdvXEzczyIiStWbk3w/chg==
X-Received: by 2002:a19:e014:0:b0:52c:98b1:36d9 with SMTP id 2adb3069b0e04-52ca6e9da28mr2241956e87.62.1718376008742;
        Fri, 14 Jun 2024 07:40:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX3v8Wn+67KK53vRvZL7N4S0NTRO/vH3/5y85IBEbKT1mz68C2tnhNAWikvnfX+3y8Ft3XvQ==
X-Received: by 2002:a19:e014:0:b0:52c:98b1:36d9 with SMTP id 2adb3069b0e04-52ca6e9da28mr2241946e87.62.1718376008400;
        Fri, 14 Jun 2024 07:40:08 -0700 (PDT)
Received: from sgarzare-redhat ([147.229.117.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ed39ddsm196069566b.142.2024.06.14.07.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:40:07 -0700 (PDT)
Date: Fri, 14 Jun 2024 16:40:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <luigi.leonardi@outlook.com>
Cc: edumazet@google.com, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, kuba@kernel.org, kvm@vger.kernel.org, stefanha@redhat.com, 
	pabeni@redhat.com, davem@davemloft.net
Subject: Re: [PATCH net-next 0/2] vsock: avoid queuing on workqueue if
 possible
Message-ID: <mfhi5is5533xyt4nlbpifrg6mpx3rye4n4vfg736irsae5tfx6@2aiorapp2uos>
References: <AS2P194MB2170EB1827729FB1666311FA9AC22@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <AS2P194MB2170EB1827729FB1666311FA9AC22@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>

On Fri, Jun 14, 2024 at 03:55:41PM GMT, Luigi Leonardi wrote:
>This patch series introduces an optimization for vsock/virtio to reduce latency:
>When the guest sends a packet to the host, and the workqueue is empty,
>if there is enough space, the packet is put directly in the virtqueue.

Thanks for working on this!!

I left few small comments.
I'm at DevConf this weekend, so I'll do a better review and some testing
next week.

Stefano

>
>The first one contains some code refactoring.
>More details and some performance tests in the second patch.
>
>Marco Pinna (2):
>  vsock/virtio: refactor virtio_transport_send_pkt_work
>  vsock/virtio: avoid enqueue packets when work queue is empty
>
> net/vmw_vsock/virtio_transport.c | 166 +++++++++++++++++++------------
> 1 file changed, 104 insertions(+), 62 deletions(-)
>
>-- 
>2.45.2
>


