Return-Path: <netdev+bounces-287515-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPuqHnhOBGrNGgIAu9opvQ
	(envelope-from <netdev+bounces-287515-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:12:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D495553135D
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEF1430E0D8D
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C923932D4;
	Wed, 13 May 2026 10:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="HeHgmaeE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="laKzuky3"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A71392825
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778666943; cv=none; b=tqIjxGvJ9Hr68nu+A2MEbZPB3H01yyRlBSHWSStZKxFlyMOz2CQ3pw89+HXwhQNHL0QLSJ0JMXzekR+Ye5reAWvWaE8PwLLFvSDktovCQXZlNjPvEcjTp0UEKWAF4sp8iVsXo6rF5UdGOUlVoxecE/0B4Bx4YqCFFpx/R8BAnlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778666943; c=relaxed/simple;
	bh=uQbklG9FEseYnqfrNHTrNuy4LtBVpczz7v2TFAGAa/Q=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=INUXcth4ePvSL66EFJkO/V9WyM9RaTHGu+3bXeZggJgb7sRZXCpe9BtJblJz09Yjl4lbkYIdMqeF7G57UGA7K0HOrgdNSJZD1Qz4saZrNrkTciPIxreWSRYS97ohbyvslM9B4oPCGyEgk7oWMzqusudNBUxLAsSr6RKnXZTzrB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=HeHgmaeE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=laKzuky3; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 40D2C1D00123;
	Wed, 13 May 2026 06:08:56 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-10.internal (MEProxy); Wed, 13 May 2026 06:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778666936;
	 x=1778753336; bh=1+1Yh+0z0n9VPxhe0SYceMzxLMr46qAf85ZwCvbLsmo=; b=
	HeHgmaeEyQ+tq/yIXpHKu5PYZ1b/r99ulcn5tOXjqeNMvyiYtN+VgFsmVLob8+YU
	jvoN8bwR2weRuUV9ue9SwGMtPibTE2yTXSPq3sNB+RrvzJ9N2DRgUHtaSiRyZiW3
	LKqycr0ouwxiSKRTimuvHbicDmwpdBNKvOxCIlZcBgAivPFK4AB+ubcmn0O+DfwI
	XItGm+4qDmPN9Irc4u9UBn63V1WiNV6J2nanXbRDX1KgE86R8XD9iZYMY5btC7EX
	ZO2hfvp5RWq4JqHEgW7FQX51VRaM+KUvzqkSwEzEh+wxi1no5V9ZwaRPSs1olAMA
	XvGpQDRMn6AaJrQfDqoEeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778666936; x=
	1778753336; bh=1+1Yh+0z0n9VPxhe0SYceMzxLMr46qAf85ZwCvbLsmo=; b=l
	aKzuky3zcBAG4fAGypVFM5ATQVJkh/rf2e+VGn7Z07k3r54O24zsy2P/aI/7caCs
	Z90/1Fbv1kgKfaWomm3r2X5RcH3emP2D+P+qV4HU83IwrOSq6hVYliwa2TgoaBmQ
	fj7lvvznz1PHHbcs8YvrBPTKUgVnIkpUl/xR6kAMYsdiLrA9EVcDjHn60P7YoyjG
	MnBZYcVWS42knAc77NikPRYycd6t/k498GF+b+/l/kmvaOYzD1FGkR3+fjmL72ie
	eGOaUrIC+CJX8Bkwdk1lUP4w1Tk8gZhkYuT6ZBisPipugoiLXPS95O+kcHxJFeUr
	+HKz/VgMkKWgah5OCVSsw==
X-ME-Sender: <xms:t00Eag4bnI4fJkYn_uBtVglz1O7jJZA2vPVm8B7Ok0-gHhq6dS2nDw>
    <xme:t00EasvsPOlT9fjXsjegCbVuyzCKUT3Fz2eCO6Negj_wPKr1_ojtRgZElNeEER9Ou
    3fqb2Vxrk8QcemfOJODCcwUXWlA1rWUnmpt2zRRNzE_aQWRDpDoYWE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdegfeekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:t00EavHOH5XMIs5QvsEv8Hsp36nPVPv_FnAm9IeUYEoaD3n9YRUA9Q>
    <xmx:t00EaqkoHDl6dnYZqEzRYyuiK-Vb1CQUZe6-2x7uI7t0eclOQVm0Gg>
    <xmx:t00Eaqdpn55NGM3FFI7OFERLspye1EAqhp3BPXhtS1reLgcDmY7vpw>
    <xmx:t00EagHZpPGQj-6R_UxvNL405qPJiR4g4lI4yDw7VOkiltb6XVMuJw>
    <xmx:uE0Eau7rmR_NlGUIlmTjVYt2ZM5b-jWb55slmeXKZoTJzqo1K4hQ8QdQ>
Feedback-ID: i559e4809:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B2DFFC4006E; Wed, 13 May 2026 06:08:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 13 May 2026 12:08:06 +0200
From: "Alice Mikityanska" <alice.kernel@fastmail.im>
To: "Gal Pressman" <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org
Cc: "Simon Horman" <horms@kernel.org>, "Dragos Tatulea" <dtatulea@nvidia.com>,
 "Willem de Bruijn" <willemb@google.com>,
 "Matthew Schwartz" <matthew.schwartz@linux.dev>
Message-Id: <ea0d0e1c-bfc2-4271-94d7-3bec2f2e85a3@app.fastmail.com>
In-Reply-To: <f356add6-e173-4020-a8af-8cc70aec955d@nvidia.com>
References: <20260513074349.2152146-1-gal@nvidia.com>
 <f75c1cf5-b5ad-47db-952f-faad9f0a33ed@app.fastmail.com>
 <f356add6-e173-4020-a8af-8cc70aec955d@nvidia.com>
Subject: Re: [PATCH net] udp: Fix UDP length on last GSO_PARTIAL segment
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D495553135D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-287515-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[fastmail.im];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid,nvidia.com:email,messagingengine.com:dkim,fastmail.im:dkim]
X-Rspamd-Action: no action

On Wed, May 13, 2026, at 11:43, Gal Pressman wrote:
> On 13/05/2026 12:17, Alice Mikityanska wrote:
>> On Wed, May 13, 2026, at 09:43, Gal Pressman wrote:
>>> Following the cited commit, __udp_gso_segment() writes single MSS length
>>> in the UDP header.
>>> The cited patch doesn't account for the fact that the last segment could
>>> be a GSO skb by itself. This could happen when the size of the packet is
>>> a multiple of MSS, hence the first segment is also the last one (there
>>> is no need for a remainder skb).
>>>
>>> When the post-loop segment is a GSO skb, assign the single MSS length in
>>> the UDP header.
>>>
>>> Fixes: b10b446ce7ad ("udp: gso: Use single MSS length in UDP header for 
>>> GSO_PARTIAL")
>>> Reported-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>> Closes: 
>>> https://lore.kernel.org/all/6c3fb15e-711d-4b8d-b152-e03d9b05293f@linux.dev/
>>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>>> Signed-off-by: Gal Pressman <gal@nvidia.com>
>>> ---
>>>  net/ipv4/udp_offload.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
>>> index a0813d425b71..71df45f9488a 100644
>>> --- a/net/ipv4/udp_offload.c
>>> +++ b/net/ipv4/udp_offload.c
>>> @@ -604,7 +604,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>>>  		       seg->data_len);
>>>  	check = csum16_add(csum16_sub(uh->check, uh->len), newlen);
>>>
>>> -	uh->len = newlen;
>>> +	uh->len = skb_is_gso(seg) ? msslen : newlen;
>>>  	uh->check = check;
>> 
>> This is going to have the same checksum bug as your first commit, which
>> I'm fixing in [1]. You should use the right value of either msslen or
>> newlen when modifying check a couple of lines above.
>
> I tend to agree that the checksum seems to have the wrong value, the
> reason I chose not to change it is because my work only moved the UDP
> length assignment from the drivers to the stack.
>
> The "wrong" checksum value was used regardless of my change,

The wrong checksum was visible only inside the driver, and since the
hardware didn't care (due to the offload), it worked well. It was the
driver business to make sure the corresponding hardware likes the
packet. After commit b10b446ce7ad ("udp: gso: Use single MSS length in
UDP header for GSO_PARTIAL"), however, the wrong checksum moved one
abstraction layer higher - to the networking stack, which attempts to
keep the checksum correct for a more generic case. It's not the same,
and while I'm trying to fix one occurrence, I'd prefer not to
introduce more.

> and I
> prefer not to change it as part of this work.
>
>> 
>> That said, maybe you can base your patch on top of my checksum fix? For
>> the last packet, it will then be:
>> 
>> if (!skb_is_gso(seg))
>>         newlen = /* the new value */;
>> /* keep newlen as is otherwise: my newlen is your msslen */
>> check = csum16_add(csum16_sub(uh->check, uh->len), newlen);
>> uh->len = newlen;
>> uh->check = check;
>> 
>> [1]: https://lore.kernel.org/netdev/20260512165648.386518-3-alice.kernel@fastmail.im/
>
> As I mentioned in the other thread, this fix goes to net, I can't take
> your patch.

Ah, that's right. Still, I guess you can take mine to net for the
checksum fix.

