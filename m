Return-Path: <netdev+bounces-191534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47648ABBD90
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 14:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F27189AEB0
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E48626F453;
	Mon, 19 May 2025 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="mrdGGweK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FD61714B3
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747657040; cv=none; b=RC7vq4iUfkqVLX5rSONcH7bWpuqKMehQo0s73PUKIBzW64prELKenbpc/8kj5vhPvwS6LTVxpdM6NqQt69MOARKGNZcgflnt/O8aAj53/eb+uQSiyV+NS74J+XU07WpwYyQ0/zjrv5RZlH/JdPhKazkeLSaZdvIdpiK1j31Rp84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747657040; c=relaxed/simple;
	bh=xX9M3OPX9zekbbbU1qgip0spthLHonxw/Nshjqi4/eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CjXyZMIdIYJxD7YqvI/iePUk2+JadyrMBLceRl3yLJBXvOMuUdBvopi9hlNRLDyD1Yd/ifd2CmNVIQTziRyMsR1ai3k1u2gB0b18qDhqlAFrZJ/TPcXW4e9n1S0AXYCAJGRla8XSHXyObi0HTSyfK8n4pxr+dXpOj4FfVgMBm7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=mrdGGweK; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-550eb498fbbso3160290e87.2
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 05:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1747657036; x=1748261836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dYHp6/v5d2x17TX4X8wlvoCCU8HU8MfSmEB6Odf9L6U=;
        b=mrdGGweKZhtV+anAxX++Bf6mmQYysPsfsNkB81Q4PBiZiMeQ7dl1frAJJFBSRsy+t5
         +80GWjVgwoms0Pk/duPIW0SizmCSzBi5LUCVgCt2VkD8Ly9Fw7H/ghDHns/PgKKdHBju
         RHAOeDb+VtiVYOTEOSPUH4xsRc4GipaFDi86qaVLsjpiu7sZo7yhu9E6zQDLR55EXvRh
         J6hem9TwBEsGSurnITqadSj3LFEhb6AinSRE1nFV0n00mHtZ2kcS7RLlXwc4aQu3Gy3w
         zCormm81/enlArp/r4mVOfMJQtfU92EOkcBLftmurKGHHHASIfw4VqB8eK48tiW98AeG
         eAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747657036; x=1748261836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dYHp6/v5d2x17TX4X8wlvoCCU8HU8MfSmEB6Odf9L6U=;
        b=IdbzbM8CiX/pLKuGqB5d0YLWDz1uD0jrAcbXH/KwWXH0YkeZpTVr4FMKLU4kmX/YfD
         Zk4tGJKy1mzt73KTHnwa5cPgmWISObSOSs7TsA3f2v5LwO2ZdA5NY8BvGx1aqoJ6Tto8
         3PvG90shu9/xgEYNIsh7fDMz0iCD9NmK86dJEnRZE3NOv1Pfs19WlmZe9UdLlSVV3oPO
         QQWsGqHaZYoYleI8lvKcJJgpB0VVGyKLxHdgeDzmRISrHJfwgj4iQ/iWvQPlJRxwM9KH
         wuWbLQHEgm4aHPW4tSJTfFJ6h4Lm37gQ+YMU5m3O4Fg+H4wD/CjTbbydZKj7BMGqRH4S
         +8KA==
X-Forwarded-Encrypted: i=1; AJvYcCUvoNKNYf66nlSODtK846q4NH319SpsB1h1wP3i1/XCZEA24lOWcqBwbQi+VM1J+BdaqsWQ3rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNxLhpkRUtd9R237if9yJ00E2v7vhxcesozM3TQe9nNCNR8wcL
	nQ16gmCx+jKUmxKBkwP2fU+XdffjvNL/KDPlrcNCzp+YPiwQ5PuCyggsHOgqHkQi8Pg=
X-Gm-Gg: ASbGncsz8XCYfOn2HYXnaxQtkeK+BJdpPcmnG8Uj79RjstXY0zIwaVKPTYTWKtOKWTQ
	yIOQYqL8TL8HyksVSpIaCBrrrugUNvfCaNYYF6YjMmTlzHMjn3UBT7QHOaGLcm9No1pw5IAKUy+
	giUG9SVEghBJlPmbq2g24/iBOTkWuFl1BBLrXuMKI9EK5KN0Umcg8d6tD1uqlVMNvPo4eRaCMKy
	PzCSEWwpZKeu3pllH2xf5T8QYiKwS+At4v71AuRRUcZEw3G5PlwYNu3a2qbGerig9AmmxN78Nbn
	awHs0vd0Vq3WNTJqXhVtFo1MTYbtOaiaubRKZNKTiKHkV3toxXsW/rWsFrjmhLYAVs0VwFStSpu
	uKYBDUQ+euIrcQGzeKnPQ7jU+WwqqF+w=
X-Google-Smtp-Source: AGHT+IHVRPK5iWNXMFn1xAdtDY1XD2K5ake/kESIQIBK4Tr+wdkojxWBAxeKGK81Ft2tt1Yrp7pohw==
X-Received: by 2002:a05:6512:4602:b0:545:2950:5360 with SMTP id 2adb3069b0e04-550e97b5bfemr3729380e87.22.1747657035673;
        Mon, 19 May 2025 05:17:15 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.185.kyiv.nat.volia.net. [176.111.185.185])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e7018194sm1821327e87.146.2025.05.19.05.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 05:17:15 -0700 (PDT)
Message-ID: <1194d026-ea54-4e86-b0e3-e5d73bc74c36@blackwall.org>
Date: Mon, 19 May 2025 15:17:12 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 0/4] add broadcast_neighbor for no-stacking
 networking arch
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Zengbing Tu <tuzengbing@didiglobal.com>
References: <B713F1A654D10D79+20250519084315.57693-1-tonghao@bamaicloud.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <B713F1A654D10D79+20250519084315.57693-1-tonghao@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/19/25 11:43, Tonghao Zhang wrote:
> For no-stacking networking arch, and enable the bond mode 4(lacp) in
> datacenter, the switch require arp/nd packets as session synchronization.
> More details please see patch.
> 
> v5 change log:
> - format commit message of all patches
> - use skb_header_pointer instead of pskb_may_pull
> - send only packets to active slaves instead of all ports, and add more commit log
> 
> v4 change log:
> - fix dec option in bond_close
> 
> v3 change log:
> - inc/dec broadcast_neighbor option in bond_open/close and UP state.
> - remove explicit inline of bond_should_broadcast_neighbor
> - remove sysfs option
> - remove EXPORT_SYMBOL_GPL
> - reorder option bond_opt_value
> - use rcu_xxx in bond_should_notify_peers.
> 
> v2 change log:
> - add static branch for performance
> - add more info about no-stacking arch in commit message
> - add broadcast_neighbor info and format doc
> - invoke bond_should_broadcast_neighbor only in BOND_MODE_8023AD mode for performance
> - explain why we need sending peer notify when failure recovery
> - change the doc about num_unsol_na
> - refine function name to ad_cond_set_peer_notif
> - ad_cond_set_peer_notif invoked in ad_enable_collecting_distributing
> - refine bond_should_notify_peers for lacp mode.
> 
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Zengbing Tu <tuzengbing@didiglobal.com>
> 
> Tonghao Zhang (4):
>    net: bonding: add broadcast_neighbor option for 802.3ad
>    net: bonding: add broadcast_neighbor netlink option
>    net: bonding: send peer notify when failure recovery
>    net: bonding: add tracepoint for 802.3ad
> 
>   Documentation/networking/bonding.rst | 11 +++-
>   drivers/net/bonding/bond_3ad.c       | 19 ++++++
>   drivers/net/bonding/bond_main.c      | 86 ++++++++++++++++++++++++----
>   drivers/net/bonding/bond_netlink.c   | 16 ++++++
>   drivers/net/bonding/bond_options.c   | 35 +++++++++++
>   include/net/bond_options.h           |  1 +
>   include/net/bonding.h                |  3 +
>   include/trace/events/bonding.h       | 37 ++++++++++++
>   include/uapi/linux/if_link.h         |  1 +
>   9 files changed, 197 insertions(+), 12 deletions(-)
>   create mode 100644 include/trace/events/bonding.h
> 

Again and more explicit - please CC *all* reviewers on the full patch-set
when sending a new version. I had to chase down the patches on the list
which is a waste of time.

Thanks,
  Nik


