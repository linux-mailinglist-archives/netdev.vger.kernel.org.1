Return-Path: <netdev+bounces-147946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FF79DF388
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 23:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555B0280FFE
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 22:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2731AC445;
	Sat, 30 Nov 2024 22:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b="AvEk8YTc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4A41AAE34
	for <netdev@vger.kernel.org>; Sat, 30 Nov 2024 22:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733005727; cv=none; b=OJIXk0mLAu1IAenZPiQASgeiJP/xPt2/axJdNIRNuXiDRRhNDlAc7FqotqqikZXH8klhij3OCBsGHcMPodbtlVkqmRUPTqcwdoIssDLDL1A6eGeccOU5yRqKUqj5FcY9gIYpDTZiHQoKLDWQtZqvfoDWnKgZXlm0wzzUCzkAFxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733005727; c=relaxed/simple;
	bh=7Wdetpt4bdjb03TKiWu74j2GUFJllbRsXuM68hzws7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lU2bP41UrfgodMlsi52ORRbszA3t4JgUgtH5GEWJSsMWyQQqHWEo/K30g120CMgs/MRf3B7w6MEhI14WJT+Qfe0znlLLlvGsvgJWE0Gd27zrhmN+a7lcG0A06pbGpEt9Ian48z29q6Bh4QI5B0XT2BfgmkSgrkJkFSKq8/TSR+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com; spf=none smtp.mailfrom=andrewstrohman.com; dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b=AvEk8YTc; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=andrewstrohman.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e3982e9278bso2047600276.2
        for <netdev@vger.kernel.org>; Sat, 30 Nov 2024 14:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrewstrohman-com.20230601.gappssmtp.com; s=20230601; t=1733005725; x=1733610525; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7Wdetpt4bdjb03TKiWu74j2GUFJllbRsXuM68hzws7A=;
        b=AvEk8YTcxL92nFNLf8S634lS8kVKEUu2yw5DY+uLKrjucSHCam+YcVr1m+TTdj9D5b
         jxunNoSlMlvmUOuExEelfdKFivCGa+7s45TLFdnyfsP+6gzelXLR+omGCCDgAF7O+JN8
         FMSTQAHfyxXQLmFAIHdzS6LijF3H4KaHkxC8gDnxnstXmhu0pJsCTmj5yhzg3iChUbTr
         NIVOLCvOdnRHWFWmfqjCZgcRTXqtOm8UfUiSl9eUBUaFG8IrMS3IMMWcgW7a+WBPWhU1
         wi1tD3bUm0pAEdvZE08kgWrfu4lBfP2qXSZPcWG47Rk8rTpwPxe0wLA/kMRqAwqPcpNW
         CkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733005725; x=1733610525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Wdetpt4bdjb03TKiWu74j2GUFJllbRsXuM68hzws7A=;
        b=RO3aqLJE4l/pXrQM2SfNDjma8YBidJTGeIpp1VNevwn7ET8+oBQwypjo6NNfEV3vHX
         6G2o7UnIfZBY8xCvTgz+I+smGadIDPGVgyTFk+Qg1zHTDReHWa7jWXkRXVT4gNoQ8Vw+
         0MmJHRXGmey6Td+GEgfwIbL2k1+pIVQQIvl2gnFruGk3xwkQB2ozYU40CaxTQM/TbGo5
         WxwUJB9QalFz56LSvyLnKmDUzl4YP7wdNuMTqDou4w9EGQL4g4EIukFpj6Ewd1OgXCdV
         YpMam+NU060vhn0KAHk+KAsLveAXCoGcwDS6/7+AzQ5+Q/sRnaY5F4kV69GtTnJPBzBR
         1Svw==
X-Forwarded-Encrypted: i=1; AJvYcCVwimwaslsv/mia8GYFHpud2N0Uv6xdao8vzfvYPz8FPx+jOoRywlbDWXr5qgYPks83wUrBJFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGP8Vswnb4YJ3tNPIZEqLsYOIlImvdlmswNREU/KbwGoxvfFEq
	5wt5eX1MZKr5zqIM+CQcdW8L0SmXOO7RySkSHcLva6N7kMrRMR1XR3xMzK5s+B4CdPf1NshjKUC
	Y438cgZTyH1cTjZjsLqFg0TjZsVcPmnPmEfrpiw==
X-Gm-Gg: ASbGncu1SikDWvZBUsczGLRbChMZo/irlPMccfdPB4EH2666UEHPa4a4K3rTTncRiWa
	zodpXM7PjpUWYrJxorLlJXGQA4j/EXt4=
X-Google-Smtp-Source: AGHT+IHfnTZT06dr55uMoGVVPSi3LB207JWWsC6/9JeXc0W+4fBNcHyu/kAuUK9CXwsbr7aiFeRwXRPIXc7R/5ScSg4=
X-Received: by 2002:a05:6902:2087:b0:e39:84c6:3041 with SMTP id
 3f1490d57ef6-e3984c633afmr9172615276.22.1733005725180; Sat, 30 Nov 2024
 14:28:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130000802.2822146-1-andrew@andrewstrohman.com> <Z0s3pDGGE0zXq0UE@penguin>
In-Reply-To: <Z0s3pDGGE0zXq0UE@penguin>
From: Andrew Strohman <andrew@andrewstrohman.com>
Date: Sat, 30 Nov 2024 14:28:34 -0800
Message-ID: <CAA8ajJmn-jWTweDMO48y7Dtk3XPEhnH0QbFj5J5RH4KgXog4ZQ@mail.gmail.com>
Subject: Re: [PATCH net-next] bridge: Make the FDB consider inner tag for Q-in-Q
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Shahed Shaikh <shshaikh@marvell.com>, 
	Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Simon Horman <horms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Roopa Prabhu <roopa@nvidia.com>, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bridge@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Nik,

Thanks for the review.

> This patch makes fdb lookups slower for everybody, ruins the nice key alignment,
> increases the key memory usage

I could make the additional, inner_vid, fdb member variable's existence
depend on a compile time flag, so that these penalties would only affect
the users that want the feature.

> and adds more complexity for a corner case, especially
> having 2 different hosts with identical macs sounds weird.

I admit that the use case is rare. In this commit message,
I focused on the duplicate MAC scenario, because I thought that would
be the easiest way to describe it. If the problem is hosts with duplicate
MACs, that's probably best remedied by just assigning a different MAC, or
translating that MAC before it reaches the 802.1d bridge.

There might be a potential DoS opportunity, if an attacker knows
the MAC addresses on a different VLAN. Consider someone on a "guest" VLAN
transmitting a frame sourced with the MAC of a server on the "production"
VLAN.

My personal use case is about simulating ethernet connections and VLAN aware
bridges, so that I can test networking equipment that provides VLAN
functionality with IVL.
https://github.com/andrewstrohman/topology-sim/raw/refs/heads/main/docs/Topology%20Simulation%20for%20Mesh%20Testing.pdf?download=
describes it, if you're interested in more information about it.

https://docs.google.com/drawings/d/1FybJP3UyCPxVQRGxAqGztO4Qc5mgXclV4m-QEyfUFQ8
is a diagram that shows what I'm thinking about. This case is not about
duplicate macs, but rather a frame being bridged in a way, such that it passes
through the same bridge twice via different ports depending on the inner
VLAN. In the commit message, this is what I meant by the poorly worded:
"L2 hairpining where different VLANs are used for each side of the hairpin".

The diagram depicts a network where a layer 2 segment is partitioned by a
L2 (bridging) firewall. I admit that this is contrived and not a typical
way of constructing networks.

In this case, my testing system would use a 802.1ad bridge to simulate a
VLAN aware bridge between .1q #1 and .1q #2. The problem is that the .1ad
bridge would get confused about which ports hosts A and B are behind.
The bridge would see them behind different ports depending on whether the
packet was heading to, or returning from the bridge mode firewall.

If these nodes were connected with an IVL .1q bridge instead of the .1ad
bridge, this topology would work. So it's a scenario where connectivity
failure would be due to my testing system (topology-sim) instead of the
networking equipment being tested.

> Fdb matching on both tags isn't a feature I've heard of, I don't know if there are switches that support it.
> Could you point to anywhere in the specs that such support is mentioned?

I've never heard of this either. It's just an idea that I had. I don't
know of any
switches that support it.

> Also could you please give more details about the use case? Maybe we can help you solve
> your problem without impacting everyone. Perhaps we can mix vlan-aware bridge and tc
> to solve it.

Thanks. I tried to give the relevant details of my use case above. I think
that using tunnels instead of VLANs would fix this for me, because the
switches would not learn the inner MAC. But, the tunnel header has more
overhead compared to adding a tag.

> As it stands I'm against adding such matching

Fair enough. I also have concerns about complexity vs value, myself. I
just thought that I would give this a try in case others found it useful.

