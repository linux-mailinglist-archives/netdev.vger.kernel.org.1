Return-Path: <netdev+bounces-113764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58F193FD4D
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 20:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0FCB2837D2
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 18:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1626B183087;
	Mon, 29 Jul 2024 18:27:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A996783A17
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722277626; cv=none; b=L3XTG2Q9mNe6HqzlGJYBMvfbgZPQ2do/CtELl4Ysjgu3a2V39tJsGp2fjXSHDfrbl4jzWRGzTVJvZHnv9UX/iUqIN5YxOIGZ6bME2K8BBL/ytHeiIIHK2s5Lq+2A7iWNC6NA5ONoNkiS0t7z8dE0Yo83Pgns8GJvFBwkb2NdGzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722277626; c=relaxed/simple;
	bh=1YIV34HmKrX5BIQOSVq6EJF+N30eKUwZl6AVoK4crj0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SbTib8fA8V4hq6n7hDADcum4UlFPLGRc4t2xl/NsxCMiZK6FOTjET+PEwD3lYOCrD688W6swHivLUmqVY2MD3g0LKUPjPXWXCSLgYMr6D2w8Zrn+ra2JehZyeInBVz/INDA/RVhivBEoOusP8bhV6Ckvao8w8iSOlfHrQdAIm9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39a29e7099dso62290665ab.3
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 11:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722277624; x=1722882424;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kGYvq/6bOR4jYv72OZJDcB+vk9Er4LnH4RkWNj6JRTU=;
        b=il59kVZRFoDB5OvvOGTC8fk/r0PrTS6ljcr2scSbWJu2IwNzRUBhpv2ju0hpl4kuDh
         UyY5+3Bc6FQOrttiBKNXpfCKlXeyO2IC7+TfK5EsMsJF07gwiS10CyavXdAY6mLMLSIJ
         J4n82iqAsNHFoWNaW0FfNrFouZ08zFF7aOc6ejyN8U5bxEjxfsLPADK2aEE7rfnYKsTl
         mPfSfDzGo1EfHcL4HgZEaz/EtKHx5JvW0lil9ex8m5/zFFkizTSgfuC2GeCEXy443Bzc
         pd9RxfTEHrDJtj2BDfcV2gmbpS6zso3MA3YOzpRnQX+Y32VwvaEKHI9IzdosBpzhspO1
         xiBA==
X-Forwarded-Encrypted: i=1; AJvYcCXGfWiaIwRpiYe1ebaFqbDiqcLPJpfsqnBpqmxt/GpKr1t9BsE6ghW/q4BdDOWRZLjNWI5VxzH9Aiw6CFBKGm6q3i2CBURW
X-Gm-Message-State: AOJu0Yz+PBLvRue1zAzNa3eUIoLpatiVj1gAOk3OtP7ib0p8Ab7FjVer
	yzd9ySZKs9wlG9RKJ1lU2I6FiNQZIEIItUpY/d/QVAqf6Re/OeYUgRWAQSejDaj4ZMH7kgGQoO2
	miPghgSt0KaqhU7y5M5HWD8YiYD0TCAwM4aJlQQaKvsghrjsRUz50V8Y=
X-Google-Smtp-Source: AGHT+IGBjtP5F2pZX+5YOLnHshBnmxrtHZWHQDGKunRQS57HKJqDNqoDGeQ7cZZt66jtP40YPeogjt3sIF38iwhLMccA6SHG1WTY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d15:b0:381:c14:70cf with SMTP id
 e9e14a558f8ab-39aec2abf78mr6623705ab.1.1722277623771; Mon, 29 Jul 2024
 11:27:03 -0700 (PDT)
Date: Mon, 29 Jul 2024 11:27:03 -0700
In-Reply-To: <20240729180122.87990-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f847ce061e670195@google.com>
Subject: Re: [syzbot] [net?] general protection fault in reuseport_add_sock (3)
From: syzbot <syzbot+e6979a5d2f10ecb700e4@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	kuniyu@amazon.com, linux-kernel@vger.kernel.org, lucien.xin@gmail.com, 
	netdev@vger.kernel.org, nhorman@tuxdriver.com, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e6979a5d2f10ecb700e4@syzkaller.appspotmail.com
Tested-by: syzbot+e6979a5d2f10ecb700e4@syzkaller.appspotmail.com

Tested on:

commit:         1722389b Merge tag 'net-6.11-rc1' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1508ede3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5efb917b1462a973
dashboard link: https://syzkaller.appspot.com/bug?extid=e6979a5d2f10ecb700e4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13c648d3980000

Note: testing is done by a robot and is best-effort only.

