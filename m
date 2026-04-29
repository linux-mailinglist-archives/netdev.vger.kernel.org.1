Return-Path: <netdev+bounces-282482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wm/OJ+1q8mkMrAEAu9opvQ
	(envelope-from <netdev+bounces-282482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 22:32:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F5949A282
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 22:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AEB0302F70E
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 20:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5315837D12F;
	Wed, 29 Apr 2026 20:32:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48091C2AA
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 20:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777494759; cv=none; b=Ot4XU0m0VtUrkmAAH0urMZWYO4L1QiudEFh9FYecxWatJAPwGfDpQrzVYBWcZmakiGjlyE2YKv7y3cpvJ4pAPguMtYXm/8xK+r9mr7EKJmzGbxwoQ154Z1aYirbSUZLs6V/iveuEtcDKgGD6U33GTw8Kj+RaHDcBEFTl3H+Jb/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777494759; c=relaxed/simple;
	bh=T7uCuNOAogKBgl0xkoImLPWCwsELhH6WDqd5AWGGc8g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dTT8iRxmVHf5uCq9Sx15c+8Jud55jzxsbu5iXnt93+oAVi42XCeNBx42WsXYTYX319qFrcQt5dAFlweg1sE7U0+Cc0fDlMUSiUTe24F4y/vCJXUeW5mLIwTlKHuUvGSlj1jjTH5AV+AHBs+GngH0wgRMpq8iC2pqj6V6brd7ec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-696266291d6so382405eaf.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 13:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777494757; x=1778099557;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QFLXSf0MhhT3Nv6MnzhC1U2ntLwmkSQrplCJ27OaT98=;
        b=Af5C5y6j3Ai6xMqEbmGzXlSiRhJft6yz0c1T/0G3BfzReLb1XXdiDsCuheSbc7xpcu
         UIx7casowOZ2R34Xq6iuMR/+oNVnUnWZlk90qX9qqcxUYGh0fXZBGZP689THEpBuzsgv
         zQ0Urmw8wbLZqRnQOVDBYqTO92D18pZihK0dJ9viXnyxFJ9w8NmcAoUDFoyCrEQLmRF6
         l6rBIVFcVuGfIVKwgoJQzVRhRobkNrMwr5AoQGs+wEhCkwxiXiRwG+Wj3GEgB1ilTWxU
         xurHiBy5JMuGo5OeZUNarnMCovKcwgg8GotTsDociHAYOi8pxEtTeKg+YBEpKTKgEYt9
         RMIg==
X-Forwarded-Encrypted: i=1; AFNElJ+tv4sZbOK5PRenUNfeBNszPYWHNUXwPvZOVQ+3cKFmn7z22yE7EGCgiwApJYYrQ4VomOXYRAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYfNMnbo+asrR4P1c4s3vzAHzws94mtHpR2zKl0I94at9bYH5w
	vYdxLpeOityBEy9uq8RVm5f7TJKifOglcDsxgctYAUisqcRe2bPyFowEHoVM71AEbb1qNxhBvQs
	H9L/KB3mJFiBJVIinvLp2RY90nU8u6mSPV3Qvmqc2g2Lg2MrCCLdlTsArhUY=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:134b:b0:696:7697:6469 with SMTP id
 006d021491bc7-6967a510533mr103473eaf.17.1777494756761; Wed, 29 Apr 2026
 13:32:36 -0700 (PDT)
Date: Wed, 29 Apr 2026 13:32:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f26ae4.170a0220.3c4978.0007.GAE@google.com>
Subject: [syzbot] Monthly hams report (Apr 2026)
From: syzbot <syzbot+listb0e725a1df57c9e37f56@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E9F5949A282
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	REDIRECTOR_URL(0.00)[goo.gl];
	NEURAL_HAM(-0.00)[-0.966];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282482-lists,netdev=lfdr.de,listb0e725a1df57c9e37f56];
	RCPT_COUNT_THREE(0.00)[4]

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 3 new issues were detected and 1 were fixed.
In total, 20 issues are still open and 48 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  16483   Yes   possible deadlock in nr_rt_device_down (3)
                   https://syzkaller.appspot.com/bug?extid=ccdfb85a561b973219c7
<2>  8461    Yes   possible deadlock in nr_rt_ioctl (2)
                   https://syzkaller.appspot.com/bug?extid=14afda08dc3484d5db82
<3>  4371    Yes   WARNING: ODEBUG bug in handle_softirqs
                   https://syzkaller.appspot.com/bug?extid=60db000b8468baeddbb1
<4>  1122    Yes   possible deadlock in nr_remove_neigh (2)
                   https://syzkaller.appspot.com/bug?extid=8863ad36d31449b4dc17
<5>  803     Yes   WARNING: ODEBUG bug in __run_timers (3)
                   https://syzkaller.appspot.com/bug?extid=7287222a6d88bdb559a7
<6>  188     Yes   possible deadlock in nr_del_node (2)
                   https://syzkaller.appspot.com/bug?extid=6eb7834837cf6a8db75b
<7>  32      Yes   WARNING: refcount bug in ax25_setsockopt
                   https://syzkaller.appspot.com/bug?extid=0ee4da32f91ae2a3f015
<8>  26      No    KASAN: slab-use-after-free Write in rose_send_frame
                   https://syzkaller.appspot.com/bug?extid=9cc08d5dcb1fc8feee76
<9>  24      Yes   KASAN: slab-use-after-free Read in nr_rt_ioctl
                   https://syzkaller.appspot.com/bug?extid=df52f4216bf7b4d768e7
<10> 23      No    KASAN: slab-use-after-free Read in rose_t0timer_expiry
                   https://syzkaller.appspot.com/bug?extid=44cccec2c6a4501f6a45

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

