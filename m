Return-Path: <netdev+bounces-106749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 092E391781B
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 07:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F621C22832
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 05:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD29143C49;
	Wed, 26 Jun 2024 05:29:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B04F14264A
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 05:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719379745; cv=none; b=Wpyx1p/N25GfSBEGdQmKlqCiVAgfvBd1NpvfcTam5wZEoosMS1nP5NYDx4VROn5QqdTyobAqp21hTy5NvK5T+FzvS/dpEg8FjKGHC74iZ0ligeVlQdwLFAQltjox7QdweLv9Jx2aHrYrVEkwhzg7t57YAc5BaVCv2zRpHPL0f8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719379745; c=relaxed/simple;
	bh=z46Img2M9tES2OAFsmy0WpYkrZexbG4QVHz5Vc5X7Zk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SlSSFNeoq5+jzHyM1Orz2V/+l1RFdfbEJS4dRj9aIsWlWdDfB1gFG7x3YxZPACmxXf8HPLHjbM4KmFrSKdU0yU6zCgqQO9/At18Ye5xLqEmqf1W3YXCWCG/hZkLDxJLtUBqRi9z1WlsvZm208DwD85zC+zLuzclBGuHjWU9drbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-375df29cb12so78521605ab.2
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 22:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719379742; x=1719984542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7jLFVxsran+Hxnl2Rjm/F6ukvXu6ukvDYfTlI6b4gg=;
        b=KflX0mQFoJUT4FeioA4OWntUwOvuxLxamJZahz8/F5yC1njkCXVkPVcI1VMqMpnGjf
         q7duXYr8AtMjLCmxFbT8mxgJYa6YLi8h/p4XZizty54g0hydtlS+AQL/q6bFY9dUMTOS
         0TFT/CkxVrWSc71TbOQVy0SQOs/tWFYOJn/MvjkFTIo11A+k/v5sJqoRoRFXhYwmtmT0
         7PJdOIY1vBDatZvxP0WszWzEdnJGSXDQDT8DcNP5K9kwV89YB2IaFAWT5smVPHn56d1j
         NMMQsns2Vccmv7HmJuCsiRyD28oY1OkcEz9T6qQXJS7D4auSMaHkqeOloBCIpM5KqlOk
         mV6A==
X-Forwarded-Encrypted: i=1; AJvYcCXAHnZDMrBgRN4FAMLNc+9YZZ6lYvhypbMbndrx7l6nUR7Rk9mpOd4Nsp1l6kxE/O4C/ZXad9njKgXOJwD8zvPXCkHk9fHW
X-Gm-Message-State: AOJu0YyR2HNHs6zEGPXvuaG6PfHxdEck7Le4DmlPoCKUjao3Pxkty1qX
	R7/YmlLl0I2XGfVBQoQn5IQ+t91PEq4Bk+VFAoFNzmBb7UYbH8WtyF9y6YXjkXZPYD7lReWme4Q
	WjnSkrWl2hxagaT+IG0z8i6shQxPGE4d43faZUZhrkqOKD98ppthwJGc=
X-Google-Smtp-Source: AGHT+IFlgf0qW4V2vp2uiO2LtpRA9jZ0J28yl5GlbXreZyyCGWbyKG3jnTZuA0un7Ca8uwcdDb/1n51YlQ8U33kMNYg94mF7vofE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe7:b0:375:e698:d0f3 with SMTP id
 e9e14a558f8ab-3763f49d3dfmr7074855ab.0.1719379742684; Tue, 25 Jun 2024
 22:29:02 -0700 (PDT)
Date: Tue, 25 Jun 2024 22:29:02 -0700
In-Reply-To: <0000000000009ce262061963e5e4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cc087d061bc44a72@google.com>
Subject: Re: [syzbot] [hams?] WARNING: refcount bug in ax25_release (3)
From: syzbot <syzbot+33841dc6aa3e1d86b78a@syzkaller.appspotmail.com>
To: davem@davemloft.net, duoming@zju.edu.cn, edumazet@google.com, 
	jreuter@yaina.de, kuba@kernel.org, linux-hams@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	ralf@linux-mips.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 9fd75b66b8f68498454d685dc4ba13192ae069b0
Author: Duoming Zhou <duoming@zju.edu.cn>
Date:   Fri Mar 18 00:54:04 2022 +0000

    ax25: Fix refcount leaks caused by ax25_cb_del()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12f83301980000
start commit:   568ebdaba637 MAINTAINERS: adjust file entry in FREESCALE Q..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11f83301980000
console output: https://syzkaller.appspot.com/x/log.txt?x=16f83301980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=33841dc6aa3e1d86b78a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=121324ae980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1607cdda980000

Reported-by: syzbot+33841dc6aa3e1d86b78a@syzkaller.appspotmail.com
Fixes: 9fd75b66b8f6 ("ax25: Fix refcount leaks caused by ax25_cb_del()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

