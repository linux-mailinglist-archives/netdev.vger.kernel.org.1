Return-Path: <netdev+bounces-154654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12A29FF478
	for <lists+netdev@lfdr.de>; Wed,  1 Jan 2025 17:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F8F3A2611
	for <lists+netdev@lfdr.de>; Wed,  1 Jan 2025 16:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA1C1E2031;
	Wed,  1 Jan 2025 16:11:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4381E1C16
	for <netdev@vger.kernel.org>; Wed,  1 Jan 2025 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735747866; cv=none; b=EWXke4vLmgyC+vFXmHEyJftygfZw9RiPGfCLA6mVSo8nnsmGhnOU+NxZQEI/pO8nN4bj+qo6LYQHHP+yqFmCWsTISVhg6QqcE4VpUP/8w2D0V1Er9m9cexXoB7rjyTKGjMwyykjqlZGQwS61sqFAZxHvNrLdHYX3dcbUm7IFDyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735747866; c=relaxed/simple;
	bh=DM1Hq+/2LTNTnyNoIXw3U7PxLwfbPFTXmwvAxyEmuKo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CrYcbp5CwFQFz+6kMv+gBDiJhELkWm015W+dlDNCdJwJspMNKOQNi8xEvXV5pumzXwiUVRFDFdc+6P8E83VVqq6fSoAZmYSKYLSbsnhCWu9J3bcFr+s968EczEWtcvkjDUBDv8jUUXPWfO1Yu2mniilUlE3qov23um5U3jsFJfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a9cc5c246bso98440785ab.2
        for <netdev@vger.kernel.org>; Wed, 01 Jan 2025 08:11:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735747864; x=1736352664;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldBjBJOnXeqSExYalt7FrxMHIbKnDFZuU4Tbtt69ogs=;
        b=h1S0dFDy2KjYJ+Oj3Hf4C0XpxiUakVTw4Gm2FCMSJNQLjKRpj4Y7joStsKBzbJbZx9
         T5YLETYRAvL3rlPYhHxzN5vyUMOc8+FPR3E55jBvke9+xKsxCE+k11kvGO7pVZAOapt1
         C8MhYa44u8GXO0kbIQ6JPcmv3gdzQ1HclRMJtrJ+bPfeAsK0wGl2ujIJz1DOJwYBGuJO
         eRxUG8jVoVXqNBxHVsRCBkCcfKuLQpqk0ckm8byx2nA+zXh+jjlfjjToJ+bDQOgfequ7
         3r60ogXvRHhxWOmXHYAtM39BIyJmvRok+jT/uHKLhQN2gGmI0RArc5aVu1RBpRZlcqz7
         oeOw==
X-Forwarded-Encrypted: i=1; AJvYcCUT4H74ow5YJhObDMUPxUtrwT8i7DK+4p+8TTsCQng97H7jciI0ur376xbfNBC19mB0FHbF640=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbnb/7kaslrUn6M+mkKwrmZvRZSysdJ6QDJcTOatq7t1QMHSDQ
	dDCoU6CFRGt119c+nsLLlbVUReukQEXei/Ysfo6kWt3wW6zh+0JxBPkeXDfJxJAAfwwRkN3urcC
	P4pCOJEvRV3LaqHy09L5prqDmXJ/kjRDhwMUXq2+4m0Bi3CXwwQryLj0=
X-Google-Smtp-Source: AGHT+IGkD/BE6tsTik9C/bv979vCxz3u9D22H4sSCwNDG/IZtdamFP3zxsUISCJggHI+jf1qD5RFWJ2yu91rLRwIam5wCid8W4me
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c87:b0:3a7:c5b1:a55f with SMTP id
 e9e14a558f8ab-3c2cc944755mr348671705ab.0.1735747864468; Wed, 01 Jan 2025
 08:11:04 -0800 (PST)
Date: Wed, 01 Jan 2025 08:11:04 -0800
In-Reply-To: <6772c485.050a0220.2f3838.04c6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67756918.050a0220.25abdd.0a11.GAE@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in vlan_get_tci
From: syzbot <syzbot+8400677f3fd43f37d3bc@syzkaller.appspotmail.com>
To: chengen.du@canonical.com, davem@davemloft.net, edumazet@google.com, 
	eric.dumazet@gmail.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, willemb@google.com, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 79eecf631c14e7f4057186570ac20e2cfac3802e
Author: Chengen Du <chengen.du@canonical.com>
Date:   Sat Jul 13 11:47:35 2024 +0000

    af_packet: Handle outgoing VLAN packets without hardware offloading

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116e3818580000
start commit:   9268abe611b0 Merge branch 'net-lan969x-add-rgmii-support'
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=136e3818580000
console output: https://syzkaller.appspot.com/x/log.txt?x=156e3818580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b087c24b921cdc16
dashboard link: https://syzkaller.appspot.com/bug?extid=8400677f3fd43f37d3bc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172066df980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=133c6ac4580000

Reported-by: syzbot+8400677f3fd43f37d3bc@syzkaller.appspotmail.com
Fixes: 79eecf631c14 ("af_packet: Handle outgoing VLAN packets without hardware offloading")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

