Return-Path: <netdev+bounces-178173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA92A7533F
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 00:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652D83AB428
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 23:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9631C3308;
	Fri, 28 Mar 2025 23:20:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF08412EBE7
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 23:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743204006; cv=none; b=Vxkli6vzbnSiQe4fYpqRxZ87vSM/PrJY1Is3XrLQHTc0anvT4Sf6gSk43sb5TylR4s4Qnha/vy+QFfTkgJhNiuZna8VIMw7pCjCFL8PU6JfKldUGPTo6lMSwaB4afw76C1dDRCigrit/kGnf/FAXyzlM87lUN0eMpWAx4ovxmdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743204006; c=relaxed/simple;
	bh=NPqWvakl93hhfEqcVUUcx4juAb8L5fUOcRkDqPxR8KY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ByRGxue422dMVUkpviJWoi2C8NYiET7pPXe9Liwl6TS4QnvEXQRUkxvWXnbWZ4oUVSezO5+n2pOcA/vm1NWj2udfuJtvVaIc6B53oNyw9z7SSAqaW1p7CYmDww3AgzeqeiaxkVak8BI1OUhly4H4uSEDnh0mmi9d9iCRSdRdC+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ce3bbb2b9dso31743185ab.3
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 16:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743204004; x=1743808804;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yCVG857K8spOJ4YsQYg/bfS5ks2fAnUWHrw003r3ztI=;
        b=LlTuipc2M/nvDaYcYOjad+9D0KPT/NtqC7ZYf/JPKqjieOhDuVpvfsiMM2f6pT1jJE
         KfDVS1+XzO9pHg90lHQ7ohU9Bj5reQFT/wyDvIod3D5jF/tbtijC0cwhkL2x5fnsVz5g
         yIHrXL+tGz4h2YRszWwxSLpy/R6hUJhIuZDlFSMwdQEhfRkwfw/AasJCDowa9VpHQ7r0
         Xwesd7CMkZJxqPNCauK3ICtlzZPgJ+Ulptmqm+CUgCkCEWFpFwZaprSoY8Vnz1aygi33
         Ezw7N0yDXrfZwVShUcYmVkyC8iYj2AsipQJOKqQE/w7zR8Fd4HiVZlvBO3OaYaE6fUOj
         YKcg==
X-Forwarded-Encrypted: i=1; AJvYcCVF7EysLUpbsu8U72SRQLY7WomX7hoH5v7TS65Zjk4+679bZjCZwK3EStBoqwUKI+6BycQ2xgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGC4D3LDd7XkjI1C78550kfJbzgvSoHBXQPFKfM5E8W3pcCu+Q
	2rGnlo306UfYQAfDTsmbXq4r9z5OA4qhCaz29G5GERSnQsjOP9wLF2k9keoZpAVyLBHY0Tdf9+N
	3+Ae8ggzTmWCXYAIEA14i+Gm18RWvbZPeIbJNdF1xrIIX2z8U+OgoH7M=
X-Google-Smtp-Source: AGHT+IGBjmKtWhEv7cg6OyvtdjVUV7yXiaEddspakjNLmB55uy4vp7Q5fbPmsWneys0zmDsOBerGwJgwNvWr52PoFKTGX4KCoLBw
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2144:b0:3d4:6ff4:260a with SMTP id
 e9e14a558f8ab-3d5e08e9ecdmr15302375ab.2.1743204003938; Fri, 28 Mar 2025
 16:20:03 -0700 (PDT)
Date: Fri, 28 Mar 2025 16:20:03 -0700
In-Reply-To: <66fa2708.050a0220.aab67.0025.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e72ea3.050a0220.1547ec.0000.GAE@google.com>
Subject: Re: [syzbot] [wireguard?] INFO: task hung in wg_destruct (2)
From: syzbot <syzbot+7da6c19dc528c2ebc612@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, bsegall@google.com, davem@davemloft.net, 
	dietmar.eggemann@arm.com, dsahern@kernel.org, edumazet@google.com, 
	jason@zx2c4.com, juri.lelli@redhat.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, peterz@infradead.org, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, 
	vincent.guittot@linaro.org, vschneid@redhat.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 66951e4860d3c688bfa550ea4a19635b57e00eca
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Mon Jan 13 12:50:11 2025 +0000

    sched/fair: Fix update_cfs_group() vs DELAY_DEQUEUE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16f07804580000
start commit:   e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=286b31f2cf1c36b5
dashboard link: https://syzkaller.appspot.com/bug?extid=7da6c19dc528c2ebc612
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146ae580580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: sched/fair: Fix update_cfs_group() vs DELAY_DEQUEUE

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

