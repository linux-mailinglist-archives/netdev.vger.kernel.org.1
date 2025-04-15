Return-Path: <netdev+bounces-182745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C74A89CFC
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5FF172039
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C95292915;
	Tue, 15 Apr 2025 11:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="huZEZPcJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3374C1D47AD
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744718220; cv=none; b=LSFyE25qvYtZzRnnOFdanDF/soqO3/gT9Jdc1tqtS1BHCfY8u8lR9E1lDZj5Rz3gX6UfWUG70lL4VBmqkXWV78b52+g5j7eoaqDKExNANIozupnGwFBb3KYuol2RllyQrw0yAleCrn6jpEhMB1WE8zbUwlB3Z4hDh+EaRa1Bkhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744718220; c=relaxed/simple;
	bh=5yAVcJxOQv8Rb2mbuiu+g6eZAVL0C1KLbuq44NaNCdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HtxAVsMRlrZ93FDAdbw6iao6oxrkV/kKvmL4im/Te2YIrbKQ9GekmhfQpsw/uZLNOICpOa1fDcwRgPn+EShNBr2grkqxQVurHKVuhhCnShKwKMU4EHCMkytR1rghVUFC2g4ZD7OLHd4f27a5Mvg/nmbGS/nhm+V7pPYdPaSgN3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=huZEZPcJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso57330595e9.0
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 04:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1744718216; x=1745323016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N6dtMTXpeA9yP99GdbhluhOJP06ddUlIw3w6Qn/m58Y=;
        b=huZEZPcJXQIBmQNb0weasfGBiF31AznTu76x5ja4DWt+e6ofcPS9MBzZHAxTSdErcP
         amefNyrcTCRWco3Mv5HPINAFrGvN3btVmOOoq0HTRvU4vE/wECWsOAPTFhQ9bk9SlGqB
         x9VP4verC5igH2GFFoRQaqWqp9C9sXaK1yJrSPyk810FIWXOC26+QmHYGVOKyg8Skk6S
         Y5dJ8Oo4g3npS3tNmo3aJkfd2OrKzpYrFCMwRYVUnYNIDfW1FnC7RefSxMWmt42200D6
         43HxhX/Q2amoujkWy64CzjGxYR6NmnPGMW9YCMv/HpAMD9LEVBTqO2RSBT2tvjT85rOo
         YwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744718216; x=1745323016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N6dtMTXpeA9yP99GdbhluhOJP06ddUlIw3w6Qn/m58Y=;
        b=IwQs0puGTkRcgT3GBkp56fatRyFfaKnwOEKGPAFn9xYg4crJhHBcrW+nGyrH5PUNoU
         RVybkRiPO5UwL5B0I6fV0f6smwKjV1Cd22oqZB4k0sy1c2G742jUcDcUVDQL2yDBigAg
         xTPeIshJ0uVad2QG0/eOjiESVjzB9iviWX/BdyyL9KKgDyk6sfzoTuHIWtRjLI5Pl3S4
         jjjxRxEoVk+oJdFcNc3goH+1FjQplnywYC4D77m2RCgI9gyBjDNlooKiM6QJ8lOgxOQJ
         x3DM9KlMI7Bdnwr2Eul+c+oIM8XXgmnTbRlhGE6pcJ21l+yAiBrWdedwSSQsX2XB8Dbh
         0Rrw==
X-Forwarded-Encrypted: i=1; AJvYcCVpW6FsUMMTZg3IYOu+sHUtW4RnLvvXicc55iZ5aaZhJUXrVcHxDWitldyF9Ej1jwMdGzMwqmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbEdEg/WYYo2N6TUFsJ6n4d6ABEdoMvx2OA/EK9y+FBbliJRrN
	/ONPhYvqOtdHQZNuvSdFPGbXm8JvixKahDM4WSS2jgYoeTA4Qza0nU1aG4LZDNE=
X-Gm-Gg: ASbGncvN8JsNATlr2kqwaC5Qb1M6OrlvUdjfL324I+wN4u22af/FMfLWO0Tx8lG4yfw
	U8MFxb3vHqb34aWFZVPDMuKUTbP2/BNeOBvL5iY2wAKZrTERjW572Dv5Xj6Af4fwXdY4ieqn6nq
	+SJh4rgeOQPxanf8XUDw1LEEuq6EjANZhr7r9Ihbp/2zTPsfGWjcDU2Ci1HoPvHgHmONfXcTecj
	E9Xgqukb4YZ8ysmWKBnEYjA9tJEEqUKvLgasrkLeuHVVCgE+M8Lt5FLSa8mVyRIr4GodSS6rK/k
	3rNGkJtScnGZIX6vFqHUfUFvpC4FmTlR0SxBtwqJCSlfgN8bc8omdiMFDaUdDIRTKVunppGW
X-Google-Smtp-Source: AGHT+IFZ/8IzbGBjcCVDGk5eFuHy/8wS8TTEduyN66eJhFjsuFGZWnxgT2nwXvJ2IN9En6IOyhPwOg==
X-Received: by 2002:a05:6000:1848:b0:39a:c8a8:4fdc with SMTP id ffacd0b85a97d-39ea520372fmr14180025f8f.16.1744718216162;
        Tue, 15 Apr 2025 04:56:56 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae979620sm14185229f8f.52.2025.04.15.04.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 04:56:55 -0700 (PDT)
Message-ID: <76b303cb-0912-41f9-885a-9c4c045a6a51@blackwall.org>
Date: Tue, 15 Apr 2025 14:56:54 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: bridge: switchdev: do not notify new
 brentries as changed
To: Jonas Gorski <jonas.gorski@gmail.com>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250414200020.192715-1-jonas.gorski@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250414200020.192715-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/25 23:00, Jonas Gorski wrote:
> When adding a bridge vlan that is pvid or untagged after the vlan has
> already been added to any other switchdev backed port, the vlan change
> will be propagated as changed, since the flags change.
> 
> This causes the vlan to not be added to the hardware for DSA switches,
> since the DSA handler ignores any vlans for the CPU or DSA ports that
> are changed.
> 
> E.g. the following order of operations would work:
> 
> $ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid 0
> $ ip link set lan1 master swbridge
> $ bridge vlan add dev swbridge vid 1 pvid untagged self
> $ bridge vlan add dev lan1 vid 1 pvid untagged
> 
> but this order would break:
> 
> $ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid 0
> $ ip link set lan1 master swbridge
> $ bridge vlan add dev lan1 vid 1 pvid untagged
> $ bridge vlan add dev swbridge vid 1 pvid untagged self
> 
> Additionally, the vlan on the bridge itself would become undeletable:
> 
> $ bridge vlan
> port              vlan-id
> lan1              1 PVID Egress Untagged
> swbridge          1 PVID Egress Untagged
> $ bridge vlan del dev swbridge vid 1 self
> $ bridge vlan
> port              vlan-id
> lan1              1 PVID Egress Untagged
> swbridge          1 Egress Untagged
> 
> since the vlan was never added to DSA's vlan list, so deleting it will
> cause an error, causing the bridge code to not remove it.
> 
> Fix this by checking if flags changed only for vlans that are already
> brentry and pass changed as false for those that become brentries, as
> these are a new vlan (member) from the switchdev point of view.
> 
> Since *changed is set to true for becomes_brentry = true regardless of
> would_change's value, this will not change any rtnetlink notification
> delivery, just the value passed on to switchdev in vlan->changed.
> 
> Fixes: 8d23a54f5bee ("net: bridge: switchdev: differentiate new VLANs from changed ones")
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
> Changelog v1 -> v2:
> - dropped the second patch always notifying dsa drivers on brentry changes
> - dropped the cover letter, as its overkill for one patch and it mostly
>   reiterated what is already written in here
> - fixed the example in the commit message to use vlan_default_pvid 0
> - fix thinko brake -> break
> - extended the changelog to include the assurance that rtnetlink
>   notifications should not be affected
> 
>  net/bridge/br_vlan.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


