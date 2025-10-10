Return-Path: <netdev+bounces-228470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05789BCBA5F
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 06:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C1D188E5A0
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 04:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3401E25F9;
	Fri, 10 Oct 2025 04:42:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1610842049
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 04:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760071324; cv=none; b=CkAevuMjUQ0X0svXbYkHo78nWtYvJ9+KVrYPi/rKsx4cXOx2wRsd5s8WZzrIVPkYFusJyQKcVLwNoLUSmbjudZecJAoyBDBWT/bIhvbtBFpMvIdcXXlVOeMTRMRzf4nwcPF4Fcin+sQjLlPYS8jERXw0z+EmJ562QwuitDCwXNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760071324; c=relaxed/simple;
	bh=1VDZnFcdkka0Jbb4CKUO/9txL26UlC695CZiL4II8Eo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GGJaTTuvxlGpsMpVLK7g4PVJ/K4H99nXAskFLrW/RTFUQCwYSkaKgbaVTEk8JAYE2T8SjC9/jP6PBsshTLYeEkEP7jLn7Qw1m6w13vOn9E271XtjKr2uWRyEKaRszT97eiyzGR1BHZX/koQb8GqTu0F37rQ/J2sHl2JAwDjvtjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-92d4dbf9b51so874656939f.1
        for <netdev@vger.kernel.org>; Thu, 09 Oct 2025 21:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760071322; x=1760676122;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZidNZTklcq4/vt7PVJN1I6R7vvJx/VgNKHeWQT98q0=;
        b=pPKqDDbDNepzbU/iofqNg0OYevVFrqOepEFvs7muT5l2iJy2Q/7NRGvaeD7OzmRTRG
         RoihcVlXURl69s73SEwe7IwTd7DlZmGVqt10hEt4+Wm2MBYxmSRbtO0CzSLkDFfyfbsB
         MRC1GxBDQvgBnlXoFlrz7cXR4JHFiSD7xMuF5+U37qgsLvLK8RpHntxh+OQAiyDTvt/S
         ame0GlKbGU+NsS0fi/7jLWDrVBs1k92HufnT3uKoR+43pi6z4esqnUgMWnXFBG9tkBlp
         5lDHWcA7eTnRF6tH+kuAsa9bfe3qwicara86BTKD2svtazAciD4+KZxvcHmMmtC/KvgW
         dx+A==
X-Forwarded-Encrypted: i=1; AJvYcCVjF2SgBBKpwjrPluFV8bar9rBZtW3yjxWqG4/H0xldlfWFAzWV5H6PQ6Ae+g6IzBQ1nw+lY8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFX6kEtUA6H9CQQ2SRRBK9x8UKnXXhHcczsAUHI9b3UScP0xMG
	PmyFCg+Vsda2e8UJvdU1WQVfVnZPQFlfwE8VOE/6Hb64NsHNVe79Y+PWtnHU/begKcn0Wl88zB1
	WPE/opN565kIzr8MRmq1RT4oa5+bMPa9q9UcfBlJHNCmdR3k1I3KZ+fudXPc=
X-Google-Smtp-Source: AGHT+IHoSJV4rDlQQyVNKm+Pipk6971WMA4WXlwDwcnGJXFDn/oDOaXr6hXEg3dXpOTMbudE3ZUpy51N0frIqlmIqV5ARPFApVV0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:60cc:b0:8ee:816f:ec7 with SMTP id
 ca18e2360f4ac-93bd1936e49mr1209219039f.11.1760071322254; Thu, 09 Oct 2025
 21:42:02 -0700 (PDT)
Date: Thu, 09 Oct 2025 21:42:02 -0700
In-Reply-To: <68e7e6e3.050a0220.1186a4.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e88e9a.050a0220.91a22.008c.GAE@google.com>
Subject: Re: [syzbot] [net?] [virt?] BUG: sleeping function called from
 invalid context in __set_page_owner
From: syzbot <syzbot+665739f456b28f32b23d@syzkaller.appspotmail.com>
To: ast@kernel.org, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, emil@etsalapatis.com, hdanton@sina.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, memxor@gmail.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sgarzare@redhat.com, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit e8d01330225210a8af55f5683fb2ca726717ee16
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Thu Jul 3 20:48:13 2025 +0000

    bpf: Report may_goto timeout to BPF stderr

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11d19892580000
start commit:   ec714e371f22 Merge tag 'perf-tools-for-v6.18-1-2025-10-08'..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13d19892580000
console output: https://syzkaller.appspot.com/x/log.txt?x=15d19892580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db9c80a8900dca57
dashboard link: https://syzkaller.appspot.com/bug?extid=665739f456b28f32b23d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138591e2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fcb458580000

Reported-by: syzbot+665739f456b28f32b23d@syzkaller.appspotmail.com
Fixes: e8d013302252 ("bpf: Report may_goto timeout to BPF stderr")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

