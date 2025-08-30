Return-Path: <netdev+bounces-218527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64891B3D03B
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 01:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1EDC188D79F
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 23:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314BE257AD1;
	Sat, 30 Aug 2025 23:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpCvdigH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA613347B4
	for <netdev@vger.kernel.org>; Sat, 30 Aug 2025 23:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756598125; cv=none; b=q5vxoNIVTIEQzGjre/qaGNbt9lfw0zE4sSp08HHvvuc8cOXd6q0c61oy3aOT90fmDwM4jODWevbEifpeBrW+DyDPn0vdKtMUrwri58Zmoos6HHnC+a+mFQUeDxZbTV6TMPLWPXf/Pmx6EcXYEZEmT4oWASkbQjh3gwPDcprMnE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756598125; c=relaxed/simple;
	bh=BbavnCKS9CDDjt6OTZy8GBGFiylDFpl97OUF/7jHTeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fw6TV7GxpZ2n6QPP/SJCtmrEXzQL35VZh6gdvudBA15kbw3syD56X+pttfCSNPEkTk9c3BwjVEYlmfgAA/vgA0yyaC7McCQ7axgFUHyYZcGqzZQ/Xtm/58IYme37FghIsUK8HF4I2UOCJyPM+WMDhjxjiM+Rd1ZFeno5TWBNy4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpCvdigH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24a95f9420aso4213815ad.0
        for <netdev@vger.kernel.org>; Sat, 30 Aug 2025 16:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756598123; x=1757202923; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zzHiQu/avmWGGa/bi1KI+w4C+mhxLmUx5T8d91guJP4=;
        b=gpCvdigHsXxHP0lXUukiqzPlxsDwybHRR5+9J9YEu36Bhn38zz34p+MmFASKS0AwQq
         7oIEeg0nGcpIwqwNC37M50dHcWHc3IfNvWgGBIIzowKfiElkoXLqHMX/ZrEL8Q29qsIK
         MMmGUZBbpGuZGQXk3uLMceT63V/L1IN0A1JeviqqjTAC2aPGDDo+dySiu4O6V/QWqRJf
         ldtmf4WPYWjPRaPd3T+C8JC8nc4KlTQYy/iAmG4TdUegfKwoaP9P2yyFYKoZEpaEpnNR
         5AMl9xHmJuIX+P28/RBkoR1shAQ8yA9Imm/no+1t7KPuX33MlaJx5mNYzW9w6cB2TauK
         TYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756598123; x=1757202923;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zzHiQu/avmWGGa/bi1KI+w4C+mhxLmUx5T8d91guJP4=;
        b=K8TYV6XsLld/fpblikD/s21gTxJKMzKcccgGxRQ9llmXGfsFW8Gr0XL/ZsyhcXbwm5
         wAA/OKsDuktXymv2LRSeadvRzildY3OthA6IpLVwfpxqZ2A5VOdaOv+WGz/aGepBZjP+
         PcKZbnqxiPffsU0e6qkwqLHWyEpZZVe6E6pF8cGots1iQm09MoZVjeBZEZ+KMHbURqDm
         thdsNlcxX5jyyJ9KaSnWn8i8KTnjlUAzbeyN0PrQhw20lnqNYbJwutbTIo5nSyys8Z5T
         a474HLsIIzMInqTXXeyggE5vpaWBk9lonkjPXssptDM5GyFX0Z1tOYO9NgaBR2rRx9vP
         ptbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwMwhOXxquqwY2joR9mGR9fOPmAmtVCZHulIRsfchQIuPW7JugFhsfZ+CLuNcAD4ru2qw5fZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBRlq4InpULtFwmaBWUkNw+tUnpL8INvHeAQetXtg12Yk+G6Bi
	1ORglOsWkpgrVGxd8DWlGCt9gpI0qEy/I5abzS6Dqn/uEuhbRslwk1ft6uUJnBMacx4H9S8KzG/
	YYJ0N7CybQmEOVuVOSBhUSaI8ClDwQ0Or7PPh
X-Gm-Gg: ASbGncu30o3CVjUG1+AxI1RbtQay9GRPVrYwylPUdIp8J2SJBXiqa1vTlqdqZR8ZQej
	vEelAwDMejwiBC0rmiXX5z2Jxor/gh6TI7KXMiYz4XUNhlZ2l5cHU6KWklO5Bq5xMGwG0JqBvfW
	jHnQAmIHdh3pIfmWFn6us/NEqnXjIaWtPOXQNCAxSWTTgzJGjaCA2cExnGBNH2d5Mi0UuuLcDU3
	DjojwCwUD5OpNUMtlru5C8Okw+VoAwfLZhXFgXiPYJSVJmNYoIR58sKBIQpteddHFOwYKtDiPiG
	WxDzNFqTxXDT1B5ddOwvyNvEa5gBpxQ9w/ZhQzgOFKeRGSHi
X-Google-Smtp-Source: AGHT+IEvxPX99/TlNNHboTv7LC23cLa8mwYPcfl84htD+sH9YFvUMHvqVt10axjtDFgwLO3SuEf1bv2YoJDW6n+a2kc=
X-Received: by 2002:a17:902:cf03:b0:242:a0b0:3c12 with SMTP id
 d9443c01a7336-24944b65688mr49900675ad.52.1756598122640; Sat, 30 Aug 2025
 16:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830-tcpao_leak-v1-1-e5878c2c3173@openai.com>
In-Reply-To: <20250830-tcpao_leak-v1-1-e5878c2c3173@openai.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Sun, 31 Aug 2025 00:55:11 +0100
X-Gm-Features: Ac12FXw70dUhauV7BdvKJ3Hg_S7-kCXRWjyGp31oAvDN0ikT5Kaidn4eiaZA48o
Message-ID: <CAJwJo6ad+Tc5WHqpCJ78PxJTW0m0P683N_-oDBoG4iBiSSf0qw@mail.gmail.com>
Subject: Re: [PATCH net] net/tcp: Fix socket memory leak in TCP-AO failure
 handling for IPv6
To: cpaasch@openai.com
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Salam Noureddine <noureddine@arista.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Aug 2025 at 23:55, Christoph Paasch via B4 Relay
<devnull+cpaasch.openai.com@kernel.org> wrote:
>
> From: Christoph Paasch <cpaasch@openai.com>
>
> When tcp_ao_copy_all_matching() fails in tcp_v6_syn_recv_sock() it just
> exits the function. This ends up causing a memory-leak:
>
> unreferenced object 0xffff0000281a8200 (size 2496):
>   comm "softirq", pid 0, jiffies 4295174684
>   hex dump (first 32 bytes):
>     7f 00 00 06 7f 00 00 06 00 00 00 00 cb a8 88 13  ................
>     0a 00 03 61 00 00 00 00 00 00 00 00 00 00 00 00  ...a............
>   backtrace (crc 5ebdbe15):
>     kmemleak_alloc+0x44/0xe0
>     kmem_cache_alloc_noprof+0x248/0x470
>     sk_prot_alloc+0x48/0x120
>     sk_clone_lock+0x38/0x3b0
>     inet_csk_clone_lock+0x34/0x150
>     tcp_create_openreq_child+0x3c/0x4a8
>     tcp_v6_syn_recv_sock+0x1c0/0x620
>     tcp_check_req+0x588/0x790
>     tcp_v6_rcv+0x5d0/0xc18
>     ip6_protocol_deliver_rcu+0x2d8/0x4c0
>     ip6_input_finish+0x74/0x148
>     ip6_input+0x50/0x118
>     ip6_sublist_rcv+0x2fc/0x3b0
>     ipv6_list_rcv+0x114/0x170
>     __netif_receive_skb_list_core+0x16c/0x200
>     netif_receive_skb_list_internal+0x1f0/0x2d0
>
> This is because in tcp_v6_syn_recv_sock (and the IPv4 counterpart), when
> exiting upon error, inet_csk_prepare_forced_close() and tcp_done() need
> to be called. They make sure the newsk will end up being correctly
> free'd.
>
> tcp_v4_syn_recv_sock() makes this very clear by having the put_and_exit
> label that takes care of things. So, this patch here makes sure
> tcp_v4_syn_recv_sock and tcp_v6_syn_recv_sock have similar
> error-handling and thus fixes the leak for TCP-AO.
>
> Fixes: 06b22ef29591 ("net/tcp: Wire TCP-AO to request sockets")
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>

Thanks, Christoph!

Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>

Quite a blunder to miss error path like that, ugh.

Thanks,
             Dmitry

