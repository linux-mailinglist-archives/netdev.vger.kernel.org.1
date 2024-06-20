Return-Path: <netdev+bounces-105188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AEC9100D0
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674C1282EB9
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 09:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221531A4F35;
	Thu, 20 Jun 2024 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FiiWnupK"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790051A4F0B
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718877183; cv=none; b=pm8Wo7JH2hGrXRHDKGE64x6XULL1bhAOjSK/ztqqmEypUvmtfim2etxR8+FW7fGBNYYp/CgBRjfxYipSGufYyfnnEWwZhYpKhUn2MZJ2YWJYbdOAEQjQ/nI3MqgDgaKX7glf/XYsDN8J9caOftLwtMhHYMn9roKGq0czuNp3mMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718877183; c=relaxed/simple;
	bh=GHQgHHWJDSk5PFqiuXn5fzI3dJUaKf9H+B0C42ZjcZM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=mvOd2d7F8Wiap9WTcl8TRKgMuCUFoQNstwW9FQxzRKJVuJoCPEAnePUJzWm5h8gIQL9lxxJUn9ST74DM8WLjAQG+emqdykqGMDq7H9W/2OR96JMlVe6IQMRBkephkVv1Ac3X6iOicxOFepvl1h76P9e68VCqUa3bE40E/P5cXaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FiiWnupK; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718877178; h=Message-ID:Subject:Date:From:To;
	bh=2Xd9ex/MMI/W8bpwDrGwLCdLUQoRR0rB+7dSg0fcmEk=;
	b=FiiWnupKmg+K9QQbeMIyLOJWlmov8VUHUquHSMe1KBbvGcI18xmDXlvkYjaohi75w0nPv1NXYVhCHZ0G2IZEs3iuU5Mde9Hye2A503ktmXSgCqxqJgcirag247nInBnHMlB0ywzMNjBmKH/z/Ih4Nb3hFdaDAqPSBQp8+/Htx8s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W8rHdgn_1718877176;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8rHdgn_1718877176)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 17:52:57 +0800
Message-ID: <1718876302.539031-8-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Date: Thu, 20 Jun 2024 17:38:22 +0800
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
 <1718868555.2701075-5-hengqi@linux.alibaba.com>
 <20240620034602-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240620034602-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 20 Jun 2024 04:32:15 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Jun 20, 2024 at 03:29:15PM +0800, Heng Qi wrote:
> > On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> > > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > > >  
> > > >  	/* Parameters for control virtqueue, if any */
> > > >  	if (vi->has_cvq) {
> > > > -		callbacks[total_vqs - 1] = NULL;
> > > > +		callbacks[total_vqs - 1] = virtnet_cvq_done;
> > > >  		names[total_vqs - 1] = "control";
> > > >  	}
> > > >  
> > > 
> > > If the # of MSIX vectors is exactly for data path VQs,
> > > this will cause irq sharing between VQs which will degrade
> > > performance significantly.
> > > 
> > > So no, you can not just do it unconditionally.
> > > 
> > > The correct fix probably requires virtio core/API extensions.
> > 
> > If the introduction of cvq irq causes interrupts to become shared, then
> > ctrlq need to fall back to polling mode and keep the status quo.
> > 
> > Thanks.
> 
> I don't see that in the code.
> 
> I guess we'll need more info in find vqs about what can and what can't share irqs?

I mean we should add fallback code, for example if allocating interrupt for ctrlq
fails, we should clear the callback of ctrlq.

> Sharing between ctrl vq and config irq can also be an option.
> 

Not sure if this violates the spec. In the spec, used buffer notification and
configuration change notification are clearly defined - ctrlq is a virtqueue
and used buffer notification should be used.

Thanks.

> 
> 
> 
> > > 
> > > -- 
> > > MST
> > > 
> 
> 

