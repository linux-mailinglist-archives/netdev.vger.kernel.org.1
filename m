Return-Path: <netdev+bounces-87254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B9E8A2537
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 06:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D032E2833FA
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 04:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650E53234;
	Fri, 12 Apr 2024 04:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdRxRxW5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B34A41
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 04:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712896761; cv=none; b=m6D7ut7+rjUuFtMZ18KVy+5VxO/0luxnDEKc7PT0R/RWhvu194JXTKlq+D0vTO2zFDUcsZXC2tZ+8hLw5II2VCeb+0mzoni4k4xPRgsuziVZ8CvsFYfXOYSDscWJQ3IjS5Yf7plIvz2DZEanjJq1a8iSdzUaloZGOk0XbcHcwGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712896761; c=relaxed/simple;
	bh=czs4dbsIrNkT/AMFxtNh50XXf1MmFe2PUoMmAebw5TQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YR0li+xqEAOTvPp0qRqMP8PEbxWs6zqIWWAUFkrWyo2dQsTDaBn1JhT6Svfdv2slDN1zHyoRinqyP09fdHy6/IpyMMX25tueC+8TkecZ6YtfgepIvRMBDRjzgU1zmV28zKaQTPpfGA5I/lV27Bg7KyimgOXePEgEKYtee3We1NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdRxRxW5; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ed2dbf3c92so416002b3a.2
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 21:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712896759; x=1713501559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYKU7j48h667VnweuV5kVThldqVF3oe+rvp/tGfOVSE=;
        b=UdRxRxW5610p6uZOz3Qus79EjK9WuvEm6dAnuL3+qq+Oz3wWH43tg0fskLYoQxsuhB
         Sq7MSBAHC8JWJBdl8wZUNuHv/17n+lk2AwQDpaCV3P9x8VooNAenzDL3ISMJMMXHi+YQ
         7GEetv0WbFtwILH5c6McuCC30//KnZw1XjF3JlzPa3DhFrYMaygYAN0a+ZNyzPqY6A8+
         ht+dMgwpd3AkNtgnx7282yfN6CQwbt+35inyL+QEPT22o8o2QzwUQeoGh7m3E7fgkeTL
         hx5Q3IOANGzbfcxwUJ66BFQGMXoEi6iWOeUSN6LsOH/l6qjek5RGgy1ApQRcchb+SVI+
         8bLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712896759; x=1713501559;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wYKU7j48h667VnweuV5kVThldqVF3oe+rvp/tGfOVSE=;
        b=oRguq53MliTkgGpc/Qwr02mwz94VeSOz/RtDqLlA9XP466XuII/QpCumUnBOfePKiL
         /g2dOCFMRl2sZ1RCnPi/iCk8TYX0zAr/S4/Pvch6PPyVnBOu8ifdscvx9Riwu8mvOBzj
         k/lCt1Wju9H/B6TrAKdprm9xkz5yXYVODcSTl/KHX2jNEkV+zgyic+uSl8MUeyWEfurv
         h47oxSKNdw5j/MrQziYLlenrvvKRzrQhZu3UzshAXYrI1W9NDvpTbyOdqn2eefwktOaQ
         6eoyHiwL1ob1i9cWdcGtGmk5AeXE/8t0QY8DEkLnoSim4wTdugwDdRoxoR4rc8wAuClf
         L1Pw==
X-Forwarded-Encrypted: i=1; AJvYcCV9IN1QYNvfJdKIQ/cZDPBAyQN0RZO6/TufKiG3HI+tBIKOv016Wmg508VJh3R5676cdWxvT9M7aIouQ8LjBMQ7+o34xRvL
X-Gm-Message-State: AOJu0YzQES4V5t7DYlbnPvjZ3lP/MWQ9ZoW8erx4dmtJpxCbi9qoIbNO
	msHfAbhHFbK6Wl/ekkDTi4D3Qoe5sMel4Blei+v6X4cKl1aEXH36IQ12bg==
X-Google-Smtp-Source: AGHT+IEWUDwOguVhvb4MSG4umjcrtLu+BMlM2MqXQxjvnKKFruZyUnioRVKQn7mJUWj/rS7lhODo2A==
X-Received: by 2002:a05:6a00:391c:b0:6ec:f5d2:f6be with SMTP id fh28-20020a056a00391c00b006ecf5d2f6bemr1690018pfb.1.1712896759141;
        Thu, 11 Apr 2024 21:39:19 -0700 (PDT)
Received: from localhost ([98.97.40.17])
        by smtp.gmail.com with ESMTPSA id n21-20020a056a000d5500b006ed066ebed4sm2078194pfv.93.2024.04.11.21.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 21:39:18 -0700 (PDT)
Date: Thu, 11 Apr 2024 21:39:17 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Madhu Chittim <madhu.chittim@intel.com>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>, 
 Paolo Abeni <pabeni@redhat.com>
Message-ID: <6618baf56c815_3a050208f4@john.notmuch>
In-Reply-To: <87a5lzihke.fsf@intel.com>
References: <20240405102313.GA310894@kernel.org>
 <87a5lzihke.fsf@intel.com>
Subject: Re: [RFC] HW TX Rate Limiting Driver API
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Vinicius Costa Gomes wrote:
> Hi,
> 
> Simon Horman <horms@kernel.org> writes:
> 
> > Hi,
> >
> > This is follow-up to the ongoing discussion started by Intel to extend the
> > support for TX shaping H/W offload [1].
> >
> > The goal is allowing the user-space to configure TX shaping offload on a
> > per-queue basis with min guaranteed B/W, max B/W limit and burst size on a
> > VF device.
> >
> 
> What about non-VF cases? Would it be out of scope?
> 
> >
> > In the past few months several different solutions were attempted and
> > discussed, without finding a perfect fit:
> >
> > - devlink_rate APIs are not appropriate for to control TX shaping on netdevs
> > - No existing TC qdisc offload covers the required feature set
> > - HTB does not allow direct queue configuration
> > - MQPRIO imposes constraint on the maximum number of TX queues
> > - TBF does not support max B/W limit
> > - ndo_set_tx_maxrate() only controls the max B/W limit
> >
> 
> Another questions: is how "to plug" different shaper algorithms? for
> example, the TSN world defines the Credit Based Shaper (IEEE 802.1Q-2018
> Annex L gives a good overview), which tries to be accurate over sub
> milisecond intervals.
> 
> (sooner or later, some NIC with lots of queues will appear with TSN
> features, and I guess some people would like to know that they are using
> the expected shaper)
> 
> > A new H/W offload API is needed, but offload API proliferation should be
> > avoided.
> >
> > The following proposal intends to cover the above specified requirement and
> > provide a possible base to unify all the shaping offload APIs mentioned above.
> >
> > The following only defines the in-kernel interface between the core and
> > drivers. The intention is to expose the feature to user-space via Netlink.
> > Hopefully the latter part should be straight-forward after agreement
> > on the in-kernel interface.
> >
> 
> Another thing that MQPRIO (indirectly) gives is the ability to userspace
> applications to have some amount of control in which queue their packets
> will end up, via skb->priority.

You can attach a BPF program now to set the queue_mapping. So one way
to do this would be to have a simple BPF program that maps priority
to a set of queues. We could likely include it somewhere in the source
or tooling to make it easily available for folks.

I agree having a way to map applications/packets to QOS is useful. The
nice bit about allowing BPF to do this is you don't have to figure out
how to set the priority on the socket and can use whatever policy makes
sense.

> 
> Would this new shaper hierarchy have something that would fill this
> role? (if this is for VF-only use cases, then the answer would be "no" I
> guess)
> 
> (I tried to read the whole thread, sorry if I missed something)
> 

