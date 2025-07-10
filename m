Return-Path: <netdev+bounces-205765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A799FB000FF
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 13:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860CD3BBE9B
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 11:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8A224A061;
	Thu, 10 Jul 2025 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hv+J8cWA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BE92222AB
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148701; cv=none; b=DdMqxXm6kl/mdFBk+aTFvbuuXkUhUdONOzNJjBWZgENaocB3qNYO+N2jOVnh5nLEbHJXvcAjhDJllyjumvxllzQBZpNcM3gZmb8Wxfge3EWtfMEWj0F2izfj7xP1EtlVi7WUvcjjrHYnEgJvSTrPGEeD/T26wnXBEhyFZ9zIHCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148701; c=relaxed/simple;
	bh=37GTRVhuocmfkPKaUGcofliLx6mUVvlkTf3yOPxVGro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nm4B42jBk/+CLbMurRuDIfXdJFX+Wb+v1epCFQja+mNbPvLDbJajkprBbgdrBoY4oCInive/Aki4lLjKdbHZpvDLMNBMgIdoofsclOQcxgUSGkMNy7Igv+iSf/7IJKdkq6YJk2AX/5yLtezMMwJAHsy7HVjAACW7AgkP2QmMCfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hv+J8cWA; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fad3400ea3so8883146d6.0
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 04:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752148699; x=1752753499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QvnZaGQ2I3aEx1WPBW9AA4zwM5tnxtodAflKv8pT2ko=;
        b=hv+J8cWAV0zQEDMFwAbHxunS2BMLIBISXdsCIDvVbnfK92H1nrUEXItrcUZJ5Q+c5L
         mofR9MPKyCazgWYJE0Y+SRKMjq/rGpYLXVT8jXFg7+Y/DYBhWlcDpqxUzF/uCdRhFcPL
         VBgkoDaKtIAXTi+txMLGaz/NoP302At46/e/9/7bD80cbt4w0q50EZGcqplwIZViOntO
         qejhp68G2MgrV8qvBnHSr+UBa9kaRytQM+FgAuXICMGcoTht6UH3ozDNIOzk04w4gfFn
         mMUNpxtGT1nmUtRDNlgVg+TuAjNkv39+K1wBIjUJWt//4atO4egUgkYs/3n6vQ0qboBY
         IIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752148699; x=1752753499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QvnZaGQ2I3aEx1WPBW9AA4zwM5tnxtodAflKv8pT2ko=;
        b=izqJ+3rXlsqkrlJ54Lrx6o+Lsmukw0ouKKDpt0NVtHxQDPFLOHpgHlrB/Xsz+fHn99
         qVvdT6cyHJHTWFMyOnpuV4nMMDDf4iuXba5DU8P2lwTwFOBk1psoKFi9Yt6U0FbA6wfh
         D+vvU3s5cWK7S3cxIL4uf7kFtlK6stvjCEeLFnT1yD8Gjs7H7TDRyMZoXsuyJvD9TRnL
         agh01S3L1EKufzMLdxPAQpgJQ15uPtT40TSaxkDJ9ygWdo/arPOucZb/zq/UUENDuV9R
         LxmZz5JmsZGt7wEdNsPqOwDX2Vzi149S+zBq6u4y3LuEFHFfmRNRujz89K0gwDcNjE6v
         b8lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSZZk5Dy0tc36JslVOIz3KhH186OJvjFBth1TmLCd2/k51105NLxmlyUs05joUmzoPxS5T9CU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwIZ0tH9qyhvRNvSyUEJb5bHk+6p20LspNm/21qZNWIgq3XLd+
	kPa16v6QJx3MYkr1JOWd3J29Banb8Z2qdk3PiJu11XIQ3WFb0gwJUiRV
X-Gm-Gg: ASbGncu4XaIY1Gqmyj+2Gika5kGh3wgQ4XzAN7BAuVwuJGjcrIXvyUbiDaoobkQm8dP
	+tluHUcj/NkQXahdxA4R0U8SuxWJOum/JZ+oXCXiH8T21wJpgPvhL2a83qabmkA+sbudIUCffDp
	GX1xr4r1VzxI05W8kjPaI0ukIYvVcsmspwIIfjZ+CwDvqCUnNHI38T4tssq/8gCJdzfRwTD+lBj
	JySv9Z0lrC2+207BGCXPxYsFcneJCvDO2XvCYvr6hbxVvcmFRgZznDukR5paJGC4h8EqMIsvM2Y
	ocOGvKe0S90tH05ZzEBX/L8Z77xPxI36YAiJfnM16J3lNpNslvYpYJMBZA0J0YTp3FPHAY7eO/H
	Ftvms5Ddo2n6GJHEf6P79XorqcTOu4J9QmxmJSIob
X-Google-Smtp-Source: AGHT+IHZ2ozF3o+NtlqfmTNQ+zeKqz80ZHwzg+jfefMLkuq+0v1MQTSk+VL6Fq91K4OLyEFYXY4UhA==
X-Received: by 2002:a05:6214:4a07:b0:704:807f:da4e with SMTP id 6a1803df08f44-7048b8304e8mr90037106d6.11.1752148698777;
        Thu, 10 Jul 2025 04:58:18 -0700 (PDT)
Received: from ?IPV6:2600:4040:95d2:7b00:8471:c736:47af:a8b7? ([2600:4040:95d2:7b00:8471:c736:47af:a8b7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979e459csm7709626d6.49.2025.07.10.04.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 04:58:18 -0700 (PDT)
Message-ID: <582cde2d-bdcd-4866-ab78-2a8e8590e8eb@gmail.com>
Date: Thu, 10 Jul 2025 07:58:17 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/19] tcp: add datapath logic for PSP with inline key
 exchange
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
 <20250702171326.3265825-5-daniel.zahka@gmail.com>
 <686aa16a9e5a7_3ad0f329432@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <686aa16a9e5a7_3ad0f329432@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/6/25 12:16 PM, Willem de Bruijn wrote:
>> @@ -689,6 +690,7 @@ void tcp_skb_entail(struct sock *sk, struct sk_buff *skb)
>>   	tcb->seq     = tcb->end_seq = tp->write_seq;
>>   	tcb->tcp_flags = TCPHDR_ACK;
>>   	__skb_header_release(skb);
>> +	psp_enqueue_set_decrypted(sk, skb);
> If touching the tcp hot path, maybe a static branch.

Ack. Do you imagine we would key the branch on pas creation or on psd 
creation? Our preference would be to defer the change to its own series 
if the code is acceptable as is.

