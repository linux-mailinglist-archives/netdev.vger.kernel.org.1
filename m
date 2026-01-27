Return-Path: <netdev+bounces-253992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOt4LH0UeWl3vAEAu9opvQ
	(envelope-from <netdev+bounces-253992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 20:39:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 597DB9A085
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 20:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5CA03061457
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 19:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5626B36CDE3;
	Tue, 27 Jan 2026 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MvrHHE4A"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5582BCF7F
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 19:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542438; cv=none; b=R+o/rmMBu3xbp7hx1A+X5+J9FfOkgqbHSaFWdvhEODz5148Eakv3JZWBvozztNEFbZKVBRuSFlkwqJVmmw2Ozmk/u665uA0GgkBm4yBPZ+H+kmMifZW/rTMkqpz4biIhXZ2h+lGlZDTXXEU7IHBo8HSPmx5/lkgsM9DJLsvkBrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542438; c=relaxed/simple;
	bh=iYAxyduA0s22PkYnL2nakuErPqp1U9iyFl2fdqR+s7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ea6mC6cbFDGkXIu5ny01+NeFjk7vjG80aGkSAiRsUYiB9pjMSo8Gmz6FdM7+FFR1GbcTDtrZGNu//zLpP2qT/XuY00n2Asc+TnIfD7xm6dtOQWpdkjChtaRs5tzHUy1zU3/6YDSAdqYKtItR1vnAHGGa285k8DHkRktK+08CXLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MvrHHE4A; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <243ea894-3bf3-4c10-b012-d4451e7ec17e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769542424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3DrtAfvaeBV+P4A9wsocJoQ3hSxFzimNThzq0s5w4qU=;
	b=MvrHHE4ASs7vyavoa/VJYmmAgD8AXEib483PbIUj8Wfu4x3AbgWNmAhBaTECcOEBPlkqyQ
	hX2Qrh0Ed5+eio9mr+Lvqn1CEkaYDkn8zsTP3NMUkU63UGwNXtVcLaCWelx3QVmeV4DJS3
	DdRZaR6KpstVb5JsZSQ9U3iu1iaRCRM=
Date: Tue, 27 Jan 2026 11:33:30 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 00/10] Call skb_metadata_set when skb->data
 points past metadata
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org,
 bpf@vger.kernel.org, kernel-team@cloudflare.com,
 Jakub Kicinski <kuba@kernel.org>, Amery Hung <ameryhung@gmail.com>
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
 <20260112190856.3ff91f8d@kernel.org> <87bjixwv41.fsf@cloudflare.com>
 <ad835a9b-e544-48d3-b6e2-ffe172fcfa6d@linux.dev>
 <878qdltsg0.fsf@cloudflare.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <878qdltsg0.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,broadcom.com,lunn.ch,intel.com,nvidia.com,iogearbox.net,gmail.com,fomichev.me,lists.osuosl.org,cloudflare.com];
	TAGGED_FROM(0.00)[bounces-253992-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[25];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 597DB9A085
X-Rspamd-Action: no action



On 1/25/26 11:15 AM, Jakub Sitnicki wrote:
> On Thu, Jan 22, 2026 at 12:21 PM -08, Martin KaFai Lau wrote:
>> On 1/13/26 4:33 AM, Jakub Sitnicki wrote:
>>> Good point. I'm hoping we don't have to allocate from
>>> skb_metadata_set(), which does sound prohibitively expensive. Instead
>>> we'd allocate the extension together with the skb if we know upfront
>>> that metadata will be used.
>>
>> [ Sorry for being late. Have been catching up after holidays. ]
>>
>> For the sk local storage (which was mentioned in other replies as making skb
>> metadata to look more like sk local storage), there is a plan (Amery has been
>> looking into it) to allocate the storage together with sk for performance
>> reason. This means allocating a larger 'struct sock'. The extra space will be at
>> the front of sk instead of the end of sk because of how the 'struct sock' is
>> embedded in tcp_sock/udp_sock/... If skb is going in the same direction, it
>> should be useful to have a similar scheme on: upfront allocation and then shared
>> by multiple BPF progs.
>>
>> The current thinking is to built upon the existing bpf_sk_local_storage usage. A
>> boot param decides how much BPF space should be allocated for 'struct
>> sock'. When a bpf_sk_storage_map is created (with a new use_reserve flag), the
>> space will be allocated permanently from the head space of every sk for this
>> map. The read (from a BPF prog) will be at one stable offset before a sk. If
>> there is no more head space left, the map creation will fail. User can decide if
>> it wants to retry without the 'use_reserve' flag.
> 
> Thanks for sharing the plans.
> 
> We will definitely be looking into ways of eliminating allocations in
> the long run. With one allocation for skb_ext, one for
> bpf_local_storage, and one for the actual map, it seems unlikely we will
> be able to attach metadata this way to every packet. Which is something
> we wanted for our "label packet once, use label everywhere" use case.
> 
> I'm not sure how much we can squeeze in together with the sk_buff.
> Hopefully at least skb_ext plus a pointer to bpf_local_storage.

yeah, only a bpf_local_storage pointer is needed in skb (or in skb_ext). 
It is the same for the bpf sk/task/... storage.

To be clear, for allocation in skb, I was thinking more about Paolo's 
comment on "...increasing struct sk_buff size as an alternative to the 
mptcp skb extension...".

> 
> I'm also hoping we can allocate memory for bpf_local_storage together
> with the backing space for the map, which update triggers the skb
> extension activation.

Allocate the actual storage at the end of bpf_local_storage? Hmm... off 
the top of my head, I don't have a good idea how to do it without 
trading off flexibility. If trading off flexibility, may as well 
allocate fixed extra space at the sk (/skb) and get a performance 
benefit (which would need to be measured).

> 
> Finally, bpf_local_storage itself has a pretty generous cache which
> blows it up. Maybe the cache could be a flexible array, which could be
> smaller for skb local storage.

For our usage, the cache has been slowly filling up, so we actually have 
another side of the issue. Improvements on bpf_local_storage is always 
welcomed.

I am currently more interested in getting the extra memory/headroom 
allocated for an sk. Eventually, the storage(s) that will be needed for 
all (or most) sk will use the extra headroom of sk. The current 
bpf_local_storage (pointer) in sk will be more for testing/ad-hoc 
purpose or for performance-insensitive usage.

It is probably off topic now. It seems having extra tail space in a skb 
is not in your current plan for the next respin.


