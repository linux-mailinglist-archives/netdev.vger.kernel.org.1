Return-Path: <netdev+bounces-143432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81269C26C9
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 21:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088DD1C241CD
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 20:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53001F26F9;
	Fri,  8 Nov 2024 20:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="WPkemQ57"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C571EBFEC
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 20:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731098598; cv=none; b=WDOb88GYP2g3QvcN+L+QGYdm0JLTlb4pL2C6x70hL1Dt5BtEWEcggE+c473zBGq+Ica9XGg5FFB2ThONUMmCybTbdzI5d0fMi8RndCD86KiVXl/LYIbpRfRtOJGnenWxzsGE0U99wUb3tQbJumyS1NLHAwI2liJBgd5ZtbgKxUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731098598; c=relaxed/simple;
	bh=05ZHk5jPkmyjho3dgLJye9taESJKqij5X4HEvUqLBEc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXTSDmn4iUWp+U2/NP6RL1/P8L3wFxzoIRmjUYdkS0Xq1/fjjfGi3MRDf/U+mkgqMEy1sJ13qGsIjKdXNZaMJdBTmU7Wa1n/oGRn2scvIT3o/3ozEushIVS36yImFGWaTVkkueJYw9WYs9HEoVNSdz1n6gtEZG7glqMDIejr6js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=WPkemQ57; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71ec997ad06so2176148b3a.3
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 12:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731098596; x=1731703396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zEzdyKVpHHrV3YxJaDgEVS6rgO35hC4CuZ/g4MMWqPk=;
        b=WPkemQ57RYXgYt4uQWNmyk1PCpjyzT/AicyGPGYUpCT9ocrIM2406ZZDzVXQfOuMUQ
         7LGNFCUFFHX5yur5Th8io7dJzD5yO5xfCOorPF5JqJo+l4oVB5GvtWHsRd2HzNu7mIoL
         yx/cqNtjym+TvA6TnE3UuQQJanWPQPLqW5YY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731098596; x=1731703396;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zEzdyKVpHHrV3YxJaDgEVS6rgO35hC4CuZ/g4MMWqPk=;
        b=Hn/fRHyJOgtWy9NKS0B3EaF+XVpQF0PCzlShhcc7ced678RcVkGCBzoBlCuczYuhPM
         kIy1kLNpoJltTKv4X7g1rFc+yk0DBF+ezD3ezItTCE/ILeeM32A8UedMazr2WXroVmmq
         BbMRVLvpBtditreI41VAPqo6ed21AhK6aSJfDjFj88pLah24xr1yx1R52DWt0XsCDV/b
         Yc7bOtarbUEJrbyncRVm095McExSmo8cVtdtGFA06Nb+zj7RUgB3LOkA5UqJMjhAbIxA
         ZwtJjLfjIkLkDju/GW+vydLVYm6/5XqisackWx0kayjwJssZAJwxdMKiLlvtX5X4HCZB
         5ZRg==
X-Forwarded-Encrypted: i=1; AJvYcCW13r+dptSaRtbp6wSHclBjhgO0WcE6DeQBHGeIrjVPA4q702Gz7pw1FQPHw0HAcjMKy3rBIzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzRGgxVvtOBQFfqFqlKG/5crQOBfyyTs3kT9ubpOOJpLQpAgzH
	jCw78OnVvPlIe3t+dkfL24iUPXD3TWhS2WWfNPF/bpRQu0EPFTlwEqo9ZKKSjqc=
X-Google-Smtp-Source: AGHT+IF75qgr9VmpLEoplJgw0SGlHTO4ep/kxXFb5UJdTOwumNrLgsW5oBLGLszqgXlZ6TIrNGy8Lw==
X-Received: by 2002:a05:6a20:4321:b0:1da:2e7c:e510 with SMTP id adf61e73a8af0-1dc228b027amr5881650637.1.1731098596251;
        Fri, 08 Nov 2024 12:43:16 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e47ec5sm35083365ad.160.2024.11.08.12.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 12:43:15 -0800 (PST)
Date: Fri, 8 Nov 2024 12:43:13 -0800
From: Joe Damato <jdamato@fastly.com>
To: Edward Cree <ecree.xilinx@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>,
	davem@davemloft.net, mkubecek@suse.cz, kuba@kernel.org,
	martin.lau@linux.dev, netdev@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH ethtool-next] rxclass: Make output for RSS context action
 explicit
Message-ID: <Zy534c38QI97WFre@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Edward Cree <ecree.xilinx@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>,
	davem@davemloft.net, mkubecek@suse.cz, kuba@kernel.org,
	martin.lau@linux.dev, netdev@vger.kernel.org, kernel-team@meta.com
References: <890cd515345f7c1ed6fba4bf0e43c53b34ccefaa.1731094323.git.dxu@dxuuu.xyz>
 <ea2eb6ca-0f79-26a7-0e61-6450b7f5a9a2@gmail.com>
 <Zy516d25BMTUWEo4@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy516d25BMTUWEo4@LQ3V64L9R2>

On Fri, Nov 08, 2024 at 12:34:49PM -0800, Joe Damato wrote:
> On Fri, Nov 08, 2024 at 07:56:41PM +0000, Edward Cree wrote:
> > On 08/11/2024 19:32, Daniel Xu wrote:
> > > Currently, if the action for an ntuple rule is to redirect to an RSS
> > > context, the RSS context is printed as an attribute. At the same time,
> > > a wrong action is printed. For example:
> > > 
> > >     # ethtool -X eth0 hfunc toeplitz context new start 24 equal 8
> > >     New RSS context is 1
> > > 
> > >     # ethtool -N eth0 flow-type ip6 dst-ip $IP6 context 1
> > >     Added rule with ID 0
> > > 
> > >     # ethtool -n eth0 rule 0
> > >     Filter: 0
> > >             Rule Type: Raw IPv6
> > >             Src IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
> > >             Dest IP addr: <redacted> mask: ::
> > >             Traffic Class: 0x0 mask: 0xff
> > >             Protocol: 0 mask: 0xff
> > >             L4 bytes: 0x0 mask: 0xffffffff
> > >             RSS Context ID: 1
> > >             Action: Direct to queue 0
> > > 
> > > This is wrong and misleading. Fix by treating RSS context as a explicit
> > > action. The new output looks like this:
> > > 
> > >     # ./ethtool -n eth0 rule 0
> > >     Filter: 0
> > >             Rule Type: Raw IPv6
> > >             Src IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
> > >             Dest IP addr: <redacted> mask: ::
> > >             Traffic Class: 0x0 mask: 0xff
> > >             Protocol: 0 mask: 0xff
> > >             L4 bytes: 0x0 mask: 0xffffffff
> > >             Action: Direct to RSS context id 1
> > > 
> > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > 
> > I believe this patch is incorrect.  My understanding is that on
> >  packet reception, the integer returned from the RSS indirection
> >  table is *added* to the queue number from the ntuple rule, so
> >  that for instance the same indirection table can be used for one
> >  rule distributing packets over queues 0-3 and for another rule
> >  distributing a different subset of packets over queues 4-7.
> > I'm not sure if this behaviour is documented anywhere, and
> >  different NICs may have different interpretations, but this is
> >  how sfc ef10 behaves.
> 
> I just wanted to chime in and say that my understanding has always
> been more aligned with Daniel's and I had also found the ethtool
> output confusing when directing flows that match a rule to a custom
> context.
> 
> If Daniel's patch is wrong (I don't know enough to say if it is or
> not), would it be possible to have some alternate ethtool output
> that's less confusing? Or for this specific output to be outlined in
> the documentation somewhere?

Sorry for the quick follow up, but I just tested this and I do think
there is an issue with ethtool's output.

Here's an example from my system where I create 18 queues and a
custom RSS context to send flows to queues 16 and 17 only:

$ ethtool --version
ethtool version 6.7

$ sudo ethtool -L eth2 combined 18

$ sudo ethtool -X eth2 weight 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 context new
New RSS context is 1

$ sudo ethtool -U eth2 flow-type tcp4 dst-port 11211 context 1
Added rule with ID 1023

$ sudo ethtool -n eth2 rule 1023
Filter: 1023
	Rule Type: TCP over IPv4
	Src IP addr: 0.0.0.0 mask: 255.255.255.255
	Dest IP addr: 0.0.0.0 mask: 255.255.255.255
	TOS: 0x0 mask: 0xff
	Src port: 0 mask: 0xffff
	Dest port: 11211 mask: 0x0
	RSS Context ID: 1
	Action: Direct to queue 0

I don't understand why this would say "Direct to queue 0" when the
weights specifically disallow this for context 1.

