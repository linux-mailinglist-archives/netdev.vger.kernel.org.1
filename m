Return-Path: <netdev+bounces-289499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAKvAyeEDGrIigUAu9opvQ
	(envelope-from <netdev+bounces-289499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:39:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D105581984
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C54931C33A8
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CDC408008;
	Tue, 19 May 2026 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="BwDs7SwC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37E840801E
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204424; cv=none; b=ltLI1L7QlVaW3TGgTemZ4Gqyh2I4jhOMiBsOGkn18Ndqx4jcjGKK8Jrg+0HdeQ0Fo2QvaTWn3N8jIKXz+Mtou7TAh+oRWD2Sd4qmm/AOn1v36OzEsk7pMp272XjSYahdcD07k2KSv21vKfXQpDC1luHLKGFULfpLVk5/aZhzbOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204424; c=relaxed/simple;
	bh=mcCiwEdL/4N+uKhN98EHjHskm5rIyNuC85F7WV3iSeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qin3OzcgiSNuUF+7BjepDgoUyRVw4w75iBBnNmuQsbqrLVJ/Ktz4amj6wyX3bEnqxJEu2XOn3kHwhca0STeG/on7jBm7Bd1lwg8tAtQeGsHfmG3AggWztBQ3eWOdF65tG6tTm6/C3UAFwN0WtrmyJQBUm0f7jrsYId5dgY33E4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=BwDs7SwC; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7dcd17e19b6so2032412a34.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 08:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779204419; x=1779809219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VWaUx6uYgh1JNysTgxghxLddStbx1OJmn9whh2c8WMo=;
        b=BwDs7SwCkq1Pu0vDX5NyMkGdjkwfWSXkYHhiOiOXoyR3ZsQkogmL2aBku2pOO+eHyL
         KG4S/ZMztW8EzAIvsclmA799ZifPhCWINWWsQdgPEm7tIMwUIzNFLXC1pTD1Llcxt6Uw
         rSw4rDjN/KN2jMc0+6h1fhcgnPXMBkmz1qWynhrjw6Cu26hS+TL58w6TQWT0j2fl66FF
         IUOvwtQbqQBM2KujNDma0ne9t3SN8RDasYJC7IpjCViltMaLh/yDD6UfTTm102yvxz4j
         0WC8LfJT617whbUT+wUU6dbZm3rsgasapgSkwraTR3RNQaAk+byDaOFVVJfOcvEath9u
         g7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779204419; x=1779809219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VWaUx6uYgh1JNysTgxghxLddStbx1OJmn9whh2c8WMo=;
        b=Ftph+EiE4cE4/ijEx18wIh1IAwy24wFsP2w12t5XUv4gKYh3FxTwLxJCnskLQPucm2
         E4J9TUj4qWWTK/bQrnhiNrEjDp6PW0O67yaEqUOUvUM2nGyc41r38qycI9F/x0/7QKS/
         RyPVcN4PrYd9a4t/PCJ5TqTaKmFgWiOFeYzhB8yFCe3d+tyOoGyfiB854Is/wmf2OqJH
         p3AJIneoAPoSujrqY6XDm9PrF1iy/1ZMXPvPHO2K+mutwVNaX4V/H4nKjgg0cKY8oAyI
         LG6Jl5rHVdzTqgxHW8aklcAD3Z+0MfUyn+7Q/2kt8q0qp5iMK5CnKjURUXVd+hRtq52F
         ZRtQ==
X-Gm-Message-State: AOJu0Yw5ScSr20YHBdSyu3r+EkJ0FVN16LNwsR34+6kEWOdw74e9xqlK
	L2RXEEboTIuMA+mJ0ZUB4SXAPs6oEyLgZ9qACPTlrXo9YbeYp3H3ulNcQVUoqbsfIoc=
X-Gm-Gg: Acq92OHNVjc1DeteEvVk9uqgkk7jlJMS5XYZKncmTF1d/+hIqrYnJkOtOYM0Nq6LIjN
	IpLbmGPRgzGAiALzklCRoG91v3k+anz042NhYeqqnsVOWE09slAqhl4+4aIDEx8hMs1Q/zYdcmU
	i3ghmxRubGACxCK2jYZnLoUW1D1AMwHGBxmcLoqeYlKsj5oQ4tk9SvI1rYiDor6vV5cXkar48+8
	lia6KHqjPAkLSXKlNrS1yynUaGjVs5tFJYEo+p0V2cT22vlFsf05tlV088HqOlDsCC4hfl9ftik
	kMggiAkFKt2XUxPao8y//l2GpeEcmEcUSte20qU5gj9Hh9cZ4vWVdDyVSeQiXsWAYyU3Vb+DrKV
	/7TotjmFSvRk7SXhd7jE1NR1kBpa99iSEPETXRN4JZkUsEX1sAnFesYZw7VnDb7XiSFiaBiULwe
	eWGrVhFOT9uW0TW+LIjYy8qsPjTU6p0WuSGMD+d64/GXF3eP344uUY6kHTkf5+Nwfg3bMOEgzzU
	I6nxSp/xxPrzncLaMw=
X-Received: by 2002:a05:6820:178c:b0:67b:bd89:90ed with SMTP id 006d021491bc7-69c954d3c42mr12537741eaf.41.1779204419508;
        Tue, 19 May 2026 08:26:59 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d041da4basm7138946eaf.0.2026.05.19.08.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 08:26:58 -0700 (PDT)
Message-ID: <7bfd707b-1e21-413e-a2e7-71e8df3e43d7@kernel.dk>
Date: Tue, 19 May 2026 09:26:58 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] io_uring/zcrx: notify user when out of buffers
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: netdev@vger.kernel.org
References: <cover.1779189667.git.asml.silence@gmail.com>
 <35cd307a03a43583838a2e151fc641c69abd786f.1779189667.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <35cd307a03a43583838a2e151fc641c69abd786f.1779189667.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289499-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,kernel.dk:mid]
X-Rspamd-Queue-Id: 5D105581984
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/19/26 5:44 AM, Pavel Begunkov wrote:
> @@ -1126,6 +1142,48 @@ static unsigned io_zcrx_refill_slow(struct page_pool *pp, struct io_zcrx_ifq *if
>  	return allocated;
>  }
>  
> +static void zcrx_notif_tw(struct io_tw_req tw_req, io_tw_token_t tw)
> +{
> +	struct io_kiocb *req = tw_req.req;
> +	struct io_ring_ctx *ctx = req->ctx;
> +
> +	io_post_aux_cqe(ctx, req->cqe.user_data, req->cqe.res, 0);
> +	percpu_ref_put(&ctx->refs);
> +	io_poison_req(req);
> +	kmem_cache_free(req_cachep, req);
> +}
> +
> +static void zcrx_send_notif(struct io_zcrx_ifq *ifq, unsigned type)
> +{
> +	gfp_t gfp = GFP_ATOMIC | __GFP_NOWARN | __GFP_ZERO;
> +	u32 type_mask = 1 << type;
> +	struct io_kiocb *req;
> +
> +	if (!(type_mask & ifq->allowed_notif_mask))
> +		return;
> +
> +	guard(spinlock_bh)(&ifq->ctx_lock);
> +	if (!ifq->master_ctx)
> +		return;
> +	if (type_mask & ifq->fired_notifs)
> +		return;
> +
> +	req = kmem_cache_alloc(req_cachep, gfp);
> +	if (unlikely(!req))
> +		return;

It'd be nice to avoid an allocation here inside ctx_lock and with bh's
disabled, which looks like is also the only reason why GFP_ATOMIC is
being used here.

Maybe opportunistically check ->fired_notifs early? Might also avoid the
lock in the first place if we get back-to-back of these.

-- 
Jens Axboe

