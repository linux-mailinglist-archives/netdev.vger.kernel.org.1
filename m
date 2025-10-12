Return-Path: <netdev+bounces-228618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DDFBD0361
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 16:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F75C4E800C
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 14:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7FA28488D;
	Sun, 12 Oct 2025 14:22:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6344E33D8
	for <netdev@vger.kernel.org>; Sun, 12 Oct 2025 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760278927; cv=none; b=GP4zAcEPLofbeOJfGOp9AEfWRQ5fR7iQBdZrX2Seqey2iUo23a49P6s3inPBKIfckTNiEHwLVYOmjD7YRBm8h9EGNmFcLbn3nZw3QfBPF0jM4IIYtd/nSx1riNOgP47nUB3W0DwGonskmbjfGoXxMpZpBcKPlrO6Bc2hrxaf+98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760278927; c=relaxed/simple;
	bh=9pESG64miPasLo7bV0CQgEu8LhHCXPWVa/VPYfrhM1U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cuXgQbiDkveJZIfzYYAbkNJERTNMF5wIQgTeK+rwAMDpLQKpB7fnMaGjjZ5YoFrlh5dX2R+BnIk3ny7JMTWXWAct6pcRU1NfSuedTPJU03kcILbftt1aeYO6S+GABe2rymZBXYy/FHVHoZTye5ENgEHuH1fCBUlPEhHr445XYCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4257567fb7cso113011845ab.2
        for <netdev@vger.kernel.org>; Sun, 12 Oct 2025 07:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760278925; x=1760883725;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U0rSnZy6IeqJJ4+YGSwK6X2T8neJu8Zh87YZ79NTSbY=;
        b=qmXsgce+qzBtracVj2NRJbiR2IJe4+E4jBa1knwMrTwne5/pX2NipO7n5h9iDHvYPl
         dFDpFO1iKbaC3uJDMwQ/qo5m3yXwnNPht3ROhEeO64MCSJyraRHjABTFZo04GdwupHNC
         CWJaBsHV0r0ejSPimNGVaSUD0gE+fj4ynA8LZQtDoq9A4gvR0Vw7GSsTWB9QQ1wu4/M6
         ZNmVR8J0ViNLhBwsHMJ/oB8AcfXoQBA0OO73EeoAVBQif5kFyclXQt+psk/0rIL7hb8Q
         dk15dF0QNUmqBPDha2BbGM6VzBvnRj3VkwmN5oZ4klE9ReOJ3vKGNirowWUIHjfBZ5P+
         l4MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXzJ/8ZcVl0zdMPdgmYF4rdT9jPfx1ORSfDlVX8ZVPsUlFh6Wax29dLado4jzLtU1URqI/pnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YynZQWDRkYeTRpqfs8Z93GBWlo0mZ+qi3mpuPqUIi8XpeYRujy3
	jF71QL+wTpdNj33qj74D7CKg3d5iWmUsa4jDPQqT+vAZkcuWdlqKDywkPgVQOLc3VCZPVE6ZwsG
	ptjdVNezpBTRtJB3WRA1aGccNJE0mrM4Qo7LPBUqhybVIJiftTfw5XxKRK+I=
X-Google-Smtp-Source: AGHT+IEOWVreDJCAhWA6Zb9zMGM0Ep8ZtoYXbNbJhScWAxb5UUqEZQDZ24kOeejx3drWf4EUBDskyIE9dfZCe8SyAQ+ioqPyW0JO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c5:b0:426:39a:90f1 with SMTP id
 e9e14a558f8ab-42f873d62c7mr207144655ab.18.1760278925708; Sun, 12 Oct 2025
 07:22:05 -0700 (PDT)
Date: Sun, 12 Oct 2025 07:22:05 -0700
In-Reply-To: <20251012135649.59492-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ebb98d.050a0220.91a22.01d9.GAE@google.com>
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

commit:         67029a49 Merge tag 'trace-v6.18-3' of git://git.kernel..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=16848c58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=308983f9c02338e8
dashboard link: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=175d3304580000

Note: testing is done by a robot and is best-effort only.

