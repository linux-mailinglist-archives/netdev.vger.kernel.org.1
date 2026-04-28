Return-Path: <netdev+bounces-281590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id caAPNpQW8GmCOQEAu9opvQ
	(envelope-from <netdev+bounces-281590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 04:08:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E7F47C9D7
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 04:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D60CF300CBFE
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335F72DEA8F;
	Tue, 28 Apr 2026 02:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mrg1wLtA"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581CC70830
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 02:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777342097; cv=none; b=abOR5h/0vY/p753qRU9idIdRmE5jRBXcaFrsiCMteszZ4j/SkHAeA0pki2s+gdc3qym4I7YuAT4FLVIhubrlpxXB41ecCJb54kpxGr/hNKiVLgKnkNWFMrtUmdH1vQvZ9nNInDMNq/LlPLNNDep0dJhlgRfiNJ+/uepUMorPUAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777342097; c=relaxed/simple;
	bh=5fweW2NW0Gar4b/duUKwxUCucTy5E5pmuqgkgyQ1cc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6AQGDRkzLgfbb8zg8ZsJePo8jCmrKg38OOLDhyGfV3xbFbvNs/+AQEWDqC9vhOdrsrlyLdDjjOdNeNp7qdoS2eqHDwZLMofoNRzIqtsc+TyZslJIzGkXcBlKc/0lccmQWQXo8KbaOL2cBu6U4ysbzUsl5DikGUgAYrKR7tODVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mrg1wLtA; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <501fb5d6-3247-40aa-aaa5-ce9dacb17255@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777342089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3XE8CatXrYTF+194303j/a2miQCVsg0bLQkFRF29ixA=;
	b=mrg1wLtAmpzJZCskWXqUIGZsGlEpDpI272zAeY/R4wE+KjjS9jzo//8KzLlYbEEVgRUAoA
	AcQBa+M6hgQYqIiHvUS5xAG8bDH0ebyeZCIDdZBjaPOBFqvUyuSxJR87eootXrI6g55oKB
	+r9PGJx8iZwyOqWs/mc4n68uaTxyVvY=
Date: Tue, 28 Apr 2026 10:08:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH ovpn-net-next] ovpn: reset MAC header
 before passing skb up
To: Antonio Quartulli <a@unstable.cc>, openvpn-devel@lists.sourceforge.net
Cc: Minqiang Chen <ptpt52@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org
References: <20260427040011.2107748-1-qingfang.deng@linux.dev>
 <101221c8-8e47-4fc1-9791-2ef3a0ae8312@unstable.cc>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <101221c8-8e47-4fc1-9791-2ef3a0ae8312@unstable.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: A4E7F47C9D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281590-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qingfang.deng@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]

Hi,

On 2026/4/27 17:45, Antonio Quartulli wrote:
> Hi Qingfang,
>
> thanks for the patch!
>
> On 27/04/2026 06:00, Qingfang Deng wrote:
>> After decapsulating a packet, the skb->mac_header still points to the
>> outer transport header. Call skb_reset_mac_header() in
>> ovpn_netdev_write() to ensure the MAC header points to the beginning of
>> the inner IP packet.
>
> May you elaborate on what this is exactly fixing?
> Did you encounter a bug triggered by this missing line?
>
> I am asking because I wonder what is "expected" as MAC header for a 
> packet not having one at all (packets delivered to the ovpn interface 
> are L3 only, as per the interface type itself).

For L3-only devices, the net core expects skb->mac_header == 
skb->network_header.

For example, in __netif_receive_skb_core(), skb_reset_mac_len() sets 
skb->mac_len to (skb->network_header - skb->mac_header).
If skb->mac_header still has a stale value, this will incorrectly assign 
a non-zero value to skb->mac_len.

Also, if generic XDP or SOCK_PACKET is used, either will do
   skb_push(skb, skb->data - skb_mac_header(skb));

>
> Thanks!
>
> Regards,
>
>>
>> Reported-by: Minqiang Chen <ptpt52@gmail.com>
>> Fixes: 8534731dbf2d ("ovpn: implement packet processing")
>> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
>> ---
>>   drivers/net/ovpn/io.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
>> index db43a1f8a07a..d92bb87be2b2 100644
>> --- a/drivers/net/ovpn/io.c
>> +++ b/drivers/net/ovpn/io.c
>> @@ -85,6 +85,7 @@ static void ovpn_netdev_write(struct ovpn_peer 
>> *peer, struct sk_buff *skb)
>>       skb_scrub_packet(skb, true);
>>         /* network header reset in ovpn_decrypt_post() */
>> +    skb_reset_mac_header(skb);
>>       skb_reset_transport_header(skb);
>>       skb_reset_inner_headers(skb);
>
+Cc: netdev

Regards,

Qingfang


