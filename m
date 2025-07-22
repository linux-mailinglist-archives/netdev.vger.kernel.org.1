Return-Path: <netdev+bounces-209080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDEBB0E37C
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 20:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795755662B1
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 18:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9164028000F;
	Tue, 22 Jul 2025 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gAqKvuWH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7F626A1BB
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 18:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208873; cv=none; b=nDzAobJYsoyWWdBPt7JHjqQZSUk3PW+Lp8VuZqGr3pkMWy0exVkpvoyfT072FLK1e4Nvkg6rRVl8/e8FdTwY1PiX7GeyIE0S+zzMHy/tDkXyvAuDLtFvUx8NNhB/Zis8kkHyZ31sC+rEtiQ9t9KK9s61VlQK2+CueAxmSGJGasI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208873; c=relaxed/simple;
	bh=kdF5tg8ENJcaojyO3wuhelQPZ6QwZOTEotDF62Wu3Jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rykbAMyAD/Xb2EwJWIteKhmni989D8W/M51v9kF6iMx+cA+36BM7i8F5AGmq9ZHA8L96s+SKB442x/eBLNxs8yTrEMxar/K3u4/6dEVb0FOkqJXtElqcnWHlcJ2zeAd2YnD+/PPYlTZLwYpyDQ7CGgKYVaEzRFQp7DvHcFf9fIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gAqKvuWH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2350b1b9129so40534105ad.0
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 11:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753208871; x=1753813671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJ06jcp3N8mk84kkZkPxLydB4nlpZWRtwPoY10l8wjU=;
        b=gAqKvuWHZ1xibrF1h5kTHZA67Gep9xDkxFZid1e07MUlPv0Yk2F5FPqXCQEZAVoxbg
         +ty8tRQGMNmQnfG0MTPVmJCafTqHNfEfsKDjW13aE/4TJm5IFrcA1qRbCtf1Hd0uiEIn
         h35oN7oSA74y4BTiGfO57AK9ew51Zp5xufbJ7lSO6T0neP1zZfLkLq8dkajOtq3DzkVh
         Yg1ruPccsggBXBIOayiwXe203Xm3GF0arXbunDnkI5o2G/ejTzSHCPDrnO4FdGX2B0RS
         +1cryPgbQp86tIpNKB/q0XZQzGLnkq7bAzVS5RS3VP12LaJ4tpZ8hb6WzfYklhYJegtR
         cGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753208871; x=1753813671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJ06jcp3N8mk84kkZkPxLydB4nlpZWRtwPoY10l8wjU=;
        b=bpKrozcN/91fbb6JrZF/xODKOx4CMEpF8vUXWIcBwgJW8WcpUImGwylkdpSjr/NBjh
         JQp6AG1Ox99ls/XZB6fe+WvaxfaKAtLoHvOkZeWnopiAcbMND3cqywTvjIbnk8KFT1jT
         OjtUfflgyRQX0lhLZZ4Nx8k1Z0kkog5WMZI9hhVHjvr4e/QB2JzRhk7Gl8l3qhcu/zo0
         NlbProOdyVZF/bEN4KVwmYztcvbjIViUm1XCGRHA6IXIPsZLhKjb/QdxksseciobfTts
         kkijbpz5F/RJ6pcrfCyOq3Tbw5IYNsfGZ+QayYGTOeoQ+v/Fe2kxxRWGapuiIfcuzSi9
         E3jQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9+gjWS9yranjOygobk9Xvd+YMWSbZq2PNeLn+vK4nJbb/9bUk2DqJGKtTi6cazVIJHdMc51A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLLjEkhbZ3sGEs4JmvZLP8LZhgRwrLeYByWOqLBKCEYC/XnbK7
	fqvy/UukMWzhGx07BZTSnRnBZ9t2APJ7EQ38uP9ZBKs0UNXTQKn2qYCY+AvU/jgs14gMPoVGTnS
	Ptv1cLA/UuOpCIR7KWGVF+F6ZdQ/+N//z8+WDIkgw
X-Gm-Gg: ASbGnctRPo6N33b3tWW65uvJHfZ9e3pRwegV2wNTzVsFmSHeS4nPhqVdTEY8FC+QAt1
	+AKF0et+ErncPoNH1QEecdD9V+pbTaA254uJqyOojLupFpspQZVEySedkVYjzcA8Cs0U0NyFjg+
	zZqESM9FwkBonTBAr2ZL5rLlEKMObImL1PAtgAtb+jzxNOhei07mFdZsMXWO+2pWar5r1W5UE0R
	UvmDe9B6Ck/RT/BRUonglhVyiI8AK/PbfA1dg==
X-Google-Smtp-Source: AGHT+IEsDSi8OkW3pGhx0kurDkEYKeTjeHF2pizFwIotQyNcJvMlToKfbMqC1EaLyBr5Mr/rFszOK4D2GukeMpu05bg=
X-Received: by 2002:a17:902:ebcb:b0:235:7c6:ebd2 with SMTP id
 d9443c01a7336-23e25730056mr376366275ad.31.1753208871268; Tue, 22 Jul 2025
 11:27:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722071146.48616-1-daniel.sedlak@cdn77.com>
 <ni4axiks6hvap3ixl6i23q7grjbki3akeea2xxzhdlkmrj5hpb@qt3vtmiayvpz> <telhuoj5bj5eskhicysxkblc4vr6qlcq3vx7pgi6p34g4zfwxw@6vm2r2hg3my4>
In-Reply-To: <telhuoj5bj5eskhicysxkblc4vr6qlcq3vx7pgi6p34g4zfwxw@6vm2r2hg3my4>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 22 Jul 2025 11:27:39 -0700
X-Gm-Features: Ac12FXxLpxDEFMJ1OteDYmd2L-tyFGpDS0pkCtWi7bSCC4GD2tBgGIdi0vnLq7g
Message-ID: <CAAVpQUBwS3DFs9BENNNgkKFcMtc7tjZBA0PZ-EZ0WY+dCw8hrA@mail.gmail.com>
Subject: Re: [PATCH v3] memcg: expose socket memory pressure in a cgroup
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Daniel Sedlak <daniel.sedlak@cdn77.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	cgroups@vger.kernel.org, Matyas Hurtik <matyas.hurtik@cdn77.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 10:50=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Tue, Jul 22, 2025 at 10:57:31AM +0200, Michal Koutn=C3=BD wrote:
> > Hello Daniel.
> >
> > On Tue, Jul 22, 2025 at 09:11:46AM +0200, Daniel Sedlak <daniel.sedlak@=
cdn77.com> wrote:
> > >   /sys/fs/cgroup/**/<cgroup name>/memory.net.socket_pressure
> > >
> > > The output value is an integer matching the internal semantics of the
> > > struct mem_cgroup for socket_pressure. It is a periodic re-arm clock,
> > > representing the end of the said socket memory pressure, and once the
> > > clock is re-armed it is set to jiffies + HZ.
> >
> > I don't find it ideal to expose this value in its raw form that is
> > rather an implementation detail.
> >
> > IIUC, the information is possibly valid only during one jiffy interval.
> > How would be the userspace consuming this?
> >
> > I'd consider exposing this as a cummulative counter in memory.stat for
> > simplicity (or possibly cummulative time spent in the pressure
> > condition).
> >
> > Shakeel, how useful is this vmpressure per-cgroup tracking nowadays? I
> > thought it's kind of legacy.
>
>
> Yes vmpressure is legacy and we should not expose raw underlying number
> to the userspace. How about just 0 or 1 and use
> mem_cgroup_under_socket_pressure() underlying? In future if we change
> the underlying implementation, the output of this interface should be
> consistent.

But this is available only for 1 second, and it will not be useful
except for live debugging ?

