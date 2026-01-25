Return-Path: <netdev+bounces-253193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOxFHsdrdmkVQgEAu9opvQ
	(envelope-from <netdev+bounces-253193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 20:15:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F20C820B7
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 20:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39AA8300101C
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 19:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1BA2F3632;
	Sun, 25 Jan 2026 19:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bNEOW6Sq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0D52F3622
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 19:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769368516; cv=none; b=JCDaqaJOH44K1047QLXhbsajif2vc5BuFrb6H7rW6x7grz7fN4cu7QUhBlnZrVYFpsBXwAPPymJeTTf3LoV1AQmnuDtfFimF9f4ns+Lr7TysjhMHbL6YGrYfkc4jqEjJwCDe9EB5vPRArLM7uQ72rJPmk6gwqDUagQHjhlRM7nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769368516; c=relaxed/simple;
	bh=UaFiLGY06az2o1UrEU9VzuHGzBsf5ccZhhq1L8W6OO8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IUVUgcS0ceIlNBnoCENk8EF1nEuL4u4d6oRaYNhTwKzIDz3UwJT0EaXigPFQfpaTEqGCJQvEcbS8CbwME/eCYNNL5kUV/3ptxLUN3nLLPQI9bDqBbYA+7Mc3tgkWnp04rAPlFcpvBX896uQxSwi0L5q9b8j7M08n7WRPpSwJ94M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bNEOW6Sq; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b886fc047d5so340245966b.3
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 11:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1769368513; x=1769973313; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UaFiLGY06az2o1UrEU9VzuHGzBsf5ccZhhq1L8W6OO8=;
        b=bNEOW6SqIW4z4rSTU5lnCtnQJ/VUy2Za4PDQOTpVhD/4kvGocIsBSvtcRZUykt8HNe
         lf9RgQUiGfABnfVawmSaXXHtvHwFNuL9qZkIBbyjalKrVxcHKI7C0jfdeaXVkeoCZdvH
         pfLfMy+DuSp43rQ614YJn2FNB8HWVziu1Z2pg0AOBdSuNPjJ8QAacWrJuafaZL0de/R3
         OOiG55Hsp0d7YUsyATJRrGqUzEG9bdtmb7SxScg4iKPCV1IquZG/c7wM2gfqg3SW9zxR
         HBqRpj8E9diSsNwY8/zIjAhr3WFRCYzrk3Ha6G+F/p1G+klMi/FU5/Uf1JSr0b/eqksh
         Ts7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769368513; x=1769973313;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UaFiLGY06az2o1UrEU9VzuHGzBsf5ccZhhq1L8W6OO8=;
        b=pisv4+Fv8lHN+xNO/7pRYLGPSBtx8flI//UVk9T69vm7wqHEFZ5OkB2UPyzzquPnnq
         +ypXT/NyYvsp+qAtAwowqO3UPO5NAKARmjTely90BiE0K1WaFtSeu/fEDtobasGibJfq
         Ddq7XmCbTrFpwDkm2sXi/Nto7NkpnDb1WSxwDTJXpdF9S/+IrOuLmtPMu+rbPbTfG5/f
         hYT02+QS5O4nGhxzxDbqtHC/I/ajlFIMYn0g0JiDPuL/JuD4ixCWpg8gbPUBpEKekLfy
         QLWIVjdTqWxBis+lcRCVIWHUZLGm7FLod36K08ot6DoYMPLb8GIy7P4MCWlEatHM8yr+
         0RWg==
X-Gm-Message-State: AOJu0YxZTFwE6CfzozxzQ0dOj8FJRKJNLah/p8aLRrBGKTp2KOdDNBPn
	jfjVGaX91uo9X1/eGMPFhGylpFe8RHuq8n+gL3yegffdcvAfapVX8ff8foZmL9qE/bc=
X-Gm-Gg: AZuq6aI0XK/Visfq0twAZy2A3lQAfmynxoTphd1TLuTjGGK7X2zdJm43wqbehclMIrn
	ppgvMpI2fWz9Xd9aUDw1IU/EBILcMGv4oTTsfl1tLmqPABnsdMir5t+SAHEeyI8NKgXlUluRtS/
	dTaUk1p7urxUPFxyOQLpF/jnB9VCbplJmqPyd3o2T6Axpw8fVoSTU77+CmXt1pojTPoezlmqmRq
	EfJLgUZ3kEKzayzmGNl+1GrX03/RaTfKZ6u+6iTXHL9OTCFN/DmH5qQoWwUT+q2xHksyiUDPcW5
	2mg1H6crJJyDfNv4tHioEh0AAZkvs0oNEnNkTb4jOjjDYuJ4dT0k9g8oDIYHF+ZFKPcT2BfffaC
	chyUXPt7OSDmb8mcTcT9JQYtlmkinc+yf/0S1aw+4f0pIry8NG9Kbg1aCXU6yeoC0tmb4nln+Qx
	JiSvI=
X-Received: by 2002:a17:907:96a9:b0:b88:60d2:11b8 with SMTP id a640c23a62f3a-b8d0a83048dmr155054466b.4.1769368512869;
        Sun, 25 Jan 2026 11:15:12 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:b1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b75d669sm494078966b.51.2026.01.25.11.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 11:15:12 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Michael Chan <michael.chan@broadcom.com>,
  Pavan Chebbi <pavan.chebbi@broadcom.com>,  Andrew Lunn
 <andrew+netdev@lunn.ch>,  Tony Nguyen <anthony.l.nguyen@intel.com>,
  Przemek Kitszel <przemyslaw.kitszel@intel.com>,  Saeed Mahameed
 <saeedm@nvidia.com>,  Leon Romanovsky <leon@kernel.org>,  Tariq Toukan
 <tariqt@nvidia.com>,  Mark Bloch <mbloch@nvidia.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Jesper
 Dangaard Brouer <hawk@kernel.org>,  John Fastabend
 <john.fastabend@gmail.com>,  Stanislav Fomichev <sdf@fomichev.me>,
  intel-wired-lan@lists.osuosl.org,  bpf@vger.kernel.org,
  kernel-team@cloudflare.com,  Jakub Kicinski <kuba@kernel.org>,  Amery
 Hung <ameryhung@gmail.com>
Subject: Re: [PATCH net-next 00/10] Call skb_metadata_set when skb->data
 points past metadata
In-Reply-To: <ad835a9b-e544-48d3-b6e2-ffe172fcfa6d@linux.dev> (Martin KaFai
	Lau's message of "Thu, 22 Jan 2026 12:21:21 -0800")
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
	<20260112190856.3ff91f8d@kernel.org> <87bjixwv41.fsf@cloudflare.com>
	<ad835a9b-e544-48d3-b6e2-ffe172fcfa6d@linux.dev>
Date: Sun, 25 Jan 2026 20:15:11 +0100
Message-ID: <878qdltsg0.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,broadcom.com,lunn.ch,intel.com,nvidia.com,iogearbox.net,gmail.com,fomichev.me,lists.osuosl.org,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253193-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0F20C820B7
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 12:21 PM -08, Martin KaFai Lau wrote:
> On 1/13/26 4:33 AM, Jakub Sitnicki wrote:
>> Good point. I'm hoping we don't have to allocate from
>> skb_metadata_set(), which does sound prohibitively expensive. Instead
>> we'd allocate the extension together with the skb if we know upfront
>> that metadata will be used.
>
> [ Sorry for being late. Have been catching up after holidays. ]
>
> For the sk local storage (which was mentioned in other replies as making skb
> metadata to look more like sk local storage), there is a plan (Amery has been
> looking into it) to allocate the storage together with sk for performance
> reason. This means allocating a larger 'struct sock'. The extra space will be at
> the front of sk instead of the end of sk because of how the 'struct sock' is
> embedded in tcp_sock/udp_sock/... If skb is going in the same direction, it
> should be useful to have a similar scheme on: upfront allocation and then shared
> by multiple BPF progs.
>
> The current thinking is to built upon the existing bpf_sk_local_storage usage. A
> boot param decides how much BPF space should be allocated for 'struct
> sock'. When a bpf_sk_storage_map is created (with a new use_reserve flag), the
> space will be allocated permanently from the head space of every sk for this
> map. The read (from a BPF prog) will be at one stable offset before a sk. If
> there is no more head space left, the map creation will fail. User can decide if
> it wants to retry without the 'use_reserve' flag.

Thanks for sharing the plans.

We will definitely be looking into ways of eliminating allocations in
the long run. With one allocation for skb_ext, one for
bpf_local_storage, and one for the actual map, it seems unlikely we will
be able to attach metadata this way to every packet. Which is something
we wanted for our "label packet once, use label everywhere" use case.

I'm not sure how much we can squeeze in together with the sk_buff.
Hopefully at least skb_ext plus a pointer to bpf_local_storage.

I'm also hoping we can allocate memory for bpf_local_storage together
with the backing space for the map, which update triggers the skb
extension activation.

Finally, bpf_local_storage itself has a pretty generous cache which
blows it up. Maybe the cache could be a flexible array, which could be
smaller for skb local storage.

All just ideas ATM. Initial RFC won't have any of these optimizations.

