Return-Path: <netdev+bounces-144370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9009C6D68
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 12:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26E3284CB0
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 11:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4592E1FF035;
	Wed, 13 Nov 2024 11:07:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892121C8776
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496046; cv=none; b=GultEodGv6PMnKo8AiY4IrK6BQIsTubBSi5lD9EypschfRl9WnaP3ugW9v8mTX+ReKhX9wKZSBn8KtibrsYv230oTOiaMG0MnnnFAs0D5uU0lx7lterJJF7lpRIMUnkymcB3Wespe0on+8uxpfM+0tzLbbdo5Ej9YtaGcWnoI58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496046; c=relaxed/simple;
	bh=3nNM0RWOHRwOh7vCR5bAGUb3yt8DqN9rgmZNmyv+1dA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DYCjLAO9xvGHhNhDb7ItOmlaPNTlb9IymRURLw1KT0Avz/QAH3kCbieAkD66ce9mVCkPXB6wETHVHavN/AEItETMbXQc985O19tH5wi5jzB5EGcOWc9iAyWNP2cr/+zfHiaeElQ/pimOR0OpH9HPWKrxXzbvG7hxa76huR34/lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83abad6594fso748967239f.3
        for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 03:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731496044; x=1732100844;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DwSOEAvBktMgftzuxBHvBD9aUQ+nzTMLZyoeTaPM0CE=;
        b=QPbxljzsiAyrF6Z1p+4iURyhfo2nf0iSp1ubha9yFTiMdnPwRMVRcSxUuL5rruttlY
         VMeRFM0FoBPu7woZbaQjDffN05p4p0A+H433OegoLSIDF11WIcgGQLQ6/CaG1zcbtg8N
         NDXhZgQCfISlyP1aCNzR9+869fyUTtFP8sy9cz84i9L0ukKraIv6EzTbL2SJBj1moy6k
         d8LKx/cDsC7vTvWfiVcSk+Xv+HB/nljfnldGAMlPCjG/9WFp8JZpS4nULCom83jxgQbv
         Op4szVkC/kCdJh10u/m5XOGXsmyLYbiXig5OVRKLyG0txo2Wd69Xzs6nDGKBC9jMCcLQ
         WLQw==
X-Forwarded-Encrypted: i=1; AJvYcCWdXQUGEc/oC4xKlyytEQk02hwhW3tMO5wDpzcGEXBY5/QL7QDYFmtBfEBxlNrZkOdZFR5u0Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEZyrZxNJFdKccHxOHlFpSq+QNmODK+rIYXdfq4uH9snIEAVXh
	D0491W1G3Js9apJlUpi8oJ1UM9q+cNunPGcX/aea+R2bW+etGjiJfbZD2pvOHgkZYh9JSmIIt4j
	7ZD1XwfEOKD4hHB5b9S1gNBnFLTjHoLPhSswSfwpu3ibbToV0yitPMTg=
X-Google-Smtp-Source: AGHT+IHc+ihD1CVYxIdzETMaxBkZllwA44W9mPFRV4QkVI/dOD/r9sngDbwP1exuFO+kJoaz8wB0v7JQPSv6nZFBRR6bZVgtedxn
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:680d:0:b0:3a7:18ac:1fd1 with SMTP id
 e9e14a558f8ab-3a718ac209fmr10563875ab.2.1731496043720; Wed, 13 Nov 2024
 03:07:23 -0800 (PST)
Date: Wed, 13 Nov 2024 03:07:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6734886b.050a0220.2a2fcc.0008.GAE@google.com>
Subject: [syzbot] Monthly netfilter report (Nov 2024)
From: syzbot <syzbot+lista609c7c1ef075b5cd57f@syzkaller.appspotmail.com>
To: kadlec@netfilter.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfilter maintainers/developers,

This is a 31-day syzbot report for the netfilter subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfilter

During the period, 2 new issues were detected and 1 were fixed.
In total, 10 issues are still open and 177 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 117     Yes   INFO: rcu detected stall in gc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
<2> 47      Yes   INFO: rcu detected stall in NF_HOOK (2)
                  https://syzkaller.appspot.com/bug?extid=34c2df040c6cfa15fdfe
<3> 45      Yes   BUG: soft lockup in batadv_iv_send_outstanding_bat_ogm_packet
                  https://syzkaller.appspot.com/bug?extid=572f6e36bc6ee6f16762

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

