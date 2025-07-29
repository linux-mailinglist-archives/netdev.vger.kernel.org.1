Return-Path: <netdev+bounces-210898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 041AAB15574
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 00:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1513A45BD
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 22:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605EE278E63;
	Tue, 29 Jul 2025 22:54:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C4D1DE2BC
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 22:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753829664; cv=none; b=Egw5xo1tOyLowqpzKBcI/h43O/6btp9KLhdLrwOMZ92I6j4LzC4t26vStNHdlmnbzqUer6w8R4SToqj/zz1hoL7UklAPD/P/ETrQiu2q7ntl6WB1zyeMveBSp5PE6Hd51HH5UpB90UBwYQrnj406DHm/WLycbHm0cEJB3DxNkjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753829664; c=relaxed/simple;
	bh=FmmKKPbsE1toXKXc97FTyBevxK2qy+Eh04NqU9ng1hQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ugsGSNB58veytANW+JG8XdzqzyPEJSv1CvMp/bHoHWGAdIla8USJqF7ndFtMAbLDov9ipmh4wdvFWxnFcUhce5c4OPFVdGL5TnIuXLz9PEXjBi0PXxzlcrMZ/AADCkouNgnUsdfXWpGP6aPaQ73wCdzKYmI7ckOnFMTBxNiuwKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.5] (ip5f5af14f.dynamic.kabel-deutschland.de [95.90.241.79])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CF6B861E647B7;
	Wed, 30 Jul 2025 00:53:53 +0200 (CEST)
Message-ID: <47059a58-a12c-4a4d-ba00-fb057088a3f0@molgen.mpg.de>
Date: Wed, 30 Jul 2025 00:53:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3 1/6] idpf: add support for Tx
 refillqs in flow scheduling mode
To: Joshua A Hay <joshua.a.hay@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Madhu Chittim <madhu.chittim@intel.com>
References: <20250725184223.4084821-1-joshua.a.hay@intel.com>
 <20250725184223.4084821-2-joshua.a.hay@intel.com>
 <f23248bc-b873-41ed-b6b3-a9638b51eb3f@molgen.mpg.de>
 <DM4PR11MB65023EC8F1B1FC4664EB1F86D425A@DM4PR11MB6502.namprd11.prod.outlook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <DM4PR11MB65023EC8F1B1FC4664EB1F86D425A@DM4PR11MB6502.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Joshua,


Thank you for your reply.

Am 29.07.25 um 19:15 schrieb Hay, Joshua A:
>>> In certain production environments, it is possible for completion tags
>>> to collide, meaning N packets with the same completion tag are in flight
>>> at the same time. In this environment, any given Tx queue is effectively
>>> used to send both slower traffic and higher throughput traffic
>>> simultaneously. This is the result of a customer's specific
>>> configuration in the device pipeline, the details of which Intel cannot
>>> provide. This configuration results in a small number of out-of-order
>>> completions, i.e., a small number of packets in flight. The existing
>>> guardrails in the driver only protect against a large number of packets
>>> in flight. The slower flow completions are delayed which causes the
>>> out-of-order completions. The fast flow will continue sending traffic
>>> and generating tags. Because tags are generated on the fly, the fast
>>> flow eventually uses the same tag for a packet that is still in flight
>>> from the slower flow. The driver has no idea which packet it should
>>> clean when it processes the completion with that tag, but it will look
>>> for the packet on the buffer ring before the hash table.  If the slower
>>> flow packet completion is processed first, it will end up cleaning the
>>> fast flow packet on the ring prematurely. This leaves the descriptor
>>> ring in a bad state resulting in a crashes or Tx timeout.
>>
>> “in a crash” or just “crashes” wtih no article.
> 
> Will fix.
> 
>>
>>> In summary, generating a tag when a packet is sent can lead to the same
>>> tag being associated with multiple packets. This can lead to resource
>>> leaks, crashes, and/or Tx timeouts.
>>>
>>> Before we can replace the tag generation, we need a new mechanism for
>>> the send path to know what tag to use next. The driver will allocate and
>>> initialize a refillq for each TxQ with all of the possible free tag
>>> values. During send, the driver grabs the next free tag from the refillq
>>> from next_to_clean. While cleaning the packet, the clean routine posts
>>> the tag back to the refillq's next_to_use to indicate that it is now
>>> free to use.
>>>
>>> This mechanism works exactly the same way as the existing Rx refill
>>> queues, which post the cleaned buffer IDs back to the buffer queue to be
>>> reposted to HW. Since we're using the refillqs for both Rx and Tx now,
>>> genercize some of the existing refillq support.
>>
>> gener*i*cize
> 
> Will fix.
> 
>>
>>> Note: the refillqs will not be used yet. This is only demonstrating how
>>> they will be used to pass free tags back to the send path.
>>>
>>> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
>>> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
>>> ---
>>> v2:
>>> - reorder refillq init logic to reduce indentation
>>> - don't drop skb if get free bufid fails, increment busy counter
>>> - add missing unlikely
>>> ---
>>>    drivers/net/ethernet/intel/idpf/idpf_txrx.c | 93 +++++++++++++++++++--
>>>    drivers/net/ethernet/intel/idpf/idpf_txrx.h |  8 +-
>>>    2 files changed, 91 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>>> index 5cf440e09d0a..d5908126163d 100644
>>> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>>> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c

[…]

>>> @@ -267,6 +271,29 @@ static int idpf_tx_desc_alloc(const struct idpf_vport *vport,
>>>    	tx_q->next_to_clean = 0;
>>>    	idpf_queue_set(GEN_CHK, tx_q);
>>>
>>> +	if (!idpf_queue_has(FLOW_SCH_EN, tx_q))
>>> +		return 0;
>>> +
>>> +	refillq = tx_q->refillq;
>>> +	refillq->desc_count = tx_q->desc_count;
>>> +	refillq->ring = kcalloc(refillq->desc_count, sizeof(u32),
>>> +				GFP_KERNEL);
>>> +	if (!refillq->ring) {
>>> +		err = -ENOMEM;
>>> +		goto err_alloc;
>>> +	}
>>> +
>>> +	for (u32 i = 0; i < refillq->desc_count; i++)
>>
>> No need to limit the length, as far as I can see.
> 
> Apologies, I'm not sure I follow. Can you please clarify?

Sorry, for being ambiguous. I meant, just use `unsigned int` as type for 
the counting variable.

[…]


Kind regards,

Paul


PS: Just a note, that your client seems to have wrapped some of the code 
lines.

