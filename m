Return-Path: <netdev+bounces-112513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2DF939B74
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 09:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49D60B21347
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 07:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4358D14A0AD;
	Tue, 23 Jul 2024 07:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MPpjeicJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF2413B5A6
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 07:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721718469; cv=none; b=m1LtQLy4bSAdvavZrPoqeyWopiw2Zfe9c2enz8wLg0rtkCwOBWAt5GFBy6UBkvpRmU/n5j7Uq0CTNrlBcnBm7EsI2HS7cFgRo8rhMrb95F0xQ97t/dr8OMexUBBZnp5D+Y3lKpJyAufbUi7xr/fAQ+/fo5KIZMTBI21sbanIPUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721718469; c=relaxed/simple;
	bh=+OBX6C6GtejNy8NzBPodSHLqKjilnUo+0lIu+8qCbfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvV51ybXtaDomtedrwXWUlVQK3X/1XO08zl6K6cv5V3jyPXqwrifwGpsRZTjLSnUEq94yk+Axa5i1+ISDp0QVrzjz9LC7SHtTinemfylVXLgAkm1xQa7nSJw/ONSZbyh82kgby/+DHG2ICr77eSTml4vQ8h0xqi+sU9H1AXHIKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MPpjeicJ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ef2d96164aso18425381fa.3
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 00:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721718464; x=1722323264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cj33ojbfrElrbAIDbnoxdxeJv+EBBbjpQCNbDVfCAeI=;
        b=MPpjeicJyO+I11bZAvgWsmv794YBYST1r+pfptC25ffrhriK+ws3/94Vd+SelCVlAO
         Z6yJ9dLB5avjJXZ/7g/OOibvwDhsRtfTthWpRMmTj5F+RkK6HXkadTF+ixT2l72dfL6y
         mgNltXgKTKywvJE1eD35VLmtRSfBO67n7wLVaLmIQDLv/5yRDwEEwPgTlCWudHtgWi4w
         UvlCrhaLzcEbQzJ1fQ+KasJAXAPhMxSm4iwYXxUFPl5xa3WC545sYXMGYfA99v2Rde4i
         O9a++8W+iNhtutuZsiNOCk9wyp1x/ETDFy8w2xlbEHJ1nTw/87xLJQ1LLP+g+mxcic2u
         irXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721718464; x=1722323264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cj33ojbfrElrbAIDbnoxdxeJv+EBBbjpQCNbDVfCAeI=;
        b=GQOsX3/vdLRaYpcu+/cBbvngD+i3tmcOp3p7He7xnWIdN8xA2ipMnEhEOd5NILoNrv
         u0HdkpC/1jaMqnVdFGXZW13e5KrQWlfLQuh/609Z7sG2gx3wpOUfJXVi+0HXRuUaY6mL
         spdWAKP49YH1HnZyt8KhcAGv0+RWmvPGxqy3C69lg8MHwekgkvNoEqZFCkk6RBoz2Ej4
         xV/7gnvCv5sB/ujqqh9fQQF5V5neMoXW2+gwtB7Sd3Frfb/G6KKIsUfqxGQs+CNOHR4j
         aud0GQi+5ZB9zAk65Fm0xtMoI08okBrbnBYInFvY+s1s07NohKK8r+hKFNi0NQO9SPAx
         9R6A==
X-Forwarded-Encrypted: i=1; AJvYcCUN07XRWtZkdk5sD3OPdUPLtr5xKZ8DjLUEyN5VCLtggI2E9NoRDn10D3a9pvkQglLme1F5cBOm7ZhMREj2zjnoMwjOChwq
X-Gm-Message-State: AOJu0YzzAjpKvRr0zEA+n6/3Vz5knNttSveHDryWcmOsZjnJMx6wnnQv
	S7hwXCjfj5uypDzdcZp85BmEvX2mvmXXHg9KgnJePOm3n73uYn0gjMOPXhvgmiY=
X-Google-Smtp-Source: AGHT+IG/tVywbRmAEoMnoev2JxGc+GA3BH8xlmMxvbYfkuglKQ6LHu8xIzxeviJVooU17G7hPmTKtw==
X-Received: by 2002:a2e:9d86:0:b0:2ef:1c0a:9b94 with SMTP id 38308e7fff4ca-2ef1c0a9c83mr57463061fa.16.1721718464036;
        Tue, 23 Jul 2024 00:07:44 -0700 (PDT)
Received: from u94a (110-28-42-216.adsl.fetnet.net. [110.28.42.216])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a2163d7d3csm2680356a12.13.2024.07.23.00.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 00:07:43 -0700 (PDT)
Date: Tue, 23 Jul 2024 15:07:34 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Xu Kuohai <xukuohai@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, "Jose E . Marchesi" <jose.marchesi@oracle.com>, 
	James Morris <jamorris@linux.microsoft.com>, Kees Cook <kees@kernel.org>, 
	Brendan Jackman <jackmanb@google.com>, Florent Revest <revest@google.com>
Subject: Re: [PATCH bpf-next v2 5/9] bpf, verifier: improve signed ranges
 inference for BPF_AND
Message-ID: <cgarsuloniffcqn5zjjomhmm5xd72t4cdiwavjqnvmgqfuc7dd@2itjdtwcq7gk>
References: <20240719110059.797546-1-xukuohai@huaweicloud.com>
 <20240719110059.797546-6-xukuohai@huaweicloud.com>
 <a5afdfca337a59bfe8f730a59ea40cd48d9a3d6b.camel@gmail.com>
 <wjvdnep2od4kf3f7fiteh73s4gnktcfsii4lbb2ztvudexiyqw@hxqowhgokxf3>
 <0e46dcf652ff0b1168fc82e491c3d20eae18b21d.camel@gmail.com>
 <CAADnVQJ2bE0cAp8DNh1m6VqphNvWLkq8p=gwyPbbcdopaKcCCA@mail.gmail.com>
 <2k3v5ywz5hgwc2istobhath7i76azg5yqvbgfgzfvqvyd72zv5@4g3synjlqha4>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2k3v5ywz5hgwc2istobhath7i76azg5yqvbgfgzfvqvyd72zv5@4g3synjlqha4>

On Tue, Jul 23, 2024 at 02:36:18PM GMT, Shung-Hsi Yu wrote:
[...]
> > +1
> > Pls document the logic in the code.
> > commit log is good, but good chunk of it probably should be copied
> > as a comment.
> > 
> > I've applied the rest of the patches and removed 'test 3' selftest.
> > Pls respin this patch and a test.
> > More than one test would be nice too.
> 
> Ack. Will send send another series that:
> 
> 1. update current patch
>   - add code comment explanation how signed ranges are deduced in
>     scalar*_min_max_and()
>   - revert 229d6db14942 "selftests/bpf: Workaround strict bpf_lsm return
>     value check."
> 2. reintroduce Xu Kuohai's "test 3" into verifier_lsm.c
> 3. add a few tests for BPF_AND's signed range deduction
>    - should it be added to verifier_bounds*.c or verifier_and.c?
> 
>      I think former, because if we later add signed range deduction for
>      BPF_OR as well...

I was curious whether there would be imminent need for signed range
deduction for BPF_OR, though looks like there is _not_.

Looking at DAGCombiner::SimplifySelectCC() it does not do the
bitwise-OR variant of what we've encountered[1,2], that is

    fold (select_cc seteq (and x, y), 0, A, -1) -> (or (sra (shl x)) A)

In other words, transforming the following theoretial C code that
returns -EACCES when certain bit is unset, and -1 when certain bit is
set

    if (fmode & FMODE_WRITE)
        return -1;
    
    return -EACCESS;

into the following instructions

    r0  <<= 62
    r0 s>>= 63 /* set => r0 = -1, unset => r0 = 0 */
    r0  |= -13 /* set => r0 = (-1 | -13) = -1, unset => r0 = (0 | -13) = -13 = -EACCESS */
	exit       /* returns either -1 or -EACCESS */

So signed ranged deduction with BPF_OR is probably just a nice-to-have
for now.

1: https://github.com/llvm/llvm-project/blob/2b78303/llvm/lib/CodeGen/SelectionDAG/DAGCombiner.cpp#L27657-L27684
2: neither was the setne version transformed, i.e.
   fold (select_cc setne (and x, y), 0, A, 0) -> (and (sra (shl x)) A)
   
>      then test for signed range deducation of both
>      BPF_AND and BPF_OR can live in the same file, which would be nice
>      as signed range deduction of the two are somewhat symmetric

