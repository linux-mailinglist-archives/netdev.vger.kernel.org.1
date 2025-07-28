Return-Path: <netdev+bounces-210428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 069E7B13421
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 07:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D5EE3A9496
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 05:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62D1219A89;
	Mon, 28 Jul 2025 05:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWx1qp3v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E47D145346;
	Mon, 28 Jul 2025 05:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753680330; cv=none; b=qzFlr84i7F2RdVYNmNYkwS5EMJ1sn5XAn5BWUdCXa/JiNgl2GKFu4wF/LdaT6mEdEwqCNCjJr6oWyORcGnAGnStsABuO1hY73uLMMLF+M9xVP0FSKdzO6VPYsGj0OJdfTXrZBJu3bfLvJ/HO/naa88Yc8GR/Zgk9fJeNMfZeV3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753680330; c=relaxed/simple;
	bh=xAA6hVtIB+bf4Uv+0L9AJ4FbHxMqP42Gq6OfbwGaPIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UA5NcYH4hw7aTvfuZpslbt4pE/JIyJjlax51BKGWl+QzNqrypLfuLCJDUfnDCezugfUmbacJZPBZOFnLtb2bFw6Za1WTkKJ0oUgt7P5iisGQd4RiLDX0un299J6Ggf4oNbx3ss5d3FUUPCUI85wb61PUfeUyytdT9LcbqYZx+xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWx1qp3v; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so647957466b.2;
        Sun, 27 Jul 2025 22:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753680327; x=1754285127; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xAA6hVtIB+bf4Uv+0L9AJ4FbHxMqP42Gq6OfbwGaPIs=;
        b=lWx1qp3vCpUqvA90oMUhCSq3j6443S2s2JKXfm64lfbshY8aPKhJ55uFTZ+ggGpFkt
         KYF4ulNovo1HsrWoWaCrIF4EsMs9XHM5hlXvYtRxtX4k23UXb33jo3jpdg7ciEhfzOC6
         NXVJoVR9+/VHjShdS3VZFbe4oOygbwH77GAcl3BsChpTL9K60VXBYTy8s89+lPCj/YHu
         r4NDxXSUpeOrX+cD4nBBfWx606FJ3R09pThnH6mZ1GfgIR8MhI3PRk0mt989uRDaqDXO
         8RiJnTwVaVt/hBdjbcHqa/Wgdo0Aay8MpqiNZlgt3K1F86ebrX7yls+bw6bdT9UkjGE0
         cPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753680327; x=1754285127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xAA6hVtIB+bf4Uv+0L9AJ4FbHxMqP42Gq6OfbwGaPIs=;
        b=eX8h/Fwjmb0bAZLLXTLDs5z5i3cP43PAXPRY0824b6Eo5MNULXeAWHSSAWlSGel+o6
         Vj/TyRUa4m/Qr6Y+DADUU1sOQZjS2GNlOLt9wdgW7yQUn3CHAZI3PB1qIVMCL8k91yZq
         dEZbOuVfYJUqvRCtcjdhfzLb+swu4xlGZfmVdTdYoaJq2/gqwF6shC04ldtlItX1KZQY
         w/junfVg2izowjotmw5a+jyfxob30d8p3WcL1Rip86bzXNZCd/2eOjB/PuPqKiOLng9Z
         5X6jUEuVRNYwUrtyb2w4C7aPo5QsS7j7mr2wqtx2EXOp6Zb/gPzulvjTl+K8Bx1zNsQw
         2EPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ+mE+wufj/77NTQwYdBVPMDfkasgl+sxGuncNLskJQLFnrXEkZYZP+05HB1YNVGWpRbddqGqg@vger.kernel.org, AJvYcCUO8ryZ8pxGAlD0/JhdqLUgerW9h2Y1eQD9crJWjePlH1w+slQ9tHwT0IKj2z5UmCp3tDVem6OFaLCY/QI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/qYgvGopPht+w2/SAMjLzs17TqBLcrq6GbmwyYLJsE7nH8DW3
	xdQoc9Pf68bvqTM8ET2VSDZMCd/BGJ3MPv7xLow7JNQ4bBKt9nJUml1E2DGJMcATIScFd+wFxzh
	bvPBl3qjQWJSL577NBDvUEGpABu9rFw==
X-Gm-Gg: ASbGncskUtcCa/ZiwxLcuZhb0IjLu52zkevv4ts9JWXJdC6HBWtIy4EcxlHk1LiP4in
	G3wC0p69KAEevECt+B3NdBPuNrDiT4UXS9ZnP1pILk5CsbddD8YEoPpHgH82jaBFND+OpBAlHiH
	IKWFzUv+Oh8s7ivo3V811VlNN7d3CI773oqcLlXqwFjH9cD83qRFksWrSY5iJysMV0vMFuz/mCK
	8SGfQqCvcjS1Cc3Lvk=
X-Google-Smtp-Source: AGHT+IGCMKefX/zChAC12Z/OhqmQYHBtBxzOUWUKWY3mCS3AEPtThfpxG8ut0Ixt1dYFyuaL6ihlrsfRaLOEUVzsXNk=
X-Received: by 2002:a17:907:7fa1:b0:ae3:5be2:d9e8 with SMTP id
 a640c23a62f3a-af61c7af16cmr1113886666b.18.1753680327292; Sun, 27 Jul 2025
 22:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68712acf.a00a0220.26a83e.0051.GAE@google.com> <20250727180921.360-1-ujwal.kundur@gmail.com>
 <e89ca1c2-abb6-4030-9c52-f64c1ca15bf6@lunn.ch>
In-Reply-To: <e89ca1c2-abb6-4030-9c52-f64c1ca15bf6@lunn.ch>
From: Ujwal Kundur <ujwal.kundur@gmail.com>
Date: Mon, 28 Jul 2025 10:55:13 +0530
X-Gm-Features: Ac12FXzuA330-pvpBxrs3N-OOIgkQ3e6G_xbUJKiPM9_Ccssgmlm5qllwTdDBS8
Message-ID: <CALkFLL+qhX94cQfFhm7JFLE5s2JtEcgZnf_kfsaaE091xyzNvw@mail.gmail.com>
Subject: Re: [RFC PATCH] net: team: switch to spinlock in team_change_rx_flags
To: Andrew Lunn <andrew@lunn.ch>
Cc: syzbot+8182574047912f805d59@syzkaller.appspotmail.com, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, jiri@resnulli.us, andrew+netdev@lunn.ch
Content-Type: text/plain; charset="UTF-8"

> Did not compile this change? I doubt you did, or you would of get warnings, maybe errors.

Ah sorry, I shouldn't have relied on static analysis -- clangd did not
complain so I did not wait for the compilation to succeed.

> And what about all the other users of team->lock?

I see the mutex is defined in `struct team` and cannot be changed as
I've proposed here. Would switching to a spinlock across the board
degrade performance?
From what I understand, the NDO for ndo_change_rx_flags doesn't seem
to disable BHs unlike ndo_set_rx_mode [1][2] so this seems to occur
only when a new unicast address is being added via dev_uc_add [3]
(which does disable BHs).
Comparing other operations that use mutex_lock / mutex_unlock, looks
like a few of them do not have RCU protection for their NDOs requiring
lock / unlock pairs in the code, but none of them disable BHs (AFAICT)
apart from the operations dealing with unicast / multicast addressing.
If this is indeed the case, perhaps we can use a dedicated spinlock
for team_change_rx_flags? Or switch back to rcu_read_lock as I believe
it's being used in team_set_rx_mode [4] for precisely this reason. To
be honest, I do not understand the intent behind this change as
mentioned in 6b1d3c5f675cc794a015138b115afff172fb4c58.

P.S: I'm still trying to get my head around the net subsystem, so
please let me know if I've misunderstood the whole thing.

[1] https://www.kernel.org/doc/html/v6.3/networking/netdevices.html
[2] https://elixir.bootlin.com/linux/v6.16-rc7/source/net/core/dev.c#L9382
[3] https://elixir.bootlin.com/linux/v6.16-rc7/source/net/core/dev_addr_lists.c#L677
[4] https://elixir.bootlin.com/linux/v6.16-rc7/source/drivers/net/team/team_core.c#L1795

Thanks,
Ujwal

