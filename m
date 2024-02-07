Return-Path: <netdev+bounces-70021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD0184D5BE
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 23:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D100C1F23275
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 22:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEFC149DFB;
	Wed,  7 Feb 2024 22:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pNWO5RT9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CF4149DF2
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707344509; cv=none; b=YyH06qu74QjlL9Tyegt51uiOjRJeSFZWfVrWhKNfyADhHkBtWnSQ/aS04oqkZ4cOD6AExOPTptpv6M9uuOrtdOz+JW7zWpQwQxl/pNfogwWZkMVfoM8pddhXMuSapBxDhRBJ72rgZJzEq0VpjVbtRpGnKT9Ff5CHs+2qbzSUwSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707344509; c=relaxed/simple;
	bh=Q+dKiZCAx2K5MWCLf8Rta07KqHdenFew9tjW2b/jNYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAlTmzmFnw9cg+eRM8BPZjrgMFGXkL8TnaP1Dao9UYpmwrsKPvlZ42DB4QsNhFAp9d1VhzBK/3FFBAGsgAby+OJyACoIBDuPp+n3oAUXCzCc5/1vRXMKA38KuerhuEytcJZ4XWOVQtfrSTaNLDwhMp6jGyjKJgf5451EvakiulE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pNWO5RT9; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4b978e5e240so476205e0c.0
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 14:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707344507; x=1707949307; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+dKiZCAx2K5MWCLf8Rta07KqHdenFew9tjW2b/jNYE=;
        b=pNWO5RT960yUoKPgce9dnJwpsqWvUhb+ZWaI726wfF5HI/FT9FEkKXexh7ktN2kn4Y
         4NWAtCcT83weohtxohgW88cI47cUZVPDXnX85aQ+GpLgiZIxJe09vxq02HOm1+hGHC5s
         MlD7St18lYttPyec0Ay+ppDMBeGVhYXvXGc1e57RMKbvQL7+A69I3KZhBeQKeeY59vD7
         pQG17mWwe6HjfWwEY7cUA3TlcG7bGJRyeX7yf7QkYy+UCzMxnIKjdtX8hNG7SMYSpdQZ
         VSl6qFXLha4okDov+X8wbHoDWbzOjHGCyyle8yE134W4W7dI/6LVOCfgT/FxuRxI6Tm/
         CVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707344507; x=1707949307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+dKiZCAx2K5MWCLf8Rta07KqHdenFew9tjW2b/jNYE=;
        b=w1Wk6fGd2YJIt+pIaMRS199LtDnm4D2rPS74yMXJ2wHN71rLBmRYiufRvEWAGdSAek
         0HAEWHGfhDnKL0+E3R3HM1hkdvxxBGjzvwywvUyAp24USJApUGDhReK/oR0ZCT3lHno5
         VcseTypRHO8Gr9lveV4a1S1i2aoUc4UflHGvWoYVi/KJYJ7jKfw/mJe6S5UkH5Ioqg2S
         QNOa43AG8K4QKacT1DACa94U+ixwheKJC+egDS1UckLp0+X7XX33IYkjDso3B//WP4KI
         tG2MDf6v1DagJgKm9485keSuMBoImN/o5R/ug9pr1cgTaHvmSDU4CYEaeEWE7rFGK3bJ
         6uxw==
X-Forwarded-Encrypted: i=1; AJvYcCVCFTO9IBzZTNFHqDCHJQs4CFCm2yACHbqYG55bd8xKQfwtg+yhiaQSYXfxVi5SJEmffhW5HK3ucLY42wcu1n+iS8sDuSot
X-Gm-Message-State: AOJu0Yz6Q8avplOn0Vqs7zMQdj/ZSyvZSiMBou5rEDHenEypLPwGt6Z/
	vIoJs+voH3Vhpf18fKmQ7nDcr1QRPdwPpD+XFTmh7vxAhnQryRjMPFEdjKf5nwuFUxrmzs3P90p
	lDn+CLDt5MekZpf01vltilw6CIoNt/TvjvTT8
X-Google-Smtp-Source: AGHT+IEHplmzp47TpsePGD3Kt24q6nGHyJMwrezwHO/siBk37pfa/HPVqc2kWJlBltV6XupzpIMl1VXoNTXQ94c7nmE=
X-Received: by 2002:a05:6122:31a1:b0:4c0:d43:f8a0 with SMTP id
 ch33-20020a05612231a100b004c00d43f8a0mr4899395vkb.13.1707344506661; Wed, 07
 Feb 2024 14:21:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e2871686-ea25-4cdb-b29d-ddeb33338a21@kernel.org>
 <CANpmjNP==CANQi4_qFV_VVFDMsj1wHROxt3RKzwJBqo8_McCTg@mail.gmail.com>
 <20240207181619.GDZcPI87_Bq0Z3ozUn@fat_crate.local> <d301faa8-548e-4e8f-b8a6-c32d6a56f45b@kernel.org>
 <20240207190444.GFZcPUTAnZb_aSlSjV@fat_crate.local> <7a3d2c33-74ce-45fb-bddc-9eceb6dd928b@kernel.org>
In-Reply-To: <7a3d2c33-74ce-45fb-bddc-9eceb6dd928b@kernel.org>
From: Marco Elver <elver@google.com>
Date: Wed, 7 Feb 2024 23:21:09 +0100
Message-ID: <CANpmjNOEhyW7xnaQ2gk0XXrdLSR6DgyWD96CBb-cxUJT+wgMXQ@mail.gmail.com>
Subject: Re: KFENCE: included in x86 defconfig?
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, Netdev <netdev@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, linux-hardening@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Feb 2024 at 23:12, Matthieu Baerts <matttbe@kernel.org> wrote:
>
> On 07/02/2024 20:04, Borislav Petkov wrote:
> > On Wed, Feb 07, 2024 at 07:35:53PM +0100, Matthieu Baerts wrote:
> >> Sorry, I'm sure I understand your suggestion: do you mean not including
> >> KFENCE in hardening.config either, but in another one?
> >>
> >> For the networking tests, we are already merging .config files, e.g. the
> >> debug.config one. We are not pushing to have KFENCE in x86 defconfig, it
> >> can be elsewhere, and we don't mind merging other .config files if they
> >> are maintained.
> >
> > Well, depends on where should KFENCE be enabled? Do you want people to
> > run their tests with it too, or only the networking tests? If so, then
> > hardening.config probably makes sense.
> >
> > Judging by what Documentation/dev-tools/kfence.rst says:
> >
> > "KFENCE is designed to be enabled in production kernels, and has near zero
> > performance overhead."
> >
> > this reads like it should be enabled *everywhere* - not only in some
> > hardening config.
> >
> > But then again I've never played with it so I don't really know.
> >
> > If only the networking tests should enable it, then it should be a local
> > .config snippet which is not part of the kernel.
> >
> > Makes more sense?
>
> Yes, thank you!
>
> On my side, KFENCE is currently in local .config snippet, not part of
> the kernel. If it has near zero performance overhead and can be used in
> productions kernel, maybe it can be set elsewhere to be used by more
> people? But not everywhere, according to Marco.

At the moment we still think this decision is to be made by the
distribution, system administrator, or whoever decides on kernel
config. I'm aware that several major Linux distributions enable KFENCE
in their kernels. The tool was designed for in-production use - we use
it in production [1] - but I'm not sure we can and should make this
decision for _every_ production kernel. The hardening config seems
like a good place, and I've put that on the TODO list.

Thanks,
-- Marco

[1] https://arxiv.org/abs/2311.09394 (see Linux section)

