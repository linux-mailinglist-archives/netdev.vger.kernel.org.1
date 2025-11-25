Return-Path: <netdev+bounces-241584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CFBC8626B
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 18:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A133B60BE
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803F02264CD;
	Tue, 25 Nov 2025 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="LwKuqZNZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668A0329383
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764090289; cv=none; b=DsAzqQuLyE7ueeVrutBtwQyGkdXKeU/KgfpTyMqkkNrBbjUGyudsXxuagWga2xK0oYb4SyMsbyE27UQuATOK8H3uZRl17xEdfZKxLidC3bBMc6OByskVNA3y5EL3Y/iVCooKVHlMH8eq+57iRgk6+tmXgR/atQ7GEnxA503g56k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764090289; c=relaxed/simple;
	bh=XXONSCwRsDMyg+20Vsv6cP1l8q0nebGsPyrrHf37CyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V3QwAig1bbh09aw8cfepiq9qXQboy+2bWYkv76cLGZToB2UfGu+JAbJSrdMTjYMP5wMBYaeJ+9iFXe404NT75YK1kgbntDksxp8owdRoHPaoh5NBLoTp7hlJwKmKvvmBM+eGoLk0gH1E3Oi+QbCzu7OBowXnL3mtxyZK+H5qnjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=LwKuqZNZ; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1764090278;
	bh=XXONSCwRsDMyg+20Vsv6cP1l8q0nebGsPyrrHf37CyY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LwKuqZNZk8ez//wQhXPM8JT+Z7A5QY9DzvSS3DRullfr4zKq7Zl0Nko5PNfykLHFT
	 Fqgh1IhdpUh4LYxHsM7JI3R2hYCC+TS+EpkRbYkdbnokIGrQxy5YZM09UKtKwCWEDq
	 EI0LjEcDo+7q2+IA5ZC7IsWznVIEwvsvXrCT5TR7Cb8DmtxJdjhijzqklZ3Uib5CwR
	 Z8Jh+UOvoYk3t4b2hZ5bgU+CKQ9yfamvOX4zIMxUZ8mYo8V+FA4TGrC/nj49PuNN+S
	 9hYvjL1j5Yc5ImnrXSgF+R/xm0CYmrBo/u5Q3Pn3MH8nD8aHLNHeUcJETydU7RBORs
	 nDAVjxNE2u+pA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id A3672600FF;
	Tue, 25 Nov 2025 17:04:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 98CE12012E7;
	Tue, 25 Nov 2025 17:03:13 +0000 (UTC)
Message-ID: <8564b02f-18f9-4132-ab69-5ee1babeb18c@fiberby.net>
Date: Tue, 25 Nov 2025 17:03:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] netlink: specs: add big-endian byte-order for
 u32 IPv4 addresses
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, "Matthieu Baerts (NGI0)"
 <matttbe@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Yuyang Huang <yuyanghuang@google.com>, Daniel Borkmann <daniel@iogearbox.net>
References: <20251125112048.37631-1-liuhangbin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20251125112048.37631-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/25/25 11:20 AM, Hangbin Liu wrote:
> The fix commit converted several IPv4 address attributes from binary
> to u32, but forgot to specify byte-order: big-endian. Without this,
> YNL tools display IPv4 addresses incorrectly due to host-endian
> interpretation.
> 
> Add the missing byte-order: big-endian to all affected u32 IPv4
> address fields to ensure correct parsing and display.
> 
> Fixes: 1064d521d177 ("netlink: specs: support ipv4-or-v6 for dual-stack fields")
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

LGTM

Reviewed-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

I also checked how consistently defined the fields using the ipv6 display helper are,
and it looks like they could use some realignment too. Obviously not for this fix.

git grep -C6 'display-hint.*ipv6$' Documentation/netlink/specs/

