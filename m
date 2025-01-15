Return-Path: <netdev+bounces-158415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B41D7A11C2D
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3C718875F8
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 08:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8941E7C10;
	Wed, 15 Jan 2025 08:39:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F511DE3D9
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 08:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736930345; cv=none; b=ZY6PviVmPpA3QHTvuicUzSYC4xiB9470oThNErBO2X828ZbQH3IPRI3tYU/Ee1jWdH8LjsUgsA8g3yba9JCWDY70OTsNpkh66Jmc2w0ULCkvUvbr0/ZfM+WNfwbLyDKEHv6xVipUHFjAxRt8ih7NTtzvArfAkOwOXzaLabuBhUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736930345; c=relaxed/simple;
	bh=Y24pZPuFwPFR1VZHcEMQpqo7yKBdVDnnPlgKCXjs+iY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=K/CVhGeBPUhQOiyrSM8DVfcLJWtJR4WbHYBVLuY0umMzUlUeCgwdoP7B0gNhq2K8B56BZ2AO4QvLBmc+QYdP5XC8D1DLf4q6KcxU/NkG/FUzn55CO1zY2fJq9AOnvnktw/E5VSKI48zI+UMj3j/CKLc3cxPBW4EWBOoOHX0V5C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so16741065ab.0
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 00:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736930342; x=1737535142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ta5z2IK+7I07RU1ai/knZKO94BiSdaHRFL5TZfBCeEQ=;
        b=NQQTIQAC+/pVjjg8QFOWoqZKO4TpOD02KJR1buFSALWppqZi4QT0BJR3jTPQnLazjD
         7k7RXIY3SKeK7OPqZMZ7gTBKwPlaq24TvhT0ejaihtYFrPAp5i1PbAUDJfZ5+NaDigm3
         Dmfd0ybztkAY1mH0+iXkviD9a3OaJFfZJoP6759gzJhTl9WSitnIqhp1pkprPjaqVckG
         C7igZZ9Uye+F3Gy9VUyh1jvUmc1i1+Hqb341kf9IU2dRw3Gjg2N4VJaAOCvkB7LgmarG
         PNNhZ8kNiA16/hQFg372mD2PJEr54x2yt4OUhL90Go1KqMppCs1aYo0tYqWiDtjq86+x
         ryRg==
X-Forwarded-Encrypted: i=1; AJvYcCUSTD5HcowAA7lj952jrj+GvozsPO/zRIwzy2PjFaSResxwWoyY44cXZ0gryTElKe6FDjmEEnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP42iy9w0Hj6/eK7O7IH/INseYUdJfaJ/i1NdKnBqKLchtuUTe
	NKpS3NzIaNoybxUvxNLS7Aj5/WyYtfkGRpZrQSYPsuUegAFKb8EE/vEkWctklzTfTp5CJFsTJPh
	9IRW5rCTSykGuh5rXFGSA9+iQexVgEpAFGCgqm7CfTf7zleBCDwHsqAs=
X-Google-Smtp-Source: AGHT+IGBUSwrbDRmXtiHaqIZSAmvQ3odCW/shzY20iSKtiAv92ooamYnIFaosuQJLlCINwHHbzf8lnxHnEoj9TfCiaVFm7wp6750
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c9c6:0:b0:3ce:64a4:4c32 with SMTP id
 e9e14a558f8ab-3ce64a44d95mr102162105ab.3.1736930342600; Wed, 15 Jan 2025
 00:39:02 -0800 (PST)
Date: Wed, 15 Jan 2025 00:39:02 -0800
In-Reply-To: <6712465a.050a0220.1e4b4d.0012.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67877426.050a0220.20d369.0009.GAE@google.com>
Subject: Re: [syzbot] [fs?] [mm?] INFO: rcu detected stall in sys_readlink (5)
From: syzbot <syzbot+23e14ec82f3c8692eaa9@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, davem@davemloft.net, frederic@kernel.org, 
	gregkh@linuxfoundation.org, jhs@mojatatu.com, jiri@resnulli.us, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tj@kernel.org, 
	vinicius.gomes@intel.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 5a781ccbd19e4664babcbe4b4ead7aa2b9283d22
Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date:   Sat Sep 29 00:59:43 2018 +0000

    tc: Add support for configuring the taprio scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=124487c4580000
start commit:   7dc8f809b87d Merge tag 'linux-can-next-for-6.14-20250110' ..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=114487c4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=164487c4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28dc37e0ec0dfc41
dashboard link: https://syzkaller.appspot.com/bug?extid=23e14ec82f3c8692eaa9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1634f218580000

Reported-by: syzbot+23e14ec82f3c8692eaa9@syzkaller.appspotmail.com
Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

