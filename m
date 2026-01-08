Return-Path: <netdev+bounces-248003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D6962D01DB3
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 10:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 244A4300814D
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 09:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D466636B060;
	Thu,  8 Jan 2026 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQFhnX22";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6pYkrNq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31737DA66
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 08:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861306; cv=none; b=A9gAPxq5g4AxPPCnfcYynf10oehwgMvgDIxB/tGJADFOMrWpOW9UG7cMvepMpm3HzFRm6U3mrjixnwtxZO1cVP0qL47mNjlgwHT4IRNI1m+ELBJtssFAI6oH28i56LmQdhQRnB7b1gU5t3QipxhP44DZpCpNdGQHubS0ASZeYgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861306; c=relaxed/simple;
	bh=vOqy1647WRoRymxOMyXMEG8qnGN00OXJpzkXEokwITs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kXkv8qDDsW9RpJPAbAdHbeC99iZBNA7aJVsqe/vLUeAobUJs51B2lmUv5ThiS+ydsrxk21fIHzW7meuUSohevrTzUk9728Di79oLA3VPN+7x4NPEPVpymOuaKKslRXev686nDHGzN7ExDTDgmuYYdUBksEt121RhNQd6K/4RGr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GQFhnX22; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K6pYkrNq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767861292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3izPdtqXaA4EZIquGKpD4hKmpzGXchWnG6uLb78MGE=;
	b=GQFhnX22O+Txw9S2KPtVot3iGYRaOF+wGaNDPDhD8Ln1AEAVt4jJP1pToS0fuDTYSiqxe6
	JjQEbvi5clIX7l3lP1niQ8/oCOg2wO0LsKBKhaSFaYoul5vzbg2PNRqys6tNdM0uqL5l38
	Do/D/34Q8lVyxGNbaLupA0GOJsD85p8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-S9OBJKZiO42kBxOp-G3hBg-1; Thu, 08 Jan 2026 03:34:51 -0500
X-MC-Unique: S9OBJKZiO42kBxOp-G3hBg-1
X-Mimecast-MFC-AGG-ID: S9OBJKZiO42kBxOp-G3hBg_1767861290
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43101a351c7so2313194f8f.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 00:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767861290; x=1768466090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G3izPdtqXaA4EZIquGKpD4hKmpzGXchWnG6uLb78MGE=;
        b=K6pYkrNqcNjfA68oKoBMJy8uzKTXCn1nNZmV+13XHevU8yk/NRVpLmCk9w7lRu4zFm
         +/s7VDAzU6q6sCJoXsKT2J2hmeclRtBW7KDV1iU4yG4HJlbFJVRepTmoMG/mdVYMkS5/
         m5Xd+frci9SzO/ainVdYma5C852c7iXOeDxSuK3rz85E9wzIR+ubxiwuxbl9zXmOYiNP
         rEvuakL7XG0h3K5xwOvr2gA/wZHljxGbLXBi8qWOSVZOAEXa258q6djz8A9yNii6N8f3
         Zd5PLJm2PV02rGuK+KLI6D373ptOvMFsdRhQq7EaCmd+NP9waUv9PGG/7pbadVYjS75F
         IV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767861290; x=1768466090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3izPdtqXaA4EZIquGKpD4hKmpzGXchWnG6uLb78MGE=;
        b=ET0ITILaHFSaRyl2Vrp4Qv/hSINoCO3qR3YTqnEn8/pEc8humicQHdqluuYqKO4AT7
         marmrsXU9zYBcoQkW/M/K4yOvCFCgBN3SlwX7SBkWxCXr+0SEZ9mnHpmK6eIODg6q7Wa
         XUKH0tslNUdtIv4RlYsFOu7oI2jOurXauPAfrsN5trD2UgqUlpmm8NDtekJt1sJIO8DD
         OS9gGFhTD1Bi/sw6Ym5CrPeclHTz8zFQU9L9jp1XbuPciAwj/PMcRDU4609WxImZjgYq
         Ttr86rr3FHp4yJ6iXR4QcU/VRFkTKJb8bJFeGJ5dsp0JSSAfI5SIZGhx3HPkVCizPKZQ
         H7rw==
X-Forwarded-Encrypted: i=1; AJvYcCVGMbEkpDTA+jqMQHQgJnywxr64T5cltG33qHqmDOP5O5MyIkGshSFLZBfR+OmlLkGf3qy1Wuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyivK47fKKXYivk2tWtljbBB4rrl4MBnl7wNcBPQ59LTnZgtLX
	xmsBX1PLJrCezZVWq0E1Bu9us5RC8EuCGjcsiviYECC8iUOzsjEZpakISTtuO6wjuzLtJjSyxd3
	1p2b9kq9B+KykCpNqWUtyvo/Isgs6sLhoCQ/Kxa+ZBgjj2rbAl3bbMKWWrg==
X-Gm-Gg: AY/fxX7F5ugM6HDoZtbgwiX9VXWpEiXh71KvsY+dvid16b15B2/NTOMosCH1okQ9aH0
	FCRuttguiJN/6QZOPANMKwmX42+yLVocVzZbAlAy5epqvc6c1XQSFWo5Pb9RrLStGse9HffT5Ct
	PWViErQMZqbb0VAcsbFREsGpLF4KOF5Qa4/oKSaVU2g4GW8FZ+XXkd6LN1dfNhdfwRfcCZMRqs3
	h5U/g8FGuh41rUAQ+5ZZJuoR0mZdn8R3iykm/T5DCpGemxDNvFPvwsk+jDVR2wGnlSR1tJ2G7oK
	8zkMRWBsu04agC8FEV24fwRWwVzjtyl9/3xeF975fiaX1WEztNUgHztguAsslZbPM9BPfTzy55S
	JsHEQYfcwd9dqPw==
X-Received: by 2002:a5d:64c4:0:b0:430:fbad:687a with SMTP id ffacd0b85a97d-432c378a4cfmr7270506f8f.13.1767861289877;
        Thu, 08 Jan 2026 00:34:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJdXnc4ULpa81FnMPK+JkotChAGavVuM3yRwe+jMFsfmaDecitohHZqOK7h9/y3DI6QU+Rqw==
X-Received: by 2002:a5d:64c4:0:b0:430:fbad:687a with SMTP id ffacd0b85a97d-432c378a4cfmr7270478f8f.13.1767861289456;
        Thu, 08 Jan 2026 00:34:49 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ede7esm14917323f8f.32.2026.01.08.00.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 00:34:48 -0800 (PST)
Message-ID: <6491258b-0ef5-4789-b856-3e9cd9a3fbd5@redhat.com>
Date: Thu, 8 Jan 2026 09:34:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 10/13] tcp: accecn: unset ECT if receive or
 send ACE=0 in AccECN negotiaion
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
References: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
 <20260103131028.10708-11-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260103131028.10708-11-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/3/26 2:10 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -1103,6 +1104,9 @@ static void reqsk_timer_handler(struct timer_list *t)
>  	    (!resend ||
>  	     !tcp_rtx_synack(sk_listener, req) ||
>  	     inet_rsk(req)->acked)) {
> +		if (req->num_retrans > 1 && tcp_rsk(req)->accecn_ok)
> +			tcp_accecn_fail_mode_set(tcp_sk(sk_listener),
> +						 TCP_ACCECN_ACE_FAIL_SEND);

Minor nit: AFAICS the above block is repeated 3 times and could deserve
landing in it's own helper.

/P


