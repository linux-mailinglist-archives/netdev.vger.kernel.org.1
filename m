Return-Path: <netdev+bounces-88040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6EF8A56B3
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 17:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2FB2283CBC
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623D97A140;
	Mon, 15 Apr 2024 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="b99ZbIvg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316DE29414
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713195797; cv=none; b=ParW3XA0MFApChvz1Cah2zkWg6L8wTyBzzpfKDJfmade1yswYwX5qCwCEFTRnS9YSEPIju6IJ120JdOjLwX4IidN7WIU1S2jWUC6UEZAAlmxaluCde37kXsTaE1UScGbNZztADXxzNPWWVPnw5leImlVkuqL8pPcjvcUjiugr/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713195797; c=relaxed/simple;
	bh=6ZzMmQQlxur4AJXe2u1N8jWtMrGUZYIa5t7CpFb8ORc=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=EK0YDeXCtj3H/13BJ3PNge1NVj+jEO1kzdX9HsMgT0GFslmq3T9klwLxNfSRK1yHf2PDLCYRJAqSdqvbsk54ui/K9wm4AZ1R1PO4Xv/+ugk4E4TDpiJjnYFBCj+D23X/Q+rjsKcfC539zjbUacgr2rXZMgswwMJprVEmpoluRtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=b99ZbIvg; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 02953411DE
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 15:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713195792;
	bh=UCnYW/5UMVuS676TKLld3+Mry/+HuiD7VxWKXuU5V74=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=b99ZbIvgzzgtBo5Br9Yyf6hNCczHsM7uAjyKFafiO6Dge+ql3cr0YBUoTNyI64EpN
	 eOYw7+BZtmn02Pz+uF+AA8bw5LGAJDi2FUMur14SD7lHAsE93tOsYDA1KbKudHHVLY
	 yXxTxMSuCypr14sxKMJm8R+qPwvRSTmMatc5iahVfvVHYe9O61kfoJmRS5n8l3Ltuu
	 Hig5PgGoB1xap0/4TPPwZyqhNeohRSZXv0uOZOZPU5UYdrIPRQXJV7k3tpVaan2nOn
	 7m0ZcIklcHfQVJjqyJ75/YcwVUnY42TWQ3fRWohVCg+RJkLQSI7OJ8WolK+0yCtWxe
	 Jw7URCKJHA/Gw==
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5cdfd47de98so2619604a12.1
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 08:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713195790; x=1713800590;
        h=message-id:date:content-transfer-encoding:mime-version:comments
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UCnYW/5UMVuS676TKLld3+Mry/+HuiD7VxWKXuU5V74=;
        b=Ghq8fkhOOZ9DyJcyu0koVVh6N9ue7GcRGtCdP2It9SqGX3m8dJskXOlVkQsHIib9H4
         tDy579FhjwS5jC5dNPG42EUgktUV7wGd8Ryc+XeN6LO1BI1lois6xc5QFGW6fIe5rXgA
         70UrvL+5kKT9r2HvM9R8w0TuWZ1aFXHaYd+srhT8dfDST3tPIrh8BmNnQi1zCdfUnMI5
         vWD/24Mu38nNFYhpm9scmWw3Fb9h5KYJ/DzvpkyxeDUd1lkhfWk7DxzTYkpphCXQafp0
         hD8aDpKmcveqbRmTPCg4zydgIVFbU6H3Rnwuh8ZKzN5Kzpd80LPjHpwVi2kpzyzFPPcO
         xqFA==
X-Forwarded-Encrypted: i=1; AJvYcCUyPdtMFVDu/5qEtLyP97oACNbd0Sj68IJEcRjYeHFIapt01N8bkoam+kNB1awO4WkQHIWpeyUuXFR4ijMbqZNk8Nhmja4O
X-Gm-Message-State: AOJu0YxAbAmkIhFuKRtjSGsucPJZ+xsPfuA3dVN4DtxnruJ6qEYGOikQ
	4KoPtvvjJPuYDdqxnczqkrHC8RPH9HctF29fFwvqHDLLZGNCq9V1TWxnFwmTJ3RPDbOrzcOBzej
	e3cv0q5sMAfRMoEsyHOj2cj3bQ6fj0kE4GZfDP1H4X8Cv9hJCAL6SCM7yTDOmHyto2IYWvg==
X-Received: by 2002:a05:6a20:7f8b:b0:1a5:6e11:2fd9 with SMTP id d11-20020a056a207f8b00b001a56e112fd9mr9538171pzj.6.1713195790172;
        Mon, 15 Apr 2024 08:43:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3/YOZCSDejeKCM6T3dzQlJ0Q4WLdS3RHSyPXkd8elDfeRaKsIKRoEQsaTWifvHHgHj5w3Qw==
X-Received: by 2002:a05:6a20:7f8b:b0:1a5:6e11:2fd9 with SMTP id d11-20020a056a207f8b00b001a56e112fd9mr9538139pzj.6.1713195789511;
        Mon, 15 Apr 2024 08:43:09 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id y15-20020a056a00190f00b006ecfa91a210sm7385100pfi.100.2024.04.15.08.43.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2024 08:43:09 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id AB3EF5FFF6; Mon, 15 Apr 2024 08:43:08 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id A406B9FA74;
	Mon, 15 Apr 2024 08:43:08 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Sam Sun <samsun1006219@gmail.com>
cc: Hangbin Liu <liuhangbin@gmail.com>, linux-kernel@vger.kernel.org,
    netdev@vger.kernel.org, andy@greyhouse.net, davem@davemloft.net,
    Eric Dumazet <edumazet@google.com>, kuba@kernel.org,
    pabeni@redhat.com
Subject: Re: [PATCH net v1] drivers/net/bonding: Fix out-of-bounds read in bond_option_arp_ip_targets_set()
In-reply-to: <CAEkJfYOebGdmKLtn4HXHJ2-CMzig=M+Sc7T0d6ghZcXY_iY5YA@mail.gmail.com>
References: <CAEkJfYPYF-nNB2oiXfXwjPG0VVB2Bd8Q8kAq+74J=R+4HkngWw@mail.gmail.com> <ZhzYCZyfsWgYWxIe@Laptop-X1> <CAEkJfYOebGdmKLtn4HXHJ2-CMzig=M+Sc7T0d6ghZcXY_iY5YA@mail.gmail.com>
Comments: In-reply-to Sam Sun <samsun1006219@gmail.com>
   message dated "Mon, 15 Apr 2024 16:46:24 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Apr 2024 08:43:08 -0700
Message-ID: <12281.1713195788@famine>

Sam Sun <samsun1006219@gmail.com> wrote:

>On Mon, Apr 15, 2024 at 3:32=E2=80=AFPM Hangbin Liu <liuhangbin@gmail.com>=
 wrote:
>>
>> On Mon, Apr 15, 2024 at 11:40:31AM +0800, Sam Sun wrote:
>> > In function bond_option_arp_ip_targets_set(), if newval->string is an
>> > empty string, newval->string+1 will point to the byte after the
>> > string, causing an out-of-bound read.
>> >
>> > BUG: KASAN: slab-out-of-bounds in strlen+0x7d/0xa0 lib/string.c:418
>> > Read of size 1 at addr ffff8881119c4781 by task syz-executor665/8107
>> > CPU: 1 PID: 8107 Comm: syz-executor665 Not tainted 6.7.0-rc7 #1
>> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 0=
4/01/2014
>> > Call Trace:
>> >  <TASK>
>> >  __dump_stack lib/dump_stack.c:88 [inline]
>> >  dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
>> >  print_address_description mm/kasan/report.c:364 [inline]
>> >  print_report+0xc1/0x5e0 mm/kasan/report.c:475
>> >  kasan_report+0xbe/0xf0 mm/kasan/report.c:588
>> >  strlen+0x7d/0xa0 lib/string.c:418
>> >  __fortify_strlen include/linux/fortify-string.h:210 [inline]
>> >  in4_pton+0xa3/0x3f0 net/core/utils.c:130
>> >  bond_option_arp_ip_targets_set+0xc2/0x910
>> > drivers/net/bonding/bond_options.c:1201
>> >  __bond_opt_set+0x2a4/0x1030 drivers/net/bonding/bond_options.c:767
>> >  __bond_opt_set_notify+0x48/0x150 drivers/net/bonding/bond_options.c:7=
92
>> >  bond_opt_tryset_rtnl+0xda/0x160 drivers/net/bonding/bond_options.c:817
>> >  bonding_sysfs_store_option+0xa1/0x120 drivers/net/bonding/bond_sysfs.=
c:156
>> >  dev_attr_store+0x54/0x80 drivers/base/core.c:2366
>> >  sysfs_kf_write+0x114/0x170 fs/sysfs/file.c:136
>> >  kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:334
>> >  call_write_iter include/linux/fs.h:2020 [inline]
>> >  new_sync_write fs/read_write.c:491 [inline]
>> >  vfs_write+0x96a/0xd80 fs/read_write.c:584
>> >  ksys_write+0x122/0x250 fs/read_write.c:637
>> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>> >  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
>> >  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>> > ---[ end trace ]---
>> >
>> > Fix it by adding a check of string length before using it.
>> >
>> > Reported-by: Yue Sun <samsun1006219@gmail.com>
>>
>> Not sure if there is a need to add Reported-by yourself if you are the a=
uthor.
>>
>> Also you need a Fixes tag if the patch target is net tree.
>
>Sorry for missing the Fixes tag, I will add it to patch. I am also not
>sure if I should add Reported-by here, since it's my first time to
>commit a patch for linux.

	The submitting-patches.rst file in Documentation/ isn't
explicit, but the intent seems to be that Reported-by is for a bug
report from a third party that isn't involved in creating the fix.  I
don't think you need it here, just a Signed-off-by.

>> > Signed-off-by: Yue Sun <samsun1006219@gmail.com>
>> > ---
>> >  drivers/net/bonding/bond_options.c | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/net/bonding/bond_options.c
>> > b/drivers/net/bonding/bond_options.c
>> > index 4cdbc7e084f4..db8d99ca1de0 100644
>> > --- a/drivers/net/bonding/bond_options.c
>> > +++ b/drivers/net/bonding/bond_options.c
>> > @@ -1214,7 +1214,8 @@ static int bond_option_arp_ip_targets_set(struct
>> > bonding *bond,
>> >      __be32 target;
>> >
>> >      if (newval->string) {
>> > -        if (!in4_pton(newval->string+1, -1, (u8 *)&target, -1, NULL))=
 {
>> > +        if (!(strlen(newval->string)) ||
>> > +            !in4_pton(newval->string + 1, -1, (u8 *)&target, -1, NULL=
)) {
>> >              netdev_err(bond->dev, "invalid ARP target %pI4 specified\=
n",
>> >                     &target);
>>
>> Do we need to init target first if !(strlen(newval->string)) ?
>>
>Good question. I think we don't need to init target first, since in
>original logic in4_pton() also leave target untouched if any error
>occurs. If !(strlen(newval->string)), bond_option_arp_ip_targets_set()
>just ret and target is still untouched. But I am not sure about it.

	I think the original code is incorrect, as target will be
uninitialized if in4_pton() fails.  The netdev_err() message shouldn't
include target at all, it will never contain useful information.

	-J

>If anyone finds other problems, please let me know.
>
>Thanks,
>Yue
>> Thanks
>> Hangbin
>> >              return ret;
>> > --
>> > 2.34.1
>

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

