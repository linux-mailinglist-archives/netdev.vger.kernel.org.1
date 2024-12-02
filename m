Return-Path: <netdev+bounces-147979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F2A9DF9E3
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 05:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851DA281852
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 04:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343B1157A48;
	Mon,  2 Dec 2024 04:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuLAHVTv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592412F41;
	Mon,  2 Dec 2024 04:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733113853; cv=none; b=F6QM17d+NmVbM7QdGW/zjBhRTGpYRxHywaKeM4JjJoUAvzpzXQ4ObEZpoLJeVxD0RF0lH+KseHeH+gJpyD1kb/Vr0IbtxMRQ91W2LH9sqViqMeuw+xiBXfq3N0NbtvntOXvbEs5XqMaW3LcS+upVZF9dZaqKjTQCt63aL+IVDQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733113853; c=relaxed/simple;
	bh=xrN99VDfdvQOyW42cxY6ak9tqDTZBcP8Fm+2EslVXgo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GUA37jEkIo5EMSqdhLR8z6T1wZCR+YXxAjKHg+2a4JjbGhQGyGs8aldlhAV4ywumnv4qWd9ozS23qDEjJZoX2rYztbhXlnPBXY9Wi77IMT3gJdOLaRaxoDzy6lsLz0E3tgk0H9Z0L4lsgRPLjGlRFyosnBpCkv0G9XfJ0pOMEoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuLAHVTv; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffc1009a06so52290661fa.2;
        Sun, 01 Dec 2024 20:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733113849; x=1733718649; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xrN99VDfdvQOyW42cxY6ak9tqDTZBcP8Fm+2EslVXgo=;
        b=KuLAHVTvkFkdt6+/SRtK+FdVrHqIK5phzoaE3LXoNVK+hFUxPLQx/6HwVrulXH/D+a
         H5ELnGI+YDcjftoW9aK6O2YCopVg1TkCdUs5C6JK6o4Zp1DBQOE3qiE2oaWABrGpjzz+
         eDT30xCQaw+E0gAHVy3nSI6n8JG/k8VPko0BWFNdqxumyPvBtllDxDWoz0+xdQFxNEp8
         8NfOA+o4ANQyQAT9oB41qbFkkM+RtpZw2RSVm5WV5lMl6ac2Ah6lwpck0VIXlsN0UdZH
         3mK716tS0pGVuDEI2fA9J1htKhp0obN63V89JTuYcEzCqCajwGd0Xx4HW0xo+B2SgVB9
         UmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733113849; x=1733718649;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xrN99VDfdvQOyW42cxY6ak9tqDTZBcP8Fm+2EslVXgo=;
        b=hFgZwVT2xkpmOB/HMrLj/vwbqvpgr8p/1oCybXHJJrPkoBFKtho/IOWnqzSyzvEUDP
         G7Q1Uev1uy5w3Ku2oJd+0M4F6/eCT4yd0DAOH+xdcuhRs929VmRAczEybbIMSatd00mv
         YVN6QGo0PGWYRK8IDnl9nxOpEiaj8HP8aN1XG5arriAyCZmRa6rEEOo/vjXzKpc4hSXJ
         fUggN0VKCFaRuGdB3Q41OMS4qCvwHyByxtjXBLO5t8NY6v32DxnPBtEioS1O6WF6Hnfn
         j+sT+2BSX8iNpy2gAOh2MAA4IhqK+Dz2pVK41dRxdUyf2EBPL1ULLjSr01/1S9LmyrnY
         AMXw==
X-Forwarded-Encrypted: i=1; AJvYcCXDNzqB934YR6xSeWMJFyhvmHslk/GCTkDA9Z7wVcI9oSISxI4aQ1N4S+Crn9RLqpAseX7SBOEBHeKoh60=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBN/O/A45cE+VEFeMvl5Rwfo3QEMXogR6KKUWMJpigFrNnRg3v
	zgkS2O1BtRnICu5k8iyMFk/xbicfwraPyo99WcsvgjsN3zaF8CxkgsByobywXSi/KA1gtR8CkAa
	U98le/G6PBIEhneXRSxKPyfo+4091bq3d
X-Gm-Gg: ASbGncubE5VYMqRb1ZxdsH9rzWNK7+xMNFkHlW4pXyqR1k4tE9IbN+M05j6xxM6lKRc
	P81k5ZldI0qgvRMXp8hcEqNgOk3nxZqnI
X-Google-Smtp-Source: AGHT+IHkkqWY/FDZUECf407SWcBP2rVH6iOszZc4Bcm8zyF5QAurI53Ih6JVa3cxYwvlG9Mu/rwyNF9Sc+dADtZjHJY=
X-Received: by 2002:a05:651c:b14:b0:2ff:5c17:d57d with SMTP id
 38308e7fff4ca-2ffd5fcc09emr161708641fa.2.1733113849031; Sun, 01 Dec 2024
 20:30:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Mon, 2 Dec 2024 12:30:37 +0800
Message-ID: <CAKHoSAuCLyh5JWVkYbEzwphX_fyKNP5PyBWsyq+V9jP7Vy4=kA@mail.gmail.com>
Subject: "bug description: kernel warn in p9_trans_create_unix" in Linux
 Kernel Version 2.6.26
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am writing to report a potential vulnerability identified in the
Linux Kernel version 2.6.26.
This issue was discovered using our custom vulnerability discovery
tool.

Affected File:

File: net/9p/trans_fd.c
Function: p9_trans_create_unix

Detailed call trace:

[ 1126.740669] RIP: 0010:[<ffffffffa0219318>] [<ffffffffa0219318>]
:9pnet:p9_trans_create_unix+0x64/0x180
[ 1126.740669] RSP: 0018:ffff81018ec3fb68 EFLAGS: 00000246
[ 1126.740669] RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffffffffffffff
[ 1126.740669] RDX: ffff81023bcee000 RSI: ffff81022e5bcfc0 RDI: 0000000000000000
[ 1126.740669] RBP: 0000000000000000 R08: ffff81022b98a000 R09: ffff8102318e5ef6
[ 1126.740669] R10: 0000000000000000 R11: ffffffff802f20a6 R12: ffff81022e5bcfc0
[ 1126.740669] R13: ffff81022e5bcfc0 R14: 0000000000002000 R15: 0000000000000001
[ 1126.740669] FS: 00007f20dd7116e0(0000) GS:ffff81023bce97c0(0000)
knlGS:0000000000000000
[ 1126.740669] CS: 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1126.740669] CR2: 0000000000000000 CR3: 000000019d47d000 CR4: 00000000000006e0
[ 1126.740669] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1126.740669] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 1126.740669] Process a.out (pid: 15058, threadinfo ffff81018ec3e000,
task ffff8101f6502750)
[ 1126.740669] Stack: ffff81023b9c0550 0000000000000000
ffffffffa0116aa0 ffffffffa00f6899
[ 1126.740669] 0000000000000000 ffff810223007c60 ffff81022c95b7b0
ffff81022996dd70
[ 1126.740669] 00000000000b1943 ffff810238190c00 0000000000001000
ffffffff803208fb
[ 1126.740669] Call Trace:
[ 1126.740669] [<ffffffffa00f6899>] :jbd:do_get_write_access+0x378/0x3be
[ 1126.740933] [<ffffffff803208fb>] match_token+0x6d/0x1d2
[ 1126.740933] [<ffffffffa0215610>] :9pnet:p9_client_create+0x181/0x2b3
[ 1126.740933] [<ffffffff80276423>] get_page_from_freelist+0x45a/0x603
[ 1126.740933] [<ffffffff80320a44>] match_token+0x1b6/0x1d2
[ 1126.740933] [<ffffffffa022475a>] :9p:v9fs_session_init+0x289/0x32f
[ 1126.740933] [<ffffffffa02230ec>] :9p:v9fs_get_sb+0x6d/0x1d9
[ 1126.740933] [<ffffffff8029cbbc>] vfs_kern_mount+0x93/0x11b
[ 1126.740933] [<ffffffff8029cc97>] do_kern_mount+0x43/0xdc
[ 1126.740933] [<ffffffff802b16a9>] do_new_mount+0x5b/0x95
[ 1126.740933] [<ffffffff802b18a0>] do_mount+0x1bd/0x1e7
[ 1126.740933] [<ffffffff8027684e>] __alloc_pages_internal+0xd6/0x3bf
[ 1126.740933] [<ffffffff802b1954>] sys_mount+0x8a/0xce
[ 1126.740933] [<ffffffff8020beca>] system_call_after_swapgs+0x8a/0x8f
[ 1126.740933]
[ 1126.740933]
[ 1126.740933] Code: 07 e0 48 85 c0 49 89 c5 0f 84 24 01 00 00 fc 48
c7 40 20 20 8d 21 a0 48 c7 40 18 30 81 21 a0 48 83 c9 ff 49 89 c4 48
89 ef 31 c0 <f2> ae 48 f7 d1 48 ff c9 48 83 f9 6c 76 31 65 48 8b 04 25
00 00
[ 1126.740933] RIP [<ffffffffa0219318>] :9pnet:p9_trans_create_unix+0x64/0x180
[ 1126.740933] RSP <ffff81018ec3fb68>
[ 1126.740933] CR2: 0000000000000000
[ 1126.745832] ---[ end trace 9deab910d1f789fc ]---

Repro C Source Code: https://pastebin.com/jirvRhYm

Root Cause:

The root cause of this bug lies in the insufficient validation of
mount options passed to the p9_trans_create_unix function in the 9P
filesystem's Unix transport mechanism. Specifically, malformed or
incomplete options, such as
"trans=unix,access=client,nodevmap,aname=vboxnet1:em0+cpuset", lead to
unhandled edge cases during option parsing and socket initialization.
This causes the kernel to dereference an invalid or null pointer,
triggering a general protection fault. The lack of proper input checks
and error handling in the function results in memory corruption and
kernel instability when processing user-controlled mount requests.

Thank you for your time and attention.

Best regards

Wall

