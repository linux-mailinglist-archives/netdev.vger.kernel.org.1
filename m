Return-Path: <netdev+bounces-205182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F97AFDB6C
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 00:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDE418960E2
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 22:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F7622331C;
	Tue,  8 Jul 2025 22:54:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DED1F4CA9
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752015244; cv=none; b=QZtKzx5qFgY7gtDQ3zErYWFUDpvPIRhdKA+rxhahsJ5LYi7D75MP+XabP4a/eLM9Xn1RAolqIC2wmQs2dT/zVnkPJlZmukXFRgSsE1jaLVVgVpOg1YtDSMD3YODXeOT5EIAoFVIBTvQrWRrX6G3mNcXnw6rbL8XUJTcDRC8XXTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752015244; c=relaxed/simple;
	bh=BWGrnPzdM29YZ+XEjVdxFQICGfUneK/3oyhUW49b96o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kd71HswKy4F8ZdymD6MPf52lM1RJiogRGT8GEYTZzmkoozogGXXI6GBzHZeKDOIR4A7PWaF170up0JCfNWu9YOROxUikTwrfdzknBeqxb3NvxFIAqS62QNoYHzNlD5QgdiOjpfrtW2MelFJUOJnd0sFe3+AjzlEdbfjqUZPHDjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86d07ccc9ecso378828039f.0
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 15:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752015242; x=1752620042;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xB6rIu45qgH+ua/fJIcg/GQ4LbflrQoSaYRE7j9ojes=;
        b=ZVtpNuj95J+7Yveujkc3C79NpeW4ngtbowHi9eDI5cC0pb0wMloIKmJmsBVvcBfCgI
         ULRdGBUADq3r+UW4aVPWiiVAh2dlPKlaJ9XJGsKCq8h24Hl8ukYhRXaKUFeuiPRbSDSO
         jiG2PB2Ad21/QxvXQf8gjKAZJ517iUaRkwKX3Hl+WLS2Gtf/wp2plhmQAl0EbbfMNhon
         EuPEh88v8PIzvARhEgEdaxlkd+0zw8FXZzbl8GPD0dM/3WCZngmLkiAhto9hiOPVzGcr
         3g/0+tmGiJO6wm1NwebfJKwTaDz5ZMUiq9v31HuSLnYVb2AlTXpir5n+ml4GJeuSHvmd
         xX8g==
X-Forwarded-Encrypted: i=1; AJvYcCWDZNZu433CnzwKhgM7KYO3d+WElKO0cCVP5NIxQOlPONAhaUWw61AjMOrpsaCf6QMaUkxj8ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlFjYLWLuMxoWFfLyTKqDWIiCVQeyNzv9ETUxJrEOpMMUzqtMC
	nanRiLjJegMRCfWDd6KDIelpznq6tfaIj/jDujlCQg2ui6o7PkJ7zZU90yKuHmdqTWcXi71BxDI
	i1oQw9s2Lgh6Oz12Niecc9uA7QX10iGE3diRPTy+BwROwXzEObp8B31Lavlg=
X-Google-Smtp-Source: AGHT+IHhl5K1IBm4w3Ha62Q3bSWZNOD6HNSa90AYPP6wynNDvSk/jc3dzaTrHiG+iN1WvOSrqpb+n7vuyOQBxSRasTloLdUsenQH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:388a:b0:86d:60:702f with SMTP id
 ca18e2360f4ac-8795af33198mr62688239f.0.1752015242081; Tue, 08 Jul 2025
 15:54:02 -0700 (PDT)
Date: Tue, 08 Jul 2025 15:54:02 -0700
In-Reply-To: <20250708224131.332014-1-kuniyu@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686da18a.050a0220.1ffab7.0023.GAE@google.com>
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
From: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, paul@paul-moore.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/smc/af_smc.c:365:3: error: call to undeclared function 'inet_sock_destruct'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]


Tested on:

commit:         ec480130 Merge branches 'for-next/core' and 'for-next/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c06e3e2454512b3
dashboard link: https://syzkaller.appspot.com/bug?extid=40bf00346c3fe40f90f2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=130a6bd4580000


