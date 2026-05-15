Return-Path: <netdev+bounces-288278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKRNCFL5BmpUpwIAu9opvQ
	(envelope-from <netdev+bounces-288278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:45:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E3254D9E6
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5A5B31ADAE2
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08D33F0A81;
	Fri, 15 May 2026 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bL/Ss4/f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFF03E074F
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840787; cv=none; b=bJ8mYxdlgBVrSRpPDeMlEbfhmCpqiFxw7VBOp7CszsaQ8v59mckJwXhHGz0z+WPO9P2jDIirlwgMpUXnBkNZN5PVIc5MwufOgYXVguogrfFVgIJHTzE1s551DtN/nlKMJ/IhIaY3jOBFm/uqFprzrip2jZ0j4IV5culSTrYAC+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840787; c=relaxed/simple;
	bh=n6/8XoyOcyWPTIe28ELVeszjm9hAAv6mm4s2tszqSTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mu4a/mEmCRo8OuYRdSWjoJq0DvPVKGDhOi2Wts7xePkCW0hEq04fFltwSYiNPTrkhVf4Rrkcvx8EBz/8RyW3PVjT9nsnhWZ6bG8ut5jGvzREYBEpgNfowIGQpONdlCMEcs7NFU+RtJvEwXwiVhs5e0GOPTQhC/yrf1JhI8hPAA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bL/Ss4/f; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso60739175e9.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 03:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778840784; x=1779445584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m8javZePBSomMzDxRk4JOXFkifBGHMbX/5UYzJMP8uo=;
        b=bL/Ss4/fi2wuAEq6gu8KB/BY6SkHIqMeOlOpNGxCJywHG4CY04waiCNaePT+VfEAbf
         syeVpHDuy4pRy/UvU3OLclME0o0jkab8irQLYXWcIWcPguieJhmIpCFdzuzAMz2kxnoe
         6HOVNSdHcK8PluZorhVtshQZC0HB0J9XWKb/8+YVbfI5+pJ4pFH1DAc6E4ouxbdSg8Nc
         HvEJbMBivEOhkf3NNiIq0BxHVHG7ksdIyfbkiw3MNptlldqgEe7robZ+kdo4W7pwGI5b
         4apCGRBY74bhYAUsBtLV0c77pYjCDOeCUj7Bn8SJOqzlut/qAbHkRpWXPlxdmIeArN9C
         KWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778840784; x=1779445584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m8javZePBSomMzDxRk4JOXFkifBGHMbX/5UYzJMP8uo=;
        b=tNrXWlFBAHgh0nkXKWPBebjGVyg9hgVcxkKYASDJZW4UWw5A23OmyYrS1kekybB9JP
         Oc4LmGE0pyeY9R3CDZ3CtNbijAql/8DQ0kw8UHE44HublEkRARfZPPWFu2d/ClsSaBuh
         SzxzIcRONUBTqb6rflw39m/0LF5bc+JtT53j3RDa7gvBpU3UwGNZFAZo7WwQ1CcmW58h
         26kFqbJMYixNQs0gs/gqLk5Mftq4v+mkabC9nw5eSqG51WcSTRCA+LeKnKwvZw9zK+gR
         IKCLweXXTJZkCtLctTCBg61PKOq1zRNb4o9xp95xlREHxHNX3pozlhfujSQounN/V+Z9
         l8Iw==
X-Forwarded-Encrypted: i=1; AFNElJ8Ve07ZvpCKRDDKdW8aNdbBNxfe9ASFSkg+NI6VM5lxwaYGdPvnU6x0CHUsZuOwurCHVSmfenA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRUnqgCoEViY7D+aAgVjMfnU0w8zfphOB/iXBNx17LeNCi3fi/
	GQSI53n9LHmwPnoA+Nh404mcNN8ZtcGYEaDFaa2bJ6yRwJXSTXPwGwEi
X-Gm-Gg: Acq92OFtbUYvWH0/7I3vQOFvFnMGkMqDZmng4tn4Ub+pqRjVxVqaM1ZE4Dzo59p5hKt
	xtxFEkmVUmCOZejLjRo1ppmavhdHef30msnKt6ZjxbQ3hGirY72m3MDXBpjXbr+GF2woGjA1I+q
	iD3QI2j7xlybxWJ89l54N5NIdYPfcMqA65Jc0pQOtPJn8IFV1LxMl2t+YBozXbj2cuIVClpVAYK
	lCZq1Xmp1osVfpMOsasi7WOAlPAEzLAgNSUEHTN16iDvflR2p6eG9rdRwB6q/Tgn2pEcvMEmTxi
	FNVrgLZF/prrx7/Tp2p/GEaDZBZFvaaz3hIBfEnAF6udLdI6JNWN2yg0z/A7j0PQHsAArEfiYRB
	B37kbxowuRQiNLK3eTawukRww7X5+CGSkyJewqozhVos6SzQCaOO/xGyfUzu8t1qXNnBNfotjSI
	bliek5PpSOZKf7y6B2iEVpmPQ7w+H8UEFP0NVwiyCgQ9q3i+NgofuzInwFqMUfeYvDNa065L3hA
	ulPpJ273c7kKORl1/rW1i4ioxfQIfJHtmZ6y8KdWsyObSqXy3HBGbr2pdE=
X-Received: by 2002:a05:600c:2d09:b0:48f:e1ac:c96d with SMTP id 5b1f17b1804b1-48fe61f2bcemr24840585e9.20.1778840784159;
        Fri, 15 May 2026 03:26:24 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:5f66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe6b60csm14137405e9.6.2026.05.15.03.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 03:26:23 -0700 (PDT)
Message-ID: <9732fdae-5e0d-4373-90a6-251d270eae16@gmail.com>
Date: Fri, 15 May 2026 11:26:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] io_uring/zcrx: notify user when out of buffers
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>,
 io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Vishwanath Seshagiri <vishs@fb.com>,
 Vishwanath Seshagiri <vishs@meta.com>
References: <20260422112522.3316660-1-cleger@meta.com>
 <20260422112522.3316660-2-cleger@meta.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260422112522.3316660-2-cleger@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D5E3254D9E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-288278-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 4/22/26 12:25, Clément Léger wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
...>   static inline struct page *io_zcrx_iov_page(const struct net_iov *niov)
>   {
>   	struct io_zcrx_area *area = io_zcrx_iov_to_area(niov);
> @@ -531,6 +541,7 @@ static struct io_zcrx_ifq *io_zcrx_ifq_alloc(struct io_ring_ctx *ctx)
>   
>   	ifq->if_rxq = -1;
>   	spin_lock_init(&ifq->rq.lock);
> +	spin_lock_init(&ifq->ctx_lock);
>   	mutex_init(&ifq->pp_lock);
>   	refcount_set(&ifq->refs, 1);
>   	refcount_set(&ifq->user_refs, 1);
> @@ -585,6 +596,11 @@ static void io_zcrx_ifq_free(struct io_zcrx_ifq *ifq)
>   	if (ifq->dev)
>   		put_device(ifq->dev);
>   
> +	scoped_guard(spinlock_bh, &ifq->ctx_lock) {
> +		if (ifq->master_ctx)
> +			percpu_ref_put(&ifq->master_ctx->refs);
> +	}
> +

Something very odd happened here. It's not my patch but rather an edited
squash of two other patches. This particular hunk creates a circular
dependency, i.e. io_uring waits for this reference to be put down before
destroying the zcrx instance that triggers io_zcrx_ifq_free.

-- 
Pavel Begunkov


