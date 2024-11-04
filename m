Return-Path: <netdev+bounces-141585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A979BB948
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 16:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2A028281B
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 15:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DFE1AF0B9;
	Mon,  4 Nov 2024 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IZlnFGSn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8858C78685
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730735126; cv=none; b=nn8guSC8caVQTKQ9AO7x272WHkcZqnzXsxxazqasBU4kITcOEdNwMI8gTeWKa8GLuWcEJYOdnrC/eNGhmB5pkTnkaQNAgLjIG3QyN37pOLtC+Hudpg1aEKxRqi1psz3OVdPGsuNe3bXL4JXyTn1ubSMD8r4f+JC7WAKZL6bH9TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730735126; c=relaxed/simple;
	bh=hPDJcBx36zovOZyGA7UWvc4j7jN6je11Jp4t2rUWfj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwF5JD5ApzI04gomQjOosyi8caW22qXdXuCgVgYdvrWS67yITMjo1ae3kvu5RCYF8I+BxLHZGPw1Ul5yr9GjiM0wBXXZiVo1kAw1pcdLYA/5mv4fsI26Kg4aLZ6J6g74Om4STaEw8J9zDj1VcsoHNRDcdNWeaJ6fywQ64T8YF/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IZlnFGSn; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso7177721a12.1
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 07:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730735123; x=1731339923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyD6YqQEWKxUIe4S6LmMmf6PWiCVhHiKz195ndFs5bE=;
        b=IZlnFGSnmD0MRHl1RSGrTBtSDERcLIHBKDCy2jsi6tYJ/IcomdMVderOnZQHELTuQS
         DLa8CRjg/AdXlIwXSb04KblacKVUKThfN0Oj9eoivkN86x9XdJk8WXFEDAGJmu7cIY4D
         QEDUxUipbPW6debAfE339w164mBugU3GgUcDjldO9onP/7KVHDOO4Kno1b2L4gG/RIds
         VzpjowiQ93tlM4+B7R8FYHjY0TjSR+mNDzgusIhs1VVWTmY9O2ShrduVMgjJH1BNnDaG
         0sHTwW8j6BiY6k6gwmYYckFxx36I0WsFL3zz31c+GDTbDX5qBOWnlEAzBWH5pTCK45Tl
         p9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730735123; x=1731339923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyD6YqQEWKxUIe4S6LmMmf6PWiCVhHiKz195ndFs5bE=;
        b=FtwrUgB5Iq9BYMC02/ThGzHaKtmx8i3g7mXp96jTkhQEWBmWfKHifSDO/zisT4O8F2
         nZJsppjLpslGJ5HF8ArG+PZYkv+lFQpJHBlp7ahoLgW/99netlEe3VvHUkLMYuY5SXee
         CGoDlEOvpb2UHkKQDoqEXyiUoe7X2dHrxC6LlcT5ttSoPrPfnTpCa7J1TJmtEYe+SFrj
         mf4TWSk7+95wdOIOVpemqF/vanCRY/qGZfuaV0kModQmzVMXAgscUxDS2TM5WHDhvKOs
         G7OJT6KPyarOe18kzvBTYy56udVl8kWXN9LpQ2/WAnR3tefyUBCojhO1ScIJze+fvL2r
         s/zw==
X-Forwarded-Encrypted: i=1; AJvYcCXAr7faaB7tJUYFoP1GOAGkaLNGVs3RbD6ej0GghlOhushoUnjQpmCYzf1mlaoWu1Ou0GDj0xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP4Ukno5+T9Q+8sC2vJrp1Jg37t3PQ1oUMZZmH4mSdO4JnAAkr
	KJqrhDmENZe5D4eOp7R75QLoXfsx5yn0X1Fbu4Bi4Fc3anguDjOKF8kuNvBnLPyK1683+LK/3DB
	DTLN3lL+y213CrOQ+Y93J/76cPwupajjtCusq
X-Google-Smtp-Source: AGHT+IEL4Bfa722zzMFIJFIe6LUBra+dg2DR/J927/adcjEn393kcxsz9by8vrW9A2NUCiatisxFPqNB6U5c0PPsRnA=
X-Received: by 2002:a05:6402:40c2:b0:5ce:b120:a080 with SMTP id
 4fb4d7f45d1cf-5ceb120a12cmr14019344a12.13.1730735122632; Mon, 04 Nov 2024
 07:45:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031122344.2148586-1-wangliang74@huawei.com>
 <CANn89i+KL0=p2mchoZCOsZ1YoF9xhoUoubkub6YyLOY2wpSJtg@mail.gmail.com> <0913d4ba-7298-4295-8ce0-8c38ddb9d5b6@huawei.com>
In-Reply-To: <0913d4ba-7298-4295-8ce0-8c38ddb9d5b6@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Nov 2024 16:45:11 +0100
Message-ID: <CANn89iKWbcjavVB-7Lwqou8n2v6oGnaE3-jzDz7n9Nj3+5yJTw@mail.gmail.com>
Subject: Re: [RFC PATCH net] net: fix data-races around sk->sk_forward_alloc
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	dsahern@kernel.org, yuehaibing@huawei.com, zhangchangzhong@huawei.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 7:24=E2=80=AFAM Wang Liang <wangliang74@huawei.com> =
wrote:
>
>
> =E5=9C=A8 2024/10/31 22:08, Eric Dumazet =E5=86=99=E9=81=93:
> > On Thu, Oct 31, 2024 at 1:06=E2=80=AFPM Wang Liang <wangliang74@huawei.=
com> wrote:
> >> Syzkaller reported this warning:
> > Was this a public report ?
> Yes=EF=BC=8CI find the report here (the C repo in the url is useful):
>
> https://syzkaller.appspot.com/bug?id=3D3e9b62ff331dcc3a6c28c41207f3b99118=
28a46b
> >> [   65.568203][    C0] ------------[ cut here ]------------
> >> [   65.569339][    C0] WARNING: CPU: 0 PID: 16 at net/ipv4/af_inet.c:1=
56 inet_sock_destruct+0x1c5/0x1e0
> >> [   65.575017][    C0] Modules linked in:
> >> [   65.575699][    C0] CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tai=
nted 6.12.0-rc5 #26
> >> [   ...]
> > Oh the horror, this is completely wrong and unsafe anyway.
> >
> > TCP listen path MUST be lockless, and stay lockless.
> >
> > Ask yourself : Why would a listener even hold a pktoptions in the first=
 place ?
> >
> > Normally, each request socket can hold an ireq->pktopts (see in
> > tcp_v6_init_req())
> >
> > The skb_clone_and_charge_r() happen later in tcp_v6_syn_recv_sock()
> >
> > The correct fix is to _not_ call skb_clone_and_charge_r() for a
> > listener socket, of course, this never made _any_ sense.
> >
> > The following patch should fix both TCP  and DCCP, and as a bonus make
> > TCP SYN processing faster
> > for listeners requesting these IPV6_PKTOPTIONS things.
> Thank you very much for your suggestion and patch!
>
> However, the problem remains unsolved when I use the following patch to
> test.
>
> Because skb_clone_and_charge_r() is still called when sk_state is
> TCP_LISTEN in discard tag.
>
> So I modify the patch like this (it works after local test):

SGTM, please send a V2 then.

