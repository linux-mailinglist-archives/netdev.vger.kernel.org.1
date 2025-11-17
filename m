Return-Path: <netdev+bounces-239044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DE7C62E1C
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 09:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1FFC534DEE4
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 08:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F8030F957;
	Mon, 17 Nov 2025 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJFKk2vl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06135280328
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 08:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763367877; cv=none; b=gTJock2bFSuX/3SLpbb+4gtBZJsiE17WhvMJf3SXicjg17a+clkmLsSwf38EoVTRG0WYkryBwomIjoSwVs8B08S+vG3+O4UaRGrVNggspX76fwqsMuQ6vC4Uk5UL8pzrn4nWrHtOz2RXmCLXsjXhToMrNuRkE7RXqm+LvKakBgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763367877; c=relaxed/simple;
	bh=g0P39zuPBvil9H9ZQrrobutdtWRGFDikvYxHxZzmnmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liyLw+6Ny1zczRctnpz4pB9jVPK/CtbKBPA8WsjDrkz0tcqAjB5Fqeo8MYgE412mWSjDqqBt9Ngb4wgPVMyYbZ4XvGxN6dYH1cwiwiJXThKhOU9V1zJa+o7/+pWDTaQt9+P9DnbabvWBKT2rEK2lj0HmEinSxRF8Ap/Uk/8xoCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJFKk2vl; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2984dfae043so36725855ad.0
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 00:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763367875; x=1763972675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TlfmmfbGgNs1vo+va+CLQu5LDEdNLZpb4q1hX8mhWak=;
        b=dJFKk2vlg2yUIykBozSFJDvWxJKRV208CVgk9oKXM4HJUpcQcyLAG7hlmIMg6LzPbw
         0UrJVmQFOoxB4DxdVAJ9oI99z8wKMltwVe2GeaRtgIcWz/OIe8zeNdFwYqU20LQoa+l/
         BMFnBpPcafAO8uMxjsZpBp8pHg4jnyxvlWiNkcLEkJXQMlZOMzLi6rYogbxCad2Np9xj
         F2eBPmGh7CQys4ANBjAGo42LiBRGjOq+Xz0HnfznU3FwHwMrkWfJXr1XWInOIvv3B54e
         X551O+ttf6w2Cte0D0Sea6G98KRO4NI0stJGtUTm8Z48dHYe2WYMHF9UQNZ3ncmD2AE/
         tiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763367875; x=1763972675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TlfmmfbGgNs1vo+va+CLQu5LDEdNLZpb4q1hX8mhWak=;
        b=SFSQX0ORlof9ycIheXYQb5jM0saYdAIOHX8UiEBG/ODaNNT8IqSZhgkYOpZJfBU7gD
         lqwh53es8jK2987h6ZVVTDNAKB19+ZaxvU/ramdbMAqeMdQi08yNH3suIHNAOeQ8qhKO
         6P1g7eHD+qzZuxUo+9bE2hytCKZlE34jEWPCUj+07sM3vaVxRxWMdCMF68w1KqodGPGg
         hg0de5GN4wUuXRFnqTihjmgIuXjb4a8SJMjbKB121A3sYy15ZJ0hXFxpnP0bZZ49N01m
         EXvetjQ1aZRmGvWyVB7kU0VDUkT8J1wcI9mDX6KYn8+0LEx7/r5ONYx09kom5sOPEa7e
         mdfw==
X-Gm-Message-State: AOJu0YzJ2y5sHFSGBwZaxAjeRYtNigv79YbVEKO8U/Z/DG4jJcgUj/fR
	jpplWxaz44qisvdGIw/wKYb2m7+UEZ+hKHB2rWAeJaoPlmwKxJVFeEZH4hWHrZzn
X-Gm-Gg: ASbGnctvAsZMIuHQE7O2yy9/ia3qj8vbBlR3qfF7p5yLGMdPbbbZmuSlC760k/UlVnC
	r3V2M9M8YEmSDlk7ar//iO+Y+7II5utcbXddpu4lqyR1GqUKDKqh6TAuPpW2oHgdWsr+avuFuvK
	DmtO7/Jcyi2bVjr1A6gJw8vieE9KPBeipEbxyrCau0pdVCDJzITeki4yy552kScbER3ne7aPi5r
	NgkpGffom+sTFM/SZ8yCQzJtmqcuKarxauCkQXA3QHEebbhQa8UdQbErx/1JNCpno+eA8hadKpk
	Z2khbYuNoZqxvkg9H76Qa5lDAxTIkUGlRAS57ILqzsvTn1EjTgigRTjrkR18AqJUvA+K+nkD0Oi
	T5o0z4c8R9MQCnCZDP0di4l6eb/bWBUTGkhFo/mvrwwC77RRHC13FJ3yYgw9qrSHlkiMAXDD+6P
	9u0rlQ
X-Google-Smtp-Source: AGHT+IFny+clG8GAy78kZX2QdQJTBoEqQ91J/6wiFTu6JFEwoASZ/l2czrMSsgkDxealyUSo4KOSzg==
X-Received: by 2002:a17:903:13ce:b0:295:105:c87d with SMTP id d9443c01a7336-2986a73b3b6mr127372435ad.32.1763367875069;
        Mon, 17 Nov 2025 00:24:35 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bf0d8sm131437745ad.85.2025.11.17.00.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 00:24:34 -0800 (PST)
Date: Mon, 17 Nov 2025 08:24:30 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: [TEST] bond_macvlan_ipvlan.sh flakiness
Message-ID: <aRrbvkW1_TnCNH-y@fedora>
References: <20251114082014.750edfad@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114082014.750edfad@kernel.org>

On Fri, Nov 14, 2025 at 08:20:14AM -0800, Jakub Kicinski wrote:
> Hi Hangbin!
> 
> The flakiness of bond_macvlan_ipvlan.sh has increased quite a lot
> recently. Not sure if there's any correlation with kernel changes,
> I didn't spot anything in bonding itself. Here's the history of runs:
> 
> https://netdev.bots.linux.dev/contest.html?executor=vmksft-bonding&test=bond-macvlan-ipvlan-sh
> 
> It looks like it's gotten much worse starting around the 9th?
> 
> Only the non-debug kernel build is flaking, debug builds are completely
> clear:
> 
> https://netdev.bots.linux.dev/flakes.html?min-flip=0&tn-needle=bond-macvlan-ipvlan-sh
> 
> A few things that stood out to me, all the failures are like this:
> 
> # TEST: balance-$lb/$$$vlan_bridge: IPv4: client->$$$vlan_2   [FAIL]
> 
> Always IPv4 ping to the second interface, always fails neighbor
> resolution:
> 
> # 192.0.2.12 dev eth0 FAILED 
> 
> If it's ipvlan that fails rather than macvlan there is a bunch of
> otherhost drops:
> 
> # 17: ipvlan0@if15: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
> #     link/ether 00:0a:0b:0c:0d:01 brd ff:ff:ff:ff:ff:ff link-netns s-8BLcCn
> #     RX:  bytes packets errors dropped  missed   mcast           
> #            702      10      0       0       0       3 
> #     RX errors:  length    crc   frame    fifo overrun otherhost
> #                      0      0       0       0       0         4

Hmm, this one is suspicious. I can reproduce the ping fail on local.
But no "otherhost" issue. I will check the failure recently.

Thanks
Hangbin
> 
> FWIW here's the contents of the branches if you want to look thru:
> https://netdev.bots.linux.dev/static/nipa/branch_deltas/net-next-2025-11-09--12-00.html
> but 9th was the weekend, and the failure just got more frequent,
> we've been trying to track this down for a while..

