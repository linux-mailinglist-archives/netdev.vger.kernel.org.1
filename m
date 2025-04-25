Return-Path: <netdev+bounces-186164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C07A9D56A
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 00:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B159463EDC
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 22:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A974E290BCF;
	Fri, 25 Apr 2025 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Kio6Ze77"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D696C290BC1
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 22:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745619889; cv=none; b=cn75g5V4aXP44bs/QHzxocBbssCC5wqxvQ0UdXkRXz2tEN99Lvn/32wCrUAFSszwiiOIUCZJqhyU9yEnUJ6+O68BKNUPcW3OMktfva7inE2b7swNNjwwIZG43haGYwYhCdSW4vyfVd1HGD9yBBJNC0qYP0wB464L3DwZbO2GqDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745619889; c=relaxed/simple;
	bh=x1Y1CJAcekcz406gLS6UC7fsR97m+7ARrxtK4isq7p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6IV9q8JxF8GMiXU+HKhBDRIEKWBux86vbj0+XXEBuyn6UHylPvUZortds6B/140kpwWtKFuIP4j4PtrPRzET88TnQ7ZLDJHHb2D09OIXzhjl9ZVpr5sn3kBBm1oKOdSWb0RibICbW/usgVAWX04PRtQiNud23pYs6K68l946FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Kio6Ze77; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-306b6ae4fb3so3048287a91.1
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 15:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745619887; x=1746224687; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UeGooiAExd8K3ICQosGoBtMG2T8YRJCy5Wwx5VmjWPU=;
        b=Kio6Ze77e97F8CtJCBLmbX5rVvN3NIwpiAttIWnu6LLT2OLa6g3hoLRM1YAxqej0rH
         5DfXJcHuEyDNeikX92WSH98XhCqMxWCBdJN4s7GUxYOgl5Qly5ejStz+z2dRZYPI9J7z
         gZFtN9L3OYkjqvt/oZHaUME51FPliGAcvWm0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745619887; x=1746224687;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UeGooiAExd8K3ICQosGoBtMG2T8YRJCy5Wwx5VmjWPU=;
        b=HdUjbGOXtublTS1HZrvI/l69HtTEfs9T3QZTGzm+A5/hh7ltp31OY9ukyq0x16GW07
         pcAs+7pm9q2PVsVEOkO0kQ8roUvLRgyKArfEr8hRqeS8ygvDb+gTQX3v4ts67Qzvvk/m
         +94chBinXDC9D9QGX5qTWhxmctkr6UfBIjPG+mL3P6T4VeM2gERoYlwnb0wYucGG1Hix
         /OSOCG9PpjWLhP573hCyQFk+wFPsuDwNbUrk3nprp1yMtgY7wQzeh7aOe1PE4B6CPDpq
         MFP9HDWDjO3lEFt4FCOKjLQGkQ9mUchSFJB6CJR98d23oTqEgWM3jRaIYFNMo/HqPEpo
         lwmg==
X-Forwarded-Encrypted: i=1; AJvYcCWTfoE3Yj8RwTPNJ5GIaIXK9EKALG23G8twnJJsBEdTR4eCCu1jiVRXHf9PYWU6GkdGqmcyp8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzquMPxIdvoGpm0BpGE9PObFT9htlPU+l2p0VfG++QAjMRHK5kN
	HNzUpabLgrGWwK4hu5r5Y5Rvrls8gZpqPUHZ6u+tQ8+2umoC8LabRcLWuYCQbac=
X-Gm-Gg: ASbGncsuOhVnxNJOkpIdYSQtEoT8KZwTJoEPHYCQbh4HT87C+ZwClmEtoz/RIxRRMnx
	BVB6PeRQkkuUfGUFemiqK0YROVTaM9+oNOyBBudlGy3iWWI70NK/a3/c+g9zDA0QmJ9VfP6+k7o
	uWFB5Gtfu6Yb3eagoZdvZMmcmX+ckOXNnt4BTlV+jbHZaZ7hv1/d0fmMxKh7vKGvoS1ykRdZus5
	xWwaAVwXYnz8gQN5sOjtQB9Dsm++Z4yeUz+/qYoj3ZxlS7Fu7ERYpIrH6BD1Zf3T4jEAgF8GoCO
	goUIpxbqnZdeSz5z1NqMctrOgVaI9auIzjvxBKCWmOBMZPTik8eOc55d8C6jqv5vVmSl09h24Ai
	dTjjmToXPLGP7
X-Google-Smtp-Source: AGHT+IEZJInDbxGpMB24rDpi/dYHLq4uIjOuODQPy8lHYv4M2G/7lzTFbXdFzLAkcOu+uU3CX4RItA==
X-Received: by 2002:a17:90b:2e49:b0:2ff:53a4:74f0 with SMTP id 98e67ed59e1d1-30a013d7f70mr1480519a91.29.1745619887041;
        Fri, 25 Apr 2025 15:24:47 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309f77371efsm2481750a91.9.2025.04.25.15.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 15:24:46 -0700 (PDT)
Date: Fri, 25 Apr 2025 15:24:43 -0700
From: Joe Damato <jdamato@fastly.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5] Add support to set napi threaded for
 individual napi
Message-ID: <aAwLq-G6qng7L2XX@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
References: <20250423201413.1564527-1-skhawaja@google.com>
 <aArFm-TS3Ac0FOic@LQ3V64L9R2>
 <CAAywjhQhH5ctp_PSgDuw4aTQNKY8V5vbzk9pYd1UBXtDV4LFMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAywjhQhH5ctp_PSgDuw4aTQNKY8V5vbzk9pYd1UBXtDV4LFMA@mail.gmail.com>

On Fri, Apr 25, 2025 at 11:28:11AM -0700, Samiullah Khawaja wrote:
> On Thu, Apr 24, 2025 at 4:13 PM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Wed, Apr 23, 2025 at 08:14:13PM +0000, Samiullah Khawaja wrote:

[...]

> > Thanks; I think this is a good change on its own separate from the
> > rest of the series and, IMO, I think it makes it easier to get
> > reviewed and merged.
> Thanks for the review and suggestion to split this out.

Sure. Up to you if you want to split it out or not.

[...]

> > > +
> > >  int dev_set_threaded(struct net_device *dev, bool threaded)
> > >  {
> > >       struct napi_struct *napi;
> > > @@ -7144,6 +7165,8 @@ static void napi_restore_config(struct napi_struct *n)
> > >               napi_hash_add(n);
> > >               n->config->napi_id = n->napi_id;
> > >       }
> > > +
> > > +     napi_set_threaded(n, n->config->threaded);
> >
> > It makes sense to me that when restoring the config, the kthread is
> > kicked off again (assuming config->thread > 0), but does the
> > napi_save_config path need to stop the thread?
> 
> >
> > Not sure if kthread_stop is hit via some other path when
> > napi_disable is called? Can you clarify?
> NAPI kthread are not stopped when napi is disabled. When napis are
> disabled, the NAPI_STATE_DISABLED state is set on them and the
> associated thread goes to sleep after unsetting the STATE_SCHED. The
> kthread_stop is only called on them when NAPI is deleted. This is the
> existing behaviour. Please see napi_disable implementation for
> reference. Also napi_enable doesn't create a new kthread and just sets
> the napi STATE appropriately and once the NAPI is scheduled again the
> thread is woken up. Please seem implementation of napi_schedule for
> reference.

Yea but seems:
  - Weird from a user perspective, and
  - Keeps the pid around as shown below even if threaded NAPI is
    inactive, which seems weird, too.

> > I ran the test and it passes for me.
> >
> > That said, the test is incomplete or buggy because I've manually
> > identified 1 case that is incorrect which we discussed in the v4 and
> > a second case that seems buggy from a user perspective.
> >
> > Case 1 (we discussed this in the v4, but seems like it was missed
> > here?):
> >
> > Threaded set to 1 and then to 0 at the device level
> >
> >   echo 1 > /sys/class/net/eni28160np1/threaded
> >   echo 0 > /sys/class/net/eni28160np1/threaded
> >
> > Check the setting:
> >
> >   cat /sys/class/net/eni28160np1/threaded
> >   0
> >
> > Dump the settings for netdevsim, noting that threaded is 0, but pid
> > is set (again, should it be?):
> >
> >   ./tools/net/ynl/pyynl/cli.py \
> >        --spec Documentation/netlink/specs/netdev.yaml \
> >        --dump napi-get --json='{"ifindex": 20}'
> >
> >   [{'defer-hard-irqs': 0,
> >     'gro-flush-timeout': 0,
> >     'id': 612,
> >     'ifindex': 20,
> >     'irq-suspend-timeout': 0,
> >     'pid': 15728,
> >     'threaded': 0},
> >    {'defer-hard-irqs': 0,
> >     'gro-flush-timeout': 0,
> >     'id': 611,
> >     'ifindex': 20,
> >     'irq-suspend-timeout': 0,
> >     'pid': 15729,
> >     'threaded': 0}]
> As explained in the comment earlier, since the kthread is still valid
> and associated with the napi, the PID is valid. I just verified that
> this is the existing behaviour. Not sure whether the pid should be
> hidden if the threaded state is not enabled? Do you think we should
> change this behaviour?

I don't know, but I do think it's pretty weird from the user
perspective.

Probably need a maintainer to weigh-in on what the preferred
behavior is. Maybe there's a reason the thread isn't killed.

Overall, it feels weird to me that disabling threaded NAPI leaves
the pid in the netlink output and also keeps the thread running
(despite being blocked).

I think:
  - If the thread is kept running then the pid probably should be
    left in the output. Because if its hidden but still running (and
    thus still visible in ps or top or whatever), that's even
    stranger/more confusing?

  - If the thread is killed when threaded NAPI is disabled, then the
    pid should be wiped.

My personal preference is for the second option because it seems
more sensible from the user's point of view, but maybe there's a
reason it works the way it does that I don't know or understand.

