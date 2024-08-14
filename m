Return-Path: <netdev+bounces-118632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2549952471
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 23:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55FC61F22379
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 21:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DDE1C7B6C;
	Wed, 14 Aug 2024 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PIoQjUka"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAC51C2324
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723669565; cv=none; b=o3gxG/C7TkhKhwjs/6b+5UVEP4EjQdWrXRMZoeitZiiPvJxoQqqqLy9DpG1aBkS+9Rlmx8m6ros+RG3wzXt1sTk4/ZmUZLzwPDXEMwVxxc1/2YZkGWNR9F4RGfc6E3VEKMNPJxB4rrXk6QQ8JdJTsHmmZM+MRoDdq0raBiDFTVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723669565; c=relaxed/simple;
	bh=H0/+AlUrAVPwZVlgF2f63uEjQjWCVEgtVgFPVQf/v/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YoFik1D8wsQdxwAzfT7qi2ye9nipPDWIttnEN46PoKyPH13gON7TaaPVVj3sq+pcx4Km1bTAahjzQv2WUFfBZOB+zBEIWe+6Lt6mpifBUEqkDg6gyvlKtxsdZs/Y/dfe9h0SfcuL0Sx+nM9ZllMmPxE0OVMqWTW0Ipgs/G5OZiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PIoQjUka; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-84119164f2cso87192241.3
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 14:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723669561; x=1724274361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZKLox5eS3QRtbNUFn2cEECTACt7m3r5KD0Nhy6dpnY=;
        b=PIoQjUkaZMMbJSEh/9MnK+4/o3s3bO78a/qkPf0LSYHYnHvAvxXqgE/grNm7bE5Uvn
         338bOm22SrpSJxC5tOf6pr1QBVoY3mZAgPeTDLRC1tYGuHuo0otOSS97rGLzsjKlwL+A
         Cf4gDTmwe8Lmfj8Fw/e1NkWY/1jHF5cTLg0clJ9/bA6uDmNYxYBYz9Wybpn4rkbHGUsW
         fHYarNIB8TqhXF7uORD3pxZ20Q+RxAuX9eQFBLFYDSwHhGCPGpebZl0S3L+ZBW0JJSJx
         VXOGhBdjG1npttT2dH49F5CCEAD0OMglRGR5ZKrU+8Y3UnofyhquFFBjaOQ3MwSjgZup
         8cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723669561; x=1724274361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZKLox5eS3QRtbNUFn2cEECTACt7m3r5KD0Nhy6dpnY=;
        b=owV49+ayNPDzJDLyx7nJWSLwgpjVCLOsfLtDSOvhZaTivy+xP0SrU26xNxKKsAfmGe
         tgqYVyAZ20x+ut2XBBRrbprDVq5jU5bi4I+uM2+Sm8lRi6wZBVjZ+ARQcmZ1lKUjcPzd
         BzscQDY2j/JA0K7pXsf8jxabUoyZwF6EZlx09iSK+wCrE/qdde0gz2tmf7T98JkcY8uA
         8HPaRyKVIn2lzlmZi2XjjSpADS+zAF+NiMJpcny24bZcLIFwrxdHHz30smFQ9pmJV/FC
         /3R1beEyMxbNJFLAn7CLM7SLzW+ChbUv6CAyGPyVdPBTiJXuU3OeZJo1l43be7RQ1jzC
         Qjbw==
X-Forwarded-Encrypted: i=1; AJvYcCXftA1up6xxySHN8WJdU3bkN2XRL1hHyVGYzd0aKHJnlVRcPXhh/A3B0wpGYYvNR0907uNMInwQNWhDlrtJ0DPtVcrpgKqs
X-Gm-Message-State: AOJu0Yyv8bjszSyNYJx0DthoPlPoM4MqsK+su17zfsjAlnZx+6Qhf4+7
	SrkDrfXgqu9BUB089C1FN2eIkyanHeQC5tnEu7AFlRCRpx1v4ck9LoIbYAjfPZpaeANm9rfSJBr
	4qCyz/sxfZonqRdHXyCXpk+AKBkh1KsF3tJtR
X-Google-Smtp-Source: AGHT+IFhhGxcNIG2aUOot8SFL7p0VSL1VjzZGKWoR3i7NdcKgE7axBiFKDojFaazDvC4pd+ClFRktfSHuKzMJ3Co+SU=
X-Received: by 2002:a05:6102:6d2:b0:48f:461c:ab86 with SMTP id
 ada2fe7eead31-49759928e16mr5099648137.12.1723669561306; Wed, 14 Aug 2024
 14:06:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zrzk8hilADAj+QTg@gmail.com>
In-Reply-To: <Zrzk8hilADAj+QTg@gmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 14 Aug 2024 14:05:49 -0700
Message-ID: <CAFhGd8oowe7TwS88SU1ETJ1qvBP++MOL1iz3GrqNs+CDUhKbzg@mail.gmail.com>
Subject: Re: UBSAN: annotation to skip sanitization in variable that will wrap
To: Breno Leitao <leitao@debian.org>
Cc: kees@kernel.org, elver@google.com, andreyknvl@gmail.com, 
	ryabinin.a.a@gmail.com, kasan-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, axboe@kernel.dk, asml.silence@gmail.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 14, 2024 at 10:10=E2=80=AFAM Breno Leitao <leitao@debian.org> w=
rote:
>
> Hello,
>
> I am seeing some signed-integer-overflow in percpu reference counters.

it is brave of you to enable this sanitizer :>)

>
>         UBSAN: signed-integer-overflow in ./arch/arm64/include/asm/atomic=
_lse.h:204:1
>         -9223372036854775808 - 1 cannot be represented in type 's64' (aka=
 'long long')
>         Call trace:
>
>          handle_overflow
>          __ubsan_handle_sub_overflow
>          percpu_ref_put_many
>          css_put
>          cgroup_sk_free
>          __sk_destruct
>          __sk_free
>          sk_free
>          unix_release_sock
>          unix_release
>          sock_close
>
> This overflow is probably happening in percpu_ref->percpu_ref_data->count=
.
>
> Looking at the code documentation, it seems that overflows are fine in
> per-cpu values. The lib/percpu-refcount.c code comment says:
>
>  * Note that the counter on a particular cpu can (and will) wrap - this
>  * is fine, when we go to shutdown the percpu counters will all sum to
>  * the correct value
>
> Is there a way to annotate the code to tell UBSAN that this overflow is
> expected and it shouldn't be reported?

Great question.

1) There exists some new-ish macros in overflow.h that perform
wrapping arithmetic without triggering sanitizer splats -- check out
the wrapping_* suite of macros.

2) I have a Clang attribute in the works [1] that would enable you to
annotate expressions or types that are expected to wrap and will
therefore silence arithmetic overflow/truncation sanitizers. If you
think this could help make the kernel better then I'd appreciate a +1
on that PR so it can get some more review from compiler people! Kees
and I have some other Clang features in the works that will allow for
better mitigation strategies for intended overflow in the kernel.

3) Kees can probably chime in with some other methods of getting the
sanitizer to shush -- we've been doing some work together in this
space. Also check out [2]

>
> Thanks
> --breno
>
>

[1]: https://github.com/llvm/llvm-project/pull/86618
[2]: https://lwn.net/Articles/979747/ (Arithmetic overflow mitigation
in the kernel; Jul 1 2024)

