Return-Path: <netdev+bounces-99312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F038D4676
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 09:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63CDA1F21223
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 07:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261A97406F;
	Thu, 30 May 2024 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="O9SdtjXR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048B020322
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 07:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717055589; cv=none; b=USPKEOr9OPCDsgWcaYOrV1p1jSFGYVoKUz1N96/iBHbfSXd/3+Ya3zVPW0ioTxmY/kO9/ArOd/+aYuuW4RXdkZ3WlUIxoxnCccBFBVlOUJMjXHLhu1xoYGSsPuh4ZmPAlcT+od+u4fLpk3EL3U/3zdT/S0EderPQjeuxFLRgvb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717055589; c=relaxed/simple;
	bh=Ta+vjQMUnEnz4IIoOGSdQZyJvJVA9F59MPLykCsDF/A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Fm8wa4sFRuMbwEN4PDejhGW3b6ZODRvNPSgglvEM78mYu+WeIjZtIakQOJYVlxb9cCJ/7csu2wQSa0EWzLeuNwrDNSlxKIdyOOHPijS+Ca6uLgK42TaIW5sBaBbzFQuiH+9oFvSH9mPcwKMFSFMT/iH62kDUuXxdi5g6V7g6K0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=O9SdtjXR; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a626776cc50so37563366b.3
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 00:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1717055585; x=1717660385; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A8+LkHQnfUqeAxK9pj0SE+OJ8HAZCjXhsYN7HJpcRbo=;
        b=O9SdtjXRGKEvCP3MtBKnRzob23XFaQac8nNG/O/GX2R9eQ3x9KE58SIu0fMl0M/kmW
         SavYIuxEcFDs2bXzteQGdxNfy1L03k7rkx9Ea86bDOwZErpgzuxisCIrkY7+wAy1F4L2
         gwp4wHD/tK/tOfl02LtNaw1feN890q2yfw4fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717055585; x=1717660385;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A8+LkHQnfUqeAxK9pj0SE+OJ8HAZCjXhsYN7HJpcRbo=;
        b=lalL1F2vSPBYpgww3XdpdJ9GeH9PFok1u5LBOedjUyQhseyjvu2HhOJy8J2mSvaSDS
         aepDfgmXrDxWHx06oGvcvlFrGfSxN0HIoFCligjYtHdN4+Nb7C3UeQcM0hYYv8cXyPMp
         h5ahn8nzAAVlE4wssy0GLgmV0++IuWKTzt6GfxySmk7RTLAvHMOlIaBCREzmoJ9f7peu
         0hVKa1X4APJAhQHf4dLhZgA+aX+lgjQ9XH/oB27jyG5QCan74RypCnv2sPVu0vZswoa0
         knoQjZXUDnifnDpbJ5gMf5XkwquFE/DoAvm1cvyPiR8xKHyId2mb5NrVJfGkJ4Nmk1C2
         2jQQ==
X-Gm-Message-State: AOJu0YxGfed4RjLV+E1EyT2K4llVJi91lK1Gbh0Qx7reeJX5ihS6iclU
	Lhm56PrELGYpxwDWP/NJaS4zdMQT2KzJlQCkRZWcP2uSt6zNTrULB3iuyuYtVJCg4cskttj4t5/
	bpBY14kixRnhI5oZc+vDobJrNFiR6cpSAbrDNp/d9P2w6cTx/1A==
X-Google-Smtp-Source: AGHT+IEFPgoHQksZ/lvCnfZlAA6o0O/qsp/JoY2hDzkjkdQaMIod7ibaPTJZSTY+I421eA41caYNPQbmLbiEkScjMvE=
X-Received: by 2002:a17:906:1d50:b0:a59:9db2:d988 with SMTP id
 a640c23a62f3a-a65e9100e73mr68383766b.50.1717055584718; Thu, 30 May 2024
 00:53:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Thu, 30 May 2024 09:52:38 +0200
Message-ID: <CAK8fFZ7MKoFSEzMBDAOjoUt+vTZRRQgLDNXEOfdCCXSoXXKE0g@mail.gmail.com>
Subject: [regresion] Dell's OMSA Systems Management Data Engine stuck after
 update from 6.8.y to 6.9.y (with bisecting)
To: netdev@vger.kernel.org
Cc: Igor Raits <igor@gooddata.com>, Daniel Secik <daniel.secik@gooddata.com>, 
	Zdenek Pesek <zdenek.pesek@gooddata.com>
Content-Type: text/plain; charset="UTF-8"

Hello

We are running Dell's OMSA Systems Management Data Engine on Dell
PowerEdge servers. This service is essential for monitoring and
managing the hardware. Recently, this daemon started getting stuck
after we updated the Linux kernel from version 6.8.y to 6.9.y.

The strace shows it gets stuck on "recvmsg(12, ... ).

# PowerEdge Server with 6.8.y: OK
$ strace -s 256 -fff /opt/dell/srvadmin/sbin/dsm_sa_datamgrd 2>&1 |
grep 'socket(AF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE)' -A4
[pid 1461196] socket(AF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE) = 12
[pid 1461196] sendto(12, [{nlmsg_len=24, nlmsg_type=0x16 /* NLMSG_???
*/, nlmsg_flags=NLM_F_REQUEST|0x300, nlmsg_seq=1, nlmsg_pid=0},
"\x02\x00\x00\x00\x07\x00\x00\x00"], 24, 0, {sa_family=AF_NETLINK,
nl_pid=0, nl_groups=00000000}, 12) = 24
[pid 1461196] recvmsg(12, {msg_name={sa_family=AF_NETLINK, nl_pid=0,
nl_groups=00000000}, msg_namelen=12,
msg_iov=[{iov_base=[[{nlmsg_len=76, nlmsg_type=RTM_NEWADDR,
nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1, nlmsg_pid=1461196},
{ifa_family=AF_INET, ifa_prefixlen=8, ifa_flags=IFA_F_PERMANENT,
ifa_scope=RT_SCOPE_HOST, ifa_index=if_nametoindex("lo")},
[[{nla_len=8, nla_type=IFA_ADDRESS}, inet_addr("127.0.0.1")],
[{nla_len=8, nla_type=IFA_LOCAL}, inet_addr("127.0.0.1")],
[{nla_len=7, nla_type=IFA_LABEL}, "lo"], [{nla_len=8,
nla_type=IFA_FLAGS}, IFA_F_PERMANENT], [{nla_len=20,
nla_type=IFA_CACHEINFO}, {ifa_prefered=4294967295,
ifa_valid=4294967295, cstamp=754, tstamp=754}]]], [{nlmsg_len=92,
nlmsg_type=RTM_NEWADDR, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1,
nlmsg_pid=1461196}, {ifa_family=AF_INET, ifa_prefixlen=20,
ifa_flags=IFA_F_PERMANENT, ifa_scope=RT_SCOPE_UNIVERSE,
ifa_index=if_nametoindex("br_private")}, [[{nla_len=8,
nla_type=IFA_ADDRESS}, inet_addr("10.12.48.106")], [{nla_len=8,
nla_type=IFA_LOCAL}, inet_addr("10.12.48.106")], [{nla_len=8,
nla_type=IFA_BROADCAST}, inet_addr("10.12.63.255")], [{nla_len=15,
nla_type=IFA_LABEL}, "br_private"], [{nla_len=8, nla_type=IFA_FLAGS},
IFA_F_PERMANENT|IFA_F_NOPREFIXROUTE], [{nla_len=20,
nla_type=IFA_CACHEINFO}, {ifa_prefered=4294967295,
ifa_valid=4294967295, cstamp=1752, tstamp=1752}]]], [{nlmsg_len=92,
nlmsg_type=RTM_NEWADDR, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1,
nlmsg_pid=1461196}, {ifa_family=AF_INET, ifa_prefixlen=20,
ifa_flags=IFA_F_PERMANENT, ifa_scope=RT_SCOPE_UNIVERSE,
ifa_index=if_nametoindex("br_public")}, [[{nla_len=8,
nla_type=IFA_ADDRESS}, inet_addr("10.12.16.106")], [{nla_len=8,
nla_type=IFA_LOCAL}, inet_addr("10.12.16.106")], [{nla_len=8,
nla_type=IFA_BROADCAST}, inet_addr("10.12.31.255")], [{nla_len=14,
nla_type=IFA_LABEL}, "br_public"], [{nla_len=8, nla_type=IFA_FLAGS},
IFA_F_PERMANENT|IFA_F_NOPREFIXROUTE], [{nla_len=20,
nla_type=IFA_CACHEINFO}, {ifa_prefered=4294967295,
ifa_valid=4294967295, cstamp=1756, tstamp=1756}]]]], iov_len=21504}],
msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 260
[pid 1461196] recvmsg(12, {msg_name={sa_family=AF_NETLINK, nl_pid=0,
nl_groups=00000000}, msg_namelen=12,
msg_iov=[{iov_base=[{nlmsg_len=20, nlmsg_type=NLMSG_DONE,
nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1, nlmsg_pid=1461196}, 0],
iov_len=21244}], msg_iovlen=1, msg_controllen=0, msg_flags=0}, 0) = 20
[pid 1461196] close(12)                 = 0

# PowerEdge Server with 6.8.y: STUCK
$ strace -s 256 -fff /opt/dell/srvadmin/sbin/dsm_sa_datamgrd 2>&1 |
grep 'socket(AF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE)' -A4
[pid 3249936] socket(AF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE) = 12
[pid 3249936] sendto(12, [{nlmsg_len=24, nlmsg_type=0x16 /* NLMSG_???
*/, nlmsg_flags=NLM_F_REQUEST|0x300, nlmsg_seq=1, nlmsg_pid=0},
"\x02\x00\x00\x00\x02\x00\x00\x00"], 24, 0, {sa_family=AF_NETLINK,
nl_pid=0, nl_groups=00000000}, 12) = 24
[pid 3249936] recvmsg(12, {msg_name={sa_family=AF_NETLINK, nl_pid=0,
nl_groups=00000000}, msg_namelen=12,
msg_iov=[{iov_base=[[{nlmsg_len=76, nlmsg_type=RTM_NEWADDR,
nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1, nlmsg_pid=3249936},
{ifa_family=AF_INET, ifa_prefixlen=8, ifa_flags=IFA_F_PERMANENT,
ifa_scope=RT_SCOPE_HOST, ifa_index=if_nametoindex("lo")},
[[{nla_len=8, nla_type=IFA_ADDRESS}, inet_addr("127.0.0.1")],
[{nla_len=8, nla_type=IFA_LOCAL}, inet_addr("127.0.0.1")],
[{nla_len=7, nla_type=IFA_LABEL}, "lo"], [{nla_len=8,
nla_type=IFA_FLAGS}, IFA_F_PERMANENT], [{nla_len=20,
nla_type=IFA_CACHEINFO}, {ifa_prefered=4294967295,
ifa_valid=4294967295, cstamp=769, tstamp=769}]]], [{nlmsg_len=88,
nlmsg_type=RTM_NEWADDR, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1,
nlmsg_pid=3249936}, {ifa_family=AF_INET, ifa_prefixlen=24,
ifa_flags=0, ifa_scope=RT_SCOPE_LINK,
ifa_index=if_nametoindex("idrac")}, [[{nla_len=8,
nla_type=IFA_ADDRESS}, inet_addr("169.254.1.2")], [{nla_len=8,
nla_type=IFA_LOCAL}, inet_addr("169.254.1.2")], [{nla_len=8,
nla_type=IFA_BROADCAST}, inet_addr("169.254.1.255")], [{nla_len=10,
nla_type=IFA_LABEL}, "idrac"], [{nla_len=8, nla_type=IFA_FLAGS}, 0],
[{nla_len=20, nla_type=IFA_CACHEINFO}, {ifa_prefered=714429,
ifa_valid=714429, cstamp=1805, tstamp=1805}]]], [{nlmsg_len=92,
nlmsg_type=RTM_NEWADDR, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1,
nlmsg_pid=3249936}, {ifa_family=AF_INET, ifa_prefixlen=20,
ifa_flags=IFA_F_PERMANENT, ifa_scope=RT_SCOPE_UNIVERSE,
ifa_index=if_nametoindex("br_private")}, [[{nla_len=8,
nla_type=IFA_ADDRESS}, inet_addr("10.12.48.105")], [{nla_len=8,
nla_type=IFA_LOCAL}, inet_addr("10.12.48.105")], [{nla_len=8,
nla_type=IFA_BROADCAST}, inet_addr("10.12.63.255")], [{nla_len=15,
nla_type=IFA_LABEL}, "br_private"], [{nla_len=8, nla_type=IFA_FLAGS},
IFA_F_PERMANENT], [{nla_len=20, nla_type=IFA_CACHEINFO},
{ifa_prefered=4294967295, ifa_valid=4294967295, cstamp=1791,
tstamp=1791}]]], [{nlmsg_len=92, nlmsg_type=RTM_NEWADDR,
nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1, nlmsg_pid=3249936},
{ifa_family=AF_INET, ifa_prefixlen=20, ifa_flags=IFA_F_PERMANENT,
ifa_scope=RT_SCOPE_UNIVERSE, ifa_index=if_nametoindex("br_public")},
[[{nla_len=8, nla_type=IFA_ADDRESS}, inet_addr("10.12.16.105")],
[{nla_len=8, nla_type=IFA_LOCAL}, inet_addr("10.12.16.105")],
[{nla_len=8, nla_type=IFA_BROADCAST}, inet_addr("10.12.31.255")],
[{nla_len=14, nla_type=IFA_LABEL}, "br_public"], [{nla_len=8,
nla_type=IFA_FLAGS}, IFA_F_PERMANENT], [{nla_len=20,
nla_type=IFA_CACHEINFO}, {ifa_prefered=4294967295,
ifa_valid=4294967295, cstamp=1795, tstamp=1795}]]], [{nlmsg_len=20,
nlmsg_type=NLMSG_DONE, nlmsg_flags=NLM_F_MULTI, nlmsg_seq=1,
nlmsg_pid=3249936}, 0]], iov_len=13312}], msg_iovlen=1,
msg_controllen=0, msg_flags=0}, 0) = 368
.. STUCK ...


I run two bisecting
1. git bisect start '--first-parent' 'v6.9' 'v6.8'
2. git bisect start

# ----------------- 1. bisecting -----------------
# bad: [a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6] Linux 6.9
# good: [e8f897f4afef0031fe618a8e94127a0934896aba] Linux 6.8
git bisect start '--first-parent' 'v6.9' 'v6.8'
# bad: [033e4491b6c614efddcf58927082887e2b78995d] Merge tag
'gpio-fixes-for-v6.9-rc2' of
git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
git bisect bad 033e4491b6c614efddcf58927082887e2b78995d
# bad: [68bf6bfdcf56b5e6567a668ffc15d5e449356c02] Merge tag
'ext4_for_linus-6.9-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
git bisect bad 68bf6bfdcf56b5e6567a668ffc15d5e449356c02
# good: [b32273ee89a866b01b316b9a8de407efde01090c] Merge tag
'execve-v6.9-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
git bisect good b32273ee89a866b01b316b9a8de407efde01090c
# bad: [9687d4ac582fad1af9979e296881f28c3f35b05c] Merge tag
'mailbox-v6.9' of
git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox
git bisect bad 9687d4ac582fad1af9979e296881f28c3f35b05c
# bad: [d2bac0823d046117de295120edff3d860dc6554b] Merge tag
'for-6.9/dm-changes' of
git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm
git bisect bad d2bac0823d046117de295120edff3d860dc6554b
# bad: [ca661c5e1d89a65642d7de5ad3edc00b5666002a] Merge tag
'selinux-pr-20240312' of
git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux
git bisect bad ca661c5e1d89a65642d7de5ad3edc00b5666002a
# good: [681ba318a635787031537b3a7df5c12980835cb1] Merge tag
'Smack-for-6.9' of https://github.com/cschaufler/smack-next
git bisect good 681ba318a635787031537b3a7df5c12980835cb1
# good: [1f440397665f4241346e4cc6d93f8b73880815d1] Merge tag
'docs-6.9' of git://git.lwn.net/linux
git bisect good 1f440397665f4241346e4cc6d93f8b73880815d1
# bad: [9187210eee7d87eea37b45ea93454a88681894a4] Merge tag
'net-next-6.9' of
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
git bisect bad 9187210eee7d87eea37b45ea93454a88681894a4
# first bad commit: [9187210eee7d87eea37b45ea93454a88681894a4] Merge
tag 'net-next-6.9' of
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next

# ----------------- 2. bisecting -----------------
git bisect start
# status: waiting for both good and bad commits
# bad: [a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6] Linux 6.9
git bisect bad a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
# status: waiting for good commit(s), bad commit known
# good: [e8f897f4afef0031fe618a8e94127a0934896aba] Linux 6.8
git bisect good e8f897f4afef0031fe618a8e94127a0934896aba
# bad: [480e035fc4c714fb5536e64ab9db04fedc89e910] Merge tag
'drm-next-2024-03-13' of https://gitlab.freedesktop.org/drm/kernel
git bisect bad 480e035fc4c714fb5536e64ab9db04fedc89e910
# bad: [9187210eee7d87eea37b45ea93454a88681894a4] Merge tag
'net-next-6.9' of
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
git bisect bad 9187210eee7d87eea37b45ea93454a88681894a4
# good: [a01c9fe32378636ae65bec8047b5de3fdb2ba5c8] Merge tag
'nfsd-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
git bisect good a01c9fe32378636ae65bec8047b5de3fdb2ba5c8
# bad: [ca61ba3885274a684c83d8a538eb77b30e38ee92] Merge branch
'rework-genet-mdioclocking'
git bisect bad ca61ba3885274a684c83d8a538eb77b30e38ee92
# good: [f42822f22b1c5f72c7e3497d9683f379ab0c5fe4] bnxt_en: Use
firmware provided maximum filter counts.
git bisect good f42822f22b1c5f72c7e3497d9683f379ab0c5fe4
# good: [e10cd2ddd89e8b3e61b49247067e79f7debec2f1] wifi: rtw89: load
BB parameters to PHY-1
git bisect good e10cd2ddd89e8b3e61b49247067e79f7debec2f1
# bad: [81800aef0eba33df2b30f2e29a0137078b9ba256] net: mdio_bus: make
mdio_bus_type const
git bisect bad 81800aef0eba33df2b30f2e29a0137078b9ba256
# good: [bed90b06b6812d9c8c848414b090ddf38f0e6cc1] net: phy: aquantia:
clear PMD Global Transmit Disable bit during init
git bisect good bed90b06b6812d9c8c848414b090ddf38f0e6cc1
# bad: [e1a00373e1305578cd09526aa056940409e6b877] Merge tag
'linux-can-next-for-6.9-20240213' of
git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
git bisect bad e1a00373e1305578cd09526aa056940409e6b877
# good: [383de5664c87abe097d6369d18305c3a6e559bb2] can: softing:
remove redundant NULL check
git bisect good 383de5664c87abe097d6369d18305c3a6e559bb2
# bad: [2ce30993831041b9dcd31eb12896be6611e8b7e2] r8169: add generic
rtl_set_eee_txidle_timer function
git bisect bad 2ce30993831041b9dcd31eb12896be6611e8b7e2
# bad: [0bef512012b1cd8820f0c9ec80e5f8ceb43fdd59] net: add
netdev_lockdep_set_classes() to virtual drivers
git bisect bad 0bef512012b1cd8820f0c9ec80e5f8ceb43fdd59
# bad: [88c9d07b96bb02108ef786f574cd0e730ebab678] Merge branch
'net-use-net-dev_by_index-in-two-places'
git bisect bad 88c9d07b96bb02108ef786f574cd0e730ebab678
# bad: [3e41af90767dcf8e5ca91cfbbbcb772584940df9] rtnetlink: use
xarray iterator to implement rtnl_dump_ifinfo()
git bisect bad 3e41af90767dcf8e5ca91cfbbbcb772584940df9
# good: [f383ced24d6ae6c1989394d052d3109b9d645f11] vlan: use xarray
iterator to implement /proc/net/vlan/config
git bisect good f383ced24d6ae6c1989394d052d3109b9d645f11
# first bad commit: [3e41af90767dcf8e5ca91cfbbbcb772584940df9]
rtnetlink: use xarray iterator to implement rtnl_dump_ifinfo()

However, reverting just the "use xarray iterator to implement
rtnl_dump_ifinfo" change did not resolve the issue. Do you have any
suggestions on what to try next and how to fix it?

Best,
Jaroslav Pulchart

