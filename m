Return-Path: <netdev+bounces-112387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7C8938D84
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 12:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCD51F21AE9
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 10:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2641B16CD30;
	Mon, 22 Jul 2024 10:30:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD3F16CD0A
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721644204; cv=none; b=C4d13Ddyty4VhtTZJ1cxFnbejoh7GIvyr+BZm0DYlAAgbVChmGEgk68b7fOO/tL3fHcpSQwxfLxc+SfHyUMZa+JSR/edLCgai3YxfUg/n/QHs2v1bBaklG941rN0T9biJXlyyFP5+SNeWEFUOODPrGMHDAbRuJyZmZTqIq2vq/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721644204; c=relaxed/simple;
	bh=Ur1D8QSGjku8Q7G5VKP6kNkgy6I95SWKMk0a7rsRzXw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FoBrei3kKAz1jX5Zy4b2swscqhw9hrkTHw6ttCdPp1MDJJl5w5AReq44JtgqGikyn9sHKkWO7ADQUTHrNIaDnuAeh4Of/C+lmx1d6/PQVuYnHe7/7T8XX6hajhVjUwA3pcoReyRm0Jz8AqY46J3um6+C2zyITGjdRGFd5MCv7/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-397810ad718so55174355ab.1
        for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 03:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721644201; x=1722249001;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TVbnRnfiSWMo/y1Phwm1SFR+PjHhye2aSEowClDCq1g=;
        b=kvEzxi6H4SIj/hv7p9OZffmbLj8WnA7E+mAT+HutMTSk5zbnYLDUYI6ej8HE9/L6iS
         oNivdGUjaoyweea9zmnfdFaY/zOTnGChOOYPV4lKDy6mvBX4UmHhPkUhh81t+0dle7cY
         1UMV3urLXwIsZ9COPnO3CZyD+qPxJekPAeQ+xtbIcVFgYTACorqhFV5LUII7cz5V6bxE
         LJaqUj/juiPB5OHzdyqAwzkgJ/jN8RmCIDUxYNLpv9hbddlFakKIOSfQadxLQrUfh6vq
         otCJ3netBzW7keMNHOR2Cn0YKu2NrhxOGZKaK1BpaS2B6PTDiUim9D4dmI2nTiLoY+DF
         R3qQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+MmUWcKTxecuXEhaOnfUhSv7HPP7COF41YXMO5cpOoc8H6m+frmjQlg2dq7YLb7JDW9gHtfetGOEDy74OL+T0K9XzJKvS
X-Gm-Message-State: AOJu0YxY5up+tEDbmtjYknRpHHrz3W6Hs8lUwSYxUO6buXo8y4Nlejb0
	a7JnKfBi24WPjq2x4Whu/qXLbjgUi9MpEbVAgq0jn+8ldulgnBG6BpU0zZ3SJIYEGeO3CwWLEeN
	yiLp0fgGhsLxiFarFFxotPitYhMcEVkqB7MD0z7lThaAN4THF3suHrsM=
X-Google-Smtp-Source: AGHT+IHDXXNaDlcJzkclmypCXUcUHVIyEECRhqINQl0i+kJKGtZvlBOKr1PmAhs3nOlyECxZcDg4kI8y5bz3TrJBC4Rs/7iSWww/
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aae:b0:397:7dd7:bea5 with SMTP id
 e9e14a558f8ab-398e17ac737mr8390995ab.0.1721644201658; Mon, 22 Jul 2024
 03:30:01 -0700 (PDT)
Date: Mon, 22 Jul 2024 03:30:01 -0700
In-Reply-To: <000000000000fdef8706191a3f7b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011de5f061dd387f0@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in __rate_control_send_low (2)
From: syzbot <syzbot+8dd98a9e98ee28dc484a@syzkaller.appspotmail.com>
To: clang-built-linux@googlegroups.com, davem@davemloft.net, 
	edumazet@google.com, johannes.berg@intel.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	nathan@kernel.org, ndesaulniers@google.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, pkshih@realtek.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 9df66d5b9f45c39b3925d16e8947cc10009b186d
Author: Ping-Ke Shih <pkshih@realtek.com>
Date:   Wed Jun 9 07:59:44 2021 +0000

    cfg80211: fix default HE tx bitrate mask in 2G band

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13e233fd980000
start commit:   51835949dda3 Merge tag 'net-next-6.11' of git://git.kernel..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=101233fd980000
console output: https://syzkaller.appspot.com/x/log.txt?x=17e233fd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d3bdd09ea2371c89
dashboard link: https://syzkaller.appspot.com/bug?extid=8dd98a9e98ee28dc484a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14608749980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178b9195980000

Reported-by: syzbot+8dd98a9e98ee28dc484a@syzkaller.appspotmail.com
Fixes: 9df66d5b9f45 ("cfg80211: fix default HE tx bitrate mask in 2G band")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

