Return-Path: <netdev+bounces-147500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322E09D9E0C
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 20:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA96286CED
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 19:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3DA1DD525;
	Tue, 26 Nov 2024 19:31:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14281191F8F
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732649469; cv=none; b=e4mfemRtmfKLW/zba1srfEpSWdlIesUCo8zDMjuHcKDhyeKFBk5GluzUnmucvEvMqinHO6jH8hg0NihO6w5WCKpVYTRApn67Mg3uIXr5Kz3IS39C5ZOBdUXclp5Ff/4wYFcUBjPeQL723yqkYA9gtcBYrNI05VxkNtQB6tqK/T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732649469; c=relaxed/simple;
	bh=Z3Yh2qOY8Xtf+fmgZGJLC+IYmCMIWKkdvMJGsLFHuZw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ERpVOs/3fpqN4mj+C7AEEHYalLtu0xnLfuglHl9qzbJWAEwVBRevjnSn9SDFi7h0xKmjsZAZVS+B3bMlWOt4tkr/ET5TvtPML5jbvtLrhxY0NQgsQqnomd8snLbsoAAuIZJpcqMgDb0GpfSY7A2cp6WZDzl+ZlQeLf1zttZHCcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a794990ef3so903025ab.1
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 11:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732649467; x=1733254267;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h3CcMyqh6Vw2D6UimFBh1G8vqaTzPY//H9G8tue85iE=;
        b=Vs6afMmjKSt7X6SeAykSa6nUpnnvEaYOpaEtxEjtN/Sbr+qQWClop5M2TFapK1KYmJ
         O/mASouuxw11ZTZpWAcxz1iLxgm8fpVvhIrnq2gFqmy5rswXvPbuKAkYXhaxi7OTmRmN
         2MhzcUuiO9PStsqXim3WWuXpB+nIjENGdXXncxP5TL8HzxVaRJZ0VY6MVziG1v4leZld
         ng+XC3dnREHfwowwdcGfbQViJJnr4hzKF4N4HVuZU5NNWcgwW3R5iybEiJzSnGMBpqEu
         2vlMcOkWtZV6t4V23B2xmTgcU+PXHYtopEMZ6Vymiwn5c0h8CAMOmfeyfPZszIZpHXaY
         T0vA==
X-Forwarded-Encrypted: i=1; AJvYcCW2LJyb94GR2ACFXrCFUgGMtgRyyJDatvVdjnpuZW4XrI7EwzcREV80sd5j+HieIxUNsC5AbvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzXfQi8JRINo97WLXvyW7ZyP3VUkSLkm082d3kpc5acBK82bb4
	HWrAd6jjBaqeFxdaXACXIJoBZXbdnAzCV9RV31RJafKl62+iBEMfb9lgCHzga4aEm5X4A1FvF76
	OCQBbQjbosdJsetCzQh1N2Cbgrgq9kI8P3Q4VY/4dM50nwdr/KDZV+jw=
X-Google-Smtp-Source: AGHT+IHhUJgZRn8cEIpq2ohKQAHuqvVvyaYASR0ayovJ4dSWmFjQUCv+4k3ANt4iU+F9hFQMh2aJBjwzb0csbO/dDix8+GQ6iwJg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1745:b0:3a7:bcc5:9de3 with SMTP id
 e9e14a558f8ab-3a7c51ea413mr5332075ab.2.1732649467304; Tue, 26 Nov 2024
 11:31:07 -0800 (PST)
Date: Tue, 26 Nov 2024 11:31:07 -0800
In-Reply-To: <67461f7f.050a0220.1286eb.0021.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674621fb.050a0220.21d33d.001e.GAE@google.com>
Subject: Re: [syzbot] [net?] general protection fault in modify_prefix_route
From: syzbot <syzbot+1de74b0794c40c8eb300@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	eric.dumazet@gmail.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, thinker.li@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 5eb902b8e7193cdcb33242af0a56502e6b5206e9
Author: Kui-Feng Lee <thinker.li@gmail.com>
Date:   Thu Feb 8 22:06:51 2024 +0000

    net/ipv6: Remove expired routes with a separated list of routes.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17a90dc0580000
start commit:   7eef7e306d3c Merge tag 'for-6.13/dm-changes' of git://git...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14690dc0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10690dc0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c44a32edb32752c
dashboard link: https://syzkaller.appspot.com/bug?extid=1de74b0794c40c8eb300
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142375c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146f1530580000

Reported-by: syzbot+1de74b0794c40c8eb300@syzkaller.appspotmail.com
Fixes: 5eb902b8e719 ("net/ipv6: Remove expired routes with a separated list of routes.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

