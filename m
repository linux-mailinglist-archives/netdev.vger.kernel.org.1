Return-Path: <netdev+bounces-243935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA1ECAB15F
	for <lists+netdev@lfdr.de>; Sun, 07 Dec 2025 05:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04F6530049B2
	for <lists+netdev@lfdr.de>; Sun,  7 Dec 2025 04:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678CC28541A;
	Sun,  7 Dec 2025 04:29:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F54B2222C4
	for <netdev@vger.kernel.org>; Sun,  7 Dec 2025 04:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765081745; cv=none; b=E7z2vZwotcvxtb0UxlESYzOUzlbstq8ahgyViqTDBTMnG2mxnX5iCVCwAs28Css1kXCLHG49sms8m/73P2DUboAACkn6lqxB8uxDZtcP/Wl8KDtvd/Gfd7IrElsuIMs8m6tix9ou+YUgdc3ex6V/QPz4TttraXHB1Lf/Vgafgcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765081745; c=relaxed/simple;
	bh=eFje0BYZc36c7GlxVwvHcOD5WpJMi+Oo3iQMgT02PVs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gDCWySc6KTVhF0i5Wm5qk5iSXuWqhHKk+PXHqSGllEfT3LQRdnMyiwEFx3Ol0oXB5k4GnhrGtDtMSc3YauHtCE7f1v0y0bQcuTHcFku05XHAfsqzl5qbRJQMfKkbwZkpZqj2CGlfsIn7dEl+a24TF/QsVL4pXr83Z4dKNwi+HYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-656b7cf5c66so4162291eaf.2
        for <netdev@vger.kernel.org>; Sat, 06 Dec 2025 20:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765081743; x=1765686543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JUNWBhctNH94PHBLcTezwPnZsKvlmgikXPpcfVicFU4=;
        b=LzSzCgiw2fgsEZBgyLCecJ1SAZIK08xwktcQaLxGp4if3B9u4n3NKtb8j+zL8fOhw/
         4QyvWlr06A3HIkFkYDalPgia+cgCEtNgF/47iz1guyvu0vAEoRj8Ufi3WpRWVhfgp6Vo
         hTV/hcjV8OE23RHBd32lOzOhvjqu4w13L5PDIR3HOVT19YRxS5gRw+Ml3sc9CWQA8Qo6
         l2QCHQ17zh1OagSv0wQwjPl1dh2r4TROet9ZHrduTsdTLy22LGCR8CpEP84Yd91NIC5L
         78IgI279NU4C9sfJKaSytDniwYCfZwZCZoVVsB0riQhenh1WUFrKznnnY635Ol+Udt/p
         8dSA==
X-Forwarded-Encrypted: i=1; AJvYcCUwxynAeXHZDKbRVZEqr50CjBMMnGZ4fv0Go8vloeoyimXnxuKwl9NK4i+56GK0NvKA55NeIrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLjN4xrsDqUKr+/Ed8jLioBwCDoE+netI+SW43Nk4hBVsjZi1M
	725LyygU9Xs+iJsOY87sgM1Ldoz54c5u/my7HjG3F8crwdHbqqS9bM9t2QG6QZCUwBYOe1KHt4u
	o2aB9Eh0vwNJ2RDQajfo8VBXG2lDP+F2rmC1WhzoaV/fuZv3rOOjBAlXpElw=
X-Google-Smtp-Source: AGHT+IHSeHYCjH1WF30LC4vlZ9tiWk2MUfW3UKXh1nskP+uvymmYU7oe3qVXmpZw1STQmVgtt4N2m3Kw9QoZWaaBCcXocytzU+OS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:80b:b0:659:9a49:8f33 with SMTP id
 006d021491bc7-6599a973dc8mr1988629eaf.68.1765081742693; Sat, 06 Dec 2025
 20:29:02 -0800 (PST)
Date: Sat, 06 Dec 2025 20:29:02 -0800
In-Reply-To: <000000000000fabef5061f429db7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6935028e.a70a0220.38f243.0041.GAE@google.com>
Subject: Re: [syzbot] [smc?] general protection fault in smc_diag_dump_proto
From: syzbot <syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, aha310510@gmail.com, alibuda@linux.alibaba.com, 
	davem@davemloft.net, dust.li@linux.alibaba.com, edumazet@google.com, 
	gbayer@linux.ibm.com, guwen@linux.alibaba.com, horms@kernel.org, 
	jaka@linux.ibm.com, julianr@linux.ibm.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, lizhi.xu@windriver.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sidraya@linux.ibm.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com, wintera@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit d324a2ca3f8efd57f5839aa2690554a5cbb3586f
Author: Alexandra Winter <wintera@linux.ibm.com>
Date:   Thu Sep 18 11:04:50 2025 +0000

    dibs: Register smc as dibs_client

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16d64eb4580000
start commit:   dbb9a7ef3478 net: fjes: use ethtool string helpers
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9d1c42858837b59
dashboard link: https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178f0d5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10906b40580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: dibs: Register smc as dibs_client

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

