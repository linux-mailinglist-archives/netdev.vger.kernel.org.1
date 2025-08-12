Return-Path: <netdev+bounces-212986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C808CB22BC4
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2B01A278AA
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478C12F5303;
	Tue, 12 Aug 2025 15:34:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4D72D3233;
	Tue, 12 Aug 2025 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755012845; cv=none; b=qZlkJDLrOLKoitXJRvRax96cXkshFJ83cJWvpALu6V2pIDr2URko+49vapWusxKvjCbxODFa6vLJ6VBMsYEq3X1l5DRbpb41O9yKjgea0fV3S4k+60GG740BRBz0Lu+fLK0LzrNzsecNc2ozK1Kqt1PTb4LHz4HMeOBczf6NGno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755012845; c=relaxed/simple;
	bh=3HP4rYFB0nXp4RH1H6ler/1qRYdsq955QxY6FVo7g8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5+SmadDnJRMlN1XB5bcr7IQxvufIQFxV4hYoPVPRVo4gMKZIM6NJCplunTwzTOoGcztyzvR9qTQoScxsaT5mIRpO7Y0e6L/c+L4HiuYGNUQVjyz6ItATqy0rSCsBE1ZDXMnBxBkHLTSM1TF0/jrRWa24pcqJfFs/TAaw10ZHpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6182ea5a6c0so3527685a12.0;
        Tue, 12 Aug 2025 08:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755012842; x=1755617642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xN4zx4r/dfg5YJKr/XyR6Pv8I6B1he5YQrgdvyTIGMA=;
        b=ccpSOS2v7cxjw6hAu/rxUf9xIKLbFcSkOnPSiRAnPRJjV6HKTTUf51yQBV1d/UpnJp
         /BfCl8WnIf+XcHe720JQEfTkv3Gq1EZ+XvZ9dTlhNOh05V3k5YT/KtobKqGCYWFZj/pl
         f6ohrsBH+8liXp/DNqQVFGn2mxgyuMbwMoORcvRa/I2iWwpF4C3yxCSLvbL6i2cjcrTg
         iKASYUvTlRRO5BjxCDwmnhFK6aQIvW5dUYdUmcR/Eoiyx3o3dLf9ZPhBtDYp1xXvG3c6
         UQwNCroJsKK9jNL3dUE5fP2Ystnn3+Jf8UrB/XaCfCyn4/Tw6CWLIvEWG3Q/P0eXotbl
         qrDA==
X-Forwarded-Encrypted: i=1; AJvYcCUZL1loQba9bgViN49vsWUNN0eMJYmRL+NHKERcZeJwnw5Nzf69jaG7kBlObYlBpcaDDP1QvibcjyktzAU=@vger.kernel.org, AJvYcCUxYsDeH1oKm+KTu5E48LutyzDHU8Unk192Y+6KU/R+2QPVnIwTg/38V3GQb5vENX3PHsKD2z70@vger.kernel.org
X-Gm-Message-State: AOJu0YyiLOV+qegKIGxftyXH0NzEac1I3MY4sLCZLetjt6NUVrMuJnpY
	YScADt54kA+k//tN/CYdzpzEnmE5v1NMczz1fiPybkR5xTHiTkhDI+G5
X-Gm-Gg: ASbGncsRV/XirUwI8Okiin4i3n+4CZm0Tr9Wl5139AiKw/nIwVeaQIS+MioeB9zta0F
	wNHcYP2+SAy+HGmUL8xAoDO4Mmdgt0qhofopvXiTt1NM67mDxBeZhIvptoNLMUMe+e1cirn9rQH
	inLgAChC36Mm3SUPtA/30ZwH/Y/vep6YikTT5Yt4BVH+Vf7xAzfHjXD/OsVGQgwDMVvMWJT9q8o
	EAZVByclOVPXGpu4o7NYy737UwOQgW2x3j8D02IyJDid5Ui5pfkIwkqKVTjJvAKMUrsdUE2JGw9
	BY3tQFRU9fO2DmsHApYRcfYAAuKiThVJ/ggagntwU+20psOAFzPsH7QbjBUO/CHwx1ze81o/U23
	odUi5r2btaZmPHg==
X-Google-Smtp-Source: AGHT+IFNnHB2fF9bZTqHtrsJWXRvSiR93SK21LOqlw4oy8VF21VQoHD8s+CIk1phTQJPBNRbHEQvbQ==
X-Received: by 2002:a05:6402:400b:b0:618:227d:34c0 with SMTP id 4fb4d7f45d1cf-6186785024amr220923a12.30.1755012841529;
        Tue, 12 Aug 2025 08:34:01 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a9113e40sm20361457a12.57.2025.08.12.08.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 08:34:01 -0700 (PDT)
Date: Tue, 12 Aug 2025 08:33:58 -0700
From: Breno Leitao <leitao@debian.org>
To: syzbot <syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com>
Cc: andrew+netdev@lunn.ch, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, kuni1840@gmail.com, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] BUG: unable to handle kernel paging request in
 nsim_queue_free
Message-ID: <xalg6eonr23hzgr5cbnmxfid2sv7crwgtehmytpkdiqzvpdsn6@tkjqfsirrlrv>
References: <688bb9ca.a00a0220.26d0e1.0050.GAE@google.com>
 <689b1044.050a0220.7f033.011b.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <689b1044.050a0220.7f033.011b.GAE@google.com>

On Tue, Aug 12, 2025 at 02:58:28AM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    53e760d89498 Merge tag 'nfsd-6.17-1' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16c415a2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d67d3af29f50297e
> dashboard link: https://syzkaller.appspot.com/bug?extid=8aa80c6232008f7b957d
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151be9a2580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-53e760d8.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7f26eabe958a/vmlinux-53e760d8.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/60128fb74c23/bzImage-53e760d8.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com
> 
> BUG: unable to handle page fault for address: ffff88808d211020
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0002) - not-present page
> PGD 1a201067 P4D 1a201067 PUD 0 
> Oops: Oops: 0002 [#1] SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 6665 Comm: syz.1.416 Not tainted 6.17.0-rc1-syzkaller-00004-g53e760d89498 #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:local_add arch/x86/include/asm/local.h:33 [inline]
> RIP: 0010:u64_stats_add include/linux/u64_stats_sync.h:89 [inline]
> RIP: 0010:dev_dstats_rx_dropped_add include/linux/netdevice.h:3027 [inline]
> RIP: 0010:nsim_queue_free+0xdc/0x150 drivers/net/netdevsim/netdev.c:714

This is being fixed in this thread:

https://lore.kernel.org/all/20250731184829.1433735-1-kuniyu@google.com/

