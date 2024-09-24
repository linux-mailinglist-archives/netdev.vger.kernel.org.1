Return-Path: <netdev+bounces-129423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E927C983BF1
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 05:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 929CDB22A83
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 03:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856371BC3F;
	Tue, 24 Sep 2024 03:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="dqofcEpY"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D88B81745;
	Tue, 24 Sep 2024 03:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727150251; cv=none; b=cnnPGrXRqyUB3AADsEUP8CYs9wQ8fL1kk4zfFI6TCA/QFVn7CNjzrO0K1Pq3mck5hUWIvZkq+sI2KzP1o6sFymfOB5uPTkrez9FpujpGqWzjueNtrNVGsGBhE9dZFXBTLC6udOqkoa6odMVVTLZwMSt4wUiLGVHAcYNDsYy4lv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727150251; c=relaxed/simple;
	bh=OExNplF2IsEM956dC/bpJHbA5xOOF1pvAX1g3M4mLKU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZF9TOoAcUldAyXO+nXp7dtOG8Bj3foyQeH2sRuTwhoFKPET0bKU1CoNJTmjX3qavdOEzLJ44mrG7eysW+NPhKiKmWqsUwGkAZEDNsZmKjWFbvEJXiQUOMNwJ8svXRx0Ro67hEcYFgyLCSD2kxbe9c8N0czJgZmUD3+YQC5bIzXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=dqofcEpY; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1727150233;
	bh=3/zfigEA5k2pKAMdxtfIPVaHEGeiJjqFlDfU7n+gcq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dqofcEpYyjg3/NSi3Py5d8C1JxqqSGnZ66YUP9LyKxwajhvZZYsWKaotIaB4AU/Fo
	 ZJ+tKKquP1LBVBQoP2QrEQoi8ZwAg4jPzB2hZ6ioegI0rMYFjDx+OIyZXAGu4LbXlU
	 5EdXWskFkmvrFEFLUO6pVkX5irJ2a/BYF/H3L6Cg=
Received: from localhost.localdomain ([114.246.200.160])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id E4A9D433; Tue, 24 Sep 2024 11:57:10 +0800
X-QQ-mid: xmsmtpt1727150230t8qmfq7du
Message-ID: <tencent_A01E0A5EA0520995F067A792F49F5C9B1609@qq.com>
X-QQ-XMAILINFO: MMUVWBTDoFy1ZHUMjE8YcEY9/CPE2ivr725lxbbtm13hF/SkyK6sax0+sOFxxy
	 fwcMUP/BwY77GXg2XYgqAfAWcfuTHo7wOogecApOZVE5+PjCCjwBv8qbhBJ/yObKLMq6LjUiyXwx
	 6tUmwFqghjlRxPi3YPK/WKFZrx+wtik/i0dIhGCux6rx6yUhxamUas/rtzyuSaVM8rgcJNYNwgZl
	 ZA3ReenvNTIie3ukrCg759U0RNR4XOOwkXOOKn4nr2zIrsc/n9GvXuUxzqh33SskzRzgg8jEnV/M
	 XZra0OoVNlr9orEc1qSNwbBIpJDTq21y4ew840cH8WzE8OFFd92St0MMfTs1SYlhPYlH10HkqdG/
	 VAp5I8NyZlnkDOxLisWo/l8oGwyAxFwOXE5RIlAUV8XQA8pssNgl9ocf+KsC9LGmAloIk8zq2peM
	 B64DWM2HFvSt9KyEqQpEuHrvzo8xi5m2FuMxdutHT+D+jLZXH/gNJybjfhKK5ZS4IQYliF1Zrhrc
	 b0/NYt78kceKYdCrLnqLoyPa+Ct3V3Cmj/E3Kw/D6h1weJZYTozhPMVrwJNOZKWpSN8yA7KsTDQO
	 wBAoEgmCPyLpByl6Zd3YuallTD+L+Nseg4EaxTWivRABJjX+KC9/hz+79DELyizLrcZeZTv+0aGE
	 szeIRaEWdofJXG3c38se3XvoozIiBZMwEv2jPfJLuBqor3oyTolirALYpvlE0DQcFbQoXP8P6om5
	 gn/JA4oqholeSImLhlCe1fT0iTDz+DRdGJf7hlcz2r48KikW3QhOdi53ZjVARo+Q/4fH44Y5y88S
	 KbwKaVWbSizFiTGehAgaWuFjVRtqyerMAwS3HrxpjqvDtce/aA5S15MeUq1L5EPJ4CRJhqwZ8/Ms
	 yxs+CMSH1j5xsjZoe24XiEx0ryQtj8NE9DjbIgIPKzmEBk9LIES5q5XGSKpiM9aQgsMYIlGn6utV
	 YkO6CR1+vYtfKHPEzQV6r3p2dDb6pzQa9G1Fx0gSXHfVdUSMqFTnLCqe2O3MicRtSJFSAL7IUChw
	 DGY232pgo3nTHsWzTWCzcvq01loTvV30gCl1pgVZQX/U0bLoTXbnIHG7mwkXM=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Jiawei Ye <jiawei.ye@foxmail.com>
To: edumazet@google.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	fw@strlen.de,
	jiawei.ye@foxmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH] net: Fix potential RCU dereference issue in tcp_assign_congestion_control
Date: Tue, 24 Sep 2024 03:57:10 +0000
X-OQ-MSGID: <20240924035710.1993159-1-jiawei.ye@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANn89iLMVTgM4+GWfYO8ue2aV34qVx=p-uGQVQY4yQV6fv_rLg@mail.gmail.com>
References: <CANn89iLMVTgM4+GWfYO8ue2aV34qVx=p-uGQVQY4yQV6fv_rLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/23/24 15:36, Eric Dumazet wrote:
> On Mon, Sep 23, 2024 at 5:16 AM Jiawei Ye <jiawei.ye@foxmail.com> wrote:
> >
> > Thank you very much for your feedback, Florian Westphal and Eric Dumazet.
> >
> > On 9/20/24 22:11, Eric Dumazet wrote
> > >
> > > On Fri, Sep 20, 2024 at 11:35 AM Florian Westphal <fw@strlen.de> wrote:
> > > >
> > > > Jiawei Ye <jiawei.ye@foxmail.com> wrote:
> > > > > In the `tcp_assign_congestion_control` function, the `ca->flags` is
> > > > > accessed after the RCU read-side critical section is unlocked. According
> > > > > to RCU usage rules, this is illegal. Reusing this pointer can lead to
> > > > > unpredictable behavior, including accessing memory that has been updated
> > > > > or causing use-after-free issues.
> > > > >
> > > > > This possible bug was identified using a static analysis tool developed
> > > > > by myself, specifically designed to detect RCU-related issues.
> > > > >
> > > > > To resolve this issue, the `rcu_read_unlock` call has been moved to the
> > > > > end of the function.
> > > > >
> > > > > Signed-off-by: Jiawei Ye <jiawei.ye@foxmail.com>
> > > > > ---
> > > > > In another part of the file, `tcp_set_congestion_control` calls
> > > > > `tcp_reinit_congestion_control`, ensuring that the congestion control
> > > > > reinitialization process is protected by RCU. The
> > > > > `tcp_reinit_congestion_control` function contains operations almost
> > > > > identical to those in `tcp_assign_congestion_control`, but the former
> > > > > operates under full RCU protection, whereas the latter is only partially
> > > > > protected. The differing protection strategies between the two may
> > > > > warrant further unification.
> > > > > ---
> > > > >  net/ipv4/tcp_cong.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
> > > > > index 0306d257fa64..356a59d316e3 100644
> > > > > --- a/net/ipv4/tcp_cong.c
> > > > > +++ b/net/ipv4/tcp_cong.c
> > > > > @@ -223,13 +223,13 @@ void tcp_assign_congestion_control(struct sock *sk)
> > > > >       if (unlikely(!bpf_try_module_get(ca, ca->owner)))
> > > > >               ca = &tcp_reno;
> > > >
> > > > After this, ca either has module refcount incremented, so it can't
> > > > go away anymore, or reno fallback was enabled (always bultin).
> > > >
> > > > >       icsk->icsk_ca_ops = ca;
> > > > > -     rcu_read_unlock();
> > > >
> > > > Therefore its ok to rcu unlock here.
> > >
> > > I agree, there is no bug here.
> > >
> > > Jiawei Ye, I guess your static analysis tool is not ready yet.
> >
> > Yes, the static analysis tool is still under development and debugging.
> >
> > While I've collected and analyzed some relevant RCU commits from
> > associated repositories, designing an effective static detection tool
> > remains challenging.
> >
> > It's quite difficult without the assistance of experienced developers. If
> > you have any suggestions or examples, I would greatly appreciate your
> > help.
> >
> 
> This case is explained in Documentation/RCU/rcuref.rst
> 
> line 61 : search_and_reference()
> 
> For congestion control modules, we call try_module_get() which calls
> atomic_inc_not_zero(&module->refcnt)

Thank you, Eric Dumazet. I will further explore the details in
Documentation/RCU/rcuref.rst and related documents.


