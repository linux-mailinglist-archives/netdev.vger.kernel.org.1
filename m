Return-Path: <netdev+bounces-109922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935E192A46F
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 16:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6B51C2152F
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE6084E11;
	Mon,  8 Jul 2024 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCcl3Nbg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40201D54A;
	Mon,  8 Jul 2024 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448200; cv=none; b=VDYiSgM5/pvq4K/9GnkDjo0lKNS5QSx+RRm76RMxb3gYmPG6b6bBXI/Yjp+x5DtATy0gd/2sZbeqUYEAwDCInazGauEwQPVavjeleCJbYzbR5uccDesvNObyIPyBWd1+pqiwUQKqPPLZCyFSKgq/nhoEP6ctHtoEOCe8ziwpXmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448200; c=relaxed/simple;
	bh=0UzVHsAK7yOF1TSP7mSF4VhiIWB+Akga/TzonZrAjXU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Got3CTs9OJz8aVaut/QjWqOe00bgs2zJV+cB1RdYGStEhX6e4mZ1uJ3sZVOZgeH2XIvXTOdfeVkOsIbkuu73ode/yJ1CGyjEDhp0prmPmgoOlsPNS4cmKv30NF7ODHrg2uLT/6i3dUP2s8B285TI/4Z8FKC3otyK4msdKl3pbPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCcl3Nbg; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-447e3a64aa1so8886361cf.2;
        Mon, 08 Jul 2024 07:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720448198; x=1721052998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wP0E5gIgFuQBnQGbv8A6NYVGVJnL5Clpudk9erlFk3M=;
        b=jCcl3NbgruiTopKGArRnECy5Z03zOjwOb5tfOI26zQxgiwKfET/LQjUse2HDpo4zja
         a74z8CDokOPRWPkT5GUksIpOOHkRTkNkOUCL0bKsObxzde2atLPtOFBxa85fgKtDrYQ1
         E2u0OBCUWwCNOL2u9KEt16gUTyWp9lTL3w9P4uu3xU2ql4Z5aOzRKD+JfCzKHNsA/v0g
         mY9tO/zcNNQyct60OYLAgQYyJNzxnsdBVJsrrti8oBK29mXJSFmqhADRxzb7zT4qvIvP
         kmpB9Q6KA2NCEMSqctfmf38BL0FalAYHfE/gPVR2oqAQM3s+23bcYi1RL9E0r1Vg+wwh
         k3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720448198; x=1721052998;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wP0E5gIgFuQBnQGbv8A6NYVGVJnL5Clpudk9erlFk3M=;
        b=aRa+mkTYa1OOFYsnAi6K32Yogaibvl6065YHjH9KtfxtM81l71A86J1Tyxabnrj4/d
         o92m4ZQFs6CAF2+zn6hneFrkKnXrragxSdgPGFzMTCNrrUsfim4zmSk2yrGrxtTUkRAq
         Pw7NyYhF1wT3JSNN+aj55CGwdRIrnTDlULXQQEkcWUZ7bZAXRSvZem1L1W4fhnJMgr8H
         XwfWuMfS2azMFzuGqM3sHabMdOOxzuUZMzlIQNnjwxkglCxBJACp5sHGlT5PqPOCv5Rv
         JzspG4URdmqQuMmZFix92I+jUC0/mtFdoTAq6Qly8oU1B0dw+p4yqHB6tT+0zGRelnnc
         nx9A==
X-Forwarded-Encrypted: i=1; AJvYcCXSkuLb4XYK2FFB+eQmW7pyDO/IRbN6Dm9Z5PJMJ1VEaVqUxCy3Z0nZutF9/QgMC1wWNjQnK0FrusKbsVEPtk9axJ5dQj/eyf+ut0KDm3uY9VgVfmoZXwkAvXO6/dC7eDn9EcJV
X-Gm-Message-State: AOJu0Yw9JglQyvm/QYnDr9URZ2+2clbrHwwDxvi1b+Gqx68dIn03MviP
	8MqzvcvvT17UYTjJ+p0nBDoo0UXbZ7JyVyrnn2gkFnxpk+QiyGnF
X-Google-Smtp-Source: AGHT+IE2JRwYdsDuo8j/MwQ9htT5JYiXKiVkKtMioWZNkxCJ/lK/i5qAzkfsn/Ab732uDDu61TBDKA==
X-Received: by 2002:a05:622a:808f:b0:447:dc5c:fc73 with SMTP id d75a77b69052e-447dc5cfffamr99004791cf.45.1720448197622;
        Mon, 08 Jul 2024 07:16:37 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4465143e475sm98481121cf.46.2024.07.08.07.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 07:16:36 -0700 (PDT)
Date: Mon, 08 Jul 2024 10:16:36 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Lunn <andrew@lunn.ch>, 
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <668bf4c48fd5a_18f88d2942f@willemb.c.googlers.com.notmuch>
In-Reply-To: <e53db011-fe6a-4e63-b740-a7d2ff33dfa9@intel.com>
References: <20240703150342.1435976-1-aleksander.lobakin@intel.com>
 <20240703150342.1435976-4-aleksander.lobakin@intel.com>
 <668946c1ddef_12869e29412@willemb.c.googlers.com.notmuch>
 <e53db011-fe6a-4e63-b740-a7d2ff33dfa9@intel.com>
Subject: Re: [PATCH net-next v2 3/5] netdev_features: convert NETIF_F_LLTX to
 dev->lltx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alexander Lobakin wrote:
> From: Willem De Bruijn <willemdebruijn.kernel@gmail.com>
> Date: Sat, 06 Jul 2024 09:29:37 -0400
> 
> > Alexander Lobakin wrote:
> >> NETIF_F_LLTX can't be changed via Ethtool and is not a feature,
> >> rather an attribute, very similar to IFF_NO_QUEUE (and hot).
> >> Free one netdev_features_t bit and make it a "hot" private flag.
> >>
> >> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> [...]
> 
> >> @@ -23,8 +23,6 @@ enum {
> >>  	NETIF_F_HW_VLAN_CTAG_FILTER_BIT,/* Receive filtering on VLAN CTAGs */
> >>  	NETIF_F_VLAN_CHALLENGED_BIT,	/* Device cannot handle VLAN packets */
> >>  	NETIF_F_GSO_BIT,		/* Enable software GSO. */
> >> -	NETIF_F_LLTX_BIT,		/* LockLess TX - deprecated. Please */
> >> -					/* do not use LLTX in new drivers */
> >>  	NETIF_F_NETNS_LOCAL_BIT,	/* Does not change network namespaces */
> >>  	NETIF_F_GRO_BIT,		/* Generic receive offload */
> >>  	NETIF_F_LRO_BIT,		/* large receive offload */
> > 
> >> @@ -1749,6 +1749,8 @@ enum netdev_reg_state {
> >>   *			booleans combined, only to assert cacheline placement
> >>   *	@priv_flags:	flags invisible to userspace defined as bits, see
> >>   *			enum netdev_priv_flags for the definitions
> >> + *	@lltx:		device supports lockless Tx. Mainly used by logical
> >> + *			interfaces, such as tunnels
> > 
> > This loses some of the explanation in the NETIF_F_LLTX documentation.
> > 
> > lltx is not deprecated, for software devices, existing documentation
> > is imprecise on that point. But don't use it for new hardware drivers
> > should remain clear.
> 
> It's still written in netdevices.rst. I rephrased that part as
> "deprecated" is not true.
> If you really think this may harm, I can adjust this one.

Yeah, doesn't hurt to state here too: Deprecated for new hardware devices.

> > 
> >>   *
> >>   *	@name:	This is the first field of the "visible" part of this structure
> >>   *		(i.e. as seen by users in the "Space.c" file).  It is the name
> > 
> >> @@ -3098,7 +3098,7 @@ static void amt_link_setup(struct net_device *dev)
> >>  	dev->hard_header_len	= 0;
> >>  	dev->addr_len		= 0;
> >>  	dev->priv_flags		|= IFF_NO_QUEUE;
> >> -	dev->features		|= NETIF_F_LLTX;
> >> +	dev->lltx		= true;
> >>  	dev->features		|= NETIF_F_GSO_SOFTWARE;
> >>  	dev->features		|= NETIF_F_NETNS_LOCAL;
> >>  	dev->hw_features	|= NETIF_F_SG | NETIF_F_HW_CSUM;
> > 
> > Since this is an integer type, use 1 instead of true?
> 
> I used integer type only to avoid reading new private flags byte by byte
> (bool is always 1 byte) instead of 4 bytes when applicable.
> true/false looks more elegant for on/off values than 1/0.
> 
> > 
> > Type conversion will convert true to 1. But especially when these are
> > integer bitfields, relying on conversion is a minor unnecessary risk.
> 
> Any examples when/where true can be non-1, but something else, e.g. 0?
> Especially given that include/linux/stddef.h says this:
> 
> enum {
> 	false	= 0,
> 	true	= 1
> };
> 
> No risk here. Thinking that way (really sounds like "are you sure NULL
> is always 0?") would force us to lose lots of stuff in the kernel for no
> good.

Ack. Both C bitfields and C boolean "type" are not as trivial as they
appear. But agreed that the stddef.h definition is.

I hadn't seen use of true/false in bitfields in kernel code often. A
quick scan of a few skb fields like ooo_okay and encapsulation shows
use of 0/1.

But do spot at least one: sk_reuseport. 
> > 
> >>  int dsa_user_suspend(struct net_device *user_dev)
> >> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> >> index 6b2a360dcdf0..44199d1780d5 100644
> >> --- a/net/ethtool/common.c
> >> +++ b/net/ethtool/common.c
> >> @@ -24,7 +24,6 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
> >>  	[NETIF_F_HW_VLAN_STAG_FILTER_BIT] = "rx-vlan-stag-filter",
> >>  	[NETIF_F_VLAN_CHALLENGED_BIT] =  "vlan-challenged",
> >>  	[NETIF_F_GSO_BIT] =              "tx-generic-segmentation",
> >> -	[NETIF_F_LLTX_BIT] =             "tx-lockless",
> >>  	[NETIF_F_NETNS_LOCAL_BIT] =      "netns-local",
> >>  	[NETIF_F_GRO_BIT] =              "rx-gro",
> >>  	[NETIF_F_GRO_HW_BIT] =           "rx-gro-hw",
> > 
> > Is tx-lockless no longer reported after this?
> > 
> > These features should ideally still be reported, even if not part of
> 
> Why do anyone need tx-lockless in the output? What does this give to the
> users? I don't believe this carries any sensible/important info.
> 
> > the features bitmap in the kernel implementation.
> > 
> > This removal is what you hint at in the cover letter with
> > 
> >   Even shell scripts won't most likely break since the removed bits
> >   were always read-only, meaning nobody would try touching them from
> >   a script.
> > 
> > It is a risk. And an avoidable one?
> 
> What risk are you talking about? Are you aware of any scripts or
> applications that want to see this bit in Ethtool output? I'm not.

The usual risk of ABI changes: absence of proof (of use) is not proof
of absence.

I agree that it's small here. And cannot immediately estimate the cost
of maintaining this output, i.e., the risk/reward. But if it's easy to
keep output as before, why not.

And hard to say ahead of time that the argument for dropping lltx
applies equally to subsequent bits removed from netdev_features_t.

Alternatively, please do spell out clearly in the commit message how
this changes user visible behavior. I did not fully understand the
shell script comment until I read the code.

