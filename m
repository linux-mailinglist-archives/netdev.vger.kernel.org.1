Return-Path: <netdev+bounces-112040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84740934AD3
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 11:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6B18B22592
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 09:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EEC80C04;
	Thu, 18 Jul 2024 09:25:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5D67868B
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721294705; cv=none; b=Oi0kLhQm7RtQF3oo+jBusk0Z8kkAKaVfW6V0TBXSNh0IFJtqVUW1dlktEFV8ht7sNtobz74HVBg7ppBz1vp1n7PiExE5eT2ZeTUEKMH7WcaZskob7cSB5gnGqyDSSl81Uvw/EHB2MVpxvozAOV7iou1js2jctgGLFcnD/QyBpng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721294705; c=relaxed/simple;
	bh=EAUinRQviMvDujUv3R7ipwJOCnMA9iLRBAFx+AvKvtg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NKIF0GpxepEW111tI8VHp/2bSovxQWMZQpF56rwgBxVAA3VfBLWoxtURWWlkWeTEHDbW8ykneRfiOWa1Vfaq5k+dZ5jZHeLdKv7ldAG/Ctkh915mM7c/271I25qhS+rUsamXz5q3W0CpnjBIzjKrsjaqXM2Q6aYT68NwfXLAxJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f6218c0d68so95675339f.3
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 02:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721294703; x=1721899503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rGyXWRLrvwl7ym9gYBnNhfugsOfnDeqOLsViPL9q/g=;
        b=l0PDUAEkoVsNbK8zAo3O6qnuG9aRbHgImycKlc+6sxZeycUZgiT/wsG3yXV88dVNGO
         xYsvBHxD3bTsVfsVSUwNy7l/aEyhB7uReDlfpfRBKs+ad/ES8pdG3ijygEIOcgy49jjC
         eMq9rRuG789xy6ztJg1jk7E9LofibLCZS5Pu9Sg4v/MZFE0MBQnHjmHJ83YiXu+DLjqp
         pdbF+Lty+ZLLimgbsYswl8nJjDV3fEoyVV8MH8bPm9SwW+ViNtpWMxS2cvZrb/4qsgPa
         H1vpazDzu1Izje7fsObDdP0Fy36KHB2tx8V8IvrIymqMph0r/DetA+CfpjPwUxy0zmuW
         jI3w==
X-Forwarded-Encrypted: i=1; AJvYcCXfv8TTJaG+EkHzjqwoSaQvZMZ28cAEXYSHRAUP4r9TMg/vCfoQ2Io4RYFtOiUtWC/N30MXXF6eAflglwWxMufDX8JyEN4Q
X-Gm-Message-State: AOJu0YzAVvOz9iz1jIRC4rdFUl7S3KHsbQH5p0NgrbTtWYVkQgvJIa10
	BG4B/RzcaI7PUP7+tJa3U78DEqNo8XJOMxG4V4lD1zsWimiSTd2MDgy9atNAREWPZYrfROQ7WcT
	hT1D9nDsMUU4t+5r/6gD3j/iA+oSHP28zo/2Xm6bCdzB5Aw5AtpTKHK8=
X-Google-Smtp-Source: AGHT+IGz25YUIa6vXqL1eZi/FObkUR9B/7QK8k4uQaFLAqvDLyFpspVztyFv/qtJeUG6Z3FXvnmr+ma8VvHFLQjQ3qYbN6/6uMgQ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a46:b0:374:9a34:a0a with SMTP id
 e9e14a558f8ab-395594e4481mr3546915ab.6.1721294702813; Thu, 18 Jul 2024
 02:25:02 -0700 (PDT)
Date: Thu, 18 Jul 2024 02:25:02 -0700
In-Reply-To: <000000000000233ab00613f17f99@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050b78b061d822720@google.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in sock_map_delete_elem
From: syzbot <syzbot+4ac2fe2b496abca8fa4b@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 98e948fb60d41447fd8d2d0c3b8637fc6b6dc26d
Author: Jakub Sitnicki <jakub@cloudflare.com>
Date:   Mon May 27 11:20:07 2024 +0000

    bpf: Allow delete from sockmap/sockhash only if update is allowed

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15df62b5980000
start commit:   4c639b6a7b9d selftests: net: move amt to socat for better ..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d14c12b661fb43
dashboard link: https://syzkaller.appspot.com/bug?extid=4ac2fe2b496abca8fa4b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153e3f70980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174ac5d4980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf: Allow delete from sockmap/sockhash only if update is allowed

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

