Return-Path: <netdev+bounces-265924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCWSNDXWr2kfcgIAu9opvQ
	(envelope-from <netdev+bounces-265924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:28:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B65B247557
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E06F13172C07
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976733EDADD;
	Tue, 10 Mar 2026 08:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvLRhApr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320F43EFD21
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 08:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773131150; cv=none; b=q/NCpACnhhZWbblOLP1QGJq5TQG6B6pehiDRPsdvW7gPI1HwloJ+gOIQw3SBDsPPhEjOznUxUl0PGuhhEwmN6LMeyeh4RG3k02eoBt8B0iNaAPOvqGk4LJvkSwHcrT4Nx5oi10hT4uk0uQxg8H9u/vERKNzMKWc/s85wDyy6nJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773131150; c=relaxed/simple;
	bh=2QCzLp0F2pYx6+dlRlsKBe0b3nFaOmqYmIDT/PUKLd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9R5Qcrpsw9brxzRYRTA9eT+UeUCll05hRRY7WTw+SWmP9P53J7SCc9nZzxzXUZChQz25iwcZOzuNl1E2fbmSHRkl7Hwxx40T0OXpKsCg24q9hIQZqz8ZR8fK7M0ijdCTok5QfZxV4y6dpEB9yUyF6wIkalOWfbQWjfd1VssdQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvLRhApr; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6611e4aefdcso9879689a12.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 01:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773131147; x=1773735947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oly3B87PA63gHRv66eFhTHd4PtYqp9cSgK81C/xTgFU=;
        b=ZvLRhAprredcnxq0ktx/IeNW4ILpm1nZeQiYEnsgEWvkHz3IMvWdVTbJJt97d9nBTm
         98LoiMW+VXShfrcxWRGvGcZZGzE0iBrDQascT32v6DTZYuGgn+3Fg3l1TZRrpwl7D4TJ
         xaasv0PN4RqciBhPbyw7rIi9nBbBS0bs3QSN7MrtA46BcoKRcz+7qUsrzyHQCWjkDpYe
         YZ+GF4rvYl2BsfYWvAvpDu0LG45rl3U60FAHRJQqN23SXRmttlABWmNCB+5NNsvq1iUW
         8cmr+Uk5SwIHu6hv4w5nmtoNxWWi0BeigDZF+3zvQgtRODWb++rAfvxEMbKEkiLZFYDz
         2l2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773131147; x=1773735947;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oly3B87PA63gHRv66eFhTHd4PtYqp9cSgK81C/xTgFU=;
        b=qMpcnfGgrfVH5ih7f/EF9XmW566KD2PEbgn8CQlHlZ+ytwsvG/ZVjqXSeb6PssDx2T
         /iwJMiqH8V5vrLwhmMSf6ik5H/iukUQIs1VN1Yoyx/jn2YiYjJl7LTkyrp2kmrNdNH3d
         uNtnOsqPHg8gLdBtN6hGASelHAGUCDGptwSR6+ZD6SoPr3SB94oCy64Wx4t1Qi2SxaVS
         Ps3hwfzjFfBrXM2ogtny3pu8hfnuOwrHcNfE7S5qehadDUXudiG+5T9eei4rjqRkIevp
         3fsx+w8HTsqjrjR3xJPYMhg5OgnYn7SexwSzaW1vV5bnYmfoYU8ABJqbd8YkK5aKKr/+
         H1UQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKKk2NLlHntZnQRT2zjKQVGNvgr4nfZ8Zk9NbU9m/jI3LgYMNHWyuOk1rjufwyibU9vS2JMcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfOQEGoEyKUtH0/H2KpFyTfoX1L/M2c1cs+Jl9ie47eTcysGSI
	9ydL1bIX6Z6wJNRSCG/pZuml7tjkVRm2ZE0RpFNfz7fUWnwbfHc11GyY
X-Gm-Gg: ATEYQzxSlHGh+AouDevCzzgwL9XaPtYjGXMRzIs2N9xeUe9G7yUzPmKEt0Iy73x7v6k
	QUlG2aGpGuQHpVsku2n5hVKPMFfRO8fAngXmepAdoO9+B078batzqAyf7owHBku6GNjzfY1zkia
	Loislq6n6cA0Xv/fsq163QH73qJhnySoQ/1cYcXPYAjuDTnGZtOdZfhw7Ffiz1ztYv6WwE6pv/9
	5g6WPizqh0crpgRbTWPFMlKmtUpNazpnM8LF/0H6OyDa2anYIQTPIrdfpEkImI5SXDT2Q+sC3Yu
	AoYE7DszO9qTstT2IHDftu7Vq3Cp2lL1f/L+4RjI0yzMRRyDAYlEnHWwKgLWCLu1ohuCJMp7p9t
	+Fy90yLrzMU1AbZrJnT7euwNmUbAyuCX5wIu+e7f0vMB4KIR8APUCYa7qp7MI5aci1RuDZy1wtJ
	QjVTKr89xhP5SVq/22HTiwvbUG5LDMJBzq0doUcPpBqr1wuW4DrIrmr1+KXMeJhL+TklItC7n+p
	F4E+9WvAh4TZJtfICKlSRw1EqeCo+cbc/pTQJJjzqTeVs70wbGo6jmciF9C3cgvQ8fgEC7R57Fg
	H+VcWHM1oOrmq5M2BC5m+OIoQOpMybkKsg==
X-Received: by 2002:a17:907:97d5:b0:b86:e938:1b3a with SMTP id a640c23a62f3a-b942dced156mr805331566b.17.1773131147211;
        Tue, 10 Mar 2026 01:25:47 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942f139e24sm460611466b.38.2026.03.10.01.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 01:25:46 -0700 (PDT)
Message-ID: <5f8c4194-5066-4a55-898f-257bfdce4a6c@gmail.com>
Date: Tue, 10 Mar 2026 09:25:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 nf] netfilter: nf_flow_table_ip: Introduce
 nf_flow_vlan_push()
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260227162955.122471-1-ericwouds@gmail.com>
 <aa86Ai1FRuJzthEF@strlen.de>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <aa86Ai1FRuJzthEF@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3B65B247557
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
	TAGGED_FROM(0.00)[bounces-265924-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 3/9/26 10:22 PM, Florian Westphal wrote:
> Eric Woudstra <ericwouds@gmail.com> wrote:
> 
> Hi Eric
> 
>> With double vlan tagged packets in the fastpath, getting the error:
>>
>> skb_vlan_push got skb with skb->data not at mac header (offset 18)
>>
>> Introduce nf_flow_vlan_push(), that can correctly push the inner vlan
>> in the fastpath. It is closedly modelled on existing nf_flow_pppoe_push()
>>
>> Fixes: c653d5a78f34 ("netfilter: flowtable: inline vlan encapsulation in xmit path")
>> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
>   
>> +static int nf_flow_vlan_push(struct sk_buff *skb, __be16 proto, u16 id)
>> +{
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
>> +	} else {
>> +		__vlan_hwaccel_put_tag(skb, proto, id);
>> +	}
> 
> I did not apply this because I'm not sure if this preserves correct tag
> order.  Can you clarify?
> 
> Lets consider vlan-offload-doesn't-exist case.
> 
> First loop pushes vlan tag 1, we get:
> 
>   [vlan1][inet]

Always !skb_vlan_tag_present (all vlan tags are pulled before the push
in the fastpath), so vlan1 is always stored in skb->vlan_all.

> 
> 2nd items pushes vlan tag 2, we get:
>   [vlan2][vlan1][inet]
> 

The second is pushed directly [vlan2][inet]. At a later moment the
contents of skb->vlan_all is pushed by SW. Ending up with
[vlan1][vlan2][inet].

> Now lets consider with-offload.  We have one tag only, so we get 1 skb with hwaccel
> tag in the sk_buff.  This is fine, HW will insert it for us.
> 
> But now lets consider two tags:
> 
> First loop pushes vlan1, we get the vlan1 tag in sk_buff vlan info.
> Packet is: [inet].

Correct, so same as SW, vlan1 in skb->vlan_all.

> 
> 2nd loop pushes vlan2, we get:
> 	[vlan2][inet].
> 

Correct, [vlan2][inet].

> Now, when packet is transmitted, where will the HW insert the tag?
> 
> [vlan1][vlan2][inet]?
> Or will this be [vlan2][vlan1][inet]?

The contents of skb->vlan_all is pushed by HW. Ending up with
[vlan1][vlan2][inet], same as SW.

Hope this is enough to clarify, but you can double-check it looking at
nf_flow_tuple_encap(). With 2 vlan tags, the contents of skb->vlan_all,
is always vlan1, the first in the encap array, which is the outer tag.

> reading though the SW-side (no hw support), it seems it will do the right
> thing (i.e.. the hw tag gets added as the inner tag, right before inet
> and not added as outermost tag.
> 
> Can you confirm thats the case?
> 
> Sorry for not responding sooner, there are lots of patches atm and
> I forgot about this one when I yanked it off the previous pull request
> at the last second.



