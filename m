Return-Path: <netdev+bounces-237947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E47EC5201B
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 12:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDA8D4F130E
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CCC2E8B83;
	Wed, 12 Nov 2025 11:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hG2M5sZH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE3ABA45
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946534; cv=none; b=FY8573pXnGtRi6dl60kKlTU2Kv6OYp+doeKYvOcsSB+NMFIVx8tz30gmu/XMu7Gg9fbJUJyOvWjjdkeq9EIAn/Wy2v0sVHbz+nicE5yzzE9n0Fd7ZTlbaoZm60BQb8gohrLbroRU6tQpMiEDvD2mEGb+7x/fqZgxELBR3/gWFv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946534; c=relaxed/simple;
	bh=7fKSQVBgMwJc5c/cBdPn9hKClzr6/00FUMqvOCg7+Ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mM31tVDkr8OD2ONBnLuXP2QCSol2/SMA+uzmMiFh1oj229MKHimMe2II3WPGPwCrYeVPkREXGMDxLq5wSRzDHy3VkGenPYa/QCrLtLXIzcyeewOdEZkMY38DOxLXyahtu+g4tkv3Ujx5grgWCOp46YGyGgT0ODRAxDTQkr0Qi8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hG2M5sZH; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ed946ed3cdso5690731cf.3
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 03:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762946530; x=1763551330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1v6KitHP0mrijsIIMG/ScW6pRmmdbLhHEWbmOep/FJY=;
        b=hG2M5sZHisTvhDkuvOKTUY6ZGzSOj5RSZxOAxAkBkKV0RUhTyqpCbrxwjyLcTj/p4V
         2oiEJpcVMJO3JcqEHjIHaCiH2xLTXcksFbvvVUnhtsx/QxCjzbh1jEVha3U5eG8TuZBN
         wDfx298mhvfiG9cAFtNSRXnAWpTJXwz5NZ8t183RvaeYkgcPmrJUS7fENiGt7h/QzSaZ
         EBY7IArpTnAIVxibPT7Onowv7dEx2ojtXlIuBzLALzH2y3AKKTlwyMV/FGBDQonvz1R+
         RXFo8ivMsge5KcGj1O3GgTvg572pS/Bh2MDLpkfASs4novgk3Bq2g7XhYzoUgKgsrRPt
         sO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946530; x=1763551330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1v6KitHP0mrijsIIMG/ScW6pRmmdbLhHEWbmOep/FJY=;
        b=JM1RqmDD5dhacfpS8FCFYkXOShhAVt/qtQ+kTIzmvQ7P3RZWt8XkZQ0ddVEPgsrb9g
         kLTTOyfLj8Pk8Vv/rEI5ns4scVh6ABVXPnHgL/kG21+Tjsi1lZ6kNrE8JvfwcpM8I/Av
         jmez73LVWICzoN398Bfhv2khtfGuhy6Fylnn+ruc1ZPOilbK5wG9VAeY39TxvpgdIt63
         0yCkRUgl/zoRzP8ZBiTM4JI4lUpNmLn2Ru/YJJ8LazZMEfzTJugQ4rTO7IXQkCMqWSVI
         qC46LxuwAxgsVg061Tc/gg6YRMAjgWV5kKwLtfjFsPlee1OtBdQ7eurkkhp08z62+DDb
         iD/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGebqKbXcTSzmSdelkvmQGPbODsP6ZFd5AP27QjDzyOZhKzgz72yWW99GE0+Yf5JazW8qeYmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBvi35gwLnS5sELBLfXI2CeSpKINBNvGvg+mgmZwdqo4RGEcFv
	2XbydT1t4udWSSCODi64a+tXyWg1VnimAuCmJGUJCNGYsXcJfZLQtik25/tV2B2GSqaMVYoQsR9
	RfEDnj3Nf+AtxSISKKXkG9tJ968oYF957wW7a8Xv1
X-Gm-Gg: ASbGncuncFFiAl9oFPqAaYziY71e+TZVcEoiiOihCL2Ocj6Pw6bmPeS1/Wumrg2W4gc
	d9g/wyTXuD6gWor+lkGiIdaczYr9GzAscFLxc+77AVyihSchuYQ92Xw+TGu0LK5RuUe7KWmV9iR
	JU/coKLrdaZJsPo74rZgqrrhveCv0WgE5N2gAcCjWRneyzevwTm1SLSWVqY4hAL021Zb+YdYzQd
	3OfJZ45tjS/EX/5HSWfRWVhn46Bz8ztZEVdpuIYtUMaDwyU6ORds1PJWvDojAOIQm3vgM0WacC7
	5ZlphIA=
X-Google-Smtp-Source: AGHT+IEi/wjI+xrJUaMuyZe1e3y0m/e+M123Su+osrkMJXNF0rNPuV4s7x8o2Z9UBWiUvIehotFH9n9tk2ngeQzkAR4=
X-Received: by 2002:ac8:5f93:0:b0:4ed:6782:12d5 with SMTP id
 d75a77b69052e-4eddbc4df29mr29148541cf.3.1762946529958; Wed, 12 Nov 2025
 03:22:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109161215.2574081-1-edumazet@google.com> <176291340626.3636068.18318642966807737508.git-patchwork-notify@kernel.org>
 <CAM0EoMkSBrbCxdai6Hn=aaeReqRpAcrZ4mA7J+t6dSEe8aM_dQ@mail.gmail.com>
In-Reply-To: <CAM0EoMkSBrbCxdai6Hn=aaeReqRpAcrZ4mA7J+t6dSEe8aM_dQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Nov 2025 03:21:58 -0800
X-Gm-Features: AWmQ_bnn4jGoe2fGISwliX4RILxlWCphKfwWUPxCUkxV7BonBsMAFjZ4WeZS8-M
Message-ID: <CANn89iJHVEbq_Cz8C6TGqOUig9xvC=joOeh_Anb+4uTW=Nyx6w@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: limit try_bulk_dequeue_skb() batches
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, kuniyu@google.com, 
	willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	hawk@kernel.org, patchwork-bot+netdevbpf@kernel.org, toke@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 2:48=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Tue, Nov 11, 2025 at 9:10=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.o=
rg> wrote:
> >
> > Hello:
> >
> > This patch was applied to netdev/net.git (main)
> > by Jakub Kicinski <kuba@kernel.org>:
> >
> > On Sun,  9 Nov 2025 16:12:15 +0000 you wrote:
> > > After commit 100dfa74cad9 ("inet: dev_queue_xmit() llist adoption")
> > > I started seeing many qdisc requeues on IDPF under high TX workload.
> > >
> > > $ tc -s qd sh dev eth1 handle 1: ; sleep 1; tc -s qd sh dev eth1 hand=
le 1:
> > > qdisc mq 1: root
> > >  Sent 43534617319319 bytes 268186451819 pkt (dropped 0, overlimits 0 =
requeues 3532840114)
> > >  backlog 1056Kb 6675p requeues 3532840114
> > > qdisc mq 1: root
> > >  Sent 43554665866695 bytes 268309964788 pkt (dropped 0, overlimits 0 =
requeues 3537737653)
> > >  backlog 781164b 4822p requeues 3537737653
> > >
>
> Hrm. Should this have gone into net-next instead of net? Given that
> the changes causing regression are still in net-next.
> Dont think its a big deal if the merge is about to happen and i can
> manually apply it since i was going to run some tests today.
>
> cheers,
> jamal
>

Let me clarify : Before my recent work, I also had requeues but did
not care much.

Since then, I am trying to reduce the cost of TX, and latencies.

This try_bulk_dequeue_skb() was a major issue, I guess nobody caught it bef=
ore.

