Return-Path: <netdev+bounces-168914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB52A417F9
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 09:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EABD93A41E0
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 08:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9B0241CA6;
	Mon, 24 Feb 2025 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cKF2vsMw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB096241681
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387565; cv=none; b=pcP7RiiEQJuiYygo2qUpjwfBEtTI4V33QUMpQdrf5y34vgzpTVjceGLt+DEeOrgDuCCJZgYAHNlXwg4M1CL1VDHQBZtrW8xqXYcocjHPhKbXP0G3sja3k+BJTOiCH1Rng52Vs8Wv0C8nVrBNPbZn24HKsAz86MJA4vTjMmzHudo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387565; c=relaxed/simple;
	bh=vc93JQEohEbYq4mQNpdj80fyVUiiKRsH7qvFpGNh63c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XI1oN9gqqERrIMREhuiLDKslRVGvOX7m2VXV5py93AqCqZ2tx8bCLSo7bivZ4e4Y1s38lo8hfRREorgiGU7JmDg8ulEpnoc4EJwhcHiF2Al02V99W1DTrg1P+xuwjG4SUJgtUPoJqZyQLeJxeh46Ku+orBRmP7zRdhhpPG8x+CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cKF2vsMw; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5debbced002so7540697a12.1
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 00:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740387562; x=1740992362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neJ6tLdV6Pj901cfP/S2V9InTeEfh19A+QUYQKvLMDc=;
        b=cKF2vsMwos2zGS/hazVfVZV7JoZOZJ2REDhtzwdEM5ra9P2ExcGcCCrnZtJiw2itKR
         ogV39DW6uHHYBrVRaSZCub/w+reosVFcpDl5kQbISHANb1XWWHGZW4sHBXOFdy6UwDT3
         LEMjdj+0XZ8us35o09ZC/v9C1solEUj4qG/9WCHi2aTtynvaAwkppQ532Tkx9pKplAPV
         oK4pt4M+eHsVuWiZIFhwj5sEF7slYv5Lv2Q27euGl4CaL+OgrGLixK2Ae+nYHqWM/LIz
         +X6kPj8L55D3VlhQiOizK2wxHEdb1ZQgTpWQ8XX8EtD9LL+TV3DJZW+SHER0D3IR2bmx
         OwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740387562; x=1740992362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neJ6tLdV6Pj901cfP/S2V9InTeEfh19A+QUYQKvLMDc=;
        b=rINSTVrhyQb3Qw5qLBHYrUGKsHys2AbJcH/rG6SSW/4VHJfkPxTV9sDce77X/wWCkt
         19dGeR2Gbzt9LactkRWG27mvRD1otPcBGMgzWHJl9DwIUBB1YqM5/o32TFKsJ0UujSJS
         0MWZFiijAChp03OZ5xMqLk//xgW1hvrJJ1Ro2406hq/xwLih0ci+V4Q6N6yLcUmZLROw
         IXgDnZ87qEYg2FgPw4x5+Qj624h85edKYswxTnV43bwsLPHukqNR5j6fkg9sb5KCpCJM
         N3ghQHt5FO4uGh5b/NI7SYUrMvjKdRp5RHgQ33VRt7v0WsAE0ZuB0oaifyPKjdYTKagC
         9r9w==
X-Forwarded-Encrypted: i=1; AJvYcCWV8dGykjH6XnHqkhpxgWWMzUo5VmKiKKQ+IPLWbQgsT9awhCnYx7F/vdLt7QKQPVnFOXUyE/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPg2H0OGwPbMBUucbzq73f0Yxm45Kg1CtKXZP4kLtIjjTmmtWO
	tYmTo27TzZl+Hf1XMClEYDkwYVpBLqdEYNZHtOjs1oThanZBFpTZxDozFybSVwrH+bUN7rxsQKX
	9QqkHLODMC7Ky8FPwKKzdXPYcix5tAPW8FI9o
X-Gm-Gg: ASbGncuF8CGeXEj5JHxRgN3/CVGxdT0fWCDnLJpre6QY4BU59PWsN2gKDhRnMxjAb8x
	epSv6zsbdTIiFAvNvVMZfHKvVHs8v0dNd2Pz10KvcdzFoBqVN3W5qBXQh9Nwl5PmWnZbG0pW/Vu
	aLWRA/uw==
X-Google-Smtp-Source: AGHT+IFck3W57TNLkGUizyHUeVGp2loSrvbYOXaJ9bWEut9fqRCQ2ANN+W0ws4sYSjDdVcReDTlaVfDPRVmW14Twv+o=
X-Received: by 2002:a05:6402:350a:b0:5db:7353:2b5c with SMTP id
 4fb4d7f45d1cf-5e0b6331da9mr11276859a12.11.1740387561801; Mon, 24 Feb 2025
 00:59:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222103928.12104-1-wanghai38@huawei.com> <CANn89iJfnmsZHtcc7O1oQSutgC5m_Jrhkxy3EYeOxQnjz4wwUQ@mail.gmail.com>
In-Reply-To: <CANn89iJfnmsZHtcc7O1oQSutgC5m_Jrhkxy3EYeOxQnjz4wwUQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Feb 2025 09:59:10 +0100
X-Gm-Features: AWEUYZkmbAxixMSREAlrws71v9qG-dnZ2a5F3ZIejXJhuG5-s4ijbg7iLdvupBw
Message-ID: <CANn89i+sG1eHW+EAfcy+5_XTAF5VuQuNc+vjg_m=iqZ=ZPFE5A@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: Defer ts_recent changes until req is owned
To: Wang Hai <wanghai38@huawei.com>
Cc: kerneljasonxing@gmail.com, ncardwell@google.com, kuniyu@amazon.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, zhangchangzhong@huawei.com, liujian56@huawei.com, 
	yuehaibing@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 8:36=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Sat, Feb 22, 2025 at 11:41=E2=80=AFAM Wang Hai <wanghai38@huawei.com> =
wrote:
> >
> > The same 5-tuple packet may be processed by different CPUSs, so two
> > CPUs may receive different ack packets at the same time when the
> > state is TCP_NEW_SYN_RECV.
> >
> > In that case, req->ts_recent in tcp_check_req may be changed concurrent=
ly,
> > which will probably cause the newsk's ts_recent to be incorrectly large=
.
> > So that tcp_validate_incoming will fail.
> >
> > cpu1                                    cpu2
> > tcp_check_req
> >                                         tcp_check_req
> >  req->ts_recent =3D rcv_tsval =3D t1
> >                                          req->ts_recent =3D rcv_tsval =
=3D t2
> >
> >  syn_recv_sock
> >   newsk->ts_recent =3D req->ts_recent =3D t2 // t1 < t2
> > tcp_child_process
> >  tcp_rcv_state_process
> >   tcp_validate_incoming
> >    tcp_paws_check
> >     if ((s32)(rx_opt->ts_recent - rx_opt->rcv_tsval) <=3D paws_win)
> >         // t2 - t1 > paws_win, failed
> >
> > In tcp_check_req, Defer ts_recent changes to this skb's to fix this bug=
.
>
> I think this sentence is a bit misleading.
>
> What your patch does is to no longer change req->ts_recent,
> but conditionally update tcp_sk(child)->rx_opt.ts_recent

Also please change the patch title.

The fix is about not changing req->ts_recent at all.

