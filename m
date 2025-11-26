Return-Path: <netdev+bounces-242090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8868DC8C296
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 23:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 028F04EB072
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 22:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0FD31987B;
	Wed, 26 Nov 2025 22:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRadHfye"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D581259CA9
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 22:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764194936; cv=none; b=HLDPRLazwk1lPPGt0SXzFCBV1D8uGfhtCorZq/VgYdKNCPLfEggYrYLbCXOrWeYJXciqOPkp0RBWZwcwrSjc8PQ1OhNxaPHTZdO5EDypfSr5ZP6PB+YWiRTtgvJCcRK/E/j1HRUcbCixr+mNytUpXoDf3MO6lu5MtGAHUWEmaBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764194936; c=relaxed/simple;
	bh=qo8J4vX3Cl+fXgul/+D4hqX+EkuSwbaUduyZBjnXG7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPbDNcV0xc/ZwmV9tfnRCk74HooPWKdSdZMK6aSbi1RAfX1sN4/Y/9BM+obvhMZdU5p0LCFNapz8JuhLBYrpwnAya3qM3IYmSXmjJsbt0h9JhG7Zb7wtwy+CfsFYcVLwYMrAe6rZ2QTd91ibMzkQQ292bYlNVzYnZNy+563fXxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRadHfye; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bc274b8b15bso229070a12.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 14:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764194934; x=1764799734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CXErpmGNacw7RWfh13rb6Qd/mQvzoh37ViyGlgUKAdg=;
        b=LRadHfye0fqSKZ3gP7WHtLaqOUhIVaQDH0rE/VUVdAREiJm39cJnYhL1+Qtn2KBX5s
         RsvtMwkEZY2x7yMcRQInTDKBDpRzhheTb5g/glXmLq3534oQvjYTdAdH5wxoDgN69ZWU
         YvPa+3fDbSk21FFD6TeHZ4VZ25BsXY02JbIwkfefZxLPhob3ZG316mysAXxhPcoNNVwa
         CKh8zLcPWvzrkPyYCr334v0mrgomHu9TMN+3Gw7hLTXp2Ut5cKI27LNyzwBhoJXP7GTP
         2zAdxjXbiaJKZE7+95QyPYoYnLicBVYFGiqkLR4CfK9MbQJiW9wwRpucUGEveWwOK29s
         xQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764194934; x=1764799734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXErpmGNacw7RWfh13rb6Qd/mQvzoh37ViyGlgUKAdg=;
        b=A6MkqlDZnxrFgjgu5W00wPAso6OacIjIqTqMuGt+TjOE59l02XIesKifSlcZxwNOA8
         jsB6lSe8k7ekKT42CwgQyM+le9/M9S8AjZP0LrPKlqaLgnfrj56QLnnOa4ZjMsB6vgQV
         s0e6TQeicEL+3A13Z8gnPjLjMy4ZCWnimerDHGKbDHF/grUPjdSro4ODaT9J75ZfXKE0
         DGdPO85EGpsE9klVOJxwBR98yyLTSk6Je4WUbGqQg3/3pgSbQE5mcCbXHFs1/8TbURI4
         cgvlhRUFENVPM6K8WRe9eZr1t2jfLvPJ7rmAepGFnw2RmUKBshbE2yKNlZisVayJZ8QP
         RZOg==
X-Gm-Message-State: AOJu0YzoA0h8yHeSgElmpXcgQGKozwFNa+XH+cbspYmX4iGUifg2dKD+
	zWbT2gRfYzB+9VOpmiYqSTdgNdrdR58pVwSndl9lmJeFOKP8Dds2xqCk
X-Gm-Gg: ASbGncsQV8l+fjui9otQaBz0jIzxhyTMIkFJ1+wRYF4iio0K5PnFv2pLAyZRJxa+Dzv
	yuGhGQwRPawv6czZj94WqJNLFnxUa3S2KVu0DEIxAEBh4gLknKbkmnf/CxU+CVoCoXRWUMY53BZ
	N1R7NBMVgHV7+4fk43SE2RLhWIyZEu+C600I2h8IXRmiiWvkUx8XJ3IV9lIbu784iNfH0yRd3e5
	99lG5hpPy7jDlPKOxTx/G+mRMpkPizEPHQlwhlR+8b+63SKWX9fWbS+iMvBHwVvSmD6unYHsF7F
	3AdQk6ryPWpTXKFge1Txb1go8jhOIoBtnvXWr9kDFPX5UIbY1K9/FEd3//Bd0Gpl7raTnmXotzk
	TBCNzJ4i8VSfNirgwzAkp4gXfC609QU4s3cxaNOLN/RW4EwXbQNpE3gXaqMIScAWzP2CszSZBzK
	CHJDIF3Tz370ZNUH8=
X-Google-Smtp-Source: AGHT+IE790gquJ8/ux7I3RHBe+5/mFzvjpHNSPW2g2OeFqXwbf6jmrUlSmH0RIWOCkIFmDWOLTGL5A==
X-Received: by 2002:a05:7301:d184:b0:2a4:4e40:7c89 with SMTP id 5a478bee46e88-2a941894af7mr4401003eec.28.1764194933740;
        Wed, 26 Nov 2025 14:08:53 -0800 (PST)
Received: from localhost ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a93c5562b2sm25158533eec.3.2025.11.26.14.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 14:08:53 -0800 (PST)
Date: Wed, 26 Nov 2025 14:08:52 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, kuba@kernel.org,
	Savino Dicanosa <savy@syst3mfailure.io>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [Patch net v5 3/9] net_sched: Implement the right netem
 duplication behavior
Message-ID: <aSd6dM38CXchhmJd@pop-os.localdomain>
References: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
 <20251126195244.88124-4-xiyou.wangcong@gmail.com>
 <dEmtK-Tj-bnNJVo0mNwP1vJ1cj9g0hqnoi-0HJdZeTittbRmmzE4wBRIjapBAFQNZDWgE4hcR27UrTSuiGj_-yRFntfX4Tuv4QP6asVecZQ=@willsroot.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dEmtK-Tj-bnNJVo0mNwP1vJ1cj9g0hqnoi-0HJdZeTittbRmmzE4wBRIjapBAFQNZDWgE4hcR27UrTSuiGj_-yRFntfX4Tuv4QP6asVecZQ=@willsroot.io>

Hi William,

On Wed, Nov 26, 2025 at 08:30:21PM +0000, William Liu wrote:
> On Wednesday, November 26th, 2025 at 7:53 PM, Cong Wang <xiyou.wangcong@gmail.com> wrote:
> 
> > 
> > 
> > In the old behavior, duplicated packets were sent back to the root qdisc,
> > which could create dangerous infinite loops in hierarchical setups -
> > imagine a scenario where each level of a multi-stage netem hierarchy kept
> > feeding duplicates back to the top, potentially causing system instability
> > or resource exhaustion.
> > 
> > The new behavior elegantly solves this by enqueueing duplicates to the same
> > qdisc that created them, ensuring that packet duplication occurs exactly
> > once per netem stage in a controlled, predictable manner. This change
> > enables users to safely construct complex network emulation scenarios using
> > netem hierarchies (like the 4x multiplication demonstrated in testing)
> > without worrying about runaway packet generation, while still preserving
> > the intended duplication effects.
> > 
> > Another advantage of this approach is that it eliminates the enqueue reentrant
> > behaviour which triggered many vulnerabilities. See the last patch in this
> > patchset which updates the test cases for such vulnerabilities.
> > 
> > Now users can confidently chain multiple netem qdiscs together to achieve
> > sophisticated network impairment combinations, knowing that each stage will
> > apply its effects exactly once to the packet flow, making network testing
> > scenarios more reliable and results more deterministic.
> > 


Thanks for your quick response.

> 
> Cong, this approach has an issue we previously raised - please refer to [2]. I re-posted the summary of the issues with the various other approaches in [3] just 2 days ago in a thread with you on it. As both Jamal and Stephen have pointed out, this breaks expected user behavior as well, and the enqueuing at root was done for the sake of proper accounting and rate limit semantics. You pointed out that this doesn't violate manpage semantics, but this is still changing long-term user behavior. It doesn't make sense imo to change one longtime user behavior for another.

If you have a better standard than man page, please kindly point it out.
I am happy to follow.

I think we both agree it should not be either my standard or anyone's
personal stardard, this is why I use man page as a neutral and reasonable
stardard.

If you disagree man page is reasonable, please offer a better one for me
to follow. I am very open, I just simply don't know anything better than
man page.

Sorry for my ignorance. Please help me out. :)


> 
> Jamal suggested a really reasonable fix with tc_skb_ext - can we please take a look at its soundness and attempt that approach? No user behavior would be affected in that case.

As I already explained, tc_skb_ext is for cross-layer, in this specific
case, we don't cross layers, the skb is immediately queued to the _same_
layer before others.

Could you please kindly explain why you still believe tc_skb_ext is
better? I am very open to your thoughts, please enlighten me here.

Thanks,
Cong

