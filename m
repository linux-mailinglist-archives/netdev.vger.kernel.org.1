Return-Path: <netdev+bounces-285138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEEYNcgI/Gm3KAAAu9opvQ
	(envelope-from <netdev+bounces-285138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 05:36:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D99724E2AB6
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 05:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB032300514E
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 03:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6342DC792;
	Thu,  7 May 2026 03:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P4gzZask"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A662D9ED1
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 03:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778124995; cv=none; b=ltKIGYBWBD4Usv5s/I4tISajar7NP/68pD59UtGcpFOUJ6b2cy4enpAONYRCLNSXgWk/sN+STtoRH4B7f5nTqW2BfaT+DyM9HbzcQVZyoECTC3V57BDXlSUwyn41Onjyvu1/Qws10xszTn+tMBz0tWG7/Zx1SVRfMgS8l3opOoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778124995; c=relaxed/simple;
	bh=GBppuMyDcFUH6AcO/8jCDVx0V066lCT1uU4JkvVwwpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OfesOWiNUUaSVqcQvxc5drx80eF9SBSpGMykmk7XL2fUaA/F72aAUlaVraP3ohDOKPc2pcPXfNDf7sI2sL4uVOsKbfnF5jKGTrBmWtJf1Br2qfgbbnXz2o382ya/yPHDG6NG+ykd7n2+iS0YzXNtuwBrHTIsj7YY5r2RM+lkL5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P4gzZask; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <63cb7820-bea0-446a-928d-c37597f5506a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778124981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3iJ5c6RrR/ATLy0Lin604yvTNl5sBXww4Jltc9j1SY=;
	b=P4gzZaskJFsuEukboSKaeQqBmP8YdqOOVn4oWOQCBRYwUs3h/qDPEryWmdz2HjYS5tqiSq
	dORwBIJsjjidNCnMYyMNkBHEYkm/B2rwq7ZeT6Mksol/jTxyApBJK0E4jOiLyb0+UDqN+E
	qoF3Kh+fUwW//SyVBlE+1bZDxFUmtcY=
Date: Thu, 7 May 2026 11:36:11 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v8 1/2] net: pppoe: implement GRO/GSO support
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, willemb@google.com,
 petrm@nvidia.com, anubhavsinggh@google.com, richardbgobert@gmail.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org,
 Pablo Neira Ayuso <pablo@netfilter.org>
References: <20260501035102.293031-1-qingfang.deng@linux.dev>
 <20260506121401.651540-1-horms@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20260506121401.651540-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: D99724E2AB6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285138-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,gmail.com,vger.kernel.org,netfilter.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qingfang.deng@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 2026/5/6 20:14, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> net: pppoe: implement GRO/GSO support
>
> This commit adds GRO and GSO support for PPPoE, which improves rx throughput
> significantly by handling packets where the pppoe header length field matches
> the exact packet length.
>
>> diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
>> index bdd61c504a1c4..363204e0c49a1 100644
>> --- a/drivers/net/ppp/pppoe.c
>> +++ b/drivers/net/ppp/pppoe.c
> [ ... ]
>> @@ -1103,6 +1104,164 @@ static struct pernet_operations pppoe_net_ops = {
>>   	.size = sizeof(struct pppoe_net),
>>   };
>>   
>> +static u16
>> +compare_pppoe_header(const struct pppoe_hdr *phdr,
>> +		     const struct pppoe_hdr *phdr2)
>> +{
>> +	__be16 proto = *(const __be16 *)(phdr + 1);
> Because struct pppoe_hdr is packed, the compiler assigns it 1-byte alignment
> semantics, which phdr + 1 inherits.
>
> Does explicitly casting this to __be16 * bypass the compiler's unaligned access
> protections?
>
> If skb->data has an odd alignment from the NIC, this could trigger a fatal
> unaligned memory access exception on strict-alignment architectures. Would it
> be safer to use get_unaligned() here?
You can disregard all the alignment warnings. On those architectures, 
drivers are required to 4-byte align the network header, so the PPPoE 
header will also be aligned.
>> +	__be16 proto2 = *(const __be16 *)(phdr2 + 1);
>> +
>> +	return (__force u16)((phdr->sid ^ phdr2->sid) | (proto ^ proto2));
>> +}
>> +
>> +static __be16 pppoe_hdr_proto(const struct pppoe_hdr *phdr)
>> +{
>> +	__be16 proto = *(const __be16 *)(phdr + 1);
> Could this also result in an unaligned access regression for the same reason?
>
> [ ... ]
>> +static struct sk_buff *pppoe_gro_receive(struct list_head *head,
>> +					 struct sk_buff *skb)
>> +{
> [ ... ]
>> +	off_pppoe = skb_gro_offset(skb);
>> +	hlen = off_pppoe + PPPOE_SES_HLEN;
>> +	phdr = skb_gro_header(skb, hlen, off_pppoe);
>> +	if (unlikely(!phdr))
>> +		goto out;
>> +
>> +	/* filter for session packets (type:1, ver:1, code:0) */
>> +	if (*(const __be16 *)phdr != cpu_to_be16(0x1100))
> Is it possible this cast could similarly trigger an unaligned access exception
> if the header offset is oddly aligned?
>
> [ ... ]
>> +static struct sk_buff *pppoe_gso_segment(struct sk_buff *skb,
>> +					 netdev_features_t features)
>> +{
> [ ... ]
>> +	segs = ptype->callbacks.gso_segment(skb, features);
>> +	if (IS_ERR_OR_NULL(segs)) {
>> +		skb_gso_error_unwind(skb, orig_type, PPPOE_SES_HLEN, mac_offset,
>> +				     mac_len);
> If the inner protocol's gso_segment callback returns NULL (indicating the
> hardware can natively offload the segmentation), skb_gso_error_unwind() will
> be called.
>
> skb_gso_error_unwind() unconditionally sets skb->encapsulation = 1. However,
> PPPoE does not configure the inner header offsets (such as
> skb->inner_network_header).
>
> When the driver sees skb->encapsulation == 1, could it attempt to read the
> uninitialized inner header offsets, parsing the outer MAC header as an inner
> IP header and misprogramming the hardware TSO context?
>
> Does PPPoE need to explicitly clear TSO features before calling the inner
> segmentation to force software segmentation, avoiding the need for
> skb_gso_error_unwind() here entirely?

I'm not sure how to test this. Is this what happens when the underlying 
interface supports TSO?

+Cc: Pablo


