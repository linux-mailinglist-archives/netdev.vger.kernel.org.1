Return-Path: <netdev+bounces-164683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B35A2EB02
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C972E188590B
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3AA1DEFD2;
	Mon, 10 Feb 2025 11:26:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D401DED6B
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739186765; cv=none; b=PQs6wMZiOiNY13KRUzhRKHCuSZKLnPUO3bMjQa1D9LhSCn2bIPlH63caCmiSD5naWFKVpehMf6QV4x0bTIeLvs775Cu33jN39b4ABW9JfgE4+f1ws1EaldqDaGHpPxu+7+08EIb8n3EepmwPUz/O0aGF3FOoItdb8ZyaguWkvTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739186765; c=relaxed/simple;
	bh=NnCmgpLc/a19Z//Ksh5P5uqxhEy9Jo+bHlhN/OP5T5I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y+jdMzYzTcRC4VLD4g5SSHP3IuHThPhQs0K34l3qYU0aRBBTokZEA2+7bzSkrLjljlytVmZUYMyUG2mHyhlwM5eUd2IJCOpM1Dg5CoXQEXRG6+vRtBSGko39z3DZE9g1JFlp9Jw8xEtyX+C3rpvdJ8DUg2ChgyhiFfAqirtRv/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d0d7bceb62so26206195ab.3
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 03:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739186763; x=1739791563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQ+h2LGkuRXC7DIQsduiIG1fRSIWK0hwahaP0xsxH60=;
        b=HHspgbbHvD42exge7cEu0pCEhH/LGXCa16DhgsA6llwpkMsw8mTWC+u4+EfGZNGHYH
         KHBTefHo6YPBzHCfYPSn2y370lTAIGBjYmVY/ozTvqCL+CcxsFzdXvo/2RIrqPQTLgN+
         bihfpy/VaKIPBRDEjc8XC/BMyTNiENcwWGYxsk6WFvBwCA2fWdANwTEA4nxUQoOmKKLw
         /oabIDiRh1g8TbzE7PpDIrNXY2vzYnNN1coZoJdcBt6nW1exqRIhrGhw/yIfBl/suXdL
         jSEMAfUQQjO5D3CfqOzhLwA3YT5EP1ltEdMcMPoThhwht+mYvpe1XQcNk2gBugxTwBai
         MAKw==
X-Forwarded-Encrypted: i=1; AJvYcCUSr7B1dX30+uprpENOFX4KuioKJBCBf2J4RViuioQL2PbpJ2z1W6NQlk1FTCO5rW2/JsD7pYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTFSNv65QPqP2spu4U1ismsuV+u7y+8l9Ol/GYAJyeJBlaC/fl
	G2QdUn4Ex+k95Nag+CqmNmgllht1/wY5rgHApwxVoAmjI0egv1TLSzUTg9T4BFGOQAyyJ909oS5
	thGDx3GtJsxXod+uXxSKHcR7/tmxynJ56v/R/QFBCY9kKLS/v8LL8n+c=
X-Google-Smtp-Source: AGHT+IGvQR9xhBJMp0yCwBu2IxYGsiNQHOCBgzHhuu/0KXacIXDsqC+PSoMINzNx3ybIiyk4U91FErnEIhDu9SfZp6zgMA5+5fVa
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d89:b0:3d0:2b88:116c with SMTP id
 e9e14a558f8ab-3d13dd4aaadmr91686965ab.10.1739186762869; Mon, 10 Feb 2025
 03:26:02 -0800 (PST)
Date: Mon, 10 Feb 2025 03:26:02 -0800
In-Reply-To: <000000000000cbc8670618a25b24@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a9e24a.050a0220.3d72c.0050.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 skb_queue_purge_reason (2)
From: syzbot <syzbot+683f8cb11b94b1824c77@syzkaller.appspotmail.com>
To: avkrasnov@salutedevices.com, hdanton@sina.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit c411c62cc13319533b1861e00cedc4883c3bc1bb
Author: Arseniy Krasnov <avkrasnov@salutedevices.com>
Date:   Thu Jan 30 18:43:26 2025 +0000

    Bluetooth: hci_uart: fix race during initialization

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116cebdf980000
start commit:   40b8e93e17bf Add linux-next specific files for 20250204
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=136cebdf980000
console output: https://syzkaller.appspot.com/x/log.txt?x=156cebdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec880188a87c6aad
dashboard link: https://syzkaller.appspot.com/bug?extid=683f8cb11b94b1824c77
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b7eeb0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f74f64580000

Reported-by: syzbot+683f8cb11b94b1824c77@syzkaller.appspotmail.com
Fixes: c411c62cc133 ("Bluetooth: hci_uart: fix race during initialization")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

