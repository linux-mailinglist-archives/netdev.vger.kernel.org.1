Return-Path: <netdev+bounces-137431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF739A6407
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0828A280A6E
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 10:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F971F5859;
	Mon, 21 Oct 2024 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3xA0Bty"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5C41F4FC7
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507016; cv=none; b=D1v0PavrU570TqV5cerGfXeMWthPDDkIwgWJKIvvu+HJs8tV2A9mQt78OZuUIl7QziuoFqn0P+ZMu9XZmSjkYsz8vwlTCx5Cw7Jl01kzkuZDb5TrX68bTmZSKaoYeLSHqpxpfn6gwVdqvDmIKM5uNQO2KzTKDNRBf+76qj9Vc/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507016; c=relaxed/simple;
	bh=lPEiblptSouibb7WFhNi9rGs9Bb3s7/GT0xRZ4fg4VY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=t8MrAinEQmolp3AJ7RHV6rMdaoKTLWOTxt91tBiQmBYeV5MyL7mydQn6rNohteDXgqCTNXzjOWHSoyll3+NzoXPLV9X0U8eNbkZj1+VIGBtNCzjYV3tiIr6LWcJA4RIQO8jkus6q0E5WMh9U7iLG4Q06IjjxK6/y2LRbgbKCdak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B3xA0Bty; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729507013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lTSf3YKmAE+ZgWB5bS9KvyFO6sfcn+EvZQhAD8CYTeI=;
	b=B3xA0Bty4elUSvptV+BL6c/6J88UyhHNml9hFRqXhAv3TwdkwBzCLvx+Hk1kn+kSZ+LZHo
	UVIPFJUKrXxDBWsEbecPK6PfPUb+NsMgEIBYxGFQFXKk/i9Rs0xrBtj4INSHwfEXhgsj10
	pLTM1yhmOlHbmtvwZMr3QcOinCbtSiU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-NWGLVNQzO7GLjZxmCLKp2Q-1; Mon, 21 Oct 2024 06:36:52 -0400
X-MC-Unique: NWGLVNQzO7GLjZxmCLKp2Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315d98a75fso29148985e9.2
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 03:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729507008; x=1730111808;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lTSf3YKmAE+ZgWB5bS9KvyFO6sfcn+EvZQhAD8CYTeI=;
        b=tBRDhqRe8lclNxXtrc8VPpx43DrK/wBETptH0ys+ONbgWbVzDN7s2epQBGx3F21o3d
         O2/p9+DZgF7b/mQvZS+Bp91zoMi1ZjE6KJMVyuS7tWFgXz6i5UsMJf8MTp9MVWQu1HXp
         fZs1JsiH9G4z2k25+Nc/GdBcx5wRezHdOmRrpxXwj6FC44rcadMKG+U4uD1a/B8dYpMe
         Jjh8tLViW5/Fp/DeCLVBhEcEdpkuhC6aWcUtH618FJXRVrkMKBFPoOOT2cHr73nbmsyl
         SQS3RCXP51j9qTnrVN4Qz9O/z6hvd32avj7mXO3hXnVWEe3zCTG38kM6dKSHpg4CBGNy
         iAZw==
X-Forwarded-Encrypted: i=1; AJvYcCVW9O6iVJp5egxVCWdM8PPsynIwKn+2IUPPf98OBADbMbB4gvEtBIGdRPLUlfI1FKB065aRsxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhpDNsz4pSsVKk+k2ybq1iL5Fma6ug3cCeFuLfevf97+9bFLAQ
	M0FO+hjR5xIOmmptKXnRlG2SezQ0QoyIJkrF2qMU3XwnoRAPl48LcnhX6bG13GxMItY3Goru1Ji
	hhDCV671g8vedl+Y6Tv9KbE3RPGO1wHfEafs2Xi6h+aoATPX/gD29jQ==
X-Received: by 2002:adf:f141:0:b0:37d:4ebe:1647 with SMTP id ffacd0b85a97d-37eb488c4d7mr6627879f8f.49.1729507008006;
        Mon, 21 Oct 2024 03:36:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr3vKPJxaebwFcXlOBxK2rvLgodp7PKXmmX7JS5OeC9VpYp3nL6jzYBBr/CEoA24nLd9cOZw==
X-Received: by 2002:adf:f141:0:b0:37d:4ebe:1647 with SMTP id ffacd0b85a97d-37eb488c4d7mr6627868f8f.49.1729507007676;
        Mon, 21 Oct 2024 03:36:47 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94356sm3975738f8f.67.2024.10.21.03.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 03:36:47 -0700 (PDT)
Message-ID: <c83c58ed-32c4-4d6b-8877-2b6392fcec8f@redhat.com>
Date: Mon, 21 Oct 2024 12:36:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 02/10] net: ip: make fib_validate_source()
 return drop reason
From: Paolo Abeni <pabeni@redhat.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 dsahern@kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
 roopa@nvidia.com, razor@blackwall.org, gnault@redhat.com,
 bigeasy@linutronix.de, idosch@nvidia.com, ast@kernel.org,
 dongml2@chinatelecom.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev, bpf@vger.kernel.org
References: <20241015140800.159466-1-dongml2@chinatelecom.cn>
 <20241015140800.159466-3-dongml2@chinatelecom.cn>
 <71a20e24-10e8-42a8-8509-7e704aff9c5c@redhat.com>
Content-Language: en-US
In-Reply-To: <71a20e24-10e8-42a8-8509-7e704aff9c5c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/24 12:20, Paolo Abeni wrote:
> On 10/15/24 16:07, Menglong Dong wrote:
>> @@ -1785,9 +1785,10 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
>>  		return -EINVAL;
>>  	}
>>  
>> -	err = fib_validate_source(skb, saddr, daddr, dscp, FIB_RES_OIF(*res),
>> -				  in_dev->dev, in_dev, &itag);
>> +	err = __fib_validate_source(skb, saddr, daddr, dscp, FIB_RES_OIF(*res),
>> +				    in_dev->dev, in_dev, &itag);
>>  	if (err < 0) {
>> +		err = -EINVAL;
>>  		ip_handle_martian_source(in_dev->dev, in_dev, skb, daddr,
>>  					 saddr);
> 
> I'm sorry for not noticing this issue before, but must preserve (at
> least) the -EXDEV error code from the unpatched version or RP Filter MIB
> accounting in ip_rcv_finish_core() will be fooled.

Please, ignore this comment. ENOCOFFEE here, sorry.

/P


