Return-Path: <netdev+bounces-199357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27880ADFEF9
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 09:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B143AD256
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 07:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684EF25CC73;
	Thu, 19 Jun 2025 07:43:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAEC1624FE;
	Thu, 19 Jun 2025 07:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750319034; cv=none; b=b68GJWf5Kv4Px8X0/tEdc4tEafJDxKXEjlk8TwD9xAJgDoEAqAvrDD4DklhqTUU/aemMGPqfqXigJm07/0ahUcny2ZgGCjVolB7JpEQmMA86+QEeRWxI5XAwfW7703My7CcoPqbf8zmCuYBVxJQvCb90KfQUsVa3rJWD47riXGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750319034; c=relaxed/simple;
	bh=L7M1r3hXW846r86reJZJKNbDYYbqOkSgw23MVbxAEB0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dtl1VwgDK6ZJh6joEb2sz3XGWV6PeJuSf9QhqhlB78r39a2umr0OQHXHi8DLnPYn/E/Fn91Epmpo/EKfholDjRgeurkhsyEamyyzY5XDNkw0z0GTty0sXep4wilkpVV/KZ3tPdMsB/PV5CObOP0fFyn72DvC39y2SEjhgFpljH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bNCD10yfnz10XVT;
	Thu, 19 Jun 2025 15:39:13 +0800 (CST)
Received: from kwepemo500015.china.huawei.com (unknown [7.202.194.227])
	by mail.maildlp.com (Postfix) with ESMTPS id B239114011F;
	Thu, 19 Jun 2025 15:43:47 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemo500015.china.huawei.com
 (7.202.194.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 19 Jun
 2025 15:43:47 +0800
From: z30015464 <zhongxuan2@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stephen@networkplumber.org>, <dsahern@gmail.com>
CC: <gaoxingwang1@huawei.com>, <yanan@huawei.com>
Subject: [Issue] iproute2: coredump problem with command ip link xstats
Date: Thu, 19 Jun 2025 15:43:38 +0800
Message-ID: <20250619074338.1774229-1-zhongxuan2@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500015.china.huawei.com (7.202.194.227)

Hello everyone,=0D
=0D
I having an issues while using iprute2 6.15.0. When I created a bond and in=
tended to use 'ip link xstats' command to query extended information, a sta=
ck overflow occurred, followed by a coredump. I couldn't identify the root =
cause through the code and need some help.=0D
=0D
Example:=0D
ifconfig eth1 up=0D
modprobe bonding mode=3D4 max_bonds=3D1 lacp_rate=3D1 miimon=3D100=0D
ip addr add 7.7.0.100/24 dev bond0=0D
ip link xstats type bond dev bond0=0D
=0D
Here is the result:=0D
[root@localhost /]# ip link xstats type bond=0D
bond0=0D
                    LACPDU Rx 0=0D
                    LACPDU Tx 0=0D
                    LACPDU Unknown type Rx 0=0D
                    LACPDU Illegal Rx 0=0D
                    Marker Rx 0=0D
                    Marker Tx 0=0D
                    Marker response Rx 0=0D
                    Marker response Tx 0=0D
                    Marker unknown type Rx 0=0D
*** stack smashing detected ***: terminated=0D
Aborted (core dumped)=0D
=0D
Here is the result with valgrind:=0D
[root@localhost /]# valgrind ip link xstats type bond dev bond0=0D
=3D=3D242893=3D=3D Memcheck, a memory error detector=0D
=3D=3D242893=3D=3D Copyright (C) 2002-2022, and GNU GPL'd, by Julian Seward=
 et al.=0D
=3D=3D242893=3D=3D Using Valgrind-3.22.0 and LibVEX; rerun with -h for copy=
right info=0D
=3D=3D242893=3D=3D Command: ip link xstats type bond dev bond0=0D
=3D=3D242893=3D=3D=0D
bond0=0D
                    LACPDU Rx 0=0D
                    LACPDU Tx 0=0D
                    LACPDU Unknown type Rx 0=0D
                    LACPDU Illegal Rx 0=0D
                    Marker Rx 0=0D
                    Marker Tx 0=0D
                    Marker response Rx 0=0D
                    Marker response Tx 0=0D
                    Marker unknown type Rx 0=0D
*** stack smashing detected ***: terminated=0D
=3D=3D242893=3D=3D=0D
=3D=3D242893=3D=3D Process terminating with default action of signal 6 (SIG=
ABRT)=0D
=3D=3D242893=3D=3D    at 0x498AB5C: __pthread_kill_implementation (pthread_=
kill.c:44)=0D
=3D=3D242893=3D=3D    by 0x493CF45: raise (raise.c:26)=0D
=3D=3D242893=3D=3D    by 0x492733B: abort (abort.c:79)=0D
=3D=3D242893=3D=3D    by 0x49281A8: __libc_message.cold (libc_fatal.c:152)=
=0D
=3D=3D242893=3D=3D    by 0x4A1621A: __fortify_fail (fortify_fail.c:24)=0D
=3D=3D242893=3D=3D    by 0x4A17435: __stack_chk_fail (stack_chk_fail.c:24)=
=0D
=3D=3D242893=3D=3D    by 0x157A81: bond_print_stats_attr (iplink_bond.c:877=
)=0D
=3D=3D242893=3D=3D    by 0x157B02: bond_print_xstats (iplink_bond.c:895)=0D
=3D=3D242893=3D=3D    by 0x1846A9: rtnl_dump_filter_l (libnetlink.c:926)=0D
=3D=3D242893=3D=3D    by 0x185A01: rtnl_dump_filter_nc (libnetlink.c:969)=0D
=3D=3D242893=3D=3D    by 0x16B0BF: iplink_ifla_xstats (iplink_xstats.c:71)=
=0D
=3D=3D242893=3D=3D    by 0x118C3C: do_cmd (ip.c:131)=0D
=3D=3D242893=3D=3D=0D
=3D=3D242893=3D=3D HEAP SUMMARY:=0D
=3D=3D242893=3D=3D     in use at exit: 33,878 bytes in 4 blocks=0D
=3D=3D242893=3D=3D   total heap usage: 8 allocs, 4 frees, 66,755 bytes allo=
cated=0D
=3D=3D242893=3D=3D=0D
=3D=3D242893=3D=3D LEAK SUMMARY:=0D
=3D=3D242893=3D=3D    definitely lost: 0 bytes in 0 blocks=0D
=3D=3D242893=3D=3D    indirectly lost: 0 bytes in 0 blocks=0D
=3D=3D242893=3D=3D      possibly lost: 0 bytes in 0 blocks=0D
=3D=3D242893=3D=3D    still reachable: 33,878 bytes in 4 blocks=0D
=3D=3D242893=3D=3D         suppressed: 0 bytes in 0 blocks=0D
=3D=3D242893=3D=3D Rerun with --leak-check=3Dfull to see details of leaked =
memory=0D
=3D=3D242893=3D=3D=0D
=3D=3D242893=3D=3D For lists of detected and suppressed errors, rerun with:=
 -s=0D
=3D=3D242893=3D=3D ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 f=
rom 0)=0D
Aborted (core dumped)=0D
=0D
Through gdb debugging, __stack_chk_fail was triggered after the end of func=
tion bond_print_stats_attr function.=0D
I first found this issue in version 6.6.0. After replacing package 6.15.0, =
the issue still persists. =0D
I also tried version 5.15.0 but there was no abnormality.=0D
Maybe some modifications triggered this issue, but I cannot found the cause=
. I hope to get some helps.=0D
=0D
Thank you very much.=0D
=0D
=0D
=0D

