Return-Path: <netdev+bounces-214113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E15B284F5
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 19:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 192FF7AF020
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 17:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F061830F53E;
	Fri, 15 Aug 2025 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="tl0fKRfu"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763DD30F536;
	Fri, 15 Aug 2025 17:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278709; cv=none; b=Jo4OcqYsndHgYO2MnPeTHkGTezT+yChHfajYncT8uiY5P05/60Qdq14exRQG+D8i048fa137owVpIZQp/iTNWc7OZM6SdfIt2L8v+RcCUsRDjtQMXm2lAyOZvTN+BNzluqIT7Moy7cLayya3ov8pgs+FtXhL59I9kPOqBzNDSIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278709; c=relaxed/simple;
	bh=/Uq5nHzyCp4ifNvMc2aSK531zFYLl9+b0x8C2WeEEFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rtu0glUn8f1xdTPHYRxNrmBC6VLSpx3SeZruDCtBjFpfvLio7BjcD+arWH8yW6Zp+1u/LkSRsXI1Sp4TrdVvJZAhddmYGIApUwwTmr2slZFQSIMR4h4DR8nIqp+rA1+WYyDdRP65YseUmO9lCQsvVNNEjN6Ba75/g2LDwPGTfKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=tl0fKRfu; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dGI/zCv2AeLu5VmhRAiKhwTNH7o0y5iVz6VXoEWKtbM=; b=tl0fKRfusOTSdZW3QCF1+MneNN
	/ZRxIii6lhytj4zuwZi0IRCgO5nbwSKDGFOSxsAcy6AJpqLfZ9Y0vCpeQ8JFNBHnoK2f0nwW9VqWx
	GC9MHsV2HoX9gW7HlWQdaFse1SMVmhRY1BlaTObtlywNYj4AY8mlH4tK+9EJzC7XqxBQ=;
Received: from p5b206816.dip0.t-ipconnect.de ([91.32.104.22] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1umyAe-00B2sT-0X;
	Fri, 15 Aug 2025 19:24:52 +0200
Message-ID: <b5bd82bb-b625-4824-9d45-4d1f41c100ad@nbd.name>
Date: Fri, 15 Aug 2025 19:24:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: pppoe: implement GRO/GSO support
To: Richard Gobert <richardbgobert@gmail.com>, netdev@vger.kernel.org,
 Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <20250811095734.71019-1-nbd@nbd.name>
 <68be885c-f3ea-48aa-91c9-673f9c67fe28@gmail.com>
Content-Language: en-US
From: Felix Fietkau <nbd@nbd.name>
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <68be885c-f3ea-48aa-91c9-673f9c67fe28@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.08.25 16:30, Richard Gobert wrote:
> Felix Fietkau wrote:
>> Only handles packets where the pppoe header length field matches the exact
>> packet length. Significantly improves rx throughput.
>> 
>> When running NAT traffic through a MediaTek MT7621 devices from a host
>> behind PPPoE to a host directly connected via ethernet, the TCP throughput
>> that the device is able to handle improves from ~130 Mbit/s to ~630 Mbit/s,
>> using fraglist GRO.
>> 
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>> v2: fix compile error
>> v3:
>>   - increase priority value
>>   - implement GSO support
>>   - use INDIRECT_CALL_INET
>>   - update pppoe length field
>>   - remove unnecessary network_offsets update
>> 
>>  drivers/net/ppp/pppoe.c | 160 +++++++++++++++++++++++++++++++++++++++-
>>  net/ipv4/af_inet.c      |   2 +
>>  net/ipv6/ip6_offload.c  |   2 +
>>  3 files changed, 163 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
>> index 410effa42ade..a8d8eb870bce 100644
>> --- a/drivers/net/ppp/pppoe.c
>> +++ b/drivers/net/ppp/pppoe.c
>> +compare_pppoe_header(struct pppoe_hdr *phdr, struct pppoe_hdr *phdr2)
>> +{
>> +	return (__force __u16)((phdr->sid ^ phdr2->sid) |
>> +			       (phdr->tag[0].tag_type ^ phdr2->tag[0].tag_type));
>> +}
>> +
>> +static __be16 pppoe_hdr_proto(struct pppoe_hdr *phdr)
>> +{
>> +	switch (phdr->tag[0].tag_type) {
>> +	case cpu_to_be16(PPP_IP):
>> +		return cpu_to_be16(ETH_P_IP);
>> +	case cpu_to_be16(PPP_IPV6):
>> +		return cpu_to_be16(ETH_P_IPV6);
>> +	default:
>> +		return 0;
>> +	}
>> +
>> +}
>> +
>> +static struct sk_buff *pppoe_gro_receive(struct list_head *head,
>> +					 struct sk_buff *skb)
>> +{
>> +	const struct packet_offload *ptype;
>> +	unsigned int hlen, off_pppoe;
>> +	struct sk_buff *pp = NULL;
>> +	struct pppoe_hdr *phdr;
>> +	struct sk_buff *p;
>> +	int flush = 1;
>> +	__be16 type;
>> +
>> +	off_pppoe = skb_gro_offset(skb);
>> +	hlen = off_pppoe + sizeof(*phdr);
>> +	phdr = skb_gro_header(skb, hlen + 2, off_pppoe);
>> +	if (unlikely(!phdr))
>> +		goto out;
>> +
>> +	/* ignore packets with padding or invalid length */
>> +	if (skb_gro_len(skb) != be16_to_cpu(phdr->length) + hlen)
>> +		goto out;
>> +
>> +	type = pppoe_hdr_proto(phdr);
>> +	if (!type)
>> +		goto out;
>> +
>> +	ptype = gro_find_receive_by_type(type);
>> +	if (!ptype)
>> +		goto out;
>> +
>> +	flush = 0;
>> +
>> +	list_for_each_entry(p, head, list) {
>> +		struct pppoe_hdr *phdr2;
>> +
>> +		if (!NAPI_GRO_CB(p)->same_flow)
>> +			continue;
>> +
>> +		phdr2 = (struct pppoe_hdr *)(p->data + off_pppoe);
>> +		if (compare_pppoe_header(phdr, phdr2))
>> +			NAPI_GRO_CB(p)->same_flow = 0;
>> +	}
>> +
>> +	skb_gro_pull(skb, sizeof(*phdr) + 2);
>> +	skb_gro_postpull_rcsum(skb, phdr, sizeof(*phdr) + 2);
>> +
>> +	pp = indirect_call_gro_receive_inet(ptype->callbacks.gro_receive,
>> +					    ipv6_gro_receive, inet_gro_receive,
>> +					    head, skb);
>> +
>> +out:
>> +	skb_gro_flush_final(skb, pp, flush);
>> +
>> +	return pp;
>> +}
>> +
>> +static int pppoe_gro_complete(struct sk_buff *skb, int nhoff)
>> +{
>> +	struct pppoe_hdr *phdr = (struct pppoe_hdr *)(skb->data + nhoff);
>> +	__be16 type = pppoe_hdr_proto(phdr);
>> +	struct packet_offload *ptype;
>> +	int len, err;
>> +
>> +	ptype = gro_find_complete_by_type(type);
>> +	if (!ptype)
>> +		return -ENOENT;
>> +
>> +	err = INDIRECT_CALL_INET(ptype->callbacks.gro_complete,
>> +				 ipv6_gro_complete, inet_gro_complete,
>> +				 skb, nhoff + sizeof(*phdr) + 2);
>> +	if (err)
>> +		return err;
>> +
>> +	len = skb->len - (nhoff + sizeof(*phdr));
>> +	phdr->length = cpu_to_be16(len);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct sk_buff *pppoe_gso_segment(struct sk_buff *skb,
>> +					 netdev_features_t features)
>> +{
> 
> I don't think this will be called for PPPoE over GRE packets,
> since gre_gso_segment skips everything up to the network header.

What's a good solution to this issue? Use the outer network header 
instead of the inner one when the protocol is PPPoE?

- Felix

