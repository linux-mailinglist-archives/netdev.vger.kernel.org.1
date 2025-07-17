Return-Path: <netdev+bounces-207990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77678B0932B
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0DC5172155
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4840C298CCD;
	Thu, 17 Jul 2025 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oc0wDoxk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FA62904
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773208; cv=none; b=QcZHiuixG6UK12af07jNAqQRekWzfdzcP1C7Pc0vuLmyrSW3Kqfzq6dHmc9OeMkFc51/XYa/P0tsZCEAhVIMw7xq7xMLJoNrotlaKnPHok1UyRF5msy3G24TCIvJkhSUqo+K6VuBqeV1DTxp6isbZaOHDO3Vf+OLrj/kUe+dRLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773208; c=relaxed/simple;
	bh=qj6op9ooO9avhscROyh802YN1mGnSBC5p9SY+9e2RsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JXXdGGLaq7KEBGaEKkVcI0ugG+/G97pe5KEJzWHFUkVVSb3vhVbG+uQldujIsWpSLEPItdeCJcpIi4NnSTaXGnksMnpgUEMNRrMk9zP1IDXukQYZprb8V+Trcv1ibGCsZQZTyHQP0sRQmROz6+yczovRFa+rGLTxurDaKf0ySJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oc0wDoxk; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b3bad2f99f5so1091764a12.1
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 10:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752773205; x=1753378005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vk0vPQ5JFT6HSzwpfrKNRusIzyrzK+g9arxPSMLBTvk=;
        b=oc0wDoxkWHFQDBCOolsrg/jMCFfuqMPGyorTe8wl+y34x/sV3kUdiNaGJe6eX6KocV
         XjsEac5FrCMinIKVYt+50Ma19L0H7GjIc2k9X59XddVe5Y2oNn31bEie5bj93vbVuXH3
         Stm1AwtaoeNUTdB06+ddQCa8Wc8M8HK8MBDLg/FxESI4yXZsZ9NVp0gFQegK2sjli2Ja
         nSiqfMYi9+WxdwprITzk/IKY6NipG5h1LFjerNJNYgITYv5h3Zb6TOt0Y3s9GqKhCz79
         t07xKaDnRkImJo5tDw7Pln025cSKRrc+Ws9mLJqpx28ik16MsU5fQvQF2k67VMD9kgBz
         wJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752773205; x=1753378005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vk0vPQ5JFT6HSzwpfrKNRusIzyrzK+g9arxPSMLBTvk=;
        b=ZaaQuQIFVPV40xhBY5S/lIPw3c9vw8wopkNXjY869/W6MNf9DYpIpDb6H8lnCn8HbX
         eYyDGd72EGay6YC3lQWVfZF7qNoVnvt5KC8WMsg05ZYswCIJAuLcOKvmQdfqbFRBzZzL
         YRXtWvcht0jrLjUO+LJ+9+Z6JEBuDhne7SC/bwy+XjzFvPN63xcd0xVhjR+Ya/ijAw1i
         Lz6DxS+b2QpVr/xAkk9iP1rxizvUIquzmLtiij/0edpYGGz8TtNzS0zDqwiUb2JaFcKs
         0FYLHxtNRM1Ta3t+7lk6+l+z3M+ryCtMIv2R0krwJWDxrdVfNjLLpOG/wyFBGXbaPKyu
         oy2A==
X-Forwarded-Encrypted: i=1; AJvYcCWN+fqLhrNDOZZWPEt5NNgVUlUXLAK8XmcRglj+zVQZu37Jo+ZpIu9SEDkaXsAcZRcOVtXlWNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQSYnNiFqYfhgMAkN+oyTg9c3BJHQRMUTdELOGXh0+kqT8ruTJ
	ZfsZYTAsJXKAG09ZnKFyRE/hLFWHlQJOiDjkHSOjsCrLIMQ7djrcpFpiRKqfsGFnGHR5uEmhGBv
	QV4dGHcXvlmiiqzYrn8NcQnqnVpRa0rj7n61nllAz
X-Gm-Gg: ASbGncv+tqR/eVRbslB6Qfku7ftYLapbM6CAtOdgLPcsh5r8mcqEoN2/S/nYHeYkkQn
	RqN4N/SIrHk/WAdVyvda0XM14uOFfzQBtUVqE6hmJrLCwFFkIZ0S3kFOxR/ILB0sjkmbFT7noo2
	2CDKAhYthzEBWxxei1dfbI7AzcqWUQjJ0llKUh3PYZnwj3/DT5/UNRD/YZR/urMW3u2C6siIgcj
	WHCxH4C4SVHn2VMCMBkmPcgB3sOMU1PBcz8g7z7
X-Google-Smtp-Source: AGHT+IEDE2E9koWe5tiexoDmWFLniUP7HmR4+lH9wASTsjepELYfnFxnLqTShLNvSMB8kFVLTopS4ykrCW26H+bj/GQ=
X-Received: by 2002:a17:90b:5150:b0:311:1617:5bc4 with SMTP id
 98e67ed59e1d1-31cc04409aamr708670a91.12.1752773205402; Thu, 17 Jul 2025
 10:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714143613.42184-1-daniel.sedlak@cdn77.com>
 <20250714143613.42184-2-daniel.sedlak@cdn77.com> <vlybtuctmjmsfkh4x455q4iokcme4zbowvolvti2ftmcysechr@ydj4uss6vkm2>
 <CAAVpQUBNoRgciFXVtqS2rxjCeD44JHOuDNcuN0J__guY33pfjw@mail.gmail.com> <924f57a8-deaa-4f7d-93ee-4030e2445a01@cdn77.com>
In-Reply-To: <924f57a8-deaa-4f7d-93ee-4030e2445a01@cdn77.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 17 Jul 2025 10:26:33 -0700
X-Gm-Features: Ac12FXxCQNMOK3G4zFCbiVejlOaKSkNVx_IcfAJdZCe4N5jxKb0BeR8m5SOxEPc
Message-ID: <CAAVpQUDSnDLxjL2O0xbOJTuV9CSNTE4XMZQ1Z5wxNteeyiCMwg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/2] tcp: account for memory pressure signaled
 by cgroup
To: Daniel Sedlak <daniel.sedlak@cdn77.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 8:31=E2=80=AFAM Daniel Sedlak <daniel.sedlak@cdn77.=
com> wrote:
>
> On 7/16/25 8:07 PM, Kuniyuki Iwashima wrote:
> >> Incrementing it here will give a very different semantic to this stat
> >> compared to LINUX_MIB_TCPMEMORYPRESSURES. Here the increments mean the
> >> number of times the kernel check if a given socket is under memcg
> >> pressure for a net namespace. Is that what we want?
> >
> > I'm trying to decouple sk_memcg from the global tcp_memory_allocated
> > as you and Wei planned before, and the two accounting already have the
> > different semantics from day1 and will keep that, so a new stat having =
a
> > different semantics would be fine.
> >
> > But I think per-memcg stat like memory.stat.XXX would be a good fit
> > rather than pre-netns because one netns could be shared by multiple
> > cgroups and multiple sockets in the same cgroup could be spread across
> > multiple netns.
>
> I can move the counter to memory.stat.XXX in favor of this patch

Please do so.  Per-netns stats could be confusing in some setup above.

Thanks!

