Return-Path: <netdev+bounces-105148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FA690FDB3
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 09:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48DA51F21B95
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 07:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210B344366;
	Thu, 20 Jun 2024 07:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tml0PjiS"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F71D4D8A1
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 07:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718868545; cv=none; b=I/S5wYInh7+Ep+y5OvVy9RCbp5rparWFtIvTAdUiztD3eWUzNgIsQm7NdLojDhq2bYR7i3jbq3Lf7RFrzOr+57+rCATbArveN/jONyxSR7V685E/oSjCNAqfKqEwS9TzuKkBV9+yifNutRucg190q7g25c31tVPqo+0drRYtp7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718868545; c=relaxed/simple;
	bh=PZpSMSwUXqsWFe7yGDGWwHD0YyoCBXhytLQ4Ro6CISM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=SfuaE2y9zIsKKNgDU/IfpOh/H3EAEJYot9MKihJf0T9PNJxWKxGJPlMfMK4TvZ5dg+Nwf8dZ+ycujGM2J2eIZ/58tHO17FtSh3cfLlcQ6VojeRX7hg/tmr5r3BzTVvlLbiHejHyIwTmRwCiuDCO2iu6RZoWO7aloFwVp1V/WrpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tml0PjiS; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718868540; h=Message-ID:Subject:Date:From:To;
	bh=N7plDoouekMcid3olDSlT1T7gAQzkJadDghYmSKJvWQ=;
	b=tml0PjiSD6nb7gPoRrMtHzy1t3WsyAicCkgpkuvIUIsxrT1cc9ZQjBEAav9fq6uWXDxYASuX3dl4Y8W0McgQZe1GblLrJacMu8zFqPKAW2/KwH4+xIDp8x06YzF25/6anoAjPE+35HDLLMiapFENyUv7vo3vU6sRxurQ67tXH9Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W8qVEfz_1718868538;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8qVEfz_1718868538)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 15:28:59 +0800
Message-ID: <1718867780.8623598-4-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v4 0/5] virtio_net: enable the irq for ctrlq
Date: Thu, 20 Jun 2024 15:16:20 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619171535-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240619171535-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 19 Jun 2024 17:16:57 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Jun 20, 2024 at 12:19:03AM +0800, Heng Qi wrote:
> > Ctrlq in polling mode may cause the virtual machine to hang and
> > occupy additional CPU resources. Enabling the irq for ctrlq
> > alleviates this problem and allows commands to be requested
> > concurrently.
> 
> Any patch that is supposed to be a performance improvement
> has to come with actual before/after testing restults, not
> vague "may cause".

1. If the device does not respond in time, the CPU usage for ctrlq in the polling mode is
   ~100%, and in irq mode is ~0%;
2. If there are concurrent requests, the situation in 1 will be even worse;
3. On 64 queues with dim on, use nginx + wrk with the number of connections is 500:
   a. If ctrlq is in polling mode and concurrent requests are not supported:
      seeing that the dim worker occupies 20%+ CPU usage. Because of the
      large number of queues, dim requests cannot be concurrent, and the
      performance is unstable;
   b. If ctrlq is in irq mode and concurrent requests are supported: the overhead
      of the dim worker is not visible, and the pps increases by ~13%
      compared to a.

Thanks.

> 
> 
> 
> > Changelog
> > =========
> > v3->v4:
> >   - Turn off the switch before flush the get_cvq work.
> >   - Add interrupt suppression.
> > 
> > v2->v3:
> >   - Use the completion for dim cmds.
> > 
> > v1->v2:
> >   - Refactor the patch 1 and rephase the commit log.
> > 
> > Heng Qi (5):
> >   virtio_net: passing control_buf explicitly
> >   virtio_net: enable irq for the control vq
> >   virtio_net: change the command token to completion
> >   virtio_net: refactor command sending and response handling
> >   virtio_net: improve dim command request efficiency
> > 
> >  drivers/net/virtio_net.c | 309 ++++++++++++++++++++++++++++++++-------
> >  1 file changed, 260 insertions(+), 49 deletions(-)
> > 
> > -- 
> > 2.32.0.3.g01195cf9f
> 

