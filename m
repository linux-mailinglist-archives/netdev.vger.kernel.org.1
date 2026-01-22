Return-Path: <netdev+bounces-252472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Gl/DbdjcmnfjQAAu9opvQ
	(envelope-from <netdev+bounces-252472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:51:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B946BB70
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D271230461FF
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1BB39F305;
	Thu, 22 Jan 2026 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNejOcli"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB38939DB2C
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 17:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102861; cv=none; b=jS75B+IVli6MRSYOWtWTlXZTd4WFqEpKcOs5hcbzS23g9EtZ4ydIEcjufmG1OTSgPKfE4B06UYfAJzO21dZ84rEU13Jch5Yh/qcTDWpqqu0DVNZU9yG14jsZCbQGHBXDdgwcyqXQQi4ozXP4EG8zn4EiMjeBabKMiesYBUlDRQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102861; c=relaxed/simple;
	bh=P2LmFR/1lNTDWed6Kwb0r0Dj8rgTd9DF8cR6dkRZvjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vphy0kR3mJW1LrstxYFIlw1wwHGQbQb7LiSix9TMcl2eD1i6d7yhk/fNmjJalJnH3EHMYQSvYZx9h3Q0lgfYhjZdl+sG0Iw1uiw9+zbaDjFLx4+qS3vvB8p7BlBO8mR7tdcWXoSJwevd0FUj1kzfu9mw3KVbXCLOb7rd87U2ZJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNejOcli; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82307c6902eso467108b3a.3
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 09:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769102838; x=1769707638; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6FjiB0Oi1wVx2cBUZqy0hA9HzDbubTG2p8tSCMTjH8w=;
        b=XNejOcliwh5r12CAZ9L3Gf7YwzHo391K26v2DohVVsSK8Ydfg+0az4VFoR2YXGa/PX
         CsXEnavZtHVFrgN4mrKo6+zrSB0pi3rSD6Vh8N5iqq+gKboNrFikFgE8lhHyZ9Qh4X3d
         cumtP6g3bTqaT0Ofl/18OhxVZOr+SEN/eCerB7zq4YYx+tM7HOfg7WPbbK7nqFcNCMHz
         Utt/EX/OuhovWZe84YCiC8S3SGsJy+fyRlKPajb/+vMEcQAT36DOr1ijuPNcpDFQJNBS
         xb1p2aHljChUyRG/s8mHEEMoHKGbcniJCMJosbHj+kSd2h+4cBvWEjDVTel3lW/oxPEG
         BPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769102838; x=1769707638;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6FjiB0Oi1wVx2cBUZqy0hA9HzDbubTG2p8tSCMTjH8w=;
        b=p/oPQvMUShRd1xpuuspBCObIp/h48kkUhljN1NHXjkxdPZrBypUGEbtBKUWXxllnfk
         lA8q5tVjy86dwTfWykFAsIL5WNtMOyhaTB7zGFXjtAV7O02rEM3c2akCYQaPYvPgRNr1
         LktVpzuU/PE+p/LnXI1p/CnO3gi903HsUmkxZGMp7zB8MFRpasKjVDEANuPIrrn3v0xy
         vt0gfPqJcA5BnrYh7qnV+MQ714gXxiJhcRV2uNx0+I3rx6oLe9+Jmg/NmSapgt5hZjgJ
         tK5MmJ2dbCFE9McKxNZfPZjrDSsHaOxObnT5x31RbWpbpvu1vp+/iJPN/q9kF1KS8ACA
         gieg==
X-Forwarded-Encrypted: i=1; AJvYcCXzBlFkxabrpbUeQsc2XW6dYU1KFg0dJ+jQTJlLEiRskbr0TLbKAnHsUHBfN0NuyzN9bgS0syI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsxAjI1VrXhwjFLsyuJ8zDFUWSgdcCuhLNw+VdyC+fU8YNb7Jm
	Taq9WA/MRv1eS9LykrqZthyypLT51lhVyx9u+3E6yfXhYkMYip/RH0Ms
X-Gm-Gg: AZuq6aImdzN6qkWcwlZsHqwY9t2iDNYqeDz/SOUvpg8od91RYXLfLm7X1Tj1nCcgCMK
	ja3/7s0f2V7KL0MqgQpivr7gK2v2IHzvGgycQD2jdNOJb3OKYJbmk1wx8KLpy7ysR8Jabx/XKvQ
	Py1Va29vOtV++6bFfs5Z8jdmqVr1+DxtRdlWGqpCE2rP4PM53YV9H4IXtXacR+rZ6Z4tdA5Pdro
	xTN4+lp6vEOYgBV7vlXkHLP57JchYsBIvyYDU6aBzoaycVhzg8ZLocqojO/iYJhFckioxKwi2Ev
	r0yTQ3IWVOhA9XQdXFkAiGHC8eTtxQLuu3exBpM7hfibMVBekUfEdpiR08rnmpoIOq0McB8DfWO
	Np2JL3YqFCSJhGdvYzA9NtK717638Hh7w3KiFVy+Xc1X9MBUsvU/9G0jEMepg6a6OYDNAvWC2zU
	psELKhnQU/ne0wesqUzbUphw==
X-Received: by 2002:a05:6a00:1493:b0:81f:41c8:765a with SMTP id d2e1a72fcca58-82317c0fbb4mr72997b3a.4.1769102838253;
        Thu, 22 Jan 2026 09:27:18 -0800 (PST)
Received: from inspiron ([111.125.231.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1277966sm18581581b3a.31.2026.01.22.09.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 09:27:17 -0800 (PST)
Date: Thu, 22 Jan 2026 22:57:08 +0530
From: Prithvi <activprithvi@gmail.com>
To: F6BVP <f6bvp@free.fr>
Cc: dranch@trinnet.net, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+3f2d46b6e62b8dd546d3@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: Testing for netrom: fix memory leak in nr_add_node
Message-ID: <20260122172708.hsqi3c42xavrmpkk@inspiron>
References: <20260117142632.180941-1-activprithvi@gmail.com>
 <f108f1f4-cdd3-4b14-ad24-d1ef328ca316@free.fr>
 <46f8fefa-f549-0b8b-d37e-0d608c5ee5f6@trinnet.net>
 <20260120160008.2kylsycgrpzcwvak@inspiron>
 <7aa6b5cb-a062-47f2-bada-2e796d3f8654@free.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7aa6b5cb-a062-47f2-bada-2e796d3f8654@free.fr>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252472-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[free.fr];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[activprithvi@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,3f2d46b6e62b8dd546d3];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42B946BB70
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 10:02:49PM +0100, F6BVP wrote:
>=20
>=20
> Le 20/01/2026 =E0 17:00, Prithvi a =E9crit=A0:
> > Hello Bernard and David,
> >=20
> > Thank you very much for your feedback. I sincerely apologize for the
> > instability caused due to this patch. I take this instability very
> > seriously.
> >=20
> > Unfortunately I am on a low-end backup system right now which does not =
have
> > resources to build or boot custom kernels effectively, locally. That's =
why,
> > it has been difficult for me to test the patch locally due to which I h=
ave
> > been relying on syzbot for testing. I am grateful for your feedback by
> > testing that patch on your setup.
> >=20
> > I will work on investigating further why the kernel isn't stable with t=
his
> > patch and try to create a better fix for this bug.
> >=20
> > Thanks a lot Bernard for testing this patch. In case you get any crash
> > dump or similar information, it would be very helpful to understand the=
 issue
> > and fix it.
> >=20
> > Thank you very much and best regards,
> > Prithvi
> >=20
> Hi Prithvi,
>=20
> Your effort in improving netrom protocole AX25 is appreciated.
> I reactivated netconsole between my two ROSE FPAC nodes machines in order=
 to
> catch kernel panic triggered by adding your line of patch.
>=20
> Regards,
>=20
> Bernard, f6bvp

>=20
>=20
> 6,1306,1249564798,-;NET: Registered PF_AX25 protocol family
> 6,1307,1249581517,-;mkiss: AX.25 Multikiss, Hans Albas PE1AYX
> 6,1308,1249627212,-;NET: Registered PF_ROSE protocol family
> 6,1309,1252718950,-;mkiss: AX.25 Multikiss, Hans Albas PE1AYX
> 6,1310,1252721666,-;mkiss: ax0: crc mode is auto.
> 6,1311,1254808312,-;NET: Registered PF_NETROM protocol family
> 6,1312,1266780331,-;mkiss: ax0: Trying crc-smack
> 6,1313,1266782411,-;mkiss: ax0: Trying crc-flexnet
> 3,1314,2553484762,-;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 3,1315,2553485598,-;BUG: KASAN: slab-use-after-free in nr_rt_ioctl+0x2073=
/0x2d20 [netrom]
> 3,1316,2553486313,-;Read of size 2 at addr ffff88811bc50e32 by task netro=
md/4776
> 3,1317,2553486860,-;
> 3,1318,2553487398,-;CPU: 1 UID: 0 PID: 4776 Comm: netromd Not tainted 6.1=
9.0-rc5-f6bvp+ #50 PREEMPT(voluntary)=20
> 3,1319,2553487403,-;Hardware name: To be filled by O.E.M. To be filled by=
 O.E.M./CK3, BIOS 5.011 09/16/2020
> 3,1320,2553487406,-;Call Trace:
> 3,1321,2553487407,-; <TASK>
> 3,1322,2553487409,-; dump_stack_lvl+0x5f/0x90
> 3,1323,2553487415,-; print_report+0x171/0x4f5
> 3,1324,2553487420,-; ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> 3,1325,2553487425,-; ? sched_clock_noinstr+0x9/0x10
> 3,1326,2553487430,-; ? kasan_complete_mode_report_info+0x88/0x230
> 3,1327,2553487437,-; kasan_report+0xf2/0x130
> 3,1328,2553487440,-; ? nr_rt_ioctl+0x2073/0x2d20 [netrom]
> 3,1329,2553487447,-; ? nr_rt_ioctl+0x2073/0x2d20 [netrom]
> 3,1330,2553487453,-; __asan_report_load2_noabort+0x14/0x30
> 3,1331,2553487457,-; nr_rt_ioctl+0x2073/0x2d20 [netrom]
> 3,1332,2553487465,-; ? __pfx_nr_rt_ioctl+0x10/0x10 [netrom]
> 3,1333,2553487471,-; ? try_to_merge_with_ksm_page+0x170/0x2b0
> 3,1334,2553487476,-; ? apparmor_capable+0x159/0x470
> 3,1335,2553487482,-; ? security_capable+0x95/0x1c0
> 3,1336,2553487488,-; nr_ioctl+0x12d/0x290 [netrom]
> 3,1337,2553487493,-; ? alloc_empty_file+0xad/0x160
> 3,1338,2553487498,-; sock_do_ioctl+0x114/0x230
> 3,1339,2553487504,-; ? alloc_file_pseudo+0x163/0x230
> 3,1340,2553487507,-; ? __pfx_sock_do_ioctl+0x10/0x10
> 3,1341,2553487511,-; ? __pfx_alloc_file_pseudo+0x10/0x10
> 3,1342,2553487514,-; ? security_socket_post_create+0x78/0x200
> 3,1343,2553487519,-; ? __pfx_do_vfs_ioctl+0x10/0x10
> 3,1344,2553487525,-; ? sock_alloc_file+0xe2/0x220
> 3,1345,2553487529,-; sock_ioctl+0x3a6/0x640
> 3,1346,2553487532,-; ? __pfx_fput_close_sync+0x10/0x10
> 3,1347,2553487535,-; ? __pfx___sys_socket+0x10/0x10
> 3,1348,2553487538,-; ? __pfx_sock_ioctl+0x10/0x10
> 3,1349,2553487541,-; ? __kasan_check_read+0x11/0x20
> 3,1350,2553487545,-; ? hook_file_ioctl+0x10/0x20
> 3,1351,2553487550,-; __x64_sys_ioctl+0x147/0x1e0
> 3,1352,2553487554,-; x64_sys_call+0x1060/0x2360
> 3,1353,2553487558,-; do_syscall_64+0x82/0x5d0
> 3,1354,2553487561,-; ? __fput+0x554/0xaa0
> 3,1355,2553487565,-; ? fput_close_sync+0xe3/0x1b0
> 3,1356,2553487569,-; ? __pfx_fput_close_sync+0x10/0x10
> 3,1357,2553487573,-; ? __kasan_check_read+0x11/0x20
> 3,1358,2553487576,-; ? fpregs_assert_state_consistent+0x5c/0x100
> 3,1359,2553487581,-; ? do_syscall_64+0xbf/0x5d0
> 3,1360,2553487584,-; ? ksys_read+0x104/0x240
> 3,1361,2553487587,-; ? __pfx_ksys_read+0x10/0x10
> 3,1362,2553487591,-; ? __kasan_check_read+0x11/0x20
> 3,1363,2553487595,-; ? fpregs_assert_state_consistent+0x5c/0x100
> 3,1364,2553487598,-; ? do_syscall_64+0xbf/0x5d0
> 3,1365,2553487601,-; ? exc_page_fault+0x95/0x100
> 3,1366,2553487605,-; entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 3,1367,2553487608,-;RIP: 0033:0x77cecd73287d
> 3,1368,2553487612,-;Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10=
 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f=
 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
> 3,1369,2553487615,-;RSP: 002b:00007fff83cb9d10 EFLAGS: 00000246 ORIG_RAX:=
 0000000000000010
> 3,1370,2553487620,-;RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000=
77cecd73287d
> 3,1371,2553487623,-;RDX: 00007fff83cb9dcc RSI: 00000000000089e2 RDI: 0000=
000000000005
> 3,1372,2553487625,-;RBP: 00007fff83cb9d60 R08: 0000000000000000 R09: 0000=
000000000000
> 3,1373,2553487627,-;R10: 0000000000000000 R11: 0000000000000246 R12: 0000=
000000000078
> 3,1374,2553487630,-;R13: 0000601de2d57a60 R14: 00007fff83cb9ef0 R15: 0000=
601dc3550159
> 3,1375,2553487634,-; </TASK>
> 3,1376,2553487635,-;
> 3,1377,2553522861,-;Allocated by task 4511 on cpu 3 at 1255.067864s:
> 4,1378,2553523540,-; kasan_save_stack+0x3a/0x70
> 4,1379,2553524231,-; kasan_save_track+0x18/0x70
> 4,1380,2553524918,-; kasan_save_alloc_info+0x39/0x60
> 4,1381,2553525593,-; __kasan_kmalloc+0xa9/0xd0
> 4,1382,2553526563,-; __kmalloc_cache_noprof+0x20b/0x5b0
> 4,1383,2553527209,-; nr_add_node+0x16b9/0x2f50 [netrom]
> 4,1384,2553527844,-; nr_rt_ioctl+0x13ee/0x2d20 [netrom]
> 4,1385,2553528464,-; nr_ioctl+0x12d/0x290 [netrom]
> 4,1386,2553529075,-; sock_do_ioctl+0x114/0x230
> 4,1387,2553529676,-; sock_ioctl+0x3a6/0x640
> 4,1388,2553530275,-; __x64_sys_ioctl+0x147/0x1e0
> 4,1389,2553530875,-; x64_sys_call+0x1060/0x2360
> 4,1390,2553531477,-; do_syscall_64+0x82/0x5d0
> 4,1391,2553532080,-; entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 3,1392,2553532683,-;
> 3,1393,2553533276,-;Freed by task 4776 on cpu 1 at 2553.484760s:
> 4,1394,2553533882,-; kasan_save_stack+0x3a/0x70
> 4,1395,2553534486,-; kasan_save_track+0x18/0x70
> 4,1396,2553535094,-; kasan_save_free_info+0x3b/0x70
> 4,1397,2553535700,-; __kasan_slab_free+0x7a/0xb0
> 4,1398,2553536306,-; kfree+0x1ad/0x510
> 4,1399,2553536908,-; nr_rt_ioctl+0x648/0x2d20 [netrom]
> 4,1400,2553537513,-; nr_ioctl+0x12d/0x290 [netrom]
> 4,1401,2553538119,-; sock_do_ioctl+0x114/0x230
> 4,1402,2553538735,-; sock_ioctl+0x3a6/0x640
> 4,1403,2553539363,-; __x64_sys_ioctl+0x147/0x1e0
> 4,1404,2553539983,-; x64_sys_call+0x1060/0x2360
> 4,1405,2553540611,-; do_syscall_64+0x82/0x5d0
> 4,1406,2553541242,-; entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 3,1407,2553541874,-;
> 3,1408,2553542499,-;The buggy address belongs to the object at ffff88811b=
c50e00\x0a which belongs to the cache kmalloc-rnd-09-64 of size 64
> 3,1409,2553543732,-;The buggy address is located 50 bytes inside of\x0a f=
reed 64-byte region [ffff88811bc50e00, ffff88811bc50e40)
> 3,1410,2553544955,-;
> 3,1411,2553545570,-;The buggy address belongs to the physical page:
> 4,1412,2553546194,-;page: refcount:0 mapcount:0 mapping:0000000000000000 =
index:0x0 pfn:0x11bc50
> 4,1413,2553546833,-;ksm flags: 0x17ffffc0000000(node=3D0|zone=3D2|lastcpu=
pid=3D0x1fffff)
> 4,1414,2553547477,-;page_type: f5(slab)
> 4,1415,2553548118,-;raw: 0017ffffc0000000 ffff888100051e00 ffffea00042c79=
c0 0000000000000003
> 4,1416,2553548774,-;raw: 0000000000000000 0000000080200020 00000000f50000=
00 0000000000000000
> 4,1417,2553549428,-;page dumped because: kasan: bad access detected
> 3,1418,2553550087,-;
> 3,1419,2553550741,-;Memory state around the buggy address:
> 3,1420,2553551406,-; ffff88811bc50d00: 00 00 00 00 00 00 00 fc fc fc fc f=
c fc fc fc fc
> 3,1421,2553552083,-; ffff88811bc50d80: 00 00 00 00 00 00 00 fc fc fc fc f=
c fc fc fc fc
> 3,1422,2553552756,-;>ffff88811bc50e00: fa fb fb fb fb fb fb fb fc fc fc f=
c fc fc fc fc
> 3,1423,2553553428,-;                                     ^
> 3,1424,2553554104,-; ffff88811bc50e80: 00 00 00 00 00 00 00 fc fc fc fc f=
c fc fc fc fc
> 3,1425,2553554798,-; ffff88811bc50f00: 00 00 00 00 00 00 00 fc fc fc fc f=
c fc fc fc fc
> 3,1426,2553555505,-;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 4,1427,2553556264,-;Disabling lock debugging due to kernel taint
> 4,1428,2553557582,-;Oops: general protection fault, probably for non-cano=
nical address 0xe00efc5800000255: 0000 [#1] SMP KASAN PTI
> 1,1429,2553558757,-;KASAN: maybe wild-memory-access in range [0x007802c00=
00012a8-0x007802c0000012af]
> 4,1430,2553559929,-;CPU: 1 UID: 0 PID: 4776 Comm: netromd Tainted: G    B=
               6.19.0-rc5-f6bvp+ #50 PREEMPT(voluntary)=20
> 4,1431,2553561094,-;Tainted: [B]=3DBAD_PAGE
> 4,1432,2553561835,-;Hardware name: To be filled by O.E.M. To be filled by=
 O.E.M./CK3, BIOS 5.011 09/16/2020
> 4,1433,2553562456,-;RIP: 0010:nr_rt_ioctl+0x6ef/0x2d20 [netrom]
> 4,1434,2553563054,-;Code: 85 c7 1c 00 00 4c 8b 73 08 4d 85 f6 74 58 48 89=
 d8 48 c1 e8 03 42 80 3c 38 00 0f 85 bc 1c 00 00 4c 89 f6 48 8b 03 48 c1 ee=
 03 <42> 80 3c 3e 00 0f 85 e0 1c 00 00 49 89 06 48 85 c0 74 1a 48 8d 78
> 4,1435,2553563699,-;RSP: 0018:ffff88810db57858 EFLAGS: 00010206
> 4,1436,2553564363,-;RAX: ffff8881a78b2a00 RBX: ffff88811bc50e00 RCX: 0000=
000000000000
> 4,1437,2553565026,-;RDX: 0000000000000000 RSI: 000f005800000255 RDI: 0000=
000000000000
> 4,1438,2553565687,-;RBP: ffff88810db57a20 R08: 0000000000000000 R09: 0000=
000000000000
> 4,1439,2553566351,-;R10: 0000000000000000 R11: 0000000000000000 R12: ffff=
8881022ac980
> 4,1440,2553567011,-;R13: ffff8881022ac9a1 R14: 007802c0000012a8 R15: dfff=
fc0000000000
> 4,1441,2553567675,-;FS:  000077cecd93a740(0000) GS:ffff888254ed6000(0000)=
 knlGS:0000000000000000
> 4,1442,2553568348,-;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 4,1443,2553569022,-;CR2: 000077cecd7baff0 CR3: 0000000107942006 CR4: 0000=
0000001726f0
> 4,1444,2553569698,-;Call Trace:
> 4,1445,2553570376,-; <TASK>
> 4,1446,2553571051,-; ? __pfx_nr_rt_ioctl+0x10/0x10 [netrom]
> 4,1447,2553571733,-; ? try_to_merge_with_ksm_page+0x170/0x2b0
> 4,1448,2553572432,-; ? apparmor_capable+0x159/0x470
> 4,1449,2553573129,-; ? security_capable+0x95/0x1c0
> 4,1450,2553573832,-; nr_ioctl+0x12d/0x290 [netrom]
> 4,1451,2553574529,-; ? alloc_empty_file+0xad/0x160
> 4,1452,2553575229,-; sock_do_ioctl+0x114/0x230
> 4,1453,2553575929,-; ? alloc_file_pseudo+0x163/0x230
> 4,1454,2553576620,-; ? __pfx_sock_do_ioctl+0x10/0x10
> 4,1455,2553577308,-; ? __pfx_alloc_file_pseudo+0x10/0x10
> 4,1456,2553577996,-; ? security_socket_post_create+0x78/0x200
> 4,1457,2553578680,-; ? __pfx_do_vfs_ioctl+0x10/0x10
> 4,1458,2553579366,-; ? sock_alloc_file+0xe2/0x220
> 4,1459,2553580045,-; sock_ioctl+0x3a6/0x640
> 4,1460,2553580722,-; ? __pfx_fput_close_sync+0x10/0x10
> 4,1461,2553581405,-; ? __pfx___sys_socket+0x10/0x10
> 4,1462,2553582087,-; ? __pfx_sock_ioctl+0x10/0x10
> 4,1463,2553582764,-; ? __kasan_check_read+0x11/0x20
> 4,1464,2553583445,-; ? hook_file_ioctl+0x10/0x20
> 4,1465,2553584130,-; __x64_sys_ioctl+0x147/0x1e0
> 4,1466,2553584810,-; x64_sys_call+0x1060/0x2360
> 4,1467,2553585993,-; do_syscall_64+0x82/0x5d0
> 4,1468,2553586668,-; ? __fput+0x554/0xaa0
> 4,1469,2553587347,-; ? fput_close_sync+0xe3/0x1b0
> 4,1470,2553588026,-; ? __pfx_fput_close_sync+0x10/0x10
> 4,1471,2553588717,-; ? __kasan_check_read+0x11/0x20
> 4,1472,2553589413,-; ? fpregs_assert_state_consistent+0x5c/0x100
> 4,1473,2553590099,-; ? do_syscall_64+0xbf/0x5d0
> 4,1474,2553590793,-; ? ksys_read+0x104/0x240
> 4,1475,2553591476,-; ? __pfx_ksys_read+0x10/0x10
> 4,1476,2553592155,-; ? __kasan_check_read+0x11/0x20
> 4,1477,2553592832,-; ? fpregs_assert_state_consistent+0x5c/0x100
> 4,1478,2553593493,-; ? do_syscall_64+0xbf/0x5d0
> 4,1479,2553594151,-; ? exc_page_fault+0x95/0x100
> 4,1480,2553594802,-; entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 4,1481,2553595451,-;RIP: 0033:0x77cecd73287d
> 4,1482,2553596093,-;Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10=
 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f=
 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
> 4,1483,2553596793,-;RSP: 002b:00007fff83cb9d10 EFLAGS: 00000246 ORIG_RAX:=
 0000000000000010
> 4,1484,2553597503,-;RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000=
77cecd73287d
> 4,1485,2553598212,-;RDX: 00007fff83cb9dcc RSI: 00000000000089e2 RDI: 0000=
000000000005
> 4,1486,2553598925,-;RBP: 00007fff83cb9d60 R08: 0000000000000000 R09: 0000=
000000000000
> 4,1487,2553599621,-;R10: 0000000000000000 R11: 0000000000000246 R12: 0000=
000000000078
> 4,1488,2553600325,-;R13: 0000601de2d57a60 R14: 00007fff83cb9ef0 R15: 0000=
601dc3550159
> 4,1489,2553601035,-; </TASK>
> 4,1490,2553601726,-,ncfrag=3D0/1007;Modules linked in: netrom mkiss rose =
ax25 netconsole snd_seq_dummy snd_hrtimer cmac nls_utf8 cifs nls_ucs2_utils=
 libarc4 netfs cifs_md4 x86_pkg_temp_thermal intel_powerclamp coretemp snd_=
hda_codec_alc269 snd_hda_scodec_component snd_hda_codec_realtek_lib kvm_int=
el snd_hda_codec_generic snd_hda_codec_intelhdmi snd_hda_codec_hdmi spi_nor=
 mtd snd_hda_intel kvm snd_intel_dspcfg irqbypass snd_hda_codec ghash_clmul=
ni_intel aesni_intel snd_hwdep rapl intel_cstate qrtr snd_hda_core spi_inte=
l_platform at24 spi_intel mei_hdcp mei_pxp intel_rapl_msr i915 snd_pcm proc=
essor_thermal_device_pci_legacy intel_soc_dts_iosf processor_thermal_device=
 snd_seq processor_thermal_wt_hint platform_temperature_control i2c_i801 pr=
ocessor_thermal_soc_slider intel_pch_thermal i2c_smbus snd_seq_device i2c_a=
lgo_bit platform_profile snd_timer processor_thermal_rfim drm_buddy process=
or_thermal_rapl lpc_ich intel_rapl_common mei_me processor_thermal_wt_req s=
nd processor_thermal_power_fl4,1490,2553601726,-,ncfrag=3D966/1007;oor ttm =
mei drm_display_helper soundcore
> 4,1491,2553601869,c; processor_thermal_mbox int340x_thermal_zone input_le=
ds nls_iso8859_1 intel_pmc_core video wmi pmt_telemetry pmt_discovery pmt_c=
lass intel_pmc_ssram_telemetry intel_vsec acpi_pad mac_hid binfmt_misc sch_=
fq_codel msr parport_pc ppdev lp parport efi_pstore nfnetlink dmi_sysfs aut=
ofs4 hid_generic usbhid hid r8169 ahci realtek libahci uas usb_storage [las=
t unloaded: mkiss]
> 4,1492,2553607611,-;---[ end trace 0000000000000000 ]---
> 3,1493,2553649506,-;pstore: backend (efi_pstore) writing error (-5)
> 4,1494,2553650533,-;RIP: 0010:nr_rt_ioctl+0x6ef/0x2d20 [netrom]
> 4,1495,2553651547,-;Code: 85 c7 1c 00 00 4c 8b 73 08 4d 85 f6 74 58 48 89=
 d8 48 c1 e8 03 42 80 3c 38 00 0f 85 bc 1c 00 00 4c 89 f6 48 8b 03 48 c1 ee=
 03 <42> 80 3c 3e 00 0f 85 e0 1c 00 00 49 89 06 48 85 c0 74 1a 48 8d 78
> 4,1496,2553652649,-;RSP: 0018:ffff88810db57858 EFLAGS: 00010206
> 4,1497,2553653658,-;RAX: ffff8881a78b2a00 RBX: ffff88811bc50e00 RCX: 0000=
000000000000
> 4,1498,2553654710,-;RDX: 0000000000000000 RSI: 000f005800000255 RDI: 0000=
000000000000
> 4,1499,2553655722,-;RBP: ffff88810db57a20 R08: 0000000000000000 R09: 0000=
000000000000
> 4,1500,2553656871,-;R10: 0000000000000000 R11: 0000000000000000 R12: ffff=
8881022ac980
> 4,1501,2553657916,-;R13: ffff8881022ac9a1 R14: 007802c0000012a8 R15: dfff=
fc0000000000
> 4,1502,2553659046,-;FS:  000077cecd93a740(0000) GS:ffff888254ed6000(0000)=
 knlGS:0000000000000000
> 4,1503,2553660069,-;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 4,1504,2553661125,-;CR2: 000077cecd7baff0 CR3: 0000000107942006 CR4: 0000=
0000001726f0
> 0,1505,2553662153,-;Kernel panic - not syncing: Fatal exception in interr=
upt
> 0,1506,2553663142,-;Kernel Offset: 0x33200000 from 0xffffffff81000000 (re=
location range: 0xffffffff80000000-0xffffffffbfffffff)
> 0,1507,2553705726,-;Rebooting in 30 seconds..
>=20

Hello Bernard,

Thanks for sharing the kernel panic log. I will try my best to resolve=20
the issue.

Best Regards,
Prithvi

