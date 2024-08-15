Return-Path: <netdev+bounces-118907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FAF953781
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159461F26424
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922BD19EEA4;
	Thu, 15 Aug 2024 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eo3GSAFI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA6815E88
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723736728; cv=none; b=GDcknIRrKVYbizIgInq3lVQMt73PazbbjbA53I1maIx2WN7uaG1NSwUmhiKsNm5XUdiVXUnNxu1ItmCGbC/R/gJ1LrYhVxVW2KaV6sAHBfvzTJesWqIJGxRa6tS/VkIQsYHgjR3lAnMzQ0kjnrqgTB/bMufJ6KTAXV9BPLe90+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723736728; c=relaxed/simple;
	bh=X6sdnle8aeNv10F0wORlnTFKiHft4wwpxnzZ9jR6saQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YOtteLr3rv/D9xqrM38vwXO6y8hxSjrVmzhkTtBJqY9Dwy4cMiYJ7miS8CFdpJw51CrXNP1hf7def3Z43JgnC8+29lgiKz87A5omTqJciJfxQKlSe+PCNRyVP/Yduz6QlG1kIk9wAZincTSV8N9U5+Nm2g4A++88xOnDkV1P7Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eo3GSAFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597DFC32786;
	Thu, 15 Aug 2024 15:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723736728;
	bh=X6sdnle8aeNv10F0wORlnTFKiHft4wwpxnzZ9jR6saQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eo3GSAFIJUHKbyyVPP72O+w0bwWZk+hp3WoXd7Oq2NRSR8slfnbdo0Pm5Sf3EPa2M
	 Ss72ZChcOjg3GPXo8xzdVlCUVvX8fSQTokUkjwFePasnjkPuhN1E6neBMb0nejABND
	 Rw5aHMTponMjTED2hHitc6U1Yf15Qp1+Y+gZljpG0if3meeHR7yeNU3JWpt1ZqDYPb
	 rLuA7ZhIpne5c/P4PtlGH9OY+M8gziQhyhNCAxLPNeJu3CWxbQ4Rhp3t17szvOFyHo
	 HHbxFDYKCevXvpiXXwmNfwsn05MrAxoN9PHwVpgb7R1bBbtVR/cjzcppJG+5B2xOTi
	 LI9sR2MwA1KLg==
Date: Thu, 15 Aug 2024 08:45:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?= <maze@google.com>, Doug Berger
 <opendmb@gmail.com>, Justin Chen <justin.chen@broadcom.com>, Maciej
 =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?= <zenczykowski@gmail.com>, Linux Network
 Development Mailing List <netdev@vger.kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, "Kory Maincent (Dent Project)"
 <kory.maincent@bootlin.com>, Ahmed Zaki <ahmed.zaki@intel.com>, Edward Cree
 <ecree.xilinx@gmail.com>, Yuyang Huang <yuyanghuang@google.com>, Lorenzo
 Colitti <lorenzo@google.com>
Subject: Re: [PATCH net-next] ethtool: add tunable api to disable various
 firmware offloads
Message-ID: <20240815084526.5b1975c3@kernel.org>
In-Reply-To: <b46f8151-29ab-453c-9830-884adcecdcfb@gmail.com>
References: <20240813223325.3522113-1-maze@google.com>
	<20240814173248.685681d7@kernel.org>
	<b46f8151-29ab-453c-9830-884adcecdcfb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 20:08:05 -0700 Florian Fainelli wrote:
> > You gotta find an upstream driver which implements this for us to merge.
> > If Florian doesn't have any quick uses -- I think Intel ethernet drivers
> > have private flags for enabling/disabling an LLDP agent. That could be
> > another way..  
> 
> Currently we have both bcmgenet and bcmasp support the WAKE_FILTER 
> Wake-on-LAN specifier. Our configuration is typically done in user-space 
> for mDNS with something like:
> 
> ethtool -N eth0 flow-type ether dst 33:33:00:00:00:fb action 
> 0xfffffffffffffffe user-def 0x320000 m 0xffffffffff000fff
> ethtool -N eth0 flow-type ether dst 01:00:5e:00:00:fb action 
> 0xfffffffffffffffe user-def 0x1e0000 m 0xffffffffff000fff
> ethtool -s eth0 wol f
> 
> I would offer that we wire up the tunable into bcmgenet and bcmasp and 
> we'd make sure on our side that the respective firmware implementations 
> behave accordingly, but the respective firmware implementations 
> currently look at whether any network filter have been programmed into 
> the hardware, and if so, they are using those for offload. So we do not 
> really need the tunable in a way, but if we were to add it, then we 
> would need to find a way to tell the firmware not to use the network 
> filters. We liked our design because there is no kernel <=> firmware 
> communication.

Hm, I may be lacking the practical exposure to such systems to say
anything sensible, but when has that ever stopped me..
IIUC you're saying that FW enables MLD offload if the wake filter is 
in place. But for ping/arp/igmp offload there's no need to wake, ever,
so there wouldn't be a filter?

