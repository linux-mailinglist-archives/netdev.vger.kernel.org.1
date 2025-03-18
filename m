Return-Path: <netdev+bounces-175853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58037A67B20
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 18:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE573AE72F
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 17:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8BB1B3957;
	Tue, 18 Mar 2025 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4JQja96"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A337220F091
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742319600; cv=none; b=rXt0aSCBq55M7lRoX3so4OC4X0DxNIByIJIhkRYwETvUCRyRFUOEVzxo9OQxM6zFFDYkWEVzf8v7xcuE5zjyUxqm3mwO4Wox2FMs9q0hH11tUVpm22xuujKVYGZAQaKsY+E77R+8z5E/MrlHIbJRaFFvAKMXzJTLKM1+GEOMz2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742319600; c=relaxed/simple;
	bh=LFU/NttlSNCPPnWnlFR2zQJpTCiWKXsFEck46ERKMIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GgTUZMO56TPpbx1COwS9KSTGI8+VEbwERzB6b+H51en/aDxcc9J9Hf8iI/YBy7p/TQs0TZIMlfCAqQlCToQQ58Rp9Uk++LnR4tR3Xa1R79S4P21wCwY5KgwVjZwfX0CokRDT5GbIZmwxRnoQUlwknwumCfnDN8tR7eQUi1zuDJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4JQja96; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742319593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3cY/S3V1OiJeeTHfh/+qu+B682kGW/beC29yAeSAm8o=;
	b=E4JQja96CIbWm6sUU4UFI2yz3kvgFSsB3vGz5UnYN8iPEDg1N5lxlmp4HnP4V0d6UmiQox
	ZfG3jVjLWrfyreV9ypZFsK3TF1W1LkNH3I1RHOhe7wtEMwoGo5NBAh4j7InyF5+IsDjD/T
	OfeRyOrBBHu0+Mbpxg8NL26A1DS3cno=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-AuqSAuS_O5eKgiO9UfXWYg-1; Tue, 18 Mar 2025 13:39:52 -0400
X-MC-Unique: AuqSAuS_O5eKgiO9UfXWYg-1
X-Mimecast-MFC-AGG-ID: AuqSAuS_O5eKgiO9UfXWYg_1742319591
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-391425471d6so2444057f8f.3
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 10:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742319590; x=1742924390;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3cY/S3V1OiJeeTHfh/+qu+B682kGW/beC29yAeSAm8o=;
        b=UnTN+ft1nm2xMYoP3ezT18eWHFIHQyd+j0rKV9rYyL5JOQQ0E4z0WdyDkTLMn8dNmv
         qYrViSaNMP/CUoUPg2FCFwPIS4cvd3W3e3+qHaGYep6K4q6kjUskA0tvTKx57oSJN8k8
         EhNnsLuQ2aeuKGwToPCpOgYDza0XTA2oeCI1UWI+7IF4//Ije/Wv7Ma4TMA5j3DzZbcP
         vitrU3x72FqkbGctAduUqX3U8BA3UPShy5Va9jUi+Im/C4sE8xVcygKgqGkWiNDtOOmM
         v+IqsIzeZKdJA0o8sZZ6p9TjLmVei40TFpKITYlRk5+gOzK4IR2vbOZ7yhuCxzkVwCgp
         mu5A==
X-Forwarded-Encrypted: i=1; AJvYcCXP7nDS/uL6bZuOHrh4sSZx48ITFogKAU5D95enLT50KR2HxbXKfu1xopg13tXWPmC5BWj7Oaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp92bNHgxUaVpoKsejQKO8BFRXPEt94ygv+yQgArq+d3Nfw+CD
	aFzmt1hFreolLtJzQCZBV/OgbFLnEO/iTNr8MH0a+j1r43htPDilWvCC1HAgMJnog+hjWbUsSFq
	KNL6j19yCvU1i8vkAk36UZ8uW37rS6N9LXG+4g3I6xUR8gCXCpsovIA==
X-Gm-Gg: ASbGncu0PLu3hoChrP8lfUbd69xeRE1g5omGV/wlCGhFGu89X02rvOaRo8YbqbDc5QQ
	1oKNd3HEGwN42Oybd1fIMNUc2WlOONMUnyDvMe93S8v3Dp/2kvpzjWb/JUnwvhPPblprH/abZ0d
	wao7boCKKmrKf/ZXgbBav6ztpL2nM+ksQSJszd2ZC5LHSypCZI1EQG5eJyv3f2pk9hjSfOVF5xq
	XYIQjzrPxNNEvi067MJqdCIFa3PbL2YfLrSLXB93RxuG7BtmuHhwE6VXPEddqDu0j29roSp9iNw
	Qf35uOHZWVJ54igUDggouUulnhD2W0emGgff4Q6RpPRvfg==
X-Received: by 2002:a5d:588e:0:b0:391:49f6:dad4 with SMTP id ffacd0b85a97d-397209627bfmr20789987f8f.41.1742319590525;
        Tue, 18 Mar 2025 10:39:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyc6CZRpuuK+7eLs9KSdExXn0k5d7MalGV8+LtDdTRH71m5JxeFr1Sd/jbDnhdqlKns+4Ttw==
X-Received: by 2002:a5d:588e:0:b0:391:49f6:dad4 with SMTP id ffacd0b85a97d-397209627bfmr20789967f8f.41.1742319590118;
        Tue, 18 Mar 2025 10:39:50 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df35bdsm18253185f8f.5.2025.03.18.10.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 10:39:49 -0700 (PDT)
Message-ID: <f2d7e0d6-8dc1-4c1d-bf1a-ea9db7ec554b@redhat.com>
Date: Tue, 18 Mar 2025 18:39:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] WARNING in udp_tunnel_update_gro_rcv
To: syzbot <syzbot+8c469a2260132cd095c1@syzkaller.appspotmail.com>,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <67d99951.050a0220.3d01d1.013e.GAE@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <67d99951.050a0220.3d01d1.013e.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/25 5:03 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    aedfbe251e1c Merge branch 'udp_tunnel-gro-optimizations'
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=177f45e4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=aeeec842a6bdc8b9
> dashboard link: https://syzkaller.appspot.com/bug?extid=8c469a2260132cd095c1
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/18e6408e4123/disk-aedfbe25.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1cdafe4afee8/vmlinux-aedfbe25.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/eda00f4a96d9/bzImage-aedfbe25.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8c469a2260132cd095c1@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 24136 at net/ipv4/udp_offload.c:118 udp_tunnel_update_gro_rcv+0x31d/0x670 net/ipv4/udp_offload.c:118
> Modules linked in:
> CPU: 1 UID: 0 PID: 24136 Comm: syz.0.4789 Not tainted 6.14.0-rc6-syzkaller-01279-gaedfbe251e1c #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> RIP: 0010:udp_tunnel_update_gro_rcv+0x31d/0x670 net/ipv4/udp_offload.c:118
> Code: 23 48 89 eb e8 14 47 4f f7 c7 05 ca a9 32 10 01 00 00 00 31 ed 45 31 ed e9 80 01 00 00 e8 fb 46 4f f7 eb 40 e8 f4 46 4f f7 90 <0f> 0b 90 e9 5a 02 00 00 e8 e6 46 4f f7 eb 2b e8 df 46 4f f7 eb 24
> RSP: 0018:ffffc9000ad7fc50 EFLAGS: 00010293
> RAX: ffffffff8a72ab0e RBX: 1ffff1100502bb6f RCX: ffff888020f55a00
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000004
> RBP: ffffffff86c2d1a0 R08: ffffffff8a72a6eb R09: 1ffffffff207a2ee
> R10: dffffc0000000000 R11: fffffbfff207a2ef R12: dffffc0000000000
> R13: 0000000000000004 R14: ffff88802815db78 R15: 0000000000000000
> FS:  0000555582b32500(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000040000001e030 CR3: 0000000034eca000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  udp_tunnel_cleanup_gro include/net/udp_tunnel.h:220 [inline]
>  udpv6_destroy_sock+0x230/0x2a0 net/ipv6/udp.c:1829
>  sk_common_release+0x71/0x2e0 net/core/sock.c:3892
>  inet_release+0x17d/0x200 net/ipv4/af_inet.c:435
>  __sock_release net/socket.c:647 [inline]
>  sock_close+0xbc/0x240 net/socket.c:1389
>  __fput+0x3e9/0x9f0 fs/file_table.c:464
>  task_work_run+0x24f/0x310 kernel/task_work.c:227
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
>  do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f3518f8d169
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffdfbd8d008 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
> RAX: 0000000000000000 RBX: 00007f35191a7ba0 RCX: 00007f3518f8d169
> RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
> RBP: 00007f35191a7ba0 R08: 00000000000000e8 R09: 0000000cfbd8d2ff
> R10: 00000000003ffcf4 R11: 0000000000000246 R12: 00000000000d64d1
> R13: 00007f35191a6160 R14: ffffffffffffffff R15: 00007ffdfbd8d120
>  </TASK>

Whoops, I did not notice that xfrm sets up->gro_receive, too, using a
different code path WRT setup_udp_tunnel_sock().

I think it's better to relax this WARN.

/P


