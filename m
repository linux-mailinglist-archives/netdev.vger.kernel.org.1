Return-Path: <netdev+bounces-98690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2D28D217C
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 18:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F06288A6A
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C172117279E;
	Tue, 28 May 2024 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kkkr3ulj"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE8D172799
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716913149; cv=none; b=bUFeCAb6qM+y5Y8BTwV2ZtEr4kH7g7rwccX6sv8gftIXLIqHT0lrOFuBE3J7yx65PH/EiJAtxqs7ACIWgwiEnzFwK2sMViMqg7j1UO5EfZFxB63nEAr+8FiexpS8q6lXC7CxxS0oqVYNfs7VReBgtpUASQ6K2+ykZkFxPNIkYIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716913149; c=relaxed/simple;
	bh=aFJE0xOfrdA+IhWVa3bl7TWEo1rOmvHpNsX5DdYQOa8=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=lfT1Lp8giQIN+HJmo1wLiPOYUh+r0FkQtz4dyceh5moZ3vuSx81jR2Wr+5I8xJIqxVR3bR0ft4z1gNc90wK3Hwepk2XAo5E7kkKZWU/b3TbTDNgGmEvDcLf6axAFeblk9zmatNCI9mG/wFgwH+OzfDQ0UxE5KmgIyogtqdP+N/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kkkr3ulj; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716913143; h=Message-ID:Subject:Date:From:To;
	bh=CKy1yn8mfMmdEgP+e0Xom04ZDQhZifO2CQTZV/20VI8=;
	b=kkkr3ulj9AHFURhlagP7S+tdWSkuysjVFXORoITotseAFiHd1nP+gkdroPsQDhGny99+wjW8rrdigPiaoBOFKfVsRYFMHkPvjamNnln4ACwIB/yBgceQRYfsGWNluRFh42nUhEAq8qJ7M1aYYDqCUgU5KTcI9P7rWeVvjcYNfew=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W7Q4PRA_1716913142;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7Q4PRA_1716913142)
          by smtp.aliyun-inc.com;
          Wed, 29 May 2024 00:19:02 +0800
Message-ID: <1716912105.4028382-1-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net 2/2] virtio_net: fix missing lock protection on control_buf access
Date: Wed, 29 May 2024 00:01:45 +0800
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
 Paolo Abeni <pabeni@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Daniel Jurgens <danielj@nvidia.com>
References: <20240528075226.94255-1-hengqi@linux.alibaba.com>
 <20240528075226.94255-3-hengqi@linux.alibaba.com>
 <20240528114547-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240528114547-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 28 May 2024 11:46:28 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Tue, May 28, 2024 at 03:52:26PM +0800, Heng Qi wrote:
> > Refactored the handling of control_buf to be within the cvq_lock
> > critical section, mitigating race conditions between reading device
> > responses and new command submissions.
> > 
> > Fixes: 6f45ab3e0409 ("virtio_net: Add a lock for the command VQ.")
> > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> 
> 
> I don't get what does this change. status can change immediately
> after you drop the mutex, can it not? what exactly is the
> race conditions you are worried about?

See the following case:

1. Command A is acknowledged and successfully executed by the device.
2. After releasing the mutex (mutex_unlock), process P1 gets preempted before
   it can read vi->ctrl->status, *which should be VIRTIO_NET_OK*.
3. A new command B (like the DIM command) is issued.
4. Post vi->ctrl->status being set to VIRTIO_NET_ERR by
   virtnet_send_command_reply(), process P2 gets preempted.
5. Process P1 resumes, reads *vi->ctrl->status as VIRTIO_NET_ERR*, and reports
   this error back for Command A. <-- Race causes incorrect results to be read.

Thanks.

> 
> > ---
> >  drivers/net/virtio_net.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 6b0512a628e0..3d8407d9e3d2 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2686,6 +2686,7 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
> >  {
> >  	struct scatterlist *sgs[5], hdr, stat;
> >  	u32 out_num = 0, tmp, in_num = 0;
> > +	bool ret;
> >  	int err;
> >  
> >  	/* Caller should know better */
> > @@ -2731,8 +2732,9 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
> >  	}
> >  
> >  unlock:
> > +	ret = vi->ctrl->status == VIRTIO_NET_OK;
> >  	mutex_unlock(&vi->cvq_lock);
> > -	return vi->ctrl->status == VIRTIO_NET_OK;
> > +	return ret;
> >  }
> >  
> >  static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> > -- 
> > 2.32.0.3.g01195cf9f
> 

