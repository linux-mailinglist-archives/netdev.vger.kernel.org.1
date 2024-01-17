Return-Path: <netdev+bounces-64072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EFD830F1F
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 23:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696E21F22E02
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 22:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72B828699;
	Wed, 17 Jan 2024 22:20:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567802561B
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 22:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705530025; cv=none; b=SJhEIS6fTsyQ/owxn0nwR0BmgXbIwkmEDwxCPIiVZBU3hRh6+F3BIg9jezo8o8/C+fGr51/BJz9tUvY4Fl2R8GxS5/dCw8oz+s1jTL1/S6zElia9K0Ip2kxxQceNQVQ77SWDSzSqR331HR3hCHMLQmv2RRSttChhBKCET/wGfJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705530025; c=relaxed/simple;
	bh=KB1471y1XKx6xdGO5u/QjdpW08VInYUwNZQLrfxQroI=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:
	 Message-ID:Subject:From:To:Content-Type; b=LcC5R3I1IzTlMBHXUNBsoqvJ6Sie69GYncwHfoov9lNcU3gput14vrzmGPvrB8VQjnNGXvVsDEoiPR84Wa9xmyFMjx8pjDZUCyR4PRUIRex8eDo9JJDKBgsiuRoqLsrXGUloVwojeNHKz5bQPiCPWCwdDRBMoNeK+qLrLRH08z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3618a7e0ab9so21990685ab.1
        for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 14:20:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705530023; x=1706134823;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8tV4gRU2K0YE0IjE7ArrNBUc0MHW7ZpL4XfMaNQQYMo=;
        b=JNzUQacaO4pWYIiw6I9c6D6Olel6VZ+gMxjjqmRtggn3nAJ7aGgIpItKQZGWcEmSwU
         j2L1UkgCBZTlz47n49yW+IzCHLEnymvTa8/Dw5d6Kr2rQJKqo5jsbqOnkEmkUaU8zrcj
         FApDPUH3x4K4eu5LyfAT0b6H2aGawEXYHjbRvaZmXOqz0LPP5Vhw6yAGQR17Tk3zx+KG
         dUPsL+4JQ6avUnHADoWoKMLTbWLERVXdUArgfxj8yuIF14luwMQEMs16sB0mje1NS1Ib
         kRQREwn3nuUZjwnKxG8sTq26oPGlpLRhEoZMNASi+/sInKZv6DJ0w9gq0AbvuVonRixI
         hb5Q==
X-Gm-Message-State: AOJu0YytrcNaHoC93v0R84ckSERaEdt+WiO+kqRVtzB5F+kWzDDyd50n
	yTkm4McUjs0mlyIwV3xq4piQHST+LEnec+4pPp1u67SuXZGM
X-Google-Smtp-Source: AGHT+IHxqpZP0uv7lPrdEFdBKRFzHG2O3t34ovXoLfNBWilymfKi6pCvba5IFy5rlNfOtpPM50stwngkTz5mzyQlJrSRX/qN98fl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:164d:b0:46e:677d:9028 with SMTP id
 a13-20020a056638164d00b0046e677d9028mr436199jat.1.1705530023539; Wed, 17 Jan
 2024 14:20:23 -0800 (PST)
Date: Wed, 17 Jan 2024 14:20:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034f719060f2ba746@google.com>
Subject: [syzbot] Monthly wireguard report (Jan 2024)
From: syzbot <syzbot+list3b7ff8aa9cee9123dcec@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello wireguard maintainers/developers,

This is a 31-day syzbot report for the wireguard subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireguard

During the period, 2 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 15 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 841     No    KCSAN: data-race in wg_packet_send_staged_packets / wg_packet_send_staged_packets (3)
                  https://syzkaller.appspot.com/bug?extid=6ba34f16b98fe40daef1
<2> 1       No    KCSAN: data-race in wg_packet_handshake_receive_worker / wg_packet_rx_poll (7)
                  https://syzkaller.appspot.com/bug?extid=97d9596e4ae0572c9825
<3> 1       No    KCSAN: data-race in wg_packet_send_keepalive / wg_packet_send_staged_packets (6)
                  https://syzkaller.appspot.com/bug?extid=6d5c91ea71454cf3e972

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

