Return-Path: <netdev+bounces-201935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1258AEB7D5
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 14:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75F0C1892024
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 12:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061262D12EB;
	Fri, 27 Jun 2025 12:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lqP3mx7M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A8E29B8D8
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 12:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751027759; cv=none; b=WEUoRr8DL0fN7GtsVgIcHKOhlyp9ocVnHLH0qmNpAiPbD7aYJDVU+BeguonPDjM/jkKb7UTU96OX8Y/dXAacmSDzVMuRnx6tZa75j/MJtI+Onenn4sQGbH/UO2GWlxWZaB/STHs7S6oMNIy54RphlyFT6o8bXnByvxHee9+AiU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751027759; c=relaxed/simple;
	bh=Kq5erFkaUKocINIQLfCU2KsuuOX0uybYGqZMyB8nJaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A5TlREscQA9tftHYeOY1h1dTK+Sp58soehwsb3FiPS6b2I77xT2GQLNNy5jgMy0KAtvadBuVVmbP47d5K9NwuthKtjOaXGIMUro9/2qgBiwiRFQYgsksinEE0e2w50SXsTzb9Wjfq+r87Wev4S/dDYL/1BII85iRwcNS+APR5S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lqP3mx7M; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a7fc24ed5cso299231cf.1
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 05:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751027757; x=1751632557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knb6VaSN7H/rapudXZLPi36++fqnqlzmQ7zJ5T0VkcM=;
        b=lqP3mx7MxjGwAUYltx0pGwTGoHlGEbtKlhsnXXTXrtyzLG+OY95LrGadEUOZmLdYiZ
         qo8RZG1H/twki6D7ZstM1JcGcN3SLM6sw0bEJi2Ah2DP/TNxKj3XsXUATDEWsezX5dQx
         6SH4HguW+9Dg3s4J00zpetNTWkzHJeeTZuG1w+UqK5gtft9328/mfPrvxSePi242ecsK
         ij8GgcW0TOE9p7PRKJhDgKSjqXmAuyKe0fB+ynzxAMJUjWrZlM7NqaOzTK30wWfeavoW
         4A2nqQe87k7rY8vpS770srP80rNHuEJmFHoQYzCyMSPK1mC1jgtQmzeWtWU83/tWa/Hs
         IlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751027757; x=1751632557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knb6VaSN7H/rapudXZLPi36++fqnqlzmQ7zJ5T0VkcM=;
        b=m+/xXeJVyNnru+frub9FmC62M+NkXoJZIrMRU6ht8R/WhznJotJxnB6PZf5wbgrV+K
         CNDn9vplPRHPggtIBgKMj6K0dOaL2d+afI6Z9jjURk2RkfwIOk/dO9zn9PG0zqY0zvsy
         vyFmJ7g3e6wwWll9TKi0/pH5zbNq1PVeS7VXgXCkeaEkQEEPwpsWwbzQ25wtpE2rucX6
         9EJaXSfcjzkvpLsNiEWheQ+1RTUZ/bLSYu8Oi4f0vw69GDSLWzgiomoTKZQjGSiQWDDN
         pWTDP3QcY8eB02N1lOY3rK3htXiMMHX/1S1MgE97p8QK+QSpVmwZdGgEAmH9ErFMNzsn
         CBdA==
X-Forwarded-Encrypted: i=1; AJvYcCUZUa+WYm/tYK6if+j44yCmywz/336sjadViiY/Z4TS1mq1GSu7ZAfq8T8aXlVWA/B0VGM9iRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqz0bbYRnmo79o3P+wam2nNqb6QOTlNlLHiZ1KAEHX+3TGt5Zy
	y1/XKQRs+S/ySpTMVB2Ki3pDP11V6LLGBdjnyaWv2TR93AOXcUPyzw3CmRO421QrpUKQz7EN46C
	YfgPZf0iIY4BpVUwkjhBzBtxjgppy0pbbYE79EB4R
X-Gm-Gg: ASbGnct/OqvYDRjrT8yEbQT+KBOp6mdB6g4r6uIyDqKgyD0LqjyTSVFO0//GX0qR9R+
	foGrXWLoE6HYmVgkt5ePZchupIjM1MrmgYboCM+6IL+q/uQYkz+f+afWjOlre/8FncwNLWLVG28
	yL8qdQNVVx7I1b8W3YB7AzGdgPYmd8a2JkhNNqAQeY6JM=
X-Google-Smtp-Source: AGHT+IGzBhZhxIhp2JUilvz8Qa/wByUwFC0LC3jr35KqTZmhL26RX3sffW9sXASIIGhKDl+8JWtRNiIYfYwjKb0oE2k=
X-Received: by 2002:a05:622a:199c:b0:494:b833:aa42 with SMTP id
 d75a77b69052e-4a7fed8044fmr2832021cf.5.1751027756931; Fri, 27 Jun 2025
 05:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627114641.3734397-1-edumazet@google.com>
In-Reply-To: <20250627114641.3734397-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 27 Jun 2025 08:35:40 -0400
X-Gm-Features: Ac12FXzIWsmjyANDHrjHX5-fmpvodIrZqsqcY7dOaAPk9BIRNtmMRJM30pFuwEM
Message-ID: <CADVnQynbzZJhfgAx_RK52PTcDG2A42JTFZQXGUKNctSq96sZxw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ipv4: guard ip_mr_output() with rcu
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+f02fb9e43bd85c6c66ae@syzkaller.appspotmail.com, 
	Petr Machata <petrm@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Benjamin Poirier <bpoirier@nvidia.com>, 
	Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 7:47=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> syzbot found at least one path leads to an ip_mr_output()
> without RCU being held.
>
> Add guard(rcu)() to fix this in a concise way.
>
> WARNING: CPU: 0 PID: 0 at net/ipv4/ipmr.c:2302 ip_mr_output+0xbb1/0xe70 n=
et/ipv4/ipmr.c:2302
> Call Trace:
>  <IRQ>
>   igmp_send_report+0x89e/0xdb0 net/ipv4/igmp.c:799
>  igmp_timer_expire+0x204/0x510 net/ipv4/igmp.c:-1
>   call_timer_fn+0x17e/0x5f0 kernel/time/timer.c:1747
>   expire_timers kernel/time/timer.c:1798 [inline]
>   __run_timers kernel/time/timer.c:2372 [inline]
>   __run_timer_base+0x61a/0x860 kernel/time/timer.c:2384
>   run_timer_base kernel/time/timer.c:2393 [inline]
>   run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2403
>   handle_softirqs+0x286/0x870 kernel/softirq.c:579
>   __do_softirq kernel/softirq.c:613 [inline]
>   invoke_softirq kernel/softirq.c:453 [inline]
>   __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
>   irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
>   instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inl=
ine]
>   sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1050
>
> Fixes: 35bec72a24ac ("net: ipv4: Add ip_mr_output()")
> Reported-by: syzbot+f02fb9e43bd85c6c66ae@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/685e841a.a00a0220.129264.0002.GAE@=
google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Petr Machata <petrm@nvidia.com>
> Cc: Roopa Prabhu <roopa@nvidia.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Benjamin Poirier <bpoirier@nvidia.com>
> Cc: Ido Schimmel <idosch@nvidia.com>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

