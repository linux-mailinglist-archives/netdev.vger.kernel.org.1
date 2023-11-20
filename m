Return-Path: <netdev+bounces-49168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0077F0FEB
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C57281D48
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 10:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63A412B7D;
	Mon, 20 Nov 2023 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jknRFWt9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3997D63
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 02:09:09 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6c3363a2b93so4024768b3a.3
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 02:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700474949; x=1701079749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vI6WE+WBYN1XuPQLStil+cx+ieN1FsNdjqfwcx5L8Ng=;
        b=jknRFWt9CfVEPaa1r8Zinqg6ejbIvUKEubAzYl77Hd//7G7iX+6D83R1/sUefpfJMW
         WwM8vfUZX+ephu1wQVbwAv3hf9dQCnAG/XKvwRtOsNePhUepRO1VfZVByNWOFWORLY6l
         xi6G36p8VzlBpcRAlQQ2V2z2rzbWYstTPHZL+NxsrJvq/tbPbBLyhn3BAeWak4O6nHrx
         I11VBut+ucO8gNgZQnudn4xSHItwP/XtbcFnIO/M3YRn1MO8fr/mX9OoVytbE9JgL/j3
         cUt4NkOj2ZXKTAUsSC6/hbTcXJXCibMW7lzkY77gpp59qFwTrQ6AlwElgR7nj73ennHy
         ZyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700474949; x=1701079749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vI6WE+WBYN1XuPQLStil+cx+ieN1FsNdjqfwcx5L8Ng=;
        b=mx7tSq3bxwuibqJkr6fi3WfccO4N9kdGDlVJKwAHmdo9Ern/Hb0PRdkdgLtxPwGho0
         qiODUH1JWKDLgnBk7zNs3ZSH0XYkXmdxivtpXnDdqhW/HsTJkIKRIEQAQ8F1f3d5JjfC
         mrzeBrXFBFQkM03x/B3hYON2MU4oklX+zFrQLtA79jmKdGlbVM6XthzPjnQ7/k4fa0kp
         X0qsKfDX6W+aJ8fRJNTWLfWplUyKz7pybFn3BMVgHjSNe2CrymzuAElwJuZEDvPVeezs
         qcVPCxkifxkJ0AJ/xg+Ph3YFtLZgp8vqLKf54kQLUSNKuyErLDl4mMeQY2VfO3qYEPnX
         Gnkg==
X-Gm-Message-State: AOJu0YzZDI8i4njpCR7O3d86qfA2vMVui8AO7oOhTczmBjn32cjONd9X
	S9pIXyzzjpzaTkeLprgy/l2dTmZEq1EKJr8G
X-Google-Smtp-Source: AGHT+IFV0I6knaWy8ukT/hWBk0BRl1RkXst3IkcfIaJUkJC7FnY5VSSZ2Uenb4JtCowQOyiAc6dCnQ==
X-Received: by 2002:a05:6a00:1888:b0:6c4:dd5b:9747 with SMTP id x8-20020a056a00188800b006c4dd5b9747mr10297747pfh.17.1700474949092;
        Mon, 20 Nov 2023 02:09:09 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id f14-20020aa782ce000000b0068fcb70ccafsm5732191pfn.129.2023.11.20.02.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 02:09:08 -0800 (PST)
Date: Mon, 20 Nov 2023 18:09:03 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	patchwork-bot+netdevbpf@kernel.org, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, syzkaller@googlegroups.com
Subject: Re: [PATCH v2 net] wireguard: use DEV_STATS_INC()
Message-ID: <ZVswP0vvfCm0FlWO@Laptop-X1>
References: <20231117141733.3344158-1-edumazet@google.com>
 <170042342319.11006.13933415217196728575.git-patchwork-notify@kernel.org>
 <CAHmME9q4uSKxtEnRmcM2h2GGSBcq9Hu_9tk3EX2_EVGFXr6KnQ@mail.gmail.com>
 <CANn89iLm0SX4dF1Y29ui=SxO5ut=v66S6SvgFsD2cjU=JN1pmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iLm0SX4dF1Y29ui=SxO5ut=v66S6SvgFsD2cjU=JN1pmA@mail.gmail.com>

On Mon, Nov 20, 2023 at 08:56:02AM +0100, Eric Dumazet wrote:
> > I thought that, given my concerns, if this was to be committed, at
> > least Eric (or you?) would expand on the rationale in the context of
> > my concerns while (or before) doing so, rather than just applying this
> > without further discussion. As I mentioned, this is fine with me if
> > you feel strongly about it, but I would appreciate some expanded
> > explanation, just for my own understanding of the matter.
> >
> > Jason
> 
> Jason, I was in week end mode, so could not reply to your message.
> 
> This fix is rather obvious to me. I do not want to spend too much time on it,
> and you gave an ACK if I am not mistaken.
> 
> If you prefer not letting syzbot find other bugs in wireguard (because
> hitting this issue first),
> this is fine by me. We can ask syzbot team to not include wireguard in
> their kernels.

Some performance test data may helps.

As I don't have good and same configure test machines. I just did a rough test.

Client: RHEL9.2, CPU  Intel E5-2620, Memory 4096 MB, NIC I350
Server: 6.7.0-rc1, CPU Intel Xeon Silver 4216, 196608 MB, NIC I350

Before patch:
=== 4in4 TCP_STREAM: 901.05 Mbits/sec ===
=== 4in4 MPTCP_STREAM: 885.22 Mbits/sec ===
=== 4in4 UDP_STREAM: 919.91 Mbits/sec ===
=== 4in4 SCTP_STREAM: 903.12 Mbits/sec ===

After patch:
=== 4in4 TCP_STREAM: 901.07 Mbits/sec ===
=== 4in4 MPTCP_STREAM: 885.24 Mbits/sec ===
=== 4in4 UDP_STREAM: 919.91 Mbits/sec ===
=== 4in4 SCTP_STREAM: 903.14 Mbits/sec ===

Exchange the client/server role:

Before patch:
=== 4in4 TCP_STREAM: 901.08 Mbits/sec ===
=== 4in4 MPTCP_STREAM: 885.12 Mbits/sec ===
=== 4in4 UDP_STREAM: 919.94 Mbits/sec ===
=== 4in4 SCTP_STREAM: 903.09 Mbits/sec ===

After patch:
=== 4in4 TCP_STREAM: 901.04 Mbits/sec ===
=== 4in4 MPTCP_STREAM: 885.24 Mbits/sec ===
=== 4in4 UDP_STREAM: 919.91 Mbits/sec ===
=== 4in4 SCTP_STREAM: 903.11 Mbits/sec ===

The result looks good to me.

Thanks
Hangbin

