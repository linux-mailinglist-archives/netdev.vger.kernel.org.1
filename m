Return-Path: <netdev+bounces-108890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE05592625E
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591711F21877
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACE917A599;
	Wed,  3 Jul 2024 13:56:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF09B171095
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014964; cv=none; b=NIRbkGGLWf6DCEjLoyFJ/e1/4HbhhiPl1FrD/YJQb0Fv3fasK3v6UpWOptIF6djRtUpXjsC+uWDA3R/FU94AZHRWSSRoQmP1kLm8mq1iaqXj43emln6huMvqaJKveJXMZkVnsbvrSNkU6s1uvh84/jNixwtLKMCrrF9ucNLvdj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014964; c=relaxed/simple;
	bh=ogDzCFWf02n0NhfQtrOVZBGui4ufGppKy2clFYNagHs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ol+hGF+vKw9oN6jMATDqXO60gGgR6XS80gIPa/f2SKIVGoPbEtlQSb77eHkmaOuI04HAxfqZ2nk9fKkw1I152Cjqh//Pr+/SelAE294dOf5yWnwKK6UmaHzG/PUAgcEx4MLNmRey5wml5/Bv71FmLkLGWgGuvnZHKASTKgXcrwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f439f51960so635109239f.1
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 06:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720014962; x=1720619762;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hdq3tCuwQI7n1SBMovokzqtbZQ3gSeo6Hdp/WmawlMs=;
        b=BUw8q3ip0vWolsUUpjgIKBCgxyicEGCZcD41bNuAFNSBZRkaYnF65ritGoUjxbV1Nk
         afRJtFIEJ7A3N/O3AE2VchaVnETTu3kVc30kNEGwb1VKjZoa3XXlZs6euY5PELenr6Yy
         C+MsLbCMTqbw+BnnE2Ex1w0D4f5VdlY96tlZ2fBQb67ASBkXHNzJoZTQmY6neDqzNxFh
         x5JszZTO9GlC52eg4rGouqgiWYd+Kbk4z3yiG4vANMBh3AynigpB6kztvyOlJhw2u73x
         End4uv5UKsQ2HLMKb52bQ719FBgji9pj4kMGBCV9FVejH9OvDZX+wiNMNKhrajfRaOl0
         57AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ4dSft/NqX0oKo97NP+OWvmGz1siEvR4lYb0/yxOwtu6r7GWZEp0wkmrB5QONcMigxceHu/VibSz6SUO3ZEC3McnBavy1
X-Gm-Message-State: AOJu0YzQfCmpFQLM5Cx/SnouS7pN7iTVdZep3K+4TzHDiaGz7Bj72RJR
	04wHsPGqEm+dmvxA68z74ZlQ66nkqeUlFiZSGTMQhI66+FSMmq0PYm+ow9q9wn/EkMwQfS0QGte
	SiF469/CFDY0x7hycOd36wQOQ8TQOHMKOaYyEmDGTBIaAwZckE2KxsBI=
X-Google-Smtp-Source: AGHT+IGdPgzclsT1Avf35z8PIjaFfO2Dyj4IQIm1vY9gWUxMTSKN/6uAP2iE+61ZcC0RGxTQBsOJJz0kS8TRV6r6BO7bSgXSnF9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:860c:b0:4bd:4861:d7f8 with SMTP id
 8926c6da1cb9f-4bd4861db3dmr267983173.4.1720014962233; Wed, 03 Jul 2024
 06:56:02 -0700 (PDT)
Date: Wed, 03 Jul 2024 06:56:02 -0700
In-Reply-To: <ZoU+7gbOSzWMOOPC@katalix.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d527f8061c5830eb@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in l2tp_session_delete
From: syzbot <syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tparkin@katalix.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/l2tp/l2tp_core.c:1301:24: error: use of undeclared identifier 'pos'


Tested on:

commit:         185d7211 net: xilinx: axienet: Enable multicast by def..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=c041b4ce3a6dfd1e63e2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16c5a181980000


