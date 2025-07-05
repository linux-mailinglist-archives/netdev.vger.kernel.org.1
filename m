Return-Path: <netdev+bounces-204282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4854BAF9E65
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 07:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75731C43B89
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 05:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B5426C3B3;
	Sat,  5 Jul 2025 05:43:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7CC264A7F
	for <netdev@vger.kernel.org>; Sat,  5 Jul 2025 05:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751694185; cv=none; b=Lrn94boPLgfZIyx7ONYNnHmm3cvcE7bvU6fbpfOoRqiHg3fNlOJurWdIbsyA/Td8bHaiS5m/iKGklCXFUficTpO52jwfy1ayNgbjk+cDTIicwe5mxovzYWMm/D5przuxKUC9wECuqpO+UMPh5+mq7YzTm//ahRoRUaRKNMbcBhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751694185; c=relaxed/simple;
	bh=CM6lUohq5ywUspKxV0/n4f/M5Qwl4T9xM2ssjXsyyY8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hfFs6xnUYDLx94IVjJLBEx+v1TcBEdyOMt8ELe54WE9ANEZ+94rKMkueWZbXwVt2HztcVWWDA0DzkEGUuriA1l1ABMydtE2WutVTNUO2l1Y3u7n/t2taz0fOugqHZu+/zRrBDyxxiZqQ9WA8HmiOfzXnzBT2sfOZoS3U6+XQxc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86cfff5669bso122657739f.0
        for <netdev@vger.kernel.org>; Fri, 04 Jul 2025 22:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751694183; x=1752298983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kc59fg6FdWXRC5411Fspbd54oUUViS20A4uqc5h8iw8=;
        b=b9BvBkstpJr48arHCEucWr8pE50DHzDR5gsBugFuuNzS2TbX7mVHkKGrPaX17Q5Mpx
         +el9UiF63i0RI6Kn43Fs3OuMk8v5XXyy4XAROmODOkZYxLN+LFfIhSBWmgsL/HPO67E3
         2OFs5jAdDwXQlZ8fvqFlCWq7a0IT8fBYehcSUs8LN88IhpkswbmPVdrLsXJYYDeA4mbe
         sSvywOVH5XP/a2H/yTuwQ7lFQgpK8IOlqdRivSH0/JFXJlFIZJ8HYFOQtfi4kgbFizIX
         zFUFmS/+IjKxQaa1gqiE5UCEjQCy6XOm2D/Ljmv4ctWRqp74tpc7syc0N7SsNpqryiKB
         Aodw==
X-Forwarded-Encrypted: i=1; AJvYcCVAsQFkPVYRYw6Ani3gh7YFXykBuTHFtdRcU98KQm7ocF+2wW/TrQxZHaHswKMRtrWttV/y/PA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAtZ77GetzeJ0bkUEDhwXHliNvalioRCsOm7A8AqrRWpAKPlpz
	Ikl0a3Ft/iRDAS3p7xZMJC2ptxoJnHX0LiYcU81KNVWbmXvc30PUCaUUo1vsMnpS/ixV7QGTuCf
	xYJW2J12GHEa5ZbcicfAKLacNLWQkNB38khN6bNXuXH5GWBfGAnQi6vJsf2I=
X-Google-Smtp-Source: AGHT+IHKt+Afq8uNiZ9S2sR1SyxCRMBe2UUFBU7QoKGVD21ViQHiJ+1y1AdJHX+nIHjV3T0VWiAIXxwifJ+YCX7rXIQCMHH9HXY4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178d:b0:3dd:e6b2:1078 with SMTP id
 e9e14a558f8ab-3e13483b9b7mr46830485ab.6.1751694183116; Fri, 04 Jul 2025
 22:43:03 -0700 (PDT)
Date: Fri, 04 Jul 2025 22:43:03 -0700
In-Reply-To: <68663c93.a70a0220.5d25f.0857.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6868bb67.a70a0220.29cf51.0032.GAE@google.com>
Subject: Re: [syzbot] [net?] general protection fault in htb_qlen_notify
From: syzbot <syzbot+d8b58d7b0ad89a678a16@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, nnamrec@gmail.com, 
	pabeni@redhat.com, pctammela@mojatatu.com, syzkaller-bugs@googlegroups.com, 
	victor@mojatatu.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 103406b38c600fec1fe375a77b27d87e314aea09
Author: Lion Ackermann <nnamrec@gmail.com>
Date:   Mon Jun 30 13:27:30 2025 +0000

    net/sched: Always pass notifications when child class becomes empty

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14c9c582580000
start commit:   bd475eeaaf3c Merge branch '200GbE' of git://git.kernel.org..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16c9c582580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12c9c582580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=36b0e72cad5298f8
dashboard link: https://syzkaller.appspot.com/bug?extid=d8b58d7b0ad89a678a16
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171af48c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151b33d4580000

Reported-by: syzbot+d8b58d7b0ad89a678a16@syzkaller.appspotmail.com
Fixes: 103406b38c60 ("net/sched: Always pass notifications when child class becomes empty")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

