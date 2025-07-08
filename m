Return-Path: <netdev+bounces-205191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 626C4AFDBFD
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 01:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499321C23746
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 23:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D211237713;
	Tue,  8 Jul 2025 23:55:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE0E18E3F
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 23:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752018905; cv=none; b=u8t7PV6eNQ7GiYmynevSIluxnPX5NBorwBYXXiNCIZJhNGAk6mPO/9sXKo2HMqDain8vOCAYrzVCNe0Ji8vK+LfE9SC/93Df5CXYpV8tPNJM34tu9Ghj/mYRS/NyA8S8ciThwTwYPlVue1Mpv+pTEtcrv85CtXr6GOCNeMHpOdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752018905; c=relaxed/simple;
	bh=wQxWK8jBvglI2zvwv6228wj6glSdtDhMFKEyulOd6Uk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aLqkekEKR8p+jMQ6IE0L7/hsSXNyuw9GvLA8+4QPWa9LgEOWesamKc4RTlW8esepB1ciGDSUxM4Z+qx95flmJpTXZNUmtfwAbyoZFmLKdvkQ6362dFhPkBqqyG9OuftY8JmwcySjhIx04xs+a8UnWSPl3p2XrBThlbUeEf19/3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86cf89ff625so471419139f.0
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 16:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752018903; x=1752623703;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E0dogU16f7slst3dKm7CYnYhI8NIlC8uvBFGVNrpma8=;
        b=J7VRHsINYiHbQ0etsuF1jxsrhKb7dVYX+985quVfRVwnMxPtbgx2jo4dXoARZ01d+C
         /2u+t7//vxEDI9Z+SkOW/GN+p/uYFIdCjgeMGXoJM0AUNbezYH0t3vJI/ngUod9s+IY8
         sFnUiWmH+hcYgy5UEE5JlFlu1N5QbOFlceEp8kRCXZjgN/M4OuM72sPjXJ5arw28ZFeN
         k7jw7xy+Tqu6Uyrc2qB2eZ0ARvaFB2MfOAMKxVlgUpsSwYSvuA2ue/PUuiDheCbgO+cd
         aecIxmwYExU/nOI0D2hRNTe5VniRjVHFsQ02X2K+MlgOTjDU0fSZCDi3GZqkWA16zMN1
         Tbkg==
X-Forwarded-Encrypted: i=1; AJvYcCXRrR6IPPGDgYdWcHmAkANNm2Ok8dCCczQst0NVSacWib+r/g0XWNmQ+o5OrXvxUP8YwBVQ44s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHvrfXhhLtyRqAwl9OvsG6XiPUtuTcKMl+nxrW3eDUx2ue8WMQ
	QDg63cxaBioaiRXPTo007Oj7G5jlUhRfIfXbYPx1SEIaOVHYPGqZ8kkn6Rch5jQrHlY+bIW6cZ5
	EWfCvowrTP8bBZsjVWchUPgVeHXPPEE3rcuzl/TWmPfgSZeBW7a8dN85SK+8=
X-Google-Smtp-Source: AGHT+IEeCsE/9d5kZQOLQz9zCsrOEREOlk+pn+j4to8gmRcKCXkSndmdjkfK2hAzPunoPRw7+j/ICnzmVVJAh8c3NFUgXCiqR16Y
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1849:b0:3df:3598:7688 with SMTP id
 e9e14a558f8ab-3e1670fc2bdmr7126025ab.21.1752018903099; Tue, 08 Jul 2025
 16:55:03 -0700 (PDT)
Date: Tue, 08 Jul 2025 16:55:03 -0700
In-Reply-To: <20250708231926.356365-1-kuniyu@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686dafd7.050a0220.1ffab7.0026.GAE@google.com>
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
From: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, paul@paul-moore.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com
Tested-by: syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com

Tested on:

commit:         ec480130 Merge branches 'for-next/core' and 'for-next/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17268a8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e99b6fcd403d050
dashboard link: https://syzkaller.appspot.com/bug?extid=40bf00346c3fe40f90f2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13fa6bd4580000

Note: testing is done by a robot and is best-effort only.

