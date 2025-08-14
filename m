Return-Path: <netdev+bounces-213786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F23B269F9
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 16:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0951887798
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 14:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2651F0E32;
	Thu, 14 Aug 2025 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOrUier7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3261DED64
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182620; cv=none; b=iJttIW6ZiszlJHq9lWhsAl34nD5aQDCZTP6yyeClqwy4Cb9Tv5B/rwggt/Iuy/LBON/13CeVR8Mu38p0tjucXlCgrhxgaFiPNqI6pBAPMjUAI6wO47qPMsXQ67WQWwAExlmGbC0IzLYB4uP+Fz3g/YRWiTNZ1E+LqMgnocPMvPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182620; c=relaxed/simple;
	bh=uwCHRuEi3RJVcUtcxIqNN95o3oVa3hxHEBjdyDfa8Jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eL7zjcpPfrdp7zRcccbhI/lEDB4gbCyoc1Joy7D+Uh9nprcN9+z2Q47G1C/Y2OIc/s+q4B8ns3QmGhSWj0edG4FtDb5g6Wqo4Cun0MuMJvhGi6v6z+O1HWSGx81ZTKpF8ptYjg0FEAr9w3RBss2p/iCjzg9d+jTCpSlSUiqee6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOrUier7; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e87061d120so101363585a.2
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 07:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755182617; x=1755787417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9qcN+78/i2M75QLZc5zxNQpKZMNyeoGpDYQO/OeYIO0=;
        b=IOrUier78NytF98S/65Ru+bMXHh/R6qcYrgMarK2e925zHSBfGmMyvLRdYYrEutwN+
         LD9R3YC1/k1h9mmhvoxjqMwq0OBNHSTqduaNjZp8e3nhPvfdThgSqctDaGFzDuiCn6Z5
         7MgNXjSO0Zi9Y4UY/4/v/mGemcoSZXX9dRcZ7DAl/O63WoEzOfY68CnOaV0MqNYNZedP
         5XTZrldQOig4LuFS4yFTpZ4wPg6wQlPQ+zNcTPprrybgC3FjFyFm1TdZUJIMBwI9jaQ7
         LObR40gatbrZ/ICWVrgDpt2KupnO8Nr4NABnSarmSdzDjeL8PQSRHyEr9VJpbJtSD16w
         2TAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755182617; x=1755787417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qcN+78/i2M75QLZc5zxNQpKZMNyeoGpDYQO/OeYIO0=;
        b=o1xT/Ig11zb26FC6oDOZCxG0ED5kZ1lGKVFr4whpbX0WtWcEsgfZzHvkk5OVWsc6nk
         Ll0A3zFGj8M7phgmfLQvo8K814+CB8b1rPN7+enZjKa5C10zro4V0cO3luZNQbElhwlL
         edEbu3GzW3dy83rt+AG7EoEbueDYQVH4bEmO5N0yaYvbBxxbUHwMLEjuoD3LiRjeAT+6
         PpU6SSMpd95laV5gJePLuCtbDxyLpmeGBNR9Api0jNl+qUPXdGMsZP4ciD8jOupfM1Hk
         yUn+ndYbevRS+Wm9Yn0u5ICsR6hVERIeM4vWAPUo002Mo3XQ/MvmTAcWDL15MG+Mx1vU
         qOfg==
X-Forwarded-Encrypted: i=1; AJvYcCU49d7g6Nl/FdGLweKP1WeStad3R9KSQJ4j7wyCevRLFYBmgVohvtmgeZ4dOVSM7yt2Zm2msFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8NV+EXzeUulYV5dCyaXOaVl//rq7z5bEC98VgQsSwoVEtiY9V
	hUhMeBq5Equp3PByUzb3+L90PnudYuJCaHncDrBmO6DUTgxyNpYm4S3n
X-Gm-Gg: ASbGncuIIFGoO/Eg1CTW0UCHVW8FfAcf2I8nErTWEQxMFEui2ve1nn5f2T+KvXC9x0N
	8cwzMNHm7Z59KAJW0mu0DjcVT1uhgbAka8GtCOQWaOCe7Qg1WB76aysCBWxO99r0eOAulR+hd3A
	K9QTgrmhmevEwwdX9gxKfgUiosfMlHvXVlgGOUkzQHYeXWzs3mcnFJWbbJoKmTTi79pe/auNON1
	2T0laAdvCgVegzYBcEAPszR9pVncxkSBuwd3riSrUzkSPeUgfOrLSq6Wc149vIUA4fi2YTnzF8/
	WsZyccvoZDF9j5tkEAEIEdRS5/Nrmf1O9h8N6vWoSn7/1houCWbAz9RNrnXKA+qN4LVnXpVF91u
	Pc4WmUGs+LRQ+KZxX3e1wkVQY/EBDeBEX6wYESWCLZCsjwwQpCI5rLJxNsHI8GgtpciTqVtmVFt
	of
X-Google-Smtp-Source: AGHT+IHe/igVfqtm4Q5rTswzkrf3lNPQkSgZrNdhjO+OVsdR9jpZqcUHLJjRf3eAYEKW9lBzjT+TYQ==
X-Received: by 2002:a05:620a:1356:b0:7e8:204c:7317 with SMTP id af79cd13be357-7e8704856fbmr373222185a.26.1755182616827;
        Thu, 14 Aug 2025 07:43:36 -0700 (PDT)
Received: from ?IPV6:2600:4040:95d2:7b00:8471:c736:47af:a8b7? ([2600:4040:95d2:7b00:8471:c736:47af:a8b7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e83075ffa6sm1118719985a.4.2025.08.14.07.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 07:43:36 -0700 (PDT)
Message-ID: <0c1dd072-8dae-429e-846f-08de9a69366f@gmail.com>
Date: Thu, 14 Aug 2025 10:43:34 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 04/19] tcp: add datapath logic for PSP with
 inline key exchange
To: Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
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
 Kiran Kella <kiran.kella@broadcom.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20250812003009.2455540-1-daniel.zahka@gmail.com>
 <20250812003009.2455540-5-daniel.zahka@gmail.com>
 <63d55246-fd88-40e6-bb78-8447e0863684@redhat.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <63d55246-fd88-40e6-bb78-8447e0863684@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/14/25 9:18 AM, Paolo Abeni wrote:
> On 8/12/25 2:29 AM, Daniel Zahka wrote:
>> @@ -2070,7 +2076,9 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
>>   	     (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)) ||
>>   	    !tcp_skb_can_collapse_rx(tail, skb) ||
>>   	    thtail->doff != th->doff ||
>> -	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
>> +	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)) ||
>> +	    /* prior to PSP Rx policy check, retain exact PSP metadata */
>> +	    psp_skb_coalesce_diff(tail, skb))
>>   		goto no_coalesce;
> The TCP stack will try to coalesce skbs in other places, too (i.e.
> tcp_try_coalesce(), tcp_collapse()...) Why a similar check is not needed
> there?

We handle coalescing of skb's in various places. On the tx path, we 
place a call to tcp_write_collapse_fence() in psp_sock_assoc_set_tx(), 
to prevent data written into the socket as cleartext from being merged 
with data written after the tx-assoc netlink operation has been 
performed. On the rx path, for dealing with coalescing before the skb is 
in the socket receive queue we call psp_skb_coalesce_diff() from 
tcp_add_backlog() and gro_list_prepare(). For skb's that are already on 
the socket receive queue, we rely on the fact that psp skb's will have 
skb->decrypted set, and all tcp functions that try to collapse skb's on 
the receive queue should call skb_cmp_decrypted() at some point. If we 
have missed a case, than that would be a bug.

