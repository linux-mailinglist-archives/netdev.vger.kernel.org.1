Return-Path: <netdev+bounces-110789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C47592E5F0
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 13:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B19F0B27342
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 11:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2234715AD9B;
	Thu, 11 Jul 2024 11:11:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950101591E2
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696265; cv=none; b=hwwP+Az2C76G4x+02GRd3uOvVyhmGaoPt1si9yLc6tnOSqoVdaYZtp5zw4x8d0UAdQxdWHZ/RqXYvnz0XW/lRgZAgAkTVd/nblLIGTptOobO5g3eMqBz7asLxU/AfSnVT47ltJcM+mVtnKmZ+/aGtL2oCMmQ1030LDMKuFJuYeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696265; c=relaxed/simple;
	bh=0ZwX0N6cmTcPU6cUOhbMilU6Yelh76r3rbVgmSzYq0s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h5zUySlR6wZVgrdepv/dDFxw61QjWAy984keNusBgKZVumYw4/BLb2kfryzV3S6ZyQ7GjdUhofzfGKA5rFjyw6C77AmbTJcvfUJFf04oU33NXBGInp/DnXUW/5IcwX4caq3pcIvX91kNwgZkEMaOHtzAwyN7uwWIGe8yW1oU728=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7ebd11f77d8so82598139f.1
        for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 04:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720696263; x=1721301063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hxg3UJPkzx7M07gbZ9SOx2eod/ecUaN/p77xgE8W3KQ=;
        b=qovGIhou80sF9CIuy8vDWl2LVs5vXjOSc+2glAKtULEXs6GnCYM0pN58783VyHX3O8
         2orL8I3Zx5G9kztbIDcLsUTAgQXu04pBWU1GAQ9dD9ijC+zQKX68uVx0FhCE0RGqa57c
         uMZ2m9ffbDp8Jm5ktn/avyZDG+ZuXeE6CJrPPQniOecAwCWZjr9aq6TrWZwjHnQDfpBH
         d+gTWO8rDYu7SiNWZSwFim6U2mmWTqAIPJjuUqEmwHU781ieefRCQorGaorp/F92B8UE
         qT84XK6C8Raqg2BuNLiS1Et/2gI6AFYfqFoHyQ++CxA+jCYK2gZbUwsCPjUAQRFvFp4E
         O6YA==
X-Forwarded-Encrypted: i=1; AJvYcCWqvdRof6e5CaaFBo2M/bQ6P3vfWiMXNQ269zJjMU+lpIbOdN57XV3dONT0YkRc1gdTyqASfDQpRS6V+XO/2te94j5xdhcu
X-Gm-Message-State: AOJu0Yy651jyFQ8e8JrDuTtPXe9m5+kLAK7mVf7Tv8/Sinrwvv3Br1NK
	Lm79wk6Kdjo9YTwPj/UEdSMbzvHXMqud3VKriSlpqO4Gtm7AiUhfS2/d0d01w8MpKUK7wTrLe/e
	eYHhuSuWAWj/dUiLO7+m1eFAh1rYVVkBya4PC6acojYrXqoePmnfCBjo=
X-Google-Smtp-Source: AGHT+IGBjGi2u0vQwkoJ9T1yTRI18dBxcqWGmgtHOfjU9ZTmOOpU364A1mpSXTEejum4DWNhNasVTJ0VRDyOX29dVNI3xFSozQ7R
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8601:b0:4c0:9a05:44c4 with SMTP id
 8926c6da1cb9f-4c0b24e9f62mr482571173.0.1720696262760; Thu, 11 Jul 2024
 04:11:02 -0700 (PDT)
Date: Thu, 11 Jul 2024 04:11:02 -0700
In-Reply-To: <0000000000008ac77c0615d60760@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000822b8b061cf6d171@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in sys_wait4 (4)
From: syzbot <syzbot+6969434de600a6ba9f07@syzkaller.appspotmail.com>
To: alsa-devel-bounces@alsa-project.org, alsa-devel@alsa-project.org, 
	broonie@kernel.org, davem@davemloft.net, dcaratti@redhat.com, 
	edumazet@google.com, jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	lenb@kernel.org, lgirdwood@gmail.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, oder_chiou@realtek.com, 
	pabeni@redhat.com, pctammela@mojatatu.com, perex@perex.cz, rafael@kernel.org, 
	shuah@kernel.org, shumingf@realtek.com, syzkaller-bugs@googlegroups.com, 
	tiwai@suse.com, vinicius.gomes@intel.com, vladimir.oltean@nxp.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit fb66df20a7201e60f2b13d7f95d031b31a8831d3
Author: Vladimir Oltean <vladimir.oltean@nxp.com>
Date:   Mon May 27 15:39:55 2024 +0000

    net/sched: taprio: extend minimum interval restriction to entire cycle too

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10593441980000
start commit:   fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=6969434de600a6ba9f07
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1091a5f6180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a22c13180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/sched: taprio: extend minimum interval restriction to entire cycle too

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

