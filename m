Return-Path: <netdev+bounces-236294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BD3C3A910
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 620EE4FE7A1
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E7330EF7E;
	Thu,  6 Nov 2025 11:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iP5ZcW6O";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxRNAGsc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447E12EC08F
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428396; cv=none; b=PQk3L4vrolNeNovMReVizzIR+W7YnrkJi7RbAF+623t9HxtkgGkTvDMd6PmsgvSWV6H9zRZYYfXoD6Cz7Y50jL4qG0VAG5TFMmk5HilYw0QaClsxJdySTP/fpa/wDWKj+eXdE4IcdQz8BMicJdeD/UHysvKnEx7tzEieb2X05SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428396; c=relaxed/simple;
	bh=dQJ7UpGrlfHCXR4jDF4h6g+I9lA0nUsBumN+lVkpg84=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=r6gRSNrh8pjPqhNMMJv+8tpRL7uUmHyB/XEYnNlPcoeXXxGkT6hOVZrYy9p0MqBu3frNBolEc8+BilC12y+bx5DMKkH4ADkZegGy5DbFEBjBJZxYAcLq78a+MZSHyMBM0ZONKReYN6QCEX2aqZoXZ/YLBbfHfcASksDEV3QXR2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iP5ZcW6O; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DxRNAGsc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762428393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U2soIc1bWuVzdGmA3cL/c6qe7E7yX3XgCWZMG0VXc8s=;
	b=iP5ZcW6O5DXfVNtn8lk2pLeysnAAtlekOYsSDfA+ZLGoVJ+qj8C12Sky2GMZFxlTjuiiVS
	ObzSJ/1sI8IWlu6DrfkSdi1KhbkOtPBvaESXXRI08rjFlhFiT8xkP8h6rDdVeFQa+hUvZr
	klFuPRoaEnlZMrcDyB5s+efr33wTcCE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-mlY0N7dIP9O1PlvQ6u4ILQ-1; Thu, 06 Nov 2025 06:26:33 -0500
X-MC-Unique: mlY0N7dIP9O1PlvQ6u4ILQ-1
X-Mimecast-MFC-AGG-ID: mlY0N7dIP9O1PlvQ6u4ILQ_1762428392
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429cdb0706aso635718f8f.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 03:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762428392; x=1763033192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2soIc1bWuVzdGmA3cL/c6qe7E7yX3XgCWZMG0VXc8s=;
        b=DxRNAGscNsdKU4rAsykkjf7xySlwZcWLuYCoLalPVvdA8G4oQpsKoDVO3DhakDYyO6
         ljTVz+ZHaAmjr19YWoxHKuOkxYKuEqFEtNPyejVAHsoyHtfuI7+DDy2Y5JuvANWr6CRu
         Pg2nkk9L5itwCSE3XwIpeNFBRm+++1jV4C8qJvaNnIAyam5y2Uc0Ry4rekskDm2JSl0n
         19B1TGaYTaLucCo0DGz0g7CfbwjjAKjjC1pYbYlRuSgnpPBjuANwFbhO1W06KJHyEvsU
         JoME8sn8gMiJInv/gPmzfroi9J7s5pVIwqgbywOozSMNpbic/LKR2ma+ib6/K/4TwTl5
         ToSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762428392; x=1763033192;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2soIc1bWuVzdGmA3cL/c6qe7E7yX3XgCWZMG0VXc8s=;
        b=gGJlLV1TXPYJp7/lY1K/yIdO2HOV3CKzi3KS4EqWf/86c7zZ/iFYMERP6tf6w7TF4G
         FWnJWuw2Fn0VjpMh0RukUqHaOdhFqIGYJoLmazqdLh3bmiChCck/6v5fLx/bTRr959Gz
         kQkT94HnOuYFVFhyX5i+BB+QcJGmAAeluzekx43KIcyy1Vnr+WNRCniwKvalN6geyLRX
         ZWrIF0a5EkX7PtuNr7RXfJYfLRYHqT1Hwu4Y79KVFIOe0J22hafYIUYxNt4qpw4euj67
         xV8cH3vhhyL++Xk/FWRG0BTeNFTEBVTcQOeewsCJIx8ybn8ru0oT/rEPYOTL6XxmC8m/
         RMFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8IBkf/2KPan1CE3Fd7+fFpa3KssryPChRX5SQlMd6ZQ0VMBWKIwfc/Detk8a2FLQgSfqtDEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9vFQi7QpHxZR3JSh/HwEPkuAmseL1NztijiSmLTuPty3VjLXr
	vm+TGajquJf7dp5d2wIQUEYQC08cecJtvpTKK7AjIBHz/WVE9gry13NfoDyocaciKg7wI3ZWa0H
	prbAIXRlZVNazGDVQMiW07RUW7pZQZAZU5l4boggvRTf4kJxvcljFq4wz8w==
X-Gm-Gg: ASbGncvPD+BqW1QiJRkoVqY7TXlyOcWMNogHbgIr9Jy4K5wNrfZgMF8wWtPYXrEuYdU
	pWrBY1uL1Qb2KmjZ1xe304p0yBs88u42qNPgkByx1TmJNf7mjgXdc3fZ/cdirnwi+HJnLfwbAFf
	bvxib95eK2c3QoXGPLFqI/uLgG5QU7a4TrZOL+DXMtgKV6hfWcb+RrNQIa62rKYhfxgAS10phz7
	tSk6B+wzDB2ZFeFDXd/s1UI/fXftZiRTo+VZu60jY2XEoxz6i1wRP+KqgZ0ArVoyBB4YhdUlrwp
	YwnmWRfBzOSi6LR5s55jFpJyi8Cn0MYVOZxaCz5Z1wR5tZ/GaH7ITvtaQiobii5OiBTaRYgz1YI
	rng==
X-Received: by 2002:a05:6000:2882:b0:426:f10c:c512 with SMTP id ffacd0b85a97d-429e330aacbmr5599521f8f.43.1762428391636;
        Thu, 06 Nov 2025 03:26:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTk4Fgt0+Mi1XCDO47kQQbIjxqGs2on8RBp/UBF82QmihADe45xfIjJ/TRK2eqLeeu+VVD/w==
X-Received: by 2002:a05:6000:2882:b0:426:f10c:c512 with SMTP id ffacd0b85a97d-429e330aacbmr5599487f8f.43.1762428391189;
        Thu, 06 Nov 2025 03:26:31 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49a079sm4564491f8f.32.2025.11.06.03.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:26:30 -0800 (PST)
Message-ID: <1c79daaf-c092-4c49-a715-52aeb9688b48@redhat.com>
Date: Thu, 6 Nov 2025 12:26:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 03/14] net: update commnets for
 SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
From: Paolo Abeni <pabeni@redhat.com>
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-4-chia-yu.chang@nokia-bell-labs.com>
 <f98d3cab-7668-4cf0-87bf-cd96ca5f7a5b@redhat.com>
Content-Language: en-US
In-Reply-To: <f98d3cab-7668-4cf0-87bf-cd96ca5f7a5b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/6/25 12:06 PM, Paolo Abeni wrote:
> On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
>> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>>
>> No functional changes.
>>
>> Co-developed-by: Ilpo Järvinen <ij@kernel.org>
>> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
>> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>> ---
>>  include/linux/skbuff.h | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index a7cc3d1f4fd1..74d6a209e203 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -671,7 +671,12 @@ enum {
>>  	/* This indicates the skb is from an untrusted source. */
>>  	SKB_GSO_DODGY = 1 << 1,
>>  
>> -	/* This indicates the tcp segment has CWR set. */
>> +	/* For Tx, this indicates the first TCP segment has CWR set, and any
>> +	 * subsequent segment in the same skb has CWR cleared. This cannot be
>> +	 * used on Rx, because the connection to which the segment belongs is
>> +	 * not tracked to use RFC3168 or Accurate ECN, and using RFC3168 ECN
>> +	 * offload may corrupt AccECN signal of AccECN segments.
>> +	 */
> 
> The intended difference between RX and TX sounds bad to me; I think it
> conflicts with the basic GRO design goal of making aggregated and
> re-segmented traffic indistinguishable from the original stream. Also
> what about forwarded packet?

Uhm... I missed completely the point that SKB_GSO_TCP_ECN is TX path
only, i.e. GRO never produces aggregated SKB_GSO_TCP_ECN packets. Except
virtio_net uses it in the RX path ( virtio_net_hdr_to_skb ). Please
clarify the statement accordingly.

/P



