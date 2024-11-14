Return-Path: <netdev+bounces-144909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F599C8C04
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 14:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69839B23B2E
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 13:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957381FAC5B;
	Thu, 14 Nov 2024 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XPU5w5YK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE58370
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731590768; cv=none; b=OSddl+jqTkgzFifknIUzODzu9BCH5J1uN3JYyXurHi1oiyqYrrQwYtmYIW+86iin0iXTGMlYe1dCCKVxv/GzTdqCUbaElRg2zMLcUvFQxjQl/orqeYsgXUvAETOXUyQIPdWUouBCpPuD9ygnkYR3y9E96AdCsTS8pckiRgfmv70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731590768; c=relaxed/simple;
	bh=jkDAWM89mPqBmTZe3eQySCaLW/Q34dQucmKF3xjDK68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+fWyPP7bko7fyQe3pVYUqRQ0HLAEPAPSjDtzusA3pPV6+QDH+STm7f1htP12IL3EMjPnYBDKnq1CzIbwnE0ZZmR7Apb4+y4n4+oFhyf8tmWqBT5Yj+vC91BdJ8UxXnjCdKyJx0QP2/uC6sU6lH/NadCFZxI6dNYfjcsRiQAk2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XPU5w5YK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NnjgbC+SAo/1WkaYK4SUPNhGBotAleahfKIS9KHnshs=; b=XPU5w5YKUgXdIEHf5tF5nT4CKT
	IBZAQnDeZOLRfKerjD8d7Ea5qkK1saJgPWy0fKwyeRPUlS2qQCEkTqYIef/b+ArgGiXOqhS/xykMi
	FX2IyikZVC8YDux5BS0l/IVhrdr/Y64dXwFtVSPpr6+kSqUqTq9SaIVDWRO4H4qjXJ6M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tBZr6-00DIZX-8o; Thu, 14 Nov 2024 14:25:52 +0100
Date: Thu, 14 Nov 2024 14:25:52 +0100
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
Message-ID: <dd54d1ac-cc53-43cb-a42e-d255ac688e6f@lunn.ch>
References: <20241110081953.121682-1-yuyanghuang@google.com>
 <ZzMlvCA4e3YhYTPn@fedora>
 <b47b1895-76b9-42bc-af29-e54a20d71a52@lunn.ch>
 <CADXeF1HMvDnKNSNCh1ULsspC+gR+S0eTE40MRhA+OH16zJKM6A@mail.gmail.com>
 <ce2359c3-a6eb-4ef3-b2cf-321c5c282fab@lunn.ch>
 <CADXeF1FYoXTixLFFhESDkCo2HXG3JAzzdMCfkFrr2dqmRVQcWg@mail.gmail.com>
 <9fa93b71-cd81-44ce-b7cc-24b12be8cb24@lunn.ch>
 <CADXeF1HQH=bhNWAtafUKD3-WoHhQEB-=TpwN9GdOOZ9PSaLktQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADXeF1HQH=bhNWAtafUKD3-WoHhQEB-=TpwN9GdOOZ9PSaLktQ@mail.gmail.com>

> This change also empowers user space applications to manage multicast
> filters and IGMP/MLD offload rules using the same netlink notification
> mechanism. This allows applications to dynamically adjust rules and
> configurations via generic netlink communication with the Wi-Fi driver,
> offering greater flexibility and updatability compared to implementing
> all logic within the driver itself. This is a key consideration for some
> commercial devices.

You are still focused or your narrow use case. Why is this only for
WiFi? Why cannot i use it for other systems using IGMP? Switches? VPN
servers? etc. We want a generic solution for all use cases, not just
some obscure niche.

And Linux does not care about commercial devices. And you would never
implement this in the driver itself, that would immediately gets
NACKed because it is not generic, but the concept should be generic.

	Andrew

