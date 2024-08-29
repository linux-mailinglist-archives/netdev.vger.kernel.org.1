Return-Path: <netdev+bounces-123303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE56964753
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE531C224E5
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 13:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9186B1AC44F;
	Thu, 29 Aug 2024 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qnkoyHCO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C360118DF90
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724939870; cv=none; b=KrlvF+1lKms/HeV2LiVu4CwMPY1b1pGjbNMoF2cBlB2WUf5vhYoD8ZWXjDuwsLlqM0OfLSQ4esXBnlSOcYU1NHasPtXgr6XnuXDm7Lbug3ydTiYbfmm3C9UZ0Mj8GbwJ9xHAmHyKPf95AqxiN7Qs77Q0bFgvKCJYdj9oM+W+y5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724939870; c=relaxed/simple;
	bh=aAaeMEKKUf0lY+Ch3OCRX9KFRGPFr3Fe+OwkVaMvlGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFLpI8p9K7Gv/3FwlczY7mpcrSWKaes89H3XuBCP7BhyhnWTfjW4sK/RISnxnqHAMHSnGh1r+ca2Ycx0LRpQGbd3q3qxEC06EKDvDeKPVD/Btw5ZHR1OWeFGYt7jOLN/8acStDPW5yGu8YMOlGC3Qm9TTf4vi762E9eF3Szh744=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qnkoyHCO; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bed83488b6so740515a12.2
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 06:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1724939867; x=1725544667; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h2gGqR0ue6Sz02StJxUbNnShrWM0kJ8kSFj/oBxzkSM=;
        b=qnkoyHCOH0RF2xT9fNFHhJ0VQSDKPi/2CEHjzXf37HqhN7Qc6Xb7ggGyEEl1xfrEsD
         3BTXi3sXaNbOPyODbaLgu9nX7gdsmsE4DZTc3QehsAfjCzi9dEATRxYxZTvnZ2AePBld
         xD2stj5VyLXYCDEwCkSt2gMdo49zbaomeQWkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724939867; x=1725544667;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h2gGqR0ue6Sz02StJxUbNnShrWM0kJ8kSFj/oBxzkSM=;
        b=FdcNfacXq2BiSLTls03wcPO9+gsmg3DPHQ50CxJrfrukERRVD9fhJWVoc1e3drYW8y
         dOksp9o+twK1NvK4IV7uaeY6uIK5GBaksPe/449sGQ8zAsfkWPxgffpS5E9+P4OK/m4/
         zPlDOsq4/q+aPF5teEWr30c1paLuG9k30WWsAnODy05Vwihwkr5uQUZGfIMXl5jIt+qB
         SJORXqBeutOu8ULk23Z8zy5fMV3ubxRwABxWsmN99DK0PTy8x4eA8xvSp7ZanJKdIeLT
         kdIDd5RBl1mh1IJMpNKMFzbzmbGXiq67PhFSDEftINAcsnaQqpHTbmOonI1BjyY+UTCD
         WsOg==
X-Gm-Message-State: AOJu0YzyoQd5nxNpnFUvXQTzApKOpjPqeAEQNA8eC+euvHZ4SKSK2Pli
	Pob1nC61ZbBeCMAHUJFKPHCTb4ZPs62/tNPsEMfx/jZ4ZdEWOuo+NZQDyFGCRhE=
X-Google-Smtp-Source: AGHT+IFWlMQE5BE0mOF4xapjpI537bzGB827eRSNxKW3GxEaAZxX5+mJ1A04QSiRHHGCsTxl9GE6mg==
X-Received: by 2002:a05:6402:2112:b0:5c0:a8ba:3c41 with SMTP id 4fb4d7f45d1cf-5c21ed2ffd0mr2687284a12.8.1724939866518;
        Thu, 29 Aug 2024 06:57:46 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989021983sm82713866b.84.2024.08.29.06.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 06:57:45 -0700 (PDT)
Date: Thu, 29 Aug 2024 14:57:43 +0100
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
	hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	kuba@kernel.org, Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/5] net: napi: Make gro_flush_timeout per-NAPI
Message-ID: <ZtB-V5cQl0Eoiw68@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	sdf@fomichev.me, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, willemdebruijn.kernel@gmail.com,
	skhawaja@google.com, kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240829131214.169977-1-jdamato@fastly.com>
 <20240829131214.169977-4-jdamato@fastly.com>
 <CANn89iKUqF5bO_Ca+qrfO_gsfWmutpzFL-ph5mQd86_2asW9dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKUqF5bO_Ca+qrfO_gsfWmutpzFL-ph5mQd86_2asW9dg@mail.gmail.com>

On Thu, Aug 29, 2024 at 03:48:05PM +0200, Eric Dumazet wrote:
> On Thu, Aug 29, 2024 at 3:13 PM Joe Damato <jdamato@fastly.com> wrote:
> >
> > Allow per-NAPI gro_flush_timeout setting.
> >
> > The existing sysfs parameter is respected; writes to sysfs will write to
> > all NAPI structs for the device and the net_device gro_flush_timeout
> > field.  Reads from sysfs will read from the net_device field.
> >
> > The ability to set gro_flush_timeout on specific NAPI instances will be
> > added in a later commit, via netdev-genl.
> >
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > Reviewed-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > ---
> >  include/linux/netdevice.h | 26 ++++++++++++++++++++++++++
> >  net/core/dev.c            | 32 ++++++++++++++++++++++++++++----
> >  net/core/net-sysfs.c      |  2 +-
> >  3 files changed, 55 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 7d53380da4c0..d00024d9f857 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -372,6 +372,7 @@ struct napi_struct {
> >         int                     rx_count; /* length of rx_list */
> >         unsigned int            napi_id;
> >         int                     defer_hard_irqs;
> > +       unsigned long           gro_flush_timeout;
> >         struct hrtimer          timer;
> >         struct task_struct      *thread;
> >         /* control-path-only fields follow */
> > @@ -557,6 +558,31 @@ void napi_set_defer_hard_irqs(struct napi_struct *n, int defer);
> >   */
> >  void netdev_set_defer_hard_irqs(struct net_device *netdev, int defer);
> >
> 
> Same remark :  dev->gro_flush_timeout is no longer read in the fast path.
> 
> Please move gro_flush_timeout out of net_device_read_txrx and update
> Documentation/networking/net_cachelines/net_device.rst

Thanks, Eric. I will take care of both in the v2.

