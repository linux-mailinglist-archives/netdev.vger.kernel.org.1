Return-Path: <netdev+bounces-178016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 644DAA74006
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 22:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4693A764D
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 21:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9341D6DD8;
	Thu, 27 Mar 2025 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCuJDAV+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5011DF745
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743109608; cv=none; b=Fo+ObUOWg3CE9dDuTwutNrTTl78f3dYS45at+7KWC+gE6bsFh0bX7sTUOJoFD9U4XvNfzlXVapX4j26MR6dRKbNfSky4HlYm9f+AOO1SaSR6B+8I4A0uira8bD4JepFSq2rKVE1TFC3F+GJ23RDE6KRo0Xx9vvrGozSzAZN2pXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743109608; c=relaxed/simple;
	bh=Gy+LLw6ybjdIYfgA/o9zBWpnHK86ITj4xiFS/CWzrjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uY2gNePo2r6YuO5aqVZ12Pca4VnrGvYCSoyeR3ZtMzZTExLtVM9B5RHRJFIJqvD37lSB+0Oh6GbeGpwe6E5b1K43aeRk6cXjiMt9RAU3VdXZj+hrfu9kaa1W8N9vw8qYGKxCyF9Fiuutd2+7MEzi2RWndlGGzZ/0e/TElDwixhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCuJDAV+; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-301e05b90caso2506524a91.2
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 14:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743109605; x=1743714405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fHgAcXJFMuob9LQNZ8sVMr4LxkHsV+xpGq7f4PmJnxU=;
        b=gCuJDAV+Hu++Kt/qxM1Waeg/tyw+sc2FnY+IFuUYblGZNxdGMHi+ry3QLfG4hoGynr
         nbz2Bbedt9yaWtC7xCIf1uZGYIqX0E3DnUFscW3xDAeYdF7h1va3hneuyaAFPWTdxkLo
         qOPAz2/TeTlZldOC/BbmYcuCJYnVswv1fssxcyIEv1PcRHU9I7M+1XhwobJ7UWhKL4Y/
         1Z6C0NvOhQOAa5ksPoWjV5YwtsCMButFCqFTUI/e7wQPtG5kbm60rlVWZHssfHUq2NOd
         GIrpEbOaa2NWzQcU5XeTbX5T8PfKTyZJfledbc+5YyOj7hm6eHPAKwB+VwmsaU7VrQGY
         /R1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743109605; x=1743714405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHgAcXJFMuob9LQNZ8sVMr4LxkHsV+xpGq7f4PmJnxU=;
        b=of4qtDhlt6Lk4yL5bQF1IGYj0Aq0Q8TsVBjhRTs1xdceg0enzqVK/eNGPOzRjJJtmJ
         xAAm42E0MZ3LbBx/7qEBETjdUDlvQmeZqge+DsVZ25qEdpy8jq+3kn0I5rPo5DWOyOex
         7FqnGUR+b+J50Lfp+iXSpd1snRWtuxDoePjOo45cJ6cD8bVp8j0Uxk8e8YJfSAvi8jpF
         cMnLusvMwrJnTzg/xIImFAEbF+YQpeWfiROcZWITzvcSRwqPYLkOmpEqiNBKfP4VdUHQ
         h3HGuDhjkRBsCJo6vYbGTvWnk1acFl3d3vjYBuiuDlG/aO8/nUDwl9DZyUFRUx2oD56M
         Kuow==
X-Forwarded-Encrypted: i=1; AJvYcCXoL5OqQgDR97pHuO4re5/dfbBVISww6taQTnpiYCJqdeBP7tUHXob3FdQXkGgG/v9MNJJyfEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcvdR2zhVExph5EkOx8T8N+YIDzTzMMHMglc+pSqpH4C6vtMm6
	Ms7ROWfMypy+F53joHgT5m9VgeYoyZpsCfQjXws4CwcGfvC1YZY=
X-Gm-Gg: ASbGncttpEJCdFe4iiDkvDaeAduqxAjsL/5uZBV8iwOdupebHivLnH2WVSL6cUukhhd
	pYSXvFXlz+73tQDnBC5/BtDh9NgAhzzpCx2hityamca2DBUd0pQcj0hobCiBh2ys99EHNdez0u0
	rKHzHmHmwqHbqRz69IkLFmnm/knrL7o/Cp2Kd31I68BezYAzEEbcborbyEa1TDNul1tlFqxpl+i
	zq87NaeRYjGDMI3+GEsNShgPCUltK01ro0PjZ3ZNVgll5hGzquwaeGNwOWuMbgoJGirVx1QH+bS
	3zqTIBKVFAfdRm3oHx+DAOMhTK4vSM1md8f3gp+TRuDn
X-Google-Smtp-Source: AGHT+IHmChEXkFFAcWcb/9fMSxm6nxL5mgEXY2SgGDno41UV664JKWmaJQh1/alASOjG2GZM9kTiFw==
X-Received: by 2002:a17:90b:3a0e:b0:2fa:1851:a023 with SMTP id 98e67ed59e1d1-303a9197d72mr7438343a91.35.1743109604683;
        Thu, 27 Mar 2025 14:06:44 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30516d3e049sm438193a91.6.2025.03.27.14.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 14:06:44 -0700 (PDT)
Date: Thu, 27 Mar 2025 14:06:43 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net v2 03/11] net: use netif_disable_lro in ipv6_add_dev
Message-ID: <Z-W945lsWMmZtisy@mini-arch>
References: <20250327135659.2057487-1-sdf@fomichev.me>
 <20250327135659.2057487-4-sdf@fomichev.me>
 <20250327120225.7efd7c42@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250327120225.7efd7c42@kernel.org>

On 03/27, Jakub Kicinski wrote:
> On Thu, 27 Mar 2025 06:56:51 -0700 Stanislav Fomichev wrote:
> > @@ -3151,11 +3153,12 @@ int addrconf_add_ifaddr(struct net *net, void __user *arg)
> >  	cfg.plen = ireq.ifr6_prefixlen;
> >  
> >  	rtnl_net_lock(net);
> > -	dev = __dev_get_by_index(net, ireq.ifr6_ifindex);
> > +	dev = netdev_get_by_index_lock(net, ireq.ifr6_ifindex);
> 
> I think you want ops locking here, no?
> netdev_get_by_index_lock() will also lock devs which didn't opt in.

New netdev_get_by_index_lock_ops? I felt like we already have too many
xxxdev_get_by, but agreed that it should be safer, will do!

