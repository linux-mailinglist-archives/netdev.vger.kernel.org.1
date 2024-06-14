Return-Path: <netdev+bounces-103647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B50908E58
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 17:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E3A71C23184
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 15:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A5D16F0EA;
	Fri, 14 Jun 2024 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ElG3alYV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E855F16B72B
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377735; cv=none; b=mr9Ve1PfAK1nLWskYquQfRINaoIO4O4VFFfMomrPp8CzxDe/cyM/cQtfI85M64LMj8O3iqGNjHz01MQ/+thjkFvbMtpCDsMW/KSKT4UymBzzh27gE979NVX20tndeDCawrYf3Wmafi4fh/Eo44E1ETLg6vTY+UXWuRKjz9+mL68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377735; c=relaxed/simple;
	bh=HrDFMm3wKTp0UO86+kI8aHZ3XDSGQ+2b7UCsc2lJ5RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZyHbkpDX+2cusn8SCCj/M3mNEorFi9J96VZ9zrzyS0sEFkykmAtFowhzb9xMR7bpMNwhIRy0Nd6Hxg5qbpa5awSs+JWFSO77c959tHXqyq5PdzFg6vTvKkKB8AeY2i1uyOOjDqxQzOuWET6xAAaBvKIPyCK/OdKx3MAEW3SZ3JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ElG3alYV; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d227b1f4f0so1166932b6e.3
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 08:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718377733; x=1718982533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=so5U+szNbhr5bnxSQqrZZ3bBxHi8XinDGxihgq18GlU=;
        b=ElG3alYVenfyC60oeKAQUBdtwT+VkJo6fF/6P1CcBLrjWqFpF7ibdC/RPMGWxRype4
         wBY4AWisfWXxbN/jWxq2CSeia32mKcOOSRY/gGz2XdzYNsmfnh9z4Rb6xpOeTnsNicg8
         ODgsdBUGXuYYBXwVz6ccg0CG63X6AuRuW9OvR1dpErtmYJB0IF4qFhCKzRcsqKRsbXsb
         vTDBBCur+7jOH+/gel7Ochi3Hw7OXPMcFTO6zZc8Css8AvgLmTYadppy++y4AcUCxskE
         SnSF8tu6h7JFwQcF/Hn+rhLR2gMrbtzEfTLTH7HXg7Knh7FAKModOc/hfmjYFPRbpnOv
         W0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718377733; x=1718982533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=so5U+szNbhr5bnxSQqrZZ3bBxHi8XinDGxihgq18GlU=;
        b=YV2SVoKc9b7iuM93IsLXOw0zRcD1RI504OXEFkJXIKSv4bEBX3Kjb7Ix0V7CRpjdNN
         PK3gj0VODpN4saAgMGmqM5AAy/0Yb1R+0FKMUrju6ez9AZ9RfjQSeu/ThXyWnFbvDhqp
         7gmM8A9XyIjM9SNnIUwykSh0poIupSWPanUbVSDHsgcQGW9uANVMwXdVImxJT0T9jlk5
         bEiCw+geV99FlEtE99rexEw80KjiQ7LJJK90wYy5H2tuA+tW5XzgPqJvVrrVOEgYxq5J
         dy0Z6LJX8aGuOklr2Uq6ggDcDwXvQ5pTPO3Yl7c4DFdD2+QovoBHw28xcZ4B5P4Rf9mu
         8Ong==
X-Gm-Message-State: AOJu0YxOjHMlCSpgmD6s8d9xAiKnd4hq3/VpGTk8KSkzevFpNPFrkp9F
	ceVet5eju5xbKjqVi/0XzgMkCpX+inJ1qr0M/4A04woQEYZ5usgry56o4lCvU43TkNC6gUTCmaA
	YC2TYC8/ZTBTHCP3cSCLQTx+pe5wHRF9VITBn3eLQIeVYMDlyAg==
X-Google-Smtp-Source: AGHT+IFwLI89Z0cObJU/BB4y3EADZgT0NPGQP8yPvcIcc70tnoYEV1Wzk2snZ+CT8t98W5JCjs0/zjJ2FHkRh1NIJcU=
X-Received: by 2002:a05:6808:170b:b0:3d2:2b43:1804 with SMTP id
 5614622812f47-3d24e8e108bmr3360579b6e.19.1718377732934; Fri, 14 Jun 2024
 08:08:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607160753.1787105-1-omosnace@redhat.com> <171834962895.31068.8051988032320283876.git-patchwork-notify@kernel.org>
In-Reply-To: <171834962895.31068.8051988032320283876.git-patchwork-notify@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 14 Jun 2024 11:08:41 -0400
Message-ID: <CAHC9VhSRUW5hQNmXUGt2zd8hQUFB0wuXh=yZqAzH7t+erzqRKQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] cipso: make cipso_v4_skbuff_delattr() fully remove
 the CIPSO options
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	patchwork-bot+netdevbpf@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 3:20=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This series was applied to netdev/net.git (main)
> by David S. Miller <davem@davemloft.net>:

Welp, that was premature based on the testing requests in the other
thread, but what's done is done.

Ondrej, please accelerate the testing if possible as this patchset now
in the netdev tree and it would be good to know if it need a fix or
reverting before the next merge window.

> On Fri,  7 Jun 2024 18:07:51 +0200 you wrote:
> > This series aims to improve cipso_v4_skbuff_delattr() to fully
> > remove the CIPSO options instead of just clearing them with NOPs.
> > That is implemented in the second patch, while the first patch is
> > a bugfix for cipso_v4_delopt() that the second patch depends on.
> >
> > Tested using selinux-testsuite a TMT/Beakerlib test from this PR:
> > https://src.fedoraproject.org/tests/selinux/pull-request/488
> >
> > [...]
>
> Here is the summary with links:
>   - [v2,1/2] cipso: fix total option length computation
>     https://git.kernel.org/netdev/net/c/9f3616991233
>   - [v2,2/2] cipso: make cipso_v4_skbuff_delattr() fully remove the CIPSO=
 options
>     (no matching commit)
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html

--=20
paul-moore.com

