Return-Path: <netdev+bounces-158280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6742A114F3
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1239C169989
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F042253FD;
	Tue, 14 Jan 2025 23:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OnM2tI2m"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC822206B7
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895870; cv=none; b=uOJCk74pNkrRW5xunjqzNGDE72x9Zb2xAza1gfMOAyQKJg6umlVETdv1MF4Q1/dseCRA7J3sjpxa7PaCx8mhzO9VvgVeTP253Xor9vhKoB1JYpjjqcGqe+GSDXlzNR95BQYpEDik80P3MwSSJ0HfgMAZgLZv8Dm3///43nuh1wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895870; c=relaxed/simple;
	bh=KzrqJdF2SkvAH4+ESlQ7r45qSC1G4Ej/JrD4b3i+SxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+tgAmncAqaTgGIzMVJIOrIaiZuqpNUvbv08w1otgEHtXKTHD3mQrryraLfTMP1PLDH9IUMpGTNFfCNDTztQj1aW4sobJOmvVNlJmdLuSP6853c0D3EpfMhwzGJPSwPSZoxn5Qk/N75Rz4INvyC0n5ZAXdA8LQczI8dUfOSx2Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OnM2tI2m; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fb1b4bc3-b6be-42d6-b664-015c0261dec0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736895863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pTT2NC40GaIKCvQxaHWcK6v2+HwRHqXxU2TA4mnTu/k=;
	b=OnM2tI2medeWUUlXg36baHAjXBMGMEJ6HRlV61VX4F/bpXKmLj0wpAzfOu8g4PQoUhnB9R
	Fak1Y6FvtOz12dHJN+iTyyFnP8YlupVcdW4CO0B/68o0z/fWu8QS3zGLhg1taJWmz4csmc
	ATf1JdZeSKnMR9IA5V0VYObLpspUao4=
Date: Tue, 14 Jan 2025 15:04:19 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 net-next 3/5] net: no longer hold RTNL while calling
 flush_all_backlogs()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 eric.dumazet@gmail.com
References: <20250114205531.967841-1-edumazet@google.com>
 <20250114205531.967841-4-edumazet@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jesse Brandeburg <jesse.brandeburg@linux.dev>
In-Reply-To: <20250114205531.967841-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/14/25 12:55 PM, Eric Dumazet wrote:
> flush_all_backlogs() is called from unregister_netdevice_many_notify()
> as part of netdevice dismantles.
> 
> This is currently called under RTNL, and can last up to 50 ms
> on busy hosts.
> 
> There is no reason to hold RTNL at this stage, if our caller
> is cleanup_net() : netns are no more visible, devices
> are in NETREG_UNREGISTERING state and no other thread
> could mess our state while RTNL is temporarily released.
> 
> In order to provide isolation, this patch provides a separate
> 'net_todo_list' for cleanup_net().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>


