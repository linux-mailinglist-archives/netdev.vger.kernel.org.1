Return-Path: <netdev+bounces-87330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DB98A2BB0
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 12:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABE581F22FB6
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 10:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B308151C5B;
	Fri, 12 Apr 2024 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLnipohW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA3D548E0
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916019; cv=none; b=C5diRQXSkpoRv/Nhh2yFJIsvJpOd8KZMiLO4yC6h7n72oR8zjxm790GRHfVKWeeBadp7p4QQEQpldSDgg2DAjkIqQ2x7Kw0bFcQR4JFMf3G4tPBBYpLHwuKn7C6JL0LF2wAmz1Sp18CxW4ZQfYZmmvP7E2LdOU7gUyW++KnSJIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916019; c=relaxed/simple;
	bh=Two23XHD08I1bV+BfFpQ0nUADd+AEFx+JCYmc9vS1KU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=BqCo7jqSHZQ99WZ+ug3hl1SRCSZH+spclIgwhaCs9as1a68/dSAmfaYK4BxSmg0g02WDFAzNfvvVkyNbbY7OYMFNCl4QvNgAeu++uoYZ7TrPL57CnzbhPvX7ZPzaM62UIwbiQPPwqPFuFoduaDgdvSmCjODgVeq72zWmnAEgDog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLnipohW; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e477db7fbso1024173a12.3
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 03:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712916016; x=1713520816; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ONk69wOQm0veI8mq//0y/HP3FhkmglvFKfXWswudKc=;
        b=kLnipohWlGcpOT1WlnZIMMzCL9maIO/dRs/W1ZwLDlNgDk1A3k3ZgpReSDlx16uPgC
         WZf2BZ1ZhyiW42mIsLkW+Mor/5WCXzu+f1Rpgy69wA0IQmhBKMHds6o59TTxsmLWQLLD
         1vHZ1sYd7PpoivTfrd4K0sv8iR9JdIB77CE/tMTHpqoDvRvMiian4bJn33WEzoXvm5bV
         5VAL1iz9HauvIZvCkTtnDbcQHhIXSNWwzsHBxbL7V223GZy7G3cw09d9PwXUeHGUO6k2
         b7M9FCa+n934y+BTZXQDzERy9bNcM9ibTgtNGPswrS6uLZGDkYK4r4LmBS7H9HbxGD9N
         4V4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712916016; x=1713520816;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ONk69wOQm0veI8mq//0y/HP3FhkmglvFKfXWswudKc=;
        b=fqYDWauYUu6DQaK5WJgMgCqrntw/k0zYWLTY9Ag0nLXFHoLS2WiK2hm0v8G05i7B0K
         KZ9MZac13ycOyYpfqC5G8IjgBoz9Nr0qAdb7QTZyJII6wa0nEMYwUQDDYfaE6JXPcWk1
         WflzzzQ822MzfjFHoLPa8na8kNKIOW13ChvMdMle7dkkGxOXR6VacJ4SqFYVOytKabZu
         /lOys/zOKxDr5uKZ/Rj+ngLu9xTzo2ZCzty6EIEYwVj9AulsSeXSbz+7MitaYJNSl5lJ
         TXIoE0QHZgRMtW5f/goXps7MSREfrkxwIgSaj7iwzrtncUoE1I62TzljSEsuFiZVRoxI
         OdwQ==
X-Gm-Message-State: AOJu0YzRoUuxbMKLGB0Qu5uXWLvsdzq09TsdgRIOb4QejR9drvMifyGT
	t8L+cdyMLtUFN15+HYwymhrOODw/mfo+6tq9UgpcbI51VIuc6+Fs
X-Google-Smtp-Source: AGHT+IFnJMS77g55TtqNb6ORNZPFC05UJ4xh1eXoVJzmTUR8OVqycPdZBUTg1lhOhLUh+L8yG3hgug==
X-Received: by 2002:a50:9f86:0:b0:564:5150:76a2 with SMTP id c6-20020a509f86000000b00564515076a2mr1446025edf.4.1712916016069;
        Fri, 12 Apr 2024 03:00:16 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7a91:3c00:7438:ddfe:2573:311f? (dynamic-2a01-0c22-7a91-3c00-7438-ddfe-2573-311f.c22.pool.telefonica.de. [2a01:c22:7a91:3c00:7438:ddfe:2573:311f])
        by smtp.googlemail.com with ESMTPSA id x7-20020a056402414700b0056feb6315easm1279201eda.1.2024.04.12.03.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 03:00:15 -0700 (PDT)
Message-ID: <2e11b89d-100f-49e7-9c9a-834cc0b82f97@gmail.com>
Date: Fri, 12 Apr 2024 12:00:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Crash in new PHY link topology extension
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On today's linux-next I get the following.

Apr 12 11:36:03 zotac kernel: BUG: kernel NULL pointer dereference, address: 0000000000000018
Apr 12 11:36:03 zotac kernel: #PF: supervisor read access in kernel mode
Apr 12 11:36:03 zotac kernel: #PF: error_code(0x0000) - not-present page
Apr 12 11:36:03 zotac kernel: PGD 0 P4D 0
Apr 12 11:36:03 zotac kernel: Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
Apr 12 11:36:03 zotac kernel: CPU: 1 PID: 219 Comm: systemd-network Not tainted 6.9.0-rc3-next-20240412+ #2
Apr 12 11:36:03 zotac kernel: Hardware name: Default string Default string/Default string, BIOS ADLN.M6.SODIMM.ZB.CY.015 08/08/2023
Apr 12 11:36:03 zotac kernel: RIP: 0010:__lock_acquire+0x5d/0x2550
Apr 12 11:36:03 zotac kernel: Code: 65 4c 8b 35 65 5d d1 7e 45 85 db 0f 84 bd 06 00 00 44 8b 15 f5 f8 14 01 45 89 c3 41 89 d7 45 89 c8 45 85
 d2 0f 84 c5 02 00 00 <48> 81 3f 00 f3 8a 82 44 0f 44 d8 83 fe 01 0f 86 bd 02 00 00 31 d2
Apr 12 11:36:03 zotac kernel: RSP: 0018:ffff9ca180e6f498 EFLAGS: 00010002
Apr 12 11:36:03 zotac kernel: RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
Apr 12 11:36:03 zotac kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000018
Apr 12 11:36:03 zotac kernel: RBP: ffff9ca180e6f510 R08: 0000000000000000 R09: 0000000000000000
Apr 12 11:36:03 zotac kernel: R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
Apr 12 11:36:03 zotac kernel: R13: 0000000000000000 R14: ffff98e7c5b38000 R15: 0000000000000000
Apr 12 11:36:03 zotac kernel: FS:  00007f7e7440e0c0(0000) GS:ffff98e937a80000(0000) knlGS:0000000000000000
Apr 12 11:36:03 zotac kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Apr 12 11:36:03 zotac kernel: CR2: 0000000000000018 CR3: 00000001027c0000 CR4: 0000000000750ef0
Apr 12 11:36:03 zotac kernel: PKRU: 55555554
Apr 12 11:36:03 zotac kernel: Call Trace:
Apr 12 11:36:03 zotac kernel:  <TASK>
Apr 12 11:36:03 zotac kernel:  ? show_regs+0x5f/0x70
Apr 12 11:36:03 zotac kernel:  ? __die+0x1f/0x70
Apr 12 11:36:03 zotac kernel:  ? page_fault_oops+0x15a/0x450
Apr 12 11:36:03 zotac kernel:  ? debug_smp_processor_id+0x17/0x20
Apr 12 11:36:03 zotac kernel:  ? rcu_is_watching+0x11/0x50
Apr 12 11:36:03 zotac kernel:  ? exc_page_fault+0x4cb/0x8d0
Apr 12 11:36:03 zotac kernel:  ? asm_exc_page_fault+0x27/0x30
Apr 12 11:36:03 zotac kernel:  ? __lock_acquire+0x5d/0x2550
Apr 12 11:36:03 zotac kernel:  ? __lock_acquire+0x3f8/0x2550
Apr 12 11:36:03 zotac kernel:  lock_acquire+0xc8/0x2f0
Apr 12 11:36:03 zotac kernel:  ? phy_link_topo_add_phy+0x153/0x1a0 [libphy]
Apr 12 11:36:03 zotac kernel:  _raw_spin_lock+0x2d/0x40
Apr 12 11:36:03 zotac kernel:  ? phy_link_topo_add_phy+0x153/0x1a0 [libphy]
Apr 12 11:36:03 zotac kernel:  phy_link_topo_add_phy+0x153/0x1a0 [libphy]
Apr 12 11:36:03 zotac kernel:  phy_attach_direct+0xcd/0x410 [libphy]
Apr 12 11:36:03 zotac kernel:  ? __pfx_r8169_phylink_handler+0x10/0x10 [r8169]
Apr 12 11:36:03 zotac kernel:  phy_connect_direct+0x21/0x70 [libphy]
Apr 12 11:36:03 zotac kernel:  rtl_open+0x30c/0x4f0 [r8169]
Apr 12 11:36:03 zotac kernel:  __dev_open+0xe8/0x1a0
Apr 12 11:36:03 zotac kernel:  __dev_change_flags+0x1c5/0x240
Apr 12 11:36:03 zotac kernel:  dev_change_flags+0x22/0x70
Apr 12 11:36:03 zotac kernel:  do_setlink+0xe9f/0x1290
Apr 12 11:36:03 zotac kernel:  ? __nla_validate_parse+0x60/0xce0
Apr 12 11:36:03 zotac kernel:  rtnl_setlink+0xff/0x190
Apr 12 11:36:03 zotac kernel:  ? __this_cpu_preempt_check+0x13/0x20
Apr 12 11:36:03 zotac kernel:  rtnetlink_rcv_msg+0x16e/0x660
Apr 12 11:36:03 zotac kernel:  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
Apr 12 11:36:03 zotac kernel:  netlink_rcv_skb+0x5a/0x110
Apr 12 11:36:03 zotac kernel:  rtnetlink_rcv+0x10/0x20
Apr 12 11:36:03 zotac kernel:  netlink_unicast+0x1a2/0x290
Apr 12 11:36:03 zotac kernel:  netlink_sendmsg+0x1f9/0x420
Apr 12 11:36:03 zotac kernel:  __sys_sendto+0x1d0/0x1e0
Apr 12 11:36:03 zotac kernel:  ? __seccomp_filter+0x22e/0x3b0
Apr 12 11:36:03 zotac kernel:  __x64_sys_sendto+0x1f/0x30
Apr 12 11:36:03 zotac kernel:  do_syscall_64+0x6c/0x140
Apr 12 11:36:03 zotac kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e

