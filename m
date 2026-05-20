Return-Path: <netdev+bounces-289805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHxoFLZhDWquwgUAu9opvQ
	(envelope-from <netdev+bounces-289805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:24:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C39ED588E64
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A8F5302EA95
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 07:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C9B36D506;
	Wed, 20 May 2026 07:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5OT29gg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sSDPT7+2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800D724E4A1
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 07:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779261866; cv=none; b=kx1pDszJD8vCarYo5z53iNZZq1iA3FZGhmtCWG8JDNsRqgtRJBUg8+5aBNFYfuKe1NRkzSR10r3KQ8xqFqON7SCVFTvIpeUZmxwfN1DDt3tjXFCPQEAD+QAidz6IvLzW/IHQlWND6opMHCHiiTi8n360Bhnpa7FjRjcHqo1l6h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779261866; c=relaxed/simple;
	bh=et5n/jVgSeC7CA3DhRH3wMYvqFbDTZKATIwL6wl4Hkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umu4+rpdeBiEKOlNpon2G6RYWWHAhvcR7zB1OzvQAMHkMbrIZMv7TsiT0Ac+Sa4mfBUiRZBcQTnfFPOsl5202hgmJqEfYgfXQOwooLeJKyvT5QfkvCJP0y/uCJlIdMtg5S6+S+Hlt1SWsUgrOHck1E5fm/r7W7y6EES2v6QnBBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D5OT29gg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sSDPT7+2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779261863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nIN5hOtVWer3WDHGGjocFJPku991/m9aF85eLbVhj2c=;
	b=D5OT29gglTmJn+0Vib8xKrE5vLx9u5s/wagViXqL236RceT0rH7/C//Zx5zqTYH5N0Dcxj
	/XlPqcJpwkIM7Rdtb77jiR5d/2Imivf6wEqCPk3g4N59yN2WNPfgoaHPUZ/fcuqRC7fMyM
	4jm3Xjdnoz3Z9A2+dAhjUnRJ2bRF2Lc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-GuM7MVUAPjShvHSALjTnZg-1; Wed, 20 May 2026 03:24:22 -0400
X-MC-Unique: GuM7MVUAPjShvHSALjTnZg-1
X-Mimecast-MFC-AGG-ID: GuM7MVUAPjShvHSALjTnZg_1779261861
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48fdca5c638so33835405e9.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 00:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779261861; x=1779866661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nIN5hOtVWer3WDHGGjocFJPku991/m9aF85eLbVhj2c=;
        b=sSDPT7+2FtdTDVXfDbN1dAdUbqfw++PiwMluZuB0ZcT5HdsZtKS98etl0n63Moz+oP
         /mqyfNiF94IvuFMlMA1gNZqA5dTgiHet9JK6xSZlXqPOKHOyTBzEy3IDAw/HJhQw+ETY
         7m8mY54vXjQZA8Sc5SK5ZWKzwnmIOwx3LmJvkVPPqNcm9s7hUTvZB4tj44Wz/OQN34iC
         mosvWIdhY4/B2o1WTqbX99e6qUeKUvA1LT5CKjuxoQXy1skBi+yAHBGRTnQJjdWUv72m
         mCznHGMUz/QbfrTXg9HMyBFr7E54+etbtFu6kRIrIi7EE38tMv8x1v2lQJJVDnPogvcV
         O92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779261861; x=1779866661;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIN5hOtVWer3WDHGGjocFJPku991/m9aF85eLbVhj2c=;
        b=gQhYcpxNT/RcpBl2bhwRvijhNNv9FzfMrSfy5aja6ddhitcCNyPvJ3kEXxTrJN+z3i
         x3U0WAPSzi1czysm/mpO0zm2JbFjNX5eBpjNqo7uMZ1wSn3UpIMFss33BkhMcygIhMDo
         lspNHaZGXiZe3YsAhU/ATi/Le2ofQN6Vn6htwOQxE7aiOhxzOoki/e5YIZ9bSRGVrcBy
         ObUho2xwDi04vcHEtwekcoy8I4IGpvuRwJ8HK+UZBbcfnAnWs+wUEK6qRqm70r7uvgdk
         BuT3UdhQJ5gPai8AX+gSKdLx8YZzXODI+NiksqTgLJrNpeHVS5QHRJaX/CeuYWt78HK/
         xHSg==
X-Forwarded-Encrypted: i=1; AFNElJ88VBJE2wiilpI38B/H1dy7o0CncgKNcU7EGYuzFKK00Ixs9G2WAAbjBVfOOMK94nnk+H6aK78=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiMEsaj/dyFaShqmlfYk6nyP5AkY1kwJ7Rv3QbtbKwgRVV26HL
	Uy8jzqAhkmMqc1e3/E76flVZUPtq5U+Gok3yyF6ltJmfRFErRdOGr5VJQzzeiKqmxetGNplCcbp
	3sJc88YuxytDkL9DG3YqUiPj15s2EtQgdtw1aiTKCsh7lg2QdXTiR6fhfww==
X-Gm-Gg: Acq92OE0neeEGvF0KSPUKkjvJuGbEFzrTvC3UCQKJeWfDXsP8zmAsb3Hdudzt75NG6H
	J0JTdeHMiS49QJtduPWlszgMDsktsEhNfbzuFtQGbUPeyuAaQ6BrIrnHdi83xfIu1v2BqffW49E
	uM5qARn2VyR0+YRjDUSBVSaIAucMhUHmJp3W7y2xddTkOXwjWFgl1RsodEUiWdG+7okfLYZCZer
	Yf6bFm1VW1wX+1Au/PCiuMwUyLHnGzReCnWQ2I69xQDhSqaKSdLdl5P948Q9Hh8Ih3ZjhsFrdhY
	orkP5rAvX3iKhk0mgeEBS1n6CSXK1p6l6EjutZq4zDxAmDIgNdQVkCw4h+ktBOpD/XXIwCuHqb0
	WM2wsSxKuedPA7Io4pshPMnY65Q==
X-Received: by 2002:a05:600c:4e55:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-48fe60e510bmr342909565e9.5.1779261860865;
        Wed, 20 May 2026 00:24:20 -0700 (PDT)
X-Received: by 2002:a05:600c:4e55:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-48fe60e510bmr342909115e9.5.1779261860393;
        Wed, 20 May 2026 00:24:20 -0700 (PDT)
Received: from [192.168.100.100] ([82.64.211.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4dac000sm385877715e9.0.2026.05.20.00.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 00:24:19 -0700 (PDT)
Message-ID: <5c1de7cb-42c2-473f-8d67-0523a3c86464@redhat.com>
Date: Wed, 20 May 2026 09:24:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/2] Fix race condition between TCP_REPAIR dump and
 data receive
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Stefano Brivio <sbrivio@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Pavel Emelyanov <xemul@scylladb.com>,
 David Gibson <david@gibson.dropbear.id.au>, Jon Maloy <jmaloy@redhat.com>,
 Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@google.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>
References: <20260518183424.3144867-1-sbrivio@redhat.com>
 <20260519190352.45c8478e@kernel.org>
 <CANn89i+DknqarcKuZxku-XvoioqkXrd3sQd3PXW5fdFZBpPxjg@mail.gmail.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <CANn89i+DknqarcKuZxku-XvoioqkXrd3sQd3PXW5fdFZBpPxjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-289805-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lvivier@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C39ED588E64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/20/26 06:39, Eric Dumazet wrote:
> On Tue, May 19, 2026 at 7:03 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Mon, 18 May 2026 20:34:22 +0200 Stefano Brivio wrote:
>>> Stefano Brivio (2):
>>>    tcp: Don't accept data when socket is in repair mode
>>
>> Not sure Eric is on board with this patch in the first place.
>> Sound like it's not the intended use case for REPAIR so IMO
>> it's up to TCP maintainers whether we want to support this.
>> And it's definitely not a Fix.
> 
> I am not on board. Only net-next material for sure.
> 
> While v2 is slightly better, we have the fundamental problem of adding
> stuff to TCP receive path for features that almost nobody use.
> (It took more than 13 years to finally complain about the race)
> 
> This consumes Gigawats of power on our planet (and tons of CO2), given
> the trillions of packets processed every second.
> 
> Please at least add a static key as we did in:
> 
> commit 020e71a3cf7f50c0f2c54cf2444067b76fe6d785
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Mon Oct 25 09:48:24 2021 -0700
> 
>      ipv4: guard IP_MINTTL with a static key
> 
>      RFC 5082 IP_MINTTL option is rarely used on hosts.
> 
> 
> But in my original feedback I pointed that we TCP_REPAIR should
> probably only insert a TCP socket into TPC established hash table
> only when it is ready to process incoming packets.

The problem is on the source side of the migration and I think removing the socket from 
the ehash table would trigger RSTs, closing the connection on the remote side.

Thanks,
Laurent


