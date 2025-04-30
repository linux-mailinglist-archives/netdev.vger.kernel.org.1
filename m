Return-Path: <netdev+bounces-186943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C473AA4252
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 07:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8B89A5912
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 05:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE351DED63;
	Wed, 30 Apr 2025 05:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGbcMrDQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D9F1C84C7
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 05:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745990959; cv=none; b=lKsn8dfJx8V/k638hjSUMPH11bsN0+zwE7TJSjdv5yc3r57fKFb2CVDo5WPCLbWISe21HgFdy4C7JzWgP55Z59GCfB0ajRgJQP+xBma+lUAHUJ1Yp/yveR2McOY7SL/Q++Dkk6gGt3MkyaLRaaDIP0j5dCPvMtNe38Z29YjvIrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745990959; c=relaxed/simple;
	bh=UjpFNPRZFpPfDQcsq9EWAoTrdLGsSoBD33nEJeC3Jj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yn8R+kqVQF1T2cwuGHzqu2VWbR7wwzd5xzNqLJh4J7EnQ5oH60GBjIew2Uixypqb9sOk3OQU4srBZE4PUvfidrlWBo1wUTpIUpM5ZEfhLvyqGNwifcYYHoqnYQ3AZ1lNrzZP6tjO267QcDBHn/Vg1mabZaXBmnl145DTR5EE040=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGbcMrDQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745990955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HrsAd6dSn628uJcdkrQWGVp8f1VXho8/Cq4Atym3MwY=;
	b=ZGbcMrDQrBxH9BIPQLuvIdLcVIl/eSkVEnt+YkU+BL7xGYMchGDlqL68+j54Pv8gMoBCoa
	jrgLXrRCSoDF959Heza4ISguedvPS/IAeIe2y3A6pXq1qP2KduHT74OsVV7COMzQ/fm7Zl
	jbbFpkE+u1A8TACUx3wfBihTmuIOO20=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-eZdGE4cHO0uQC9cFj-RAKQ-1; Wed, 30 Apr 2025 01:29:12 -0400
X-MC-Unique: eZdGE4cHO0uQC9cFj-RAKQ-1
X-Mimecast-MFC-AGG-ID: eZdGE4cHO0uQC9cFj-RAKQ_1745990952
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912fc9861cso1924996f8f.1
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 22:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745990952; x=1746595752;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HrsAd6dSn628uJcdkrQWGVp8f1VXho8/Cq4Atym3MwY=;
        b=Yfdakyvd1leYd4NlGayX62saucKC+0FNUpxEd1fZh9w6KTLuCGzTf1BcluDKwsfouW
         aEZ99qKvQBvdYc+IHqnp7CYBe96NNvXLjY1kgTUrsol/rD9xgahfrH9RJOi4j63w0j3s
         Me68TO8DHPTeEmWbz/9m+wQHWEOX4jJeLnlKc6SPlbOVXOmukXmRk+xCPKxv8LkDboEa
         zyenqwk6pICJ4tLqeX5h2iWT8KcHmS8SaYWT91qwfByxDqOKThOd9IQhB2Q+CtIs5crc
         97huATWNoiPkPKB2uG+A5lNI0bbWmMNx+K6Fj9X1JtS2y9+zeQb3Xr4YAUeDhn+piCaX
         5WUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPH521d3cA66CbiayG1+s4y5BIi81RNRxaWH0Yd6qTIrMsadg2QWblMbBs9mXQiK9OmeOeiOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzifvyAakTbvRdgex4zLZWZsYyiDjQ8jUEM+A5dikCDoOuVbh70
	0NbbYsmnIEEX0LxFDoWnW01xxITog4TSYPfbzOSlasTjsECkvwPUxgguNDQFp2YhrSHSfBqja2k
	tMpi39yj0+rQGda1LSZWzeQ+XNY9FpT+jEtI5Bu1WWXHBj8tKfUtttg==
X-Gm-Gg: ASbGncstwd0R2fvK+Yb2Jx21bQf+66MWKH7y+FU2rOWDzm60VQOeq/U2wHxg8dkeuR/
	kW+7A24KF2vm+KHGktWAP95TDVXzqWIOPpeVa98lKfU8JX2820uABpktIKwe2cigC/kICOYPlfx
	vDtszkajoEmPoRt6/ozfsmRhBMMd9VRxC/2aVSaqn20cvu1LSVA9jBeeWUm9cOW4xZ8KfvHAuBi
	gFxENb9go2debHfwjzkN/PagPsFOO1W+ihk6UdRnTnAyZSBNAOSdh6+uqbseT+z0YcmDnq7VFjT
	+05ssw==
X-Received: by 2002:a05:6000:4382:b0:3a0:8495:cb75 with SMTP id ffacd0b85a97d-3a08f7985f5mr1389196f8f.9.1745990951767;
        Tue, 29 Apr 2025 22:29:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFiH7uMgCfGvd2/j6i6NapwDI1qvZgSgAio3hl0KdvKSaeaW6jBZchdAwR/MSNWbcy3zYtLQ==
X-Received: by 2002:a05:6000:4382:b0:3a0:8495:cb75 with SMTP id ffacd0b85a97d-3a08f7985f5mr1389173f8f.9.1745990951429;
        Tue, 29 Apr 2025 22:29:11 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e47307sm16052695f8f.65.2025.04.29.22.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 22:29:09 -0700 (PDT)
Date: Wed, 30 Apr 2025 01:29:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, minhquangbui99@gmail.com, romieu@fr.zoreil.com,
	kuniyu@amazon.com, virtualization@lists.linux.dev
Subject: Re: [PATCH net] virtio-net: don't re-enable refill work too early
 when NAPI is disabled
Message-ID: <20250430012856-mutt-send-email-mst@kernel.org>
References: <20250429143104.2576553-1-kuba@kernel.org>
 <CACGkMEs0LuLDdEphRcdmKthdJeNAJzHBqKTe8Euhm2adOS=k2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEs0LuLDdEphRcdmKthdJeNAJzHBqKTe8Euhm2adOS=k2w@mail.gmail.com>

On Wed, Apr 30, 2025 at 11:49:15AM +0800, Jason Wang wrote:
> On Tue, Apr 29, 2025 at 10:31 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > Commit 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> > fixed a deadlock between reconfig paths and refill work trying to disable
> > the same NAPI instance. The refill work can't run in parallel with reconfig
> > because trying to double-disable a NAPI instance causes a stall under the
> > instance lock, which the reconfig path needs to re-enable the NAPI and
> > therefore unblock the stalled thread.
> >
> > There are two cases where we re-enable refill too early. One is in the
> > virtnet_set_queues() handler. We call it when installing XDP:
> >
> >    virtnet_rx_pause_all(vi);
> >    ...
> >    virtnet_napi_tx_disable(..);
> >    ...
> >    virtnet_set_queues(..);
> >    ...
> >    virtnet_rx_resume_all(..);
> >
> > We want the work to be disabled until we call virtnet_rx_resume_all(),
> > but virtnet_set_queues() kicks it before NAPIs were re-enabled.
> >
> > The other case is a more trivial case of mis-ordering in
> > __virtnet_rx_resume() found by code inspection.
> >
> > Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> > Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> > CC: mst@redhat.com
> > CC: jasowang@redhat.com
> > CC: xuanzhuo@linux.alibaba.com
> > CC: eperezma@redhat.com
> > CC: minhquangbui99@gmail.com
> > CC: romieu@fr.zoreil.com
> > CC: kuniyu@amazon.com
> > CC: virtualization@lists.linux.dev
> > ---
> >  drivers/net/virtio_net.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 848fab51dfa1..4c904e176495 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3383,12 +3383,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
> >                                 bool refill)
> >  {
> >         bool running = netif_running(vi->dev);
> > +       bool schedule_refill = false;
> >
> >         if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> > -               schedule_delayed_work(&vi->refill, 0);
> > -
> > +               schedule_refill = true;
> >         if (running)
> >                 virtnet_napi_enable(rq);
> > +
> > +       if (schedule_refill)
> > +               schedule_delayed_work(&vi->refill, 0);
> >  }
> >
> >  static void virtnet_rx_resume_all(struct virtnet_info *vi)
> > @@ -3728,7 +3731,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
> >  succ:
> >         vi->curr_queue_pairs = queue_pairs;
> >         /* virtnet_open() will refill when device is going to up. */
> > -       if (dev->flags & IFF_UP)
> > +       if (dev->flags & IFF_UP && vi->refill_enabled)
> >                 schedule_delayed_work(&vi->refill, 0);
> 
> This has the assumption that the toggle of the refill_enabled is under
> RTNL. Though it's true now but it looks to me it's better to protect
> it against refill_lock.
> 
> Thanks

Good point.

> >
> >         return 0;
> > --
> > 2.49.0
> >


