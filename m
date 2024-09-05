Return-Path: <netdev+bounces-125544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBEA96DA43
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 15:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8621F21CFF
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 13:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6310919D06B;
	Thu,  5 Sep 2024 13:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F6zS3lSq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966B3156250
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542805; cv=none; b=darjh3r5fPJpockqbYgE4hVdud0dOKpnx99W/TUEFbyleY2KaNQhEv03WW+jvPztW+vUt4EUa1Mym2ICqg3p/SrxvYDab6wE6sWj3mE1tfF1GloXoOdeRNX8nWeDYpF3H6kWopxv06bBuzuLyZ8w2dLgkrVVfWKBnPPzQpfo9Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542805; c=relaxed/simple;
	bh=HOFxJPN//V4aKN4EniNWh8C+fLXHnFXFifMxEJp7TXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWAfyioZlXFQW2n3Sxy3x2ftl6+yc1Scs1KQEUyuHz85Iajy7ei3i5DcDGEaQYbypeaANerwI+BcKVIO9X5YIKDukFFYb1I7HdeuA/jTRsbfd1i+4T7EJLYp+TvOqSA6KoBwIRn640527bg3lpIqzRlSJAjI5fCMmWkQroqsopU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F6zS3lSq; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53438aa64a4so821082e87.3
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 06:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725542802; x=1726147602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZrMGobYahdKqJPly9ZwcV8Cah5wu0RUAUNPlIxQhRs=;
        b=F6zS3lSqDj4++SkTmwrfz8MAuFyofo0iPh1z49G4NhiVBTOpUjh6s/ND9RDGq1KU+9
         bKStKGOsK6E+pw5mXRJjJFJvKolkajbtYcYXuu1tP2znguR70LEPvQ94OQOfhevrW8vA
         7BAqj4dCxj6Z8zixf+TsfRlZMRrq4PaOnGzaCX1hDe6AZGj0ibUnik3LZmW+Nc17so5F
         GqYYMoSwsJMnJFZb6d6C7mKvnqER73V9Ce10Tg5P7NVE/O+B9ZhcAMPnoL4aGQo0OwcO
         05T0ov2LCX8bNXUgSz2JgqEaWkcvNFO2QP/RC0BWbpihdtqN9zquR6LNf80DapWDoPQ/
         aKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725542802; x=1726147602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZrMGobYahdKqJPly9ZwcV8Cah5wu0RUAUNPlIxQhRs=;
        b=j4HAKe2Pa8nYa9sYk2BG/V/AFx6jqvXD0u1c3QMnq07ED0RrpwJu51HzIZgL5h8Mq/
         btkwer9f3q1Up8Dgz0fBNpMf7hOCdj68kuwzNxbTwkNzF55MpVrgSInSpZLpOS6jc/HI
         vFrxSts40BiFElClahICZAsWYlkEF4s3/HQ4cG5p5x9WusdSK2HARom7dKPYhQu3u9Ut
         xrBkLp9WBnBEumPGWfzjFK+uaiIggQtosI0+SpVJ3fWmvLzkcusptbsvprONxZCl9MPH
         kj/kBF7/x6RN16mBWITAWPYgcf6Pb3AxpKiHccscrqXZRTj4QyasWV8e9+9WOKD8D4BN
         HcUg==
X-Forwarded-Encrypted: i=1; AJvYcCWyH5eVHRi17qFEPWVNxsZTsQSJShW+WXFRU0W9ICh1c/qLiRpxnEvLoOUvYq9xU+EXCDr691g=@vger.kernel.org
X-Gm-Message-State: AOJu0YypWhen4CsbMSm5x6W8Rc0R8ENf7U0K3+XHoSHNyULWYSaDaVPz
	yc2ZKaxMJyk6Sdj+wT9EmKAO61KW5cxo6C2Y/zv6evPsaRx0hDTT4KuiapsmpCRML9XOpe1qmwm
	oRajGearbxbdqsIUTM3eiReLTSOkblxwF4HraD/ndYhOAA6/Z/5TW
X-Google-Smtp-Source: AGHT+IHADuINUGyFvC3ILfqFtMgtakgjUsefzrAXGDuLAR7pXZRr8A58pSqQ7Nvq6u/ilKmNjyQ88bD2d1Hf5s/c3wM=
X-Received: by 2002:a05:6512:4022:b0:536:55f7:75d6 with SMTP id
 2adb3069b0e04-53655f777d0mr44670e87.37.1725542800868; Thu, 05 Sep 2024
 06:26:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904133725.1073963-1-edumazet@google.com> <20240905121701.mSxilT-9@linutronix.de>
 <CANn89i+K8SSmsnzVQB8D_cKNk1p_WLwxipUjGT0C6YU+G+5mbw@mail.gmail.com> <20240905131831.LI9rTYTd@linutronix.de>
In-Reply-To: <20240905131831.LI9rTYTd@linutronix.de>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 5 Sep 2024 15:26:27 +0200
Message-ID: <CANn89iLQxH0H_cPcZnxO9ni73ncmbbhx3knzRB2swTsx=J-Fmg@mail.gmail.com>
Subject: Re: [PATCH net] net: hsr: remove seqnr_lock
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 3:18=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-09-05 14:26:30 [+0200], Eric Dumazet wrote:
> > On Thu, Sep 5, 2024 at 2:17=E2=80=AFPM Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > >
> > > On 2024-09-04 13:37:25 [+0000], Eric Dumazet wrote:
> > > > syzbot found a new splat [1].
> > > >
> > > > Instead of adding yet another spin_lock_bh(&hsr->seqnr_lock) /
> > > > spin_unlock_bh(&hsr->seqnr_lock) pair, remove seqnr_lock
> > > > and use atomic_t for hsr->sequence_nr and hsr->sup_sequence_nr.
> > > >
> > > > This also avoid a race in hsr_fill_info().
> > >
> > > You obtain to sequence nr without locking so two CPUs could submit sk=
bs
> > > at the same time. Wouldn't this allow the race I described in commit
> > >    06afd2c31d338 ("hsr: Synchronize sending frames to have always inc=
remented outgoing seq nr.")
> > >
> > > to happen again? Then one skb would be dropped while sending because =
it
> > > has lower sequence nr but in fact it was not yet sent.
> > >
> >
> > A network protocol unable to cope with reorders can not live really.
> >
> > If this is an issue, this should be fixed at the receiving side.
>
> The standard/ network protocol just says there has to be seq nr to avoid
> processing a packet multiple times. The Linux implementation increments
> the counter and assumes everything lower than the current counter has
> already been seen. Therefore the sequence lock is held during the entire
> sending process.
> This is not a protocol but implementation issue ;)

These packets are sent on a physical network, reorders are inevitable.

> I am aware of a FPGA implementation of HSR which tracks the last 20
> sequence numbers instead. This would help because it would allow
> reorders to happen.
>
> Looking at it, the code chain never held the lock while I was playing
> with it and I did not see this. So this might be just a consequence of
> using gro here. I don't remember disabling it so it must have been of by
> default or syzbot found a way to enable it (or has better hardware).
>
> Would it make sense to disable this for HSR interfaces?

This has nothing to do with GRO.

Look at this alternative patch, perhaps you will see the problem ?

diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index af6cf64a00e081c777db5f7786e8a27ea6f62e14..3971dbc0644ab8d32c04c262dbb=
a7b1c950ebea9
100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -67,7 +67,9 @@ static rx_handler_result_t hsr_handle_frame(struct
sk_buff **pskb)
                skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
        skb_reset_mac_len(skb);

+       spin_lock_bh(&hsr->seqnr_lock);
        hsr_forward_skb(skb, port);
+       spin_unlock_bh(&hsr->seqnr_lock);

 finish_consume:
        return RX_HANDLER_CONSUMED;


I am surprised we even have a discussion considering HSR has Orphan
status in MAINTAINERS...

I do not know how to test HSR, I am not sure the alternative patch is corre=
ct.

Removing the seqnr_lock seems the safest to me.

