Return-Path: <netdev+bounces-119940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5726957A7F
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 02:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7076F1F2360A
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 00:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1544C66;
	Tue, 20 Aug 2024 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZOuVYqn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AFDA927
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 00:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724113791; cv=none; b=rpuA1ob4eeQzXZ2n2uWsnYddbNgd/LU2kP7vchrLD+DZHMxI7XFSN6pZ7iMT+fxPRaCYadQ2CO6v+bHho7pEJPF0alM4EoYlk30xQVCYH1vNNSAxIcDn65ueJHoSYhRTLBrsRCIwzCL+Oj8GS6WGz/RL1g3EDMh9f6hBARikamc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724113791; c=relaxed/simple;
	bh=I5YCOXJbI9UUsmsnHzZHszPCwuOq3iy6WIYbtbQN1wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6ur/vb0h64+82JCzwR7CUDzKPIdLJs2esCtx636Hq75d+fzYwsE6Gi9luc1Mc7qJT0li7jRGeFKGQTPBa3erPhOgHKsvgFJDKhZ2of5yG4tVR4cCDJ4QVTuaIvrj5tJ4gysfZ81UJ5MteeOgQAEAWFMHlo6f4UzVqplf8ZdS5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZOuVYqn; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39d21fdc11bso16797065ab.2
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 17:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724113789; x=1724718589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhLNdORnqjAvGpX7mEBiwgcfXa1NUr6sGdrEYPk/fbE=;
        b=SZOuVYqnoYruKyE46K57F4K44Er29+6LnvTVTdWDd21x14ibsSL/XAB8vbGuO4YnIN
         wfaxIOKnjPTW+k50vSWpeJ3lSlC3UiEo2B9pTx9YFUrLnH05Jp8VHWdeitV3otQpxLG1
         6jMQeZpUDfAzx7G0D9MMAN2+ZPS3EBejcUrQgGKdect8tvvKqRVXpMAwscG/nwoXIvq9
         1sz2KDNqaHwmF39aPVoU3YBrodL2skBL0lBnYkEC02MszR3xxXiAPRmFUruhSPK3KN7u
         APzj8q9vFz1IuJ0VTn2TC+d5JwA0tp1AdaG78Imn1mL/ppG6lS27kqEXAcTTOFObt2Th
         2m9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724113789; x=1724718589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhLNdORnqjAvGpX7mEBiwgcfXa1NUr6sGdrEYPk/fbE=;
        b=CKcHOtlnWKoGWoHWQK3PVzc1UUAgwXKTrW92XdHAR8RLcJfJsdAcUfL6XBUHNRWBx9
         z2dAXP3JU1cdmKtp/U1koZpR5IWFGsJS8fMunLnf4YwJlO/sVsRRenH2JuzBNxCFZuXt
         gXdwDEOEEaOSZe5SEs7bhmukVvyLMmTehWEq4Cr5tRbkcMrzcltNYkv0SR2Ni+GHsry8
         SC9fUscxKWBS1q8k6lL9D3DJkt4gBKYkbB5StH2P+qWx+xk/HnnlXBuAChuS+jHov8zs
         Y7MZQxJIKjBqnWZT5bijikqEBeaCszRPJs5Gl4S4nTNrlsCC6cdng2NoHE1N5vrpd1qV
         C5Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXCwDZzXmgOD0MpbTsfw62u1ptC8vL1hc4TPYFEq1UeF3nI71MTOvGQMN1U7WGwPZwOeEwxIyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf1Muqm+jxM9ox4zaURbWtvV+tq6QqonmxntF3Rgp7L8Bvmdjd
	wVVJg2PbV/9S7A35qR1eAYZXrAoyc0rPZ/zWOi7e3BJPyThoB9uKor8laq3EKiXyTWc/wkmx8+5
	FHFYr573G4ouf8+NlK73EmTKkQ0c=
X-Google-Smtp-Source: AGHT+IEQ+YKiga9k+jsbKy9Ac0rNqD8lx6/wXDC571t99afqYVYNHDjeLQB+V5Z8lSfuPuPVGHyUhNbJa+uHywg+fH0=
X-Received: by 2002:a05:6e02:1c04:b0:39b:2133:8ed4 with SMTP id
 e9e14a558f8ab-39d26d04977mr160716195ab.14.1724113788779; Mon, 19 Aug 2024
 17:29:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoCZQdU5H3c88g3MMoBRxvMTC81HaVzKF4TL=mA53arwWw@mail.gmail.com>
 <20240819175614.14990-1-kuniyu@amazon.com>
In-Reply-To: <20240819175614.14990-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 20 Aug 2024 08:29:12 +0800
Message-ID: <CAL+tcoD=Skk06JGEOntJxYL=Zn17TCxXuFxbXDma5AFn3DumHA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: do not allow to connect with the four-tuple
 symmetry socket
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: 0x7f454c46@gmail.com, davem@davemloft.net, dima@arista.com, 
	dsahern@kernel.org, edumazet@google.com, fw@strlen.de, kernelxing@tencent.com, 
	kuba@kernel.org, ncardwell@google.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, pablo@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 1:56=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Mon, 19 Aug 2024 17:41:32 +0800
> > On Mon, Aug 19, 2024 at 5:38=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Mon, Aug 19, 2024 at 11:32=E2=80=AFAM Jason Xing <kerneljasonxing@=
gmail.com> wrote:
> > >
> > > > After investigating such an issue more deeply in the customers'
> > > > machines, the main reason why it can happen is the listener exits
> > > > while another thread starts to connect, which can cause
> > > > self-connection, even though the chance is slim. Later, the listene=
r
> > > > tries to listen and for sure it will fail due to that single
> > > > self-connection.
> > >
> > > This would happen if the range of ephemeral ports include the listeni=
ng port,
> > > which is discouraged.
> >
> > Yes.
> >
> > >
> > > ip_local_reserved_ports is supposed to help.
> >
> > Sure, I workarounded it by using this and it worked.
> >
> > >
> > > This looks like a security issue to me, and netfilter can handle it.
> >
> > I have to admit setting netfilter rules for each flow is not a very
> > user-friendly way.
>
> I think even netfilter is not needed.
>
> It sounds like the server application needs to implement graceful shutdow=
n.
> The server should not release the port if there are on-going clients.  Th=
e
> server should spin up a new process and use the following to transfer the
> remaining connections:
>
>   * FD passing
>   * SO_REUSEPORT w/ (net.ipv4.tcp_migrate_req or BPF)
>
> Then, no client can occupy the server's port even without
> ip_local_reserved_ports.
>
> But I still recommend using ip_local_reserved_ports unless the server por=
t
> is random.

Yes, there are some ways that can mitigate or solve the issue.

The reason why I wrote the patch is because at the beginning I don't
think the self-connection feature is useful which you reminded me of
some test tools like syzbot could use. That's not what I was aware of.
Thanks for your reply.

Thanks,
Jason

