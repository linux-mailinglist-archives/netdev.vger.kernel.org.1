Return-Path: <netdev+bounces-225014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 498AFB8D1CE
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 00:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003D056053E
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 22:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022C02727EE;
	Sat, 20 Sep 2025 22:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyrSitGX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD5F25FA0E
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 22:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758407324; cv=none; b=XNyILmgEP99Y52kGKZbaq4tvSJO0RiNe75C9kL5ErZqzRABxfGRWX/cI2tuk9zUkijwpqInV3kUi8uffQQ5n5seaoVsXJ0zBMgPgTRTlGj2PPCsq5jSg0xH1Pd7Aa31sVutS2PwxsUMBzTxZyh5BCuK0LF6v9fWhTYFkgVTc1PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758407324; c=relaxed/simple;
	bh=9gu6hJVAnIfRTHtgnZ0zrWIon8dUaef830KhxqL6EZs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BGSOekyD2LbgicSvS6BZAPKYTgLL27hCAOPZRsliMAgXQoHLU0gfr+/J0IwDKtnqKypwk8oerUF82cxLsMf/CQfYtw35lacIZld87U8zWZx5WsZGaO6tdNHPMJydDot3TxMBCAjWILKBP9zDVtWSEuxSdsqXLLK+kmBCaIcDfTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyrSitGX; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-75763558ae1so1123303a34.3
        for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 15:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758407322; x=1759012122; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nA0qvsHjha/KfwIagmo7Q/qF5pnKgf1p52tDDCS5guk=;
        b=QyrSitGXTosZASyCS9VIljhApcWUNZYI5RDkYr9+mAnoVat8SW3s67eWFjpkSlkPag
         0Akfp8Ie30mHRYlW0K3n3nFl0vu9khxnqcSJaAAcPCRO2x27gkwM4Kbpr9m/phrC7JfL
         aEEmXt2U1ew6ajnnMrAQAhOunNL5jaQ/NnMeGvKGr8AKYtX1ZZGAmrz/hLwMzKvh3jk2
         Smv4Bi1FbnjRNHa8tk0AFnus4O7SIN+dQMbIY4U025B3nJ2NpeiOOwZyJxh4InSRVnZ0
         5uQ7PDg8QE0M+2Y4S09fvywHkFD+ZfgIe0mkVY3CyPlsW4YGiAtmyiolhQFGm2gSvQh+
         V33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758407322; x=1759012122;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nA0qvsHjha/KfwIagmo7Q/qF5pnKgf1p52tDDCS5guk=;
        b=QxsCDfjITEWnxr2zb65oc8IhICvsvFDoyfR3yjN8gnvcf+PCRF/GR8RSvL4kkLrqyB
         zAQhXePtxdON4I6ukfwVLCjMMfjWE/JmXt15aevru1pVM9p3NRa7GqX9KFBfsSXS7pl/
         GVODSAnHBRxwaXfLFsPvgBxGkTg8/llEivMPxZj117Qwq5vT/prtDDDU04z8DKZuyI8T
         S7ecLdf6CohwRHJcYZqztFezIan7vIv0FoBGEEAneIPOL2/mc4fdixBIH+mk9/9Cdj6H
         ru0QQqjqeEUpktjOShBtpl88JIf16veqcOeq0HxaZRl8Ql2lhNoTSwop5R8twFeQIV7H
         NPlw==
X-Forwarded-Encrypted: i=1; AJvYcCVTrVXklbV3EiB/cgak4d28ZMPMbg3W345bC97cG3QQYKzr9ez3UeR6jxXun62B1i5pIO8tuek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA4JVx/NcpG/eZFw7PlkOFJ0XTphHFK/40hxBm7z6uCgkHrMKG
	asiPlJ4XpK3snxlk3ZCFaJQ3S2kmYIhkmc6OvUU/4Wtp7RYnvF/jTOme
X-Gm-Gg: ASbGncsubcIW6Kg0I9J8i+eWczro0n1kX0aP2OrKy+4Ij6LqYIMu3qkLVIXswJKA2I/
	ntJiXrG1wZ7nb4GAJ51JHwj3uoIVr04PJM0ROCPWe27NAvgvqu6BlBSoUniHdQnSl1QtWMlgJu2
	TJ2O3+RkegsLF3Ctym4duOCAxbCnQBb6xHo2yNKPjvTudsB5TFNk6kzgh4W+6nb/OPtjXeNVwpK
	+ygfqAR1FDuOfDvKb1jFVeuQa5EtEbLApdKanuLE+KskAqQiJKWHmbbtaFWRFjcxupjhLq0GXmn
	+MR9rcLcH4h5vGwEb0BYft0AY2T2+hKHWnRI20d4U9r+5ERCbGaf5HcCYPcE1PE3TfQNncgjklM
	bMkzaoVSOVUKc5VbfYNmpycAs4eVhnhANRkQ4swlvyDDS0e37lbXfFpchD3ESTc3Yfj5lgLWq9x
	Suzv8o3n+xTjU60exl4tXNeeSS1HaCv2yLwMA=
X-Google-Smtp-Source: AGHT+IEQ4dNngj00vQnCTq2dGbkr6X6Uyiu6Awm/G2AhyR9r9uQMYSQ+ael8GKCRVsJEaC3eNEb/cQ==
X-Received: by 2002:a05:6830:398a:b0:74a:ed47:a2fd with SMTP id 46e09a7af769-76f70bfd509mr4198600a34.9.1758407322247;
        Sat, 20 Sep 2025 15:28:42 -0700 (PDT)
Received: from [10.0.11.20] (57-132-132-155.dyn.grandenetworks.net. [57.132.132.155])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7692c72528esm4150535a34.42.2025.09.20.15.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 15:28:41 -0700 (PDT)
Message-ID: <6980dba4ac0be1d6bbed8cb595d38114d89a14f5.camel@gmail.com>
Subject: Re: [REGRESSION] af_unix: Introduce SO_PASSRIGHTS - break OpenGL
From: brian.scott.sampson@gmail.com
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: christian@heusel.eu, davem@davemloft.net, difrost.kernel@gmail.com, 
	dnaim@cachyos.org, edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	kuni1840@gmail.com, linux-kernel@vger.kernel.org,
 mario.limonciello@amd.com, 	netdev@vger.kernel.org, pabeni@redhat.com,
 regressions@lists.linux.dev
Date: Sat, 20 Sep 2025 17:28:40 -0500
In-Reply-To: <20250920035146.2149127-1-kuniyu@google.com>
References: <caa08e5b15bc35b9f3c24f679c62ded1e8e58925.camel@gmail.com>
		 <20250920035146.2149127-1-kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 (flatpak git) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> Thank you for your patience.
>=20
> I assumed SO_PASSCRED was the problem, but I missed
> SO_PASSCRED was also inherited durint accept().
>=20
> Could you apply this on top of the previous changes ?
>=20
> Also, could you tell what desktop manager and distro
> you are using ?=C2=A0 If this attempt fails, I'll try to
> reproduce with the same version on my desktop.

No worries! I just applied this patch as well(on top of the other two
in the order you originally provided), and still seeing the black
screen upon resume. I am seeing a stack trace now when I check
systemd's journal, which wasn't there before(not sure if its related).
I do have the System.map as well for this build, but not sure why
everything seemed to end up so cryptic. I'll paste it below as well as
my desktop:=C2=A0

Desktop Environment:=C2=A0Gnome 48.5=C2=A0
Window Manager: Mutter (Wayland)=C2=A0
Distribution: CachyOS


Trace:

=E2=9D=AF sudo journalctl -k -b -1 | grep "cut here" -A52 | awk -F 'kernel:=
 '
'{print $2}'
------------[ cut here ]------------
WARNING: CPU: 3 PID: 545 at net/core/sock.c:1548
sk_setsockopt+0x1709/0x1b50
Modules linked in: dm_mod crypto_user loop nfnetlink lz4 zram
842_decompress lz4hc_compress 842_compress lz4_compress amdgpu amdxcp
i2c_algo_bit drm_ttm_helper ttm drm_exec gpu_sched drm_suballoc_helper
video rtsx_pci_sdmmc mmc_core drm_panel_backlight_quirks nvme drm_buddy
nvme_core drm_display_helper serio_raw rtsx_pci nvme_keyring cec
nvme_auth wmi
CPU: 3 UID: 0 PID: 545 Comm: systemd-journal Not tainted 6.17.0-rc6-
local-00268-g3b08f56fbbb9-dirty #1 PREEMPT(full)=20
c74d467c5c838be6e0491dc375b7e67fc07dfcf3
Hardware name: Alienware Alienware m18 R1 AMD/0HR91K, BIOS 1.19.0
07/01/2025
RIP: 0010:sk_setsockopt+0x1709/0x1b50
Code: 00 e9 30 eb ff ff ba a1 ff ff ff e9 64 eb ff ff 0f b6 43 12 3c 0a
0f 85 d0 f3 ff ff 8b 83 b8 00 00 00 85 c0 0f 84 c2 f3 ff ff <0f> 0b e9
bb f3 ff ff 48 8d 7c 24 38 b9 08 00 00 00 4c 89 de 4c 89
RSP: 0018:ffffccbfc3e8bbf8 EFLAGS: 00010202
RAX: 0000000000000010 RBX: ffff8a3598268cc0 RCX: ffff8a35805db400
RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffffffffadc442f3
RBP: ffffccbfc3e8bc98 R08: ffff8a35c4ed8000 R09: 0000000000000004
R10: 0000000000000010 R11: 00007ffeb08dc62c R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000001 R15: ffffccbfc3e8bd30
FS:  00007f47de2c7880(0000) GS:ffff8a3d0dc30000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f47de0bb910 CR3: 000000011431b000 CR4: 0000000000f50ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __x64_sys_fcntl+0x80/0x110
 unix_setsockopt+0x42/0xd0
 ? security_socket_setsockopt+0x52/0x160
 do_sock_setsockopt+0xb2/0x190
 ? __seccomp_filter+0x41/0x4e0
 __sys_setsockopt+0x7b/0xc0
 __x64_sys_setsockopt+0x1f/0x30
 do_syscall_64+0x81/0x970
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? do_syscall_64+0x81/0x970
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? do_sock_getsockopt+0x1cc/0x210
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __sys_getsockopt+0x77/0xc0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? do_syscall_64+0x81/0x970
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? do_syscall_64+0x81/0x970
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? exc_page_fault+0x7e/0x1a0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f47ddb42b4e
Code: 48 83 ec 10 48 63 c9 48 63 ff 45 89 c9 6a 2c e8 48 39 f6 ff 48 83
c4 18 c3 0f 1f 00 f3 0f 1e fa 49 89 ca b8 36 00 00 00 0f 05 <48> 3d 00
f0 ff ff 77 0a c3 66 0f 1f 84 00 00 00 00 00 48 8b 15 81
RSP: 002b:00007ffeb08dc618 EFLAGS: 00000202 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 000055798b740c40 RCX: 00007f47ddb42b4e
RDX: 0000000000000010 RSI: 0000000000000001 RDI: 0000000000000005
RBP: 00007ffeb08dc630 R08: 0000000000000004 R09: 0000000000000000
R10: 00007ffeb08dc62c R11: 0000000000000202 R12: 0000000000000005
R13: 00007ffeb08dc6d0 R14: 0000000000000006 R15: 0000000000000000
 </TASK>
---[ end trace 0000000000000000 ]---





