Return-Path: <netdev+bounces-107953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F35991D318
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 20:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE482812D7
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 18:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930D713D509;
	Sun, 30 Jun 2024 18:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="a74OjGpg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A503716D
	for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719771663; cv=none; b=C5t0LPbHe3qF/x+f73t3yHPkDUi9AJNX1by2vw2q6A3nEhNOtaegAXhz8NraH1pu1JKkrqQjZoOw+F2ObMMu6/MU69dDo+VWy/7KxeJ0Z2JT9VyrqGYVx19gH8apjtVa+LyGwL0i1+VP4gy4zmuwDzExzaR7U6WUHmm/8JIX6AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719771663; c=relaxed/simple;
	bh=+mFJubt1on90cYskh1saq0OjtcB3CHaVX1g8AZXtAJg=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=tMBnQoIE/QpChhZU6jf0JYRmxIVLWmWrv4FsmyDunfbnCEoalcGpPXjUHOTxo6RvkuFRAwshdJ0Tj4mRA9tW0cJdVFwWlCoFK/GbNVQu3aISMZi9IvJKDp0wUaAPyzcqL+dn/0/eycwDqtOjlValDwCnL8hnNehxsLxnSSodJ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=a74OjGpg; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5EF1241334
	for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 18:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1719771653;
	bh=aiPyzd3UVoPw0z3dFgtgSA4EUA/ILBOA9FGg0A858To=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=a74OjGpg0asto0bZ/cbkd3pRBkRKMBuQOFOHLk0Wr7nmiOq3PYzdO82przx6iHopt
	 bm7FhoyV5IE+aUb+L8TS9nurRBYpR1JfSNryh2Nlcq01W+uHne+mJ37Ja3hrsFHLhR
	 Ub6BmRimJ5ANXwtKAgEU3wWrT2DrawcJTqteMaaOWr4ESCRhG+UykachMGBxBp9ZO3
	 F9tMx8ZSwjxlcatc5zegcimFkgm9/0PntEkxfNg7ukvq0cE+4hIMPsCt9mWa0bCFoH
	 IjOtqwOxch37VwYrixx5hlFgKzFih+qnD22cC/2bKzE3/iL4iHW02iInKQp3vN3Pyg
	 B0THOhUo8MW0g==
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-25bfed6a3f5so2581815fac.0
        for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 11:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719771650; x=1720376450;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aiPyzd3UVoPw0z3dFgtgSA4EUA/ILBOA9FGg0A858To=;
        b=uDZY/9wmGYWtuvT/uyksydLftJZtF0NYSPC7tJKZTORNpU63Yh6EHgNZGQx3O5Ke72
         gQ2EQd4xfoKEUdrR0hZ1zpx7TSu4YQlalv0crROiZALKMMHfA2lIgCPx3mTyyYuk9irb
         eW+reDS9X2zvMGqEjJZUSfT5mzTpYOSjOOIP4ePsHqthEIg1AN8SjSCyWzI6Sl0QjhsU
         1GzICN9UagF3SP4+6c8deFLfKFUjiU25TWnN31eBKHdDSKJ3WbQfHTy84viVWoPIuyau
         mZbABx1C4yRoB9bMMim3ZIq63Kg1K9qoXvUFPrBuL5dVH8wEDzqmqVjBLArE7arK+M1O
         C18g==
X-Forwarded-Encrypted: i=1; AJvYcCVi0Dk+fK6qEF1MEtK/KpbcmkZGjlHbMdU8JqVedC7NnW2bAXeTblklk2LsjylrOgAxwYpRgpQccZJU6qUeTa+FwiNPDKV/
X-Gm-Message-State: AOJu0YwyDkbyXB7smpJRChBsmXmntBywAzp5enKaF2tU3jnmnYmaMwD9
	v8MVj5h1dFpCGUM49e+mRPDSqbVXfcMcUetSWJa//WtIs0vX9PNaeWfin3HBgdRnn33Q1tsmDa2
	4iDNik0DrP6nUIjFoe3hJ8V3DJtwyH5AcN3HK7qXa/1+hBwZTn1yvtOdEqhA9YjO+csf5Xg==
X-Received: by 2002:a05:6870:514:b0:254:aada:cc8b with SMTP id 586e51a60fabf-25db3494dffmr3280695fac.31.1719771649902;
        Sun, 30 Jun 2024 11:20:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsJE2X++7SRA6uaIe7og+wuHvivcZmE7YdRwof1I5Fd9DxIQ+2dytv9oBp8GZAnZefd6Yqew==
X-Received: by 2002:a05:6870:514:b0:254:aada:cc8b with SMTP id 586e51a60fabf-25db3494dffmr3280678fac.31.1719771649409;
        Sun, 30 Jun 2024 11:20:49 -0700 (PDT)
Received: from famine.localdomain ([50.35.97.145])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801007c62sm4963595b3a.0.2024.06.30.11.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 11:20:49 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 4EA949FC97; Sun, 30 Jun 2024 11:20:48 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 4BCA89FB9B;
	Sun, 30 Jun 2024 11:20:48 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: 'Simon Horman' <horms@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Andy Gospodarek <andy@greyhouse.net>,
    Ding Tianhong <dingtianhong@huawei.com>,
    Hangbin Liu <liuhangbin@gmail.com>,
    Sam Sun <samsun1006219@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net v5] bonding: Fix out-of-bounds read in
 bond_option_arp_ip_targets_set()
In-reply-to: <20240630-bond-oob-v5-1-7d7996e0a077@kernel.org>
References: <20240630-bond-oob-v5-1-7d7996e0a077@kernel.org>
Comments: In-reply-to 'Simon Horman' <horms@kernel.org>
   message dated "Sun, 30 Jun 2024 14:20:55 +0100."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1568134.1719771648.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Jun 2024 11:20:48 -0700
Message-ID: <1568135.1719771648@famine>

'Simon Horman' <horms@kernel.org> wrote:

>From: Sam Sun <samsun1006219@gmail.com>
>
>In function bond_option_arp_ip_targets_set(), if newval->string is an
>empty string, newval->string+1 will point to the byte after the
>string, causing an out-of-bound read.
>
>BUG: KASAN: slab-out-of-bounds in strlen+0x7d/0xa0 lib/string.c:418
>Read of size 1 at addr ffff8881119c4781 by task syz-executor665/8107
>CPU: 1 PID: 8107 Comm: syz-executor665 Not tainted 6.7.0-rc7 #1
>Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
>Call Trace:
> <TASK>
> __dump_stack lib/dump_stack.c:88 [inline]
> dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
> print_address_description mm/kasan/report.c:364 [inline]
> print_report+0xc1/0x5e0 mm/kasan/report.c:475
> kasan_report+0xbe/0xf0 mm/kasan/report.c:588
> strlen+0x7d/0xa0 lib/string.c:418
> __fortify_strlen include/linux/fortify-string.h:210 [inline]
> in4_pton+0xa3/0x3f0 net/core/utils.c:130
> bond_option_arp_ip_targets_set+0xc2/0x910
>drivers/net/bonding/bond_options.c:1201
> __bond_opt_set+0x2a4/0x1030 drivers/net/bonding/bond_options.c:767
> __bond_opt_set_notify+0x48/0x150 drivers/net/bonding/bond_options.c:792
> bond_opt_tryset_rtnl+0xda/0x160 drivers/net/bonding/bond_options.c:817
> bonding_sysfs_store_option+0xa1/0x120 drivers/net/bonding/bond_sysfs.c:1=
56
> dev_attr_store+0x54/0x80 drivers/base/core.c:2366
> sysfs_kf_write+0x114/0x170 fs/sysfs/file.c:136
> kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:334
> call_write_iter include/linux/fs.h:2020 [inline]
> new_sync_write fs/read_write.c:491 [inline]
> vfs_write+0x96a/0xd80 fs/read_write.c:584
> ksys_write+0x122/0x250 fs/read_write.c:637
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
>---[ end trace ]---
>
>Fix it by adding a check of string length before using it.
>
>Fixes: f9de11a16594 ("bonding: add ip checks when store ip target")
>Signed-off-by: Yue Sun <samsun1006219@gmail.com>
>Signed-off-by: Simon Horman <horms@kernel.org>

Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>

>---
>Changes in v5 (Simon):
>- Remove stray 'I4' from netdev_err() string. Thanks to Hangbin Liu.
>- Sorry for the long delay between v4 and v5, this completely slipped my
>  mind.
>- Link to v4: https://lore.kernel.org/r/20240419-bond-oob-v4-1-69dd1a66db=
20@kernel.org
>
>Changes in v4 (Simon):
>- Correct  whitespace mangled patch; posting as requested by Sam Sun
>- Link to v3: https://lore.kernel.org/r/CAEkJfYOnsLLiCrtgOpq2Upr+_W0dViYV=
HU8YdjJOi-mxD8H9oQ@mail.gmail.com
>
>Changes in v3 (Sam Sun):
>- According to Hangbin's opinion, change Fixes tag from 4fb0ef585eb2
>  ("bonding: convert arp_ip_target to use the new option API") to
>  f9de11a16594 ("bonding: add ip checks when store ip target").
>- Link to v2: https://lore.kernel.org/r/CAEkJfYMdDQKY1C-wBZLiaJ=3DdCqfM9r=
=3Drykwwf+J-XHsFp7D9Ag@mail.gmail.com/
>
>Changes in v2 (Sam Sun):
>- According to Jay and Hangbin's opinion, remove target address in
>  netdev_err message since target is not initialized in error path and
>  will not provide useful information.
>- Link to v1: https://lore.kernel.org/r/CAEkJfYPYF-nNB2oiXfXwjPG0VVB2Bd8Q=
8kAq+74J=3DR+4HkngWw@mail.gmail.com/
>---
> drivers/net/bonding/bond_options.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bon=
d_options.c
>index 0cacd7027e35..228128e727c2 100644
>--- a/drivers/net/bonding/bond_options.c
>+++ b/drivers/net/bonding/bond_options.c
>@@ -1214,9 +1214,9 @@ static int bond_option_arp_ip_targets_set(struct bo=
nding *bond,
> 	__be32 target;
> =

> 	if (newval->string) {
>-		if (!in4_pton(newval->string+1, -1, (u8 *)&target, -1, NULL)) {
>-			netdev_err(bond->dev, "invalid ARP target %pI4 specified\n",
>-				   &target);
>+		if (!(strlen(newval->string)) ||
>+		    !in4_pton(newval->string + 1, -1, (u8 *)&target, -1, NULL)) {
>+			netdev_err(bond->dev, "invalid ARP target specified\n");
> 			return ret;
> 		}
> 		if (newval->string[0] =3D=3D '+')
>

