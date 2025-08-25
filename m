Return-Path: <netdev+bounces-216572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 914C8B34972
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 19:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6127188B3B2
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 17:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18451303CB7;
	Mon, 25 Aug 2025 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nF9yWOVO"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56433239E6C
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144675; cv=none; b=lOYTM6VMTxQEVlB4ymzlhm0636h4zXeMjF606qi0D21L3I1eSWTSlCYH67mNYp6PRz6pBSXKU8qWT08iBdSWAXV5WHrfUXi2c/KvsG6OjuYZ9bzBYsPnDuNjekFZROotDYsXmKZ+bmlT14XTGCnj9tsw6yH5kW9GKiRFprUUs14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144675; c=relaxed/simple;
	bh=rZ1gVlHVC2LtswozWTAknTdiVP4jlIX2acbTjgdNq2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c7sSSft+2MBdBt+UszpOr+JDcuNnTD1R5yUm3nNCMad6TiiHA30K/Sb0CQvSDAm0T0QXuW5v2nbQUbL7fdAjHANwqTBD83WOofE2JLf832EFwJMP68Iz5S7+74SmKK91bScpAcIC3czKuhGxuNYccXIL5g34phhSw9FIdLTXodc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nF9yWOVO; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <daa73a77-3366-45b4-a770-fde87d4f50d8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756144661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UunViqkcj2OvVIMREzKdT5BwO3vN56/qvu8uu6ah+VY=;
	b=nF9yWOVOcjDUmy/9Stb1563tEnFTyokVcKO+F8ZJrE/RvCdzkPIS7zwjdoCGn+RM6z2iVG
	f5wMT6PYQ274/eOGhHOBEG75LOSupJs0EJ5URR9pH6xXJSl2Re507b7M9IuFA0WMsKaqU4
	TM/5FhPj/52an7N21WrqkIeJSkdns80=
Date: Mon, 25 Aug 2025 10:57:30 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next/net 2/8] bpf: Add a bpf hook in
 __inet_accept().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250822221846.744252-1-kuniyu@google.com>
 <20250822221846.744252-3-kuniyu@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250822221846.744252-3-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/22/25 3:17 PM, Kuniyuki Iwashima wrote:
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index ae83ecda3983..ab613abdfaa4 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -763,6 +763,8 @@ void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *new
>   		kmem_cache_charge(newsk, gfp);
>   	}
>   
> +	BPF_CGROUP_RUN_PROG_INET_SOCK_ACCEPT(newsk);
> +
>   	if (mem_cgroup_sk_enabled(newsk)) {
>   		int amt;
>   
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 233de8677382..80df246d4741 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1133,6 +1133,7 @@ enum bpf_attach_type {
>   	BPF_NETKIT_PEER,
>   	BPF_TRACE_KPROBE_SESSION,
>   	BPF_TRACE_UPROBE_SESSION,
> +	BPF_CGROUP_INET_SOCK_ACCEPT,

Instead of adding another hook, can the SK_BPF_MEMCG_SOCK_ISOLATED bit be 
inherited from the listener?


