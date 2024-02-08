Return-Path: <netdev+bounces-70112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE07184DAE2
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 08:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD1B1F21978
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 07:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E226931C;
	Thu,  8 Feb 2024 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tVNX0jE9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE0E6A00E
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 07:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707378498; cv=none; b=P0PfkaIcLlu1j3D1hV0hQcLHAc80KRjOVl0XIl/C98eCmSeOVRpynodjrEATnydgrUdWcuFy/ovaAMIe4+NePkzFVFtJxhS/P51wYDkGTB196ExhCRV2ShyQvO66nJP5d9iTrmo8tjr6EVrsTUi0oAxDh36N9+Sm7+D6i1H4r90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707378498; c=relaxed/simple;
	bh=385hCUDagPRLXBeOIkuJcZqA/c6Z79mqmXF47UMwoI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8KIr5EppNg01BC60GwzO4mM3ZKVAJaM/sy25isPFyeD4Gre6j7NbTM0ne2EZsiDKOSem6hZfLv8AsXRxv5qGrv+srHxfi/+9oVyMT56A9x64OUNyvvKBYE58YDXTro06wMm6jIbeiQhsA3OPo/BDUx+wCcqnStoKfZcmdpCQXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tVNX0jE9; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4c009d2053fso625306e0c.3
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 23:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707378495; x=1707983295; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=385hCUDagPRLXBeOIkuJcZqA/c6Z79mqmXF47UMwoI8=;
        b=tVNX0jE98lFRt5CZwoLfNUbzG9OjXj9sg1stXBi33lMBCtDsmGPEbbKRq2yFHCqZpd
         uBvA12AAKtEVgfP1uu7N0m5NMDf1bJ+BX5tzrpPEpfgP2n5V8HJO9vAGKZwxr5kxGNFv
         1uHDrV6kO7CkRIfZk3e1qoVc1COodl8ppfTiJnkLeYmgi6PGjTH3W2cGFIn8dSGdg1GQ
         UMhL70GRPR9yMnOCmTPSRWPxyT3VLdhlEL1iNUurcdOSbpgXFC6PitPndHmkmowEjPJa
         pNl0dmcuj4sqj9AIZeqMdAEKSzKZoufJAZVAjI+mBng0QfoDcqkzPWEepsS5Uw0e6HRE
         g8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707378495; x=1707983295;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=385hCUDagPRLXBeOIkuJcZqA/c6Z79mqmXF47UMwoI8=;
        b=LaM6sZwcx4szN4zIc7i7eoYB7r9cdJkWWD3A6eX6N4pFx783FApROXoQ64z9xhVsOC
         UScv2CsfgtRC3syQJ3i6f3t8yv1T46vPE+sUVF+KgS+VyZe3W9hWqE3nREg2P9RY/p74
         1OM65FevK+41XanWMG1cgsIGE+sNYt/qrP6Hh3fT0Wrcg+4TLXFQIWaOojUB9frOnf4d
         lffwtq35rYCTj86/adP1118raBMoOY24Q90EgB971DWwztdukkrA0Yv+gYmgwY6i0PTZ
         agzPrQ/CkjhdxmpBYqoA/li8GyJR9NPsU1yNG8FTWWhLtefw7InvQsbieaYk0DJCAQbt
         MPBA==
X-Forwarded-Encrypted: i=1; AJvYcCVxJRwVCGwE2t04tN5eVBlkb6drzX42S7z/CqyioT1XxKph2Q9O71sBiQpN6of+PL869jbf1KeaPMsdEZonqVV/tLsJB3T1
X-Gm-Message-State: AOJu0Yy/P+JvEej9+klhct2xrZAuFkjRBQ3nZugEokCe2IE3Oei1AQ5/
	yANDx1gtxa+4VMW/A3v6RDfFiah/E5ucJYEiYK0zvPEhonEBI5X6XRnMdW4pMEWO7AWQiYPBOBT
	COWWaQwxZ8UsZ2HbJXpppTu9g74TxP/aBpO0G
X-Google-Smtp-Source: AGHT+IFfAWgcwyQD2mZhUwcrOfyVNULDgaE2Hm0wSLF/MsohweHJ4+cnildQhvAC+LK+/ZWLQMFrbZXkCFQs2av9htE=
X-Received: by 2002:a05:6122:a0b:b0:4c0:1a89:e641 with SMTP id
 11-20020a0561220a0b00b004c01a89e641mr5647392vkn.12.1707378495118; Wed, 07 Feb
 2024 23:48:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e2871686-ea25-4cdb-b29d-ddeb33338a21@kernel.org>
 <CANpmjNP==CANQi4_qFV_VVFDMsj1wHROxt3RKzwJBqo8_McCTg@mail.gmail.com>
 <20240207181619.GDZcPI87_Bq0Z3ozUn@fat_crate.local> <d301faa8-548e-4e8f-b8a6-c32d6a56f45b@kernel.org>
 <20240207190444.GFZcPUTAnZb_aSlSjV@fat_crate.local> <20240207153327.22b5c848@kernel.org>
In-Reply-To: <20240207153327.22b5c848@kernel.org>
From: Marco Elver <elver@google.com>
Date: Thu, 8 Feb 2024 08:47:37 +0100
Message-ID: <CANpmjNOgimQMV8Os-3qcTcZkDe4i1Mu9SEFfTfsoZxCchqke5A@mail.gmail.com>
Subject: Re: KFENCE: included in x86 defconfig?
To: Jakub Kicinski <kuba@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Matthieu Baerts <matttbe@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Netdev <netdev@vger.kernel.org>, linux-hardening@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Feb 2024 at 00:33, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 7 Feb 2024 20:04:44 +0100 Borislav Petkov wrote:
> > On Wed, Feb 07, 2024 at 07:35:53PM +0100, Matthieu Baerts wrote:
> > > Sorry, I'm sure I understand your suggestion: do you mean not including
> > > KFENCE in hardening.config either, but in another one?
> > >
> > > For the networking tests, we are already merging .config files, e.g. the
> > > debug.config one. We are not pushing to have KFENCE in x86 defconfig, it
> > > can be elsewhere, and we don't mind merging other .config files if they
> > > are maintained.
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
>
> Right, a lot of distros enable it and so do hyperscalers (Fedora, Meta
> and Google at least, AFAIK). Linus is pretty clear on the policy that
> "feature" type Kconfig options should default to disabled. But for
> something like KFENCE we were wondering what the cut-over point is
> for making it enabled by default.

That's a good question, and I don't have the answer to that - maybe we
need to ask Linus then.

We could argue that to improve memory safety of the Linux kernel more
rapidly, enablement of KFENCE by default (on the "big" architectures
like x86) might actually be a net benefit at ~zero performance
overhead and the cost of 2 MiB of RAM (default config). One big
assumption is that CI systems or whoever will look at their kernel
logs and report the warnings (a quick web search does confirm that
KFENCE reports are reported by random users as well and not just devs
or CI systems).

Thanks,
-- Marco

