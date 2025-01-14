Return-Path: <netdev+bounces-158133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E20A108B4
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 15:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E452516ABA8
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F6314A0BC;
	Tue, 14 Jan 2025 14:09:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961C01494A7
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736863745; cv=none; b=fWFTaVX0H/467QWit7jFm3h9z1tu/WCCXw9huHmuhT/e4SdJi0K6i4WJqlLh8yjh3kCfyDFTOD7Q0EybAbqPVAKO/jHBLhdNJJtnKncghy+CxLCZUgdfOCrWZ5uQoDH6CY0WbNMCEkDOU41WENUJse5DFN25oa0+f1u0ESksiFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736863745; c=relaxed/simple;
	bh=/bd3ma/dAD7l96Or7WAx0hfZjgtiDmfL11Y6Li0f3TQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=m2Oc/mfgk63hp8RB54W0ld3x+zG1tXFva3B7FV/5DkbfsZ7mPl/f475Q2oMLgbm8uKZ7+xd4pLe2bb/TZJRGlOGaQll/7v2Ri2noToV6Gt91JKSM847WppelbaGw4RcgPPl7tcVCkTPMXFhoiZSfwBAh6IfbSQvchpiijQoD5b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-844e5b72c69so978441939f.3
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 06:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736863743; x=1737468543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=joZ1x2i8obqtOPNVFLbKHrDgqWfAhM7RFuwpd/o9wy0=;
        b=fNEPg9xL2w3iDzKQjflpqmX9KJrPMjg0YvyTmtGcW2dgWZMU72r+fHa1/2xQ3gLNoV
         +f+F4Y6751Bnh6fvL7XYYenSN9pWA/S1DTKzxOQQJZvjaxI3YoR2J0vhv9yWwXAk8oMi
         XdC80A9wjmeelpM/BZ6g5VERCvb9+X0AOvK/JBj8mFyzHuDZ9xjlJ3ckf9LWpDVnsang
         MgQFu1dt82nYpEaW+kfp8rcrYhy5tbFEc9TTbcGJ/ocpzMVcIF85i20FzuQWwHTBw7f+
         bYOLjQUIudkBnigLkK7IZj9zPBst0VHITTkPTSPsls4cPeN6jCz1A4r7UUhKQtx6sFl5
         byeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp103LWawOSEwbESdT49A4fLQl4qbNTOoch4FCUWETufzvvn73Iyt6mzj/2nriD4tjADXwXDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwobIDsZ2qOhEuVr71Z8+RXfCUOTJipiVCrtet6NNks2K+ot84Y
	SuiJaqknHdikamxVSLSbLgMlkb6zDnwGQnjA4c2xb1L4wIanh5hodK7Bd3zbmfgILEPz1/tOxVa
	z61W2cq3/Jqy7RCZYC7PTUFJ56+1IVsS/pW9ioqfi/Xu84he3mN3X+M0=
X-Google-Smtp-Source: AGHT+IEOwFv/959LrZgUjPZ1+PGyTZgehs5vYxH2uYC8tfJTvl9pvj9M6c3Kff/OwMLktJ6EDRBHCZ+JXxJHBLsqQqbLuJDiZdu9
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f09:b0:3a7:e0c0:5f27 with SMTP id
 e9e14a558f8ab-3ce3a86a220mr220941785ab.2.1736863742784; Tue, 14 Jan 2025
 06:09:02 -0800 (PST)
Date: Tue, 14 Jan 2025 06:09:02 -0800
In-Reply-To: <00000000000070784806124596ec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67866ffe.050a0220.216c54.007b.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_send_cmd
From: syzbot <syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hdanton@sina.com, 
	johan.hedberg@gmail.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit e7b02296fb400ee64822fbdd81a0718449066333
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Thu Feb 1 16:18:58 2024 +0000

    Bluetooth: Remove BT_HS

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10665bc4580000
start commit:   ab75170520d4 Merge tag 'linux-watchdog-6.13-rc6' of git://..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12665bc4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14665bc4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c541fa8af5c9cc7
dashboard link: https://syzkaller.appspot.com/bug?extid=31c2f641b850a348a734
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11261edf980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fa36f8580000

Reported-by: syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com
Fixes: e7b02296fb40 ("Bluetooth: Remove BT_HS")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

