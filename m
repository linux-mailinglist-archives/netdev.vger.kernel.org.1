Return-Path: <netdev+bounces-179452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E38E2A7CC8E
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 04:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF75189310C
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 02:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF352AEF5;
	Sun,  6 Apr 2025 02:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTniIvGO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EDC4409;
	Sun,  6 Apr 2025 02:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743906676; cv=none; b=bs0H7P4tdxvI2E0cR2N9iC6UT+B954RgXF/JPI6ZMtGWe7NUpBBdNvOfcMp3SRiEBgY/BBozVdzUmIrKYc6P8YvHHbyUHJYwx1YBVzHIHlScTz/WT+YYUam7yyw8fv+/5qhVtunWba735tkNxC0Xx2ab8aYqO13PD6FbM0Dt3xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743906676; c=relaxed/simple;
	bh=AwhulNA2OU/T8auYLPhdGeFKiFceZQEpi7Kn4mlaTNA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=s7JlcypAm2AvSc8K/sDbazTh/KHJkmJHMycjRM9VWa9EBFME+x4FpyIfB10NIk6AmVLnX1WrLaPqS2GKQ0Dvep8TtRQVB9O0WO7e6kS7Y99JJ9nupElS20tt/MD1u8gthtGalsIf1iFPdLUQUzzieOZMalH5PTv8PZHtzo9y0tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTniIvGO; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5240764f7c1so1354234e0c.2;
        Sat, 05 Apr 2025 19:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743906673; x=1744511473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AwhulNA2OU/T8auYLPhdGeFKiFceZQEpi7Kn4mlaTNA=;
        b=JTniIvGOlJWZfhM3hv/o6fOi1wg1KC8RMVOd761XyWNVSy1H7E8lqABcSRSPJrMiiX
         2YtYxCaEUyzKmi0qGMMnEMr/MLDVQNpHlklw6vPGe9r2lhA2l793XcYp4S4HQPf64oVd
         0f0Csex9lNIWusE+vuvLRhny9Z76/cRj7y6bkSCAiDKH+3ApkX2TL0pfI8ff3mGaz44n
         ZcVxilBl0cx7pneLM7gflRxTq5Sc0HyspbZC16uePIs/5ZRnI//R+ypa0Jkq2vf/iJzZ
         2/kQDMWMTqa71o3R8TL3TsNBGCBRRG96DhXRhPJpX7PEnKSIL1WVnBUUA0IeMbvoLho3
         uxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743906673; x=1744511473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AwhulNA2OU/T8auYLPhdGeFKiFceZQEpi7Kn4mlaTNA=;
        b=iinAF8isuMN0geeEgY6cI3n17XrbpHTkiRatcZv/otkWGifoO8Ulj/4/zjM2rYoGyy
         v3l0Imhdtii8gto1Sq/RhzYps9D8ltk4m+iug0EyliD5Ct6ROc/r9SfCtOLFQO8YChdW
         Tcnm5GIQyxQexl0H8Dfc/wpyAYT2DO75BWDC/rP9mCGMzwJm5E4hH0Q/eroBxVh9yX6d
         yuya6iWOf/q4mTAcaAVcT0e9JlKeTSBuqygKL3HREtcbpg1QW23i1gA7YpqqG5VsYrQT
         HvuXVPW68NWB5NSWXtBfMKg1baK6zsLDCKaZ1kvn5NRyAHC80xwGcKjdgMjjXt1PGIL7
         XP/g==
X-Forwarded-Encrypted: i=1; AJvYcCW9QiRHAwSnkBaV1zS2JmNoUntfMLRCXAyt1tjhgdDLHve09XC6sC1E3SwOCSqVvnvkMqj/2XHP@vger.kernel.org, AJvYcCXERlQHdRjLvQBE8tcpkg9Z0OQpuuUlmBJ32LK1A2ccfEXG5eeRgMHrC1haP7DpSnJ5UAsMfBxKs6lesp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf2FGjZqmaWY5Vg0EtDLWdDz0gFBImp++ggkXKTVkCm2g4PJ4i
	OrYpckxyLGOiPuonroATlCLUu5bE7lz1vz7pO63C8HuxAvb1viTFwUvhAG5An4YleNYgYWEPY33
	EJy3dSOfQKvTkfxiyWysv/oRWUGo=
X-Gm-Gg: ASbGnctwXF2KCp0anbT+UUzo23dcUDW1euhvfzgDzIsHTXPzTVr8+q0dsyzxWkqnzj6
	ekKPwox37ckE9n8MnMZcO26NEPwGY22/jce16GRmvzxxpTHMfIkZqll693yvRGBLnhdFsP2weiC
	4TCYu8X3zbm4vrRjqz6ftS3hDODSQ=
X-Google-Smtp-Source: AGHT+IFgL+LeFLO/kOk71unZniPAJxN2aWXsMiOStbz8QMA2/JA1jXdKyhCJIxFQ4BC81gJHVJiMYnAOtAqWbs5wvOY=
X-Received: by 2002:a05:6122:1e03:b0:520:3e1c:500f with SMTP id
 71dfb90a1353d-5276457162emr6176559e0c.8.1743906672706; Sat, 05 Apr 2025
 19:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hui Guo <guohui.study@gmail.com>
Date: Sun, 6 Apr 2025 10:31:00 +0800
X-Gm-Features: ATxdqUGROUGKHwhNTLlxBeM9EEfiDEB5TWT1E0mUyHBpalHmiXRzpbEqCaedQKI
Message-ID: <CAHOo4gK+tdU1B14Kh6tg-tNPqnQ1qGLfinONFVC43vmgEPnXXw@mail.gmail.com>
Subject: general protection fault in addrconf_add_ifaddr
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>
Cc: syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kernel Maintainers,
we found a crash "general protection fault in addrconf_add_ifaddr" (it
is a KASAN and makes the kernel reboot) in upstream, we also have
successfully reproduced it manually:

HEAD Commit: 9f867ba24d3665d9ac9d9ef1f51844eb4479b291
kernel config: https://raw.githubusercontent.com/androidAppGuard/KernelBugs=
/refs/heads/main/9f867ba24d3665d9ac9d9ef1f51844eb4479b291/.config

console output:
https://raw.githubusercontent.com/androidAppGuard/KernelBugs/refs/heads/mai=
n/9f867ba24d3665d9ac9d9ef1f51844eb4479b291/b4f94e7f408c53ff0bac07a7b69ecfe4=
8ab5575d/repro.log
repro report: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/=
refs/heads/main/9f867ba24d3665d9ac9d9ef1f51844eb4479b291/b4f94e7f408c53ff0b=
ac07a7b69ecfe48ab5575d/repro.report
syz reproducer:
https://raw.githubusercontent.com/androidAppGuard/KernelBugs/refs/heads/mai=
n/9f867ba24d3665d9ac9d9ef1f51844eb4479b291/b4f94e7f408c53ff0bac07a7b69ecfe4=
8ab5575d/repro.prog
c reproducer: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/=
refs/heads/main/9f867ba24d3665d9ac9d9ef1f51844eb4479b291/b4f94e7f408c53ff0b=
ac07a7b69ecfe48ab5575d/repro.cprog

Please let me know if there is anything I can help with.
Best,
Hui Guo

This is the crash log I got by reproducing the bug based on the above
environment=EF=BC=8C
I have piped this log through decode_stacktrace.sh to better
understand the cause of the bug.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
2025/04/06 02:22:59 parsed 1
programsa/ghui/docker_data/workdir/upstream/ghui_syzkaller_upstream_linux_6=
_upstream/crashes/b4f94e7f408c53ff0bac07a7b69ecfe48ab5575d/repro.prog
[ 86.179154][ T9592] Adding 124996k swap on ./swap-file. Priority:0
extents:1 across:124996k
[ 87.644012][ T60] audit: type=3D1400 audit(1743906187.305:14): avc:
denied { execmem } for pid=3D9608 comm=3D"syz-executor"
scontext=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
tcontext=3Dun1
[ 87.761387][ T5240] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > 1
[ 87.764562][ T5240] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > 9
[ 87.765968][ T5240] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > 9
[ 87.767698][ T5240] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > 4
[ 87.772260][ T5240] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > 2
[ 88.154097][ T60] audit: type=3D1401 audit(1743906187.815:15):
op=3Dsetxattr invalid_context=3D"u:object_r:app_data_file:s0:c512,c768"
[ 88.319741][ T12] wlan0: Created IBSS using preconfigured BSSID
50:50:50:50:50:50
[ 88.320838][ T12] wlan0: Creating new IBSS network, BSSID 50:50:50:50:50:5=
0
[ 88.377747][ T9629] chnl_net:caif_netlink_parms(): no params data found
[ 88.377904][ T1155] wlan1: Created IBSS using preconfigured BSSID
50:50:50:50:50:50
[ 88.379844][ T1155] wlan1: Creating new IBSS network, BSSID 50:50:50:50:50=
:50
[ 88.457479][ T9629] bridge0: port 1(bridge_slave_0) entered blocking state
[ 88.458808][ T9629] bridge0: port 1(bridge_slave_0) entered disabled state
[ 88.459788][ T9629] bridge_slave_0: entered allmulticast mode
[ 88.461242][ T9629] bridge_slave_0: entered promiscuous mode
[ 88.463760][ T9629] bridge0: port 2(bridge_slave_1) entered blocking state
[ 88.464785][ T9629] bridge0: port 2(bridge_slave_1) entered disabled state
[ 88.465822][ T9629] bridge_slave_1: entered allmulticast mode
[ 88.468044][ T9629] bridge_slave_1: entered promiscuous mode
[ 88.502986][ T9629] bond0: (slave bond_slave_0): Enslaving as an
active interface with an up link
[ 88.505841][ T9629] bond0: (slave bond_slave_1): Enslaving as an
active interface with an up link
[ 88.543640][ T9629] team0: Port device team_slave_0 added
[ 88.545637][ T9629] team0: Port device team_slave_1 added
[ 88.581650][ T9629] batman_adv: batadv0: Adding interface: batadv_slave_0
[ 88.582413][ T9629] batman_adv: batadv0: The MTU of interface
batadv_slave_0 is too small (1500) to handle the transport of
batman-adv packets. Packets going over this interface will be
fragmented .
[ 88.585340][ T9629] batman_adv: batadv0: Not using interface
batadv_slave_0 (retrying later): interface not active
[ 88.590220][ T9629] batman_adv: batadv0: Adding interface: batadv_slave_1
[ 88.591134][ T9629] batman_adv: batadv0: The MTU of interface
batadv_slave_1 is too small (1500) to handle the transport of
batman-adv packets. Packets going over this interface will be
fragmented .
[ 88.594386][ T9629] batman_adv: batadv0: Not using interface
batadv_slave_1 (retrying later): interface not active
[ 88.642273][ T9629] hsr_slave_0: entered promiscuous mode
[ 88.643637][ T9629] hsr_slave_1: entered promiscuous mode
[ 88.804702][ T9629] netdevsim netdevsim9 netdevsim0: renamed from eth0
[ 88.810111][ T9629] netdevsim netdevsim9 netdevsim1: renamed from eth1
[ 88.813180][ T9629] netdevsim netdevsim9 netdevsim2: renamed from eth2
[ 88.815381][ T9629] netdevsim netdevsim9 netdevsim3: renamed from eth3
[ 88.828851][ T9629] bridge0: port 2(bridge_slave_1) entered blocking state
[ 88.829814][ T9629] bridge0: port 2(bridge_slave_1) entered forwarding sta=
te
[ 88.830877][ T9629] bridge0: port 1(bridge_slave_0) entered blocking state
[ 88.831656][ T9629] bridge0: port 1(bridge_slave_0) entered forwarding sta=
te
[ 88.861702][ T9629] 8021q: adding VLAN 0 to HW filter on device bond0
[ 88.874562][T10046] bridge0: port 1(bridge_slave_0) entered disabled state
[ 88.876863][T10046] bridge0: port 2(bridge_slave_1) entered disabled state
[ 88.889439][ T9629] 8021q: adding VLAN 0 to HW filter on device team0
[ 88.894746][ T96] bridge0: port 1(bridge_slave_0) entered blocking state
[ 88.895679][ T96] bridge0: port 1(bridge_slave_0) entered forwarding state
[ 88.900531][ T96] bridge0: port 2(bridge_slave_1) entered blocking state
[ 88.901442][ T96] bridge0: port 2(bridge_slave_1) entered forwarding state
[ 89.014295][ T9629] 8021q: adding VLAN 0 to HW filter on device batadv0
[ 89.153586][ T9629] veth0_vlan: entered promiscuous mode
[ 89.157428][ T9629] veth1_vlan: entered promiscuous mode
[ 89.173404][ T9629] veth0_macvtap: entered promiscuous mode
[ 89.176012][ T9629] veth1_macvtap: entered promiscuous mode
[ 89.184642][ T9629] batman_adv: batadv0: Interface activated: batadv_slave=
_0
[ 89.193218][ T9629] batman_adv: batadv0: Interface activated: batadv_slave=
_1
[ 89.197719][ T9629] netdevsim netdevsim9 netdevsim0: set [1, 0] type
2 family 0 port 6081 - 0
[ 89.200444][ T9629] netdevsim netdevsim9 netdevsim1: set [1, 0] type
2 family 0 port 6081 - 0
[ 89.202146][ T9629] netdevsim netdevsim9 netdevsim2: set [1, 0] type
2 family 0 port 6081 - 0
[ 89.203812][ T9629] netdevsim netdevsim9 netdevsim3: set [1, 0] type
2 family 0 port 6081 - 0
2025/04/06 02:23:08 executed programs: 0
[ 89.301312][ T87] Bluetooth: hci1: unexpected cc 0x0c03 length: 249 > 1
[ 89.303336][ T87] Bluetooth: hci1: unexpected cc 0x1003 length: 249 > 9
[ 89.304722][ T87] Bluetooth: hci1: unexpected cc 0x1001 length: 249 > 9
[ 89.306642][ T87] Bluetooth: hci1: unexpected cc 0x0c23 length: 249 > 4
[ 89.310004][ T87] Bluetooth: hci1: unexpected cc 0x0c38 length: 249 > 2
[ 89.409170][T11015] chnl_net:caif_netlink_parms(): no params data found
[ 89.483073][T11015] bridge0: port 1(bridge_slave_0) entered blocking state
[ 89.484753][T11015] bridge0: port 1(bridge_slave_0) entered disabled state
[ 89.486427][T11015] bridge_slave_0: entered allmulticast mode
[ 89.489542][T11015] bridge_slave_0: entered promiscuous mode
[ 89.494571][T11015] bridge0: port 2(bridge_slave_1) entered blocking state
[ 89.496212][T11015] bridge0: port 2(bridge_slave_1) entered disabled state
[ 89.497273][T11015] bridge_slave_1: entered allmulticast mode
[ 89.500140][T11015] bridge_slave_1: entered promiscuous mode
[ 89.538296][T11015] bond0: (slave bond_slave_0): Enslaving as an
active interface with an up link
[ 89.541739][T11015] bond0: (slave bond_slave_1): Enslaving as an
active interface with an up link
[ 89.580396][T11015] team0: Port device team_slave_0 added
[ 89.584584][T11015] team0: Port device team_slave_1 added
[ 89.625746][T11015] batman_adv: batadv0: Adding interface: batadv_slave_0
[ 89.626548][T11015] batman_adv: batadv0: The MTU of interface
batadv_slave_0 is too small (1500) to handle the transport of
batman-adv packets. Packets going over this interface will be
fragmented .
[ 89.629609][T11015] batman_adv: batadv0: Not using interface
batadv_slave_0 (retrying later): interface not active
[ 89.631614][T11015] batman_adv: batadv0: Adding interface: batadv_slave_1
[ 89.632399][T11015] batman_adv: batadv0: The MTU of interface
batadv_slave_1 is too small (1500) to handle the transport of
batman-adv packets. Packets going over this interface will be
fragmented .
[ 89.635213][T11015] batman_adv: batadv0: Not using interface
batadv_slave_1 (retrying later): interface not active
[ 89.668575][T11015] hsr_slave_0: entered promiscuous mode
[ 89.669594][T11015] hsr_slave_1: entered promiscuous mode
[ 89.670548][T11015] debugfs: Directory 'hsr0' with parent 'hsr'
already present!
[ 89.671508][T11015] Cannot create hsr debugfs directory
[ 89.780189][T11015] netdevsim netdevsim0 netdevsim0: renamed from eth0
[ 89.783028][T11015] netdevsim netdevsim0 netdevsim1: renamed from eth1
[ 89.785272][T11015] netdevsim netdevsim0 netdevsim2: renamed from eth2
[ 89.788202][T11015] netdevsim netdevsim0 netdevsim3: renamed from eth3
[ 89.803525][T11015] bridge0: port 2(bridge_slave_1) entered blocking state
[ 89.804338][T11015] bridge0: port 2(bridge_slave_1) entered forwarding sta=
te
[ 89.805684][T11015] bridge0: port 1(bridge_slave_0) entered blocking state
[ 89.806484][T11015] bridge0: port 1(bridge_slave_0) entered forwarding sta=
te
[ 89.848614][T11015] 8021q: adding VLAN 0 to HW filter on device bond0
[ 89.860220][ T5240] Bluetooth: hci0: command tx timeout
[ 89.863306][T10046] bridge0: port 1(bridge_slave_0) entered disabled state
[ 89.864964][T10046] bridge0: port 2(bridge_slave_1) entered disabled state
[ 89.875376][T11015] 8021q: adding VLAN 0 to HW filter on device team0
[ 89.884670][T10046] bridge0: port 1(bridge_slave_0) entered blocking state
[ 89.886327][T10046] bridge0: port 1(bridge_slave_0) entered forwarding sta=
te
[ 89.892937][ T1155] bridge0: port 2(bridge_slave_1) entered blocking state
[ 89.894576][ T1155] bridge0: port 2(bridge_slave_1) entered forwarding sta=
te
[ 90.024333][T11015] 8021q: adding VLAN 0 to HW filter on device batadv0
[ 90.055011][T11015] veth0_vlan: entered promiscuous mode
[ 90.058720][T11015] veth1_vlan: entered promiscuous mode
[ 90.075111][T11015] veth0_macvtap: entered promiscuous mode
[ 90.077489][T11015] veth1_macvtap: entered promiscuous mode
[ 90.083799][T11015] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3e) already exists on: batadv_slave_0
[ 90.085087][T11015] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[ 90.086999][T11015] batman_adv: batadv0: Interface activated: batadv_slave=
_0
[ 90.094388][T11015] batman_adv: The newly added mac address
(aa:aa:aa:aa:aa:3f) already exists on: batadv_slave_1
[ 90.095512][T11015] batman_adv: It is strongly recommended to keep
mac addresses unique to avoid problems!
[ 90.097413][T11015] batman_adv: batadv0: Interface activated: batadv_slave=
_1
[ 90.100436][T11015] netdevsim netdevsim0 netdevsim0: set [1, 0] type
2 family 0 port 6081 - 0
[ 90.101419][T11015] netdevsim netdevsim0 netdevsim1: set [1, 0] type
2 family 0 port 6081 - 0
[ 90.102363][T11015] netdevsim netdevsim0 netdevsim2: set [1, 0] type
2 family 0 port 6081 - 0
[ 90.103306][T11015] netdevsim netdevsim0 netdevsim3: set [1, 0] type
2 family 0 port 6081 - 0
[ 90.136521][ T12] wlan0: Created IBSS using preconfigured BSSID
50:50:50:50:50:50
[ 90.137631][ T12] wlan0: Creating new IBSS network, BSSID 50:50:50:50:50:5=
0
[ 90.150925][ T98] wlan1: Created IBSS using preconfigured BSSID
50:50:50:50:50:50
[ 90.152068][ T98] wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:5=
0
[ 90.201985][T12032] Oops: general protection fault, probably for
non-canonical address 0xdffffc0000000198: 0000 [#1] SMP KASAN NOPTI
[ 90.204525][T12032] KASAN: null-ptr-deref in range
[0x0000000000000cc0-0x0000000000000cc7]
[ 90.206275][T12032] CPU: 3 UID: 0 PID: 12032 Comm: syz.0.15 Not
tainted 6.14.0-13408-g9f867ba24d36 #1 PREEMPT(full)
[ 90.208522][T12032] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.15.0-1 04/01/2014
[90.210452][T12032] RIP: 0010:addrconf_add_ifaddr
(/data/ghui/docker_data/linux_kernel/upstream/linux/./include/net/netdev_lo=
ck.h:30
/data/ghui/docker_data/linux_kernel/upstream/linux/./include/net/netdev_loc=
k.h:41
/data/ghui/docker_data/linux_kernel/upstream/linux/net/ipv6/addrconf.c:3157=
)
[ 90.211725][T12032] Code: 8b b4 24 94 00 00 00 4c 89 ef e8 7e 4c 2f
ff 4c 8d b0 c5 0c 00 00 48 89 c3 48 b8 00 00 00 00 00 fc ff df 4c 89
f2 48 c1 ea 03 <0f> b6 04 02 4c 89 f2 83 e2 07 38 d0 7f 08 80
All code
=3D=3D=3D=3D=3D=3D=3D=3D
0: 8b b4 24 94 00 00 00 mov 0x94(%rsp),%esi
7: 4c 89 ef mov %r13,%rdi
a: e8 7e 4c 2f ff call 0xffffffffff2f4c8d
f: 4c 8d b0 c5 0c 00 00 lea 0xcc5(%rax),%r14
16: 48 89 c3 mov %rax,%rbx
19: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
20: fc ff df
23: 4c 89 f2 mov %r14,%rdx
26: 48 c1 ea 03 shr $0x3,%rdx
2a:* 0f b6 04 02 movzbl (%rdx,%rax,1),%eax <-- trapping instruction
2e: 4c 89 f2 mov %r14,%rdx
31: 83 e2 07 and $0x7,%edx
34: 38 d0 cmp %dl,%al
36: 7f 08 jg 0x40
38: 80 .byte 0x80

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
0: 0f b6 04 02 movzbl (%rdx,%rax,1),%eax
4: 4c 89 f2 mov %r14,%rdx
7: 83 e2 07 and $0x7,%edx
a: 38 d0 cmp %dl,%al
c: 7f 08 jg 0x16
e: 80 .byte 0x80
[ 90.215834][T12032] RSP: 0018:ffffc90015b0faa0 EFLAGS: 00010213
[ 90.217134][T12032] RAX: dffffc0000000000 RBX: 0000000000000000 RCX:
0000000000000000
[ 90.218816][T12032] RDX: 0000000000000198 RSI: ffffffff893162f2 RDI:
ffff888078cb0338
[ 90.220520][T12032] RBP: ffffc90015b0fbb0 R08: 0000000000000000 R09:
fffffbfff20cbbe2
[ 90.222226][T12032] R10: ffffc90015b0faa0 R11: 0000000000000000 R12:
1ffff92002b61f54
[ 90.223921][T12032] R13: ffff888078cb0000 R14: 0000000000000cc5 R15:
ffff888078cb0000
[ 90.225617][T12032] FS: 00007f92559ed640(0000)
GS:ffff8882a8659000(0000) knlGS:0000000000000000
[ 90.227459][T12032] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 90.228725][T12032] CR2: 00007f92559ecfc8 CR3: 000000001c39e000 CR4:
00000000000006f0
[ 90.230303][T12032] Call Trace:
[ 90.230937][T12032] <TASK>
[90.231510][T12032] ? __pfx_addrconf_add_ifaddr
(/data/ghui/docker_data/linux_kernel/upstream/linux/net/ipv6/addrconf.c:313=
6)
[90.232367][T12032] ? __pfx_avc_has_extended_perms
(/data/ghui/docker_data/linux_kernel/upstream/linux/security/selinux/avc.c:=
1022)
[90.233023][T12032] inet6_ioctl
(/data/ghui/docker_data/linux_kernel/upstream/linux/net/ipv6/af_inet6.c:580=
)
[90.233514][T12032] ? __pfx_inet6_ioctl
(/data/ghui/docker_data/linux_kernel/upstream/linux/net/ipv6/af_inet6.c:564=
)
[90.234061][T12032] ? tomoyo_path_number_perm
(/data/ghui/docker_data/linux_kernel/upstream/linux/./include/linux/srcu.h:=
167
/data/ghui/docker_data/linux_kernel/upstream/linux/./include/linux/srcu.h:4=
02
/data/ghui/docker_data/linux_kernel/upstream/linux/security/tomoyo/common.h=
:1120
/data/ghui/docker_data/linux_kernel/upstream/linux/security/tomoyo/file.c:7=
38)
[90.234685][T12032] ? tomoyo_path_number_perm
(/data/ghui/docker_data/linux_kernel/upstream/linux/security/tomoyo/file.c:=
710)
[90.235320][T12032] ? __pfx_tomoyo_path_number_perm
(/data/ghui/docker_data/linux_kernel/upstream/linux/security/tomoyo/file.c:=
710)
[90.235977][T12032] ? __sanitizer_cov_trace_switch
(/data/ghui/docker_data/linux_kernel/upstream/linux/kernel/kcov.c:350
(discriminator 3))
[90.236626][T12032] sock_do_ioctl
(/data/ghui/docker_data/linux_kernel/upstream/linux/net/socket.c:1196)
[90.237134][T12032] ? __pfx_sock_do_ioctl
(/data/ghui/docker_data/linux_kernel/upstream/linux/net/socket.c:1182)
[90.237704][T12032] ? ioctl_has_perm.constprop.0.isra.0
(/data/ghui/docker_data/linux_kernel/upstream/linux/security/selinux/hooks.=
c:3698)
[90.238428][T12032] ? ioctl_has_perm.constprop.0.isra.0
(/data/ghui/docker_data/linux_kernel/upstream/linux/security/selinux/hooks.=
c:3667)
[90.239140][T12032] ? __pfx_ioctl_has_perm.constprop.0.isra.0
(/data/ghui/docker_data/linux_kernel/upstream/linux/security/selinux/hooks.=
c:3667)
[90.239884][T12032] sock_ioctl
(/data/ghui/docker_data/linux_kernel/upstream/linux/net/socket.c:1314)
[90.240370][T12032] ? __pfx_sock_ioctl
(/data/ghui/docker_data/linux_kernel/upstream/linux/net/socket.c:1218)
[90.240903][T12032] ? hook_file_ioctl_common
(/data/ghui/docker_data/linux_kernel/upstream/linux/security/landlock/fs.c:=
1757)
[90.241515][T12032] ? selinux_file_ioctl
(/data/ghui/docker_data/linux_kernel/upstream/linux/security/selinux/hooks.=
c:3746)
[90.242087][T12032] ? selinux_file_ioctl
(/data/ghui/docker_data/linux_kernel/upstream/linux/security/selinux/hooks.=
c:3749)
[90.242627][T12032] ? __pfx_sock_ioctl
(/data/ghui/docker_data/linux_kernel/upstream/linux/net/socket.c:1218)
[90.243148][T12032] __x64_sys_ioctl
(/data/ghui/docker_data/linux_kernel/upstream/linux/fs/ioctl.c:52
/data/ghui/docker_data/linux_kernel/upstream/linux/fs/ioctl.c:906
/data/ghui/docker_data/linux_kernel/upstream/linux/fs/ioctl.c:892
/data/ghui/docker_data/linux_kernel/upstream/linux/fs/ioctl.c:892)
[90.243660][T12032] do_syscall_64
(/data/ghui/docker_data/linux_kernel/upstream/linux/arch/x86/entry/syscall_=
64.c:63
/data/ghui/docker_data/linux_kernel/upstream/linux/arch/x86/entry/syscall_6=
4.c:94)
[90.244146][T12032] entry_SYSCALL_64_after_hwframe
(/data/ghui/docker_data/linux_kernel/upstream/linux/arch/x86/entry/entry_64=
.S:130)
[ 90.244768][T12032] RIP: 0033:0x7f9254b9c62d
[ 90.245246][T12032] Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3
0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff f8
All code
=3D=3D=3D=3D=3D=3D=3D=3D
0: 02 b8 ff ff ff ff add -0x1(%rax),%bh
6: c3 ret
7: 66 0f 1f 44 00 00 nopw 0x0(%rax,%rax,1)
d: f3 0f 1e fa endbr64
11: 48 89 f8 mov %rdi,%rax
14: 48 89 f7 mov %rsi,%rdi
17: 48 89 d6 mov %rdx,%rsi
1a: 48 89 ca mov %rcx,%rdx
1d: 4d 89 c2 mov %r8,%r10
20: 4d 89 c8 mov %r9,%r8
23: 4c 8b 4c 24 08 mov 0x8(%rsp),%r9
28: 0f 05 syscall
2a:* 48 3d 01 f0 ff ff cmp $0xfffffffffffff001,%rax <-- trapping instructio=
n
30: 73 01 jae 0x33
32: c3 ret
33: 48 rex.W
34: c7 .byte 0xc7
35: c1 .byte 0xc1
36: a8 ff test $0xff,%al
38: f8 clc

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
0: 48 3d 01 f0 ff ff cmp $0xfffffffffffff001,%rax
6: 73 01 jae 0x9
8: c3 ret
9: 48 rex.W
a: c7 .byte 0xc7
b: c1 .byte 0xc1
c: a8 ff test $0xff,%al
e: f8 clc
[ 90.247261][T12032] RSP: 002b:00007f92559ecf98 EFLAGS: 00000246
ORIG_RAX: 0000000000000010
[ 90.248137][T12032] RAX: ffffffffffffffda RBX: 00007f9254d65f80 RCX:
00007f9254b9c62d
[ 90.248957][T12032] RDX: 0000000020000040 RSI: 0000000000008916 RDI:
0000000000000003
[ 90.249802][T12032] RBP: 00007f9254c264d3 R08: 0000000000000000 R09:
0000000000000000
[ 90.250634][T12032] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000000000
[ 90.251467][T12032] R13: 0000000000000000 R14: 00007f9254d65f80 R15:
00007f92559cd000
[ 90.252306][T12032] </TASK>
[ 90.252630][T12032] Modules linked in:
[ 90.253206][T12032] ---[ end trace 0000000000000000 ]---
[90.254158][T12032] RIP: 0010:addrconf_add_ifaddr
(/data/ghui/docker_data/linux_kernel/upstream/linux/./include/net/netdev_lo=
ck.h:30
/data/ghui/docker_data/linux_kernel/upstream/linux/./include/net/netdev_loc=
k.h:41
/data/ghui/docker_data/linux_kernel/upstream/linux/net/ipv6/addrconf.c:3157=
)
[ 90.255906][T12032] Code: 8b b4 24 94 00 00 00 4c 89 ef e8 7e 4c 2f
ff 4c 8d b0 c5 0c 00 00 48 89 c3 48 b8 00 00 00 00 00 fc ff df 4c 89
f2 48 c1 ea 03 <0f> b6 04 02 4c 89 f2 83 e2 07 38 d0 7f 08 80
All code
=3D=3D=3D=3D=3D=3D=3D=3D
0: 8b b4 24 94 00 00 00 mov 0x94(%rsp),%esi
7: 4c 89 ef mov %r13,%rdi
a: e8 7e 4c 2f ff call 0xffffffffff2f4c8d
f: 4c 8d b0 c5 0c 00 00 lea 0xcc5(%rax),%r14
16: 48 89 c3 mov %rax,%rbx
19: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
20: fc ff df
23: 4c 89 f2 mov %r14,%rdx
26: 48 c1 ea 03 shr $0x3,%rdx
2a:* 0f b6 04 02 movzbl (%rdx,%rax,1),%eax <-- trapping instruction
2e: 4c 89 f2 mov %r14,%rdx
31: 83 e2 07 and $0x7,%edx
34: 38 d0 cmp %dl,%al
36: 7f 08 jg 0x40
38: 80 .byte 0x80

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
0: 0f b6 04 02 movzbl (%rdx,%rax,1),%eax
4: 4c 89 f2 mov %r14,%rdx
7: 83 e2 07 and $0x7,%edx
a: 38 d0 cmp %dl,%al
c: 7f 08 jg 0x16
e: 80 .byte 0x80
[ 90.261730][T12032] RSP: 0018:ffffc90015b0faa0 EFLAGS: 00010213
[ 90.263435][T12032] RAX: dffffc0000000000 RBX: 0000000000000000 RCX:
0000000000000000
[ 90.265534][T12032] RDX: 0000000000000198 RSI: ffffffff893162f2 RDI:
ffff888078cb0338
[ 90.267919][T12032] RBP: ffffc90015b0fbb0 R08: 0000000000000000 R09:
fffffbfff20cbbe2
[ 90.270260][T12032] R10: ffffc90015b0faa0 R11: 0000000000000000 R12:
1ffff92002b61f54
[ 90.271462][T12032] R13: ffff888078cb0000 R14: 0000000000000cc5 R15:
ffff888078cb0000
[ 90.272695][T12032] FS: 00007f92559ed640(0000)
GS:ffff888124f59000(0000) knlGS:0000000000000000
[ 90.274114][T12032] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 90.275136][T12032] CR2: 00007fb4e404b0b8 CR3: 000000001c39e000 CR4:
00000000000006f0
[ 90.276353][T12032] Kernel panic - not syncing: Fatal exception
[ 90.277599][T12032] Kernel Offset: disabled
[ 90.278172][T12032] Rebooting in 86400 seconds..

