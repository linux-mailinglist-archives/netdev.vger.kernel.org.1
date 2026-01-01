Return-Path: <netdev+bounces-246474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B841CECB7F
	for <lists+netdev@lfdr.de>; Thu, 01 Jan 2026 01:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48D4C300E3C5
	for <lists+netdev@lfdr.de>; Thu,  1 Jan 2026 00:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782C8246774;
	Thu,  1 Jan 2026 00:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="amjdY8FL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B906E244694
	for <netdev@vger.kernel.org>; Thu,  1 Jan 2026 00:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767229055; cv=pass; b=jDRUJ2EELZ9NeLYfmJJMIgF13qjGliwqiXf05ZtuU5Kh3r2Vg6fXFK4A6AE4QBVSxLWiurwjqo9vDc9lERe95gEbF41000WMrwk52doKe2Ex06PkyTIfDWLRNs/lgRUte0PQrXHkK6JYVw/A7Rs8HobQjURvhHRRTQaPKzjS7rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767229055; c=relaxed/simple;
	bh=emxm9F4PEs7twMpgwWsBAp/Ckd0EfI6WSs7yozL7W/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pt/NnpU+t3cP86ZR09FQxxqqQHKt8P2dKAX7Vkx9CUYj+0aKYVWVRdK/w8aoMn9m2mgRptNi+2iwv/dGmidEKQeN0d4ea/rX3uTCChiKhyKBQHZ9J7c5jtd0OhFZj5xFwSnvirrjtZxJ6xF2grp8bjuKdEnWVuc3fnLEus9v1xU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=amjdY8FL; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ee147baf7bso498751cf.1
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 16:57:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767229053; cv=none;
        d=google.com; s=arc-20240605;
        b=gOUVYEYkacCbaIBfelIklm8VCK/HisemIowS7Ww7JreZ9LA0SMzI+NOJTiowh4f5ej
         Kglyuh9jZfw027nLUwHxmJ6V/dysRkVJC1G1UPfqZ9UafYk5sd4Z3e534y73YXoJMbAt
         AaIRNNZxqAoRHVk4z2+VOkLlxASVJazLM4pIoemfXAEaFyizRYONaUfWiaIs1PmoAcPu
         LQN1eHred39SymtBMxz5KTIhavVV2hQ7M6nvxltNB1dcz9s3MXLbErydW0mWtdIjQUSm
         M7BcAqRc4/9Ezm2aesbeNmz9CB/chw9Z8cxAE8NNQdn7YDyaYOrCqRUsBF4gtocAUUXk
         XQgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cm1BL2ERrg3kCh6F6FAnwWgqfYK5vc0iS8vU9VA7hbs=;
        fh=K3Q6Zm5yD8kfI5oTsaxSAyYxJZAWjOhPAfR4BGVF97o=;
        b=ftarLWfTHKgEl7WUFxwxzAoNvkao3NjdfLghlcfrWuznt72D573bKf/E5f+oq2KGvK
         tcdqBwxBpBRPRm0FhtVjfBpFlyLQEuumsgEFjeHI5fKZnyyT9u+1joE5rklZAjf/oMEx
         amAvU4NLn7+nBGT5t7KC74CdY3NLjOx0Y2y+pii/g3YjJx786eSu86DHiO1Ha4DR/ag5
         pyFvJiNP4uyBLtDcGjtBz+gi04Qmnx4gQgAxSx5WZEUZr3rHlQO1QD95CVfmtVmmxtng
         yFfC+ouDQMvIbXZYKMJkJwo895cfGKNQpYZtDHlDS+ZKLGcCFzsuf/KA6xmgl/IhGbi1
         fojQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767229053; x=1767833853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cm1BL2ERrg3kCh6F6FAnwWgqfYK5vc0iS8vU9VA7hbs=;
        b=amjdY8FLeAN+ZPHh9RDcMADBERszkJ4kfQaOgKlHdUtCNSFcLaBQ2e/s21aYebAlJE
         vFBrpdjYlU2anp7XbCcvUDtNNxbwCPWJJXyvavH2Ck0TFajWB4Yw3aytRJjY+UXhxAlL
         8jW9KHaEfLdfljD2vzQ0u66CEoGxeZVF3C6iTX3zVCjJepnkg/3wrtQKIBgOvXdQKlX8
         n2bF1Y6QvNRMjnw40TtANR+jsXinOTIX95rrXHzAvY+pbyaSqVJOyfNN868wl76KDX2N
         yvxUqI1ID85yPwF4QuDKhb8QYn6jxfErcUt0JoMyQ+8yU/g3nae7Sjr+ZV2s3DqgC6Vg
         wWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767229053; x=1767833853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cm1BL2ERrg3kCh6F6FAnwWgqfYK5vc0iS8vU9VA7hbs=;
        b=GMpCKR2+S3mtqFKrAnZwY2SMaIEKrsMw97rake1Di/6qiF217XXNpTUjJoAQZBpFtB
         FUlrpX/bWv6c/Npa4btG7y9UgctNtOKwGm+eatVtLYHxxaDsFktuK9kaeYwEg+qTcEtI
         ASdqwMCgVatg4fjZF0qY5AQrPUVWetOhNd9p66nnylgUpmgvNLmrYirtPpCuV1tw61C+
         /l/ysDwzU9hoVM5mqPdFeEjQzMZL0hRyAlGCdr85J44aS1XOIM8BsZF7W/QwNTod8/9z
         R7EQCUNQQYTGud2rvXf28qwjlhWZ9jugzrIaXWcV0z86/NHkzQHTrOz1UQu6x8LG8HUY
         0VEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhARvbzhyfMFVA4vdmU3HT5PG+E86uH8OdWlUX9SjCtuI/2xa4nXlOXXDYzdxpYec037DUmGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv9KxjBXdruoqK3Qyeu5/JsBy5halFCzGxHje6yaGdQ4AHzHD+
	huV03Fvp7GMd4/8tAQVisy3MF8H7wnhrgZ6IdQ4VH5di8iJ7blvZjGifErdQvW9EtJFSwtzXkJw
	oF1DdQqk4wLY0SH6KQ/oxLk0IZSnbqUciHoe2EPRD
X-Gm-Gg: AY/fxX538ydX4mBVNFXpie7P4G9hYjZmnpJw7hwSe0lFy7TnlfhKsalPUBbeMDPSEix
	cbTbh8pmd9JRP61D1OWDkdX+2ThY48toeTacOGOMxtc375gXYBawVcc3/FNhxsT69B5Ve8FU8yM
	cKF8hsP4aFOu62XenTkz9LIWfdfTkOVpqGeRn+RHGTEUwBEoZF/A+2ChJxaxRbdgS+rPo3pF+S9
	kem98mZTJNWXIWQK98TYjiZ1q5u+BEqDfDFaC4H3tAmLHl/iOmdt/WxMmc4YzLPPJpwDm/Wnlsw
	VzC6OJi97oUCRzBskU5E8E+DKDT/Tip/Fqfdn70=
X-Google-Smtp-Source: AGHT+IE5OfZJ0/hIzhA8mBhbLh4j/deDnJBAW7Dn9FJZWDt+5ezAN6a04NmIQZHYNVZNn2qTdMcz9MSn3BadTm1/mm8=
X-Received: by 2002:ac8:7f06:0:b0:4f4:b46e:34a0 with SMTP id
 d75a77b69052e-4fbd6096b15mr8909641cf.5.1767229052434; Wed, 31 Dec 2025
 16:57:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231232048.2860014-1-maze@google.com> <CAADnVQL4ZPaiwuXtB7b9nrVVMg0eDiT6gnnNGrU5Ys61UWdgCA@mail.gmail.com>
In-Reply-To: <CAADnVQL4ZPaiwuXtB7b9nrVVMg0eDiT6gnnNGrU5Ys61UWdgCA@mail.gmail.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Thu, 1 Jan 2026 01:57:20 +0100
X-Gm-Features: AQt7F2qicWjCRjlu-6jL-eYQFIqmteU4y56SOln4I4mG55D8dWPVyDkjxlYOTGw
Message-ID: <CANP3RGdFdAf9gP5G6NaqvoGm7QZkVvow9V1OfZrCPBzyvVDoGg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: 'fix' for undefined future potential exploits of BPF_PROG_LOAD
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BPF Mailing List <bpf@vger.kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 1, 2026 at 1:07=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Dec 31, 2025 at 3:21=E2=80=AFPM Maciej =C5=BBenczykowski <maze@go=
ogle.com> wrote:
> >
> > Over the years there's been a number of issues with the eBPF
> > verifier/jit/codegen (incl. both code bugs & spectre related stuff).
> >
> > It's an amazing but very complex piece of logic, and I don't think
> > it's realistic to expect it to ever be (or become) 100% secure.
> >
> > For example we currently have KASAN reporting buffer length violation
> > issues on 6.18 (which may or may not be due to eBPF subsystem, but are
> > worrying none-the-less)
> >
> > Blocking bpf(BPF_PROG_LOAD, ...) is the only sure fire way to guarantee
> > the inability to exploit the eBPF subsystem.
> > In comparison other eBPF operations are pretty benign.
> > Even map creation is usually at most a memory DoS, furthermore it
> > remains useful (even with prog load disabled) due to inner maps.
> >
> > This new sysctl is designed primarily for verified boot systems,
> > where (while the system is booting from trusted/signed media)
> > BPF_PROG_LOAD can be enabled, but before untrusted user
> > media is mounted or networking is enabled, BPF_PROG_LOAD
> > can be outright disabled.
> >
> > This provides for a very simple way to limit eBPF programs to only
> > those signed programs that are part of the verified boot chain,
> > which has always been a requirement of eBPF use in Android.
> >
> > I can think of two other ways to accomplish this:
> > (a) via sepolicy with booleans, but it ends up being pretty complex
> >     (especially wrt verifying the correctness of the resulting policies=
)
> > (b) via BPF_LSM bpf_prog_load hook, which requires enabling additional
> >     kernel options which aren't necessarily worth the bother,
> >     and requires dynamically patching the kernel (frowned upon by
> >     security folks).
> >
> > This approach appears to simply be the most trivial.
>
> You seem to ignore the existence of sysctl_unprivileged_bpf_disabled.
> And with that the CAP_BPF is the only way to prog_load to work.

I am actually aware of it, but we cannot use sysctl_unprivileged_bpf_disabl=
ed,
because (last I checked) it disables map creation as well, which we do
want to function
as less privileged (though still partially priv) daemons/users (for
inner map creation)...

Additionally the problem is there is no way to globally block CAP_BPF...
because CAP_SYS_ADMIN (per documentation, and backwards compatibility)
implies it, and that has valid users.

> I suspect you're targeting some old kernels.

I don't believe so.  How are you suggesting we globally block BPF_PROG_LOAD=
,
while there will still be some CAP_SYS_ADMIN processes out of necessity,
and without blocking map creation?

