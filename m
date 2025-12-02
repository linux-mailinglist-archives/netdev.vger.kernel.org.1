Return-Path: <netdev+bounces-243321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF483C9D09E
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 22:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5AE3A2D39
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 21:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111602F9DA5;
	Tue,  2 Dec 2025 21:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="OaNXb2zy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CC32F99A8
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 21:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710300; cv=none; b=OcnRqniVdKQzrcbJMPaxxpIZ4kcFxGErpiViQSSXei7S61Dd+NdCLqzE+DgaNeYX4Oyemu5g1knwsi6t48VF9EAXMj2D67m0/wFSLNGXE/IrTb2nfVMoTKIj8pqPw5oakfBGxHB5PZ1TEifYL0bfhp2ZdkoWoV8O/dO7T20RruM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710300; c=relaxed/simple;
	bh=BCcJdnvT9giiaMuq+hL5R6OjWImntNg/8Gw7bMNsY30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kdq+Iz9O81cQHoWYOrhLVW4kghImhxXAJX2zh73kmwp90xhanPHEdNk/iQvlKuGhEAsoU8qP4V0PVbT2OlFvONLN/3YIuUaukujROQG99JLixIp1V9aBNBulTihj3KphPSnOOixOkJhFkWowV24FiUdw1ivV9EyKOT6leSe0gYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=OaNXb2zy; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b80fed1505so6982103b3a.3
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 13:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1764710298; x=1765315098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+TS89M+UOYIgRP0ioMsh9CToRf9xqXg4uuBdhxsYAko=;
        b=OaNXb2zyIhYlEhJoLqTsjU9hfknlkrxpiiq0kF8s9GYCxwmR77Nsvd7TL3SPGo3ihu
         6XXb7q+kqx7v3rcUX3GZPphsMlFj9BRq8PVkbcwUltAouRIFkqGbWr3Jc2OcRPuq2ojK
         b+0IUXEaVols5sD2vR2oZWT8vq7hQMLHh2SpapvqQTyf/kHlKmTll9+bF+eadHc2wwlN
         eS4a31t/RZV5lpX3Ih06WSv1G3OgVdJNXUAw7JNO2oXM6+/nMYPGvgaLhIn+ifyhrXy3
         8+vIbIVKvXvRUqPhZ5701OD8q98ib3bm4Vk2jw4yk74GImpYa5ULLV3JGU9m7RlbxWN+
         qcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764710298; x=1765315098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TS89M+UOYIgRP0ioMsh9CToRf9xqXg4uuBdhxsYAko=;
        b=vNEdwvamhL3ZrLhS33TmB31KGxm8/8hhkmaswyiUJK3j3votmnBA4YG3tT7yVdGwah
         eU1Y0C6ncjQB6Fct2w8NkEb9NPTijWNpa6bRtn1S8qrQZzB6Ymy9p1jj9rX4HgpfYU1m
         7TUN1Wz8o2KPC0FVxKM4+SZ3Kr8vQFCXsvblPNwYBozUymIeZj1TQA5KovZEHEPpdPV0
         lvLaxqSbpWXgFU1nl/B16O/aJsUGc9QmIwuE4v8tZG7abfVmYpNZQ6MO4AEUTiOD4Gh/
         OKK9tqjjN2WMyS3vWr0xhdXwnECqoYZaCOnbfIbMfCRljdxV3cPqDR5Qv+FWwIfLKg8C
         vN1A==
X-Gm-Message-State: AOJu0YxSE+nOC4OU+9gwAqvmzSOG6e4shwSfvotcEk4kPk5AZ1sDEDJH
	mxp6ej6FKUPjBFTZOdCkGhdRXWiPW92vW3HH/YrZaja+4huXe3xuMqZaaGkIKWEWoZzBjmcPlHz
	JXdA=
X-Gm-Gg: ASbGncu7L0DxTQWUPlRhCbPFjtvt8UaiUY5y+3dFrjam2FZ2vXJYNx6qjj9XPRc1JpB
	xRbSCMrN9IeXRxSdCntZaCvFRM5sbLrF375w+GukRSbpAbrBssK1429UEFnur4GkELPHp+4uzdU
	7fRxaGVp2oSbELRtsnx57tyeDLAGzsxo8HnpDFxOJHXWNIIs1hlHY+D4+45W+c4nCrCl4q9YHi3
	jt3gmibbfpigVy1yxVUpwzlRWHg+UbokpH0pKLJ9zjOUzAaGMKiPr/+lrLMATt1TvujdeuIsAcE
	kZYn0SEr8KJDVrdArhLN4M6i8Vgx0cNmgvLZiAD7Ku4M7q+wpPRxy92euL+XcPXs0oA5gc4Pugn
	b4VFGF8bh+TkWJWf8zfcjTl2HU6jGp1w+AIKQc+q8pmZMoDjUfPm0mrChJFJfboGMWu7iAKYF5U
	dhWkDQf03VHcxUSmMq
X-Google-Smtp-Source: AGHT+IHGLxhaOggddAkr18uA7EfjTYRrwPUFdQ4S7vUGZMJrJsPA8L9EgheAIc0Who5MO5T2PnZuGw==
X-Received: by 2002:a05:7022:ff49:b0:119:e56b:9592 with SMTP id a92af1059eb24-11df0cc51fbmr28688c88.23.1764710298403;
        Tue, 02 Dec 2025 13:18:18 -0800 (PST)
Received: from p1 (209-147-139-51.nat.asu.edu. [209.147.139.51])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaee660asm84234840c88.3.2025.12.02.13.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 13:18:18 -0800 (PST)
Date: Tue, 2 Dec 2025 14:18:15 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, kuba@kernel.org
Subject: Re: [Patch net v5 5/9] net_sched: Check the return value of
 qfq_choose_next_agg()
Message-ID: <bzz3jovy7tsxwxa3ek3opnl2xuk7l5fuzqewrxw4syvwfzxkmj@22o6rjgiwnkm>
References: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
 <20251126195244.88124-6-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126195244.88124-6-xiyou.wangcong@gmail.com>

On Wed, Nov 26, 2025 at 11:52:40AM -0800, Cong Wang wrote:
> qfq_choose_next_agg() could return NULL so its return value should be
> properly checked unless NULL is acceptable.
> 
> There are two cases we need to deal with:
> 
> 1) q->in_serv_agg, which is okay with NULL since it is either checked or
>    just compared with other pointer without dereferencing. In fact, it
>    is even intentionally set to NULL in one of the cases.
> 
> 2) in_serv_agg, which is a temporary local variable, which is not okay
>    with NULL, since it is dereferenced immediately, hence must be checked.
> 
> This fix corrects one of the 2nd cases, and leaving the 1st case as they are.
> 
> Although this bug is triggered with the netem duplicate change, the root
> cause is still within qfq qdisc.
> 
> Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
> Cc: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>  net/sched/sch_qfq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> index 2255355e51d3..a438ebaf53e0 100644
> --- a/net/sched/sch_qfq.c
> +++ b/net/sched/sch_qfq.c
> @@ -1145,6 +1145,8 @@ static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
>  		 * choose the new aggregate to serve.
>  		 */
>  		in_serv_agg = q->in_serv_agg = qfq_choose_next_agg(q);
> +		if (!in_serv_agg)
> +			return NULL;
>  		skb = qfq_peek_skb(in_serv_agg, &cl, &len);
>  	}
>  	if (!skb)
> -- 
> 2.34.1
>

The explanations make sense to me. The patch also handles the case
correctly.

Reviewed-by: Xiang Mei <xmei5@asu.edu>

