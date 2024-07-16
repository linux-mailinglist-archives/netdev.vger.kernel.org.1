Return-Path: <netdev+bounces-111743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897CF9326D5
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 14:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9F41C21DD0
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 12:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5826419AA68;
	Tue, 16 Jul 2024 12:48:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D820717D34A
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 12:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721134085; cv=none; b=dBXE/QWbshwhdtyrCFC5VVOEaI0bJ8PxEayuQ5DiRkAFEalxSWye00tCpVx4Kyw/Bo2w6e1HQkYQ/zELQreGYPIaLbbZjyTN/UF08cjjU0hBqzrIGYxaBcHUxTxLefNEFKcvh63cGHQhKCn4vvHAO0A8BcO2SN9pMf7FYPZA4RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721134085; c=relaxed/simple;
	bh=E2nZjSWDCpSniAOgFo0k28Kj4THvfunBub8RcuI4IDc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gk9vOOR6nAT9wp7yiqx5uvLWY2fr2oCV1YulwGaYj832Cy7+Lmq6bEvoJZuwMuT7u2fe7U20y+z2UmUOpKuS7Bybe9XcduQTq8nKpCyCPYcO4qB5Er3qRx15tLDSCeBY7yffW3N6O3n/3PbcfxTZUVxeOi6XI1actUxXcQGRB80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-807b123d985so729039639f.0
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 05:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721134083; x=1721738883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/GQmuW9oEGylooIhciy6e3DjFVO7n6m2qCoRl9cIxk=;
        b=DeqeG9B1H5dqA4+qWFdbCUUcNeA94CXjOFVc/CxEgGwp85VAzRfeyZiA3e0Irt/U3S
         DB4rBbn9SX49OAwSRV5WTB+Drc0+xZu0Gi28Xt7NDEkBMbpTexpEmiEEPcDSwKfnsv8S
         uGkJT/IZlPbZA/X6bUjDRWZuqlQe0p46DC2p8IT4+sKp8s7qcTHEHqjq5piVOlefvbqe
         hTgvyLdZElMRSpdHckjVlX5gWTgtZ0nilJUN5hn8OvvlQjaGgMJayCLfZtwMpnXMa43r
         fyi+iujjcUlVU38UMjhIw8ZgXfHXtoIej8ztnMXHdRyCRlXEhnrfkuuGnzlTsGgT0iRH
         9ttg==
X-Forwarded-Encrypted: i=1; AJvYcCUN40MZqK0JWve0qv0yKEupy78rKLBviOFGqAAsBGrTTXuqripZryVF6H4aXaoC6TdE+OEhDjvSetXnACznsAEIqEjDY4mB
X-Gm-Message-State: AOJu0YwII35g5qOdCUcJoOFMSFnDduEooSpE6p5w1y52phqRfLeama4i
	FymQ4OByXqbn6LGXRb9Nsd8mVx/3oCCDldplmdYRzhVm1W5Rlutakt3+8KDwQsZI2ZX1qGYSpvw
	jI1O4Rt4B4I2fzpwR8f5c3MKq7S6Rf9cBlGHpI8EvQBFL5JTME28bZ4A=
X-Google-Smtp-Source: AGHT+IF0N+2TOc0t43ZvyhnpOUrNdhABMYBRZ7HlAQ6MLOp6KnFbslLaXfCAy/o/1nZ29lCtkMF+nqQdQrgC2dpCO/jsgD7aDQgm
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:6c0d:0:b0:804:f2be:ee42 with SMTP id
 ca18e2360f4ac-81571a97c3cmr2458739f.0.1721134083002; Tue, 16 Jul 2024
 05:48:03 -0700 (PDT)
Date: Tue, 16 Jul 2024 05:48:02 -0700
In-Reply-To: <0000000000005c6453061d53bc0f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0f1fd061d5cc101@google.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in lockref_get
From: syzbot <syzbot+d5dc2801166df6d34774@syzkaller.appspotmail.com>
To: benjamin.berg@intel.com, gregkh@linuxfoundation.org, 
	gregory.greenman@intel.com, hdanton@sina.com, johannes.berg@intel.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miriam.rachel.korenblit@intel.com, netdev@vger.kernel.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 0a3d898ee9a8303d5b3982b97ef0703919c3ea76
Author: Benjamin Berg <benjamin.berg@intel.com>
Date:   Wed Dec 20 02:38:01 2023 +0000

    wifi: mac80211: add/remove driver debugfs entries as appropriate

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=150e3cf1980000
start commit:   58f9416d413a Merge branch 'ice-support-to-dump-phy-config-..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=170e3cf1980000
console output: https://syzkaller.appspot.com/x/log.txt?x=130e3cf1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db697e01efa9d1d7
dashboard link: https://syzkaller.appspot.com/bug?extid=d5dc2801166df6d34774
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1658c7dd980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ed24b5980000

Reported-by: syzbot+d5dc2801166df6d34774@syzkaller.appspotmail.com
Fixes: 0a3d898ee9a8 ("wifi: mac80211: add/remove driver debugfs entries as appropriate")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

