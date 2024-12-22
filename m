Return-Path: <netdev+bounces-153965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2287D9FA50C
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 10:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B1C188892D
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 09:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6826187555;
	Sun, 22 Dec 2024 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="duT34jTQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD94632
	for <netdev@vger.kernel.org>; Sun, 22 Dec 2024 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734860880; cv=none; b=kU2T7ZPLrbu8PMKWaofO1uHEt5irBJJNNC2Gw0Xhy/l+8Mx74Af3dYSyJdKhq0fJp5pLTIl3/TtY5G3hf7tpHySWpSv0yM5UCXz4H3jp/oRCxCmhfrHWZaCqnnWB3SOhTnolecplrD1KrRBc3LEucx3bLTBo8QODxCzpsF5LoQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734860880; c=relaxed/simple;
	bh=96xyyFmwBHZS0vGuPUHDQfo6PiDu5wU9W5WNoD4FPm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hyrENyafSJWXsoO3j1sCks0xVzEAcZTCPKclVlggZkn3uUBjsMnM5A5zBdw76wEuhw/ztjJO19QRlWkAocNOTNr3uGfKnIOkFtSLEzL7LBya8FPdDBABXp73CK52Wldv+Zlhz8ZYDrP0I/gpQXr4JuN9expuaFmgjAxfN8hQxrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=duT34jTQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4363ae65100so35428845e9.0
        for <netdev@vger.kernel.org>; Sun, 22 Dec 2024 01:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734860877; x=1735465677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jr9s/wEFXQFEgy5W79KAW8kmZ6yqcSTB1nkgsGLRiEg=;
        b=duT34jTQOnogiFR/ho+hYnTdqrspArkN8ASwbWPRwGMWz/iJ/EpvOAPa1rP7OhYPiy
         vf13ignDlGPASYqbqNXIdlaobD8yPBCWoiq9kBendRnLRkFdvGZCDJ10VwmDEWpaq5cH
         BFlTXp6CQ2Hg2fPUANMdLV7DjJ+0N2sREC7eXCfzFQ2aso2I+vYGOMpzo3NjvIzjzNAE
         lqY8CJLcAf1S923Z9ScwJhJmJ23SQTEHh4GOB6wUY+dv1b7APuCs3vHf1rMzEKbAXYaK
         Os7Owjx2CCHc7DzE2PmA/6vLrpecxncY+gQmmn95vhpXjDEyTm3W7v3tTh03xQLPOTGL
         Vf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734860877; x=1735465677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jr9s/wEFXQFEgy5W79KAW8kmZ6yqcSTB1nkgsGLRiEg=;
        b=ms8muoVnLhF+lQGQhJrTUEHxXKrfzr+OLEhxPAljyfQfbR4yK6HNH2k3hBywlFBGX2
         hH0G1mwXEw7xrwrhrymlWw99eFACJ3IGr0/m31CvWWbEim4dHEOeTjW/JDnOiLzgHCQF
         xW1l/ciJwUFP3o3En9jhB9PCA8SzkV7TvfHb+u+7+3RMSL/NJKYXEiE47YhW/VxbNnxV
         ptgwx6kz4k7ghpYMzGoGyUJfgBp4O+VFgBr7FVdp/JnOYd9Wq+g5JHxaKVUq9WfVR584
         eXmQcn5S3P35Fek7DOY0bUfv3SWhNGJ6MX/eTncOtH7tl0HwlJBQYF9vwQ+BniDYg+Vp
         wPXw==
X-Forwarded-Encrypted: i=1; AJvYcCXyGKhTHHVtdI69EglNfivsI/Qdvotn6vAc4s1d3tARBOQuqnYAhRxQ9rjgNEWPOHf5BZBKKnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgk5LOUkDF8vZY55UXDowSJz2yjtUXBkeAblpO8HpHt481vB/o
	AhPfYptF6k9IwdQJHvenV0QTGTKqA9t6n8RkCzTnryF1sYTMIoUHeC/zu+GB9QQ=
X-Gm-Gg: ASbGncu8ugiaiT1BL72/nhKVYKdORV3YodIwt+D0F+qkJQQ7VgKs+t/GLYIFXHKOKzG
	qR7AVqtTNaJUcXTciM0WzdGXP5llz1k27i7RIvWhBtExr0OKZL7S04s685ew8BGOW1Q2PQ0Yqpm
	PDBymPO7/IxIHdbtGJbrXnfBgw1mSniBSWN/iltVMAaIerDtBVxbxBx2gbPOAu+MUtZuytcP0SM
	vaXKU5c06OkkI3YY9pRhmKDz6Fw6y4n9HVGYNVWKnm7QZNvNPzAlaNqiiNMHw==
X-Google-Smtp-Source: AGHT+IFFUPOD9lQGPcXbq8xd6zyf5wVbg0nk4IKmdVXabGHAOJsS3nuQKHcgAscr1l4qCavDSMQgRw==
X-Received: by 2002:a05:600c:35cb:b0:436:1baa:de1c with SMTP id 5b1f17b1804b1-4366854c186mr76809865e9.13.1734860877429;
        Sun, 22 Dec 2024 01:47:57 -0800 (PST)
Received: from [192.168.0.105] ([109.160.72.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436612899f0sm99096085e9.38.2024.12.22.01.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2024 01:47:56 -0800 (PST)
Message-ID: <41ac7bde-9760-44db-9287-dfcc986657c6@blackwall.org>
Date: Sun, 22 Dec 2024 11:47:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] bridge: multicast: per vlan query
 improvement when port or vlan state changes
To: Yong Wang <yongwang@nvidia.com>, roopa@nvidia.com, davem@davemloft.net,
 edumazet@google.com, netdev@vger.kernel.org
Cc: aroulin@nvidia.com, idosch@nvidia.com, nmiyar@nvidia.com
References: <20241220220604.1430728-1-yongwang@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241220220604.1430728-1-yongwang@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/21/24 00:06, Yong Wang wrote:
> The current implementation of br_multicast_enable_port() only operates on
> port's multicast context, which doesn't take into account in case of vlan
> snooping, one downside is the port's igmp query timer will NOT resume when
> port state gets changed from BR_STATE_BLOCKING to BR_STATE_FORWARDING etc.
> 
> Such code flow will briefly look like:
> 1.vlan snooping 
>   --> br_multicast_port_query_expired with per vlan port_mcast_ctx
>   --> port in BR_STATE_BLOCKING state --> then one-shot timer discontinued
> 
> The port state could be changed by STP daemon or kernel STP, taking mstpd
> as example:
> 
> 2.mstpd --> netlink_sendmsg --> br_setlink --> br_set_port_state with non 
>   blocking states, i.e. BR_STATE_LEARNING or BR_STATE_FORWARDING
>   --> br_port_state_selection --> br_multicast_enable_port
>   --> enable multicast with port's multicast_ctx
> 
> Here for per vlan query, the port_mcast_ctx of each vlan should be used
> instead of port's multicast_ctx. The first patch corrects such behavior.
> 
> Similarly, vlan state could also impact multicast behavior, the 2nd patch
> adds function to update the corresponding multicast context when vlan state
> changes.
> 
> 
> Yong Wang (2):
>   net: bridge: multicast: re-implement port multicast enable/disable
>     functions
>   net: bridge: multicast: update multicast contex when vlan state gets
>     changed
> 
>  net/bridge/br_mst.c       |  4 +-
>  net/bridge/br_multicast.c | 96 +++++++++++++++++++++++++++++++++++----
>  net/bridge/br_private.h   | 10 +++-
>  3 files changed, 99 insertions(+), 11 deletions(-)
> 
> 

Hi,
It seems there will be another version (see kernel robot), can you
please add selftests that verify the new and old behaviour?

Thanks,
 Nik



