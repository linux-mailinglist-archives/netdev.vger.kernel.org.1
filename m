Return-Path: <netdev+bounces-176177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 309A1A69423
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 16:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322B53BD636
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 15:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08D5195811;
	Wed, 19 Mar 2025 15:49:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151B81AA1C9;
	Wed, 19 Mar 2025 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742399351; cv=none; b=BqZilodVd4YCq2cUusE1Nnqqkv8YMsZGXcG5GXOs5tFba9b5VF61LYFHTO4uUlZEPaGKD27JTZ8p1USvkIgkpDWgWqmiqKmw8t78r4s296uMbG9Zqw+muwt/ZYhC+MdG7Ab0UO01SyOq0Y1q99XpSbR2XWzEVEuEuq4Xp8xNyYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742399351; c=relaxed/simple;
	bh=CcImMfT7vEa1FvA1efo7PNdGOeWk31nKJQpHEzFDTYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mUWjMqo6Rnbbmrt8gg4MKIU007/fvJfpTjl7jG5V5FVUqllP3XMSG1pCG4jzh2n1m/43h/gtXHTejQn++0WNysCYkIlpf8HxUO3tR5VmHeeK4fwzr4GLxcuCAo4+RqXR7qj0bsl80TJAMyDHH63UdJdm60ePZYLvisfBrqeTpKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.43] (g43.guest.molgen.mpg.de [141.14.220.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1CE1561E647AE;
	Wed, 19 Mar 2025 16:48:27 +0100 (CET)
Message-ID: <6cf69a7e-da5d-49da-ab05-4523f2914254@molgen.mpg.de>
Date: Wed, 19 Mar 2025 16:48:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] net-timestamp: COMPLETION timestamp on packet tx
 completion
To: Pauli Virtanen <pav@iki.fi>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, willemdebruijn.kernel@gmail.com
References: <cover.1742324341.git.pav@iki.fi>
 <0dfb22ec3c9d9ed796ba8edc919a690ca2fb1fdd.1742324341.git.pav@iki.fi>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <0dfb22ec3c9d9ed796ba8edc919a690ca2fb1fdd.1742324341.git.pav@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Pauli,


Thank you for your patch. Two minor comments, should you resend.

You could make the summary/title a statement:

Add COMPLETION timestamp on packet tx completion

Am 18.03.25 um 20:06 schrieb Pauli Virtanen:
> Add SOF_TIMESTAMPING_TX_COMPLETION, for requesting a software timestamp
> when hardware reports a packet completed.
> 
> Completion tstamp is useful for Bluetooth, as hardware timestamps do not
> exist in the HCI specification except for ISO packets, and the hardware
> has a queue where packets may wait.  In this case the software SND
> timestamp only reflects the kernel-side part of the total latency
> (usually small) and queue length (usually 0 unless HW buffers
> congested), whereas the completion report time is more informative of
> the true latency.
> 
> It may also be useful in other cases where HW TX timestamps cannot be
> obtained and user wants to estimate an upper bound to when the TX
> probably happened.
> 
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
> 
> Notes:
>      v5:
>      - back to decoupled COMPLETION & SND, like in v3
>      - BPF reporting not implemented here
> 
>   Documentation/networking/timestamping.rst | 8 ++++++++
>   include/linux/skbuff.h                    | 7 ++++---
>   include/uapi/linux/errqueue.h             | 1 +
>   include/uapi/linux/net_tstamp.h           | 6 ++++--
>   net/core/skbuff.c                         | 2 ++
>   net/ethtool/common.c                      | 1 +
>   net/socket.c                              | 3 +++
>   7 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
> index 61ef9da10e28..b8fef8101176 100644
> --- a/Documentation/networking/timestamping.rst
> +++ b/Documentation/networking/timestamping.rst
> @@ -140,6 +140,14 @@ SOF_TIMESTAMPING_TX_ACK:
>     cumulative acknowledgment. The mechanism ignores SACK and FACK.
>     This flag can be enabled via both socket options and control messages.
>   
> +SOF_TIMESTAMPING_TX_COMPLETION:
> +  Request tx timestamps on packet tx completion.  The completion
> +  timestamp is generated by the kernel when it receives packet a
> +  completion report from the hardware. Hardware may report multiple

… receives packate a completion … sounds strange to me, but I am a 
non-native speaker.

[…]


Kind regards,

Paul

