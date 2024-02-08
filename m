Return-Path: <netdev+bounces-70357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5BD84E78E
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 19:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A17A1C2303D
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 18:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4181184FCF;
	Thu,  8 Feb 2024 18:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkpYEiLp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6464C84FBD
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 18:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707416296; cv=none; b=d/BjxT+bo7XaNOMa1oNPYZizLwClW4/a/yWjyBWhGYKyx5BELhKdDlM8Q/lrYUGTNW580OM1KiAvqH3KFvlSFA+2sPIlfOxhjAoRpcPxYLftMRG2x58cfXZ1MbTb8h5/ewBSCvsseyJXuitByew2jRfuOoh2BhzUwi/a6uGrRu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707416296; c=relaxed/simple;
	bh=8WQrh0Yb38/CEEp0K8aQH4tZQIw9SlnBpD3HzicDqg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSNLL0vqq7zBU+Gn9GQ5ayXeUCzjHngtCPJaozAH1WGCmc6/V+8zLQBpcD+vcLQh5dXGSE+PSdXNe7QXUoIH9MEUbwLRz/FgwXq7DalTqK40SNpJJ/me6rgYBQM2h1RKW+jGg14CZ3XTTHnCLlEb/p4hNCeLOqyCPtdNm5MKub0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MkpYEiLp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707416293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RjTSOuqmKK3C/LJtQNnSoXwJu384NMrU80esiJ7Q4R0=;
	b=MkpYEiLp6WGTCeB6uTLJnsxjvBT2vDkOH2p9+z3koigKKOPxscLWyB9pgcVP0OCCqisbS6
	2+i6sAn+LlHgYs9C2YIsNxsQmDrlLpAwKB6xE3O7n+139dU7sv8x06phV/CccsLqvzKbBh
	9kcc3v18ad0uj+lbocbHu5Tg/3nG+vc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-bmIaSEeuOkWdE7xFHZXmfA-1; Thu, 08 Feb 2024 13:18:11 -0500
X-MC-Unique: bmIaSEeuOkWdE7xFHZXmfA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-558b84a7eeeso121260a12.0
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 10:18:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707416289; x=1708021089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjTSOuqmKK3C/LJtQNnSoXwJu384NMrU80esiJ7Q4R0=;
        b=HJVaH1zucJSwGszP/j7IrWWfoyi8hKWYIdyulIx5a00bnc/i9CJhBZk4FvFksTOXTL
         x8ATrlL+nirFBujcdoB5Wgu3WuGL3XRoB/7Te59Vg3vQDlaXG0wUKL203UsXGEuD/M4B
         LC/TlAq3pOVYsn8+xqdryqxo02SDC/6WWuM5M/S/wgCZQtdCqqZRX1BeeXEMx1WrWLPE
         Ln/0vOMRNABOKIZcF9mSwzJVColxfKz8Dpa9E9l7K5qEPdaXCeMYAvhtLf5qzPPoZlmE
         sT6QBrLswhWMWhIB4Yy3MlOuR7nBmtD8s7hgDeWrj1HzzolSkl1cglcjBrpYFixgOCPw
         BYlg==
X-Gm-Message-State: AOJu0Ywgw3PPEc8w4B7VR1Uo4rje8gU44GIr+PRGxZLNiNJ3dXNHjR29
	AF5dpvpILIojSPKNpzOhYfUari1u6DToSuQH1kmJrzj7A0l4DUDnpn9utxpGLKfiHjBhVpZHGx/
	ygDu5Ftl1Yg+6ITrj/voQ5R9JAnMhyTPEh+0jBMrRKi28OEm89xIJlpOtaGY9CTAAZuiTXCGWJm
	botM4QJpPNNAOWeR2El5jlMjG8R42kJGyTXzLF
X-Received: by 2002:a05:6402:753:b0:560:3745:6576 with SMTP id p19-20020a056402075300b0056037456576mr48168edy.6.1707416289611;
        Thu, 08 Feb 2024 10:18:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEvcYZyKwJ4cajYNmQK437p4mT1kP2gz7h4kYzJNBzo0manu46HZSfDasFlASGB6RoTZiJiCP08qMnm5nZtgA=
X-Received: by 2002:a05:6402:753:b0:560:3745:6576 with SMTP id
 p19-20020a056402075300b0056037456576mr48155edy.6.1707416289315; Thu, 08 Feb
 2024 10:18:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206142213.777317-1-sgallagh@redhat.com> <20240206191209.3aaf9916@hermes.local>
In-Reply-To: <20240206191209.3aaf9916@hermes.local>
From: Stephen Gallagher <sgallagh@redhat.com>
Date: Thu, 8 Feb 2024 13:17:58 -0500
Message-ID: <CAFoKQtwcXPMs1ecABfBhJbgXpRqz2OKp=ir3qHO3XbMR4eWVYQ@mail.gmail.com>
Subject: Re: [PATCH] iproute2: fix type incompatibility in ifstat.c
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 10:12=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Tue,  6 Feb 2024 09:22:06 -0500
> Stephen Gallagher <sgallagh@redhat.com> wrote:
>
> > Throughout ifstat.c, ifstat_ent.val is accessed as a long long unsigned
> > type, however it is defined as __u64. This works by coincidence on many
> > systems, however on ppc64le, __u64 is a long unsigned.
> >
> > This patch makes the type definition consistent with all of the places
> > where it is accessed.
> >
> > Signed-off-by: Stephen Gallagher <sgallagh@redhat.com>
> > ---
>
> Why not fix the use of unsigned long long to be __u64 instead?
> That would make more sense.
>


FWIW, that's the first path I tried, but it's accessed in dozens of
places, every one of which treats it as a 'long long unsigned'. That
led me to the belief that the specified type was just wrong (or at
minimum, in contravention of the consumers' expectations).

> Looking at ifstat it has other problems.
> It doesn't check the sizes in the netlink response.
>
> It really should be using 64 bit stat counters, not the legacy 32 bit
> values. (ie IFLA_STATS64). Anyone want to take this on?X

I definitely don't have the subject-matter expertise to do this,
sorry. Given that this issue is blocking our builds in Fedora/RHEL, I
was hoping we could try to solve the acute problem and leave
wider-ranging fixes to a separate effort.

> Also, the cpu_hits offload code is a wart. If it is of interest, it shoul=
d
> be more than one stat.
>
> One last issue, is that change the size of this structure will break old
> history files.
>

I'm not sure I understand this; it looks to me like this is a private
structure. If it has API impact (as in, it's written directly to
output data meant to be re-read), shouldn't it be in a public header
and/or otherwise denoted as API?


