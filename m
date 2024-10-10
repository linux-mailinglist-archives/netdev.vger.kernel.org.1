Return-Path: <netdev+bounces-134153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F811998310
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 12:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC1D1F21C44
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383411BE87C;
	Thu, 10 Oct 2024 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="SB32WZ4H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC8D1A070D
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554452; cv=none; b=eZSEvAZtT+c4UIm7zwEA7tFjW76QNYhBKUGtflwcmuiZ74qzit7L/vxfivHOksFuyiuDgFlCHUUCkFpR/xSH6MU4KtM5wpdP2DZ3LYcKG+GBqOHyER8Cg1VLJEmOnjKL1Bs9I3Yniu0YnTq6HvHu529hks3rEKdf3DKqfiW1t94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554452; c=relaxed/simple;
	bh=1hgGmXuLVRKXhHohAA3BPkQmHfbaybE0ZgqiF0mXekA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PrjM3Y+rugAmPFNrtFLbLf3ZLpjnD/0FzIfMWUMTN2dbuHOfJ3u2ts+dRk9xXj3X5jxTiQ+3yQvGhwS9oVYaEDpb8QflG5Fz5tlHyEt0F7g2+ZNilICo31djRzO95RLj27xWANMnfkiHQsDst4Scy7YfHibgExeVnrTYfwge3kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=SB32WZ4H; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a99422929c5so87685866b.0
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 03:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728554448; x=1729159248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ebJVrdaGPpzXVT93kSNOz6xd2XJqXSAdAZ6etIW3Ims=;
        b=SB32WZ4HwXY08XKEfYogl6ssukq4gd+HnUGLZUcdk7LbWahbCDJmETD7jaOvoBJLUP
         S9WbGM27YyZqE2R1kA3CQxgSLl1bPV2WqTDOy7R176MJb3+oOstTOU+2QmZPIMPc+tR5
         5cAwYlgfmtG0UdJgqf+My6WJNv7Jk3+wXHLIbA5hPhbSOOMKzmC0fLDVydxm9YFWilOw
         0LNjFVuB+BM3MPlN4+fdjwE6hM8HwHTX6QZ4gRdnfrgy3kiuZQAKRWO+tVE/UASSwMa5
         FUKhgfvzmNIFw/0LtTOQTB1E2tZYuZYdycc4EQAehzl9Z81X2RM2z2a8rJwYcpjb8AzU
         UMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728554448; x=1729159248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ebJVrdaGPpzXVT93kSNOz6xd2XJqXSAdAZ6etIW3Ims=;
        b=c85NzquRJ6PjxAJiFgHtUZIy/71nJ+H2ouUSoivyQZN/XsQigkr8PUyIUKfSy4d74K
         VtV4HhxfMQpyOsVvnpEUGDmP7RAru3SMozk31DYQm+FVh4G3im6Ad/h6Z6PrpI/bShH4
         rNlVBks9u4yFO+ehgEyv9lEkHy9jiyOihPiw/LOhpu7xjV8BBVbvn5dvmLjQPPef0CpW
         SxiHKiLv8WHgJeSAU4zHF9dSIHXN7neil5iEFltCcvyIlDi3eg2kfLPYAF7eYwJNnLVG
         PDoJGRjKzMYq3GVcqvbyvTOTLH9Xqcaz0JOfkWSrGYIykYp931jGaQW0cG06aArlzIVw
         AHPA==
X-Forwarded-Encrypted: i=1; AJvYcCWP6y70zxI/SzpS+1/t9CnC71DWKlnfoUHLNkI5jxy6w6XXoA0SGiGRVUwVpadIHnRy9EscCZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9J1NvrkewxmnQlULwzx+8OAYV4HOcaDpOeilcWyemA1C9J7QO
	BjUGcbiVW/ck9BwS/H/YmN6qURbbL5/1nivs13TaMBWIkUE+HGuPa4Wdk/bmJew=
X-Google-Smtp-Source: AGHT+IHLpub98hIc5Ob5qa2Hr81nP7l6zY7EVcC34hBKOI7yvtg50A5KLJh78bJSKCuqb8kGAeSA5A==
X-Received: by 2002:a17:907:3e0a:b0:a99:3c32:b538 with SMTP id a640c23a62f3a-a998d32b805mr520152866b.42.1728554447571;
        Thu, 10 Oct 2024 03:00:47 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7ec54c1sm67001166b.10.2024.10.10.03.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 03:00:47 -0700 (PDT)
Message-ID: <879c5998-cd65-473d-962a-7f4442979ab4@blackwall.org>
Date: Thu, 10 Oct 2024 13:00:45 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [apparmor?] [ext4?] INFO: rcu detected stall in
 sys_getdents64
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 syzbot <syzbot+17bc8c5157022e18da8b@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 Network Development <netdev@vger.kernel.org>
References: <6707499c.050a0220.1139e6.0017.GAE@google.com>
 <7fbdb7db-57c3-47b8-89ed-da974d03f17f@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <7fbdb7db-57c3-47b8-89ed-da974d03f17f@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/2024 12:48, Tetsuo Handa wrote:
> This is a printk() flooding problem in bridge driver. Should consider using ratelimit.
> 
> #syz set subsystems: net
> 

It should already be ratelimited, the code that prints is:
                       if (net_ratelimit())
                                br_warn(br, "received packet on %s with own address as source address (addr:%pM, vlan:%u)\n",
                                        source->dev->name, addr, vid);

Cheers,
 Nik

> On 2024/10/10 12:27, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    fc20a3e57247 Merge tag 'for-linus-6.12a-rc2-tag' of git://..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1083b380580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=ba92623fdea824c9
>> dashboard link: https://syzkaller.appspot.com/bug?extid=17bc8c5157022e18da8b
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=135f7d27980000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1483b380580000
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/2ad9af7b84b4/disk-fc20a3e5.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/1afa462ca485/vmlinux-fc20a3e5.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/75c0900b4786/bzImage-fc20a3e5.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+17bc8c5157022e18da8b@syzkaller.appspotmail.com
>>
>> bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
>> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>> rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5244/1:b..l
>> rcu: 	(detected by 1, t=10503 jiffies, g=5253, q=1466 ncpus=2)
>> task:syz-executor116 state:R  running task     stack:18800 pid:5244  tgid:5244  ppid:5243   flags:0x00000002
> (...snipped...)
>> net_ratelimit: 33488 callbacks suppressed
>> bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
>> bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
>> bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
>> bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
>> bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
>> bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
>> bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
>> bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
>> bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
>> bridge0: received packet on veth0_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
> 
> 


