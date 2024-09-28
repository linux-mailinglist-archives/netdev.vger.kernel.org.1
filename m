Return-Path: <netdev+bounces-130191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7346D988FC2
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 16:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B31E1F2179F
	for <lists+netdev@lfdr.de>; Sat, 28 Sep 2024 14:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415F0168C7;
	Sat, 28 Sep 2024 14:47:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99542FB6
	for <netdev@vger.kernel.org>; Sat, 28 Sep 2024 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727534825; cv=none; b=U8eWYiBdmLUAYAMYoJBI1w1w4iIjKEBSPV+Qlal3vz2ipgaajPB+xeJ3CncqGktnWSamOPSsGxgW4C2nY3+UyxH3SCCwB6p1mALi4Drmc0aZyC8v3eMOSm/C9rRMG5ghsY0gJI5HFWPBk273CYR6IgKUY61k10FZ+9sYAs8Rozg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727534825; c=relaxed/simple;
	bh=lx7Ifb9q719owpGrIkO2jtwN2HKzH6UEVno5u3b+iF4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nWKxwkhIKKhpO8gy0B7gqUxcwZuSbxBrFHDlwjofYFTpoi89yRrOrZXgaE6yOnM6SN0O2zY/X0XrFQ+Tgq0fQuwA4y0uLzCh4Q5NYkWELG25CY5hKf87TahKFX5e3QFTIAJka26vX1z//IsyE+zLrYS+vMvf+mMqgnOu0YVFU4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82cd9c20b2bso373950039f.1
        for <netdev@vger.kernel.org>; Sat, 28 Sep 2024 07:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727534823; x=1728139623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qS3n76UGkCFfSzpWf68kEL7cLIcUZy/Q42VybJ4lvPc=;
        b=BxRB9BsZyViyfcXrhnsSDPFuhJjAPpVbvNFTdlqWIqZNv1StvVBlHOj2KTIl09kFmF
         ulwkOch+tmpBUpdyHFfObjEm+g9SO19GaOk8W8I5y1V+FDGrKDxKjhto36bXBKoz6M6c
         /C8dMlViGSuDTmQsys7+dcqsLAkI3Ogv0Hkgu4HDw4YQbB+zeytOzLOg08Tbw0NXjMXa
         urkEk2ByabWsdMFqIokkeJshdrQZpHoak0zFUJSzci46Zk/06fiWEAr4cHabVl01RcDc
         lJnJnwqVZBUKha74a8EkQzxHDTzQJuLFnK2BjBwtQK48TfNL9HvTA8u+gqOdz/Scp4YI
         BROw==
X-Forwarded-Encrypted: i=1; AJvYcCUmZfQjS7jumsTGad5l2lSVgZpDNw+Vd6EudOTJq33J+lkHxOhu+tX9fE30HLzoHBhmZmlZ0K0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOgdkKXj/fM0X8GyBBx7sz3comeocgH4kqV/rKkSGei0z9fPDt
	Bw7D/HUEgbklkL5P+gcRYY5jWUtMgdVJ8FGlaPFjJ/tvVZROpuzkwYpFKxG63a3coHAtIzPnFxK
	ior8T4kbrHPpQdLZokCM7pVKhmgBeEnzdK8PcV8l+uYrZX3xoMFCaotw=
X-Google-Smtp-Source: AGHT+IFQPRWXJ8MlIWkc8iJvXKX8p5A6JpNeYO/NKPlG50WuJZZ4zc7BrIPosH16IdW8xqGLrFONOFk/JPLQ+xYj3mCLBIvJNAzl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a08:b0:3a0:92b1:ec3c with SMTP id
 e9e14a558f8ab-3a345161e57mr58864265ab.4.1727534822873; Sat, 28 Sep 2024
 07:47:02 -0700 (PDT)
Date: Sat, 28 Sep 2024 07:47:02 -0700
In-Reply-To: <000000000000aefb4d061e34a346@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f816e6.050a0220.aab67.0004.GAE@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in linkwatch_event (4)
From: syzbot <syzbot+2ba2d70f288cf61174e4@syzkaller.appspotmail.com>
To: bsegall@google.com, davem@davemloft.net, dietmar.eggemann@arm.com, 
	edumazet@google.com, jiri@resnulli.us, johannes.berg@intel.com, 
	juri.lelli@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	mgorman@suse.de, mingo@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	peterz@infradead.org, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, 
	vincent.guittot@linaro.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit e8901061ca0cd9acbd3d29d41d16c69c2bfff9f0
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Thu May 23 08:48:09 2024 +0000

    sched: Split DEQUEUE_SLEEP from deactivate_task()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ce9e80580000
start commit:   075dbe9f6e3c Merge tag 'soc-ep93xx-dt-6.12' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=102e9e80580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17ce9e80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b2d4fdf18a83ec0b
dashboard link: https://syzkaller.appspot.com/bug?extid=2ba2d70f288cf61174e4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e2c507980000

Reported-by: syzbot+2ba2d70f288cf61174e4@syzkaller.appspotmail.com
Fixes: e8901061ca0c ("sched: Split DEQUEUE_SLEEP from deactivate_task()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

