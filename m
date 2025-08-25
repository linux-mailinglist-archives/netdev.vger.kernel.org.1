Return-Path: <netdev+bounces-216538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C300B34654
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 17:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614361B20048
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 15:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94782FC008;
	Mon, 25 Aug 2025 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uA01IO9j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B0F2F2914
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 15:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137158; cv=none; b=lpwIBakijdlHfBcSuY+o+TRjrvco+PRQfr6S46SolD+XeGNvqsPM759qOUEzDQuskCGXXK0CQ8rEV7ndq7DE2pTZGsd5Wfhdf3+UYd0dqRcuc4KyJ6ksm5NTW0avd2rf8gg8+cdFWs1/Y3TohxLoYMDbrtWdp6oUf5de/bpOnzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137158; c=relaxed/simple;
	bh=wsKg6l7r/J2zcxiFpiwwm7FGgHwj9OfMddAVZD3IKZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kov4Yy9TnXagFw1fpdE3eGhQn9sFalWPFXTQZx/IfbZp8fqNNKuzQj7orDKUshOr1BOPTo77zrZtSbLMt7CRj5fqhoLWWZs8gZD6RMvpWMZrp/bro1/9ya0bIE2b22797F8/573uAQMDdnZ5hD/xVsS/jkySLGdUxAZ46iAcbYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uA01IO9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF125C4CEED;
	Mon, 25 Aug 2025 15:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756137156;
	bh=wsKg6l7r/J2zcxiFpiwwm7FGgHwj9OfMddAVZD3IKZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uA01IO9jFY1DCl9M0rzZuPWPkxWCeZBrjRJCR0haBFf6Nii6gwy+FLyP64UyduUse
	 Z0fuPhqdYB+I5NwgLM7l8/HfXkYZ89I8C8rirXqtSkdRglTFdTywsZgT8tvQpqzXDS
	 UTWtocOfhykAbSm+QhibjQhPnQzuId6q2gsAT+B3bSflLrNqH4FjCJCh2QNof6kMsq
	 ILv2OWjp3MHitek6LD5eoLkP6kqqUcD+toPwtyX1apCTni40bWadLNzmHv2d9wOwen
	 DJATVw1RmSdpMz/x+FttGDJ6JWyZiM3HpIWvbr7Y4Jm+1sT+i3C+zvUrfj+nO8kObh
	 juW5ag17jP5Zg==
Date: Mon, 25 Aug 2025 08:52:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dsahern@gmail.com,
 netdev@vger.kernel.org, haiyangz@microsoft.com,
 shradhagupta@linux.microsoft.com, ssengar@microsoft.com,
 dipayanroy@microsoft.com, ernis@microsoft.com
Subject: Re: [PATCH iproute2-next v3] iproute2: Add 'netshaper' command to
 'ip link' for netdev shaping
Message-ID: <20250825085235.47b430ed@kernel.org>
In-Reply-To: <20250824134017.GA2917@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1754895902-8790-1-git-send-email-ernis@linux.microsoft.com>
	<20250816155510.03a99223@hermes.local>
	<20250818083612.68a3c137@kernel.org>
	<20250821110607.GC7364@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
	<20250821071259.07059b0f@kernel.org>
	<20250824134017.GA2917@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 Aug 2025 06:40:17 -0700 Erni Sri Satya Vennela wrote:
> > Sorry, I wasn't very precise, it supports printing the string messages.
> > But nothing that requires actually understanding the message.
> > No bad attribute errors, no missing attribute errors, no policy errors.  
> 
> Are you referring to the following error logs from the ynl tool?
> 
> $./tools/net/ynl/pyynl/cli.py
>  --spec Documentation/netlink/specs/net_shaper.yaml
>  --do set 
>  --json '{"ifindex":'3',
> 	  "handle":{"scope": "netdev", "id":'1' },
> 	  "bw-max": 200001000 }'
> 
> Netlink error: Invalid argument
> nl_len = 92 (76) nl_flags = 0x300 nl_type = 2
>         error: -22
>         extack: {'msg': 'mana: Please use multiples of 100Mbps for
> bandwidth'}

Not 'msg', the other types, for example miss-type, bad-attr:

$ ynl --family net_shaper --do get
Netlink error: Invalid argument
nl_len = 44 (28) nl_flags = 0x300 nl_type = 2
	error: -22
	extack: {'miss-type': 'ifindex', 'miss-type-doc': 'Interface index owning the specified shaper.'}

$ ynl --family net_shaper --do get --json '{"ifindex": 1}'
Netlink error: Operation not supported
nl_len = 44 (28) nl_flags = 0x300 nl_type = 2
	error: -95
	extack: {'bad-attr': '.ifindex'}

> If yes, would it be reasonable to add support in iproute2 itself for
> displaying such error logs?

