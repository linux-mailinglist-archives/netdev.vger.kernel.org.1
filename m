Return-Path: <netdev+bounces-129223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2782D97E4ED
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 05:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D34A4B20C69
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 03:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCC24437;
	Mon, 23 Sep 2024 03:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="xd/7QcKB"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4F02114;
	Mon, 23 Sep 2024 03:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727061014; cv=none; b=nGBVVC7UwjfEu75Dz09EjZY4LleEACKEWy4cPZXqmxYi9YOXdLq7Jn+8q94lLilXnsA9TZiABAdvddrBTogzO2McrmpCp/FIUXfVQv3oQqjSIoFi6LzA1iWq6BluUVzet0EUCPIYYlIjqEFRHHWVxqJ/uO6hggirVUrEL0ttOtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727061014; c=relaxed/simple;
	bh=nrhud71X6LQqXvqTiNUo603XxA2gxvtXfuyZb86jIWI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lH1UwL3CrQ07mzyBeVWyzqesIzwX00BHmSjyzsjss70HPuTxSen1g4HMMOGA/entLk9/zf91nQHKNXJeoqQWyhP4ergG0JzLUmSSiMNr0qEMuLb72ehQETvFtE7cVRZBZxMA9/GWjmHIQpT9ObppUCAH+qX2EmKA21lxauJ1Jqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=xd/7QcKB; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1727060999;
	bh=bFaU/1T0LwEzSReEsmUgeOmQ8IuikMYglCA5b559DoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xd/7QcKBOEt7Y7RjSR8CkXuceC2ZrgPWRm2PAoTG5spwOeIE7B8ht2MsOk920D1l7
	 bLDJV0RwcG7mjvsOE7XzFRnlJ7gAUgEshi3g+mR9icU3tkgJjL667Mz8iUkInbSFZr
	 DUclDSax6uKfi4/DUNP824YCDUOt9BXllz03KfQA=
Received: from localhost.localdomain ([114.246.200.160])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 278396AC; Mon, 23 Sep 2024 11:09:56 +0800
X-QQ-mid: xmsmtpt1727060996t0wnzjwop
Message-ID: <tencent_AB92549E869AAA1F1E5EF653439554675109@qq.com>
X-QQ-XMAILINFO: MiPTq5wGoKOmSaVzu8dFqRWrfAc13ZD/1Kw+McXloL19GN0psb/S2J1BYJaxsx
	 ZaOaKKNb6n7KTjt0qESOUSTrLiYhrTT65wO5DZj/Sx0qv/xbxohBZHmkf4rNeQWG3Ey/Xnex8E+n
	 IZumcRDsCtLgKZmK4Ra5X80p1mpTjA4nDPPLdMnaM40HB51Q35EglPuVA28l+iR+RUiGn5mUOVbJ
	 9t0XDZVYah0RPwVUvjsALEQQX9k8wgThIQvx7P0Q1whDcfCaTG0KqG5BDGMJiJTtUXVvei2p6gGs
	 TrWLkko0UXFM1C2cRohXdqp2F2U4Ha1xxnKNuf4MJYAuRmM6hhT37OMbprO8+BtLbUul+FpHn9v9
	 syZ+rdIP3nxHcN2u38c4buH8PrWJHZNhxls8zKLJ+eBmZwAvx8TF1hwQZ2OwkIQPTCvon8Q0W39d
	 1PViI9QIkiQuFaWlUdF1Vgt39ddAsU5ccNTZjwUZm+njMYGi8UapmD0vcpVVqvLYe7GH7XdSPJhF
	 nGTP0uWAsvK2PAWEE2LrovYgz6qJbvDigrP+W9t6sK6bdgd6ri8dnx0DWtkxYaxIOxOC3pZiIbi2
	 QYOvnT+d5wOe89TvI5D2G7DxogFLz00F9PKMCdp5WG28c12hvBXHzgeuMDUfSv++ygr/e8ZvfNbs
	 xKCQ1gfksoqd//CUhCEIVN8vp6we301u1k7fSgtrURuwHHwK9sLHLBGslBUPMoRxjoRcAnYyCHjy
	 Qw1DvA6V5RNWWm9Go+cbmmV1dUwJFLHx2jaynAbdPhZOt8MIsiywcRMWLXMgLwXm6dK65k+YI/zo
	 xBoTn4ZpW4WE/bsBLVLH/PtUk+Ave6tq61Wq6rDIxYsFJloIAdyDKBk9IBwini0pi7H+YzskiiSa
	 Q7Zqyp2g3n+1NaX030tQGWK1Y73yA2JOp2X8Ke9yGlChrMCUMhq5trodNqDSr31tKnyZa1G37sCc
	 TuBBHIFS/dweK6v7arOHhHm8V8CneaaSNYaxiq930Ntf5PtkWMzXfHhGj00cQH7UL2pYlZ2L/JXz
	 OxfL2W62XSPLl7OAc5
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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
Date: Mon, 23 Sep 2024 03:09:56 +0000
X-OQ-MSGID: <20240923030956.448500-1-jiawei.ye@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANn89i+E4RP+gJghHZujmKUJbCgYY_L20ssVmvmRUT4a8FvunQ@mail.gmail.com>
References: <CANn89i+E4RP+gJghHZujmKUJbCgYY_L20ssVmvmRUT4a8FvunQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thank you very much for your feedback, Florian Westphal and Eric Dumazet. 

On 9/20/24 22:11, Eric Dumazet wrote
>
> On Fri, Sep 20, 2024 at 11:35 AM Florian Westphal <fw@strlen.de> wrote:
> >
> > Jiawei Ye <jiawei.ye@foxmail.com> wrote:
> > > In the `tcp_assign_congestion_control` function, the `ca->flags` is
> > > accessed after the RCU read-side critical section is unlocked. According
> > > to RCU usage rules, this is illegal. Reusing this pointer can lead to
> > > unpredictable behavior, including accessing memory that has been updated
> > > or causing use-after-free issues.
> > >
> > > This possible bug was identified using a static analysis tool developed
> > > by myself, specifically designed to detect RCU-related issues.
> > >
> > > To resolve this issue, the `rcu_read_unlock` call has been moved to the
> > > end of the function.
> > >
> > > Signed-off-by: Jiawei Ye <jiawei.ye@foxmail.com>
> > > ---
> > > In another part of the file, `tcp_set_congestion_control` calls
> > > `tcp_reinit_congestion_control`, ensuring that the congestion control
> > > reinitialization process is protected by RCU. The
> > > `tcp_reinit_congestion_control` function contains operations almost
> > > identical to those in `tcp_assign_congestion_control`, but the former
> > > operates under full RCU protection, whereas the latter is only partially
> > > protected. The differing protection strategies between the two may
> > > warrant further unification.
> > > ---
> > >  net/ipv4/tcp_cong.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
> > > index 0306d257fa64..356a59d316e3 100644
> > > --- a/net/ipv4/tcp_cong.c
> > > +++ b/net/ipv4/tcp_cong.c
> > > @@ -223,13 +223,13 @@ void tcp_assign_congestion_control(struct sock *sk)
> > >       if (unlikely(!bpf_try_module_get(ca, ca->owner)))
> > >               ca = &tcp_reno;
> >
> > After this, ca either has module refcount incremented, so it can't
> > go away anymore, or reno fallback was enabled (always bultin).
> >
> > >       icsk->icsk_ca_ops = ca;
> > > -     rcu_read_unlock();
> >
> > Therefore its ok to rcu unlock here.
> 
> I agree, there is no bug here.
> 
> Jiawei Ye, I guess your static analysis tool is not ready yet.

Yes, the static analysis tool is still under development and debugging. 

While I've collected and analyzed some relevant RCU commits from
associated repositories, designing an effective static detection tool
remains challenging. 

It's quite difficult without the assistance of experienced developers. If
you have any suggestions or examples, I would greatly appreciate your
help.

Best regards,
Jiawei Ye


