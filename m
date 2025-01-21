Return-Path: <netdev+bounces-159923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF40FA175F5
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 03:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081A216A928
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 02:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619EC1547C9;
	Tue, 21 Jan 2025 02:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u8nO/kyE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C5E153BE8
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 02:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737426604; cv=none; b=HSAmXI6BLblW06bOqKfEKr7gCLYIblLhEGBeJIKi+ShOzi5XgmF4HSHRkzEJhfaH/Ucs+SBKTgOBqXSM2XjlfhnzSLZbyVI1RkiE30RfFZ1zkdCGocNMd1Rsrq9/VpSHPyp4HPS1rcAbrxGkwK1sNYo0Zk0VqEvxu+WPkO48568=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737426604; c=relaxed/simple;
	bh=kkfCkGHH/5pcAL0xqI/wvdSZvH51iCZ4dgaEReAVEIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AI3N/YdrtP+CnNb5EWQ0E0GOH51/n3V5BbqxqjhtudTPeVGPNjrJsE6ezeHPU4Zjm7TodSPQrDMxdkQUzJE0HGUWSgol+tv3EzYdFOn3xXUDnAoqC0lRgATqaIYtVUJzXiEadpIuJ7jPlc8JEkjPT1HqP7V4GzQv3565GYIgm3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u8nO/kyE; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a818cd5dcbso45ab.0
        for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 18:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737426602; x=1738031402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPH2l5qf1qTVXhW3y6X6yrEqTd9SkGMkHh8IfEKrlFk=;
        b=u8nO/kyE5GH6ee2wsFEwh1foOoz4DgjTuauzcqHWH1ZzPUFFMF/x1upQGnSRtuXD+O
         Nl+kU47W5nGKMLg11zujBUY7CVn+Js7xVFRNKI8+h+xLoXFzrs/HH30sgVDtacKqdEay
         A+Y1N+7kqVEFpaNs9ZylkYpsJq4YsIj4Ddl/3/RTi0g/FQbrOYDI/wzDY4U1X/q6IA5A
         VBO3tQwrpO3UXrDbLN2zu/nR8yYYbP7b+vkn5DkY8ImVHFurX6HVnTuhhcRTfQZfEIBG
         /ooaYOI0Iwfe5dbtB7xX+wkJkj63D2FeyHwgNeUi7y0ayZlLB/JCmnunBQ+2pltGc3IG
         zGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737426602; x=1738031402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPH2l5qf1qTVXhW3y6X6yrEqTd9SkGMkHh8IfEKrlFk=;
        b=d9BH1aDjE6a6rKMvRNpeb06EmLvdqIgiDPsOIjGqyo3YhekNZoE7JAULSBkARsaoA2
         Vonecisg9ZJuKqYhSMRzRBr4V5ayRdnzpiaq6JKFOAlr4R1oRsGR6XAkpdaizkeIz4M2
         OVztiSVfRLN8bcHTchP3/5FUSHC/uUBnb3dhqsTNVnfMsZpsrgeuj+fZ2dTQaWo42nlW
         zaEJtYJfd+T4AFGn5S0Py7TAiKnSbPuIoFOj3al+vbb0jcPF2PqHcpYG+Df9fwEwT2Ph
         fRW0no3QZe1QlEIbwZbEfH40hMWtf5e7rse2h9QrMm+FB5hYqfu6DmyAJjRn0NtX6qes
         VzSw==
X-Forwarded-Encrypted: i=1; AJvYcCWN31ZowMQDGHYpJS4dcqyxs+lS/Bn34cx/OoHAEAP57MFTakxCglI5r1S2yA7qdUTkrJDBUuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtf4ibIOsZVoyYHGhqGW/3sZCfnJ/Q9zEBqs7z3nSMnntGDAav
	EC8KQ4zdZqVGdvZg8q2A3zxyDZcbxsrHBqppJzEZD41cv0jaRESBMaJtbm4Arf2vCaUARgdamIa
	+/LdR6Xcu1NNmLm5zXv4GPPVwbur5vQcQ07Bd
X-Gm-Gg: ASbGncvE2NPeqenXxPJ59Y/ql/jHaLQO3q5NmZdaNC8TZkkkILZQ/eORZT7ZteyugcY
	GRNcsyorGWud6mg6mgYTeLcxmEdXSTjNcAz+y13u44CVISSaAPMASMb/NTh719FFCuAyvcB4o6K
	cqo/2Pcw==
X-Google-Smtp-Source: AGHT+IFlz4TxB3vciHD96WStNcWKfDv2nt6pDTX2HSfNXumM8/MVKhR4YG5/U51YA28bK2CS8jm9EvWOsee1FBpIG28=
X-Received: by 2002:a05:6e02:1111:b0:3ce:51bd:3b05 with SMTP id
 e9e14a558f8ab-3cfa9443651mr11835ab.2.1737426600885; Mon, 20 Jan 2025 18:30:00
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117081600.150863-1-yuyanghuang@google.com> <20250120164621.287af2eb@kernel.org>
In-Reply-To: <20250120164621.287af2eb@kernel.org>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Tue, 21 Jan 2025 11:29:24 +0900
X-Gm-Features: AWEUYZkgAGWY6e-kgWc5FZORob9sGJ4tEP4o23gzR672JEL0GNHYtT3vCoErJAY
Message-ID: <CADXeF1F5R+p7ohvMRDBsRSxxqqAO-zXwctSz5KvMJEPbQLy90Q@mail.gmail.com>
Subject: Re: [PATCH net-next, v6 1/2] netlink: support dumping IPv4 multicast addresses
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Hangbin Liu <liuhangbin@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	linux-kselftest@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback.

>IIUC Paolo's suggestion was to create a new header file under net/ipv4,
>if you consider addrconf.h unsuitable. There is no need to expose this
>argument struct in kernel-wide headers.

Currently the structure is like follows:

IPv4:  `struct inet_fill_args` in igmp.h and use it in igmp.c/devinet.c
IPv6: `struct inet6_fill_args` in addrconf.h and use it in mld.c/addrconf.c

We could move `struct inet_fill_args` to a separate header file, but
this would cause the IPv4 and IPv6 code to diverge. Therefore, we may
need to modify the IPv6 header structure slightly as well.

I propose moving `struct inet_fill_args` to `igmp_internal.h` and, in
a separate patch, moving struct inet6_fill_args to
addrconf_internal.h.

Please let me know if you have any other suggestions.

Thanks,

Yuyang



On Tue, Jan 21, 2025 at 9:46=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 17 Jan 2025 17:15:58 +0900 Yuyang Huang wrote:
> >  include/linux/igmp.h | 12 +++++++
> >  net/ipv4/devinet.c   | 76 ++++++++++++++++++++++++++++++++++++--------
> >  net/ipv4/igmp.c      | 13 +++++---
>
> IIUC Paolo's suggestion was to create a new header file under net/ipv4,
> if you consider addrconf.h unsuitable. There is no need to expose this
> argument struct in kernel-wide headers.

