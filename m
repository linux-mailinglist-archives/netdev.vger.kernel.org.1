Return-Path: <netdev+bounces-121502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBE995D7B4
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 22:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E741C2313C
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 20:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD6919408C;
	Fri, 23 Aug 2024 20:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="sjxe3Usi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BE2149C7E
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 20:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444156; cv=none; b=W9ZTfc+6aK8PXj6VBjDOF8o08+2Y6HpDYUNLcCSCx8Avk5xRKmbGwfqw2LmftEbyGXapKrzDPD1uwAb7ea2gjrk5kjSeUvUKDQ5OFSnleLVtQPFM/HE6Lag/1ORa9dmNEV89aLJCjGdetEtXeBiiGLORayhpTQPYGqqqBeSUULY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444156; c=relaxed/simple;
	bh=nc8WEFOsdWUuzawTIRKrp1AuH0gA1orr36E/e+nLHhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUFDYm8PniiILzlcI1H/EiV1Y3oNjbrlGV7hxTbSihM/AK2/R9e6mbG6c5kzYiFpQWsVJC+3Bl5LYJmAMhKVNlW7J72WsWoLSg5flLGyE7yHkmsJW+5NClQb3p2sGkSzA9kfeU5ZN3SZu6J9TK+FaJJJA8usYr8GITYzzwUpV98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=sjxe3Usi; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a86933829dcso273551666b.3
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1724444152; x=1725048952; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TvepJA4PZWA959Ft+rZeK+/JSerRWD/WGD1+NbMgnLs=;
        b=sjxe3UsipnfDUe/BhSJ582HWh6TTXvX4E5s91F72juTLUaLxUVCQGOqf7m8xvsamqj
         tkj0fwCWRU/ejCnQSLWey0BTPy5ZOUZ69QmKGqWWX4VrXRk/9ErgHULIw4ORuW8e2JEA
         Bz8YqNz3tiwPZ45VuKA37/Jzf5hVhimIBa61k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724444152; x=1725048952;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TvepJA4PZWA959Ft+rZeK+/JSerRWD/WGD1+NbMgnLs=;
        b=uSTKNwT9udgbojOvDf7+iquF5beAW6wyyWxVdCKc50tHMPwsx7FoSU7z5kMVn8NOnD
         gfMIbcFNgjsou5PQJIjtQgggNvUrstYi/A9SooKZyk72ef/MNyyhcZufUiiQNyh0Xwib
         vpqU8X3IkO2kBSeS2/RHRqpVmHkOac4flURB7Ngwohh0n9clAhyWEzyV1MIMgXU5S4WG
         457hIB8UkDA0PTmjhrQFXx/2W90yet9eYBPZFQCZVVMyEUS6rgZ+sOmOJ80C6gFK5J4m
         AnfK1vqO+UnJPK7dQa/C/fHEerraLtA7sRMzgNqq87StkuFpD94IC49PfoMftKG/u5sk
         JWeg==
X-Gm-Message-State: AOJu0YyD8DNlAzdoqaUCQ18uO2+ssS6E1i50wVjRywAsumQVluDXuV1B
	hKRogYWvOIwqWmV7uQp4WIl9aHEm8FBbfP3PIKkTsi+svKwlds9Sx/T65K4M1Pg=
X-Google-Smtp-Source: AGHT+IFdDxBzJQY3oD6t/LoSsgJYuNnoWg3jkhc/eSKhhrbO26MmxuFE6Wy7/Rcq2eO3fyR28pSd6Q==
X-Received: by 2002:a17:907:7203:b0:a83:8591:7505 with SMTP id a640c23a62f3a-a86a54de3c3mr204032566b.59.1724444151417;
        Fri, 23 Aug 2024 13:15:51 -0700 (PDT)
Received: from LQ3V64L9R2 ([185.226.39.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f436be2sm303374266b.138.2024.08.23.13.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 13:15:51 -0700 (PDT)
Date: Fri, 23 Aug 2024 21:15:49 +0100
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, willemdebruijn.kernel@gmail.com,
	skhawaja@google.com, kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/6] net: Add sysfs parameter irq_suspend_timeout
Message-ID: <Zsjt9XwIiqAVk0Et@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	sdf@fomichev.me, peter@typeblog.net, m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com, hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	kuba@kernel.org, Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240823173103.94978-1-jdamato@fastly.com>
 <20240823173103.94978-2-jdamato@fastly.com>
 <CANn89iJE01V4TBCXg=w=M8=75TXypuYMJ_pXBUrN9NdRRAtAZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJE01V4TBCXg=w=M8=75TXypuYMJ_pXBUrN9NdRRAtAZg@mail.gmail.com>

On Fri, Aug 23, 2024 at 07:39:56PM +0200, Eric Dumazet wrote:
> On Fri, Aug 23, 2024 at 7:31 PM Joe Damato <jdamato@fastly.com> wrote:
> >
> > From: Martin Karsten <mkarsten@uwaterloo.ca>
> >
> > This patch doesn't change any behavior but prepares the code for other
> > changes in the following commits which use irq_suspend_timeout as a
> > timeout for IRQ suspension.
> >
> > Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > Co-developed-by: Joe Damato <jdamato@fastly.com>
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > Tested-by: Joe Damato <jdamato@fastly.com>
> > Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > ---
> >  rfc -> v1:
> >    - Removed napi.rst documentation from this patch; added to patch 6.
> >
> >  include/linux/netdevice.h |  2 ++
> >  net/core/dev.c            |  3 ++-
> >  net/core/net-sysfs.c      | 18 ++++++++++++++++++
> >  3 files changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 0ef3eaa23f4b..31867bb2ff65 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -1857,6 +1857,7 @@ enum netdev_reg_state {
> >   *     @gro_flush_timeout:     timeout for GRO layer in NAPI
> >   *     @napi_defer_hard_irqs:  If not zero, provides a counter that would
> >   *                             allow to avoid NIC hard IRQ, on busy queues.
> > + *     @irq_suspend_timeout:   IRQ suspension timeout
> >   *
> >   *     @rx_handler:            handler for received packets
> >   *     @rx_handler_data:       XXX: need comments on this one
> > @@ -2060,6 +2061,7 @@ struct net_device {
> >         struct netdev_rx_queue  *_rx;
> >         unsigned long           gro_flush_timeout;
> >         int                     napi_defer_hard_irqs;
> > +       unsigned long           irq_suspend_timeout;
> >         unsigned int            gro_max_size;
> >         unsigned int            gro_ipv4_max_size;
> >         rx_handler_func_t __rcu *rx_handler;
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index e7260889d4cb..3bf325ec25a3 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -11945,6 +11945,7 @@ static void __init net_dev_struct_check(void)
> >         CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, _rx);
> >         CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_flush_timeout);
> >         CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, napi_defer_hard_irqs);
> > +       CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, irq_suspend_timeout);
> >         CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_max_size);
> >         CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_ipv4_max_size);
> >         CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, rx_handler);
> > @@ -11956,7 +11957,7 @@ static void __init net_dev_struct_check(void)
> >  #ifdef CONFIG_NET_XGRESS
> >         CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, tcx_ingress);
> >  #endif
> > -       CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx, 104);
> > +       CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx, 112);
> >  }
> >
> >  /*
> > diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> > index 0e2084ce7b75..fb6f3327310f 100644
> > --- a/net/core/net-sysfs.c
> > +++ b/net/core/net-sysfs.c
> > @@ -440,6 +440,23 @@ static ssize_t napi_defer_hard_irqs_store(struct device *dev,
> >  }
> >  NETDEVICE_SHOW_RW(napi_defer_hard_irqs, fmt_dec);
> >
> > +static int change_irq_suspend_timeout(struct net_device *dev, unsigned long val)
> > +{
> > +       WRITE_ONCE(dev->irq_suspend_timeout, val);
> > +       return 0;
> > +}
> > +
> > +static ssize_t irq_suspend_timeout_store(struct device *dev,
> > +                                        struct device_attribute *attr,
> > +                                        const char *buf, size_t len)
> > +{
> > +       if (!capable(CAP_NET_ADMIN))
> > +               return -EPERM;
> > +
> > +       return netdev_store(dev, attr, buf, len, change_irq_suspend_timeout);
> > +}
> > +NETDEVICE_SHOW_RW(irq_suspend_timeout, fmt_ulong);
> > +
> >  static ssize_t ifalias_store(struct device *dev, struct device_attribute *attr,
> >                              const char *buf, size_t len)
> >  {
> > @@ -664,6 +681,7 @@ static struct attribute *net_class_attrs[] __ro_after_init = {
> >         &dev_attr_tx_queue_len.attr,
> >         &dev_attr_gro_flush_timeout.attr,
> >         &dev_attr_napi_defer_hard_irqs.attr,
> > +       &dev_attr_irq_suspend_timeout.attr,
> >         &dev_attr_phys_port_id.attr,
> >         &dev_attr_phys_port_name.attr,
> >         &dev_attr_phys_switch_id.attr,
> > --
> > 2.25.1
> 
> 
> Please no more per-device sysfs entry, shared by all the users of the device.
> 
> Let's not repeat past mistakes.
> 
> Nowadays, we need/want per receive-queue tuning, preferably set with netlink.

Thanks for the feedback, Eric. We appreciate your consideration
and guidance.

May we ask what your thoughts are, overall, about getting a
mechanism like this accepted?

We want to make sure that this, in principle, is acceptable before
iterating further and going down the path of netlink, if required.

On the specific netlink bit in your comment, we agree in principle,
however:

  1. Our code integrates directly with existing sysfs parameters.
     If we make our parameter settable via netlink, but the others
     remain as sysfs parameters then the interface for users
     becomes a bit cumbersome.

     And, so the urge will be to move all parameters to netlink
     for ease of use for the user.

     As we mentioned in our cover letter: we agree that doing so is
     a good idea, but we hope to convince you (and the other
     maintainers) that the netlink work can come later as a separate
     change which affects the existing parameters we integrate with
     as well as the parameter we are introducing, at the same time.

  2. The proposed mechanism yields a substantial performance and
     efficiency improvement which would be valuable to users. It would
     be unfortunate to block until all of this could be moved to
     netlink, first.

  3. While adding a new sysfs parameter does affect the ABI
     permanently, it doesn't prevent us from making these parameters
     per-NAPI in the future. This series adds strength to the argument
     that these parameters should be per-NAPI because our results show
     the impact these parameters can have on network processing very
     clearly in a range of scenarios.

We appreciate your thoughts on the above as we want to ensure we
are moving in the right direction.

