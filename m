Return-Path: <netdev+bounces-180364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D0CA8117F
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF2E881CEB
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB202550A2;
	Tue,  8 Apr 2025 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xonx/cjf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ECC22D7AE;
	Tue,  8 Apr 2025 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127802; cv=none; b=cW4pkVN3boZRfco55QWvAA1gm0KQEXgW6Qa+OAwMNfZHZOTiOSyXZQ/kThCCRWFWnKznYRt8ElY+//BCeli7QCkZaUhSnLGi9Cs9lhXTtT198Zjq4AfkhnF2+uGCQJuCUuiyyMcRGstMaqt4q09xP3PKWyCEoMt00kaj/ocigWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127802; c=relaxed/simple;
	bh=NuCi+nDF9crUQoMi5wM+LePlLWUwiPgvZOlIzO5vlCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZI2nax/q/cmyVrbOvIjSoFtqedWzivThEYi5+yZPlyoeuWHlZsmUOcpW2mKWrfoNec9cOSyQ17hDDxEPpaT5Xzaqp44g8w1TQRaKEQ4r/OGXJZkuawfS1TzCrPg65tIJXOLtsvGws2AihFOFt6bI/eH8gE/M9ClTf23PlFNnrXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xonx/cjf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2295d78b45cso76244375ad.0;
        Tue, 08 Apr 2025 08:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744127800; x=1744732600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=affzJlfeuyLH/afrS0PgLg2pJtDzPDL4GjLq78Ev2zs=;
        b=Xonx/cjfJj77hfmjxpdNTTxPi6OOYU3xr1OO4ToV5MhpnhhrvsYpNm3ZFZ0LGTQ2c1
         jfCw71L1ZqgB8YHcrfme71aal2dMGpJyyrzVmUE1r+RoqjemKA4yv3TdVIvqJ3ACBcIJ
         SQSvL2250anGyhBCT/UXqVGWSbaP8vvKsph2gUVMiJwskxyF3nt2VE5x0MJrR/eM7e81
         CW3J8h5qCP6F88OLwJb5jhIRYsZPnqy+eYdtUvB8TbGn+d9uLXpOsawT4Hv+IHMaSiNt
         047i12bRtHOfpg2+zS+uRNgnukptZBEu/3caZX1rBxe5IbSEu7hs1rJVksORE1hJpFjc
         nkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744127800; x=1744732600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=affzJlfeuyLH/afrS0PgLg2pJtDzPDL4GjLq78Ev2zs=;
        b=ARbkrP77+AtA3+zOCvgkbonRuZ5/SYqBvirbUNhqvHRnFM9i0pjTXeHwEbTGp3mYNv
         wt92Y+STnaE9i1a83ud0oYAVkepoXGYq3cE8gNK3CYArvYeyBJ52KOmSsGpoKUerS9ee
         Vy3zeuvrGzVos4ySlF0OUXnkCGJ+bRSO1RWyqFFm+2FWRHrsIDe27zPYGo8ITBk0+3bR
         k4LDtJ095lrRK1oOriaLnl8iyTWPeBzoddx5FXwvXzEQX2EnZ2ed+39RvTdAax0+Q4kb
         84bpjPcVNMaCvufL0O5DRgT3A8GKdgdrBT5+O+lyiOhGM3bnrM9C4afOeqLat4UfB9cC
         EYNA==
X-Forwarded-Encrypted: i=1; AJvYcCVopc7wfXawUki8BBIu7VvN+X03CllL7Ox93754viRyqQnTbeim+fQtWBS8bI9VnztvE5WSN4tY@vger.kernel.org, AJvYcCWr+tuUkN8oWsSIfW2lK6ZT4R+jnf29EFf153FSzjP4XvuUdy5ISNzWEkA5HPqNcoYF7CaC0H8jevS6uio=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWWNICuBr5CAkWjk2TGv5tSotSM9VE92hA/E8nsntBINhXHVd6
	OZGIdTXLZMB0mg6R2olTbmhIyyn9Ur3lQcxTz0Btn8KDtmEWem8=
X-Gm-Gg: ASbGncuI8737nwIq4iU1In56HPRpP46Tyl+TNDPBvOAckamWOzeVRZglhVL8xfSRriu
	3LMwOWv+WIvg90xmSwR1nQOShz7SDS27uWTyFA3+IobBeujwHpxBohCt7MpRntcscMzM00X/Xxy
	Tq0prACpEB47XbjLCOtSh3bpmyfjQqDs+gQ2kJ62/XKo9rl9swy+jM5/hQe/m75e5RR0MOmeMSX
	nQfjlk4KjAYpKOmWoyzl0GLmDBrdRpvFMLZaoWAVCKVdJHY//ILAr0FUFtEdgR5I6YIBZd3HUEa
	VEQrDkvRf3n/eukv36wF/FYukYMinTDqtcFBCbkwIW+g
X-Google-Smtp-Source: AGHT+IG0zZw727VjBHQVHWXJeTmxJ3mhCgj6F2p95LiwEhiwGMKetvFsZh6wJSLG0xQ8S40XBA0ttw==
X-Received: by 2002:a17:902:db09:b0:224:255b:c92e with SMTP id d9443c01a7336-22a8a0431ffmr193175125ad.3.1744127799574;
        Tue, 08 Apr 2025 08:56:39 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2297866e4c2sm101866535ad.199.2025.04.08.08.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:56:39 -0700 (PDT)
Date: Tue, 8 Apr 2025 08:56:38 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: syzbot <syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in __linkwatch_sync_dev
Message-ID: <Z_VHNtNQ5hqZx33v@mini-arch>
References: <67f4d325.050a0220.396535.0558.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67f4d325.050a0220.396535.0558.GAE@google.com>

On 04/08, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7702d0130dc0 Add linux-next specific files for 20250408
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15fe8070580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=91edf513888f57d7
> dashboard link: https://syzkaller.appspot.com/bug?extid=48c14f61594bdfadb086
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0603dd3556b9/disk-7702d013.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d384baaee881/vmlinux-7702d013.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1ac172735b6c/bzImage-7702d013.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> RTNL: assertion failed at ./include/net/netdev_lock.h (56)
> WARNING: CPU: 1 PID: 2971 at ./include/net/netdev_lock.h:56 netdev_ops_assert_locked include/net/netdev_lock.h:56 [inline]
> WARNING: CPU: 1 PID: 2971 at ./include/net/netdev_lock.h:56 __linkwatch_sync_dev+0x30d/0x360 net/core/link_watch.c:279
> Modules linked in:
> CPU: 1 UID: 0 PID: 2971 Comm: kworker/u8:8 Not tainted 6.15.0-rc1-next-20250408-syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> Workqueue: bond0 bond_mii_monitor
> RIP: 0010:netdev_ops_assert_locked include/net/netdev_lock.h:56 [inline]
> RIP: 0010:__linkwatch_sync_dev+0x30d/0x360 net/core/link_watch.c:279
> Code: 7c fe ff ff e8 f4 63 cc f7 c6 05 83 28 53 06 01 90 48 c7 c7 60 5c 51 8d 48 c7 c6 8a 9b 67 8e ba 38 00 00 00 e8 04 6b 8b f7 90 <0f> 0b 90 90 e9 4d fe ff ff 89 d9 80 e1 07 38 c1 0f 8c 19 fd ff ff
> RSP: 0018:ffffc9000b767710 EFLAGS: 00010246
> RAX: bb6ea754fa006300 RBX: 0000000000000000 RCX: ffff888030979e00
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffff81824ed2 R09: 1ffffffff20c01c6
> R10: dffffc0000000000 R11: fffffbfff20c01c7 R12: 0000000000000000
> R13: dffffc0000000000 R14: ffff88805d768008 R15: ffff88805d768000
> FS:  0000000000000000(0000) GS:ffff888125089000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f85e8c4df98 CR3: 000000006a050000 CR4: 00000000003526f0
> DR0: 0000000000000099 DR1: 0000000000000000 DR2: 000000000000000b
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:63
>  bond_check_dev_link+0x1fb/0x4b0 drivers/net/bonding/bond_main.c:864
>  bond_miimon_inspect drivers/net/bonding/bond_main.c:2734 [inline]
>  bond_mii_monitor+0x49d/0x3170 drivers/net/bonding/bond_main.c:2956
>  process_one_work kernel/workqueue.c:3238 [inline]
>  process_scheduled_works+0xac3/0x18e0 kernel/workqueue.c:3319
>  worker_thread+0x870/0xd50 kernel/workqueue.c:3400
>  kthread+0x7b7/0x940 kernel/kthread.c:464
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>

This needs ops lock/unlock around get_link in bond_check_dev_link, will
follow up.

