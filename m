Return-Path: <netdev+bounces-259909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEImEf5km2k2zAMAu9opvQ
	(envelope-from <netdev+bounces-259909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 21:20:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 920C61704A3
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 21:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DC03300C59C
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 20:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8D335BDCB;
	Sun, 22 Feb 2026 20:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Im5+F6P9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D726E1DE4EF
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771791610; cv=none; b=Ad0TKuLfl2AFyU/AsbDcJ1D1EUl96imVKByS71NBa38F6vJIz7QsPdtLJEldGw/qdQFmBr9fxyzy5XiUNZqlQHRGnCsiW9AqR1VvxqALjWAt0mOlpHfDksOB6+vVaImQRI7NLyJAFGPrszsv4zr8U67m3+WQRGkm7bUj0WGE3kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771791610; c=relaxed/simple;
	bh=AvPUejLylMe6jxtFjp+4uu3x6b6UYh1yyZKXO4RB18g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMYLhwnfn7FO1oUC0zh30OvUtjAxA0S8He2xeLLvhIbJuxMBheXEgEdiXIIVBrHaPL7qtTmQpdgB2CvEdnsJj53ktwjf7XX2epUP1AC4yqgt9+vrU8YBOMgqGuUsrSFKy7WIOE8NB9NMHe5jM20D+hI0NQkThz8QK63dKrhnDtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Im5+F6P9; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8fd976e90cso495037066b.0
        for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 12:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771791606; x=1772396406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ziqVjObozmBP/YMpMD3gIg2L0bYhVbhRy21Cs0R6NM4=;
        b=Im5+F6P9mQnTRX6lgEV7pYRTS5FxSC6LH2GxXTbY553unxaWlpMZBCn2C9nS44M79U
         wFouC2OvIKcB+qoSmWZjCHB4lVDpZBV5rmOKrQiOY9a+CvfnWIVuGg8QFisW7/j1nNQz
         NFWHJARiDrDLEEwQC/yhoDp+Ge1o1mskdSA+HcEf6/Ru3pwMxXcr2I+5pVQcrKb6OAet
         /sWAm7oaslecI06aHwmptjaf5IXnKGbFiw6Nt6PH5C2p0uYZGJTpKNG6JLlYqK3SU+wb
         XghlSwLBaN3FVELPBxv6l6HBUWqR/kgeEtSJ/R7pNhC0SxgeCTulRAIlJoAwxw8qnv66
         Qn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771791606; x=1772396406;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ziqVjObozmBP/YMpMD3gIg2L0bYhVbhRy21Cs0R6NM4=;
        b=wRLtPDey/vK4ot8p+aX6VPczkY3AoDlrUHlT8oLZx2Z+qwAgw7cHzfABy0E8+PmaOa
         dQHuoybrK1VXbxOYkhUdsWouogrbHVT/jxGXKiwZYP8cgdEh2H8CJeEPWkoDTMhBADZ2
         v8PbDdNm/94RYS2wPfH6s9PvTb5N4sXVZRl2UlNh406eRUG1h/rO3quAlXjKEicO0Bhi
         4VpGQMHrUw5NNxirUvuHHwGdFzvljCulfzwSEY6jjz+8Ut5kQOzi2uKdK55CAqicNA/G
         wFqlIdWHfisEUJkGFksQAOvu8xI69JS+FMIm3MuSUcXzXVu39kEJssMnr6YP3mWZEYu1
         8UCw==
X-Forwarded-Encrypted: i=1; AJvYcCViq/tBbUXri+HiiRnxKiCBqx2FJwtvvXo4DlPCKyLXdaxVLNE7CYSQQD0HQ6LR9Qjy8B59+00=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIL16hDgkiEIHIltcZicWCOiv7fqmoo6iPjhkRG2NiLI6eYnqM
	BFmhheU5XFjzUHwTuiPMafsO+gqSrm2UoVsVptc3XwjI8BLGnth/tQM/
X-Gm-Gg: AZuq6aJznzcys/xJWmd7T5Q2boSzQr1VDppHTl6+GgxG7Ct/KHzgt0Ai1Yhe6Dbkuft
	t3HjF4OuHP7dBUVFNQJRRBqRXMiqDkhPUPuC35yYq8J/F2TXazaA8/o8rPqdf44SAUsboEAj+Mo
	JvK+Xbb0qnTcd33iiY1IDW0LnIRJi2DFTwje+6BHlqN5IV18rHwCSBtwWz1XT5e0a596ucrr0L/
	TLkKhT8X0o1fGlhHg19ibOBDznpu+8y+apU17u0AdkhHhy/4gOElbJDp1wQ0azUUAf3SF2iRGij
	PyHmV8vA0U715+jKuW9y+a5Ga6T2ZteWKDsd55Y4MxB5/+bh3sjrtZH7suve0+N/vG1A38GAt6N
	JO+8r/qd/scOjrY+esgdNlwHuCJy/6TurA8Vw2HxsiDeA/r8sVvx3GYzaNZYdO/DNYot5quTBSz
	eLy6VAmRLvKMugxHOxyiEpMgozHwYLWk87tXDhwWu01rXrkO6QNN19Q9grJO9QDPzGwAgZSmdJm
	A211D+ykpMmsvFAB6vXvCpT/1iUUrKVE0NzLQox1Z5AVOX2gWS112ooxlorobGpTARiXQrKLv1E
	g3hNTOve4k0CGMbFwRT8NT/R7ueuUr7Clg==
X-Received: by 2002:a17:907:3d4b:b0:b8f:e43d:d5fe with SMTP id a640c23a62f3a-b9081a0cbc8mr417794866b.20.1771791605886;
        Sun, 22 Feb 2026 12:20:05 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65eab9ac4acsm1892737a12.14.2026.02.22.12.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 12:20:04 -0800 (PST)
Message-ID: <a4af5ff8-7aff-454d-8990-2922f1b9bbf3@gmail.com>
Date: Sun, 22 Feb 2026 21:20:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 nf-next] netfilter: nf_flow_table_ip: Introduce
 nf_flow_vlan_push()
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260222155251.76886-1-ericwouds@gmail.com>
 <aZs8atSEZTjkzzQ3@strlen.de>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <aZs8atSEZTjkzzQ3@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-259909-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 920C61704A3
X-Rspamd-Action: no action



On 2/22/26 6:27 PM, Florian Westphal wrote:
> Eric Woudstra <ericwouds@gmail.com> wrote:
>> With double vlan tagged packets in the fastpath, getting the error:
>>
>> skb_vlan_push got skb with skb->data not at mac header (offset 18)
>>
>> Introduce nf_flow_vlan_push, that can push the inner vlan in the
>> fastpath.
>>
>> Fixes: c653d5a78f34 ("netfilter: flowtable: inline vlan encapsulation in xmit path")
> 
> This change is in net/nf tree, so why are you targetting nf-next?
> Are you proposing a revert for nf?  If so, please first send a revert
> for nf.
> 
> Is there a test case for this that demonstrages the breakage?
> 
> And why is this tagged as RFC, what is the problem with this patch?
> 

I have run into this, when testing my branch for implementing the
bridge-fastpath, not in the forward-fastpath. But anyway, no matter how
packets are handled in the original path (forwarding or bridged), once
going through the fastpath it would not matter, so it is broken in any
fastpath.

I have the complete testcase for bridge-fastpath here:

https://github.com/ericwoud/linux/commits/bpir-nftflow-nf-next

I do not have a ready to use testcase in the forward-fastpath, but is is
clearly broken. So this is why I started with an RFC first.

>> +	if (skb_vlan_tag_present(skb)) {
>> +		struct vlan_hdr *vhdr;
>> +
>> +		if (skb_cow_head(skb, VLAN_HLEN))
>> +			return -1;
>> +
>> +		__skb_push(skb, VLAN_HLEN);
>> +		skb_reset_network_header(skb);
>> +
>> +		vhdr = (struct vlan_hdr *)(skb->data);
>> +		vhdr->h_vlan_TCI = htons(id);
>> +		vhdr->h_vlan_encapsulated_proto = skb->protocol;
>> +		skb->protocol = proto;
> 
> Ok, I see, this opencodes a variant of skb_vlan_push().
> Would it be possible to correct skb->data so it points to the mac header
> temporarily?  skb->data always points to network header so this cannot
> have worked, ever.

The code here for the inner header is an almost exact copy of
nf_flow_pppoe_push(), which was also implemented at the same time.
So handling pppoe and inner-vlan header is implemented in the same
manner, which keeps it simple and uniform. If one functions
(in)correctly, then so would the other.

I've been implementing handling the inner vlan header like this for a
half year now. My version of nf_flow_encap_push() was a bit different,
but after this patch it is quite similar.


