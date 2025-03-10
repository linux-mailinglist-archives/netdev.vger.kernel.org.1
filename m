Return-Path: <netdev+bounces-173562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1276EA59779
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 15:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A85316B95D
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 14:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268F922CBD7;
	Mon, 10 Mar 2025 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="nOUIoAAK"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2BD22CBE9;
	Mon, 10 Mar 2025 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616512; cv=none; b=I1fnPt1mAtQaAPEkBW8hskb8eoO4rkOmYiEsyOCXu0xnbZR/ViLeCJMP59+SZ/AZxRxubIUBKucOBlfe+Nq2EeACtS7h75YOoTVDsMn+oty96df82UTNplXhSud/3f25fmBVDmPbW5k0cteJTJDbSypcBOGH6Ep44oXsb+ity8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616512; c=relaxed/simple;
	bh=XZpH1ZbB7QcjTFHcyjtmymxC7cCksLt7cIepXMJrfS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PhoTze/xXqDuokwgRqJ9Nr/LwcpZrUndAOvj4YDmYSppfL1kvapDuq5djKvCZKsW3KGNuoxNuzXmwbHotZql5Igu2kZ2DizabB+uNAFCoFYUqpf5tHZNOXpcwKpcQ1XPPKExIvLco8U766jwYIrReQ9zawFVDV7Pb+nGfQUqPwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=nOUIoAAK; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GYXNgGCnhPv7UBjij+Y5EEiscfgCiwjGov9xdF6uGsc=; b=nOUIoAAKTM+16vBVyvqk8kBgPx
	0LZ3QeomLLVaOjvGw5xF954rXOp/wD6vasDb8fsD9X+xpyuDf3loKOSnZM9wNBsB6ALoJbsgdkt2Y
	T+l60wBSu91hGBcZzBA8+/26ky98Oy+ieH+3cj/f2N0AAUNt9TSF+1mNF9t7RhbGXM4I=;
Received: from [2a01:599:100:bcaa:ed1e:6906:5476:d0ad] (helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tre0i-00FfPu-24;
	Mon, 10 Mar 2025 15:21:40 +0100
Message-ID: <23698682-9e31-42a9-8346-fab7738f79c5@nbd.name>
Date: Mon, 10 Mar 2025 15:21:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ipv6: fix TCP GSO segmentation with NAT
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 linux-kernel@vger.kernel.org
References: <20250310112121.73654-1-nbd@nbd.name>
 <CANn89i+tX02HsfcGx1g5fdg9N4Cx=FNDk886KNPqsiem7rPcJA@mail.gmail.com>
From: Felix Fietkau <nbd@nbd.name>
Content-Language: en-US
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
In-Reply-To: <CANn89i+tX02HsfcGx1g5fdg9N4Cx=FNDk886KNPqsiem7rPcJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.03.25 14:50, Eric Dumazet wrote:
> On Mon, Mar 10, 2025 at 12:21 PM Felix Fietkau <nbd@nbd.name> wrote:
>>
>> When updating the source/destination address, the TCP/UDP checksum needs to
>> be updated as well.
>>
>> Fixes: bee88cd5bd83 ("net: add support for segmenting TCP fraglist GSO packets")
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>> v2: move code to make it similar to __tcpv4_gso_segment_list_csum
>>
>>  net/ipv6/tcpv6_offload.c | 18 ++++++++++++++----
>>  1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
>> index a45bf17cb2a1..34dd0cee3ba6 100644
>> --- a/net/ipv6/tcpv6_offload.c
>> +++ b/net/ipv6/tcpv6_offload.c
>> @@ -94,10 +94,20 @@ INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int thoff)
>>  }
>>
>>  static void __tcpv6_gso_segment_csum(struct sk_buff *seg,
>> +                                    struct in6_addr *oldip,
>> +                                    const struct in6_addr *newip,
>>                                      __be16 *oldport, __be16 newport)
>>  {
>>         struct tcphdr *th;
>>
>> +       if (!ipv6_addr_equal(oldip, newip)) {
>> +               inet_proto_csum_replace16(&th->check, seg,
> 
> th is not initialized yet.

Sorry, I had this fixed locally, but forgot to add it before sending. 
Will send v3 later.

- Felix

