Return-Path: <netdev+bounces-227650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0C4BB4C0B
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 19:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C75B321548
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 17:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EAE26E71F;
	Thu,  2 Oct 2025 17:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRdTQj5H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9739725C6F9
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759427610; cv=none; b=nzy+5ilBCb+WlshfwWmWWiuoCkuV6SriQWtI3Rv1jtN+KK+IcwE8U82UN8JRxY9tt8ljUCv61H3zqCYABzL72VBJ578Le3JSaWz4ngUoXFhc+QVp9/YcWXecwgApCE7WWBsvMAdhUZQnrimbHiqd8+o4ihr1Xj0CGpKTiHtRlpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759427610; c=relaxed/simple;
	bh=lYlR9JAkY6eonM9QwEMKfhCQRHt2uu3QYqSTTamIBdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeEV+S36cMAUghShfqgQe7RYS0AyY6zNUcaHlBiAxfqEKXGYW1zZX/qo2fl+KW8ARTM9N7/eVhlTIUcaKWvlYQeDbOJzCmc12nJmNwZAgBQ+fdzz8n1wtwfgEwPweKXByAS4N0HbQCHyF0PkjRc3+FI7PsgXchMMSf/iUpjDTKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRdTQj5H; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42420c7de22so816802f8f.1
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 10:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759427607; x=1760032407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaxQ5nlkJBoLX0kDXGvJ6XBK66v+3iFsoex1hiWJ05Q=;
        b=LRdTQj5HA57YVY7NqSsaSHUE9ezVXfVkKiA3tx4sIG7YPF3d+j3ltMzh9hU7u0Lo+v
         zs+y0nRiwOGSD0ALpJq61LnvsdOv9kJplLXDi0AhjWMUM1u88fIYWDmjzLA9orpdKeZD
         THAoAu+3KbIGNaLEYA4aKNcVcy78ngRuQRTdEurCD6yvjcbr8WKEuOG8NdEA5HUUQWGl
         pVv0BWSYfj0ZXbfAiSIcKRRWZA8ZOYLhqfSR6679FCMS9tb4+/6KNANJjge0du1wtWlS
         ff94Rcj4eW7l4j7UxSTKtmLdRlUEAoCd5zzn+/jrx1Au+XG+k1cUxzBmHtuwM48YcD2g
         U9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759427607; x=1760032407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaxQ5nlkJBoLX0kDXGvJ6XBK66v+3iFsoex1hiWJ05Q=;
        b=NpcFAxex2dpsY78T2LawL2z6DqnHNacOBKp2FE5HRR3NKUmVC2jnOuW66g4eKGX520
         crLdqop2AwNZUaGUmbnWht6X7cTmGFiSJX6Om4ypDGiIQaCwXvpu0a10X/n+QvCmJ4GF
         laL1JHHkkrfR2rNzf041IHuY97nTb7kkxFoiym2KJtT4TCa06QXuaqrn/hTsKiXakluE
         LTim+IAJcpPl52HigCZi5+8249nAmjmNQ7SQvGJiyOASrbCLcKkE2d5aEG51qhpSZGO0
         JamliUDyjgkyGyiojAO18Q4hmiYPen3SPhFPmhg0nsFp8pEAT/heekIrT6Up6y+wGuOz
         JpNw==
X-Gm-Message-State: AOJu0YwlLHWsDpv6OvWTvM94yA2bfSR0JrmLmFhkT4TO9d4rGA32T92g
	9BlQAZAGIaqbvh3xy8bJAafivRYhU2W299nkMrkGkcP8XeXLO7F5Y3a/A96SG95zrsXiTmfD6ve
	bbvmypf/S3ea8UGX5wGlewSBlawXfpuE=
X-Gm-Gg: ASbGncsvKxlM33AfRX9iiAfGA8J4BISTxB8jt5TH5rZjXR15aSX5Ro8C+JPFAet3w66
	Y261mrwDOpEfZVmHQv2T8aEPvZ+tKEE+20hWBuPCoD8ZjGVrRHUkWPbMcRHsj2L74zwfLlRBpfj
	fOtG0bUAEImYhNSRiBjCCVtykmWZ88dvTDMR6elU1fgYvDk1cgAk+zITrxjKMHmogh3zah7tjfs
	FozZ3WGnetGwCAOaphi53p5LnamYibtIet/CeK11w/N5Xk=
X-Google-Smtp-Source: AGHT+IGUdaUJJ5Am0eJaFvkFzR87l/n/eveNeYR/SWSgPBWRcduqOdb2zPykXRgYMPLLpVYYFEtMNgr6Gvw1FOwxbKQ=
X-Received: by 2002:a5d:5d87:0:b0:40d:86d8:a180 with SMTP id
 ffacd0b85a97d-425671362a3mr143408f8f.20.1759427606568; Thu, 02 Oct 2025
 10:53:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929194648.145585-1-ebiggers@kernel.org> <CAADnVQKKQEjZjz21e_639XkttoT4NvXYxUb8oTQ4X7hZKYLduQ@mail.gmail.com>
 <20251001233304.GB2760@quark> <CAADnVQL=zs-n1s-0emSuDmpfnU7QzMFo+92D3b4tqa3sG+uiQw@mail.gmail.com>
 <20251002173630.GD1697@sol>
In-Reply-To: <20251002173630.GD1697@sol>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Oct 2025 10:53:13 -0700
X-Gm-Features: AS18NWCbGcuZ8Cebik8lq4lHKUH7KbCo2CuA-1gvo_9eRy3exLlbGTVyNK97Dds
Message-ID: <CAADnVQKTvXWQ72iBaAvCsDumq834t7f_0Vjy+Vz-8zaYtnupwA@mail.gmail.com>
Subject: Re: [PATCH iproute2-next v2] lib/bpf_legacy: Use userspace SHA-1 code
 instead of AF_ALG
To: Eric Biggers <ebiggers@kernel.org>
Cc: Network Development <netdev@vger.kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	bpf <bpf@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 10:37=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Thu, Oct 02, 2025 at 10:12:12AM -0700, Alexei Starovoitov wrote:
> > On Wed, Oct 1, 2025 at 4:33=E2=80=AFPM Eric Biggers <ebiggers@kernel.or=
g> wrote:
> > >
> > > On Wed, Oct 01, 2025 at 03:59:31PM -0700, Alexei Starovoitov wrote:
> > > > On Mon, Sep 29, 2025 at 12:48=E2=80=AFPM Eric Biggers <ebiggers@ker=
nel.org> wrote:
> > > > >
> > > > > Add a basic SHA-1 implementation to lib/, and make lib/bpf_legacy=
.c use
> > > > > it to calculate SHA-1 digests instead of the previous AF_ALG-base=
d code.
> > > > >
> > > > > This eliminates the dependency on AF_ALG, specifically the kernel=
 config
> > > > > options CONFIG_CRYPTO_USER_API_HASH and CONFIG_CRYPTO_SHA1.
> > > > >
> > > > > Over the years AF_ALG has been very problematic, and it is also n=
ot
> > > > > supported on all kernels.  Escalating to the kernel's privileged
> > > > > execution context merely to calculate software algorithms, which =
can be
> > > > > done in userspace instead, is not something that should have ever=
 been
> > > > > supported.  Even on kernels that support it, the syscall overhead=
 of
> > > > > AF_ALG means that it is often slower than userspace code.
> > > >
> > > > Help me understand the crusade against AF_ALG.
> > > > Do you want to deprecate AF_ALG altogether or when it's used for
> > > > sha-s like sha1 and sha256 ?
> > >
> > > Altogether, when possible.  AF_ALG has been (and continues to be)
> > > incredibly problematic, for both security and maintainability.
> >
> > Could you provide an example of a security issue with AF_ALG ?
> > Not challenging the statement. Mainly curious what is going
> > to understand it better and pass the message.
>
> It's a gold mine for attackers looking to exploit the kernel.  Here are
> some examples from the CVE list when searching for "AF_ALG":

Ohh. I see. That made it very concrete. Thanks!

Acked-by: Alexei Starovoitov <ast@kernel.org>

