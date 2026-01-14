Return-Path: <netdev+bounces-249707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B3CD1C44D
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 04:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DEB13011EC2
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FB82BF00D;
	Wed, 14 Jan 2026 03:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AACJ866m"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06A3299AAC
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 03:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768361758; cv=none; b=ftX+Yxv0de7PpykMuas2yuER0/X6dacpsfUV2W2BQx6RI/61gE4gzkwYJQQKh3ULiJrCLNr5NZ1gPVqJ/kA9qG8bB9LjT+pSaQJS058/FfArQB9QVm16cf/9367/KfnxiFmAC471JRAGFKOl+eYA/QqyRVT3GHtjubh1NcqW/Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768361758; c=relaxed/simple;
	bh=ohaobj+4qOvxjQEnZRdNuGgPWT8AT1b4fJ6n6QAMlbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EEK9GDkTSXK8qYILUqw3fqtMym8azu3E5d3MbntSkMLXiNSRvu7l0yVHXvsR6auSA02F7arU6MMHZJxydLGmQkzLKc3homNgoyuofG7HoaUmE4XxQTSO2dsiqiUBjOF24tZ2UQTNKmgsr5tW7asXqFzfUVa9leTMgOa64z7CfWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AACJ866m; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768361744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkdbmQzm1KP85q+4iUZeHygR0VxNFnIzbGnli5J4hsA=;
	b=AACJ866mZ+MhF7qATP1VuiEWyu7dOe67zQ1qJBd3MCS7+RwjBOmlQz8wH/AqBLqhSWe12n
	VOCGLPKDCBndfeIdHMRkFFrIm14avN9yErrZwUCT4PU79b+bO6p+akwIoJ1hT28d1MNMAZ
	iLuDTwc2RrSsU0TtMq7YFIU8K3FKZxY=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v9 07/11] bpf,x86: add fsession support for x86_64
Date: Wed, 14 Jan 2026 11:35:30 +0800
Message-ID: <40194042.10thIPus4b@7940hx>
In-Reply-To: <2187165.bB369e8A3T@7940hx>
References:
 <20260110141115.537055-1-dongml2@chinatelecom.cn>
 <CAEf4BzYE0ZTrCaruJSr8MXAbZSsKz8H_BqHoZX5kS63yRBa-2g@mail.gmail.com>
 <2187165.bB369e8A3T@7940hx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/14 11:27 Menglong Dong <menglong.dong@linux.dev> write:
> On 2026/1/14 09:25 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> > On Sat, Jan 10, 2026 at 6:12 AM Menglong Dong <menglong8.dong@gmail.com> wrote:
> > >
[...]
> > >
> > > +       if (bpf_fsession_cnt(tlinks)) {
> > > +               /* clear all the session cookies' value */
> > > +               for (int i = 0; i < cookie_cnt; i++)
> > > +                       emit_store_stack_imm64(&prog, cookie_off - 8 * i, 0);
> > > +               /* clear the return value to make sure fentry always get 0 */
> > > +               emit_store_stack_imm64(&prog, 8, 0);
> > > +       }
> > > +       func_meta = nr_regs + (((cookie_off - regs_off) / 8) << BPF_TRAMP_M_COOKIE);
> > 
> > func_meta conceptually is a collection of bit fields, so using +/-
> > feels weird, use | and &, more in line with working with bits?
> 
> 
> It's not only for bit fields. For nr_args and cookie offset, they are
> byte fields. Especially for cookie offset, arithmetic operation is performed
> too. So I think it make sense here, right?

Oh, I see what you mean now. It's OK to use "&" instead of "+"
here. I were explaining the decreasing of func_meta in invoke_bpf().
That can use "&/|" too, but use "-/+" can make the code much
simpler.

Thanks!
Menglong Dong

> 
> 
> > 
> > (also you defined that BPF_TRAMP_M_NR_ARGS but you are not using it
> > consistently...)
> 
> 
> I'm not sure if we should define it. As we use the least significant byte for
> the nr_args, the shift for it is always 0. If we use it in the inline, unnecessary
> instruction will be generated, which is the bit shift instruction.
> 
> 
> I defined it here for better code reading. Maybe we can do some comment
> in the inline of bpf_get_func_arg(), instead of defining such a unused
> macro?
> 
> 
> Thanks!
> Menglong Dong
> 
> 
> > 
> > 
> > 
> > 
> > > +
> > >         if (fentry->nr_links) {
> > >                 if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off,
> > > -                              flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image))
> > > +                              flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image,
> > > +                              func_meta))
> > >                         return -EINVAL;
> > >         }
> > >
> > > @@ -3445,9 +3467,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
> > >                 }
> > >         }
> > >
> > > +       /* set the "is_return" flag for fsession */
> > > +       func_meta += (1 << BPF_TRAMP_M_IS_RETURN);
> > > +       if (bpf_fsession_cnt(tlinks))
> > > +               emit_store_stack_imm64(&prog, nregs_off, func_meta);
> > > +
> > >         if (fexit->nr_links) {
> > >                 if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off,
> > > -                              false, image, rw_image)) {
> > > +                              false, image, rw_image, func_meta)) {
> > >                         ret = -EINVAL;
> > >                         goto cleanup;
> > >                 }
> > > --
> > > 2.52.0
> > >
> > 
> 
> 
> 
> 
> 
> 
> 





