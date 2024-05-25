Return-Path: <netdev+bounces-98054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EFC8CEDAF
	for <lists+netdev@lfdr.de>; Sat, 25 May 2024 04:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E76281C45
	for <lists+netdev@lfdr.de>; Sat, 25 May 2024 02:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F250B1862;
	Sat, 25 May 2024 02:56:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84257110A
	for <netdev@vger.kernel.org>; Sat, 25 May 2024 02:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716605784; cv=none; b=U+S9Bhah0jNldaaS26OBsJOBD+tUNCYNAHqyLJshKD9dZulnCNk/gv0wu/30rlgsUCMlNlc35GIF4G9adEGPoGjpaGdwdS798osgEtSKUl4JwL+liPW6PgaQL96oKEzSoJHRxZ4ktwZveEjzGGFeklwSQXkDtquFsGKvEx7ioyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716605784; c=relaxed/simple;
	bh=Ks3KmzwMbRsannbXAsBY5Mpb/8YYOiPHCfk/qKRpZZ8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QoZNzchh01FU20bFHhbWJfOEv985dt0t+LJgfx4HxOEJ+tIlgX9SiJNWWY7hRF3dOqkunlwib2C7wuBy+9Bj+xc95Dhjzq8nRN1L7FtdRv05MAK68lXNhiqyBwCYRq3+LhbH/ZocJArrDdnYs+/BcARLL1yzs+bfcYpBrVRE+KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3737b3c496fso14618245ab.2
        for <netdev@vger.kernel.org>; Fri, 24 May 2024 19:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716605783; x=1717210583;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ExZtektDIQPH03325dsSn5zzOZ7zTFNhg8HxEcmp2pY=;
        b=VqdpPkdajF6F62CJTJYu2axLrFuMnymXfV2cklpePxpbzJeeJ7u0IuA7B7RVVNC8Aq
         rDnfFdW3x6pbRztwoU7+vXti0ZnDdm9m3SHOnO+yBL59u5yOq/hAWXR2YnDX4VyvMHaZ
         U7Uu6jFoGmbLPfC+pguyqMKrGRywPn037yQphnLuoplrDiUfXvz0Mn+nJhWHTfq+Onia
         ZQTEEgzxbv2OKEccISHn0hTcFgVO277NKIuKc25ZoA07TRNOagV95Xu02nB6zH8BGPTb
         +nDn52Kzols1sGQirMyndJ9Tj2drUzWVJ4NF2GEz74d3VFqLZzNArs5i1/g6Xxo5nFVO
         ETiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoo27eKc2DFqbaOhPTPQf0B7SfKdyomZvhXzloSZg1ZfAI3+KRIWZPZXU+1X7YS/X5foi5hGm0D/6Mdow3V4TImk7cWnl/
X-Gm-Message-State: AOJu0Yz3fYFzXgjt8tnudOMIyct8boBtc6iOdI4iXCfhW5k2+X5astko
	ZB2a6ICN+c3kr8ExNofZpAMKet66nJxpb5yMNNsEXaDb/s1p1IsO2GW2fhtMzX7x6tUD0tNL5ip
	G/huI4m+6UVCKA+pa6mc+MpM6eCKFkbRJbGm7nb6L3GeVnxo0oQgOv+M=
X-Google-Smtp-Source: AGHT+IHSvRTiPokUE/70fZDTdslc+f038Gctibu7OR86v/OeWMvaJzlipA+ZcFINQ4y9b22ZNVZQjCUPPTqhv8pdYQnNEkbykyQr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c743:0:b0:373:874e:93be with SMTP id
 e9e14a558f8ab-373874e977emr865105ab.3.1716605782818; Fri, 24 May 2024
 19:56:22 -0700 (PDT)
Date: Fri, 24 May 2024 19:56:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e7924806193e6dcc@google.com>
Subject: [syzbot] [net?] [virt?] upstream boot error: KMSAN: uninit-value in corrupted
From: syzbot <syzbot+f8f2e9a62c70487ab828@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jasowang@redhat.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f6a15f095a6 Merge tag 'cocci-for-6.10' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=119aa5cc980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d66c5ffb962c9d5b
dashboard link: https://syzkaller.appspot.com/bug?extid=f8f2e9a62c70487ab828
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0a053ab9d75b/disk-8f6a15f0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a1cac58c3541/vmlinux-8f6a15f0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/180b83fc69a9/bzImage-8f6a15f0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f8f2e9a62c70487ab828@syzkaller.appspotmail.com

Starting dhcpcd...
dhcpcd-9.4.1 starting
dev: loaded udev
DUID 00:04:19:0b:4d:1d:24:6b:9f:8b:bf:f7:85:18:31:02:d0:f0
forked to background, child pid 4697
Starting sshd: [  113.935289][    C0] BUG: KMSAN: uninit-value in receive_mergeable drivers/net/virtio_net.c:1839 [inline]
Starting sshd: [  113.935289][    C0] BUG: KMSAN: uninit-value in receive_buf+0x25e3/0x5fd0 drivers/net/virtio_net.c:1955


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

