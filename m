Return-Path: <netdev+bounces-235480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 362A8C3143C
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 14:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4172C4F1F4B
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 13:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0FF32862C;
	Tue,  4 Nov 2025 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDKE3zMT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC032F90C4
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263490; cv=none; b=UaH54E+0aL65FmFOPN6WqdwKSelKytYvDS25TAq+6Hg07ERdnSVYbMaFaTh4Fr26rjK6gkKEP+ggiVb3Mum0h/Ougn2m+1Z5IL/tReYMG5CtoGGQplKhsyOtXO3odiBnDF3wIWyk7enxb37RxpIUdhyhW85VkBY/12a/aMBxzaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263490; c=relaxed/simple;
	bh=b+4MFJ1P4fD0WLQwYtySbmNZfeOBeQMdgCxN60MzNfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ia+FZH6NettyPysVdj9DkF8TzWkvyXYNjnyH2RRkSc3yyrK1ph8LJNxVkHJhIIiQ2MCh6EsRJezTD1feEYMsII3UI+ACWKMj9Jax75Z8vkVAVIDwZbBBCkLuheD3b68hNrEED+kj4Ih2SsMmmijJfZXFsC0xCFGbYHEdQDvt94c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDKE3zMT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477563e28a3so5160915e9.1
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 05:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762263484; x=1762868284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=716JUp54HLtiXbrW2pmciFc8haFAbjAYRpxOJ1zhcr0=;
        b=QDKE3zMTLH9+fhrItuC/xGBYWZf/l7BRYt7AmqMwZtcGOydZPu9ZGOHOd0hzSnuikn
         0umotZByJQ61oElBEus13qYKEInjW+NOuf2d8moa23sO7WLjxh/pmWSBIGcPqhNwoGmD
         1F3XlC/kbV8g/fGq7spGelkb9N20p0rwS/0eSqqzG16WnSMZviHVop5BxUoKdvAPXOp1
         hfyIiC7FSIz8PmfhjLobIMy86cQMfGLdyWRfJKebz7DcKF7tc0lgWFCFSCJFRXX1HauH
         73twDbuQR2DQgbhu7r9dl/xbvPGTaN07l7iVzhjvxag0pJ15vu/Mk3TRXc/0MiL8HyI8
         8R3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762263484; x=1762868284;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=716JUp54HLtiXbrW2pmciFc8haFAbjAYRpxOJ1zhcr0=;
        b=MMACpbylRqGjRbNnr9I/czXet5C4aHQ7ASWv6KiG4TGIQfRV8FQ2GhXMZa+Dk9dEPk
         NMAQycgg/j6eDPWkMEKaf6DQHUkPlSE6qYMd+IoAsZYcqxH8tEdNpdH28hqrzHXD6nuN
         RMc5YpguMxp7GnhsxXIlVXe1AzBQamrxWFFFeQlt44wBVl4Hux/sKxkPes6Ptnav+X39
         Bqoi/KO8/S7Dmxu10iJFBXjlYt2WmVsFjOUQ4HpbtroOTf+fKqv6p5r8mTzlSXiebl3S
         diKUBQ8+mS4/Ceo5/eU5L5MB2snX5Lz4OBDPim6QaYQhCWs9vM7ramuxTy5C+rligWLd
         c7bg==
X-Forwarded-Encrypted: i=1; AJvYcCWGCIl8EerJ2oFZ2XvxjvbpUfoB6Mcqwp7ZF568VoEBYBqQhZnt2c4f6JCMo6JdVbI3kza42Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCNzYoACBuHOOEUqpcQVwvHU4QhipIOf1qPIS+6dE8o+vtP1BJ
	xFp0TAD+sGY6h8zoXWUG73RvHolrMX9UDlZai4OfcuO4tOVGFxB96kWf
X-Gm-Gg: ASbGncu3vW5oReA3lWAiyaG9DxWhXVgZH23rRrCpAXu4L+kTEdt+ciCz14N3+02vpM7
	URmx5mfRucf4eWiUqJNIX/Tc3ECPVxlVZJDlTYTnBwV6wjNGDmOEXkFm/LdYVKJBZEpYp8OUULR
	jEZ6tVE5gbXus20g4nwmmFyKj4LqTIgU4hM0yY6vmQjGLTAilCtC0fGRdzR+ON6m9swOKg1/rs4
	HuG5qVDLAWJy6MiE6BC9R9cdy0XXgKYpzHpvtsIyndmJFpTB1mfYf8ERLUBu1+OIaZUwsFzNZZ9
	hfc9H0Pnd97maKYXzZGdq1eOg8mL6Vacl2r4tccN89qf6+Dda2ExAOjA+PbawdTuLd2WYXpGtpc
	k+269ZA8dzCw29hWGWoo/1HDX0q+ydIbcGEpJKV6TVy7ZjZ2DMqkb6SibBitRATe3d2VRXdQoGv
	uPkiPL1g0OZbeTtB17cdA6uzRUCzgZncQQ4C3SZgNBfCdIsOsm5fc=
X-Google-Smtp-Source: AGHT+IGIdycrxy71HgH6Af4ITn325431vaJhiq25nsAZXoIWw1PHU3PRJFe7+cWlwbxB69ZNS54Gfg==
X-Received: by 2002:a05:600c:282:b0:471:793:e795 with SMTP id 5b1f17b1804b1-47754b897e3mr20588295e9.0.1762263483818;
        Tue, 04 Nov 2025 05:38:03 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1fdae2sm4837075f8f.41.2025.11.04.05.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 05:38:03 -0800 (PST)
Message-ID: <e92c80f7-de26-4a06-a100-5947e6ccc739@gmail.com>
Date: Tue, 4 Nov 2025 13:38:00 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/12] io_uring/zcrx: reverse ifq refcount
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
References: <20251103234110.127790-1-dw@davidwei.uk>
 <20251103234110.127790-10-dw@davidwei.uk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251103234110.127790-10-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/25 23:41, David Wei wrote:
> Add two refcounts to struct io_zcrx_ifq to reverse the refcounting
> relationship i.e. rings now reference ifqs instead. As a result of this,

Note, you don't need the 2nd refcount in this patch as there is
only one io_uring using it. I hope not, but there is a chance
we might need to backport it, which is why it's midly preferably
to be kept separate.

> remove ctx->refs that an ifq holds on a ring via the page pool memory
> provider.

Nice!

> The first ref is ifq->refs, held by internal users of an ifq, namely
> rings and the page pool memory provider associated with an ifq. This is
> needed to keep the ifq around until the page pool is destroyed.
> 
> The second ref is ifq->user_refs, held by userspace facing users like
> rings. For now, only the ring that created the ifq will have a ref, but
> with ifq sharing added, this will include multiple rings.
> 
> ifq->refs will be 1 larger than ifq->user_refs, with the extra ref held

Can be larger than +1 as there might be multiple page pools
referring to it.

> by the page pool. Once ifq->user_refs falls to 0, the ifq is cleaned up
> including destroying the page pool. Once the page pool is destroyed,
> ifq->refs will fall to 0 and free the ifq.
-- 
Pavel Begunkov


