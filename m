Return-Path: <netdev+bounces-287091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIQxJKAIA2pmzwEAu9opvQ
	(envelope-from <netdev+bounces-287091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:01:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE3151EFF1
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE7E130055EC
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6008E384CDE;
	Tue, 12 May 2026 10:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htg5d6Cd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3494138E8A7
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778583575; cv=none; b=i21bdJl5sX1nO46BpgfQbNG+CXi35ReSUue+8eEvlGaFOEl1x0pAVTWFgDnAjdiAiWMqSTQtJ6lwxra5uiL4espACQaslvROoLbT9sRTBhZzBQ0T4ly2RqhQ9CFlkzr+FQ3ysMK/vzf+ijjRWRv7CdACXVtMmdqKrfAREJr1fdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778583575; c=relaxed/simple;
	bh=2O6kMZeCfa2WzuVxLVjO6q02eX3L6eA7J+7iqPYMAV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZCYnV3gQYMkokkGFXASxCuoJ7zV71ynV8XAd8Ymsnd0Y6PIZa6/9jatGmRssgllsOqBq8ycdKjfkCM2NA8pvCVcNLXR/bYFBumevQxWvqnJe4+8naWtjcTcgj+HR4Q/kfuCpu0btC5XdMjyzjjVJuaekHbNy58E1S6fGF+V4Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htg5d6Cd; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so60009465e9.2
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 03:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778583571; x=1779188371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uhHS6zVrC9HlZ4w9H9Y7re+MM/8aX/6jJDkwDStDfFo=;
        b=htg5d6Cdq6YZFukk5+nG+yX0wzoJ9Ss8Hi6w+Frzd5rNbk+/ZgcWNez/43uXtwSEze
         h+2d0/0fHDqceJff76lQ0IYJOeY32NktATIyibop5TsxzTkPEpBiqhtalzE4O8ZMj2jj
         xHiNGOar8P0og8mBB1tkuXSrlj7GJMTl/HJ82FqBgnkDymQkweYNEmMd50l6CKpXI/Ls
         6GT2LLxdoA5FghfXUsQZxXbqd1W7ooRJvZoEgRa68fbZccb3tG3msU+OubN1rCA/UiLh
         UW3vVG9kB9QZ2o5yWPSj+bmOyMAeJtCooL87mNSff/5okn2m4EHWbjvDfKiCJm3uxQYR
         0BbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778583571; x=1779188371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhHS6zVrC9HlZ4w9H9Y7re+MM/8aX/6jJDkwDStDfFo=;
        b=fSawU3yWZPGV2B302SYZLvddwFm9lVau5XvaUbuu643C1+vZ1B3QaDxuGPXi15bz9u
         JYZGWcqaiGJ7F2LLaciZHu3+/jhtA7TJ/Kj/Pt4jDYu+UiBoMnOOEyMtASEGq1SwAD5E
         WurfgeYJWlxWxqOx4I/4LrdUtskDjgqHiD7lwoP2Bj2yEZ8tLUI9qHtA2maqkvAmTlTL
         ZJnnW3hYXAt4KdP61MlbCeUd0icM1sF+XghUPKFLkjCjUna8H9HpszYFJ3P/lvzv1sv8
         QxNp4Bla8m8LAX3pV+3ERzWlnjxBaOs8TdJzqu3uwF/Z1lS2YmFh/OCa82FyVMB4wNaA
         Xq2Q==
X-Forwarded-Encrypted: i=1; AFNElJ8KeFoDuOHVWel3nPFriAa/znHAe0ZEDUr37takgd2yBkjODuguIPMG+eNuU1aS/W6lNzK49Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwASg6AIw58E6wS2oSVDJ4+d1YDiQuk5sNpAJZwfR6WNIWN+lUz
	5ua2QanAVSZdCJWxq5JJi2pW53rM8qXzbaBhq1Zk6BgxnyknAxqAM7un
X-Gm-Gg: Acq92OG11B4YvpMLAGYAKXOU8aH2mBNmv9u5rclvGSA335UIQ6KGWT4pHvuGeAXXdrB
	YM6MWfh4NNyKdCiKgXnqIb81IuljOwpQAohtggOwNsvlDQWMTY6YllnrX8q/sbsg0+CgDfSwzOA
	/Yn1dbwtKNJK70XoURDktNGV5//x8katGXVvUMU7jULMs0PnFmfvFpxt46voRFMGdy6O30nIfIg
	7aqNp0er9Lz67DnewUETlRFe7tMBeRRIw70akmNJNXVdGaAnq1H7UuAkCU/2Nqy9NHHdhZTcqvr
	YLBeaoKAjv7dmv2xuxfiBQuBG7yOhoBRaHWS+w6d5GzoETwsDgMVolh1gE5FjQh5mz1QUYmXizV
	LvxtpuzQAJAOg1HABDTxPA58yye3SCK8EvOEMUEuErpDiKXtmFrahPwsys07mys3rm2/strZSrT
	aUzeQdQfh729unVyC+jLT5iDnpPX2ERv2qeIXtgsxEVNoiuH8wi4NXxWznJUR6SJhffhztdbInt
	dIzK4SlteKUzFsEfmLD98IcGpTVY5C6zIrBe1Y=
X-Received: by 2002:a05:600c:45d0:b0:488:7ff6:1f75 with SMTP id 5b1f17b1804b1-48e707f821dmr219403715e9.21.1778583571615;
        Tue, 12 May 2026 03:59:31 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::372? ([2620:10d:c092:600::1:8c90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6b00fsm35042477f8f.11.2026.05.12.03.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 03:59:30 -0700 (PDT)
Message-ID: <1ae85366-de3e-4891-8581-bdfc6e605a23@gmail.com>
Date: Tue, 12 May 2026 11:59:26 +0100
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
X-Rspamd-Queue-Id: DBE3151EFF1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-287091-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[asmlsilence.gmail.com:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 4/22/26 12:25, Clément Léger wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
...
> +static void zcrx_notif_tw(struct io_tw_req tw_req, io_tw_token_t tw)
> +{
> +	struct io_kiocb *req = tw_req.req;
> +	struct io_ring_ctx *ctx = req->ctx;
> +
> +	io_post_aux_cqe(ctx, req->cqe.user_data, req->cqe.res, 0);
> +	percpu_ref_put(&ctx->refs);
> +	kfree_rcu(req, rcu_head);
> +}

Note to myself:

io_poison_req(req);
kmem_cache_free(req_cachep, req);

-- 
Pavel Begunkov


