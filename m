Return-Path: <netdev+bounces-142670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FD09BFF7A
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 09:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B422820E8
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 08:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A0F18BC20;
	Thu,  7 Nov 2024 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5zII586"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9DB18755C
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730966504; cv=none; b=AINTMMipsDHrn6HjayYHXmjv96aPyuy4/MvmSPcZzAmAqIvkbPVUP+i+P6RMhydI0370vTbbCoAZTHHWSJAMO7hj43UrCiddF+yNBro8SP/9GY8PMWGh/6zMGDWf20lUNnYK05NDYEklr8UMKI91cD5AAjodTNnR5R5fkh+DOqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730966504; c=relaxed/simple;
	bh=2XQEVU5z3jrPiMCt2vtGs6DIOF4Q0FPndIsjpRMrtbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tT6OXpw6p25wTXODATwwqB6Nqh2K/zejbviRnwywvsxw8j2tkZ5KJ/5MuHFlKvzssrb4LBUkLs5RfJgQ4qh30sShzJYeYmJqy4bQJQ+i/jlqO8CChk8FmRJjS10jvVxhVVMdxZGQXq/tjYhAHF6rI6TfHP6GWQ03xE12eElB1Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5zII586; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a6bf539cabso2564595ab.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 00:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730966502; x=1731571302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ch3NMmdq9Vsp3nMcc25TsMysny6rUSxlpP8UeTlRP2Y=;
        b=H5zII586cdyBmntokUFmFBVjVJSuOvjqLdffXopzDhBzLr6uJSl/2TKu3mWIf8rs9z
         fP+fKONDf6IB9ReCIO71+tuBuFfNkSx6VCvlimuvtI4xOWJIW0S71erDQhKQDhjtUBAm
         qTpqCY/OcLGRNRtxpi4ylO4WiDZYLWUHkf7Jz3N+hyOPaYnRPmj6/nmyc2C+gxgoxOTf
         868Gzf73lQtDjYJVsrNz+i96v8GKfXZgV0tX5Bu1B1qkl/WZsRhrgGqsy9Mu2G9V0PHt
         VqNjeHwXsLn5HHggBRy1xS+F/XGu1ZajhoqT3mkkIjF4DTX2pURIkd1IScDZdJ6JMQoB
         aA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730966502; x=1731571302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ch3NMmdq9Vsp3nMcc25TsMysny6rUSxlpP8UeTlRP2Y=;
        b=cVgA6P0/aPGTsOjNxYDsZffyWR0OBkQ2nX8Fi5LlGcgn87Q90/9w1kQZddel2V5qLj
         kuMuj/Fmru9e9Wo41VGDfWLGc4qecf+4RYKk+DphOSUmruM7j/gcfyzGc6lIu+nmEJsc
         bNG3vu0ht8RCUlozYGulKGszTDsHRfRM07kAw1eU/Y+YFum+BXcrVRDPDhy/E6NRqUN3
         rIdGRX/aSLOx6TzhQNEHc9YoDh8QwcHWFrXlgeTCiwNQ1yf8IWxvNOS4llOwmpfr5a0C
         fZvmAU0YvQn7eBp+oOeIlO8X7pOMlelgLAhHn4GTMR3ZUSiFfdOQgAqa4MdcgTvVsUYv
         2xmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpeEV1ux3lBSRcGXO7L5o41RVRv34lpQtepTZsT2pliL5DApk1ADe3VUeviX8whRbsY/6lfz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeaq9viKSoDeoe1V/ZG/zQEOL/9wDOXFzIKAu9IGdbDc15oQbc
	Ya+tvr30NthfpIgbU3Ok8cD6t9RIv7pNYRjEuYG3dTkN+6tiTQN5mLLZIf3l0Bsu41K6Kzq2IKa
	G6Tlyn97Z+AFbc5rcjm7kgen1/ko=
X-Google-Smtp-Source: AGHT+IEeCQvJzxaaiOZ4ucf9WngDat1kmhe/FQq51TMmqfCV9KlXBp2vR0xmeYhcfvng7wrAyyNJXYf3jpww3KhRGyA=
X-Received: by 2002:a05:6e02:1985:b0:3a4:eaae:f9f0 with SMTP id
 e9e14a558f8ab-3a6ed0a40f4mr4226765ab.2.1730966501568; Thu, 07 Nov 2024
 00:01:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105025511.42652-1-kerneljasonxing@gmail.com> <92c1d976-7bb6-49ff-9131-edba30623f76@linux.alibaba.com>
In-Reply-To: <92c1d976-7bb6-49ff-9131-edba30623f76@linux.alibaba.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 7 Nov 2024 16:01:05 +0800
Message-ID: <CAL+tcoBZaDhBuSKHzGEqgxkzOazX3K-Vo2=mCdOy+iLp4sPAhg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: avoid RST in 3-way shakehands due to
 failure in tcp_timewait_state_process
To: Philo Lu <lulie@linux.alibaba.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 3:51=E2=80=AFPM Philo Lu <lulie@linux.alibaba.com> w=
rote:
>
> Hi Jason,
>
> On 2024/11/5 10:55, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > We found there are rare chances that some RST packets appear during
> > the shakehands because the timewait socket cannot accept the SYN and
> > doesn't return TCP_TW_SYN in tcp_timewait_state_process().
> >
> > Here is how things happen in production:
> > Time        Client(A)        Server(B)
> > 0s          SYN-->
> > ...
> > 132s                         <-- FIN
> > ...
> > 169s        FIN-->
> > 169s                         <-- ACK
> > 169s        SYN-->
> > 169s                         <-- ACK
> > 169s        RST-->
> > As above picture shows, the two flows have a start time difference
> > of 169 seconds. B starts to send FIN so it will finally enter into
> > TIMEWAIT state. Nearly at the same time A launches a new connection
> > that soon is reset by itself due to receiving a ACK.
> >
> > There are two key checks in tcp_timewait_state_process() when timewait
> > socket in B receives the SYN packet:
> > 1) after(TCP_SKB_CB(skb)->seq, rcv_nxt)
> > 2) (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval) < 0)
> >
> > Regarding the first rule, it fails as expected because in the first
> > connection the seq of SYN sent from A is 1892994276, then 169s have
> > passed, the second SYN has 239034613 (caused by overflow of s32).
> >
> > Then how about the second rule?
> > It fails again!
> > Let's take a look at how the tsval comes out:
> > __tcp_transmit_skb()
> >      -> tcp_syn_options()
> >          -> opts->tsval =3D tcp_skb_timestamp_ts(tp->tcp_usec_ts, skb) =
+ tp->tsoffset;
> > The timestamp depends on two things, one is skb->skb_mstamp_ns, the
> > other is tp->tsoffset. The latter value is fixed, so we don't need
> > to care about it. If both operations (sending FIN and then starting
> > sending SYN) from A happen in 1ms, then the tsval would be the same.
> > It can be clearly seen in the tcpdump log. Notice that the tsval is
> > with millisecond precision.
> >
> > Based on the above analysis, I decided to make a small change to
> > the check in tcp_timewait_state_process() so that the second flow
> > would not fail.
> >
>
> I wonder what a bad result the RST causes. As far as I know, the client
> will not close the connect and return. Instead, it re-sends an SYN in
> TCP_TIMEOUT_MIN(2) jiffies (implemented in
> tcp_rcv_synsent_state_process). So the second connection could still be
> established successfully, at the cost of a bit more delay. Like:
>
>   Time        Client(A)        Server(B)
>   0s          SYN-->
>   ...
>   132s                         <-- FIN
>   ...
>   169s        FIN-->
>   169s                         <-- ACK
>   169s        SYN-->
>   169s                         <-- ACK
>   169s        RST-->
> ~2jiffies    SYN-->
>                                <-- SYN,ACK

That's exactly what I meant here :) Originally I didn't expect the
application to relaunch a connection in this case.

