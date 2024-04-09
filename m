Return-Path: <netdev+bounces-86316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14A989E614
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 01:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE82283B7E
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0342158DBD;
	Tue,  9 Apr 2024 23:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ydmw07Ah"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895C2156F4E
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 23:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712705478; cv=none; b=ZYCBDO3B4Usn4aDpl+IHSAc4R73govzDToRPaL1wfc3L/iiKafKdKLBC81EQ0KdEhDuHMnjQWh3Ex2XCItRzaZsB5PPhUhu2QqEIyVFbiAdDiwHBttY1xZ6uJpRcISoJ1kGHK/eMIPOuipcF8nEg3y9kzCN9XrWpN2tEf0KqXOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712705478; c=relaxed/simple;
	bh=o9L+f1xpCo7HGa4iQmVysPIL8tMgYLomWfPYYRBuA8U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GK1rkkWyapevChQAI49AoEwylhxXEVzYX9WFr3u2c67B3wqcY798XJEO5JxyoDOFG2/WUOWDvZKtUdKFU0Owc854EePJvSzt+NUgaY7HbNJbaOA7Uzj+H7H99LCiEsdrpPMJtKzXCIyLTwQwdNzkfy812j9v0Bv2FH12leYGKoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ydmw07Ah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D912C433F1;
	Tue,  9 Apr 2024 23:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712705478;
	bh=o9L+f1xpCo7HGa4iQmVysPIL8tMgYLomWfPYYRBuA8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ydmw07AhUlG5llXuvw1f33eWxvjqCYR7OtRP5kuVbsCz4tG4re4ePHStNPppamPEv
	 atSviUUF1ksYt9vsRxwmbKxO+hXztoPT2RCbtQn97Ue56kduf0Khb2tMqAT+tG03dv
	 X+4bDao1swNeAkui0FkAWzQ4YoVxiM1DKTekDVTPmfHp6LxtYtsnHmHi2jylq9ZIrz
	 8dLe/vmW9rrTlqcdKWM1owBPstRf4vhvbwDXVPjvjrd5ZfTZ7izIzmqfBV227ncGwR
	 TtdPKgT4ijaiXTBQ1mBKdFa5yg1bIIbJWDJxp9h/NvgXTZN6VCOOj8Ezv0rXbwKMw6
	 UoIQ9USrJDihA==
Date: Tue, 9 Apr 2024 16:31:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Jason Wang
 <jasowang@redhat.com>, yan@daynix.com, andrew@daynix.com,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: change maximum number of UDP segments to 128
Message-ID: <20240409163116.0b1525c5@kernel.org>
In-Reply-To: <20240406185029.93335-1-yuri.benditovich@daynix.com>
References: <20240406185029.93335-1-yuri.benditovich@daynix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

CC: netdev@

On Sat,  6 Apr 2024 21:50:29 +0300 Yuri Benditovich wrote:
> Fixes: fc8b2a619469378 ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation")
> 

Fixes: line goes right above your sign-off, no empty lines in between
them.

> The mentioned above commit adds check of potential number
> of UDP segments vs UDP_MAX_SEGMENTS in linux/virtio_net.h.
> After this change certification test of USO guest-to-guest
> transmit on Windows driver for virtio-net device fails,
> for example with packet size of ~64K and mss of 536 bytes.
> In general the USO should not be more restrictive than TSO.
> Indeed, in case of unreasonably small mss a lot of segments
> can cause queue overflow and packet loss on the destination.
> Limit of 128 segments is good for any practical purpose,
> with minimal meaningful mss of 536 the maximal UDP packet will
> be divided to ~120 segments.
> 
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>

