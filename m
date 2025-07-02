Return-Path: <netdev+bounces-203530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A67AF64CA
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 00:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F72F520822
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D69E23B630;
	Wed,  2 Jul 2025 22:04:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C312DE6FC
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 22:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751493845; cv=none; b=fl/qfQkSktlTW7J28LI0McJCX1hXxGFoe5T8qJ90u0kslyNhQ4VW1rpitq3JgzaCOcQ/AZHeUwrB4TiaCkdJLyEO5M3PFmKQr0awlT9GrNe0ESZBw9QStTQBEdGmm/44WU/cmHjgejG9yQWIm+P8ISVESOaUoGad/WVzY5elvZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751493845; c=relaxed/simple;
	bh=SsfceBP+qhOoMo7OoM5UWUZ1eymVxtTJuiLiM1pfvGI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RpqP9lDrEJ8If7X3jfwzSdKUmqszPt2lgp5bD5roAdxc9sQehVabs5K8vdJaLZoJm9l9dD8RsDv5gUOWC7mhw2t24jycYXILHObREPJ0p9EGP+71xzuckChKdk+2aXUhuI1KlI56jZe9rPqXxlJfWdT/d5lQA9TDsS1aImNy5ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3df2cc5104bso82005185ab.2
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 15:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751493843; x=1752098643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n/J03lRbzuvB4PtTp7I4ZDRquz2XgnWn7PW50AxA3/A=;
        b=Buvw9k6oyOZhS/6QH9qoq++NSaThKc5SInF116AnZmKX4vXT1B2TDlgc0ouNkpmI6S
         jS+CufF0rNVLAuprRfz3NlI5b5PKCA/JShEVHh3DjETbd0b8P3qj+T9WKyemhTNfwnqT
         HY8pSj3AnyWdFbmntqANeWtuOp1SoCsVfe2WjpXvqNbm1UpDfUzVBZqZ5SQ6t0Elu1AI
         M9oQZ3GgI0PLl34tCQd+xlgvOihdX01CBx7Y9deWHmIDS9MXEaYVdvs1TzVcafuKOSUs
         ghL/NyWpVuW08v4YPi/rAxPetQztetvFdechlckJ587GA9WEzsh+y7Q86YqdqOvkzpa7
         sF+w==
X-Forwarded-Encrypted: i=1; AJvYcCWjUwublvi2Fg1eke7jXxStgiIH0FaSuwxkYFWWRhpTsZMxSLdteMAzUftGXcBwUJ3NwdgjtIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ISoScaTl4/YdeUgSCKkEdhd2ygtYrXp/pauD2G3DXrfIFl24
	BSG7YCWFVzfevsTHkkK/TaBcv96ive8HHr9nAh1sLSd9M1rOvnj07ySrniANO0ZxHHtZVfMfVJx
	bup4vZrnRpfUJBnF0HAnPVTWggFXkTAGGAMTm8WqKFnSqrMwXaau46MuuU+4=
X-Google-Smtp-Source: AGHT+IEw/ZHDnLHRk/xRKLu4Ya2e0GjrHeyDhj/YYErj5HvA2TZDeohNuR8anf7y3BU+aQdE712Xkz53vyUBKu1Q4hNP8ysjci3Y
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0c:b0:3df:5314:1b88 with SMTP id
 e9e14a558f8ab-3e05c324012mr16573595ab.15.1751493843172; Wed, 02 Jul 2025
 15:04:03 -0700 (PDT)
Date: Wed, 02 Jul 2025 15:04:03 -0700
In-Reply-To: <686491d6.a70a0220.3b7e22.20ea.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6865acd3.a70a0220.2b31f5.0005.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in check_helper_call
From: syzbot <syzbot+69014a227f8edad4d8c6@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	paul.chaignon@gmail.com, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 0df1a55afa832f463f9ad68ddc5de92230f1bc8a
Author: Paul Chaignon <paul.chaignon@gmail.com>
Date:   Tue Jul 1 18:36:15 2025 +0000

    bpf: Warn on internal verifier errors

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155a848c580000
start commit:   cce3fee729ee selftests/bpf: Enable dynptr/test_probe_read_..
git tree:       bpf-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=175a848c580000
console output: https://syzkaller.appspot.com/x/log.txt?x=135a848c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79da270cec5ffd65
dashboard link: https://syzkaller.appspot.com/bug?extid=69014a227f8edad4d8c6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144053d4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d45770580000

Reported-by: syzbot+69014a227f8edad4d8c6@syzkaller.appspotmail.com
Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

