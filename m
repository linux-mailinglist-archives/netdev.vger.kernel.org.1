Return-Path: <netdev+bounces-111593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6129931A95
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 20:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1BE2819D2
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 18:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740B3770EB;
	Mon, 15 Jul 2024 18:58:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0600B5025E
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721069909; cv=none; b=GhQl1CwWn/j5PKgYGO3gAqCmqKtBXIODKlI//RUE6nXYTBoxOsC7L1HaksNeBLVTjaMVh7BpMRKFkYqpI9RnS6wU/shWQ3RsaPjMAlOzeCLENywyP+443lzMGp4mFhlxuVQinij2gzCRsTKN/6P2kjvYmGuvFrm7MTPcFUQfmPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721069909; c=relaxed/simple;
	bh=cpmTQBktvxfEjsfDAHgNYSl1n9i+mHiYwKZA5zq1664=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rlmVd8OuQ7ILzFBWJQXsr3HTfBWCOczFV7jf+prCQLM1qK/QFzoZdVYlZQpMOMA0ENMHW1znIXlGGsVR3kKxaimgPckIPRFyxL/OcsWocxwaGBmNVokte1fRYnDuBozt4IovmELQDrH1CT8T5SpiFU6IeuLs+BnNwP9E+pexRHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-381f1b3050bso49903525ab.0
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 11:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721069907; x=1721674707;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CLFH2JBjewy4ABEXyNEx3SEk+w8nbuEWu0g6qYvBIvg=;
        b=U0MIAGUXyosEU4IuhmICMtW4cFz6bGyLV4H27X/kMQg+pTa/ShOAyHBClQfFMerWL+
         aS1GxRJOsq6756roljhXFqVeRXTEcKT9zPt0zJOpVG0656JL5mBU7r/dFQwBiKz983Mb
         TJMpx2605dbC8Vt8MbD2qei7IP7ayTDlK77bGBs5bhWBFuSheGWkoVcwRpZQCnWIi/OC
         TKItvtwC9h95mCadtjqcN84fAUepE6SERroZ8ftV+z0s7fmYfsaljg4SQ2ucmcRyfYqG
         Pkp8kCro9tQeA4ZjtRqgp1c71KBJutlgiXheL9GxngdH8TmgPJTTXujqscyAvpdAwOeR
         Cj5g==
X-Forwarded-Encrypted: i=1; AJvYcCUhSbX38aEpvbz3x4hcBL9e+yf4xka2Us52dR/dD28vxb2zN4nziRejNyB9zkP/jMfGJxxZtaqroyCZH4uxCWgmZDru5Af4
X-Gm-Message-State: AOJu0YyLsKucnyiUkQTV55CBDQd9ihmS9SdtY4AeaQsrOMgAleKMROOX
	+UAMNby5luhdKskM/CVHo50hhBFuwkSpj7wLcNrggVXNEiBYRauo1/TVSHUYP74u31HIc02TQWX
	SaXznOTP1hzk1IrIlm1ZsTO2W+z4VwTpOFDk06B3TPw2C00hPeaXSZro=
X-Google-Smtp-Source: AGHT+IG5gnwO+2PNyj24HiTL4E5/5if1gDwVATLMA9Vwy4dawML/hf5wVhjnmhELMScFZcHeC9MRJ4EjKNSXQrMFIWf01H5IIKLN
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218a:b0:375:9cb9:9d04 with SMTP id
 e9e14a558f8ab-393d2f7eda0mr26745ab.3.1721069907170; Mon, 15 Jul 2024 11:58:27
 -0700 (PDT)
Date: Mon, 15 Jul 2024 11:58:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000736b1e061d4dd0b6@google.com>
Subject: [syzbot] Monthly batman report (Jul 2024)
From: syzbot <syzbot+list04e0bfa034e581a03989@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, 
	linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, 
	netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello batman maintainers/developers,

This is a 31-day syzbot report for the batman subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/batman

During the period, 1 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 26 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1297    Yes   INFO: rcu detected stall in worker_thread (9)
                  https://syzkaller.appspot.com/bug?extid=225bfad78b079744fd5e
<2> 381     Yes   INFO: rcu detected stall in batadv_nc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=69904c3b4a09e8fa2e1b
<3> 10      No    BUG: soft lockup in batadv_iv_send_outstanding_bat_ogm_packet
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

