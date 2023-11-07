Return-Path: <netdev+bounces-46477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B247E4690
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 18:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D69B2810D7
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 17:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64293328D2;
	Tue,  7 Nov 2023 17:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXxdeJq7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46636321B7
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 17:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64BCC433C8;
	Tue,  7 Nov 2023 17:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699377065;
	bh=8Lk7coUZChVrUjWOCb0vKBTKyCO8PapJdoRvSdg/KgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EXxdeJq7J1awfpj9plI4EFeTZ2kKiaSAC7DbIBqJr3pGpAM6Jv2PJ1sC1QvN1Dhiy
	 HX3T0QksrIRTxhQrtfB8whfkevHObygzrfQt4zjVZCvLgfY89A+Rck5rIXs5d+sYXn
	 DCHwQg6bO/ZRVr9l5tnEgwFbwb7K7JEoQbFGrJ8lRyqfwCD8YuRKn5YR2os20xfPb9
	 4jjnU/XCPCBwn+fWZMKqkFPL4DqNMKPiqNSnAxMaAqguZhlEFarNB8BPNt+eq3MWj/
	 VtEdyfbj8oVSVvULNKUwMkBg5IxxQVy0m/FjGWmgiuuAfVUV8C8e4HLbeVLiwndUR7
	 luV+Aa//lb+BQ==
Date: Tue, 7 Nov 2023 12:11:03 -0500
From: Simon Horman <horms@kernel.org>
To: Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc: Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Linux Network Development Mailing List <netdev@vger.kernel.org>,
	Netfilter Development Mailing List <netfilter-devel@vger.kernel.org>,
	Jan Engelhardt <jengelh@inai.de>, Patrick McHardy <kaber@trash.net>
Subject: Re: [PATCH net v2] netfilter: xt_recent: fix (increase) ipv6 literal
 buffer length
Message-ID: <20231107171103.GA316877@kernel.org>
References: <20231105195600.522779-1-maze@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231105195600.522779-1-maze@google.com>

On Sun, Nov 05, 2023 at 11:56:00AM -0800, Maciej Żenczykowski wrote:
> From: Maciej Żenczykowski <zenczykowski@gmail.com>
> 
> in6_pton() supports 'low-32-bit dot-decimal representation'
> (this is useful with DNS64/NAT64 networks for example):
> 
>   # echo +aaaa:bbbb:cccc:dddd:eeee:ffff:1.2.3.4 > /proc/self/net/xt_recent/DEFAULT
>   # cat /proc/self/net/xt_recent/DEFAULT
>   src=aaaa:bbbb:cccc:dddd:eeee:ffff:0102:0304 ttl: 0 last_seen: 9733848829 oldest_pkt: 1 9733848829
> 
> but the provided buffer is too short:
> 
>   # echo +aaaa:bbbb:cccc:dddd:eeee:ffff:255.255.255.255 > /proc/self/net/xt_recent/DEFAULT
>   -bash: echo: write error: Invalid argument
> 
> Cc: Jan Engelhardt <jengelh@inai.de>
> Cc: Patrick McHardy <kaber@trash.net>
> Fixes: 079aa88fe717 ("netfilter: xt_recent: IPv6 support")
> Signed-off-by: Maciej Żenczykowski <zenczykowski@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

