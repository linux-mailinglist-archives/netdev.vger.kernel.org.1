Return-Path: <netdev+bounces-282197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CFQAkpm8WlfggEAu9opvQ
	(envelope-from <netdev+bounces-282197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:00:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBAF48E347
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C646300E02E
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0312D3783CC;
	Wed, 29 Apr 2026 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pusD8QNF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C10F3783A8
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 02:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777428034; cv=pass; b=GXI4gnsZQ87TiLwp/OYnC47VHBzXqgRxRMxWrKeUBO6NgYqvtYVVwOjpdG+OMvw9/ukGNGwTRfmNFRceecEUWm78YHGoVUFsSV12fvm4KdDgTPCScbdguxSVPZKKcHe8aZyDtXI61CUiQWYuITVT1uflv/Af3j8/Tmj7INX/f/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777428034; c=relaxed/simple;
	bh=kNEuZqdlWrBRiXVn84PODF8Tu0xvqFjm67LKvdSE4IA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fP8RpOFh26o6kNo9qou64W9vyAmdaKt0OouvmaiVIUMzzr+KYeIMK+Mvjv3BN4bHp1NOr0hZ3Rh18gFsSQyIrxNUhu4x5p8UkJfhUd10r1R0x56Iuv4dWaBWuqjXj8pZyR0Bh8xW7tkJf+akE622FVT34Z1wc84q83tXhCJa93M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pusD8QNF; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50fb4a7d704so70084101cf.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 19:00:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777428032; cv=none;
        d=google.com; s=arc-20240605;
        b=GOp5Z69cGN9ShhcBPC11wZ6WxokbpqEgz0DphwnnZS93N5tfRSWUWo5XNfq5+oxSO2
         nXrx6oec24l+i08bue0WZa9naEy2pd1uDBs1U6NJ0knz1Fc+B2ZD/Ptd87555wDlBzpQ
         E3OMp45s6rye29ydtzkbTwnXmiaUD6aunSptERDJXrKpmI+yeDn5jwydZAm8SkeGHmeF
         aSvftlZiVfTi/xbYgBQqzc4hfaURI51pALk27LWsY037bFHkH9sbHRsjn/HONQjm4ydz
         fMQIIPO0kKkzoJuEcsufTF/kvENkhLMxWrc96S9orCovIWKmatuA/Xw2pLjymazGEto2
         +U3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kNEuZqdlWrBRiXVn84PODF8Tu0xvqFjm67LKvdSE4IA=;
        fh=0X6jyZ5GN9iCrGaPOtgWPivVTvY1JYPcmDd8wutCRmQ=;
        b=Un9U/RlAM2CIMMC0KEU3KJwV/QoscvtF+trG6U5pKqZOtedIv9Tfq/kxP0TVLpJuVf
         n2FaeHeuWo/2cHlXTQr2lqIJaHU2v5XWx74BWH8pml/5p42kJdhVC+VmRPbw1jOpQdcS
         WFuM9bXIUolA5uAgDyqsLQDCBHUFOCbTCXf2zLklqw5a2go0A7rnQWQBfRi+f/xp+sjo
         ZuQyrP2OQhgChkFLMV963yNKLIfhT2cFKblIeKtAUqhO3Nk5jYDpmRZiEHyxAz2x293J
         BioHsooaPr4LcIDXRSvQWAPM6wfVQ1OAHFSgFzJYO/26FpsSJEH+7uT238EHFsIcMeNj
         pMjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777428032; x=1778032832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNEuZqdlWrBRiXVn84PODF8Tu0xvqFjm67LKvdSE4IA=;
        b=pusD8QNFpJu8/15ycEhgCfOx8QuwA7RQhFWDGDS2AOGV6DIr5qNvXE4UffFEtg3H5n
         tA2wQONYDCXwgDRJhvlU1AIA9y0cbS9f7xw8CHXGJeRu53N0AnCvrElM3ivlpK2jGOWU
         5gioaMcGCs28fxM1xo4O7Z6VuL2Qgu0RL1F6KoWIwIXIF9JagBxpkptdNZ+KQvGXbbl+
         1e3yIpEA32hugRtVcDKLT4STwKWoUpJjkhGBMTnLokAamXWeyN8cFBaBIl8bxq1LUh+P
         9GkQp3g0PE/MO6yhtn4JVfea4cHMnowWIBZUjPjTV/SIMgZc50tAIcWelHe7/S9dA7N3
         63Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777428032; x=1778032832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kNEuZqdlWrBRiXVn84PODF8Tu0xvqFjm67LKvdSE4IA=;
        b=luo541kM4ACaX7gu+5GU1VPM+ztVPfahaf3+DH7azkXcOx9yyArxh5NOLv6X3B2W9o
         xlrq9cp1z9aKvRtMIzYstocITDmS7qoG8kKMZEQTxLhs3J5fWbJlp5Fztkiz/xfL0JN6
         ivEkDe2mObDXwqMsN22DyPftBu4pkApurlqY++hjD+adFVTRGPiVDP93xGla/utGlV5w
         jEwWH2IurdHeC6b871UJyRP+TNsS+1JgbWtZ9/5uE3BscU9GUJx2MlBQB7n+VQbUYGir
         RpncIbqjtR9WioNpWxOHcmtVKyiOQdJ0L4Rof57aKs9uLL16XTeP3ARfU2BB+hMuc+Ja
         hVtg==
X-Forwarded-Encrypted: i=1; AFNElJ8EO7wfnCeV7+ZqOcVHfA2YbVmF36UorjkGc/5t92KbZjUbBPlGvjcppCjvyGu++a0hPb3pwwE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5WDzfpFlILQU8tNLSLDZq2RwwKoO5QhHyTtdcG8PrWKWerhRb
	cdM5XhqAn8QATGAtSNtgYo+Abi6W2rROQwZh3aro5uh6e6yFoPbbEbSa3CFE8E6qjaF4xgbvmZg
	5R5henKQzAKVcdXYjSu2VNuSPZKUMLGlxkOELwtjp
X-Gm-Gg: AeBDiesdovK55shwCA8cqULYr4gNSRsuody7/V64YmCST+T8STAqAmcYN/wtxia4i2R
	DX+L4kAQC2yhMRsNFx5JxJcX/fB0l0PMivDaKgPSF+Qq5F2JJifpXLdojEJnRrwSard8YLxLC5P
	1hEQW4prazkbRRPX7jX7Vkrrds4aUbPeVu7YL4c0a0TWJCv2oYU/KvINA8PcgKmULl/KsPmM9Wl
	EoZlUJNvnsWY2LKBGHrPUBK0aEyvqW2q2JeNWZ5nomv8a+fUFU2JXaacUQoaH1CWCFftyC0vaXL
	zlZQE8oCtBGdAF6KGKirfebCewhEZQy3BaaT0yMQ/yiSiGacNCkE0tl4BVgQeTdTnjQkJCQrE1l
	kFv26ozsU21qR6JLeyomq
X-Received: by 2002:ac8:5912:0:b0:50f:b003:59d0 with SMTP id
 d75a77b69052e-5100e12587amr79028791cf.21.1777428031193; Tue, 28 Apr 2026
 19:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428110713.2550315-1-maoyixie.tju@gmail.com>
 <20260428110713.2550315-3-maoyixie.tju@gmail.com> <CABAhCOTmZ4hAuhtimOX1YQDGFC2fbXm5WmwT0Z8PxZU7Zq-2Fw@mail.gmail.com>
In-Reply-To: <CABAhCOTmZ4hAuhtimOX1YQDGFC2fbXm5WmwT0Z8PxZU7Zq-2Fw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Apr 2026 19:00:19 -0700
X-Gm-Features: AVHnY4LMPN3ftzG8WLk9TlJnVnhfyDIJxS4hrw6s4E3ltMk5YCYcEAIXaXlJao4
Message-ID: <CANn89iJzu1zXpx5G-3jVDS0duLB_tbm+ULzLk1ZW68fayoF9qQ@mail.gmail.com>
Subject: Re: [PATCH net 2/2] ip6_gre: Use cached t->net in ip6erspan_changelink().
To: Xiao Liang <shaw.leon@gmail.com>
Cc: Maoyi Xie <maoyixie.tju@gmail.com>, netdev@vger.kernel.org, kuniyu@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: ABBAF48E347
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282197-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,ms2.inr.ac.ru];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ntu.edu.sg:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, Apr 28, 2026 at 6:58=E2=80=AFPM Xiao Liang <shaw.leon@gmail.com> wr=
ote:
>
> On Tue, Apr 28, 2026 at 7:07=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com=
> wrote:
> >
> > From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
> >
> > After commit 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of
> > rtnl_link_ops"), ip6erspan_newlink() correctly resolves the per-netns
> > ip6gre hash via link_net. ip6erspan_changelink() was not converted in
> > that series and still uses dev_net(dev), which diverges from the
> > device's creation netns after IFLA_NET_NS_FD migration.
> >
> > This re-inserts the tunnel into the wrong per-netns hash, leaving a
> > stale entry in the original creation netns. When that netns is later
> > destroyed, ip6gre_exit_rtnl_net() walks the stale entry, producing a
> > slab-use-after-free reported by KASAN, followed by a kernel BUG at
> > net/core/dev.c (LIST_POISON1) in unregister_netdevice_many_notify().
> >
> > Reachable from an unprivileged user namespace ("unshare --user
> > --map-root-user --net"); cross-tenant scope on container hosts.
> >
> > Note: ip6gre_changelink() (the non-erspan sibling earlier in the same
> > file) already uses the cached t->net correctly. The bug is specific
> > to ip6erspan_changelink() copying the wrong shape.
> >
> > Fixes: 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of rtnl_li=
nk_ops")
>
> The changes look good to me. But why is 5e72ce3e3980 mentioned
> here? It neither introduced nor was intended to fix this bug.

Which patch added the bug then in your opinion?

