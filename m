Return-Path: <netdev+bounces-157912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6635BA0C48E
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 23:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21DE43A1950
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 22:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B4C1E764A;
	Mon, 13 Jan 2025 22:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="PdlCmv4M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085081F8F18
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 22:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736806861; cv=none; b=Eq7jD2dUAZLGzo4VDgcBDMeRAs9qg9uyySLMCFR//mx4s1jXL7gBASBkDWNHUqPXMyWn4P9LhBvAaUHknHzFJ8u3Hym01pC3o6gBBXjfR0piosQEQMck12H4fiw3A8xmoA4gTEu27FiIgS7P/+HaeI7IkXM4nRgb2t6Sh7NuR80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736806861; c=relaxed/simple;
	bh=2YAL09Koyp+fcrC3ydsWeYH9O90SQKrYwzJ026mS9QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtQF8iG0lobAt36eXxNLJZR/LSOjeThiNm8IHGZqw3d/THZ6Tsi/4g42Q1F63mmwmSsBZGg4WBugQ/zLbXVmweQXY53CjGnvNlyXfLpaUaosbrYDwHDzQPMe1fB0n2RZbH0kaYqFp1ZIvBCvZ4ETbdyhkIS/XW8MBpJofYekWRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=PdlCmv4M; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-218c8aca5f1so103859005ad.0
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 14:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736806859; x=1737411659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGgKg0I90jC0WJ9/MA+ovv8BmzlWfQERRLDis8KJI80=;
        b=PdlCmv4MmEEmUTikOLRlseu36g63DmzSOt2DaGBQ/AJCR265kirnztZVxy6pkQLgT3
         JNe5xzWDL9PjAFrCT5iItuTXyArHw8vz3ZAdkjG2JzPHlQUm79BPKxwQRa/rLq2/hVZk
         XQHpquFoSdV38H8I1PyOsmnhVu1Ltp4KVv15s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736806859; x=1737411659;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGgKg0I90jC0WJ9/MA+ovv8BmzlWfQERRLDis8KJI80=;
        b=O6TlAPxxHdNIJ2IiFQJT4dN3GJoWw7U8+fwNvr95bmzYgJtwmEIK6Qm+D4IZ0s6i+B
         zGnkxwI3YI+FHaxH/6tJybd+XciglCE9N3OhLFQ4Ray29yTM4Uec32AiB/bMOjiFYn8W
         rIEWF7N1KjWQIUrtT9Xm4GuFIDHUrcSowuj05/JfitOq0VqdkcmeeFLobWNNIETEp1QB
         bUm+8GnTeKpNzVMKvzA8cpQnK5BzBW4x2LsBPUOwXv8H8lW2KzDr1ZJ8i6iS6kUrfNtM
         MKK2qmJbL2ShmCJd2Ff2Luj13czCUZsnCcRVvDUKvB9k3WrrrnfcLC9ZWQ7UH9EpH/7B
         +IDg==
X-Forwarded-Encrypted: i=1; AJvYcCU/qD6cmW+15wV/Abe6smDgW1v3pKdMCxaiTKsQDjvaN2kzpiIFkEpFpH+LxRSFCTXBx9GHVo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHug+IFAFH5ItGCZ1d3a5P9ikSNM/7b+3V9+rUZgcgvdgTiaI6
	GTm+CYE5WXzfysC8Pu/sal0fIdg2Q/Lh+0DKuP4P8FsJjy8WukQwN63B4Q0vIWo=
X-Gm-Gg: ASbGnctHuaafNe5hGMVmZ0beANIrcin6imzPoQi6TS6sViizdn/nLS2MBrKT8nlhOq6
	Zo6vg2h54EGbE9nkthT/4D6Ldq5GMg4zXzQIEEo1r+rssOwqsHFPLRDmgaVbkEZ4kSrfcXSiAcZ
	e3RrHjZum9E9t4t2Bu25Vw4nB624T7LznZnqklEScAJrhjIBnmhyVkcMuPp1ZjkMZwCON+PcrjG
	BlKZD02QLoYzgHc82z/Ddt+v5PV0EJC9HAqJS98ap0J46IXrJr+OsGNcN2mz1mAoxT9j7bydDTL
	xcE4IKKkPqhisfy5AzaLyfs=
X-Google-Smtp-Source: AGHT+IFlj6RqQ9PT9tgEWpApjJEGtRcdb926Mzks5SWPN/KckpIB61Z996eCrEia8y5kT08nGuV6ig==
X-Received: by 2002:a17:903:41c4:b0:212:5786:7bb6 with SMTP id d9443c01a7336-21a83f469b8mr312800535ad.3.1736806859278;
        Mon, 13 Jan 2025 14:20:59 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22d113sm58460715ad.170.2025.01.13.14.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 14:20:58 -0800 (PST)
Date: Mon, 13 Jan 2025 14:20:56 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Gerhard Engleder <gerhard@engleder-embedded.com>,
	magnus.karlsson@intel.com, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] tsnep: Link queues to NAPIs
Message-ID: <Z4WRyI-_f9J4wPVL@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	magnus.karlsson@intel.com, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org
References: <20250110223939.37490-1-gerhard@engleder-embedded.com>
 <Z4VwrhhXU4uKqYGR@LQ3V64L9R2>
 <91fc249e-c11a-47a1-aafe-fef833c3bafa@engleder-embedded.com>
 <Z4WKHnDG9VSMe5OD@LQ3V64L9R2>
 <20250113135609.13883897@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113135609.13883897@kernel.org>

On Mon, Jan 13, 2025 at 01:56:09PM -0800, Jakub Kicinski wrote:
> On Mon, 13 Jan 2025 13:48:14 -0800 Joe Damato wrote:
> > > > The changes generally look OK to me (it seems RTNL is held on all
> > > > paths where this code can be called from as far as I can tell), but
> > > > there was one thing that stood out to me.
> > > > 
> > > > AFAIU, drivers avoid marking XDP queues as NETDEV_QUEUE_TYPE_RX
> > > > or NETDEV_QUEUE_TYPE_TX. I could be wrong, but that was my
> > > > understanding and I submit patches to several drivers with this
> > > > assumption.
> > > > 
> > > > For example, in commit b65969856d4f ("igc: Link queues to NAPI
> > > > instances"), I unlinked/linked the NAPIs and queue IDs when XDP was
> > > > enabled/disabled. Likewise, in commit 64b62146ba9e ("net/mlx4: link
> > > > NAPI instances to queues and IRQs"), I avoided the XDP queues.
> > > > 
> > > > If drivers are to avoid marking XDP queues as NETDEV_QUEUE_TYPE_RX
> > > > or NETDEV_QUEUE_TYPE_TX, perhaps tsnep needs to be modified
> > > > similarly?  
> > > 
> > > With 5ef44b3cb4 ("xsk: Bring back busy polling support") the linking of
> > > the NAPIs is required for XDP/XSK. So it is strange to me if for XDP/XSK
> > > the NAPIs should be unlinked. But I'm not an expert, so maybe there is
> > > a reason why.
> > > 
> > > I added Magnus, maybe he knows if XSK queues shall still be linked to
> > > NAPIs.  
> > 
> > OK, so I think I was probably just wrong?
> > 
> > I looked at bnxt and it seems to mark XDP queues, which means
> > probably my patches for igc, ena, and mlx4 need to be fixed and the
> > proposed patch I have for virtio_net needs to be adjusted.
> > 
> > I can't remember now why I thought XDP queues should be avoided. I
> > feel like I read that or got that as feedback at some point, but I
> > can't remember now. Maybe it was just one driver or something I was
> > working on and I accidentally thought it should be avoided
> > everywhere? Not sure.
> > 
> > Hopefully some one can give a definitive answer on this one before I
> > go through and try to fix all the drivers I modified :|
> 
> XDP and AF_XDP are different things. The XDP part of AF_XDP is to some
> extent for advertising purposes :) If memory serves me well:
> 
> XDP Tx -> these are additional queues automatically allocated for
>           in-kernel XDP, allocated when XDP is attached on Rx.
>           These should _not_ be listed in netlink queue, or NAPI;
>           IOW should not be linked to NAPI instances.
> XDP Rx -> is not a thing, XDP attaches to stack queues, there are no
>           dedicated XDP Rx queues
> AF_XDP -> AF_XDP "takes over" stack queues. It's a bit of a gray area.
>           I don't recall if we made a call on these being linked, but
>           they could probably be listed like devmem as a queue with
>           an extra attribute, not a completely separate queue type.

Sorry to be an annoyance, but could this be added to docs somewhere?

I think I did the AF_XDP case I did two different ways; exported for
mlx5, but (iiuc) not exporter for igc.

I don't want to hijack Gerhard's thread; maybe I should start a new
thread to double check that the drivers I modified are right?

