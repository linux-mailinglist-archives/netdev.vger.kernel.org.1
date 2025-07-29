Return-Path: <netdev+bounces-210748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 618B9B14A85
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 10:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9DD0188CA2B
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 08:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A5A286897;
	Tue, 29 Jul 2025 08:56:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A470285CBD
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 08:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779364; cv=none; b=I8mG4oC0GH/CUZMYRtT5Z9WeNSreZxlDEbaCExADA+tUA/Q77gvzxfkej8GDxvYJuelH+VkZBq/zohyjcqkI82jtNZKX8U9Agfp3Qve9Gs8VrgMnjUpwnyAwPceaHl2UINsA9MNdPzOWtn1TP3OvqCXxrBGfwCh+fd9Bd3EYChQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779364; c=relaxed/simple;
	bh=uBjlPTSujMJnq+adL8AQHG9GvvL9ojVDTJ8XvBEl+Ig=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bXJeZ8ANTtK9CoTrY14ok/8/ZCL+FRTWDnkMoej8pLzAGrTK/rSWSG0j/rvbvUodfxNx/dn7yGMYDyyGulKY+jL8z598g+YTBNh/6TI6nAbUMFk3414pEY5eOs5wQ9SK7i7CipJ2UslnoAumtwIFe9vLQdpl/hbjZRyyNwJlY8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87c0e531fc4so1282936339f.2
        for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 01:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753779362; x=1754384162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jlHNxi6fbgmpncRlD4B+e2NWpW9TaER/WSxCeS0bgh0=;
        b=kGp8JinMJlQwtS/iQdyiMDII1H4hGXhJhY2VT86iXYRx/sWyxxi/bbbYHFAhlagNG8
         19VRCGQfGyUZP9/EPteKOYr3DkRp14pAsT0NhJ8yZeRsGmGbCMEet81SEWq86/u+mx4H
         jU137q3ooiu7vVezq2MpA2eYIVbJR7bBEgjgBiUAdwKKTxGtgTVROBTnzz0bvkGo6Cu2
         tSCJS8Qf1K97HVBittcgev4d0TzMBpRWYsoSJM56zITy3snMqMG+PLyNsVk2M65AWb8p
         +ix5zhhKDKd8F7h78mH1dUO2i/zXESF/jLYF/10LNui9Z8itvhB7qeN+No5FnRfT18JO
         7lWw==
X-Forwarded-Encrypted: i=1; AJvYcCWMxVEkczGPw5BlwOHXrfl3o2l/N4jxmR45kljlhnuAOQKct2RXaGkdR328c6xe9WedmQk3SuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr+QuRLzmI3xVj+FFiKYFzjNj1qM+PVreRL9urSQ0kxeQUGxJH
	KNvHCLFEy4ehxq9i/SXHOFY0Q36Xc5nuCHuNolLP5juQVvBccU3EJ91VzFwFeY6a70X5obST7Nl
	kIbS238IT/SDx1fv+r5uR1bgD1EUBcbNbGe22KNHtFOCKvQQjrERV+BITmYw=
X-Google-Smtp-Source: AGHT+IEDK/1RkYgL4GVGXQltD8EKmq+l5LGMj/Z/HdZqdOw9HDMwzpgSQ4PEQ5MKZoIuzzePtUJqsR/qq6gvOPv5MKRU/3ZdTqq8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1408:b0:87c:49fe:cafe with SMTP id
 ca18e2360f4ac-8802298192emr2690950839f.11.1753779362649; Tue, 29 Jul 2025
 01:56:02 -0700 (PDT)
Date: Tue, 29 Jul 2025 01:56:02 -0700
In-Reply-To: <20250729072234.90576-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68888ca2.a70a0220.13df61.0000.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-out-of-bounds Write in __bpf_get_stackid
From: syzbot <syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, contact@arnaud-lcm.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
Tested-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com

Tested on:

commit:         cd7c97f4 Merge branch 'bpf-show-precise-rejected-funct..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15fe44a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=934611ae034ab218
dashboard link: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11bbb4a2580000

Note: testing is done by a robot and is best-effort only.

