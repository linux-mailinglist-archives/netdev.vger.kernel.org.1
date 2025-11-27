Return-Path: <netdev+bounces-242136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B08BDC8CB63
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 04:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699EE3A695F
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 03:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A298624A058;
	Thu, 27 Nov 2025 03:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyBe4L7K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C30A21C9FD
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 03:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764212517; cv=none; b=RhWAZCk9ff2Klid+bdLnup5l9+hmaGFOg3JKx2w8WT8w684CR9ztgV+E3cYaJ4GOqeBvAbS1ETXF6s5VpLZaRgtiHQyUQkdMx+sh4CKAwTzSlSFY48pPFvuq94gby6JiXse0GKN0dmIKVmWfKg5tlz5aHfEfTJ6cw/dHQmgD5Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764212517; c=relaxed/simple;
	bh=KzPpgh5+14+7GwvfLEQbhhcnSH2NyLCUhtNfZjc19D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMiNMzDXYXEiXqZDPQXp8Uq2UFn10VC2V2IRbxce2R8brt64Bl50Hzi8iTjer4o+aiHxReIDMR2GrpdVpmDglZM+VX7s5eBrnZ0oxbCdP3Y0QjGX9p5ppWn0UqWkUVQZZvPdJZlhBqap8dUCuufrx/FnU0BgwL8GO8ByCf+iUGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyBe4L7K; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2980d9b7df5so4781695ad.3
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764212515; x=1764817315; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IGvTCI861DqWFwZLbgubWBCCfl7KjeqeuprB8SsYcFc=;
        b=EyBe4L7K42PtIyzYH/NK7aR37CKZn+bSjv4r4Tk1JZturIqeNc2TUyBXBZB5W6HzlJ
         TpHL1FKrqKGV6NGEqYErwDYVTxv4hZdLCmoJuJcfj0fkd6OlZ49NSLE9Ih6kSDQjtm/C
         XPt+LquF+3h5o/LRVfIaEVDoBpFP7wRsYcbusawPTAhDxkhoal6UXiiuM0bkE7Yn3k11
         84UVgd8Yiw+fn48fy16W0q0uN4rwbAjiQDER56r7UML7xlhHZQHZHpz6FxJvU4PWyZ2C
         sKAJ545jx2W2YzE0vJx/GME4bqa0yIGVk2QcMHXdL4iENsohUxwgTSMigERyUcbgkSKx
         aQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764212515; x=1764817315;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGvTCI861DqWFwZLbgubWBCCfl7KjeqeuprB8SsYcFc=;
        b=jFk1LqeMntnl7F4Kmd7GZiVG91BtRQYd/opKHA2BafFJ9k/Q/T1INI7A+bNvlviZhx
         mO1RsRP6FN/PAT9fXwCWlfDhvOmRcwM4CNLd1Gi620PnbLJzdAaSZ+CSuPAOlI3fW6IA
         KiCSyOwsC923BUJaeW7OOAUnHqoIRyu3+3S61dIkP5iqeJowa8Ka3sq4dKX8vGUw5NAZ
         8iNwWK9EaXkkp4klNwduUtjIcVe3DvqsMfeVA1ZGgQbNO9FBM+wUsbPcts9ymXZPR4tq
         r/rkHeSWGXC0UqMRQ0PtVtUIBrfsGy5kcUB5fnXbSV3+8rkKMdo2o3pE4awghaxqC9iT
         33hQ==
X-Gm-Message-State: AOJu0YwWCZp/dRCK/H/ysMG2J45zbCC2AQXF1+w+gYKwY9Tgvxd+dxor
	Eft84KkWVQ8O5ebyA7DEcY34fxK4OCHp6XKGsWAlGUMiD1VuE1fybFFSD3f6yGdt
X-Gm-Gg: ASbGnct4igr+/30/quGLZ+chTopTj2STSoHqOxwHXYQFaRwZufZKkKxUo05QbUv8LEh
	Y6L2MubA21NdDLi5y6drFsm/ZTsBTGl/P6fmS0jhXj6MkTbUpDCiJenMC83MQH4f9B4cc7tLGdC
	IXvNOBAvmrcuI8z0/WQEpLaepY8khMoC7Hbyc8pCM26gMFcFjYU98KcBsGMDIjt1lMYcMj0p56m
	CKXVVpSTOeC1gzY6+PNv4BfRACgursaxUrAWr8NsqTpO6iu/SSbz+gVxlWyKvfH/hGVcm2qdT+M
	wn/Ddn3cx5lgHQtmTjesYnkXsoxR7dm8NJ1XjnF+niQ3gKBwJRInBLwugKnTDOeSO1x7s3uzhl2
	njFPIQDu8t9l9gntu+S5XPXSYoanty+Jqkeq1DmxDXgeErkaQ361zvRGlvLnbHURPfaGpWQ6trU
	TcDSrnykKMTLT40Aj1
X-Google-Smtp-Source: AGHT+IGRT0rPXgavR5Wlc5N3Ac510ixjKoVAdH3gBMYR1YeQFR/jNjnUOn1IKiwsu9HYhU/lPchdXQ==
X-Received: by 2002:a05:7300:bc83:b0:2a4:3593:6461 with SMTP id 5a478bee46e88-2a7191414e4mr15840472eec.17.1764212515102;
        Wed, 26 Nov 2025 19:01:55 -0800 (PST)
Received: from localhost ([2601:647:6802:dbc0:91b6:79f3:c6c8:a62])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a9653ca11esm1960959eec.0.2025.11.26.19.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 19:01:54 -0800 (PST)
Date: Wed, 26 Nov 2025 19:01:53 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, kuba@kernel.org,
	Savino Dicanosa <savy@syst3mfailure.io>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [Patch net v5 3/9] net_sched: Implement the right netem
 duplication behavior
Message-ID: <aSe/IfNSZBTTAfTA@pop-os.localdomain>
References: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
 <20251126195244.88124-4-xiyou.wangcong@gmail.com>
 <dEmtK-Tj-bnNJVo0mNwP1vJ1cj9g0hqnoi-0HJdZeTittbRmmzE4wBRIjapBAFQNZDWgE4hcR27UrTSuiGj_-yRFntfX4Tuv4QP6asVecZQ=@willsroot.io>
 <aSd6dM38CXchhmJd@pop-os.localdomain>
 <JgkxCYimi4ZuZPHfXoMUgiecvZ0AKYxbIhqPQZwXcE4yC9nYnfproH5yrmQETZUo55NOjj5Q9_bOFJbWI351PFvc9wv3xiY_0Ic9AAsO1Ak=@willsroot.io>
 <aSeJo5C9tA93ICcy@pop-os.localdomain>
 <mz8HnpeShmNHFgeE6yoGG_gb5l1mHqvNee9aRtGX6yTz5zDvf2I4U1wKtH9k5qkfz0SfUfhsonzrzDSgvyM9vRRyvktvYwtTHvfmcZK_Sp8=@willsroot.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mz8HnpeShmNHFgeE6yoGG_gb5l1mHqvNee9aRtGX6yTz5zDvf2I4U1wKtH9k5qkfz0SfUfhsonzrzDSgvyM9vRRyvktvYwtTHvfmcZK_Sp8=@willsroot.io>

On Thu, Nov 27, 2025 at 02:09:58AM +0000, William Liu wrote:
> On Wednesday, November 26th, 2025 at 11:13 PM, Cong Wang <xiyou.wangcong@gmail.com> wrote:
> 
> > Again, it does not violate the man page. What standard are you referring
> > to when you say "expected user behavior"? Please kindly point me to the
> > standard you refer here, I am happy to look into it.
> 
> I meant long-time existing user-observable behavior (since 2005).

If you believe this does not violate man page, then it is safe.

Otherwise, please be specific on how it violates man page. There is only
one sentence in the man page: "creates a copy of the packet before queuing."
Let's reduce it down to two words: "before queuing", please kindly point out
which word my patch violates. I am happy to consider your opinion, but
only when you are willing to help.

Keep saying long-time or user-expected does not help anything here, man
page is the only "contract" we have with the users.

> 
> If you were just trying to fix the bug, then a fix that prevents DOS and changes no existing observable behavior is better imo.

The problematic behavior of duplication is the root cause. So, we can't
fix the bug without fixing the root cause.

Let's put security aside, it is still problematic logically. There is no
way to define a logiclly correct behavior with queuing back to root.

Since you ignored my 3-page long changelog, let me copy-n-paste it for
your convenience:

   Single netem hierarchy (prio + netem):
      tc qdisc add dev lo root handle 1: prio bands 3 priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
      tc filter add dev lo parent 1:0 protocol ip matchall classid 1:1
      tc qdisc add dev lo parent 1:1 handle 10: netem limit 4 duplicate 100%

    Result: 2x packet multiplication (1→2 packets)
      2 echo requests + 4 echo replies = 6 total packets

    Expected behavior: Only one netem stage exists in this hierarchy, so
    1 ping becomes 2 packets (100% duplication). The 2 echo requests generate
    2 echo replies, which also get duplicated to 4 replies, yielding the
    predictable total of 6 packets (2 requests + 4 replies).

    Nest netem hierarchy (netem + netem):
      tc qdisc add dev lo root handle 1: netem limit 1000 duplicate 100%
      tc qdisc add dev lo parent 1: handle 2: netem limit 1000 duplicate 100%

    Result: 4x packet multiplication (1→2→4 packets)
      4 echo requests + 16 echo replies = 20 total packets
 
If a netem clone is reinjected at the root, then each duplicate enters the
entire qdisc hierarchy again, so the clone becomes
an input to netem again, producing: 1 → 2 → 4 → 8 → …

This is no longer a single probability distribution; it becomes a cascade
of netem stages, even if you only configured one.

The behavior becomes structural, not probabilistic. Which is not what users
expect when they set duplicate 100%.

They intuitively expect:
- One duplication,
- One netem pass,
- No recursion.

This matches same-qdisc enqueueing.

This is why the right behavior matters for users, regardless of security
concern. Hence it must be corrected.

If any part of it is not clear, please let me know. I am very happy to
explain to you. If you need, we can have a video meeting too, happy to
walk you through this step-by-step.

Thanks,
Cong

