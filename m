Return-Path: <netdev+bounces-98700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0D68D21DB
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 18:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD16C1C22D1C
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A131172BC2;
	Tue, 28 May 2024 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8I5Lm4Z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7684716C86A
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914749; cv=none; b=g+C8+lUiGyp02IXOG9KEirP+5l2nQQAXJBAJwVEnMBQP4EYHIPPGNzi4kRPA14QQXuuTzh7mCDpr3OTSYF1E1m8t+isnDEPcdY6kOWFbGg9NFf1fW30CJep2FFV5l0TmDSiYBuMwe1P1fDPT8/3STbwxJv+MRTHwv4jdzy6KcMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914749; c=relaxed/simple;
	bh=iFNnuOu2HwWtWmWue9l7M2F5N/SbCFGvNbXjcJ7ZdJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joQD8otR+S94QwwVOrgK1nTZTP2s51YHGrjZpkqlL0uZZox6p67g3FgSbOBZHX2HkXx1DWjsam4k7qjOGmqHjN9Cb+nt/SkGijwy4LUCBI91vrXLTRrnJWYCaJdfN7dzwjyFg9k0Az3quiVLTswU42hehyVbMzLAyYc/d2g1xOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8I5Lm4Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716914746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wa5dly9dXKEpZgbrWQL2pjwW4nOpdYdwbtcWXOar958=;
	b=f8I5Lm4ZfLvhuWp1Kwc8OwCyx7/6nWHSevvV6lyR1Xjt5SyByKmEcaA/tUZcuSrTjC7cYe
	cmUuE7P2J/knWisBZBbJREVc9rAzz3BqTw/40b58uSdzaH3gxs5tHfo33raOLck3aJxm2M
	1vjo0Vn6RBpIXKmHMsyuaIPlwjshQV8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-f_RQtssnNaqxK_JUofmk_w-1; Tue, 28 May 2024 12:45:44 -0400
X-MC-Unique: f_RQtssnNaqxK_JUofmk_w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35858762c31so954541f8f.0
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 09:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716914744; x=1717519544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wa5dly9dXKEpZgbrWQL2pjwW4nOpdYdwbtcWXOar958=;
        b=nMc9YsoMLxiQqXQv9BjHW2SxtOlPORT72Bg3IR03cCyBAHcfm8jHrq1nAezuFk36RD
         lmDBVZ3PywTNVa9d4xU9oUSSsQT4RqNAiGgfTFU/4swXsw/dv0bX0X3gqHkSAbuxUzWp
         oHTWc3nIyW+QqMI1sLaLxIen0kGsujmCOTtucfjSfuZ0LpJJUPGatp7q3nLeFK5kjRAt
         cr1elmAy0nxe+EO/UVIsPZ+tPL4GtSv6ICv4r9xK3JRSpNmpcljEXaOzhSDR0tgpLb7Y
         xf50z8SKMbBqsYTGPx5ifc9TX0ROmZeewEslsO56CJnNbC+8w2spRh9cNW+5InPqu6/u
         EgMA==
X-Gm-Message-State: AOJu0Yw1lHCdpOK4m9Ida1RinEqmXcnixNhGb6Tzsf1Dp1MS91NCPfRo
	LyUdAA/X+WR/3fVzwT3tj2yn7wFo5oEtEubHAan0osr9mvFeGXUCQUQ8SGxO7DuSwCrXLkyujF+
	KlczekzsVLRKTFMpQPT/amLi3pASPHQWED6owhU3iRp4aNoAdqCcPjA==
X-Received: by 2002:a05:600c:4f48:b0:41f:c5c5:c9df with SMTP id 5b1f17b1804b1-421081dff05mr118456275e9.14.1716914743620;
        Tue, 28 May 2024 09:45:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBXW0wrd1ee1hCZrl8Yx0rQb9lk7S9zHjdf8iTXhqpiDFpcyGn/ILsKlm48qukSntx6bMJEw==
X-Received: by 2002:a05:600c:4f48:b0:41f:c5c5:c9df with SMTP id 5b1f17b1804b1-421081dff05mr118455715e9.14.1716914742696;
        Tue, 28 May 2024 09:45:42 -0700 (PDT)
Received: from redhat.com ([2.55.190.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ae866sm147498295e9.34.2024.05.28.09.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 09:45:42 -0700 (PDT)
Date: Tue, 28 May 2024 12:45:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [PATCH net 2/2] virtio_net: fix missing lock protection on
 control_buf access
Message-ID: <20240528124435-mutt-send-email-mst@kernel.org>
References: <20240528075226.94255-1-hengqi@linux.alibaba.com>
 <20240528075226.94255-3-hengqi@linux.alibaba.com>
 <20240528114547-mutt-send-email-mst@kernel.org>
 <1716912105.4028382-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1716912105.4028382-1-hengqi@linux.alibaba.com>

On Wed, May 29, 2024 at 12:01:45AM +0800, Heng Qi wrote:
> On Tue, 28 May 2024 11:46:28 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Tue, May 28, 2024 at 03:52:26PM +0800, Heng Qi wrote:
> > > Refactored the handling of control_buf to be within the cvq_lock
> > > critical section, mitigating race conditions between reading device
> > > responses and new command submissions.
> > > 
> > > Fixes: 6f45ab3e0409 ("virtio_net: Add a lock for the command VQ.")
> > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > 
> > 
> > I don't get what does this change. status can change immediately
> > after you drop the mutex, can it not? what exactly is the
> > race conditions you are worried about?
> 
> See the following case:
> 
> 1. Command A is acknowledged and successfully executed by the device.
> 2. After releasing the mutex (mutex_unlock), process P1 gets preempted before
>    it can read vi->ctrl->status, *which should be VIRTIO_NET_OK*.
> 3. A new command B (like the DIM command) is issued.
> 4. Post vi->ctrl->status being set to VIRTIO_NET_ERR by
>    virtnet_send_command_reply(), process P2 gets preempted.
> 5. Process P1 resumes, reads *vi->ctrl->status as VIRTIO_NET_ERR*, and reports
>    this error back for Command A. <-- Race causes incorrect results to be read.
> 
> Thanks.


Why is it important that P1 gets VIRTIO_NET_OK?
After all it is no longer the state.

> > 
> > > ---
> > >  drivers/net/virtio_net.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 6b0512a628e0..3d8407d9e3d2 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -2686,6 +2686,7 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
> > >  {
> > >  	struct scatterlist *sgs[5], hdr, stat;
> > >  	u32 out_num = 0, tmp, in_num = 0;
> > > +	bool ret;
> > >  	int err;
> > >  
> > >  	/* Caller should know better */
> > > @@ -2731,8 +2732,9 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
> > >  	}
> > >  
> > >  unlock:
> > > +	ret = vi->ctrl->status == VIRTIO_NET_OK;
> > >  	mutex_unlock(&vi->cvq_lock);
> > > -	return vi->ctrl->status == VIRTIO_NET_OK;
> > > +	return ret;
> > >  }
> > >  
> > >  static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> > > -- 
> > > 2.32.0.3.g01195cf9f
> > 


