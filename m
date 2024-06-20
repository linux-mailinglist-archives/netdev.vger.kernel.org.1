Return-Path: <netdev+bounces-105150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF25590FDE6
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 09:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 628FEB21372
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 07:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC71854750;
	Thu, 20 Jun 2024 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yE9SssuR"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBAB54720
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718868894; cv=none; b=aidBQGUXMUoYKpt0xd1prTZs4N8fM+5FIslg2GgVGPr+G6b0twvx7dM1wnwwRVrZwGk0MAJcMlSh8jYAr06IXc7qPgOSaJLAWEq+K21Ehnt9/38m3mJ8xpDHXp8KF7jdtzyXvvekRsFV3kbnMBZOBQW85RQrgvV7OJmOciUf1n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718868894; c=relaxed/simple;
	bh=utnGBcGfqhx3odsMMUpnDqRZ87HpmTagQZGorlaBLQY=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=KPOLQDxWjB4bCN7QCiOr+PYIlblrUOEGSTG1Z2A0B7LVu6AZ6rjfCl/j0DqAKuD0rJbY8CuUhzZpEbvhxbV6IvXDRB77t7p7dbGLlYZB9kAKinPub/Wuc1WrivbGO9aYfHcx5B7ATAo4ndY/1q0EegkfHXMLkvfgLBJ37FdJUMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yE9SssuR; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718868883; h=Message-ID:Subject:Date:From:To;
	bh=d9iPSVqNJ1QqmN6EFZNWgjHrK3uM1ZJvNdZTn7+Ymtw=;
	b=yE9SssuRtgEAeN+px+1Dbk5rrsaIUmISAqVPOwegBA1dy9WCWkyZa/2YlftRSaK3DSNKF1rpTgNR+ZCKAMnC0e2UjVzNs7PFAJ42Oxg7GYFrx3Xx1Rx6uy6iiZvNzeg83vowMBM3QTwiyO4+XBg2lA0goZGQlN1pIAbom3j871U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W8qVGgm_1718868882;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8qVGgm_1718868882)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 15:34:43 +0800
Message-ID: <1718868555.2701075-5-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Date: Thu, 20 Jun 2024 15:29:15 +0800
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
 <20240619161908.82348-3-hengqi@linux.alibaba.com>
 <20240619171708-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240619171708-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> >  
> >  	/* Parameters for control virtqueue, if any */
> >  	if (vi->has_cvq) {
> > -		callbacks[total_vqs - 1] = NULL;
> > +		callbacks[total_vqs - 1] = virtnet_cvq_done;
> >  		names[total_vqs - 1] = "control";
> >  	}
> >  
> 
> If the # of MSIX vectors is exactly for data path VQs,
> this will cause irq sharing between VQs which will degrade
> performance significantly.
> 
> So no, you can not just do it unconditionally.
> 
> The correct fix probably requires virtio core/API extensions.

If the introduction of cvq irq causes interrupts to become shared, then
ctrlq need to fall back to polling mode and keep the status quo.

Thanks.

> 
> -- 
> MST
> 

