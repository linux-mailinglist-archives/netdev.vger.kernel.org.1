Return-Path: <netdev+bounces-111026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BB392F626
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 09:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93375281675
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 07:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E891422B5;
	Fri, 12 Jul 2024 07:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="iL/KL6fT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D6813E3E4
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 07:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720769269; cv=none; b=eSODVxyDVQ67ZOHw+111UKMYow3xiz4J4wP3SoSt8W67MhVL2dfjaAi0cN+WbOBtoY+wZNIv7f85QcozUO0gbtC5NScU7p927ktXxiuA35EfJeed4toqNke8/MBj1lSMsFLHbpGxpqtF16RFM0jLRy50mWFs3NOrw16bB6hC/UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720769269; c=relaxed/simple;
	bh=P4mIafREpn6h7plQjYSpGs1UlyXzDra4OmllL9/yIZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FzTMN3xaiBL4iAbN7+f5rstWGf8Yv6lJ0D7jp5gvqctN8OqkMCrO4u74+zIkCIm5m1PHLmRJPGPk7k99wwGWujuSTNNLrfb/WNFRMp0YtJd2L9WuMv1FHu7Nh1Guo1x72MgLPgd+1BMW//B+duImjObZngsUvJoDz9XQxALu75w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=iL/KL6fT; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57cf8880f95so2103629a12.3
        for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 00:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1720769265; x=1721374065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LlwpSi63N1z5BUSejLoMf5VZ8PuCQqb4+FkOedv3l0A=;
        b=iL/KL6fTS0Rv/yPihzSnDn+CrxH8ZIadVV5+xldI7oQbXlMpb11mnWo9gKRljAV0nZ
         A8gfmnNkBQ69Id4tNUaT6F5GJff6onQ+uCFq53hYJFfskniqnmv43XRQpqKHJ2n7/WCm
         oxT6qneKoWExKiJJUakADIwTEUIFSs11sUqttXpUpQVVdd3FyLfWfOb4NZM+On87DaMJ
         QPx9p8AZTiUOTDaQ0XDFL0hr0tIKH2jeiRZvueNtPi002QMJyZNAU0rYgZMokPAe6p5l
         +N/r8CG/eWyXRXgAvmMgzulUPuPd6ZE84NqyH0yua2zVvRMGwgGcKf/VTSeauu6cEES8
         /b8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720769265; x=1721374065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LlwpSi63N1z5BUSejLoMf5VZ8PuCQqb4+FkOedv3l0A=;
        b=oGbAwZN2RsAR4FRU9++2/5flcNSMSQ5P4UDtvyJaLHOe0nx/FcZ6FXT+csj6u2oH3a
         uxdTJXXeOEPBYAVDb/mCeNZatiYuK7zCguIR/wcY10wo2NbsnrrbD8THoRkp0dKNdzb5
         4uk8/4QVG3LSR6BTUqAkflLsbUu8zUlDD3mORaeny6lglVzBa+d7MupaT7cDE7Le8O/C
         huyAjCz+WPwyVllMwmaT/4KnkcyYHxVoCOZNL+ZJkjMf+RYkh4geo3zpA2Y1hRZyT1vM
         oLbsTSprGhAfBcsYRDWTSZGx+5HWg3mnZN53yTTlrlD5ZzNXrnJ2YG6iO1qznkezLRf4
         zO8A==
X-Forwarded-Encrypted: i=1; AJvYcCXTl+TpLX6mNdJZsK6f4p27Ps4Nl1pooMxSit1y9X9TAftk4o4AhlAY70MHd6nrZm05DiT5fFrQLEBENCMYFDVSpx0ORjZ0
X-Gm-Message-State: AOJu0YwixQafyA4c4LEaYhV7gSDqyNlyUmlRembU73PmyvkgICk4o5r4
	oSTRYK3Vg+NwpkCu4GhI4ohLkxW5wJROLmwdZztd3K+mvNnnjwFzsCOvU6vXyxk=
X-Google-Smtp-Source: AGHT+IHgpOHeaT3lVGJdaXi/tIr1BOqe27pQXQR344YC5suu3getWDIJlHps77AKEhLiL7Q5GgUxYg==
X-Received: by 2002:a05:6402:11cd:b0:57d:2db9:15e7 with SMTP id 4fb4d7f45d1cf-594baf917e8mr10130318a12.12.1720769265456;
        Fri, 12 Jul 2024 00:27:45 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bbe2ce4bsm4244511a12.25.2024.07.12.00.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 00:27:45 -0700 (PDT)
Message-ID: <17d67de2-4f10-4454-addb-1fbb86a264ee@blackwall.org>
Date: Fri, 12 Jul 2024 10:27:43 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: bridge: mst: Check vlan state for egress
 decision
To: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>, davem@davemloft.net
Cc: Roopa Prabhu <roopa@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240712013134.717150-1-elliot.ayrey@alliedtelesis.co.nz>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240712013134.717150-1-elliot.ayrey@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/07/2024 04:31, Elliot Ayrey wrote:
> If a port is blocking in the common instance but forwarding in an MST
> instance, traffic egressing the bridge will be dropped because the
> state of the common instance is overriding that of the MST instance.
> 
> Fix this by skipping the port state check in MST mode to allow
> checking the vlan state via br_allowed_egress(). This is similar to
> what happens in br_handle_frame_finish() when checking ingress
> traffic, which was introduced in the change below.
> 
> Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
> Signed-off-by: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
> ---
> 
> v3:
>   - Properly reference port state to fix compile error
> v2: https://lore.kernel.org/all/20240711045926.756958-1-elliot.ayrey@alliedtelesis.co.nz/
>   - Restructure the MST mode check to make it read better
> v1: https://lore.kernel.org/all/20240705030041.1248472-1-elliot.ayrey@alliedtelesis.co.nz/
> 
>  net/bridge/br_forward.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index d97064d460dc..e19b583ff2c6 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -25,8 +25,8 @@ static inline int should_deliver(const struct net_bridge_port *p,
>  
>  	vg = nbp_vlan_group_rcu(p);
>  	return ((p->flags & BR_HAIRPIN_MODE) || skb->dev != p->dev) &&
> -		p->state == BR_STATE_FORWARDING && br_allowed_egress(vg, skb) &&
> -		nbp_switchdev_allowed_egress(p, skb) &&
> +		(br_mst_is_enabled(p->br) || p->state == BR_STATE_FORWARDING) &&
> +		br_allowed_egress(vg, skb) && nbp_switchdev_allowed_egress(p, skb) &&
>  		!br_skb_isolated(p, skb);
>  }
>  

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


