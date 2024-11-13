Return-Path: <netdev+bounces-144262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AACA9C6686
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 02:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3516CB25217
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 01:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FD718654;
	Wed, 13 Nov 2024 01:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bCRA45K0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF81DF71
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 01:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731460672; cv=none; b=HT2fZK0zZsuMObYaz5uiGTHfHngVj87vTz/iNyjc+6pwqAqnDW/Egt6nWkElckmeVGt1qpnBHt1ERJDU6/0Z5aesb90spK7j/Kcxm2yVJ0FrfI+Ma7ZGvl6dPptSiujJdWahHSPDn2J/mjv4krQbg4dTSUUVpAoRae7wqV5UyZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731460672; c=relaxed/simple;
	bh=bxYMDy3LNcoEgP7wMuscDEOWLGw2181SZWUMqE5lwLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrLldjhIsQo+T7KIU0Kd22A4zGCKsERomqGCA02JMIq01f89aeLPs11AZY4o4sMw6SZo1cFzzodyTzAABjOwayWROlJ2yBvSQktiYj64hHmu8hp/YY314YHlNAfr02B1W3vUlv6aMdkO+JiuTl1JYLzN0OoOhU1Lhfu2muqYnfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bCRA45K0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=S8n/sSJ9WOH/y4a58VO7Z3Ycp4yfhQBQCL7yATGGx5k=; b=bCRA45K0WOt2WlveI7Ss9v/A04
	WEJNIOkcAF+2nvO7mpNFC2jaLwMcG9ECvwm9OVPqh54vVcg+UqLMpJF+5sfGde4tZK3PxPDqvpQUf
	BGODEPo5fV2puC6cnuM+jR2TslmYPnTkzAi+f9txkj2/Dlm9Bt3Buta4E+x21g2tV8nQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tB20j-00D6ux-LI; Wed, 13 Nov 2024 02:17:33 +0100
Date: Wed, 13 Nov 2024 02:17:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	roopa@cumulusnetworks.com, jiri@resnulli.us,
	stephen@networkplumber.org, netdev@vger.kernel.org,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Lorenzo Colitti <lorenzo@google.com>
Subject: Re: [PATCH net-next] netlink: add igmp join/leave notifications
Message-ID: <ce2359c3-a6eb-4ef3-b2cf-321c5c282fab@lunn.ch>
References: <20241110081953.121682-1-yuyanghuang@google.com>
 <ZzMlvCA4e3YhYTPn@fedora>
 <b47b1895-76b9-42bc-af29-e54a20d71a52@lunn.ch>
 <CADXeF1HMvDnKNSNCh1ULsspC+gR+S0eTE40MRhA+OH16zJKM6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADXeF1HMvDnKNSNCh1ULsspC+gR+S0eTE40MRhA+OH16zJKM6A@mail.gmail.com>

On Wed, Nov 13, 2024 at 09:56:17AM +0900, Yuyang Huang wrote:
> > Please could you say more about programming hardware offload filters?
> > How is this done?
> 
> Sure,  please let me explain a little bit further on how Android
> Packet Filter (APF) works here.
> 
> The Android Packet Filter (APF) has two parts:
> * APF Interpreter: Runs on the Wi-Fi chipset and executes APF
> programs(bytecodes) to decide whether to accept, drop, or reply to
> incoming packets.

O.K. WiFi is not my area. But i'm more interested in uAPIs, and
ensuring you are not adding APIs which promote kernel bypass.

Is the API to pass this bytestream to the wifi chipset in mainline?
And how does APF differ from BPF? Or P4? Why would we want APF when
mainline has BPF?

Do the new netlink message make sense without APF? Can i write a user
space IGMP snooping implementation and then call bridge mdb
add/del/replace? Assuming i can, why are the WiFi card not using that
API, same a switches do?

	Andrew

