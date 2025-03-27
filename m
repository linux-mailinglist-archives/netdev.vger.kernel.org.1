Return-Path: <netdev+bounces-177974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBDAA734ED
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 15:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85533ADEE2
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 14:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEA6218851;
	Thu, 27 Mar 2025 14:46:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1828C218599
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743086764; cv=none; b=KFeElAWX7sJwTjepToSE1zj27jK5YAHzXHHPxs6u/DF56dAQJK9cEf9Lg36nGueInjRcBnKTSdBCqtp/PG40BLO/MUkVfxv2o2AjtYeJCz10awPbyQD/y70BTCueJ56kOT/Rs+yt7Lspe/9dRThqw5LXMv80VnNPalVRfhms6No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743086764; c=relaxed/simple;
	bh=bBLBi+/uszXJrNS0RExv+HyTwvtK2Dqw8vfB6OTf6tQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=prnneCDyK8Jg8YN3zcL9A0tHz5o2rPxXvkKIpmYaXCnkTckHky5ITEwnDeSPur6gzixYvCxF6hqpjYL1u9mlREJ+9SdwuHydsSBoD/iGG6RdLKfK8dU2+t1TbsHtPQFtnjdaDmegay19svjaNm4lW/969K/efU4alnD9HJ/EkMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d2a6b4b2d4so19455495ab.2
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 07:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743086762; x=1743691562;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O31EDqZnf42bmiyYjE9Gv1Kig77RT2Jp/txzXzrDTBI=;
        b=BCbPi+sEs8GLzuU4vSKcvJSdCKYR0175JTJ1W3z0KdNN/dnrVIZMGciJWmBELkXeE3
         yxIkiBOqTKPszeQz4oDFNSRcKjFeFhYL63Xj5tthONJa32YbSg9JV2S1vig2rl97EbzZ
         o4K5Az+G7DZowlLASAlCOcA+kzTSxoXmUFSX/hY7asGEMlvf/ZNOTGm7nGfIYr2ZpZF/
         H67IS2sqm3Xqauv0KQWtku5aVodmX83/Ti4gtWVSofe6qnkYZTHORrYbjWXa8jzSnfYj
         VOUjkxIe6fLZrnKcx0LMxuGJbPU49GCT66pM4Sh17jVyWurpUD2h31NxmA1hPwb8RbRo
         OSuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfwP0NYKlpIoTKFht7pK+Ce6K1gIk2JxD7fQf9zOei5Vx1ZJNLZRAS8s2JqFz3CkPzs9w5KHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHexN8BXvFa3p2mFD6BXrniowJXw78xAzLT7VMx5RY4rtan+mn
	qxxb0SJK9O5ezeBiNwV5iXLmDooYD6h3us00dMzUVcpaUpUVOHIas2g8AuoORjF3BAPjvQ7GTI1
	3egPREWh5eNHoci6DGZrDukw+2VZiMhGU+tEioAcG3ZBb5lbEVPU/x74=
X-Google-Smtp-Source: AGHT+IH3/YAoWyMyOT2ZmZKztUVHp0JJQajrmaritGZ7UtKATN1DB+AKdKLwXrPb1fsB9Cnl/8Zof7ODuhfQc/4UsqLHRutL++np
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1646:b0:3d3:dfc2:912f with SMTP id
 e9e14a558f8ab-3d5ccdd1496mr40599045ab.7.1743086762074; Thu, 27 Mar 2025
 07:46:02 -0700 (PDT)
Date: Thu, 27 Mar 2025 07:46:02 -0700
In-Reply-To: <Z-ViZoezAdjY8TC-@mini-arch>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e564aa.050a0220.2f068f.0031.GAE@google.com>
Subject: Re: [syzbot] [x25?] possible deadlock in lapbeth_device_event
From: syzbot <syzbot+377b71db585c9c705f8e@syzkaller.appspotmail.com>
To: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	eric.dumazet@gmail.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org, lkp@intel.com, 
	llvm@lists.linux.dev, ms@dev.tdt.de, netdev@vger.kernel.org, 
	oe-kbuild-all@lists.linux.dev, pabeni@redhat.com, sdf@fomichev.me, 
	stfomichev@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

drivers/net/wan/lapbether.c:376:36: error: 'netdev' undeclared (first use in this function); did you mean 'net_eq'?


Tested on:

commit:         1a9239bb Merge tag 'net-next-6.15' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=95c3bbe7ce8436a7
dashboard link: https://syzkaller.appspot.com/bug?extid=377b71db585c9c705f8e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15a66bb0580000


