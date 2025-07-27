Return-Path: <netdev+bounces-210352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B9FB12EB7
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 10:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B411736E6
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 08:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4DE1E8326;
	Sun, 27 Jul 2025 08:37:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315BB1DFE26
	for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 08:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753605441; cv=none; b=H6G3bHUt64VXvdHbzSpm7E8vKEG/pVTo7sQg8ssycfkGX40mH12Y/bX+V+qlwXK62xU3v5pEODQXgeBCcJXIyYuUUzykXzhd8uyW9YbZr4ZdqrEfqsXs/hHz+1GbNgPvkR57jF/j0pn9pkbOX2AmPZMz7wWqaqol8gnxKXH7nBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753605441; c=relaxed/simple;
	bh=O6Msoqha+znSu7TVUCpgsxtShrRxu9yAZdxMN9lfCNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJdRIzS2fbKyggsNoYFR505yc8Rn29i4BX52kCtbcIrYjyEJSGiToh4avni4vrgVtWAjlJSYDjWduhPK23Md7hRDdL6jUmO+ZNsmB+CR18u3j9htdWsVpETrEpze+KweKpY5QYQLA9lnk5bOIGWDa0k/QxdJBpQtrUm1Ka6WLKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.202] (p5b13a0f7.dip0.t-ipconnect.de [91.19.160.247])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CECEC61E64849;
	Sun, 27 Jul 2025 10:36:26 +0200 (CEST)
Message-ID: <a8eba276-afbf-456c-943d-36144877cfc0@molgen.mpg.de>
Date: Sun, 27 Jul 2025 10:36:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-net] ixgbe: xsk: resolve the
 negative overflow of budget in ixgbe_xmit_zc
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 larysa.zaremba@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org,
 maciej.fijalkowski@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20250726070356.58183-1-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250726070356.58183-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Jason,


Thank you for the improved version.

Am 26.07.25 um 09:03 schrieb Jason Xing:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Resolve the budget negative overflow which leads to returning true in
> ixgbe_xmit_zc even when the budget of descs are thoroughly consumed.
> 
> Before this patch, when the budget is decreased to zero and finishes
> sending the last allowed desc in ixgbe_xmit_zc, it will always turn back
> and enter into the while() statement to see if it should keep processing
> packets, but in the meantime it unexpectedly decreases the value again to
> 'unsigned int (0--)', namely, UINT_MAX. Finally, the ixgbe_xmit_zc returns
> true, showing 'we complete cleaning the budget'. That also means
> 'clean_complete = true' in ixgbe_poll.
> 
> The true theory behind this is if that budget number of descs are consumed,
> it implies that we might have more descs to be done. So we should return
> false in ixgbe_xmit_zc to tell napi poll to find another chance to start
> polling to handle the rest of descs. On the contrary, returning true here
> means job done and we know we finish all the possible descs this time and
> we don't intend to start a new napi poll.
> 
> It is apparently against our expectations. Please also see how
> ixgbe_clean_tx_irq() handles the problem: it uses do..while() statement
> to make sure the budget can be decreased to zero at most and the negative
> overflow never happens.
> 
> The patch adds 'likely' because we rarely would not hit the loop codition
> since the standard budget is 256.
> 
> Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
> Link: https://lore.kernel.org/all/20250720091123.474-3-kerneljasonxing@gmail.com/
> 1. use 'negative overflow' instead of 'underflow' (Willem)
> 2. add reviewed-by tag (Larysa)
> 3. target iwl-net branch (Larysa)
> 4. add the reason why the patch adds likely() (Larysa)
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> index ac58964b2f08..7b941505a9d0 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> @@ -398,7 +398,7 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
>   	dma_addr_t dma;
>   	u32 cmd_type;
>   
> -	while (budget-- > 0) {
> +	while (likely(budget)) {
>   		if (unlikely(!ixgbe_desc_unused(xdp_ring))) {
>   			work_done = false;
>   			break;
> @@ -433,6 +433,8 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
>   		xdp_ring->next_to_use++;
>   		if (xdp_ring->next_to_use == xdp_ring->count)
>   			xdp_ring->next_to_use = 0;
> +
> +		budget--;
>   	}
>   
>   	if (tx_desc) {

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Is this just the smallest fix, and the rewrite to the more idiomatic for 
loop going to be done in a follow-up?


Kind regards,

Paul

