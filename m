Return-Path: <netdev+bounces-108593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B6D92477C
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 20:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52DED1F26AB7
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 18:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3707442F;
	Tue,  2 Jul 2024 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="MqhwQaEB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E2F839F4
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719945924; cv=none; b=ZmUcL6iUoc5xcmQmmDs/SKWeHpIrIF3Pyea3pGgGuYhwi8szH8/XHL3IoMYPrByp3n+9RdUJx3My8qwR21hyywCnzuFaVKME3ElL2ppTU82FLIdgW2q/fcyIuzRllpTAHpSQ6vte3zT+oAUfaw1m1cVpyIVq5nG3XfOnsmMmsKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719945924; c=relaxed/simple;
	bh=GXPeRMkkpVr20GWXBD03zq7BxRqU9GNBw9ZhNxZhx1U=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=gc1TnN7shlAm0+q40tQru1b7CJCQoFJKJ6A69x1t60qOgTkcs50fLlpIC8YZJ6s0AzF/Pt9RUHuOBVJDrCQDjTq6FY9lRko1/xn0klbr7oPqbAFXbPVBGq9KHrkfHFY3jkc+D2u2R+euXEGbVOOfwYG5sFbADIVGVKOFUdSwUiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=MqhwQaEB; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 11DB13FD42
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 18:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1719945914;
	bh=0zkjgeqp0/MlY6CIib2imAhCP1MTmFZfYTolEvIgEVM=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=MqhwQaEBSwtLSgvp8YfaLHoL2USHZuQwcb2K1ZCELzXZH6Ic+amD/EbfYba7mtaa6
	 xJPoOdcMmsT+9y2p00NDF+Ih+UNv5l/B/pxm30qzg9Zq4L8iYExQ0uQOGPAJJ9xNPy
	 O1YgGsUU6tOP+X8haHa3Z3URJgyAqM0Oa4nxSfKAx6sBc5itHFx66J+W4Aslx1iw1k
	 dImBxCZNnfXjpbC+HIiHC0ArFxRAt4Q0mq52c7YpiXBNbh9TYFdqLQhGpJz+6dqKyl
	 R44SfOLS+pY1Clv2onir+BX2F2Cu0hAaK9DU1XDFUE85izbqmUr8PlSPWCR5Zn26Am
	 RwIxeYCelux/A==
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-376282b0e2bso46886225ab.1
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 11:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719945912; x=1720550712;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0zkjgeqp0/MlY6CIib2imAhCP1MTmFZfYTolEvIgEVM=;
        b=UdKfN6dEPa8NxPKw7dT7kijtMoLy1uJh3yaM9KRfyXYgikfgQzMMuFxTbzqRHzIF+v
         XeLYpAWYnNmkpCnj09mwXfT1ggRa8C+4C459EFLSpFoHVme1cVh433h/2dpDa9gXdD5g
         MXAaAJKfEcf9Z8t1K8vm31w9606uXGMADgndOOtRN7UOCrKrvTFtvJILOCN4B1vgor44
         1g7nARuBHawgvArlUvxEDopR2Y7pIi4HlODBT9LuaqAFoosmvpAtNVYXKgX/TPoowEy8
         yhPUwNM9Z5d+r7YJZilwroNH54rp540b5xZRTG76d2UOWGG/z2vwhTEca/SQAGAvTLrE
         MRQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2T6brQqBdt7dDR4SZd26zx7lV1V/yN1qji8hujkvCRrENc4a8xsT5cWoXDOOc0H7OHc2frMKIRvpMy81OIu3CjJ5AnU7n
X-Gm-Message-State: AOJu0Yy0tTjaPzNJQRJHBFCwc/eqdqFCpF8rrSiM4i9hD+PIHLTs5rEf
	H75zIgQUMGnsZ2Eq3SbR1i0VrZQ/Dhsnxi7kTWrPfIUWKNrQk6co/XzmzWaXTkE9EfD1p2fokB6
	/XUUub45LxGY3aYqEsujcgvNjNA0E3PUTEW1GOVBZdK8A/vbKz+PkQONgtfV9HEB6tStABA==
X-Received: by 2002:a92:c56b:0:b0:374:b07f:6dbf with SMTP id e9e14a558f8ab-37cd0aff882mr128265975ab.1.1719945912264;
        Tue, 02 Jul 2024 11:45:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3JWwtWbppJp/SLb7aptGY3dXrk5RuK2A20/Z1XUI6GeW7XZcQ2WV3ee+/UqReC+QTkO3o7Q==
X-Received: by 2002:a92:c56b:0:b0:374:b07f:6dbf with SMTP id e9e14a558f8ab-37cd0aff882mr128265765ab.1.1719945911911;
        Tue, 02 Jul 2024 11:45:11 -0700 (PDT)
Received: from famine.localdomain ([50.35.97.145])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6b2a15acsm6930970a12.43.2024.07.02.11.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 11:45:11 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 2A7B59FC9A; Tue,  2 Jul 2024 11:45:11 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 297569FB98;
	Tue,  2 Jul 2024 11:45:11 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: 'Simon Horman' <horms@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Andy Gospodarek <andy@greyhouse.net>,
    Ding Tianhong <dingtianhong@huawei.com>,
    Hangbin Liu <liuhangbin@gmail.com>,
    Sam Sun <samsun1006219@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net v6] bonding: Fix out-of-bounds read in
 bond_option_arp_ip_targets_set()
In-reply-to: <20240702-bond-oob-v6-1-2dfdba195c19@kernel.org>
References: <20240702-bond-oob-v6-1-2dfdba195c19@kernel.org>
Comments: In-reply-to 'Simon Horman' <horms@kernel.org>
   message dated "Tue, 02 Jul 2024 14:55:55 +0100."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1645937.1719945911.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jul 2024 11:45:11 -0700
Message-ID: <1645938.1719945911@famine>

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
>Changes in v6 (Simon):
>- Update check to strlen(...) < 1, as suggested by Jakub
>- Not accumulating tags due to above change,
>  which is material given the size of this patch
>- Link to v5: https://lore.kernel.org/r/20240630-bond-oob-v5-1-7d7996e0a0=
77@kernel.org
>
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
>index 0cacd7027e35..bc80fb6397dc 100644
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
>+		if (strlen(newval->string) < 1 ||
>+		    !in4_pton(newval->string + 1, -1, (u8 *)&target, -1, NULL)) {
>+			netdev_err(bond->dev, "invalid ARP target specified\n");
> 			return ret;
> 		}
> 		if (newval->string[0] =3D=3D '+')
>

