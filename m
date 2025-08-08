Return-Path: <netdev+bounces-212161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCCFB1E7F1
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1E187A449A
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 12:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5913260592;
	Fri,  8 Aug 2025 12:04:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4779276038
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754654653; cv=none; b=oQ/bv2GSRttrsHT6eCrPS/D/wMei4PrmoQ/5C2+d+lJN8vacoELqSo2WxMhYBR4KZRlN9t/L56NEMjsCZcHf69rQMJ+alY7mhXRGr/EgKRXSVOeutgJbVfGqus2EvR/h6x0g01Cj+nbfFr7fmDF6doOJq8h/z1cyNLjkKIeniXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754654653; c=relaxed/simple;
	bh=pC9LzVgTkKwLZJzcio7e9M+PrdBY8o5KhxAJonzP33k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c00pASgj2cITO+lgXBiNEz5y7HkTjp4+7BTIEYDHlc3V56AMCTyMwtJHb5NhzlTqDMTnQfTi5ofYTrfk7ezveZknhyVDqAotW7wZQzCmzZ/IPGKlCwMaAxhVX9TNrsYKzw4T0g3QPOepkfXzGq4KsOiy2Fi+Twmc471zd4o5TiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8BB7660288279;
	Fri, 08 Aug 2025 14:03:43 +0200 (CEST)
Message-ID: <ee6af42d-b274-4079-8a8b-35ec8d500c1c@molgen.mpg.de>
Date: Fri, 8 Aug 2025 14:03:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 3/3] ice: switch to Page Pool
To: Michal Kubiak <michal.kubiak@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, maciej.fijalkowski@intel.com,
 aleksander.lobakin@intel.com, larysa.zaremba@intel.com,
 netdev@vger.kernel.org, przemyslaw.kitszel@intel.com,
 anthony.l.nguyen@intel.com
References: <20250704161859.871152-1-michal.kubiak@intel.com>
 <20250704161859.871152-4-michal.kubiak@intel.com>
 <53c62d9c-f542-4cf3-8aeb-a1263e05acad@intel.com>
 <aJXiP-_ZUfBErhAv@localhost.localdomain>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <aJXiP-_ZUfBErhAv@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Michal, dear Jacob,


One minor comment:

Am 08.08.25 um 13:40 schrieb Michal Kubiak:
> On Mon, Jul 07, 2025 at 03:58:37PM -0700, Jacob Keller wrote:
>>
>>
>> On 7/4/2025 9:18 AM, Michal Kubiak wrote:
>>> @@ -1075,16 +780,17 @@ void ice_clean_ctrl_rx_irq(struct ice_rx_ring *rx_ring)
>>>   static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
> 
> [...]
> 
>>> @@ -1144,27 +841,35 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>>>   		if (ice_is_non_eop(rx_ring, rx_desc))
>>>   			continue;
>>>   
>>> -		ice_get_pgcnts(rx_ring);
>>>   		xdp_verdict = ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_desc);
>>>   		if (xdp_verdict == ICE_XDP_PASS)
>>>   			goto construct_skb;
>>> -		total_rx_bytes += xdp_get_buff_len(xdp);
>>> -		total_rx_pkts++;
>>>   
>>> -		ice_put_rx_mbuf(rx_ring, xdp, &xdp_xmit, ntc, xdp_verdict);
>>> +		if (xdp_verdict & (ICE_XDP_TX | ICE_XDP_REDIR))
>>> +			xdp_xmit |= xdp_verdict;
>>> +		total_rx_bytes += xdp_get_buff_len(&xdp->base);
>>> +		total_rx_pkts++;
>>>   
>>> +		xdp->data = NULL;
>>> +		rx_ring->first_desc = ntc;
>>> +		rx_ring->nr_frags = 0;
>>>   		continue;
>>>   construct_skb:
>>> -		skb = ice_build_skb(rx_ring, xdp);
>>> +		skb = xdp_build_skb_from_buff(&xdp->base);
>>> +
>>>   		/* exit if we failed to retrieve a buffer */
>>>   		if (!skb) {
>>>   			rx_ring->ring_stats->rx_stats.alloc_page_failed++;
>>
>> This is not your fault, but we've been incorrectly incrementing
>> alloc_page_failed here instead of alloc_buf_failed.
>>
> 
> Sure. It's a good idea to fix it while we're rewriting the Rx path.
> Will be addressed in v2.

Should this be a separate patch, that can be easily backported?

[…]


Kind regards,

Paul

