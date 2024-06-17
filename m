Return-Path: <netdev+bounces-103941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C94290A6CE
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 09:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C6F1C225C0
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 07:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F7418FC88;
	Mon, 17 Jun 2024 07:16:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9EB18C35B
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718608608; cv=none; b=doVmoGaMPFObTsx4nJq/ne+QebMNC6WeSQCwCq9/lX/9SJZmJ36T3Aoz38TQH4zSAXxlFvl3zZ149Ai9rJZKTZ3P627Kjji2gPZq2m+YssFtBLX0BegbiJhCEZDQ5+zs27FkuUcSAsmuWWWJsMELaB1gnvEaaViL9+tGIk8dFDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718608608; c=relaxed/simple;
	bh=H7AmQrMJP4s4L5v4AT7IMHIAdsrL5oe6gLYAaKub+Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=quxDoo7PLr/HaG8ISe9WfKwJHjipt+8cL4NbsTyOTYMmsizJF/U84VYlbZB9ANhQGqWNWwJHCCzu7BQ8t5CEJQtJvgDXE8768BjbEfGtcgfQrINsnOX/i2PB1o6wvLsCCQSyvVh2qd6PdppoDWQBC+XnLxycg6nd9C3BIEfYPLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav120.sakura.ne.jp (fsav120.sakura.ne.jp [27.133.134.247])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45H7FwLU025803;
	Mon, 17 Jun 2024 16:15:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav120.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp);
 Mon, 17 Jun 2024 16:15:58 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45H7Fwki025800
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 17 Jun 2024 16:15:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <4ffb1d55-acfd-4647-a4d7-f227a6ad21ea@I-love.SAKURA.ne.jp>
Date: Mon, 17 Jun 2024 16:15:54 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] [virt?] upstream test error: KMSAN: uninit-value
 in receive_buf
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>
References: <000000000000d10c260619498c25@google.com>
Content-Language: en-US
Cc: syzbot <syzbot+799fbb6d9e02a7a1d62b@syzkaller.appspotmail.com>,
        davem@davemloft.net, edumazet@google.com, eperezma@redhat.com,
        linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux.dev
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000d10c260619498c25@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Bisection reached commit f9dac92ba908 ("virtio_ring: enable premapped mode
whatever use_dma_api").

On 2024/05/26 1:12, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    56fb6f92854f Merge tag 'drm-next-2024-05-25' of https://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=157a5462980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1b6c22bca89a3565
> dashboard link: https://syzkaller.appspot.com/bug?extid=799fbb6d9e02a7a1d62b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/39a256e13faa/disk-56fb6f92.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d4ecc47a8198/vmlinux-56fb6f92.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/0d37bfdfb0ca/bzImage-56fb6f92.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+799fbb6d9e02a7a1d62b@syzkaller.appspotmail.com


