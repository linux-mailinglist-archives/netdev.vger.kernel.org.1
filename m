Return-Path: <netdev+bounces-148401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCEC9E166A
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 09:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10046B2335B
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4E11BD504;
	Tue,  3 Dec 2024 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="Z/vaFr9m"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A512A189F39
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733214056; cv=none; b=YpAkygFBqRERPK8eOopVMO3Y+sEskP+fP0dQJh6GNRrrb/dwih62UtyA557NhWy/7U/RaXoEKo7yF1oYimIfwpCfPGfVQnrdiq3NnNEZJH4cpQOmGAoTTH0mouREBLwd0xp+Qi+s0HsTQ1rVYr0tosu7V2RtNUVH2GxAvGzo/vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733214056; c=relaxed/simple;
	bh=a/ziReuEbT1K8R1zLEe+HU8Wkbwhm+/KX9r1MAxFvJ0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=IuvNDKXHjiqki5y3TAdfU3yK3+aXZkA5TiupWxIMFGsU01eV12jsbdpcuHdVKJjtC86N0zhKXIt5B+++iOGUjznTDETTUmFRJ+vRgdXvN8oga5c38FCjc8IxkoB6ms0R7akt2jXiCilMpOC8v7MbtrcLj1IoGPGkZ+XJdtokzzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=Z/vaFr9m; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:2:9c63:293c:9db9:bde3] (unknown [IPv6:2a02:8010:6359:2:9c63:293c:9db9:bde3])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id A25317DEBC;
	Tue,  3 Dec 2024 08:12:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1733213557; bh=a/ziReuEbT1K8R1zLEe+HU8Wkbwhm+/KX9r1MAxFvJ0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<bb2cd5e8-39c3-4fc4-e02e-2c2d6bf01f64@katalix.com>|
	 Date:=20Tue,=203=20Dec=202024=2008:12:29=20+0000|MIME-Version:=201
	 .0|To:=20Guillaume=20Nault=20<gnault@redhat.com>,=20David=20Miller
	 =20<davem@davemloft.net>,=0D=0A=20Jakub=20Kicinski=20<kuba@kernel.
	 org>,=20Paolo=20Abeni=20<pabeni@redhat.com>,=0D=0A=20Eric=20Dumaze
	 t=20<edumazet@google.com>|Cc:=20netdev@vger.kernel.org,=20Simon=20
	 Horman=20<horms@kernel.org>,=0D=0A=20David=20Ahern=20<dsahern@kern
	 el.org>,=20Andrew=20Lunn=20<andrew+netdev@lunn.ch>|References:=20<
	 cover.1733175419.git.gnault@redhat.com>|From:=20James=20Chapman=20
	 <jchapman@katalix.com>|Subject:=20Re:=20[PATCH=20net-next=200/4]=2
	 0net:=20Convert=20some=20UDP=20tunnel=20drivers=20to=0D=0A=20NETDE
	 V_PCPU_STAT_DSTATS.|In-Reply-To:=20<cover.1733175419.git.gnault@re
	 dhat.com>;
	b=Z/vaFr9mYHN+ZnqlQb2pfdm3NAGrttWO1FvyuCN/AEEnCnLqO+nfmYHJnxS8MZr3e
	 rP020xWUzDI0+0F3kHdlA9bMW+65ZqXXgFE0Bp7A2wIkn0NCad+JApfuaNOgopBBt3
	 d/iP7f2CLFXfWzokuI9224iEaLKlWcn3dz/+9XQTcU28oddcc7IqdkYYa/9UlJU3XC
	 bI8r5EmLhKGsbh1PQr78oLkCOqfbj+OXTGg8Tate/OgP6XhMUlMCHz0Wt1NAXn9zKK
	 siG8Haf+p3ZYJPGUPNZskgAEqUbSetYMsXgtWyPsOVknicqINIctKHzQ0b7PukrrOR
	 pOBeVm+FB9hlg==
Message-ID: <bb2cd5e8-39c3-4fc4-e02e-2c2d6bf01f64@katalix.com>
Date: Tue, 3 Dec 2024 08:12:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Guillaume Nault <gnault@redhat.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
References: <cover.1733175419.git.gnault@redhat.com>
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: [PATCH net-next 0/4] net: Convert some UDP tunnel drivers to
 NETDEV_PCPU_STAT_DSTATS.
In-Reply-To: <cover.1733175419.git.gnault@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Guillaume,

I can work on similar changes to l2tp if you haven't already started 
work on it.

James

On 02/12/2024 21:48, Guillaume Nault wrote:
> VXLAN, Geneve and Bareudp use various device counters for managing
> RX and TX statistics:
> 
>    * VXLAN uses the device core_stats for RX and TX drops, tstats for
>      regular RX/TX counters and DEV_STATS_INC() for various types of
>      RX/TX errors.
> 
>    * Geneve uses tstats for regular RX/TX counters and DEV_STATS_INC()
>      for everything else, include RX/TX drops.
> 
>    * Bareudp, was recently converted to follow VXLAN behaviour, that is,
>      device core_stats for RX and TX drops, tstats for regular RX/TX
>      counters and DEV_STATS_INC() for other counter types.
> 
> Let's consolidate statistics management around the dstats counters
> instead. This avoids using core_stats in VXLAN and Bareudp, as
> core_stats is supposed to be used by core networking code only (and not
> in drivers).  This also allows Geneve to avoid using atomic increments
> when updating RX and TX drop counters, as dstats is per-cpu. Finally,
> this also simplifies the code as all three modules now handle stats in
> the same way and with only two different sets of counters (the per-cpu
> dstats and the atomic DEV_STATS_INC()).
> 
> Patch 1 creates dstats helper functions that can be used outside of VRF
> (before that, dstats was VRF-specific).
> Patches 2 to 4 convert VXLAN, Geneve and Bareudp, one by one.
> 
> Guillaume Nault (4):
>    vrf: Make pcpu_dstats update functions available to other modules.
>    vxlan: Handle stats using NETDEV_PCPU_STAT_DSTATS.
>    geneve: Handle stats using NETDEV_PCPU_STAT_DSTATS.
>    bareudp: Handle stats using NETDEV_PCPU_STAT_DSTATS.
> 
>   drivers/net/bareudp.c          | 16 ++++++------
>   drivers/net/geneve.c           | 12 ++++-----
>   drivers/net/vrf.c              | 46 +++++++++-------------------------
>   drivers/net/vxlan/vxlan_core.c | 28 ++++++++++-----------
>   include/linux/netdevice.h      | 40 +++++++++++++++++++++++++++++
>   5 files changed, 80 insertions(+), 62 deletions(-)
> 

-- 
James Chapman
Katalix Systems Ltd
https://katalix.com
Catalysts for your Embedded Linux software development


