Return-Path: <netdev+bounces-133486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB6B99614A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 09:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9219B284F56
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 07:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048E4186E39;
	Wed,  9 Oct 2024 07:44:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADBA186E26
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 07:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728459845; cv=none; b=fpFhUhh1wc+4jmyyAQMyegfvI4yR+6YE46/jFpk1WXTaMmVqtzTza4MRAsCoKnNbkh+ZUKVq6UEx8RIYNA2+U5DOvorJwBDIvcVK7GZNUdGQKzvcEovL4SqCBXKLhcHKK8c4NYPRaHx59ld9cJJhhUPFLIup94ax97uEC9+of90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728459845; c=relaxed/simple;
	bh=vro3Bbe+8hKP1n1pXWEdxEnFJNKRiv0zk1QHqAcZZkw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sESc9O2aDDIw5qXCByKTbplGSHJxBXFHSwseb2sJ/iISRwTJHid29Sq7IF0V1VxltMsM7FasKgu8TR8PNVBhLSkVXK69XroMxG+G/AXaIlpsfURBROJ9dTPiGqE306h1K/w7KlLpHDVJ+hB2yo7CcXrxR8LvJ/JE/OZoYkwHz5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3a031168eso2237675ab.2
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 00:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728459843; x=1729064643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/cIM4FzGaC91vtdSI5kp+oxCUFiOwgoAfMBzSugYPic=;
        b=d63BtwB+mNUMW4eplmhA03BYbciGJ4IkGPG9Gw351hUCHBltjxInFGkwUsJTXd+8m6
         yN5LqBfISP4fZlitsq9+CmRhpxPdQpNFHc/a+kFzVzeSPW5tz/lBUydKYygX81bysUCy
         MOHX85vnxiczIYukyGeyPYf7H20aE/+TjepGLWiZu6cytnHu+HuoUvx2xuXz3VEnkChz
         RkUgOi7xOtmTlvpO0wSz76AHkVJiZr2KU+VezH92jBhVN3iiWfYyhIxBOfg1I1WFq8Mu
         couwsagcPRrwon2FlarhBAyDbLJlvzBsZWidaTaMV27pPb866nlj9F1SzqQmuQIejASX
         ynoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWMSGQaBTQZIdmNlfN5JvMQOepznRO7/OSWPBkN3j3sRR3d2ORHUxPiSFsx8Ri4ttTJGVqkUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YztR9eapBxTzvMQNMnGwoKmp8lDD4elftf98ZvSotnk3HfvNCoX
	YSqNob5eQ/8+b4OyjeuSjTY3veTPToW3Adtluf59WeOurx73F+3Pn2Mfbb5Q5vQ1zCf+pujAOr+
	jrvOppzfeUxajk2f2DavdXvJfobxCiQP3XyFM+FiKpTvPYFtNj7xxNeM=
X-Google-Smtp-Source: AGHT+IGQUQlE1emHK5BMoVHftqjMHMKZ9WzpGESuX/WJupIlx748u5PWWxzaIpPs7tVEVvN3RxleI5Ir+epplxZsh4OdZn5wVcaV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152b:b0:3a2:463f:fd9e with SMTP id
 e9e14a558f8ab-3a397ce4910mr11518575ab.6.1728459843585; Wed, 09 Oct 2024
 00:44:03 -0700 (PDT)
Date: Wed, 09 Oct 2024 00:44:03 -0700
In-Reply-To: <66fa2708.050a0220.aab67.0025.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67063443.050a0220.22840d.000f.GAE@google.com>
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

syzbot has bisected this issue to:

commit dfa0a574cbc47bfd5f8985f74c8ea003a37fa078
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Wed Jun 5 10:09:11 2024 +0000

    sched/uclamg: Handle delayed dequeue

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13c2d7d0580000
start commit:   e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1022d7d0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17c2d7d0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=286b31f2cf1c36b5
dashboard link: https://syzkaller.appspot.com/bug?extid=7da6c19dc528c2ebc612
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146ae580580000

Reported-by: syzbot+7da6c19dc528c2ebc612@syzkaller.appspotmail.com
Fixes: dfa0a574cbc4 ("sched/uclamg: Handle delayed dequeue")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

