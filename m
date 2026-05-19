Return-Path: <netdev+bounces-289500-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGFoBumJDGo1iwUAu9opvQ
	(envelope-from <netdev+bounces-289500-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:03:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7214C581E83
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 934EE330B7CB
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF49288B1;
	Tue, 19 May 2026 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKxpvy3z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846BB26FA60
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204622; cv=none; b=IRJqxJIUSO6S62qFiJ2mqkybx5YO8f6nNCm21NYKc7UZdr+UnuspzDByIIPDa3BNXP4xr7HkzvGQbUYzi9BBoVMqZ5s8lkA3EDJime1Hbo2pyg6vT3+ubQuQLtLGR/IvtfyuA8UJKkxm1y9LVhYxXFEfy7FruLV4QDiZd26IiA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204622; c=relaxed/simple;
	bh=3cVHgqIhhod6UbrrDiXCF41PWBnI/2fX43l7euUBMLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PY0llLiJOs8qRpaNrfEzp7dUhBYppnu+h9zniLGbb63kdc+rIECWTJiiGY6NjUA7OA5KL6S96cvipStReGerUxX6pkIfO5xIkaVTdvm81trjtfbpk0EJG0q8JijCHbCtaZerQ4U2qYpXIAZjoTtbC9z/XCCgVFEfeyIz3L6Ew1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKxpvy3z; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so31005895e9.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 08:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779204619; x=1779809419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AtAvdKbTK0hlYdy2YZop5t6x4T6dhodW+7Bm3nuCt7E=;
        b=DKxpvy3zkHujLm6XFfg3C0oVMzzBqmsekQUe7OGWOFrOO6Wnbf9Su4apMnOngUcmsS
         DlJqeE6vPxjcP2nhjgVpGW7BnVlb6hzxQ0q3s6Pr1pyAH7sO0db+92NkpX/KwBN0/5Pm
         k8nDSrYYzlxPnslJnLfHJlAsfev9tyEaHxnjXjRdfTbTpDmFVMTtTKhLqMMQtN0ibVm3
         T7rlZVJ9p4BqJFSlgWu/Fc3rGRRcmZQi0FY1M3PpwJO26z39lHYQ4DxknK9k1HBSpzTb
         3oawGIDFjOWSqjKK6je0MPYONgGINqBcSZHohm2mcN7rio4rl5GExdRHqVJ4SgF17f/V
         jmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779204619; x=1779809419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AtAvdKbTK0hlYdy2YZop5t6x4T6dhodW+7Bm3nuCt7E=;
        b=PQ38YHzg7UgRBIj9kp5qyPg87VIZyR+ylkvPxzD2+DKVwnt83DsdyeEUlJFWa4S8+z
         MkHS1oiCqotY2E4/bmOfPiNBXAlRujL22qQZIkYHjq6kFmiG7asRh6E2cUkTsJr7MgS7
         6JfxSGSwgRtBRgY0BsTu3L90Iz4ZL2jnhCqcZaYpYAaG1c99hopu47SsRz6C20uGfr4E
         xWaR3TT87u/Bd8cgDKXrAPIKIs1z+p9kVg+fvnmDKMHWXgSXu/tqkLN0uck6BaoPhviI
         bXgj3sB4+ZNj/vohFid1U9GS8iwayYg39LYpyNHW1pHUJzTNNuvk5zI4N/cZ8Z4FhxIF
         gguQ==
X-Gm-Message-State: AOJu0YwNnipkik4sgC4nawDbqtTfCedViNi6yYt1vSCxRQIDZY1SNjGu
	5A/F3iIiXX0AfwZeUzxF+hTbpw7C4RTfdy8bvmIgtVkr1NQXGPn41CoV
X-Gm-Gg: Acq92OFsxtuoG0xgXSL2WPtTduknrKERc2Azgvo645bXO+jFoqvt8BvXtTyDNmSNgCQ
	QZwd8oMOxEFcSqhS/c4q5eHZpS+Jd0/FymHOBvPVTIsYiZriieCEeTZEA+e3msQMfJWqpUAKQpL
	fsLf6Iu+aOo+wmmuOoZDXQMQIdDML7E0YoiWON8AuGAjqc712PvQyV1MCU+dMG61uzkAYjl56SR
	sj6K3kPd/l2FYSD+QEGWVG0gKYkn4Iso/xlI6t7kU4r3Ufj1zeDzDH++NTN2apLLP1YzKC5WZjH
	f4SCe6kSpnbLbpxkyPa1IJ27jHtqFPczWl5eimw3gAzpMxJ4fA7Zmn0K7AcGxwfiq2HV08nL5t/
	yOFkeDHJ+j4IjvZK/k+CSA7yd4QVpEwLhqDc11EOAOLdLZPRTJmYytQaTxPHH5AwKnvkQ4QZ3Cr
	6wiwcfQJkRQS6sn2+LghPApofO+i6Av4fnHTqM6t9B4E0o8s+SJzlNkcFD5Q/U8UuGbBjoxRA0b
	w8Mx3+pSVzfo/i3OCWCG+2hnKjQ4oPyZN1Pu1Ml7CAL7/ELJ0wBKy2wEstlXZwZHOTs505hU7aM
	JQ==
X-Received: by 2002:a05:600c:a11c:b0:48f:e230:8cac with SMTP id 5b1f17b1804b1-48fe662a1cbmr230777895e9.32.1779204618708;
        Tue, 19 May 2026 08:30:18 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13a7sm48477498f8f.29.2026.05.19.08.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 08:30:18 -0700 (PDT)
Message-ID: <6d1187c8-ba4f-41ad-b692-351d8b072038@gmail.com>
Date: Tue, 19 May 2026 16:30:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] io_uring/zcrx: notify user when out of buffers
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc: netdev@vger.kernel.org
References: <cover.1779189667.git.asml.silence@gmail.com>
 <35cd307a03a43583838a2e151fc641c69abd786f.1779189667.git.asml.silence@gmail.com>
 <7bfd707b-1e21-413e-a2e7-71e8df3e43d7@kernel.dk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <7bfd707b-1e21-413e-a2e7-71e8df3e43d7@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289500-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7214C581E83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/19/26 16:26, Jens Axboe wrote:
> On 5/19/26 5:44 AM, Pavel Begunkov wrote:
>> @@ -1126,6 +1142,48 @@ static unsigned io_zcrx_refill_slow(struct page_pool *pp, struct io_zcrx_ifq *if
>>   	return allocated;
>>   }
>>   
>> +static void zcrx_notif_tw(struct io_tw_req tw_req, io_tw_token_t tw)
>> +{
>> +	struct io_kiocb *req = tw_req.req;
>> +	struct io_ring_ctx *ctx = req->ctx;
>> +
>> +	io_post_aux_cqe(ctx, req->cqe.user_data, req->cqe.res, 0);
>> +	percpu_ref_put(&ctx->refs);
>> +	io_poison_req(req);
>> +	kmem_cache_free(req_cachep, req);
>> +}
>> +
>> +static void zcrx_send_notif(struct io_zcrx_ifq *ifq, unsigned type)
>> +{
>> +	gfp_t gfp = GFP_ATOMIC | __GFP_NOWARN | __GFP_ZERO;
>> +	u32 type_mask = 1 << type;
>> +	struct io_kiocb *req;
>> +
>> +	if (!(type_mask & ifq->allowed_notif_mask))
>> +		return;
>> +
>> +	guard(spinlock_bh)(&ifq->ctx_lock);
>> +	if (!ifq->master_ctx)
>> +		return;
>> +	if (type_mask & ifq->fired_notifs)
>> +		return;
>> +
>> +	req = kmem_cache_alloc(req_cachep, gfp);
>> +	if (unlikely(!req))
>> +		return;
> 
> It'd be nice to avoid an allocation here inside ctx_lock and with bh's
> disabled, which looks like is also the only reason why GFP_ATOMIC is
> being used here.

I thought about it, but it's already bh, it'd need to do pre
allocations + caching to be reliable, but that's left out for now.

> Maybe opportunistically check ->fired_notifs early? Might also avoid the
> lock in the first place if we get back-to-back of these.

Slow path, doesn't matter

-- 
Pavel Begunkov


