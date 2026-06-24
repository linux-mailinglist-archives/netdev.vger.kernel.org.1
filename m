Return-Path: <netdev+bounces-301597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZBhSM+emO2psawgAu9opvQ
	(envelope-from <netdev+bounces-301597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:44:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DD06BD08E
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:44:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SZlFEU4D;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301597-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301597-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5D2330059AF
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9CD23815B;
	Wed, 24 Jun 2026 09:44:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E652417D9
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 09:44:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782294245; cv=none; b=Q4NphiusWGexNMeuVBqxPelqTbA3nMZmHkl+Dh7Ni/Y1VyqXPUc2eYKxUz9ikOeu3WdWWwHqJfeguVBQefn1Pp+CxB5iv/sdZaL91Q1mGlnmnQ0xAa/hjhIrUT7FS3myAccNrtATqS6n+1chUeAJQL1Fj8s3k26LrSYrUt7FRZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782294245; c=relaxed/simple;
	bh=DkfiNip9gvyz5mAVZwLGn9pHn6AMMbIR6YtLs/F+Pzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvvdU9EHJENVwouyEFgF+g+T4O9eN2UMSDKGsP3t9DFFkr+LTsS2o1oFoy+19HEPnrULk/iBVDGZfccarW6ditj/GfSUQZOhj01b2pC6yagXrYsZeE1MDNBte242/zS3+HSEnCfHPE8WWAsyar10QJRCJ0xjwuwdlpV23mKvdaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZlFEU4D; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37c867bd3e0so510445a91.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 02:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782294243; x=1782899043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6/Nm8rMgcjSABP2aayKy6xYMf5YMQOQ2B23LheDWb6Y=;
        b=SZlFEU4DRN5PWCyOExNKaxPfneZlBdNKaVyj9a8muDXJwCqPU5l/40dT9DsOo3FgHo
         IpS1W9sXdmchlLgzsvhxsWbIUIyrkrWCJXUnL8LD7Wlmp1T9ZewxTaw1cVaqULM7XsZp
         98NqKslPgC1BQHqMRtA3czYs3YIZjTW/2nARLzVJGHpfA6AVxr6gP7mIOxaAwy4F279i
         pZpbMpnTHYhBu3cxp7U3G/1bzt4dlit3Ckoba4aGCPzdoPjxrzJ0WrBENpo6WXJ6QLX4
         F65XIXpOQWaxn6om/0QjV7G01lSvbQI/Uz0cmw+vhlUX8gF5o17qvEUFi3d0u+ujFj2/
         urdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782294243; x=1782899043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/Nm8rMgcjSABP2aayKy6xYMf5YMQOQ2B23LheDWb6Y=;
        b=P9OGugOSWLnWKAhR5+ecgpn04E5hxuDugyVWiNv469FNax7lUUCqmL8bZiN1e4nx8p
         Rgqp6x+Q92vTgr0dhcdmiQWmC1WbQGA3KBwNUoo8RtYd6UKyEPAbdVzD3PSiwaUgzmDj
         OwsG8luDUAyPF8eunJl49CCo3Dlx4VtIedc72895lfizPZCox0BnfzpIyqVFxEiK/wwm
         WuPnCPLNUEoWVhZcVVCFc/JTXbQlZeuPUSJF8XdPsVFTdtiza4VMY0hs88DQsF62FgeI
         2ldxWKmVssaV1ceCi3krC7tRYR1/wUvSr3r5G/Yh5EUu+uvtWxMDe+OtH3uErzAaPXau
         YdGw==
X-Forwarded-Encrypted: i=1; AHgh+RqL2/vhtaVRwzWfruLNcoSsn3Gl3ToxsYQ/R+1Ic717JIt2Sr9BN+Ii3MHChlmb8NXyK+g0rK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfDSyT9kFRldr/Y4OnY6TKR4SW0ExxWBmABMaH6AAzNPydOGgE
	zwpN74lF+AMb9TX/k0cB4nnimVYx5+M47qxW1W5ed/bWNBgbrpm8GokLs8eKIKDJd3A=
X-Gm-Gg: AfdE7clijtcjnEoGSL82Vr2oHs2HQrRLn7TEVTvN5ErbwPZK0Pb0u6osw/gc+l6MeGu
	dUfwOBfHmMYJ3albCP1YMm+0BpPVF+JtccIXg4659U0x6NeGy8o4pat9T4knquWktCaKEv1OL+B
	56twkTJT45GdRrv1n029K1TByaiRuBgLAACAb1mmOvFwpUJcWhl/v2hnPmUabmhQe98dxa6h1nY
	2lcZkJ4edXgIyPY6ctkTU8HyeFbowPCIBIa7yZfIMwGe7KvWzSJ2oQ0nZG+o8yf7TlSQt7FsEUt
	iuQ1VkU5o23kTxYe4i5ilKB4WYrY4qOzvuHfCouBSXOsazfJvi225OSqfG9IksJz4TbY199ML4D
	jxc6LsSSzL7GADwg0jgmyw/R01bKfOdMuUobnj/Qn4hj4jUpwHZ8WuxR1R1cNip3uVQNJh9c/c4
	HcXgQWUMiqKom/hx9bU3gmVM7G1yUD/03PFJncluVdOJtnW3d+79M0ARa3gAJS9ff92A==
X-Received: by 2002:a17:90b:4b10:b0:36c:e254:4db with SMTP id 98e67ed59e1d1-37de41aa52dmr2724532a91.6.1782294242992;
        Wed, 24 Jun 2026 02:44:02 -0700 (PDT)
Received: from DESKTOP-19IMU7U.localdomain ([125.242.148.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37de4d4b0cdsm619527a91.1.2026.06.24.02.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:44:02 -0700 (PDT)
Date: Wed, 24 Jun 2026 18:44:00 +0900
From: Wongi Lee <qw3rtyp0@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jungwoo Lee <jwlee2217@gmail.com>
Subject: Re: Please apply 736b380e28d0 and eca856950f7c down to 6.1.y
Message-ID: <ajum4HXbhgdRl6Vz@DESKTOP-19IMU7U.localdomain>
References: <ajuR7rZYU943EG6p@DESKTOP-19IMU7U.localdomain>
 <2026062417-conceal-driving-0ebd@gregkh>
 <ajujm9+82N1g/HgF@DESKTOP-19IMU7U.localdomain>
 <2026062416-amulet-paradox-cf7c@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026062416-amulet-paradox-cf7c@gregkh>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301597-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[qw3rtyp0@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jwlee2217@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qw3rtyp0@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,DESKTOP-19IMU7U.localdomain:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67DD06BD08E

On Wed, Jun 24, 2026 at 11:37:29AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jun 24, 2026 at 06:30:03PM +0900, Wongi Lee wrote:
> > On Wed, Jun 24, 2026 at 11:00:45AM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Jun 24, 2026 at 05:14:38PM +0900, Wongi Lee wrote:
> > > > Hi,
> > > > 
> > > > Could the following upstream commits be queued for the active stable
> > > > trees?
> > > > 
> > > >   commit 736b380e28d0480c7bc3e022f1950f31fe53a7c5
> > > >   ("ipv6: account for fraggap on the paged allocation path")
> > > 
> > > I do not see that commit id in Linus's tree, are you sure it is correct?
> > > 
> > > >   commit eca856950f7cb1a221e02b99d758409f2c5cec42
> > > >   ("ipv4: account for fraggap on the paged allocation path")
> > > 
> > > Same here, no id of that one in Linus's tree that I can see.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > 
> > Hi Greg,
> > 
> > First, sorry for confusing you.
> > 
> > The commit IDs are from netdev/net.git:
> > 
> >   736b380e28d0480c7bc3e022f1950f31fe53a7c5
> >   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=736b380e28d0
> > 
> >   eca856950f7cb1a221e02b99d758409f2c5cec42
> >   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=eca856950f7c
> > 
> > They were applied to netdev without Cc: stable@vger.kernel.org, so I
> > wanted to flag them for stable handling but I send it too fast (before
> > merge).
> > 
> > I will resend the request with the Linus tree commit ID.
> 
> They have to be in Linus's tree, before we can take them in a stable
> release, right?
> 
> And why were they not originally tagged with the cc: stable?  That would
> save you time in the future as it would all just happen automatically.
> 
> thanks,
> 
> greg k-h

Right, my fault.

Also I just forgot cc'ing stable when sending it. I'll apply it next time.

thanks,
Wongi

