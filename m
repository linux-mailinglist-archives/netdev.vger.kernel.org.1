Return-Path: <netdev+bounces-204061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 686B5AF8C21
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 10:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134BF3ABC5A
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935B82E6105;
	Fri,  4 Jul 2025 08:34:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C3028980E
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618045; cv=none; b=Qnens86BpsvoTKNVgs9hUauSWEk4lAkRomQRri2RGZ8L1hE+ETTuSfyTvpX3uaE6+b80iZyVykk8GK8CyWtoS+VXeIo6cbKa7EpHHlLQjNiaDAh1/wL51O6GABEklX0+m8lo9+mHgtSxzxrOcD73ymJSo/izdgNpr0VOggly4PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618045; c=relaxed/simple;
	bh=zpjaHVU9o3w1AU1ZPc7ZQ1mQ782dEOQ2yNVsFLOdCUU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aQUiSjt5WusyLjEIwJOrIkKE+Pj9c7JGEbJQsLlwhipIlLgJa4oCmChvrX6/3cRm/SsQ6dCPQeBtDcYf2802wLGD5jR76hn54RZHGim021KRHtIxmCBfe3LrX+6d5pyCcHiXV9w4KZ3xRgjr4I3eWYcJ1bxlFDV0F4ahxhLo9Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3df6030ea2fso17233745ab.1
        for <netdev@vger.kernel.org>; Fri, 04 Jul 2025 01:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751618043; x=1752222843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iGyzmkda1O439XWhlwqgi+PPwho0P8q0N0XZCBhneyc=;
        b=mQv9hHTeIAh32DpFLWnD98tgf+VPjn8kbr8hcffvX/QlwgGsMn5v+HwKQnxScbpu5w
         PtRDYR7AMxiswp+Tabm1at7TbklWb5Le0Ws2QAfFWmpuoj5WqVCN1L3dtQr0+wQvCWwD
         D7SlrXfcmPhWGs35Jv4+QY36GVw616T+/Vu+dQa8YxeH2SfBrMUnm1f8hYrRnXwESR2c
         gUZtwRVdkErqHuM/B2cMyXSDCg1eMQbLN1W8d5wQ7CK9Axi7Yu+4rXIFXW9D3BHOT8qk
         GF1PENWVz5fjxOvQuGeL8rPU1dtd14gtZ3yZU46MaQdVshKwGhnJr8TrPqarU8CYDF2T
         9/BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWANd8YAiTc7GGG2PljnwUXrcAxJGDovtHAshMdwwcX5n+XtDBxWuJKYOo0etVWN86pF1XZCXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4r0KbiMP65bIlyPBawI2C5GkYyxxXG/TEBmtX6rvC6qedmOqp
	B+PUsx7ag6gkUUwfr2tvcJYuDmb3aZveTqPWWnLM5w3XxgbQ8slU7q74R2bIGkPlUGmVjPVN7Di
	hp3ZP9NroOD2qWZ5hosrh502UViuY1vetGfEl91jKvP23ZiooXWACR+n/F5U=
X-Google-Smtp-Source: AGHT+IGq3iGVa8EGg2H3nidF1Y5oAB/PEaq8fbEsYWECa2At0F9aiZr+qUsebKd63Uwb4ZWqNZ3pAzqOoxWnNHU/LK8aNsnj8ZqN
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1887:b0:3dd:f813:64c5 with SMTP id
 e9e14a558f8ab-3e13561cf90mr16307775ab.22.1751618043239; Fri, 04 Jul 2025
 01:34:03 -0700 (PDT)
Date: Fri, 04 Jul 2025 01:34:03 -0700
In-Reply-To: <686764a5.a00a0220.c7b3.0013.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686791fb.a70a0220.29cf51.0014.GAE@google.com>
Subject: Re: [syzbot] [net?] general protection fault in qdisc_tree_reduce_backlog
From: syzbot <syzbot+1261670bbdefc5485a06@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hdanton@sina.com, 
	horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, netdev@vger.kernel.org, 
	nnamrec@gmail.com, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 103406b38c600fec1fe375a77b27d87e314aea09
Author: Lion Ackermann <nnamrec@gmail.com>
Date:   Mon Jun 30 13:27:30 2025 +0000

    net/sched: Always pass notifications when child class becomes empty

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13678582580000
start commit:   bd475eeaaf3c Merge branch '200GbE' of git://git.kernel.org..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10e78582580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17678582580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=36b0e72cad5298f8
dashboard link: https://syzkaller.appspot.com/bug?extid=1261670bbdefc5485a06
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164d8c8c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14839ebc580000

Reported-by: syzbot+1261670bbdefc5485a06@syzkaller.appspotmail.com
Fixes: 103406b38c60 ("net/sched: Always pass notifications when child class becomes empty")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

