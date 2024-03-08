Return-Path: <netdev+bounces-78789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D70E876782
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 16:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93643B22A1A
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 15:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E588A1F94C;
	Fri,  8 Mar 2024 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="NIn0xIFA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F5D1EF1E
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709912619; cv=none; b=Umnc75HNeJYh7Mk8AIXNdoyr0xzuNClw7fF8X3AIK6YJHyY3eLXaKZcPsvsOLlahVOKz4HbxAI/HXBpy/Hm3YGfrYx9SdfOKI84enthxNFFgT9654VSZw2XAUSLi6wTWUTWT6hki9DSMLMGJzl7cgAX7UxoEgyfVetYUHZ1wcqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709912619; c=relaxed/simple;
	bh=GQYGKfLGSAfOn459qjUHqTQALqwBfMsCMGEAQCwbqRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LfXwwPI7malnJMwRzfVqqtR42qrpWi9kBLKtdKJr3gbOCLO2ggy+/dYGbVC7xx2f/1t80Djnb9XEA3B66gU5svRPVzlmuiG//Cd39tWw5icWSrWB9bxREAJ+6MAJ8ubFcgln91/ZqEiI1GbVplwuHCB3ed2g6icrWwS8mMjD0qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=NIn0xIFA; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so1267730a12.1
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 07:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709912616; x=1710517416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nZc3N94GCYeIO1iDbFQDk4VjqnLHC1dkhrXlzuA5+kA=;
        b=NIn0xIFAGB48EXc0qjRssTVKpLxI03EmRYAnar0A++jlrSpq1pN9JHMdCvHv7EHLj5
         7pUwgWHkXyNtrrdRJcMMNPi5fzmGOtljquSjr71fUFkICoYBNPGFCwjZCCzFpc5sWbGK
         UyAQdDZtyj/VQImRHNeThRhs/8d40mRanOgmX4n4pJQ+RGajAyt8CNUmvCC+nI2Kt96P
         jMRW+8TaCTSFGCLYmxp+3amXPUPhtNsUNbdAqoHuoJTXBtXSUmYc3Q6vcJfomJO7NBYH
         mEA765FmRCKD7//yu2mBgxzq99Val7BW/5ybTIeppxlDcaluJIp8Pn5bMpFvCkffS9wx
         hJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709912616; x=1710517416;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZc3N94GCYeIO1iDbFQDk4VjqnLHC1dkhrXlzuA5+kA=;
        b=vCl0JyhffDC4S6+R6SoEjby+rWS91MIuS8PUveFst/brElTMdcAiXQomp91b9PEry7
         XYGNb12CMX83VXK43efEErsKT4ammgl0oku6XuywKldyEU78jkM8SCgNON+F3I/z7nh3
         P2FlKFT8y6fVsdDv6wbpy+oHqz5ATKeuC6Bg30PgoNUbqlIn03GZT2CH1DpFz0bbq6E8
         Q+nk4ItEWu0sWAH1DGkCpc1wT7ZqF8OGlnbfeAfVS/RdfZy68rllCzQ5gqy6kZEWigeM
         QnRFG8lMDQDnpGraXbmv7qlpz9iJaZzGU6ygVxPg+OOosclCu0luM/7kOXvN04ZMT/E2
         IWvg==
X-Forwarded-Encrypted: i=1; AJvYcCVjKXw0GWRBn4lPe5sgfX4l05PR6Q7NCtHLiAS7JKVa4qERWrn75j6F1cUTXJS9VsaM7q1g4AvyD2OIPWh+B1ECiGuIKN0r
X-Gm-Message-State: AOJu0YxCA5L+Cp8x8Xfk6rizTWLcBPje35KPKybnRfcoZzMdUOLzJwRj
	5i9C3ZtdSiZ0TzneFPGcn0YOFzJCit0N5mX2hvYFR4IaUE7PrSixPdBHEwmVdKk=
X-Google-Smtp-Source: AGHT+IGyWIUAy/vywTzsbYs1G5P+drTmvXEK7vP4hgYEfpYX1imGSwf2OAuHtyYQ45a4xRHrHO++Xg==
X-Received: by 2002:a17:906:af87:b0:a45:c18e:9679 with SMTP id mj7-20020a170906af8700b00a45c18e9679mr5184604ejb.6.1709912616057;
        Fri, 08 Mar 2024 07:43:36 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:0:b873:e280:4c85:26d8? ([2001:67c:2fbc:0:b873:e280:4c85:26d8])
        by smtp.gmail.com with ESMTPSA id p5-20020a1709060dc500b00a4537466591sm5917059eji.32.2024.03.08.07.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 07:43:35 -0800 (PST)
Message-ID: <0273cf51-fbca-453d-81da-777b9462ce3c@openvpn.net>
Date: Fri, 8 Mar 2024 16:44:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 08/22] ovpn: implement basic TX path (UDP)
Content-Language: en-US
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Sergey Ryazanov
 <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-9-antonio@openvpn.net> <87ttlgrb86.fsf@toke.dk>
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <87ttlgrb86.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Toke,

On 08/03/2024 16:31, Toke Høiland-Jørgensen wrote:
> Antonio Quartulli <antonio@openvpn.net> writes:
> 
>> +/* send skb to connected peer, if any */
>> +static void ovpn_queue_skb(struct ovpn_struct *ovpn, struct sk_buff *skb, struct ovpn_peer *peer)
>> +{
>> +	int ret;
>> +
>> +	if (likely(!peer))
>> +		/* retrieve peer serving the destination IP of this packet */
>> +		peer = ovpn_peer_lookup_by_dst(ovpn, skb);
>> +	if (unlikely(!peer)) {
>> +		net_dbg_ratelimited("%s: no peer to send data to\n", ovpn->dev->name);
>> +		goto drop;
>> +	}
>> +
>> +	ret = ptr_ring_produce_bh(&peer->tx_ring, skb);
>> +	if (unlikely(ret < 0)) {
>> +		net_err_ratelimited("%s: cannot queue packet to TX ring\n", peer->ovpn->dev->name);
>> +		goto drop;
>> +	}
>> +
>> +	if (!queue_work(ovpn->crypto_wq, &peer->encrypt_work))
>> +		ovpn_peer_put(peer);
>> +
>> +	return;
>> +drop:
>> +	if (peer)
>> +		ovpn_peer_put(peer);
>> +	kfree_skb_list(skb);
>> +}
> 
> So this puts packets on a per-peer 1024-packet FIFO queue with no
> backpressure? That sounds like a pretty terrible bufferbloat situation.
> Did you do any kind of latency-under-load testing of this, such as
> running the RRUL test[0] through it?

Thanks for pointing this out.

Andrew Lunn just raised a similar point about these rings being 
potential bufferbloat pitfalls.

And I totally agree.

I haven't performed any specific test, but I have already seen latency 
bumping here and there under heavy load.

Andrew suggested at least reducing rings size to something like 128 and 
then looking at BQL.

Do you have any hint as to what may make sense for a first 
implementation, balancing complexity and good results?


Thanks a lot.

Regards,



> 
> -Toke
> 
> [0] https://flent.org/tests.html#the-realtime-response-under-load-rrul-test
> 

-- 
Antonio Quartulli
OpenVPN Inc.

