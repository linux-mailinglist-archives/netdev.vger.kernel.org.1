Return-Path: <netdev+bounces-197326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD7BAD81F9
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 05:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 410287A66C1
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 03:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3517B1DED40;
	Fri, 13 Jun 2025 03:48:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B6F19D084
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 03:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749786485; cv=none; b=P47OciYIpargCsp3fisuER63QMqmsRjGaoW88s29w+nkRij66ajQjJdHQ8+r+GgCSYDPysCTn1RQfWHiPye99pp6WGGmLJsXhr4yz//aJFhNfbZRw+H3ZxG923UDlR7IBcKrsZaSWObDP8jKWgG98+wF3KGG6E6fD4/s4GwyK3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749786485; c=relaxed/simple;
	bh=N1gUe52OrqxqAbjdyE4E7HFj3Ap44rjytkPGKEt6g/o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nSE6VzhgMJrdx7F55Vb9OH3yDXMS7+y+C+T8z3svdpghNpEgKIzGaelVj3JdJOGZOISXsbV+k5bJFINe6NhOg/0N+jG2Q7X0gAZj1oEOMXvUWvRItMoR7IWPBPkF0H8zNGC6n4FC7SCHQfJ7+yWXqh6ja0nM+J4Ne1/93JnIIPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ddcc7e8266so28622075ab.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 20:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749786483; x=1750391283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bb7E79GyQMeti4MBfKw+o8g0qjQkyE9gUdl7QQL2wGE=;
        b=uZ4n36nWu0bNX8QjJYMeZC8GmGk0x4ZX1gxGD2ap4fAQ2dOdMlzb4kltnx09AS0YuM
         hc+bq8wy3qDpJQswhRQqmjeWCGbFGCy8uL7Td8oQDxZwDR/oxGAUTtWVJOf40k3RiSnV
         qf+lJuVsnhIZJUrg2zB2KzXjlhMAiuPyTkua2IMS5NFsSrFF1Mv4dzztTec8T5UX4bBs
         wVYbMQAYJQWgx5eooswDE8FgXF2RMOQ3wYSrsCrLcWeMCZBNc/osYQigbP4AAgl/ONeV
         hxpxP5y2kdidgcLhuSQ5odS5gUvKpP9yXOVIL8Hp9qAiC7ksNwyRyqKV/V5JZhf8/3jA
         5KnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVet8ijcpEnA97Hg6TeUSKrYsKtERwkmVdZlHTZF+NlvqMrvOLdJuXfpBH3IJMkGT4OYX/vWio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8KRdLGDEM+ZQPBLOJBEEbhVZf/HeT3Dj8/J8ex/QKIJ/2Fui8
	fS+obyvNDUsGvmYCpKHuFYBxAWZ3uaAQwG2R6+tSKLtyDxof6UmeUDCONuJzvnqAZ3A126m1Dfx
	ikXifPp4mjnPy3i+UGvekM5ibNj/suV+xZfoQO3edUnSvS47vVoR1XolqLVo=
X-Google-Smtp-Source: AGHT+IFAaUNUVUwpx+yr5Lts6w/i1C8c2OGsKXM9GI/kfVSZFF098ps8LaS6jDuxbGX9VLeErfyxSkh9NsnudZ8UYmYQ26Pn8IXN
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d4d1:0:b0:3dd:bb43:1fc0 with SMTP id
 e9e14a558f8ab-3de01700c5fmr7352865ab.11.1749786482836; Thu, 12 Jun 2025
 20:48:02 -0700 (PDT)
Date: Thu, 12 Jun 2025 20:48:02 -0700
In-Reply-To: <20250613030043.226990-1-kuni1840@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684b9f72.050a0220.be214.0299.GAE@google.com>
Subject: Re: [syzbot] [atm?] KMSAN: uninit-value in atmtcp_c_send
From: syzbot <syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com>
To: 3chas3@gmail.com, kuni1840@gmail.com, kuniyu@google.com, 
	linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com
Tested-by: syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com

Tested on:

commit:         27605c8c Merge tag 'net-6.16-rc2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d17682580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42d51b7b9f9e61d
dashboard link: https://syzkaller.appspot.com/bug?extid=1d3c235276f62963e93a
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
patch:          https://syzkaller.appspot.com/x/patch.diff?x=129e7682580000

Note: testing is done by a robot and is best-effort only.

