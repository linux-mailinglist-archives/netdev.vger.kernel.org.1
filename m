Return-Path: <netdev+bounces-244883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C468CC0C15
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 04:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7819302F68F
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 03:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A45D279795;
	Tue, 16 Dec 2025 03:49:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36661CBEB9
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 03:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765856946; cv=none; b=g+F9hq/xMtXE4sgg32xtDpQi+45DSveRZLXEAUaU+fbuK2K7kMH9D1TdgwEp7rMkrwyLOP7le/SGwQD+y2+MyynIhrBkpxvWQWlYeQklmUoD47NM/wrA/B6QECk7tKqj56+ms7iXjfdQa52tys61ep4+fCzil+1sgRsU5AhDBVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765856946; c=relaxed/simple;
	bh=Unutd6wCkiNh4RacUyjP326EvR/Ys1jEQu6+sKGiWAg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pz1+0ptDJHsl9W3TCsIpW2V48fjfY4Go1eiiSLwPtH4CvCPOZRzGkraXADqNFwGOrEnv4O77PPhuqdUHK5eoIt0VfV1dVrmV/9zGH/a8Q3ACNgl64Pm95Xq+wq7b01CJfaPQnNiLvGVOhECls0XYpEjfC4kBq5OgQkCWro7PasU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-65703b66ebfso6359160eaf.0
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 19:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765856943; x=1766461743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UA7NZRyjwv7hEiqYjxI52dnHRVbVd/ftI8bUbW0TUwQ=;
        b=auMgB4a7B6vuR7RFfDsAcCWnrvPVcOVq4d9mwAHqmZyuFX8NVDS83mlXiN3SVLbdv2
         6LuQyaZF8tlAYiOvBGG145Yz/dz4FXhM1dEReTCaD8LvmoPC7h/1tEvSbks+mDnMvSUG
         Z/IDJYgVo6Nf8dsxTT4c5GLjZ8FyVOb3fasbOE+tNOMXuMFqxopjvgPY5ADi3Fg+dk2g
         q367KTO1eYC2+Y+6rHNQArrAWybom52hcRB+2ZdZRggvJ6YOBV7KGc2gc8fjTkKFkLzR
         SclLhMvdVTX2Orvx1uCRgQEDHY16MPlfPeqvH/n36pVRQvyGg/MMQE3j18YBHL2mNTnf
         YcQw==
X-Forwarded-Encrypted: i=1; AJvYcCXbrj4RlMWbzK5rHCeD+M4HzMwzYTvgHjOOy7Z054NDat7Pyx6cjPy7+rNT4fi8StiE3KZViT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/t9b8Jz2ca1DKyFGKRiEKKBQdgzYWFUE54yqCVuVzk/4Q++ba
	0bkgxhZ6WJUrHaQmkmRefl6VwbOL7YRkeATJKwkL7t+4Wltgo3gpsAaKGqpIR0PG9eeoWQirnxs
	EJATzonQmOmd1EnLKuBGAB0lq+pUe16lTG644KxbrTLUQoR7IPhydzB12tnY=
X-Google-Smtp-Source: AGHT+IFa3E9j4szhRq4TjaO4AExrxT/b7DDledAz5tQ3PDW6L+l1D/C6ucPqDcs4X3BVKRZBrKXJtp55A0s0736sTiygqQP1UvT6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:178e:b0:659:a130:dfdf with SMTP id
 006d021491bc7-65b37e856a8mr7438243eaf.8.1765856943606; Mon, 15 Dec 2025
 19:49:03 -0800 (PST)
Date: Mon, 15 Dec 2025 19:49:03 -0800
In-Reply-To: <20251216031018.1615363-1-donglaipang@126.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6940d6af.a70a0220.33cd7b.0130.GAE@google.com>
Subject: Re: [syzbot] [net?] [bpf?] general protection fault in
 bq_flush_to_queue (2)
From: syzbot <syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, donglaipang@126.com, 
	eddyz87@gmail.com, haoluo@google.com, hawk@kernel.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com
Tested-by: syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com

Tested on:

commit:         8f0b4cce Linux 6.19-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=137ab91a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=412fc3ec22077a03
dashboard link: https://syzkaller.appspot.com/bug?extid=2b3391f44313b3983e91
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10be172c580000

Note: testing is done by a robot and is best-effort only.

