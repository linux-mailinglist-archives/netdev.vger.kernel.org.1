Return-Path: <netdev+bounces-210191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60686B12476
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 20:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4328AC6B97
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 18:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF398253F2C;
	Fri, 25 Jul 2025 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyATfJSx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0F925394C
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 18:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469781; cv=none; b=jCd650ozGC2TkNPNbY+U8kn9KBRRHwDsC11gw/R6uFFgHXLVTtoTbZ27znN705ubmWEEQO1BtL6dmEG2vxEPgboPIwDueuB6nDEBNGWXzZSX1TxDYJegUG9opqJwjrdGRAi0hfxyTXotDE9VbW9gjiZL/oroHfBRwiUwuoXy0j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469781; c=relaxed/simple;
	bh=w72PiuRLD/VW7rLyweIirifLc6g/pDjq7GkYSncvxHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8DJjzFEpOHBbs9F52GRFDNa1iIihQVxiXWxbDv8/ARPzGEtZCziod6uQsc10yYC+gj6u5DX7n7YdQLGjcd4/wyhafnWBgU+77GlZV9wuL/Wmj6h8855TU9rq4EYjS5TBzbEDbneY0p7wkPScuEaUU1am6mwU8qEkPMQG1YkdxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyATfJSx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2363616a1a6so20657425ad.3
        for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 11:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753469777; x=1754074577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yCFjTSAyR05tZxAt1zg3lCnQ5nBd70ZmiaJSsK2JjLw=;
        b=CyATfJSxbOHOxcDOUT5SAORzD1GlgR2IvOD77BCZaoFB2F1PMjsVaSHlsS1v5Zc0i4
         s5egtzAeWuEE4cMmxdqYLcPDlr68ogRjMnLDiYpWhy7bLI41rHHvOdCLzNZ/cNlzNQDn
         bKsaPpsg8Pj4qS3hHHEPe9XDAHJStrz2OtWll8B1u958eGC8YP0Uc1WvbfS3suGUBIHk
         fO6gKYYeantJc+iV1G7y2FeDZIsOXljijJpjnyyjlWB+TzcKgDEcIDebe5znv9qyGHvL
         LpizQFomFBAE4D2fXMY8nAnaB4a0BN06KfJXABIRvGG61ZE/Z6WYNBBzZ72Lzn24KyyQ
         zBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753469777; x=1754074577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCFjTSAyR05tZxAt1zg3lCnQ5nBd70ZmiaJSsK2JjLw=;
        b=vOCJ2eAaKJo5P1M9dGSoKpVocEpqOevKHk9wFCY5uoNsbn82z3+AHPw/Fo+I3/QFHF
         yt03m740W4LNhTFEXnECxhAAVtC9i4b675nHjIGMQojx+d7EkknOxgKqaBxyfhkfCSvZ
         siurhp/NR5O8IA25RgL0CiK9ARo0ViJoyt5c6g/G0eDC4jsAoTvZf0Lo66VulXLAbK2k
         01hVnHpqy6aEn0gsnDn3ertIv++TjXcQoGSBZm0h5fkOz43vf0Fr9s1Dpnazk0CFlUmO
         jUg5XMAyortfEet5+Z0u3e/Xo4u0kVggywrZnb0LmV/SbDlBz4yockb5KhLP22F/G3qu
         nVZw==
X-Gm-Message-State: AOJu0YwTU4BQFWQbHZMywPXhszf6ZBOzDkWmk9syKXRdCWGyWZDR33nq
	9tl9zFWdS3yS+7tWu4Msol6S7bztXklb98c//61UlEMCrPfq7J/8kCmp
X-Gm-Gg: ASbGncuhNfU8GefiEjnhIB1DYPhriz26+RrSnvCOY1PRJ4D05GorCH3kuCMv4wKQZpv
	IHRTEiIh/Csa8R58zGzxH+vG7G9v/JicPGn2Xetj1J0mSfd69S2u2I9u+Mcksx5yAwo//0U3ItB
	IIjAO1FLujr6fgqBR2zVTfL8c6VNw0gdYA1efBrPPHcF0NvYxgL6XMGufJLsSRHT5bSikryb71V
	2yrbr6Jwt8XmgtC6fFbS9SugqzQ5XyTHm3MoyyWFwBo9bDbcx+69SNi6aU9Lg7scUxOWP9puy9v
	Y6NiB72zLfFHbwdvmaHF8P8ysExzmMcma23GPfn+N1fomsZhfRNlko9hUh6z6qLtHndO1W2wDPf
	xg3MuktRWtFDierItwBnpZV82iw==
X-Google-Smtp-Source: AGHT+IEUOsBOgtF7NrzpyDhQ3+jBYN3NWOXkOOyDrjaFjFfio5NOFHJV2F3FLFXOg8tPRLAoD6j17g==
X-Received: by 2002:a17:903:19e4:b0:23e:3164:2bf3 with SMTP id d9443c01a7336-23fb3126028mr47568705ad.28.1753469777504;
        Fri, 25 Jul 2025 11:56:17 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e83507c40sm242454a91.21.2025.07.25.11.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 11:56:15 -0700 (PDT)
Date: Fri, 25 Jul 2025 11:56:15 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, pabeni@redhat.com,
	kuba@kernel.org, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, savy@syst3mfailure.io
Subject: Re: [PATCH net v2 1/2] net/sched: Fix backlog accounting in
 qdisc_dequeue_internal
Message-ID: <aIPTTxhfC519+cdr@pop-os.localdomain>
References: <20250724165507.20789-1-will@willsroot.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724165507.20789-1-will@willsroot.io>

On Thu, Jul 24, 2025 at 04:55:27PM +0000, William Liu wrote:
> diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> index 2a0f3a513bfa..f9e6d76a1712 100644
> --- a/net/sched/sch_fq_codel.c
> +++ b/net/sched/sch_fq_codel.c
> @@ -286,6 +286,10 @@ static struct sk_buff *fq_codel_dequeue(struct Qdisc *sch)
>  	struct fq_codel_flow *flow;
>  	struct list_head *head;
>  
> +	/* reset these here, as change needs them for proper accounting*/
> +	q->cstats.drop_count = 0;
> +	q->cstats.drop_len = 0;
> +
>  begin:
>  	head = &q->new_flows;
>  	if (list_empty(head)) {
> @@ -319,8 +323,6 @@ static struct sk_buff *fq_codel_dequeue(struct Qdisc *sch)
>  	if (q->cstats.drop_count) {
>  		qdisc_tree_reduce_backlog(sch, q->cstats.drop_count,
>  					  q->cstats.drop_len);
> -		q->cstats.drop_count = 0;
> -		q->cstats.drop_len = 0;


Is this change really necessary? This could impact more than just the "shrinking
to the limit" code path. We need to minimize the the impact of the patch since it
is targeting -net and -stable.

The rest looks good to me.

Thanks for your patch!

