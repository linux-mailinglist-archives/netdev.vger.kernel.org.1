Return-Path: <netdev+bounces-230478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02533BE8923
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 14:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A519B19A2E65
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 12:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751AC3164AF;
	Fri, 17 Oct 2025 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="stBFIijk"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C33C332EC5
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760703734; cv=none; b=E6dtRN2ITDlvMTjI7b/So8AYLHhi+TME1mA6fTrSdeReqMu4xg6ZA+Z0TDl9u2qVYI3clxv+7fpvB10MAFWM2v+wH43hfHSQRXyJcYQfxwsD7mky/S2i9rV4TREqVTZ6yOoGCgTu8h0H6iiCl/hlE+FQ1fm47fuS5ecx5kcy1Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760703734; c=relaxed/simple;
	bh=p4htG76CAU6X4aXzc3hFDO91x7V/rjzHSa6bas1xNfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLj33TN32lAub1F7+WHIuadp+kiw6qn0Aw9HhgqLujUyUe7Fbz9GvekPH38WXZZvdSdWZ/TFZm1B0eF0q/u3pEgPoaG+wiQjS93EazwtsWx6FnAZXhdi4W0uJRLPLG7LxATIXa77HHFBeENV7sANUQ6StZVDRfG0JGj+inQZhSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=stBFIijk; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <83ffc316-6711-4ae4-ad10-917f678de331@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760703720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pm4SvBhyBXqqMBUE8P86/UF8WP0RkuXkSVtcysJBKDc=;
	b=stBFIijknAIaQCktEObO1xPMD1ChASDC9VZojqVyFVrqnsIFbs9oq/ezFB8rp7D4w1ms5a
	Vbg5rmvsgtccQsQwbkSfu2j94pn4HRe+HSNysIhQlWvpzgObZQbA2RgkztsgdXWT/rNVjG
	GeBghovGgUutRQLjuvLSY6O44YANHWM=
Date: Fri, 17 Oct 2025 13:21:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3 2/3] net: stmmac: Consider Tx VLAN offload tag
 length for maxSDU
To: "G Thomas, Rohan" <rohan.g.thomas@altera.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>,
 Rohan G Thomas <rohan.g.thomas@intel.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20251017-qbv-fixes-v3-0-d3a42e32646a@altera.com>
 <20251017-qbv-fixes-v3-2-d3a42e32646a@altera.com>
 <d7bbb7dd-ddc6-43d6-b234-53213bde71bd@altera.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <d7bbb7dd-ddc6-43d6-b234-53213bde71bd@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 17/10/2025 08:36, G Thomas, Rohan wrote:
> Hi All,
> 
> On 10/17/2025 11:41 AM, Rohan G Thomas via B4 Relay wrote:
>> +    sdu_len = skb->len;
>>       /* Check if VLAN can be inserted by HW */
>>       has_vlan = stmmac_vlan_insert(priv, skb, tx_q);
>> +    if (has_vlan)
>> +        sdu_len += VLAN_HLEN;
>> +
>> +    if (priv->est && priv->est->enable &&
>> +        priv->est->max_sdu[queue] &&
>> +        skb->len > priv->est->max_sdu[queue]){
> 
> I just noticed an issue with the reworked fix after sending the patch.
> The condition should be: sdu_len > priv->est->max_sdu[queue]
> 
> I’ll send a corrected version, and will wait for any additional comments
> in the meantime.

Well, even though it's a copy of original code, it would be good to
improve some formatting and add a space at the end of if statement to
make it look like 'if () {'>
>> +        priv->xstats.max_sdu_txq_drop[queue]++;
>> +        goto max_sdu_err;
>> +    }
>>       entry = tx_q->cur_tx;
>>       first_entry = entry;
>>
> 
> Best Regards,
> Rohan
> 


