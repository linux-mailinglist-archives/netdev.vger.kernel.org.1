Return-Path: <netdev+bounces-86284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8B189E4FA
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435C11F22D25
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D398158A34;
	Tue,  9 Apr 2024 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2i+0a3PA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD62158A1D
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 21:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712698227; cv=none; b=OUBmES884XCJIo92lcX8maKjfyVURT/aiHGRBHeeboYh1jzHbC2hn8tNQxc2gHkJP/hN2Xn+aMTtxB5pz4Bz83JDtIjtoQW/9uFOLi4vo/1yNw6DES7FBYatD+hQNTh5SwOz8Bpwmuz6AmKyZ0B8v/MNS1Q9XAF+nHYznA8LZJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712698227; c=relaxed/simple;
	bh=nwau/m6Z03wHvRH/w4m7NrLIDsPiqIKOIJKXCLxPvHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzIErsfhH9uuZy84AHukCthLGfLf0NZqJe0AGXyOODuI+bx571qpo4yzLQlI4gQ1NMsnMYQCuli/iVpJmWEcNFSGMrEoNn7uC9c7DyZRh9decEobgRcOrcecXmbWAjh6VdYrd90OonK1/Vcy4M36UuLeZBKKSr39J+0WCOluvz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2i+0a3PA; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e67402a3fso1661a12.0
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 14:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712698224; x=1713303024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFVxAMub5n4PvNMIllszd5bPD89juGGBs4dWISvXPqM=;
        b=2i+0a3PAuQ/dRqK2DNMeVxz0+CorEetmhGnNGD3ina9rujZvbEImj71coOulrcOSk2
         HKnInb5h8QDRwhNrvj4AUkjBAfhWF0aDJrPF2Bzq6T21Beh58qaCk8Ds+v3sBnia7YsP
         /QVNvnE+1NCUYzB0ma7STRxzvmngXp9DGbcEiGmR0DuQbRfwVboIRBlhFlIWwrN3NWbW
         sGXrnBiQ9vPFyCfuaTsTj5/Z56LGI7e28xGCWh8TiL5lWaWVwBkFxXNpF1rh/2Txc8kb
         YPq3jm3qJy0dWMloXW/zoY5Dk+ojRtEZ42AzdGVc0Z4bKj0rrQDqn1gVR/XhT1fXJdu7
         TviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712698224; x=1713303024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFVxAMub5n4PvNMIllszd5bPD89juGGBs4dWISvXPqM=;
        b=BEb1NsKChU9LX8V3n/PiTVFWw3oY8ET8CSbdFgumDyZ1sZSpqgT/hT6aP2csk0jile
         uSmkqfZTmLYsqf1+kl31DsptWZQstIVC6DQ3N6COWTh0VjDrd8MJUMRoFL7ktZ9RXcRM
         Udr/gFwya/eHcihgLVJknI4agd03bI5x00gxGc+89HNRN7SQwnq8hS7dREK3QsjsuAqr
         jgWMJoP3GTstRpz2FRhCkYeT20bFcM3J2qAnxMh0DCpUzfqoY6jaD4z4ALHRytQmBM7C
         lnhlMbOctiu74Blf08gtve97teEf1fRz5yimXzy+5peRDqYiP7RdqCBgkBiAwkffcqby
         RQhw==
X-Forwarded-Encrypted: i=1; AJvYcCWZ7RPHwjNmMTFxME16dYVam67f+z9cuAuGmsJxT8C1Gt4Tv3fBbKiKh5z6FgEOxlNm9A2Ajd7s4T8b46FRd9e0Zts40Om4
X-Gm-Message-State: AOJu0YwDPyk1mSrOjRuJ5QAe68WSl9tvaD4QSBx9FRjm7JtM4FtVy/Mk
	+7LMw1f9yoQm1KhBj3weOk75cxihaZS+XYd7DEDtC4KclYqgLHHYeiu8I7i97LEJ/jGGh9G+tHG
	OtgSr1BHYvEIysrtodsLNYguOImnA50Fi7+ni
X-Google-Smtp-Source: AGHT+IF7lbYoHPuE59xuK5JqoHTQlPalROVQSgIxzgt43SmqHwDesgBg8nVTLLM4oowFyCZ7asYiwCP5klk817CMsbU=
X-Received: by 2002:aa7:d359:0:b0:56e:ac4:e1f3 with SMTP id
 m25-20020aa7d359000000b0056e0ac4e1f3mr6619edr.7.1712698223538; Tue, 09 Apr
 2024 14:30:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409205300.1346681-1-zijianzhang@bytedance.com>
 <20240409205300.1346681-3-zijianzhang@bytedance.com> <6615b264894a0_24a51429432@willemb.c.googlers.com.notmuch>
In-Reply-To: <6615b264894a0_24a51429432@willemb.c.googlers.com.notmuch>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Apr 2024 23:30:12 +0200
Message-ID: <CANn89iLTiq-29ceiQHc2Mi4na+kRb9K-MA1hGMn=G0ek6-mfjQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] selftests: fix OOM problem in msg_zerocopy selftest
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: zijianzhang@bytedance.com, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, cong.wang@bytedance.com, xiaochun.lu@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 11:25=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> zijianzhang@ wrote:
> > From: Zijian Zhang <zijianzhang@bytedance.com>
> >
> > In selftests/net/msg_zerocopy.c, it has a while loop keeps calling send=
msg
> > on a socket, and it will recv the completion notifications when the soc=
ket
> > is not writable. Typically, it will start the receiving process after
> > around 30+ sendmsgs.
> >
> > However, because of the commit dfa2f0483360
> > ("tcp: get rid of sysctl_tcp_adv_win_scale"), the sender is always writ=
able
> > and does not get any chance to run recv notifications. The selftest alw=
ays
> > exits with OUT_OF_MEMORY because the memory used by opt_skb exceeds
> > the core.sysctl_optmem_max. We introduce "cfg_notification_limit" to
> > force sender to receive notifications after some number of sendmsgs.
>
> No need for a new option. Existing test automation will not enable
> that.
>
> I have not observed this behavior in tests (so I wonder what is
> different about the setups). But it is fine to unconditionally force
> a call to do_recv_completions every few sends.

Maybe their kernel does not have yet :

commit 4944566706b27918ca15eda913889db296792415    net: increase
optmem_max default value

???

>
> > Plus,
> > in the selftest, we need to update skb_orphan_frags_rx to be the same a=
s
> > skb_orphan_frags.
>
> To be able to test over loopback, I suppose?
>
> > In this case, for some reason, notifications do not
> > come in order now. We introduce "cfg_notification_order_check" to
> > possibly ignore the checking for order.
>
> Were you testing UDP?
>
> I don't think this is needed. I wonder what you were doing to see
> enough of these events to want to suppress the log output.

