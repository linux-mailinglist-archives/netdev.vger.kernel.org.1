Return-Path: <netdev+bounces-201577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1175FAE9F77
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B7177A72CA
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709562E7189;
	Thu, 26 Jun 2025 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="dLm84g3i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D60928FFEE
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750946147; cv=none; b=h4i0NRnmSY5/O+ESDw5MIOXZJImWWDBH0l9L6VSS+uKlMXglKSj8k/QacM7g7NAjISVz8ACw6dtBTz5iixAO1blBuX6qSykhZwUffm3DpxYlaRjsYqPLNMxlyMimEr4s3ExeWIXK2OnsyOgIA9pZe/rvOACy0dIrsQD0eYm3pqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750946147; c=relaxed/simple;
	bh=p8dTFwOXaJolnPKKZxBvR0kA3vRQTNDo779L0Xg/S4M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9puI3fnyJc2yoVdJPmrVmUWjdbTV8dmWPra1hn6p38yn1WYq3w5gZtSOfpvFNh6fwWJ/kB/zPLYutKFqnRMzT8mlarn4DNN79rbFRvmLsNPYslJu/KHP7U2S9VzTstWBWyMHUkKEyEDerLCX20JekG3NVWiONjQsOScR71TDFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=dLm84g3i; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d21cecc11fso164866085a.3
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 06:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750946144; x=1751550944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KY6uoWqFt+gH5qFF/7TA+aeZmO9qstem/kfCaD0HTU=;
        b=dLm84g3ivfuQWL2r12ELv7h52SvlKvyzA3gAyTGQ2jJR0KGpFnnX6bWX34Cl9O3nSN
         DeCHv6Fz9Nf0dtw+Sek7glBwFOoTgbq0jqp7SF4vtJht8+ZNqaDyp62tRUkBeqQaiG8n
         3Y6y7hndWDVH83rG9FSZ98EqHliUM2CtcUupkFNB1Q2I6940CJYxAXQbARA1jBLgkJwZ
         pL+LYKVPlKcrjgg+CYu4Se4PSIUwR4rHbvGcHTKnY8lAWvglDp2yBvuXBJXm/CebYRZV
         vj49/d8tICu153jRw2v7ly/vfIZI1BrKPpzWtUWN1QbUTG4d4ETQDZzMcura2/zYrymb
         3j/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750946144; x=1751550944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KY6uoWqFt+gH5qFF/7TA+aeZmO9qstem/kfCaD0HTU=;
        b=qGN0NPBQ6yMD/JQ/y/AT8fpntCj7PZpOxDu4biF88l3PuhqI6DuBBCyGJFbCxjYDKa
         i/V7cVdRPhE/IsqxLGHH6FA3zer42BlOyRj1OxJVMCbBy/HUVfU0DJy1oneIRipO3Ufw
         UXqghcJiXIx91/dYUPBl8cahcK0xxhEybSeLq/K91WHJPtUR8NK0Iw7cVc0vbyNnhuZz
         IgkrtWoIAzNwns4G3xOR/W+zBk2tiiAS3If9XT0ILzqZTLJSec2ij4d9NoEKtfwGkWHO
         dJfn0G1AiowD8ZjbPT3H83BD/6jH0AhNz7lANV9gHoxHXuvjKuQxPhj67JPDx28SFM1A
         lS+Q==
X-Gm-Message-State: AOJu0YxqJaCUxXQ9SNJGgIDP/Ol1+v5GLo6n3mZ6NFg6+7Yd+M1Fd/5E
	Q45b2qTocGKEq311rNMVcuTcvC89afFBoymAhcIgCgjryYtdYnyULLxgEXg8d4YWYNc=
X-Gm-Gg: ASbGncvVrqolKqsaWyH5vgrCHIBPntRP3X/tB1CSng84fm5SoCGxXaf+OhPcZodcbK2
	mLMmGa0WTuB1FZmhKtxn/3z2LAREAEl9/9ShNYvekah7jSNtmvABlw3M8WoxtznJ9SFnSYGSjFi
	HF0lRHz6hCtehf8dcIaq+llfMFvhMFd04pcGrs7g+oOlUN0ojrxOSuAUFSfoSjKfOAIVOL2j90T
	72UmwtafeKkdyO3HDx91XwTwRXlklXisds5sgm6Ry+bhofEPr5tFTXsFpidaA9zlhX+RsR6cTPV
	Vg0isa81gVIF/dH436SEr+xLq3WY0tpRVqBTlGZ74bDhs9eiLu5O9b2oozPbyusJmtbKrfUJgQ6
	0xM4wiaOsv1h7TtDRX7oHm4SPskO98uLWkRGSghhhb1x1ZSt+4A==
X-Google-Smtp-Source: AGHT+IGF/axsm6TCoasMp3dJRYEbfjzn0cVauHe6eM7reaEROspM7hrYNsrohQKzR2Mdxe6cc1rxiA==
X-Received: by 2002:a05:6214:ca8:b0:6fa:ccb6:602a with SMTP id 6a1803df08f44-6fd5ef83730mr118879916d6.20.1750946144137;
        Thu, 26 Jun 2025 06:55:44 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd7718a750sm7634076d6.8.2025.06.26.06.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 06:55:44 -0700 (PDT)
Date: Thu, 26 Jun 2025 06:55:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: z30015464 <zhongxuan2@huawei.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dsahern@gmail.com>, <gaoxingwang1@huawei.com>, <yanan@huawei.com>,
 <tangce1@huawei.com>
Subject: Re: [Issue] iproute2: coredump problem with command ip link xstats
Message-ID: <20250626065519.753de723@hermes.local>
In-Reply-To: <20250619074552.1775627-1-zhongxuan2@huawei.com>
References: <20250619074552.1775627-1-zhongxuan2@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Jun 2025 15:45:52 +0800
z30015464 <zhongxuan2@huawei.com> wrote:

> Hello everyone,
>=20
> I having an issues while using iprute2 6.15.0. When I created a bond and =
intended to use 'ip link xstats' command to query extended information, a s=
tack overflow occurred, followed by a coredump. I couldn't identify the roo=
t cause through the code and need some help.
>=20
> Example:
> ifconfig eth1 up
> modprobe bonding mode=3D4 max_bonds=3D1 lacp_rate=3D1 miimon=3D100
> ip addr add 7.7.0.100/24 dev bond0
> ip link xstats type bond dev bond0
>=20
> Here is the result:
> [root@localhost /]# ip link xstats type bond
> bond0
>                     LACPDU Rx 0
>                     LACPDU Tx 0
>                     LACPDU Unknown type Rx 0
>                     LACPDU Illegal Rx 0
>                     Marker Rx 0
>                     Marker Tx 0
>                     Marker response Rx 0
>                     Marker response Tx 0
>                     Marker unknown type Rx 0
> *** stack smashing detected ***: terminated
> Aborted (core dumped)
>=20
> Here is the result with valgrind:
> [root@localhost /]# valgrind ip link xstats type bond dev bond0
> =3D=3D242893=3D=3D Memcheck, a memory error detector
> =3D=3D242893=3D=3D Copyright (C) 2002-2022, and GNU GPL'd, by Julian Sewa=
rd et al.
> =3D=3D242893=3D=3D Using Valgrind-3.22.0 and LibVEX; rerun with -h for co=
pyright info
> =3D=3D242893=3D=3D Command: ip link xstats type bond dev bond0
> =3D=3D242893=3D=3D
> bond0
>                     LACPDU Rx 0
>                     LACPDU Tx 0
>                     LACPDU Unknown type Rx 0
>                     LACPDU Illegal Rx 0
>                     Marker Rx 0
>                     Marker Tx 0
>                     Marker response Rx 0
>                     Marker response Tx 0
>                     Marker unknown type Rx 0
> *** stack smashing detected ***: terminated
> =3D=3D242893=3D=3D
> =3D=3D242893=3D=3D Process terminating with default action of signal 6 (S=
IGABRT)
> =3D=3D242893=3D=3D    at 0x498AB5C: __pthread_kill_implementation (pthrea=
d_kill.c:44)
> =3D=3D242893=3D=3D    by 0x493CF45: raise (raise.c:26)
> =3D=3D242893=3D=3D    by 0x492733B: abort (abort.c:79)
> =3D=3D242893=3D=3D    by 0x49281A8: __libc_message.cold (libc_fatal.c:152)
> =3D=3D242893=3D=3D    by 0x4A1621A: __fortify_fail (fortify_fail.c:24)
> =3D=3D242893=3D=3D    by 0x4A17435: __stack_chk_fail (stack_chk_fail.c:24)
> =3D=3D242893=3D=3D    by 0x157A81: bond_print_stats_attr (iplink_bond.c:8=
77)
> =3D=3D242893=3D=3D    by 0x157B02: bond_print_xstats (iplink_bond.c:895)
> =3D=3D242893=3D=3D    by 0x1846A9: rtnl_dump_filter_l (libnetlink.c:926)
> =3D=3D242893=3D=3D    by 0x185A01: rtnl_dump_filter_nc (libnetlink.c:969)
> =3D=3D242893=3D=3D    by 0x16B0BF: iplink_ifla_xstats (iplink_xstats.c:71)
> =3D=3D242893=3D=3D    by 0x118C3C: do_cmd (ip.c:131)
> =3D=3D242893=3D=3D
> =3D=3D242893=3D=3D HEAP SUMMARY:
> =3D=3D242893=3D=3D     in use at exit: 33,878 bytes in 4 blocks
> =3D=3D242893=3D=3D   total heap usage: 8 allocs, 4 frees, 66,755 bytes al=
located
> =3D=3D242893=3D=3D
> =3D=3D242893=3D=3D LEAK SUMMARY:
> =3D=3D242893=3D=3D    definitely lost: 0 bytes in 0 blocks
> =3D=3D242893=3D=3D    indirectly lost: 0 bytes in 0 blocks
> =3D=3D242893=3D=3D      possibly lost: 0 bytes in 0 blocks
> =3D=3D242893=3D=3D    still reachable: 33,878 bytes in 4 blocks
> =3D=3D242893=3D=3D         suppressed: 0 bytes in 0 blocks
> =3D=3D242893=3D=3D Rerun with --leak-check=3Dfull to see details of leake=
d memory
> =3D=3D242893=3D=3D
> =3D=3D242893=3D=3D For lists of detected and suppressed errors, rerun wit=
h: -s
> =3D=3D242893=3D=3D ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0=
 from 0)
> Aborted (core dumped)
>=20
> Through gdb debugging, __stack_chk_fail was triggered after the end of fu=
nction bond_print_stats_attr function.
> I first found this issue in version 6.6.0. After replacing package 6.15.0=
, the issue still persists.=20
> I also tried version 5.15.0 but there was no abnormality.
> Maybe some modifications triggered this issue, but I cannot found the cau=
se. I hope to get some helps.
>=20
> Thank you very much.
>=20
>=20
>=20

Thanks, fixed it with:

=46rom e4d10d064f5dbc64e4d2d73074c33b54d06b4514 Mon Sep 17 00:00:00 2001
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Thu, 26 Jun 2025 06:50:17 -0700
Subject: [PATCH] bond: fix stack smash in xstats

Building with stack smashing detection finds an off by one
in the bond xstats attribute parsing.

$ ip link xstats type bond dev bond0
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
bond0
                    LACPDU Rx 0
                    LACPDU Tx 0
                    LACPDU Unknown type Rx 0
                    LACPDU Illegal Rx 0
                    Marker Rx 0
                    Marker Tx 0
                    Marker response Rx 0
                    Marker response Tx 0
                    Marker unknown type Rx 0
*** stack smashing detected ***: terminated

Program received signal SIGABRT, Aborted.

Reported-by: z30015464 <zhongxuan2@huawei.com>
Fixes: 440c5075d662 ("ip: bond: add xstats support")
Cc: nikolay@cumulusnetworks.com
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 ip/iplink_bond.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
index 19af67d0..62dd907c 100644
--- a/ip/iplink_bond.c
+++ b/ip/iplink_bond.c
@@ -852,7 +852,7 @@ static void bond_print_stats_attr(struct rtattr *attr, =
int ifindex)
 	const char *ifname =3D "";
 	int rem;
=20
-	parse_rtattr(bondtb, LINK_XSTATS_TYPE_MAX+1, RTA_DATA(attr),
+	parse_rtattr(bondtb, LINK_XSTATS_TYPE_MAX, RTA_DATA(attr),
 	RTA_PAYLOAD(attr));
 	if (!bondtb[LINK_XSTATS_TYPE_BOND])
 		return;
--=20
2.47.2


