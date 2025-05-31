Return-Path: <netdev+bounces-194511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330EAAC9BB3
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 18:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F292717C490
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 16:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742C517F4F6;
	Sat, 31 May 2025 16:20:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDED17A2FC
	for <netdev@vger.kernel.org>; Sat, 31 May 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748708404; cv=none; b=CUw4wOOp7c3n+KYtulBc6+9joTBsUYdS0ajXkzbAxDd43KqGGdXiA6R5z2a5Pnxz4RPvLXE1fcC5RpZsaDXYy8o22J0CxWr1joxo4xk7mc8bTU06JY1vE99mF958bM6n0pt+sBQGl6DjzpkIuytUwxx3wsINMFnk3jOJelkmK5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748708404; c=relaxed/simple;
	bh=sgPA9Q230YlwYNsgLsUAGT+EIJ3MJXCV8CkuV+njEC8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h++K/4vpIsvYxikqgHRuSKSL0BaOQGLUGXCSsWkLQB3Eiq/92MlvaQXyNMwlvfLdB5/qZiUtnC1q916U6noZAfNnIkjUDcKI2mjjyLRZcVcwOY+JsN7HXhc8/HCfnTKA3WbX/Q8O+ncaNMufKhF6h2MV+yZaWBqhIorK4Thk9KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3dc854af016so37200735ab.3
        for <netdev@vger.kernel.org>; Sat, 31 May 2025 09:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748708402; x=1749313202;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOT3+3dtKmIMbjiKp4WKPYIYOuy19lzYdhT8ETpxuvo=;
        b=seGwjzCurjToC7a8hIIxidXLv3rdgjhIHbIlIgAA3bWmpbXeYOowAH0FaPFYFqmTNw
         iduazftpZWSMpZdzH0YaMosqmDdq6D+9SQYenAkWpZPdk9FH8vDzk5U9MJjzcWBfyLxY
         WVBIK2LQioM5s7mpjHvvafsLaE08QUcGgFxSbdAfzaD5Kx7YCFCt36/fcgiV+NvObpRL
         BNFDuk9B8jrCDHM4qc+OOVmRrjhsY5wDaIbnwNjRO0S+NGiEwsCzxyy7SZLs4ZCMegDk
         eMGV8dNPP4QFq2a3LwlnodiEQCAKX6Ff9MmSGiYaTH12vglYXT6dF5xmgyuF0UnKlVUA
         GGIw==
X-Forwarded-Encrypted: i=1; AJvYcCVR1c3gDaPgoQBtsA+rgq0G9a4GQWjY226khoF4wEf9YQkFKIhe0dZLzJWiTCD7U4wJJzw3sGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQQAQjnZzwjidVVg0ndW9FFDBBetOpfx13LKB0cIIp4437DpzZ
	h+NKuNmUZ2+W3SiD6flnVDKWhHMSQDBD2MkMAXWR2IXgnRMY4bPhHDTjDFeAicD9kNWuKmiLpgl
	/4jOVl9tUYUzMbvIhWPb2ngBiJzn/bvGdw39R/sRxFg53xTmM7FyIwTS7cuE=
X-Google-Smtp-Source: AGHT+IGdap3ueor/+dC4QVfuI3dEjhxnuRezgHUx4IFWYUjshQSu+2Ssy2m7Z8B44GaIOMUzHwVmDX58Z5+KnBdSnlu+zMS+qDxq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1568:b0:3dd:8a06:4db3 with SMTP id
 e9e14a558f8ab-3dda339232emr19169295ab.19.1748708401944; Sat, 31 May 2025
 09:20:01 -0700 (PDT)
Date: Sat, 31 May 2025 09:20:01 -0700
In-Reply-To: <000000000000ec1f6b061ba43f7d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683b2c31.a00a0220.d8eae.001b.GAE@google.com>
Subject: Re: [syzbot] [smc?] possible deadlock in smc_switch_to_fallback (2)
From: syzbot <syzbot+bef85a6996d1737c1a2f@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, guwen@linux.alibaba.com, horms@kernel.org, 
	jaka@linux.ibm.com, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, tonylu@linux.alibaba.com, 
	wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 752e2217d789be2c6a6ac66554b981cd71cd9f31
Author: Kuniyuki Iwashima <kuniyu@amazon.com>
Date:   Mon Apr 7 17:03:17 2025 +0000

    smc: Fix lockdep false-positive for IPPROTO_SMC.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13833ed4580000
start commit:   47e55e4b410f openvswitch: fix lockup on tx to unregisterin..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ef22c4fce5135b4
dashboard link: https://syzkaller.appspot.com/bug?extid=bef85a6996d1737c1a2f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14832cb0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e17218580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: smc: Fix lockdep false-positive for IPPROTO_SMC.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

