Return-Path: <netdev+bounces-109630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3E09293D0
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 15:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792651F21E1D
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 13:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65BE12DDA2;
	Sat,  6 Jul 2024 13:38:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488D674063
	for <netdev@vger.kernel.org>; Sat,  6 Jul 2024 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720273084; cv=none; b=WzHoL7rBCl+oa5ZfdW/bOjxrFOTfRW9w87LEf8XL7JdulnvgOTn4wwkk1U0bVYjovgxxkCgY4qYlmv3zje9J02o7ZPhi+gUGnnXvbgfB1VcQAuyuxtx6IUGuw0OAFpCBdSdRJ+fHhkTp934UgFvDa4NWpBRv2UnbjlCHZubK15U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720273084; c=relaxed/simple;
	bh=zWaW7v6PJhOBV43NT3fE4HnLKL+0G6JoD8gx4YTscdU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SyymE3rTsHAgdLYTQiJ4XbhwF3c/zrxEW4GzeVg1/Yd7b8RfKw9CrEG9Tgx6xLK2R0j640CJoCIVL+lkXZ2T/2NtvuNEHH0weAmdPQO/J92lUKtukHH7zwAiXABReX2N2DJaBMQ16TmfR10y0r/Ql1JlU9uRPy4a7UkTKWbter8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7ec0802fd0dso300111239f.0
        for <netdev@vger.kernel.org>; Sat, 06 Jul 2024 06:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720273082; x=1720877882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SrvwA9+kz/VdMLLWXSyRN3pFrHfsHxWlAply6NHrwzg=;
        b=OJn9gV497Ks1LagNG7v4JuU0ZvlQXvCBWkCVPU2mXkQVd0gF9gd1AzcKly9UEPDpAX
         BS7sdYL1y/cQLzjV7A+8EbU9HBP8a069KyKJKc96exJ/B+cWZEbO771YXhDcAv1WuVEY
         3/pZs8X+GFUP8cs/QchH0x/L2tLwSWB1b6my7ZGmjfNOFX5uUiH+2EpMPOKqf8bD1cUf
         4dhikNZb7D+MtwwoAMPrG5w3Ug6HKa37MiJiL2+0S71hf+sNVaOElDANWdT1AXWm4IEZ
         BUlIyv5gIc6fZMuG5p1I4o1/X+qNNSRqYZkLo/G6MbeXVAxQg1mtda35U04hCn0fT6L6
         2ydA==
X-Forwarded-Encrypted: i=1; AJvYcCU7Rt73XRl6clqciP1WVpO7HNTfjzbxyzhaKfVAgdFW3XBOVtwFIezOLydLHqpsLQmiqCgDEQuVa7udY/ExKGiRUJ1WgDOG
X-Gm-Message-State: AOJu0YxO4DxOiq3mXncYo95zV4vdlugQHh5Yj9/hh6RcR1TShi9WU4eU
	aLZBo6h7sUy3fV9z32NW6p0l8FuLO5j0yO/5Pz0LaWlu3Gp0pqSPcMFTZ1roSsuwgTWVZuC5Yx/
	Yt4SsmCu6bsM2QMj5aHcI7o9FWYhCA2lfKylFHVPalr0crRUWNEKa9g8=
X-Google-Smtp-Source: AGHT+IHCSx2+VbzZCCozhjDVuSHJ5tQ1gic4b9jAHvFVi10Tecnep7tLHfjFLuZpWjQmZJs8YvMggPuufjgt+z+fOZLhmQgFhl/w
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:144d:b0:4b7:c9b5:675c with SMTP id
 8926c6da1cb9f-4bf63c2f6efmr1014361173.6.1720273082401; Sat, 06 Jul 2024
 06:38:02 -0700 (PDT)
Date: Sat, 06 Jul 2024 06:38:02 -0700
In-Reply-To: <20240706131317.Vx3MriDC@linutronix.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe576c061c944907@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in dev_map_redirect
From: syzbot <syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bigeasy@linutronix.de, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	eddyz87@gmail.com, haoluo@google.com, hawk@kernel.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, patchwork-bot@kernel.org, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com

Tested on:

commit:         2f5e6395 Merge branch 'net-pse-pd-add-new-pse-c33-feat..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=12f8b8a5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db697e01efa9d1d7
dashboard link: https://syzkaller.appspot.com/bug?extid=08811615f0e17bc6708b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

