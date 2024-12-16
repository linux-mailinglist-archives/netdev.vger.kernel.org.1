Return-Path: <netdev+bounces-152266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 800549F34F0
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1EDB161E2E
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE191494C9;
	Mon, 16 Dec 2024 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGRgqGMa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BBF13D61B
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364194; cv=none; b=WPk07HeomjZkHLfr7AQMNTI/YSudKlb310O4S7O2HD/7vJGLVzRov9i9ftW3uo9exCStUCrt0rxv0CLEfDLIc4gVBVN4zrZnKjNx4w6o7tJ86p9oFQ5rzGeIqiXdnffL2fApVslFuNTsedonmnfmKIrqVv5dYquc8CkPGz9gvHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364194; c=relaxed/simple;
	bh=OERRW4Xs7V9ucgttPt3rRxOUnu3qwpwIs0Brqj1Rupw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hhg1/njnkyGHbdO/2FDBYpiWL0EzSmDHanD6p6ztakf/QtxtcavcznYmxRXYTEQjIY4WfTmIyxgrz3fNsT2AlP9qRM4pS9aSahDoXZQzYh9faXRqDNGRFfeDn3I/2Q1PtkiHQpn30wrJw7opHtM+tI8YgSqMcFaKGFsldqsdzCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGRgqGMa; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385e44a1a2dso437796f8f.3
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 07:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734364191; x=1734968991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hytvqia2Iz4oarM8pBxyao8l7VRK9O6L+zwEfab8bIs=;
        b=OGRgqGMav84AmQD6+2Q+aD6cl5LAszsUv1ZDyjXncSchoH+/LN2cneC2w1TU9rWZoi
         oiK1mghK8ffz45d4Q2Bu9BgzsH5aCHCFN/I9ufllsQQoaMxlWSYWO9IbYc6sphtMVjiT
         ai3JugatHCD0d/WyLIemUjZlMlHKfS7NTV0kPf12WHtHmkYyvrd7a5cLI092+ZArAezX
         93lnI9yIasPwlCEcZ36+8oAGQ3gmqVFP5/TUHHJpvIfD1kKLgpCMOxzJyWDni+iwCsDE
         9tTOM8zdov412/u+ZjGCg+mzUGVBuDDys9aB4xJZ/RjSME1lwsev82neqTbHi3adUgcm
         /RNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734364191; x=1734968991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hytvqia2Iz4oarM8pBxyao8l7VRK9O6L+zwEfab8bIs=;
        b=LWMdyezOKU1K9bi6e/WYQIM5Jc4a4rM7A4YaW2J7nzFpvaGaHoiDXtgcwjXgjpaCHt
         OgmpB5wubRuwg+Gt6geOJFCe99NmP0HHf9jiVC/B7wcY1MROa3DgdozUYbGRdGja5I+k
         ECs0vmWCwCOeUoBmCn6nzv/BTVP9i/DUSEipFPWr5evbDAAU/Ufq3KbV4KL9BYN3JNVt
         HKP9AiNXVy6T6ZkZHfOzdb21eLgnoKhapLSbT1aSwTaqnF6r7U66JJXwZo4Sk2Y+CrtO
         RrHjDyN4gVoLvoxdhmljQpQ4oPwsb9gepTuvrsB435dG/GFdsgD5EQE6BgKwHX8n9Tyb
         HzYQ==
X-Gm-Message-State: AOJu0Yy3NqAILM7ID/LC6xQ3N4chK4Q/O8zNCyOu8mB9x6SjQT6cHp3x
	Qncv6OYSkWirTB1Y4AufaIuUIcAbtYLp3v/gWM6M+A5YWUerJzml
X-Gm-Gg: ASbGncvUCemVekzwG25Z2WCFWC1uNF187/5F1JHhWsbQ8pjvZnnkM+V7Jf3FQ/1r9My
	QMFiVxZxJo6D/Fq1aTagJtptdyxjwoJbBHUH2HbZw5Lpr0mRBXNCW/vgj35judQkHcfeIpiEJCS
	P7ChbtecDREayL4RY6o3JI3mNnHoOlut6/24VgzfYFUAsSyn1uDKhxtHtNAUBaAzjOrXdY6pBcg
	iQf1rgK6LDValH5YmGh2wzTeF6BQDomi0Tj4LfApJJy
X-Google-Smtp-Source: AGHT+IEq5zg3/1bvKRX35wdkWO5mnXbaGZ78GkLs6S1RwcobnXzhYV8MRVEh3TwjPuFkTzNPEnipFA==
X-Received: by 2002:a05:6000:4b15:b0:385:ed78:e17d with SMTP id ffacd0b85a97d-3886c7243f2mr4605191f8f.0.1734364190548;
        Mon, 16 Dec 2024 07:49:50 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80605d9sm8450970f8f.95.2024.12.16.07.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 07:49:49 -0800 (PST)
Date: Mon, 16 Dec 2024 17:49:47 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Oleksij Rempel <linux@rempel-privat.de>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, nbd@nbd.name, sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com, lorenzo.bianconi83@gmail.com
Subject: Re: [RFC net-next 0/5] Add ETS and TBF Qdisc offload for Airoha
 EN7581 SoC
Message-ID: <20241216154947.fms254oqcjj72jmx@skbuf>
References: <cover.1733930558.git.lorenzo@kernel.org>
 <20241211154109.dvkihluzdouhtamr@skbuf>
 <Z1qqrVWV84DBZuCn@lore-desk>
 <20241212150613.zhi3vbxuwsc3blui@skbuf>
 <Z1sXTPeekJ5See_u@lore-desk>
 <20241212184647.t5n7t2yynh6ro2mz@skbuf>
 <Z2AYXRy-LjohbxfL@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2AYXRy-LjohbxfL@lore-desk>

On Mon, Dec 16, 2024 at 01:09:01PM +0100, Lorenzo Bianconi wrote:
> I guess what I did not make clear here is that we are discussing about
> 'routed' traffic (sorry for that). The traffic is received from the WAN
> interface and routed to a DSA port (or the other way around).
> In this scenario the 3-way handshake will be received by the CPU via the
> WAN port (or the conduit port) while the subsequent packets will be hw
> forwarded from WAN to LAN (or LAN to WAN). For EN7581 [0], the traffic
> will be received by the system from GDM2 (WAN) and the PSE/PPE blocks
> will forward it to the GDM1 port that is connected to the DSA cpu port.
> 
> The proposed series is about adding the control path to apply a given Qdisc
> (ETS or TBF for EN7581) to the traffic that is following the described path
> without creating it directly on the DSA switch port (for the reasons described
> before). E.g. the user would want to apply an ETS Qdisc just for traffic
> egressing via lan0.
> 
> This series is not strictly related to the airoha_eth flowtable offload
> implementation but the latter is required to have a full pictures of the
> possible use case (this is why I was saying it is better to post it first).

It's good to know this does not depend on flowtable.

When you add an offloaded Qdisc to the egress of a net device, you don't
affect just the traffic L3 routed to that device, but all traffic (also
includes the packets sent to it using L2 forwarding). As such, I simply
don't believe that the way in which the UAPI is interpreted here (root
egress qdisc matches only routed traffic) is proper.

Ack?

> > I'm trying to look at the big picture and abstract away the flowtable a
> > bit. I don't think the tc rule should be on the user port. Can the
> > redirection of packets destined towards a particular switch port be
> > accomplished with a tc u32 filter on the conduit interface instead?
> > If the tc primitives for either the filter or the action don't exist,
> > maybe those could be added instead? Like DSA keys in "flower" which gain
> > introspection into the encapsulated packet headers?
> 
> The issue with the current DSA infrastructure is there is no way to use
> the conduit port to offload a Qdisc policy to a given lan port since we
> are missing in the APIs the information about what user port we are
> interested in (this is why I added the new netdev callback).

How does the introduction of ndo_setup_tc_conduit() help, since the problem
is elsewhere? You are not making "tc qdisc add lanN root ets" work correctly.
It is simply not comparable to the way in which it is offloaded by
drivers/net/dsa/microchip/ksz_common.c, even though the user space
syntax is the same. Unless you're suggesting that for ksz it is not
offloaded correctly?

Oleksij, am I missing something?

> Please consider here we are discussing about Qdisc policies and not flower
> rules to mangle the traffic.

What's a Qdisc policy?

Also, flower is a classifier, not an action. It doesn't mangle packets
by the very definition of what a classifier is.

> The hw needs to be configured in advance to apply the requested policy
> (e.g TBF for traffic shaping).

What are you missing exactly to make DSA packets go to a particular
channel on the conduit?

For Qdisc offloading you want to configure the NIC in advance, of course.

Can't you do something like this to guide packets to the correct channels?

tc qdisc add dev eth0 clsact
tc qdisc add dev eth0 root handle 1: ets strict 8 priomap ...
tc filter add dev eth0 egress ${u32 or flower filter to match on DSA tagged packets} \
	flowid 1:1

