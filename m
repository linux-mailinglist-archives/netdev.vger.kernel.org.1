Return-Path: <netdev+bounces-218543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F42B3D17C
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 10:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645F318984B6
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 08:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCC124DCF7;
	Sun, 31 Aug 2025 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1l4Q0dL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2044624A054;
	Sun, 31 Aug 2025 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756630242; cv=none; b=m5uwpo2AIYkbCwi1C5cm+ZAaMXOiTvG+g2imfXh7dovDmTpql9sKr8q4NY/OIXO4ROwibp1YpL+oPyhEGt05NdVJRMuIFxE9479FRdhnasU1UjkxvQ7Z+cT8kSqyzo9l6u3cgrdHQplDPDG+Bo5QTH6DMf2C/SVCj2SglyF1dtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756630242; c=relaxed/simple;
	bh=62ZRVz/a+iniPXqEtHjttYlsm229Roujk0h7I8/fUu8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject; b=eQ8fC0q2Bg2GrBz1zRt4uRuZ25hAwlgSE+YakXjWL2knKh+hfHskQY6y9Fcm0RwISQ1CEIzaUFSL25koUZCmvYvXXlAxXjaaiyKymXE9c4r18fb/8DWj4eJ4L3Yat2wD+9mSCtbdlOmw2CUqFDNnzG8xAEqNUQ/+9hBTHY97YnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1l4Q0dL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso19484865e9.2;
        Sun, 31 Aug 2025 01:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756630238; x=1757235038; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:content-transfer-encoding
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SDzUuUDnSod+LyxqsRnFLfeinRJ17SRAkYjqkM4gx88=;
        b=Y1l4Q0dL6+y2WraKjHSaef6SnD5BYLUZLN/cDE/uIZNqUqAzQOYqa40Qr+YVsGElQw
         gEwjdtt9EdkGh7FeW9qsFR8mpavwald0g+4ofmLDpyOUjgNPS/nfgNVp5I/SVAJfxeBn
         nl3+jNTBz0d8IpKLoJHRrs0ikcxLxnApxkl5+YVs5fjtbFeero83m7dR/IAO3Y3kQLFT
         IbAMqu0Y5Cxaov+/9BA4Sfx3kz2UvWyYhYHW/0rG7c1Wp77Z+ajyC3MkSi6axKM+Vm82
         Okbr5WWIJlYBbqUBJP7oZA8DrTOigHbA24j9Uo8iolCkZfEtxm78R14QvM00ETyVMZ0X
         5oRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756630238; x=1757235038;
        h=subject:cc:to:from:message-id:date:content-transfer-encoding
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDzUuUDnSod+LyxqsRnFLfeinRJ17SRAkYjqkM4gx88=;
        b=wMyXMdJqsdp9Okg1+YYHAp6K4V8f4ddL4k0tAcR45a92R933CXyKPgyjeKaM5HZmZk
         wftHR1EVHSDJFSqhFKW7G9c9otwrMplpGxxhqLfu4XC5EeABp2UXN/vyj54OQEgoaKGs
         wLMIcIWhEpug4VDFO+PTjJRxL5UEA3RdDn0M2icl2ytozlYv01PKExWPatlS2pCXslCw
         mYKQTIg7tOkvg3VGpnx8l8WtPCRbk/p/Tn/I2pm6M+rzkBsCvNdBweaiNlhtKcuapXWi
         7OTo9yJmD8wM6OOvfzw2BF3lujB7Rhb6hBbbtDAONRlUJEZiOv0R5qlkr1vvCJ6oOfS6
         VDtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxpzzAettMnJ9Uh3RgAx5Vj5SDhn/CQkj4s+y5SQyp6MoPJuQbr138tnzZETSZLBDcEhaB5+4r0/Wm7qk=@vger.kernel.org, AJvYcCXa+XOT4XAaIirdTqYI3FHCfyduYiBzqQXPpw9ZVZbIytaWQaS1NZYqwC9SB3JhiLicl+INp5kF@vger.kernel.org
X-Gm-Message-State: AOJu0YyRVrji3T2Uoza987yRVd5X/3JGIaWM1EbgfHutAlbQ30JkX1pD
	w2T5exFPBgkBPh618rd9yP9iK3LJQK68mGkWKoN3X22qSf2VXX/wSquw
X-Gm-Gg: ASbGncuyyWgKNxwNsFpc8EgX2h7q2ukjzCSgMwtKIISz+vPG4x9dluecaYxtinJNcnh
	ZXwaMIdJeN+Nr4x8xDtM8oyfE1fBoX20bDeJ4PVwTOWwGswgNVWCoMLloZLguckOyItMqgXzt85
	u7X7uxIt0WXKxS+BSNLQByOpHonq6tOFbl/yV5+NFpPMIkxzttU4O96/ZJR1ey+bxqa/N059wBg
	gqfkC0dgmZ5Jme2kqZuyNVQz7mn66nK1OkzREHvpqMX77AeuKk0uvJHxn7fi9eimZ2rj6uD7Nbz
	8LjoaPbpSyQ7+sh5iOsFXJhJhsx+45ZCVhrTcZq/CH4NJdu3sU/onMPR+SjtV5dNifVR3aIZK6j
	AzUpHsBFhFCqDL6O67Umdtm22vo5bCnwF0p+nAJIX+GLy/hEEH2576Xr8ND6y3P5PKUyhSJRRa6
	G5Lk2a2kY1h1XP
X-Google-Smtp-Source: AGHT+IFVKA49diDb1kHmVgVOw4Z/GlIBlMufFjdRe8fWtG1R/vlyL6dSlDFFSWc04qEN0fBFzYQQEw==
X-Received: by 2002:a05:600c:4f87:b0:45b:8482:5ad4 with SMTP id 5b1f17b1804b1-45b855341femr29104325e9.13.1756630237982;
        Sun, 31 Aug 2025 01:50:37 -0700 (PDT)
Received: from localhost (public-gprs292944.centertel.pl. [31.62.31.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e74b72esm110605875e9.0.2025.08.31.01.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Aug 2025 01:50:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 31 Aug 2025 10:50:35 +0200
Message-Id: <DCGHG5UJT9G3.2K1GHFZ3H87T0@gmail.com>
From: =?utf-8?q?Hubert_Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>
To: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Oleksij
 Rempel" <linux@rempel-privat.de>
Cc: <linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>,
 <regressions@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [REGRESSION] net: usb: asix: deadlock on interface setup
X-Mailer: aerc 0.20.0

Trying to bring an AX88772B-based USB-Ethernet adapter up results in a
deadlock if the adapter was suspended at the time. Most network-related
software hangs up indefinitely as a result. This can happen on systems
which configure USB power control to 'auto' by default, e.g. laptops
running `tlp`.


Steps to reproduce:
  Try to bring the interface up while the adapter is suspended. For
  example, assuming that the device is on bus 1, port 1:
    root@usb-eth-test:/sys/bus/usb/devices/1-1/power# echo auto > control
    root@usb-eth-test:/sys/bus/usb/devices/1-1/power# cat runtime_status
    suspended
    root@usb-eth-test:/sys/bus/usb/devices/1-1/power# ip link set enp0s1u1 =
up


Expectations vs reality:
  The interface should be brought up and be able to operate, but instead
  the `ip` command hangs up and never returns, and lockdep emits the
  following warning (decoded here):
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    WARNING: possible recursive locking detected
    6.17.0-rc3 #1 Not tainted
    --------------------------------------------
    ip/273 is trying to acquire lock:
    ffffffffb906e748 (rtnl_mutex){+.+.}-{4:4}, at: ax88772_resume (drivers/=
net/usb/asix_devices.c:650)

    but task is already holding lock:
    ffffffffb906e748 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink (net/core/r=
tnetlink.c:3893 net/core/rtnetlink.c:4057)

    other info that might help us debug this:
    Possible unsafe locking scenario:

    CPU0
    ----
    lock(rtnl_mutex);
    lock(rtnl_mutex);

    *** DEADLOCK ***

    May be due to missing lock nesting notation

    1 lock held by ip/273:
    #0: ffffffffb906e748 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink (net/co=
re/rtnetlink.c:3893 net/core/rtnetlink.c:4057)

    stack backtrace:
    CPU: 0 UID: 0 PID: 273 Comm: ip Not tainted 6.17.0-rc3 #1 PREEMPT(volun=
tary)
    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-=
1.16.3-2 04/01/2014
    Call Trace:
    <TASK>
    dump_stack_lvl (lib/dump_stack.c:122)
    print_deadlock_bug.cold (kernel/locking/lockdep.c:3044)
    __lock_acquire (kernel/locking/lockdep.c:3897 kernel/locking/lockdep.c:=
5237)
    ? usb_start_wait_urb (drivers/usb/core/message.c:83)
    lock_acquire (kernel/locking/lockdep.c:470 (discriminator 4) kernel/loc=
king/lockdep.c:5870 (discriminator 4) kernel/locking/lockdep.c:5825 (discri=
minator 4))
    ? ax88772_resume (drivers/net/usb/asix_devices.c:650)
    __mutex_lock (arch/x86/include/asm/jump_label.h:36 include/trace/events=
/lock.h:95 kernel/locking/mutex.c:600 kernel/locking/mutex.c:760)
    ? ax88772_resume (drivers/net/usb/asix_devices.c:650)
    ? ax88772_resume (drivers/net/usb/asix_devices.c:650)
    ? __usbnet_read_cmd (drivers/net/usb/usbnet.c:2065)
    ? ax88772_resume (drivers/net/usb/asix_devices.c:650)
    ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:183)
    ax88772_resume (drivers/net/usb/asix_devices.c:650)
    asix_resume (drivers/net/usb/asix_devices.c:663)
    usb_resume_interface.isra.0 (drivers/usb/core/driver.c:1375)
    usb_resume_both (drivers/usb/core/driver.c:1532 (discriminator 1))
    ? __pfx_usb_runtime_resume (drivers/usb/core/driver.c:1981)
    __rpm_callback (drivers/base/power/runtime.c:406)
    ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:183)
    ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:183)
    rpm_callback (include/linux/sched/mm.h:339 (discriminator 1) include/li=
nux/sched/mm.h:369 (discriminator 1) drivers/base/power/runtime.c:458 (disc=
riminator 1))
    ? __pfx_usb_runtime_resume (drivers/usb/core/driver.c:1981)
    rpm_resume (drivers/base/power/runtime.c:934)
    ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:183)
    ? lock_release (kernel/locking/lockdep.c:5536 kernel/locking/lockdep.c:=
5889 kernel/locking/lockdep.c:5875)
    rpm_resume (drivers/base/power/runtime.c:913)
    __pm_runtime_resume (include/linux/spinlock.h:406 drivers/base/power/ru=
ntime.c:1193)
    usb_autopm_get_interface (include/linux/pm_runtime.h:532 drivers/usb/co=
re/driver.c:1828)
    usbnet_open (drivers/net/usb/usbnet.c:899)
    __dev_open (net/core/dev.c:1684)
    __dev_change_flags (net/core/dev.c:9549)
    netif_change_flags (net/core/dev.c:9612)
    do_setlink.isra.0 (net/core/rtnetlink.c:3143 (discriminator 1))
    ? lock_release (kernel/locking/lockdep.c:5536 kernel/locking/lockdep.c:=
5889 kernel/locking/lockdep.c:5875)
    ? rtnl_newlink (net/core/rtnetlink.c:3893 net/core/rtnetlink.c:4057)
    ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:183)
    ? __mutex_lock (include/trace/events/lock.h:122 (discriminator 2) kerne=
l/locking/mutex.c:607 (discriminator 2) kernel/locking/mutex.c:760 (discrim=
inator 2))
    ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:183)
    ? rtnl_newlink (net/core/rtnetlink.c:3893 net/core/rtnetlink.c:4057)
    ? lock_release (kernel/locking/lockdep.c:5536 kernel/locking/lockdep.c:=
5889 kernel/locking/lockdep.c:5875)
    rtnl_newlink (net/core/rtnetlink.c:3761 (discriminator 1) net/core/rtne=
tlink.c:3920 (discriminator 1) net/core/rtnetlink.c:4057 (discriminator 1))
    ? lock_acquire (kernel/locking/lockdep.c:470 (discriminator 4) kernel/l=
ocking/lockdep.c:5870 (discriminator 4) kernel/locking/lockdep.c:5825 (disc=
riminator 4))
    ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:183)
    ? find_held_lock (kernel/locking/lockdep.c:5350 (discriminator 1))
    ? rtnetlink_rcv_msg (include/linux/rcupdate.h:341 (discriminator 1) inc=
lude/linux/rcupdate.h:871 (discriminator 1) net/core/rtnetlink.c:6944 (disc=
riminator 1))
    ? __pfx_rtnl_newlink (net/core/rtnetlink.c:3948)
    ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:183)
    ? rtnetlink_rcv_msg (net/core/rtnetlink.c:6945)
    ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:183)
    ? __pfx_rtnetlink_rcv_msg (net/core/rtnetlink.c:6849)
    netlink_rcv_skb (net/netlink/af_netlink.c:2552)
    netlink_unicast (net/netlink/af_netlink.c:1321 net/netlink/af_netlink.c=
:1346)
    netlink_sendmsg (net/netlink/af_netlink.c:1896)
    ____sys_sendmsg (net/socket.c:714 (discriminator 1) net/socket.c:729 (d=
iscriminator 1) net/socket.c:2614 (discriminator 1))
    ___sys_sendmsg (net/socket.c:2670)
    ? lock_release (kernel/locking/lockdep.c:5536 kernel/locking/lockdep.c:=
5889 kernel/locking/lockdep.c:5875)
    __sys_sendmsg (net/socket.c:2700 (discriminator 1))
    ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:183)
    do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x8=
6/entry/syscall_64.c:94 (discriminator 1))
    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
    RIP: 0033:0x7fddcbcb2687
    Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8=
 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f =
80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
    All code
    =3D=3D=3D=3D=3D=3D=3D=3D
       0:	48 89 fa             	mov    %rdi,%rdx
       3:	4c 89 df             	mov    %r11,%rdi
       6:	e8 58 b3 00 00       	call   0xb363
       b:	8b 93 08 03 00 00    	mov    0x308(%rbx),%edx
      11:	59                   	pop    %rcx
      12:	5e                   	pop    %rsi
      13:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
      17:	74 1a                	je     0x33
      19:	5b                   	pop    %rbx
      1a:	c3                   	ret
      1b:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
      22:	00
      23:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
      28:	0f 05                	syscall
      2a:*	5b                   	pop    %rbx		<-- trapping instruction
      2b:	c3                   	ret
      2c:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
      33:	83 e2 39             	and    $0x39,%edx
      36:	83 fa 08             	cmp    $0x8,%edx
      39:	75 de                	jne    0x19
      3b:	e8 23 ff ff ff       	call   0xffffffffffffff63

    Code starting with the faulting instruction
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
       0:	5b                   	pop    %rbx
       1:	c3                   	ret
       2:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
       9:	83 e2 39             	and    $0x39,%edx
       c:	83 fa 08             	cmp    $0x8,%edx
       f:	75 de                	jne    0xffffffffffffffef
      11:	e8 23 ff ff ff       	call   0xffffffffffffff39
    RSP: 002b:00007fffad1c7b60 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
    RAX: ffffffffffffffda RBX: 00007fddcba85840 RCX: 00007fddcbcb2687
    RDX: 0000000000000000 RSI: 00007fffad1c7c10 RDI: 0000000000000003
    RBP: 00007fffad1c7c10 R08: 0000000000000000 R09: 0000000000000000
    R10: 0000000000000000 R11: 0000000000000202 R12: 00007fffad1c8300
    R13: 0000000000000000 R14: 0000555b0fa13020 R15: 0000000000000000
    </TASK>


Details:
  I have used QEMU with USB passthrough to catch the issue, but this
  happens on real hardware as well.

  The bug has already been reported on bugzilla
  (https://bugzilla.kernel.org/show_bug.cgi?id=3D215199), but this was
  probably not the right place.

  USB device: Edimax USB 2.0 Fast Ethernet Adapter, model no. EU-4208
  USB device IDs: 0b95:772b ASIX Electronics Corp. AX88772B

  Kernel version (/proc/version):
    Linux version 6.17.0-rc3 (hubert25632@B550M-AE) (gcc (Debian 14.2.0-19)
    14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #1 SMP PREEMPT_DYNAMIC
    Sat Aug 30 21:43:30 CEST 2025

  iproute2 version: ip utility, iproute2-6.16.0, libbpf 1.6.2
  OS: Debian GNU/Linux forky/sid
  CPU architecture: x86_64
  Kernel config: https://pastebin.com/MiBZnCgC
  dmesg log: https://pastebin.com/JXiZTiAT

  Last good kernel version: v5.13
  First bad commit: 4a2c7217cd5a ("net: usb: asix: ax88772: manage PHY PM f=
rom MAC")


Possible workaroud:
  Users of `tlp` can add the following statement to `/etc/tlp.conf` to
  prevent the adapter from being suspended automatically:
    USB_DENYLIST=3D"0b95:772b"


#regzbot introduced: 4a2c7217cd5a

