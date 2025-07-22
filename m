Return-Path: <netdev+bounces-209005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E69D9B0DFB7
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12B6E7B70CF
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D1C2E2667;
	Tue, 22 Jul 2025 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="XQA9YfLw"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DB92EBDC3;
	Tue, 22 Jul 2025 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196197; cv=none; b=hrInvEu0teLsXIGhLzyR/pvGqZ3BVIybFfFzQWMEPfHfZIGyB9ROnX+5Mfve5kKA65QTeB2L94zHvMhZbq8KvQE5fEo1EMQFy80OEfFX9e3WgzUQMrig9NToITA5JuRR+211a4e7oAUaaitFEor8hyk6f4JisJhD7NTTRRlX3XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196197; c=relaxed/simple;
	bh=nyOCIRsk7cHuWx7Mr65MokWumesb6obxAJCtEisKfiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uIVfAMy9sLMG0c9qzUYPY4aGWemzmWwm298o8+q4g1B2k8qwsaIzaxcU6mFQghKrbQnv5fCuqKHhwXEZqDlqpM2hQ1amgQJPLnihdZMixzGrUV6TdOY7T94JrZWT9VUuyzx54nP8ROIPn8gOGfrcP8I0aCEvopxnHIsuaZqFxkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=XQA9YfLw; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3sUNkmwxLGiEvzprnrdV3XYHqqaQvavIxb9/5p2P1Tw=; b=XQA9YfLwm6Sdg+GalXlPMS9yJM
	FCJT1dxrIiwPKf34mkeDREy/onjWhA6ahU7P1OE+QqOcx5XBnIEkvHyz4fkdkN+qTDW7fqrz61yBj
	rj5nQ748xR5WxKlQ1zazxto8TALf+3LQ9wQysgmb1Y69oMEfNVr62+6VHYIb7P2oX2hc=;
Received: from p5b2062ed.dip0.t-ipconnect.de ([91.32.98.237] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1ueEPq-00G5hB-2q;
	Tue, 22 Jul 2025 16:56:26 +0200
Message-ID: <439bd3e3-85d1-44b9-9587-052bd9c35dec@nbd.name>
Date: Tue, 22 Jul 2025 16:56:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: pppoe: implement GRO support
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250716081441.93088-1-nbd@nbd.name>
 <CANn89i+SHNfG3UxTOwr9kE26hbF-0_E7YJpt=3OHriMGLG7PeQ@mail.gmail.com>
 <d1bc6357-9bdd-444e-86f8-9e6955f46624@redhat.com>
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
In-Reply-To: <d1bc6357-9bdd-444e-86f8-9e6955f46624@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.07.25 16:47, Paolo Abeni wrote:
> On 7/22/25 4:04 PM, Eric Dumazet wrote:
>> On Wed, Jul 16, 2025 at 1:14 AM Felix Fietkau <nbd@nbd.name> wrote:
>>>
>>> Only handles packets where the pppoe header length field matches the exact
>>> packet length. Significantly improves rx throughput.
>>>
>>> When running NAT traffic through a MediaTek MT7621 devices from a host
>>> behind PPPoE to a host directly connected via ethernet, the TCP throughput
>>> that the device is able to handle improves from ~130 Mbit/s to ~630 Mbit/s,
>>> using fraglist GRO.
>>>
>>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>>> ---
>> 
>> Shouldn't we first add GSO support ?
> 
> I *think* the current __skb_gso_segment() should be able to segment a
> pppoe GSO packet, as the pppoe header is static/constant, skb->mac_len
> will include both eth/pppoe and skb->protocol should be the actual L3.

If the packet is received on a ppp device, __skb_gso_segment works 
afterwards.
However, for the bridge forwarding case, Eric is correct. In this case, 
skb->protocol will not be the L3 protocol.

I will add GSO support in v3.

Thanks,

- Felix

