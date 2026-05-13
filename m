Return-Path: <netdev+bounces-287553-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDM+GjVlBGq6HgIAu9opvQ
	(envelope-from <netdev+bounces-287553-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:49:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FB353283E
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00EE7300A8E0
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9233E9C37;
	Wed, 13 May 2026 11:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="koSUU7EJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SndV3drr"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0541427A
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778672946; cv=none; b=JbUBQyXAnDdBHQckyFwaxXIFSecBDh3tkDyBcxDX/8X9Ulmb/5Mb5dqh0ee4jVvdK5rPye4SUshd8EsF7dQYh837zkGvma9xAAWbpBApeYUuSwDzVecHRHjw5tH2aoIaFbtmy73eo0ErVa0c3/i6ZhBzc0Q4CAq4brXOtY1HmYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778672946; c=relaxed/simple;
	bh=1QIxWlWTB4NtBgfgBm7FF5qlNTVYp0iacKSMhJfEj18=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Kite6doO8V3TTYUs/ZEyWU1XbVcgm41VARhnSAc4f1kJZjN8NoQKAOWbk+rWu9smVrGsF9OD8QKTLg7fF1T6nBzDvit5appda2L0qS2WlF0x0D5kM08btluwTITJWBFjtXsVBPpjbbJv2XexwWYcegxq4ZdJPO4ijukiDhmlhXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=koSUU7EJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SndV3drr; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5E3227A0156;
	Wed, 13 May 2026 07:49:02 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-10.internal (MEProxy); Wed, 13 May 2026 07:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778672942;
	 x=1778759342; bh=vtU642UQcTS1yFh2yFytTiYauavllYh3YMTs+oQbXg0=; b=
	koSUU7EJ1Kk/MYoGNnMok0yWADgFqOpAYwdPKL1Di1IP0tM3vjd0WqBcwQuEjL94
	QeV1mKJGH+pPCAFa8B5ZTuQ3fxaeqUaZlrSGYvjBl+kzWRxYy38KqdYwVU1rAY3O
	WG+Jg9XqoxvYvcagl0etYovL7o5ay2kDhSJKzBAZvPaV3GE/PSfm/iWGfOUDfbmv
	j5mgdsklrummcWsTRMd8IXfDIW0qp989xqlwZYEvezXJH9zWmdYGAT1SYb/uD1a6
	Fun+sSwb/00ne+PruQmFj8eZwKB8LCD/Zaq+8hwXuAmmRXpxgr7xYzMu19mX0lCs
	Aq2nRISK9RI/zOJmsQscEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778672942; x=
	1778759342; bh=vtU642UQcTS1yFh2yFytTiYauavllYh3YMTs+oQbXg0=; b=S
	ndV3drrJod0pbAaUQsGolSQYbtGI5B16aSGqIjyY2vKfhqZI/yFMbMaJ7+UBn61P
	TSqRQPDVk0ngLnO4GaaqfPmPI9Azpr8Hgh3dIfIsCEjS5phuWo7SNPamIQqOMzzt
	unXNuPlIYWSoWKb9WCHodnB0LDsNVlEHlkNVIxuInIc5N0ghDpWdVMmYu1Tdvssb
	iW+nC5sE3BgbamZY+CHl6MOw5fWBJOupk2+WUeVOsx2pG7K942SSeFayXJtSTAzA
	pSrg/TOEA1qppjb4yDkc3IKtnJmOG0zh9j76g+lVBY+yReGmMSrVcYBZeZRgtG8K
	E4LHGjSiX9Ex7Y4KCq5pg==
X-ME-Sender: <xms:LWUEaszLk3Ige5ER20furuLElHBOZamoe5mQPc1ehrEdh7puPNsQ1Q>
    <xme:LWUEarHhpTUXv0pUUxIMJSv9GzR5m9gsuglYYKG2Vj5bozbdv8zrYyPdiZDJ8j2MC
    YvwkEozX4Da5Rfb-EjdMS3ertTeySKgXLp0HW2LgajeL9JdYY9UXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdegheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehlihgt
    vgcuofhikhhithihrghnshhkrgdfuceorghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrg
    hilhdrihhmqeenucggtffrrghtthgvrhhnpefhgfevgeeljeegleeiffduheegieehtdff
    tdetvdffieelkedthfejleejgfeftdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgt
    vgdrkhgvrhhnvghlsehfrghsthhmrghilhdrihhmpdhnsggprhgtphhtthhopeduuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdr
    nhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepfihilhhlvghmsgesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhmshes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmrghtthhhvgifrdhstghhfigrrhhtiieslhhinhhugidruggvvhdprhgt
    phhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepug
    htrghtuhhlvggrsehnvhhiughirgdrtghomhdprhgtphhtthhopehgrghlsehnvhhiughi
    rgdrtghomh
X-ME-Proxy: <xmx:LWUEar8np9TiOC9f6udPjIkay8EZofd5O-h3olVXq-TtRCm_7Z39jQ>
    <xmx:LWUEal8MbmGjfJw8iB9mtKsd-NJhhi-nHbpNjWikcNexfxCbyK0kkw>
    <xmx:LWUEaiXi2hvxLwpIn_jaY-gVYfO_jLCOhlJ5MbW8Dh32aSBc4h1IYg>
    <xmx:LWUEaqdaYAqYsERCcrAl2tTPjofcXLC_3T8SU3oa0UymWYei_P-gew>
    <xmx:LmUEakzDXb2J-8rTzo0boNHPZuYFuQo0uKXDotuNTJAUKsbbraRtwYdM>
Feedback-ID: i559e4809:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5FCFDC4006E; Wed, 13 May 2026 07:49:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 13 May 2026 13:48:41 +0200
From: "Alice Mikityanska" <alice.kernel@fastmail.im>
To: "Gal Pressman" <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org
Cc: "Simon Horman" <horms@kernel.org>, "Dragos Tatulea" <dtatulea@nvidia.com>,
 "Willem de Bruijn" <willemb@google.com>,
 "Matthew Schwartz" <matthew.schwartz@linux.dev>
Message-Id: <23e6e0f4-29ee-4f86-b02d-8c8d881c51f7@app.fastmail.com>
In-Reply-To: <c129979f-7494-433c-92c4-6d4290add4d9@nvidia.com>
References: <20260513074349.2152146-1-gal@nvidia.com>
 <f75c1cf5-b5ad-47db-952f-faad9f0a33ed@app.fastmail.com>
 <f356add6-e173-4020-a8af-8cc70aec955d@nvidia.com>
 <ea0d0e1c-bfc2-4271-94d7-3bec2f2e85a3@app.fastmail.com>
 <c129979f-7494-433c-92c4-6d4290add4d9@nvidia.com>
Subject: Re: [PATCH net] udp: Fix UDP length on last GSO_PARTIAL segment
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 74FB353283E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-287553-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[fastmail.im];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,fastmail.im:dkim]
X-Rspamd-Action: no action

On Wed, May 13, 2026, at 13:28, Gal Pressman wrote:
> On 13/05/2026 13:08, Alice Mikityanska wrote:
>> On Wed, May 13, 2026, at 11:43, Gal Pressman wrote:
>>> On 13/05/2026 12:17, Alice Mikityanska wrote:
>>>> On Wed, May 13, 2026, at 09:43, Gal Pressman wrote:
>>>>> Following the cited commit, __udp_gso_segment() writes single MSS length
>>>>> in the UDP header.
>>>>> The cited patch doesn't account for the fact that the last segment could
>>>>> be a GSO skb by itself. This could happen when the size of the packet is
>>>>> a multiple of MSS, hence the first segment is also the last one (there
>>>>> is no need for a remainder skb).
>>>>>
>>>>> When the post-loop segment is a GSO skb, assign the single MSS length in
>>>>> the UDP header.
>>>>>
>>>>> Fixes: b10b446ce7ad ("udp: gso: Use single MSS length in UDP header for 
>>>>> GSO_PARTIAL")
>>>>> Reported-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>>>> Closes: 
>>>>> https://lore.kernel.org/all/6c3fb15e-711d-4b8d-b152-e03d9b05293f@linux.dev/
>>>>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>>>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>>>>> Signed-off-by: Gal Pressman <gal@nvidia.com>
>>>>> ---
>>>>>  net/ipv4/udp_offload.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
>>>>> index a0813d425b71..71df45f9488a 100644
>>>>> --- a/net/ipv4/udp_offload.c
>>>>> +++ b/net/ipv4/udp_offload.c
>>>>> @@ -604,7 +604,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>>>>>  		       seg->data_len);
>>>>>  	check = csum16_add(csum16_sub(uh->check, uh->len), newlen);
>>>>>
>>>>> -	uh->len = newlen;
>>>>> +	uh->len = skb_is_gso(seg) ? msslen : newlen;
>>>>>  	uh->check = check;
>>>>
>>>> This is going to have the same checksum bug as your first commit, which
>>>> I'm fixing in [1]. You should use the right value of either msslen or
>>>> newlen when modifying check a couple of lines above.
>>>
>>> I tend to agree that the checksum seems to have the wrong value, the
>>> reason I chose not to change it is because my work only moved the UDP
>>> length assignment from the drivers to the stack.
>>>
>>> The "wrong" checksum value was used regardless of my change,
>> 
>> The wrong checksum was visible only inside the driver, and since the
>> hardware didn't care (due to the offload), it worked well. It was the
>> driver business to make sure the corresponding hardware likes the
>> packet. After commit b10b446ce7ad ("udp: gso: Use single MSS length in
>> UDP header for GSO_PARTIAL"), however, the wrong checksum moved one
>> abstraction layer higher - to the networking stack, which attempts to
>> keep the checksum correct for a more generic case. It's not the same,
>> and while I'm trying to fix one occurrence, I'd prefer not to
>> introduce more.
>> 
>>> and I
>>> prefer not to change it as part of this work.
>>>
>>>>
>>>> That said, maybe you can base your patch on top of my checksum fix? For
>>>> the last packet, it will then be:
>>>>
>>>> if (!skb_is_gso(seg))
>>>>         newlen = /* the new value */;
>>>> /* keep newlen as is otherwise: my newlen is your msslen */
>>>> check = csum16_add(csum16_sub(uh->check, uh->len), newlen);
>>>> uh->len = newlen;
>>>> uh->check = check;
>>>>
>>>> [1]: https://lore.kernel.org/netdev/20260512165648.386518-3-alice.kernel@fastmail.im/
>>>
>>> As I mentioned in the other thread, this fix goes to net, I can't take
>>> your patch.
>> 
>> Ah, that's right. Still, I guess you can take mine to net for the
>> checksum fix.
>
> Do you think it is suitable for net?

This is always a mystery to me... I've had different experiences:
sometimes I am asked to resubmit less important fixes to -next,
sometimes a fix is a fix and must go to net. This one is a refactoring
useful for my further patches + the checksum fix, which we get for free
and which I considered not important enough to submit to net (hardware
offload fixes the checksum in most cases anyway). Following the "a fix
is a fix" logic, we may try sending it to net. What do you think?

> Would you like to rephrase the
> commit message accordingly?
>
> If you can send me an updated version I will take it and submit both (or
> you can submit mine if you prefer).

