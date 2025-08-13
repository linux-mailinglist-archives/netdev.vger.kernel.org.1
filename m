Return-Path: <netdev+bounces-213258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF90B24414
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EAEF7B8F18
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2BD2D3230;
	Wed, 13 Aug 2025 08:19:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F861A9FB0;
	Wed, 13 Aug 2025 08:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073157; cv=none; b=HPiCttABU39jU+s4Ofw3ea/vx+n7H1Q+3yMyGfqRjGPia7FXnYGXFk+EObSc/DsFZAx7/isvUesLLyUmXs0PUEzvzROVhW1aZMpT2Mi/1G2GrKI09tSy9kN4VyToHNUooHGwUai81vegW4pv1ekSUszgWImM0sBJJvnoh+0O+6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073157; c=relaxed/simple;
	bh=v7rtgWQNu/mbQ/micpT414DkETdzWVBsO6/aw191THE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ag6uWQ5QDOYv3tCApx+wlqsgYxkvSPeDfo6m22YVQ4DOBUeXp0KGokvg/+HdiJXk2jOdUoqwdExaYBu6WUic4ZgUdQSQCQHNrQlipM/vBYMp7HYOijUQrhHNy+8X+SVG65JUQOSzx2p8Jf38SGjHU2eli/VGjnjl8u+49YXdwvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7c8.dynamic.kabel-deutschland.de [95.90.247.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5389461E647B3;
	Wed, 13 Aug 2025 10:18:30 +0200 (CEST)
Message-ID: <9b44df93-acec-4416-9f32-f97d0bfaaa7b@molgen.mpg.de>
Date: Wed, 13 Aug 2025 10:18:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v1 iwl-next 1/2] igbvf: add lbtx_packets
 and lbtx_bytes to ethtool statistics
To: Kohei Enju <enjuk@amazon.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kohei.enju@gmail.com
References: <20250813075206.70114-1-enjuk@amazon.com>
 <20250813075206.70114-2-enjuk@amazon.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250813075206.70114-2-enjuk@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Kohei,


Thank you for your patch.

Am 13.08.25 um 09:50 schrieb Kohei Enju:
> Currently ethtool shows lbrx_packets and lbrx_bytes (Good RX
> Packets/Octets loopback Count), but doesn't show the TX-side equivalents
> (lbtx_packets and lbtx_bytes). Add visibility of those missing
> statistics by adding them to ethtool statistics.
> 
> In addition, the order of lbrx_bytes and lbrx_packets is not consistent
> with non-loopback statistics (rx_packets, rx_bytes). Therefore, align
> the order by swapping positions of lbrx_bytes and lbrx_packets.
> 
> Tested on Intel Corporation I350 Gigabit Network Connection.
> 
> Before:
>    # ethtool -S ens5 | grep -E "x_(bytes|packets)"
>         rx_packets: 135
>         tx_packets: 106
>         rx_bytes: 16010
>         tx_bytes: 12451
>         lbrx_bytes: 1148
>         lbrx_packets: 12
> 
> After:
>    # ethtool -S ens5 | grep -E "x_(bytes|packets)"
>         rx_packets: 748
>         tx_packets: 304
>         rx_bytes: 81513
>         tx_bytes: 33698
>         lbrx_packets: 97
>         lbtx_packets: 109
>         lbrx_bytes: 12090
>         lbtx_bytes: 12401
> 
> Tested-by: Kohei Enju <enjuk@amazon.com>

No need to resend, but I believe, you only add a Tested-by: tag, if the 
person differs from the author/Signed-off-by: tag.

> Signed-off-by: Kohei Enju <enjuk@amazon.com>
> ---
>   drivers/net/ethernet/intel/igbvf/ethtool.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igbvf/ethtool.c b/drivers/net/ethernet/intel/igbvf/ethtool.c
> index 773895c663fd..c6defc495f13 100644
> --- a/drivers/net/ethernet/intel/igbvf/ethtool.c
> +++ b/drivers/net/ethernet/intel/igbvf/ethtool.c
> @@ -30,8 +30,10 @@ static const struct igbvf_stats igbvf_gstrings_stats[] = {
>   	{ "rx_bytes", IGBVF_STAT(stats.gorc, stats.base_gorc) },
>   	{ "tx_bytes", IGBVF_STAT(stats.gotc, stats.base_gotc) },
>   	{ "multicast", IGBVF_STAT(stats.mprc, stats.base_mprc) },
> -	{ "lbrx_bytes", IGBVF_STAT(stats.gorlbc, stats.base_gorlbc) },
>   	{ "lbrx_packets", IGBVF_STAT(stats.gprlbc, stats.base_gprlbc) },
> +	{ "lbtx_packets", IGBVF_STAT(stats.gptlbc, stats.base_gptlbc) },
> +	{ "lbrx_bytes", IGBVF_STAT(stats.gorlbc, stats.base_gorlbc) },
> +	{ "lbtx_bytes", IGBVF_STAT(stats.gotlbc, stats.base_gotlbc) },
>   	{ "tx_restart_queue", IGBVF_STAT(restart_queue, zero_base) },
>   	{ "tx_timeout_count", IGBVF_STAT(tx_timeout_count, zero_base) },
>   	{ "rx_long_byte_count", IGBVF_STAT(stats.gorc, stats.base_gorc) },

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

