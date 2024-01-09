Return-Path: <netdev+bounces-62661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4C7828626
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 13:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39F71C23A0C
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 12:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D46381BB;
	Tue,  9 Jan 2024 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="d6F9gXLc"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC166364A8
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=P8P2DPgcLIs1U0Ms4I4IOad60OlN5Zw/f7uZrNzp17c=; b=d6F9gXLcIp/A9b2OInYY+STCUJ
	DhVySTirAi9Ghp7ntbUb/p6JkZOjNUbSIKc5qoR8DirJRnBi4U1lv8kAnBnesBne7kOD296R3cu71
	OCHTZnSGAT6SkJgWDtRho27DEjvxL9wRjhccL3A2l1+x6WE6QTQ0FrM6wAENS5BFPn+E=;
Received: from p4ff13178.dip0.t-ipconnect.de ([79.241.49.120] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rNBQS-002S2B-6e; Tue, 09 Jan 2024 13:41:48 +0100
Message-ID: <bdb86076-d4ce-49b3-8ceb-742f61f05559@nbd.name>
Date: Tue, 9 Jan 2024 13:41:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: bridge: do not send arp replies if src and
 target hw addr is the same
Content-Language: en-US
To: Nikolay Aleksandrov <razor@blackwall.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20240104142501.81092-1-nbd@nbd.name>
 <6b43ec63a2bbb91e78f7ea7954f6d5148a33df00.camel@redhat.com>
 <e5d1e7da-0b90-45d7-b7ab-75ce2ef79208@nbd.name>
 <2b3bbe3a-6796-458c-88f9-1458a449d79c@blackwall.org>
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
In-Reply-To: <2b3bbe3a-6796-458c-88f9-1458a449d79c@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.01.24 13:02, Nikolay Aleksandrov wrote:
> On 09/01/2024 13:58, Felix Fietkau wrote:
>> On 09.01.24 12:36, Paolo Abeni wrote:
>>> On Thu, 2024-01-04 at 15:25 +0100, Felix Fietkau wrote:
>>>> There are broken devices in the wild that handle duplicate IP address
>>>> detection by sending out ARP requests for the IP that they received from a
>>>> DHCP server and refuse the address if they get a reply.
>>>> When proxyarp is enabled, they would go into a loop of requesting an address
>>>> and then NAKing it again.
>>>
>>> Can you instead provide the same functionality with some nft/tc
>>> ingress/ebpf filter?
>>>
>>> I feel uneasy to hard code this kind of policy, even if it looks
>>> sensible. I suspect it could break some other currently working weird
>>> device behavior.
>>>
>>> Otherwise it could be nice provide some arpfilter flag to
>>> enable/disable this kind filtering.
>> 
>> I don't see how it could break anything, because it wouldn't suppress non-proxied responses. nft/arpfilter is just too expensive, and I don't think it makes sense to force the use of tc filters to suppress nonsensical responses generated by the bridge layer.
>> 
>> - Felix
>> 
> 
> I also share Paolo's concerns, and I don't think such specific policy
> should be hardcoded in the bridge. It can already be achieved via tc/nft/ebpf
> as mentioned. Also please CC bridge maintainers for bridge patches, I saw this
> one because of Paolo's earlier reply.

Why is this 'specific policy'? I'm not changing the bridge to filter 
quirky ARP responses generated elsewhere. I'm simply changing the bridge 
code to avoid generating nonsensical ARP responses by itself.

Also, I can't replicate the exact behavior with a nft/tc filter, because 
a filter can't differentiate between forwarded ARP responses and bogus 
fake responses generated by the bridge code itself.

The concern regarding breaking existing devices also makes no sense to 
me at all. From my perspective, proxyarp is an optimization that you 
should be able to turn on without breaking breaking existing devices.
The fact that the current code violates that expectation is something 
I'm trying to fix.

- Felix

