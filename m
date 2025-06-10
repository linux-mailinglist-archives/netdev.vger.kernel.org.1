Return-Path: <netdev+bounces-196064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC91AD3600
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CFF91605A3
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 12:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85621290BAD;
	Tue, 10 Jun 2025 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="IDYcT1dy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366E3222598
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558117; cv=none; b=Bc/TnlJAmKEMWF7hpDFmQNefAcQiKsdV2ThxyJdrWU3490V8cKYWwqidJn2kvHMQ6wxOXZMiXK8pMJM8/OL3ogGKx1N7SBsCJeNd//SR9XXpZzFvTTx0/FSOH6w8tlrYQbT/2oYeBDxzTggMVlAe/TnffiNPMcrHv73llQSTBYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558117; c=relaxed/simple;
	bh=pGkjcw6YDzKi2PtQFF1DybqZsg9nWYh5T4MBtqVpx5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o5nInGCG8uRK7XCuWLIwcstibascAID8lyY8ZCqVYLgGKTpnv3DwLUXvSRHP53Wlr2GgcUMF20uC4LVG/hXAck15f37hEwz8Zd/c1V5pfPi7IMDUwruLLBxhJifjIqfhK1iHx7AJhGmLUaykHCh03vGVLN6mBeo5G+IXsosxHQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=IDYcT1dy; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32b019bdeaaso17219741fa.0
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 05:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749558113; x=1750162913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wkr8NlzrT7q+6KLISKYLjBRPxrJzkpjNvX6605AbOkg=;
        b=IDYcT1dyDQvUGDQsVP/HXo9/6L7LQ00QEH95reH8MAbwWIqH8JBVXaRQrQ8il4ElY5
         yxgmQbwUfQvyCeTUIl1uTCkiDGsvLNq71Y5fv22hVxOXCC9Im8ZNHtLQLQP0dHhw3Msc
         yJKy5yC+R3jPBXKZ89FjEMle0OGOwOfzTK6KLiNRBCMCcedNnAzphzKygj+21M8FTgkY
         M+nn7uJTUpKR/75/jbJtVTbyf3OaaUBA0EXRzs3WG347Agt6R7U7qW87wZOLYOZieqYm
         TXTR1zpElQRsvE0yklzcmQFKK0UW5FCYINeoG1dcXx5H9bxMel1UmWGtYhxo2mpJ8ZUz
         VJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749558113; x=1750162913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wkr8NlzrT7q+6KLISKYLjBRPxrJzkpjNvX6605AbOkg=;
        b=juq0Yogd+L+y023TcyBO7XuAZe3ZQzUS9Mq3DN8l/2MaoeKH3iF7jAdBXgvqgxPODY
         0UcwCjFfm+rhboY5yOH1Cmbl2Ox4M+vdmK9Z4woOvVSdSYViI/0b1gyil5rvq0lcoCBw
         WEFN2wEz3/2zjU3TP1T2ZWtJ1Ar3jPfv08rRvmWh1gtse6WOyjzxVjnlRDjVV7ebKHJ8
         Onj7FeO+jjXE7l1fr6fJowpCHBbyrKR7sQBONbKtWLVgxg8eScZuveOmGYyrs9egtlLP
         +VQjcUQBX2zjpVCJvIktCWEOWiYD/1Yo2fko9yfw1Tl+w8dc4+2FyIedyKZcdDGv15PK
         nBzA==
X-Forwarded-Encrypted: i=1; AJvYcCXRAMsGG3vX9M78/4FUAqiCLNE/AUdsVH0KkXcvKkRz+m0EGldm2cNlR9U79NFUfFz3v0F5GPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLRwlS5V9312F74a5hVv+STr6ExjK7tqFOJ2P3EGnO2qoYh0x8
	EidaQdwcrJO+0mqCrMqJ7PfLVfRTFzGbQAZY+jSzB6xZ5qiQjD8DZhMu/8lfYpUgaHo=
X-Gm-Gg: ASbGnctZ/RSGDHBS+Yl6FmO2MOXf8lUtcheljFZAq8fYIdFO5YxCJGrIP22aDGA+u3H
	U9fQg6+Hd5tzlMMqYIaPEHEuGGsf+ACxsLhYAZpWI80kf49aPeOxbF1i4fJVn6ixjO9ydgTRqFO
	VFVUXquW66saPnWDBb/KFJq7LRZDcZkQusOPhjBd6O4eVr0aym8xUIYLZlWGGVe46+pCYeMdub/
	DZMkHFxbcbAe1vqNR3l5pb+wZc57furAKXu+pVZ+MBv9qcCWv7qSxY6YQiFY60fVmavo5PktK0V
	xO4UDUXWNAGJFMtaps3hAsmPyAZuPFjbk0+3M5qG/CAU2Hjpf/RNo+WRecW7e5QW4Cl7iw2Y5i/
	Hvfjo/eG64YRNZbbkB+1MY/U0Q1f5M+8=
X-Google-Smtp-Source: AGHT+IEgwRAVIyE6nLzZ0225oh2wo8Bpgx3Maq6YW9HopN0ZkGH0l2d9dudPlx3GX8xSOSGIfI4g+g==
X-Received: by 2002:a2e:be9c:0:b0:32a:6502:df45 with SMTP id 38308e7fff4ca-32adfe900c4mr41634491fa.40.1749558113312;
        Tue, 10 Jun 2025 05:21:53 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32ae1ccfc48sm14389601fa.95.2025.06.10.05.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 05:21:52 -0700 (PDT)
Message-ID: <23d87175-9212-49f6-b4fd-2d5ba251c085@blackwall.org>
Date: Tue, 10 Jun 2025 15:21:51 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2 4/4] ip: iplink_bridge: Support bridge
 VLAN stats in `ip stats'
To: Petr Machata <petrm@nvidia.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org
References: <cover.1749484902.git.petrm@nvidia.com>
 <c0d97a28464afeb3c123f73b656e5e5532893726.1749484902.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <c0d97a28464afeb3c123f73b656e5e5532893726.1749484902.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 19:05, Petr Machata wrote:
> Add support for displaying bridge VLAN statistics in `ip stats'.
> Reuse the existing `bridge vlan' display and JSON format:
> 
>   # ip stats show dev v2 group xstats_slave subgroup bridge suite vlan
>   2: v2: group xstats_slave subgroup bridge suite vlan
>                     10
>                       RX: 3376 bytes 50 packets
>                       TX: 2824 bytes 44 packets
> 
>                     20
>                       RX: 684 bytes 7 packets
>                       TX: 0 bytes 0 packets
> 
>   # ip -j -p stats show dev v2 group xstats_slave subgroup bridge suite vlan
>   [ {
>           "ifindex": 2,
>           "ifname": "v2",
>           "group": "xstats_slave",
>           "subgroup": "bridge",
>           "suite": "vlan",
>           "vlans": [ {
>                   "vid": 10,
>                   "rx_bytes": 3376,
>                   "rx_packets": 50,
>                   "tx_bytes": 2824,
>                   "tx_packets": 44
>               },{
>                   "vid": 20,
>                   "rx_bytes": 684,
>                   "rx_packets": 7,
>                   "tx_bytes": 0,
>                   "tx_packets": 0
>               } ]
>       } ]
> 
> Similarly for the master stats:
> 
>   # ip stats show dev br1 group xstats subgroup bridge suite vlan
>   211: br1: group xstats subgroup bridge suite vlan
>                     10
>                       RX: 3376 bytes 50 packets
>                       TX: 2824 bytes 44 packets
> 
>                     20
>                       RX: 684 bytes 7 packets
>                       TX: 0 bytes 0 packets
> 
>   # ip -j -p stats show dev br1 group xstats subgroup bridge suite vlan
>   [ {
>           "ifindex": 211,
>           "ifname": "br1",
>           "group": "xstats",
>           "subgroup": "bridge",
>           "suite": "vlan",
>           "vlans": [ {
>                   "vid": 10,
>                   "flags": [ ],
>                   "rx_bytes": 3376,
>                   "rx_packets": 50,
>                   "tx_bytes": 2824,
>                   "tx_packets": 44
>               },{
>                   "vid": 20,
>                   "flags": [ ],
>                   "rx_bytes": 684,
>                   "rx_packets": 7,
>                   "tx_bytes": 0,
>                   "tx_packets": 0
>               } ]
>       } ]
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
> 
> Notes:
>      v2:
>      - Add the master stats as well.
> 
>   ip/iplink_bridge.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


