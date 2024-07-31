Return-Path: <netdev+bounces-114567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FAE942EE8
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 14:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18F41C2129E
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DD21AED3D;
	Wed, 31 Jul 2024 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="et2RB3eS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568301AE85F
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430019; cv=none; b=Bav/f8NppoRApATpl3i5M3YFqP+uVIJsBePYF9CZOR6YM8IBHX+jWsieY1lpl012hdOifzQH/gt4c8eMe+De2ukxA308Z+d2dbXRaKdqtl8XOvWdpEcYEHTzJtHAjJty5yYmshGjVbjTzR/9nZ4fo3jWLYd6UeslMwZz+X6Xxe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430019; c=relaxed/simple;
	bh=9UPvDjZj7omKIq+R/WkcdYc4X8qFyrkL1Uld0g/QkDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAZuqUJxSokBd9Jio93HB82riE+VZdvVwgvuJgUWxd0eQrOyaWdPvQJzNChTI3hVoXc5c8x9VUg/qn4nHQlIHMxmt/Fq/ZR29F/ezYeH7GjzwWtyvKrm0as2vLoXbFO4Jxw26b9w4AKroR1bdIB9X+YX7qVtjfQbEV8Hf+teeFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=et2RB3eS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722430016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NWAg3XJ7lRmViz7eWm0AuiImDEV7Paz7qFAo+DxnEWw=;
	b=et2RB3eSb3hatQruiQfSNijjcKJ8McVx5XHpjCOIVA3pkCsMlXWLGY+lZhBB12ZAxScIWk
	2g+Tr8lVel1Gtj2eSH6fIZF+EBpZdun19Jq6KD+CuvRcb3k2kq6fiycvZ6Jgfm1TjgSAT7
	Keo7Wq85HpGqsp5TsQQOvs7H3hEyp5c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-yhXpVd0YMo-tgqVn7B1NCA-1; Wed, 31 Jul 2024 08:46:54 -0400
X-MC-Unique: yhXpVd0YMo-tgqVn7B1NCA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a7aa7e86b5eso518253666b.2
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 05:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722430013; x=1723034813;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NWAg3XJ7lRmViz7eWm0AuiImDEV7Paz7qFAo+DxnEWw=;
        b=jpaJwb+kgesz09ctJ0FxeMsHCzd0fJkuPtnGcfCoBn8DMovLseo8gQnBzq8iFKQWI7
         4x1QX+R3kfuNp/vhembjcWVZ+ghJi4A/dTHaE+TzcDzAZ1fQo/5FN4VgBxnr5XX/cfIO
         H0/sYSbgmRcspouXb3vA+v2dGNMeECSxSDTt9aw7aWw2048Ou2MUsg4+pFMM9yWui9F8
         zX9VDcGQz3zS5KklxCsG1Z6DdT1JawK0ytgEf/uCfqSxlRNCZVubLISAPb9+sBdTBfcS
         iWfuBV4DZ+f52I19YPGemz2cdjT+IFlq++BLS6WiOHkBM1JfTaL3MQjYCAQhVgPN9mR2
         lAeQ==
X-Gm-Message-State: AOJu0YyjnWS+WHgNkqU0iOXSnz+d+OGMC24yfjDcEirAf/psohYQRh9v
	jIzlRsQDVCHMFS3dkvalzmfzMLrAXdMIZ5lH29O3PZ0o5o8ZT/9nIIonR1aHFAXHvflqRdl0F4t
	mJQFEg7/f/pYK+HYCMWgUtjN5qovmOi+GLamNrLZ7Z4DpVc60poVGmQ==
X-Received: by 2002:a17:907:801:b0:a77:e55a:9e87 with SMTP id a640c23a62f3a-a7d40116a40mr909915666b.48.1722430013096;
        Wed, 31 Jul 2024 05:46:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGViNLur3vjF6ZbGgoVg8yVsxu213V+7vQF63GW+BvUWRfICnkA4QVWqssZQovjshHinyRmyg==
X-Received: by 2002:a17:907:801:b0:a77:e55a:9e87 with SMTP id a640c23a62f3a-a7d40116a40mr909913466b.48.1722430012291;
        Wed, 31 Jul 2024 05:46:52 -0700 (PDT)
Received: from redhat.com ([2.55.14.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab580b4sm761021266b.58.2024.07.31.05.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 05:46:50 -0700 (PDT)
Date: Wed, 31 Jul 2024 08:46:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	=?iso-8859-1?Q?EugenioP=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH net v2] virtio-net: unbreak vq resizing when coalescing
 is not negotiated
Message-ID: <20240731084632-mutt-send-email-mst@kernel.org>
References: <20240731120717.49955-1-hengqi@linux.alibaba.com>
 <20240731081409-mutt-send-email-mst@kernel.org>
 <1722428723.505313-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1722428723.505313-1-hengqi@linux.alibaba.com>

On Wed, Jul 31, 2024 at 08:25:23PM +0800, Heng Qi wrote:
> On Wed, 31 Jul 2024 08:14:43 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Jul 31, 2024 at 08:07:17PM +0800, Heng Qi wrote:
> > > >From the virtio spec:
> > > 
> > > 	The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL
> > > 	feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
> > > 	and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.
> > > 
> > > The driver must not send vq notification coalescing commands if
> > > VIRTIO_NET_F_VQ_NOTF_COAL is not negotiated. This limitation of course
> > > applies to vq resize.
> > > 
> > > Fixes: f61fe5f081cf ("virtio-net: fix the vq coalescing setting for vq resize")
> > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Acked-by: Eugenio Pé rez <eperezma@redhat.com>
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > > v1->v2:
> > >  - Rephrase the subject.
> > >  - Put the feature check inside the virtnet_send_{r,t}x_ctrl_coal_vq_cmd().
> > > 
> > >  drivers/net/virtio_net.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 0383a3e136d6..2b566d893ea3 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -3658,6 +3658,9 @@ static int virtnet_send_rx_ctrl_coal_vq_cmd(struct virtnet_info *vi,
> > >  {
> > >  	int err;
> > >  
> > > +	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> > > +		return -EOPNOTSUPP;
> > > +
> > >  	err = virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(queue),
> > >  					    max_usecs, max_packets);
> > >  	if (err)
> > > @@ -3675,6 +3678,9 @@ static int virtnet_send_tx_ctrl_coal_vq_cmd(struct virtnet_info *vi,
> > >  {
> > >  	int err;
> > >  
> > > +	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> > > +		return -EOPNOTSUPP;
> > > +
> > >  	err = virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
> > >  					    max_usecs, max_packets);
> > >  	if (err)
> > > @@ -3743,7 +3749,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
> > >  			err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, i,
> > >  							       vi->intr_coal_tx.max_usecs,
> > >  							       vi->intr_coal_tx.max_packets);
> > > -			if (err)
> > > +			if (err && err != -EOPNOTSUPP)
> > >  				return err;
> > >  		}
> > >
> > 
> > 
> > So far so good.
> >   
> > > @@ -3758,7 +3764,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
> > >  							       vi->intr_coal_rx.max_usecs,
> > >  							       vi->intr_coal_rx.max_packets);
> > >  			mutex_unlock(&vi->rq[i].dim_lock);
> > > -			if (err)
> > > +			if (err && err != -EOPNOTSUPP)
> > >  				return err;
> > >  		}
> > >  	}
> > 
> > I don't get this one. If resize is not supported,
> 
> Here means that the *dim feature* is not supported, not the *resize* feature.
> 
> > we pretend it was successful? Why?
> 
> During a resize, if the dim feature is not supported, the driver does not
> need to try to recover any coalescing values, since the device does not have
> these parameters.
> Therefore, the resize should continue without interruption.
> 
> Thanks.


you mean it's a separate bugfix?

> > 
> > > -- 
> > > 2.32.0.3.g01195cf9f
> > 


