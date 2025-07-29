Return-Path: <netdev+bounces-210880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2F1B15312
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 20:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C86561B7F
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 18:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261D925394A;
	Tue, 29 Jul 2025 18:47:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4B4237180
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 18:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814832; cv=none; b=fkH/2nTcbidLNysUxNvtXS6x15xs7mWzl6tMdiX/vooU8JD4TK4r7W7HFS+At7RUDRKypFkOK3CXCSHRBaSVca7mNnt0oaw+Is3DLdZE7cf2t1ottiJV9Frp+6BGqbpL+gqNCQsn4ItzvO868Oj67jtXByIF4dhYuHQ4eueG6yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814832; c=relaxed/simple;
	bh=dJquwTid9tF52hRjBWfKnIo1339t3mzBrAkjXAzfhbI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eaXpuRkbM8gLx+oy3F8hd1evmO7yLTVojNUXdxC8Q1Csq4jBDjwjFviYB3+6cNwhxGN+DtccSwOZzQBiu3hk8ivlR8uDExCemSwF0UpANyDB/5GpIgRqUrYnWa1BX+irVVoQip3s/jQ3DJeGT1xPA6175uBLmbFoWEDjyT326H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ddc5137992so71409195ab.2
        for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 11:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753814826; x=1754419626;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cKd3St0RrZp1EfD+ZBL0RqGv8txDOXUCQcCl+2+1qpU=;
        b=VGidCSmt5OUZc3SYKYW2QnVPOk3p9q40yaINzFVhEZAkWGRN1l2vjtUXyv3p1HxKMj
         tlGjed3djQJiIauXWt466d2WaadkRmK7UBJANf174ihP6RGMJ79hC2U45Ck/deUebcmY
         SEKhJI/APr951UtsJ3Hlg17m7ZzD0gBnrQdSCn6F0np4GsY4qSLSxerkwneBTJHXK4kO
         7hsO2F7nDKEtDLWhy3MqRfsPjvz6A6e0Wffp8kr23a1+Q68RpKreAT+RKiSWY8Gs4YOO
         L2rtnsVgO835tU4UNtGJDKfqXZTnJX8TR72VK3Uj40N2ihTkyE4VlhG4b3tWqSn60TC/
         PmqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuvdf2rTSyoNUDFIHH32XLxPM3UnWPxXgorykCimT6hS375nMJdP6ZafpYno2cHRUJxgeJvNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR1hp9T1TpVxfaimpi+I1fsOFLjaKQ4POPyhIL93YWvLUlU+LJ
	z+1pYYMmMs8iFvLNhyIiozfLZdiL2nUCIpIOE6DokuZsjLAcNTZmInIXc0n5tRB2HjRIZOr78fS
	0HJfHse5+9a3npwdWzOXOV+UsTt7RybN9dude1iupofWjnQoq+2/L9dyCAh8=
X-Google-Smtp-Source: AGHT+IFEGANFC6sFs0qxttEtpboZ4OLIeGa6jj7ufGyldWSrrqMfY3EEdsLhOqh4ozMAOoH19V6rVvg6f8U2ez4U4YcsJ+stxzpm
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5e82:b0:3e2:9f1e:e291 with SMTP id
 e9e14a558f8ab-3e3f64ae682mr9549805ab.21.1753814826062; Tue, 29 Jul 2025
 11:47:06 -0700 (PDT)
Date: Tue, 29 Jul 2025 11:47:06 -0700
In-Reply-To: <aIisBdRAM2vZ_VCW@krikkit>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6889172a.a00a0220.26d0e1.000d.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in xfrm_state_fini (3)
From: syzbot <syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, sd@queasysnail.net, 
	steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com
Tested-by: syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com

Tested on:

commit:         86aa7218 Merge tag 'chrome-platform-v6.17' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16eb74a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6aef71a615d0cdf2
dashboard link: https://syzkaller.appspot.com/bug?extid=6641a61fe0e2e89ae8c5
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14b29782580000

Note: testing is done by a robot and is best-effort only.

