Return-Path: <netdev+bounces-126298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 097289708CB
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 18:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA130281F41
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 16:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A22175D32;
	Sun,  8 Sep 2024 16:43:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26A92E634
	for <netdev@vger.kernel.org>; Sun,  8 Sep 2024 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725813785; cv=none; b=S2Ogo1I/8CiSKW65spHLGU/fB8mi5WiRgoHdWI5Bv/dTVN42XTTf49oEyGs61RBOUmGoJ8OWBb15KOGNaJkgclnXU7IC5g2ylcuqPAc7Pm1ho/P642YOdhQJ0JB68tY2Z75E0c07dFO/lMQmLKMHWKe5Gv7JE88IVTyPqaFFMeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725813785; c=relaxed/simple;
	bh=+hpRt2dV5nPaL/nXyAs/uGkUnfPrWQbCVMJPn5e929Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JZWinUL58moMUXZNdHjf/etpH0JBX+iJmN5EGPNBuLhR8LwhvpO+MpEMwjeXvHmclY1yHkmnvldOPyNFk6tl50BL254hOmsK/cCZuCUBD1rGpjnKVMIT5wtrQBHYBW5YI3YNW6fAMSX3LsmWqzbsEk/AJOjdcYKlCGmPDo1Qjaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0570aa7b5so17517875ab.3
        for <netdev@vger.kernel.org>; Sun, 08 Sep 2024 09:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725813783; x=1726418583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+wp0usBhcD98D12aDAt+WbEjn/+6VIsoMm0S/3mqMI=;
        b=w87BpU7gkCqLmxtUawtMFIjkzci4KHJ9Rgc/1GhbOdpigiLAPpvNzLvGS+idTXdesx
         7PcjHUN4IPEMm+XH3Ih/UsmLLb/RYm2CGl+UwXwGJk6Bfh7Kezirx8kDaRF1gIcUe9i3
         ESVzV0XZUMdlDoTk3vpRVezicLVo2m9/pj+BD6wshck0igLyIfMFoPJUFknJ7qEpTJzc
         I2TYvrWBHowbBrE7byii0grJO+B7e2R8mQ9EQLI0dynTodLrHmBDCh84IZd8aQArMWrO
         iMyUZ5wZ++tar2DC/AD+TaMTZatiogrNkvRUSn1HInMfHg5EarDWdc1qdDngDNv/MV2b
         UmVg==
X-Forwarded-Encrypted: i=1; AJvYcCVk8THwOdg9qre/OrcXDyT4sgNMVyhOzNvfGY2mmzilCgYOve6ZlZCnG85G/GYpsT6YQq7ALlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnMu2maPOEgTSB/gCyFBLMPLSkw7u+5vucC6XQCyTBKqubH4o1
	Uu1RoqdBgnvADVG3AAnPs71eQows9vazuWsN5gpOdCzlxOXRf4iVHE3T1/jYDnYZvSuiqMWdLsM
	3XKnTO20r0i2Oaear7HQxz0qZ9isIz9ZuBxET3tE8/GYUTBF7j7ZLR8o=
X-Google-Smtp-Source: AGHT+IErW406J68fk8lzI9LE+Br5vIRWQbo3xGD7mtxZhp3G/swle8CJ+fMHpBuJiwZP8Jv49IExS2en+n4PALMBN85sEoQb4UpM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c27:b0:3a0:4dcb:de0b with SMTP id
 e9e14a558f8ab-3a057461e7dmr42929675ab.10.1725813782959; Sun, 08 Sep 2024
 09:43:02 -0700 (PDT)
Date: Sun, 08 Sep 2024 09:43:02 -0700
In-Reply-To: <000000000000932e45061d45f6e8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b685f06219e55c5@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in set_powered_sync
From: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
To: brian.gix@intel.com, davem@davemloft.net, johan.hedberg@gmail.com, 
	kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, mlevitsk@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 275f3f64870245b06188f24bdf917e55a813d294
Author: Brian Gix <brian.gix@intel.com>
Date:   Tue Mar 1 22:34:57 2022 +0000

    Bluetooth: Fix not checking MGMT cmd pending queue

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=138c743b980000
start commit:   f723224742fc Merge tag 'nf-next-24-09-06' of git://git.ker..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=104c743b980000
console output: https://syzkaller.appspot.com/x/log.txt?x=178c743b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37742f4fda0d1b09
dashboard link: https://syzkaller.appspot.com/bug?extid=03d6270b6425df1605bf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110c589f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139b0e00580000

Reported-by: syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com
Fixes: 275f3f648702 ("Bluetooth: Fix not checking MGMT cmd pending queue")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

