Return-Path: <netdev+bounces-123375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F690964A3D
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A3B1F23E40
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109431B3B17;
	Thu, 29 Aug 2024 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="n2eamTJI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C261B374E
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724945980; cv=none; b=ilZzQ19ZQ89oIb6FnSzVRuohGhNzysMQLWuRowD+epRbFb3KlVfRkmSuc7xibmLtZ5+JusUlEu4tqUj6rsbcnzBZsyKfWcK0oF2+55YIKEnuFnff+desCvnhk7VgUmWfcZmEFVqoT2plT9+VRXEwpEqx/Fmzs5jxZXN/ubBNwtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724945980; c=relaxed/simple;
	bh=3VMZJqONVQR9wtdnyuCO/ZBwx7UloXNwmvHIHz8VqnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKvzquwb1Ahx68CVqCD9PyRWq86siwEg9U37MYOvL0Rf3eUCLBJbcCmne5xHv6AFvibJYbxvvIFqtaZSRJz3veSdAR17L/Mpcisu5soma24D+9l0PirW7LElclqwZDrKRDl7n+zkadgo08obIZYjPChfMfVvJriqHVrbCYjIsZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=n2eamTJI; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a868d7f92feso95546066b.2
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 08:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1724945975; x=1725550775; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uW/PdravxcZkD2m2WNuCwaA2sDqSzWun+0WvkhUtIDg=;
        b=n2eamTJIaSk3n2v4fQNS2zdwvLUtpxbPajaZmw/4qO9VN00CX94Hn4/qo4DNxeaqeK
         Jc0ScvkTiWtLEJOcn17Q531uta8sxgvk6n5Xqq+I5ywhgwG0gj4awll9CgO4LZ8Y91at
         gCHccjpCOh4gdKDxhDYmzvu02+QEPHmLRIRSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724945975; x=1725550775;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uW/PdravxcZkD2m2WNuCwaA2sDqSzWun+0WvkhUtIDg=;
        b=W5IQaiFfDbvqsOmfH2PQnlmQVHK3o1Ms+qrP4nEFSX8ZF3rrqOmJ71EIys2O9M8DKm
         6nCqj4uiB/uLDA/G2v7W3v9txto+eRhlDYS1FTcO0kAvJ45qi6m8OOZCWw0DsJyHATFy
         /Gd+tpIlnWBHEzu0rdqoT5EJ2eo8/O3fVPq/uAuz089NsnMGUcwgkrZgfifGr9mtldpN
         tRL80kVdjKWptgJDvaMY5I48gzPwB+CHgI2sWEFtrJaTbCiMMx2j0ag7PwgUMbHPt6jp
         pk63lty8d5Pw939/l8H1+nMq1VxURa7SKJAgRtYAKi1mveRHeXZ27kFSyAEBGF/T9Brv
         yx+Q==
X-Gm-Message-State: AOJu0YxWnhwgdJOGbh/8qGtlOAXj8Xl352ETVpY3+F1i3Xji0E9vY7bE
	6ZthpLhbIGbzVM/Zg/FibNbhfDeWKMVFZMfVFpTe6nAlRwK9Z4ceWYBg7+z1JMg=
X-Google-Smtp-Source: AGHT+IF1/XySUQDJPYMQIvpr5CxHLJNvYYXMvfBFoyADKxI+ochdqOgg9LZ7CiukkNaTPxdzdV+TZg==
X-Received: by 2002:a17:907:2d07:b0:a7d:a29e:5c41 with SMTP id a640c23a62f3a-a897f8e7272mr258940966b.40.1724945974643;
        Thu, 29 Aug 2024 08:39:34 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989021973sm91689766b.82.2024.08.29.08.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 08:39:34 -0700 (PDT)
Date: Thu, 29 Aug 2024 16:39:32 +0100
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
Message-ID: <ZtCWNAxXV6JmYXND@LQ3V64L9R2>
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
 <ZtCTgEEgcL3XqQcO@LQ3V64L9R2>
 <CANn89iJgXsn7yjWaiuuq=LFsKpQi8RQFo89MDRxeNddxeZUC2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJgXsn7yjWaiuuq=LFsKpQi8RQFo89MDRxeNddxeZUC2A@mail.gmail.com>

On Thu, Aug 29, 2024 at 05:31:30PM +0200, Eric Dumazet wrote:
> On Thu, Aug 29, 2024 at 5:28 PM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Thu, Aug 29, 2024 at 03:48:05PM +0200, Eric Dumazet wrote:
> > > On Thu, Aug 29, 2024 at 3:13 PM Joe Damato <jdamato@fastly.com> wrote:
> > > >
> > > > Allow per-NAPI gro_flush_timeout setting.
> > > >
> > > > The existing sysfs parameter is respected; writes to sysfs will write to
> > > > all NAPI structs for the device and the net_device gro_flush_timeout
> > > > field.  Reads from sysfs will read from the net_device field.
> > > >
> > > > The ability to set gro_flush_timeout on specific NAPI instances will be
> > > > added in a later commit, via netdev-genl.
> > > >
> > > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > > Reviewed-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > > > Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > > > ---
> > > >  include/linux/netdevice.h | 26 ++++++++++++++++++++++++++
> > > >  net/core/dev.c            | 32 ++++++++++++++++++++++++++++----
> > > >  net/core/net-sysfs.c      |  2 +-
> > > >  3 files changed, 55 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > > index 7d53380da4c0..d00024d9f857 100644
> > > > --- a/include/linux/netdevice.h
> > > > +++ b/include/linux/netdevice.h
> > > > @@ -372,6 +372,7 @@ struct napi_struct {
> > > >         int                     rx_count; /* length of rx_list */
> > > >         unsigned int            napi_id;
> > > >         int                     defer_hard_irqs;
> > > > +       unsigned long           gro_flush_timeout;
> > > >         struct hrtimer          timer;
> > > >         struct task_struct      *thread;
> > > >         /* control-path-only fields follow */
> > > > @@ -557,6 +558,31 @@ void napi_set_defer_hard_irqs(struct napi_struct *n, int defer);
> > > >   */
> > > >  void netdev_set_defer_hard_irqs(struct net_device *netdev, int defer);
> > > >
> > >
> > > Same remark :  dev->gro_flush_timeout is no longer read in the fast path.
> > >
> > > Please move gro_flush_timeout out of net_device_read_txrx and update
> > > Documentation/networking/net_cachelines/net_device.rst
> >
> > Is there some tooling I should use to generate this file?
> >
> > I am asking because it seems like the file is missing two fields in
> > net_device at the end of the struct:
> >
> > struct hlist_head          page_pools;
> > struct dim_irq_moder *     irq_moder;
> >
> 
> At first glance this is control path only, no big deal.

My plan was to move both fields you pointed out in my series to the
end of the struct (there is a big enough hole for both) and move
them to the bottom of this doc file (with just Type and Name, of
course).

The two fields (page_pools, irq_moder) being missing made me unsure
if I was planning on doing the right thing for the v2.
 
> > Both of which seem to have been added just before and long after
> > (respectively) commit 14006f1d8fa2 ("Documentations: Analyze heavily
> > used Networking related structs").
> >
> > If this is a bug, I can submit one patch (with two fixes tags) which
> > adds both fields to the file?
> 
> No need for a Fixes: tag for this, just submit to net-next.
> 
> This file is really 'needed' for current development, for people
> caring about data locality.

Will do; thanks for the guidance.

