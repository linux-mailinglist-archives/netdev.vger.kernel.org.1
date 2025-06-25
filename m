Return-Path: <netdev+bounces-201362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B3CAE92ED
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 01:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C1B1C24A40
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 23:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA2E285CA0;
	Wed, 25 Jun 2025 23:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fZgk0MVK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21291DE4EF
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 23:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750895165; cv=none; b=uIwOwN5SZyfEjeRgVvqUNYzN7XnIAcY7TDeiNLESIXn+By2b1PacYTKKG14Q9Mvxpedb45u1dMUIF47GWzm3Z9f1viYE7YPEn2/F5BSyw66C/WkBHKFL+Gn0CIyo3zcdb+b6q3yjiz6SQlIAJ/NofthIxPz38/ZTo7wdm1Uv+Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750895165; c=relaxed/simple;
	bh=oS2+qEeE0p/dhi+nuprgW9YttSbFNXmR+OjGJ4tLvLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3LvKpFctomK6AKH5j9zMXlqymutPpJfvyokg4ytTV3GZoDGDr0Q1eWxflXjkUrB6HpJWXXd4Nq7C8uSCdQvhvo5HAUyTlIOprOGY5xoxeLjZUqvNLwmLA5i4+mXgrPl0FMEX57kSmYleASEIq6TL81rwCU4OcKSpvaA9sa+hSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fZgk0MVK; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-235e389599fso87795ad.0
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 16:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750895163; x=1751499963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxW6eLameOAnRuvuazW/r9gHcMuI7UE9esV+BikOkkQ=;
        b=fZgk0MVKBH/qV4poo1wzlkNtBvgEeOqbcP7BZB4JidCQshcnr0wBY30VxYmOQzF/ge
         nO9FqcTEWxv7pv3ghsroHYLfeUky3YSxVDFSzbb6EyjIoVkximh+r1/7IbkCV0YFvVTR
         eciSP797i/h3aKlQ2E4U5g6ENbC5odGyuyVC5zO46EpLLkhireIWgaJt//us2q4KzpmI
         yd8/lmzelKk7/BrjsWEEbu8uBpmebR0iM5UbkvXeAiLDMQnPNhC8SwHXKPRe3qfppMAf
         ERdirHueFqBN7qiP+NE0bcMS75d3sOeuI2jwwEsgfFJkd3cfD7QOBLkbj9ANbO5RFio4
         lHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750895163; x=1751499963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxW6eLameOAnRuvuazW/r9gHcMuI7UE9esV+BikOkkQ=;
        b=kjxAmza6hhqKm6C6huHp0rBUeAJI7slWY3mwTUWOB4+fsC05nnUsb2dAboRdHYtXpK
         86lfSeBta3yG3kiZ0wAL7+kcRoiEYQU8SwSbb2EAr9U5poZA/XKUx6334kRXdJyMrPeg
         W0suZHwfP/TO8XESgvoXoCi1eUz8XRikHvwmzXq+XPUgaCA45rXuanCw0f0xGvouKVic
         J1/zG9+OiEbGFC6Jg7xEgl69j74TOYyPXM4fSMkmyFJf0mNr1BwAbWDFie1Q8hB/xsXM
         rLNOKB+c935t9jslkekCzmko1vKXr1ftDDK6srXV2FH125z80weoCDOojmBTHuB5dfjt
         HS+g==
X-Gm-Message-State: AOJu0YzCWR/w+DupA5gIIw+v3Pf5O3hk36ME3yJrruCa3yrA2sCPp/1x
	MZe5kKvEqOLI/CPsoWjI6+RKovdfIpmuIRloLCK8Hg1rLtiEgGpij84kPLdGfJBBg+W1kNUCIsm
	B5suHJWSzaE+Q4SmD+22eMpnDK5TRufZ754JjtDKH
X-Gm-Gg: ASbGncsSEv2d6h1MDF35/ju/C4el6b0k7SRFgY/DvBR/qisIMNCEla4O3mjNqNXFlh8
	eHQDSHgXaX5jVj99wIa7A9yECRhYKmCMsQ4azYFDd9ix/FW2ZeAw02P/fT8zyeVSGMMiM7rJf8y
	kMQD4dSy0YMHuXyZyWaWAgpArAKE/sLOfKZNOnDrxF4vuSKQ9+ZLYuwc1kTfeudymHXgU9wulBb
	g==
X-Google-Smtp-Source: AGHT+IGYwGdc7VZyHxBpFQo3+2lzQv7lF6WR5ZbRy7zYEYyrFdgvZ22U0tAmCKzl7fZPUnYtijG7OErvXz50cjSIri4=
X-Received: by 2002:a17:903:1988:b0:215:65f3:27ef with SMTP id
 d9443c01a7336-23977c0bc75mr1397605ad.12.1750895162870; Wed, 25 Jun 2025
 16:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619181519.3102426-1-almasrymina@google.com> <175072801301.3355543.12713890018845780288.git-patchwork-notify@kernel.org>
In-Reply-To: <175072801301.3355543.12713890018845780288.git-patchwork-notify@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 25 Jun 2025 16:45:49 -0700
X-Gm-Features: Ac12FXzjltO9e3B85tE8sad7lqP2GbKMu7X5vbHIRSfDkIJObcz8XrCJ3tz_b5o
Message-ID: <CAHS8izMPWjmxLWJr+BSqd5jamsFHDOm71NkG7fmm-78SkLxQTg@mail.gmail.com>
Subject: Re: [PATCH net-next v5] page_pool: import Jesper's page_pool benchmark
To: patchwork-bot+netdevbpf@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, hawk@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, ilias.apalodimas@linaro.org, toke@toke.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 6:19=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This patch was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
>
> On Thu, 19 Jun 2025 18:15:18 +0000 you wrote:
> > From: Jesper Dangaard Brouer <hawk@kernel.org>
> >
> > We frequently consult with Jesper's out-of-tree page_pool benchmark to
> > evaluate page_pool changes.
> >
> > Import the benchmark into the upstream linux kernel tree so that (a)
> > we're all running the same version, (b) pave the way for shared
> > improvements, and (c) maybe one day integrate it with nipa, if possible=
.
> >
> > [...]
>
> Here is the summary with links:
>   - [net-next,v5] page_pool: import Jesper's page_pool benchmark
>     https://git.kernel.org/netdev/net-next/c/cccfe0982208
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>

Thank you for merging this. Kinda of a noob question: does this merge
mean that nipa will run this on new submitted patches already? Or do
I/someone need to do something to enable that? I've been clicking on
the contest for new patches like so:

https://netdev.bots.linux.dev/contest.html?pw-n=3D0&branch=3Dnet-next-2025-=
06-25--21-00

But I don't see this benchmark being run anywhere. I looked for docs
that already cover this but I couldn't find any.

--=20
Thanks,
Mina

