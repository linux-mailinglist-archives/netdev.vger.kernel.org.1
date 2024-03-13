Return-Path: <netdev+bounces-79660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3819887A77D
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 13:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31896B210F7
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 12:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27563FE5F;
	Wed, 13 Mar 2024 12:23:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DDD3FE2E
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710332586; cv=none; b=Q5Y1XfgUo61WDQHHj2WdIPSNjBnbiovNK+xXBRBrbKoMNEUlCJunJFGf8ThJzjyb3j3STWJF00cTgZxQhp5+H21JBf0hEcAPkxGuKQzTSOOKKYsf+apZKv7llgqjOM8xYAgywe15T7DOp7NdS8xmwCue/wh4iSIP1S4/Hu6pp7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710332586; c=relaxed/simple;
	bh=CMx0+K0+od6gAAfqGFuKrClz/7QMgfg21jkqF8+bk0U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FkT/WnIL275lclgX1JU1r82rgQXZmCac/U3iFuVY/BGyRQMvHwZwyYmXietxVHsZnpi/EJ3IZESdrEiBXzVSmffXhsY3FaAIAbqvsumUGwCQp3l7LyA0TV0htZiWmbQiaCpbpJPNgrZd7LRUyJzUA06Qkbpy6ekojPAcrqbUF6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c8af56060aso313247639f.3
        for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 05:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710332584; x=1710937384;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/RQ7ulMJ/8EuK5QcToN/BsgCLIW1fJL8XxtmY+wQjs=;
        b=bv/x/geHu+cPfjlTF22L48muiU39EBHe3Blw4vi45rrR8z3zpDdz5P8VvtJ0P+saEa
         7t9kdceWSzmgYxiuIMUbibiQCIGSffiH0Jc5ixDBsl3G4BFYDVQaq4iLZJOGTnQbUVa3
         a7XfX5W0fyfX6XAIFSB4YCchtvxjLkXhuZHhLXLNVr2N+GT1tmGysb1qLoMqWivZ/fPw
         C/l7AZoF/pE/chfZsMBsRCpy48ciExVsUEOENvQsRjKS2M9nuUbJj39u50QYx0P5gvGO
         bHzpvsnBGv5WVyN/IZ1gz5xpio5w3zrNSiMNZO7rKoYHuuiXqzZM/FWglu+YvgHBnWPW
         Jn3g==
X-Forwarded-Encrypted: i=1; AJvYcCUAwMiv0QWldTI0jmQE9/4sF4WrJ4nFJ4rIvaS+8HvWRfqDixGLl4pw3k1FxzC31oTB1vzV72/xwHbyZxskQvi30e9qa6T1
X-Gm-Message-State: AOJu0YxH7nGcRvioDacH1ZtpV82ZjFPBwnjFGxBs4NKxqaZGTjwfLqLk
	bYeWSQh3/BmbCaFP3iIQVc7yGOmaCgh0hXXqIu4PlFfRMDIj0b61bEaw307e/1M0pgciq3vsSat
	FBUSZiLI5GXLOtaqBqI60BdH4Wp58UUvtT7Nz1JOEo3IsHfAF50GvG1k=
X-Google-Smtp-Source: AGHT+IGVTtQ4uojG97WNJ0uwB0YBDq59+qtV5IZ/3cDnbc7YourhmR/GosPslCuD+dZwEelAMVRAygeYYtaFyq8wBk2Nc0aMcF63
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1693:b0:7c8:bd8e:a88 with SMTP id
 s19-20020a056602169300b007c8bd8e0a88mr143010iow.4.1710332584607; Wed, 13 Mar
 2024 05:23:04 -0700 (PDT)
Date: Wed, 13 Mar 2024 05:23:04 -0700
In-Reply-To: <00000000000095640f05cb78af37@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002755ce061389d67b@google.com>
Subject: Re: [syzbot] [can?] possible deadlock in j1939_sk_queue_drop_all
From: syzbot <syzbot+3bd970a1887812621b4c@syzkaller.appspotmail.com>
To: astrajoan@yahoo.com, davem@davemloft.net, edumazet@google.com, 
	hdanton@sina.com, kernel@pengutronix.de, kuba@kernel.org, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org, 
	o.rempel@pengutronix.de, pabeni@redhat.com, robin@protonic.nl, 
	socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6cdedc18ba7b9dacc36466e27e3267d201948c8d
Author: Ziqi Zhao <astrajoan@yahoo.com>
Date:   Fri Jul 21 16:22:26 2023 +0000

    can: j1939: prevent deadlock by changing j1939_socks_lock to rwlock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10e4d371180000
start commit:   dd72f9c7e512 Merge tag 'spi-fix-v6-6-rc4' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=12abf4cc4f802b24
dashboard link: https://syzkaller.appspot.com/bug?extid=3bd970a1887812621b4c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17602089680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13398a9d680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: can: j1939: prevent deadlock by changing j1939_socks_lock to rwlock

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

