Return-Path: <netdev+bounces-148628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3DB9E2AAE
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 19:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F2D82814AB
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 18:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A295A1FC7EF;
	Tue,  3 Dec 2024 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oy6XdlqY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA53C1FBEA5
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733250086; cv=none; b=DJUHA0j4Eu6vXQP9aJoK7mqU6JbCwWYDizgBDBYoDIR9UD/DvAm2/BW4uMTcL1p9SGLtNAsqnD90NIXVcHWIlsk22yota6UHUKEN2FJyAYVMGJO4r8XwYRnJ0YBTYbEjLNzKoAA1iJS1Y2FA7okAL9xUEs7z5wrofl6yUkSixWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733250086; c=relaxed/simple;
	bh=0pR8wHbG2EpinRUX7sOjW5bAxd3b/Yk6MGMuZbsLWrs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cKfyx8UwhJ2yEWPEeEAMrntU0kGozwKkFNy6Dbj6rjNc4OBIRsv6ilnuZyMiV+jL8CyvjUuTv12VcA0N528uiu9YuPE2zO+7ekHfZ8RGa9/8euygN+RJ1DkNHdLLY2l1xYLekp++cODcoVni7eqCIm3IxKVE7NU/HwLe5Dk9EMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oy6XdlqY; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6d884e46548so68379976d6.2
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 10:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733250084; x=1733854884; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FN54Sr9QLBQIrkewMRkTvBLZ54fjMvSBCIBoEcUqnnc=;
        b=oy6XdlqY1BEnFy2CAUSTIBmFbH7NzEFsARaH+CsGtW8o+FjN4jMfE4ATLYDBJ6N/UL
         Il5UcEvg58O7J7OfgFiwTE85W89Ct/n5j2ZElj/urU+OesuJ3oGOd0NZMYd4aAwiyMZE
         QPM09Ur1Uc4tav3YIeXIwdix3PrCSsTm8McK/gVhjMqS3dwSOyhqugy8cKDcDFgXfZXV
         iIP4Vk9y4mxesRks7WmWR19CAQU5Xl9l9zx+HWHc5EgGYeEKXYZB1txzMHTfmuGBRHJf
         PT0bdaiqGeCBWVtDvvfS6ljuEDODpZwT3R3Q9Rh8nt5kXV4aeYj8SvNM7fejF/FybRHP
         5yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733250084; x=1733854884;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FN54Sr9QLBQIrkewMRkTvBLZ54fjMvSBCIBoEcUqnnc=;
        b=OPQGHkC7H6Q5S6X/KWHoMrmkjKKqnYkWZOHXRp4CO7J/56bONHyFg4I0/V6Tjn3vyU
         6CUns1z4lnITkiKmsx2Bxot7CpfpaV+PBZcg9SHWjNWhKdCW54wXdiPlTUatZdHHOHB3
         aePwaDc7uxPJpIB9l8IHFfLjp4Fu8Va7b7OEjgBNLSI5vTsrm1/hTd24OlSnxg187pO0
         fdY5kE/i2IPPAq6VjfnsE7EzHFkJ8MyHRMhqZ93JuSfHFtYzlDfRoj2EESumZmC31s8U
         9xcuezdTQi0W+Z1Rb+7gNxN6afgKewfBWYlJnDenl/6NAc7Yo73thl2c2YdGHH/kPh75
         Zmng==
X-Gm-Message-State: AOJu0Yzs0/MsPME7R8rugxxRGLTdr4A7fDJHtLLj3P0JpNOzMuHP0J8A
	nyUnM1YoknqXB+yWFDnVH4zk8A0hXYFasMYL0JYKnjTiUDt8Puw7bKPSsikyL50QKzoe4WeGl0Z
	emySGJewrSQ==
X-Google-Smtp-Source: AGHT+IHbBd9W6ycVnDiuz7WTesF9LGA1mq2faGp9Mkh+wSYLEwfzsRHOnX/1ktaCWsd9bEvlOxhSi/FSRQaeLA==
X-Received: from qvc12.prod.google.com ([2002:a05:6214:810c:b0:6cb:2aa1:eb4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5aee:0:b0:6d4:19a0:202 with SMTP id 6a1803df08f44-6d8b740e6a7mr41783096d6.33.1733250083785;
 Tue, 03 Dec 2024 10:21:23 -0800 (PST)
Date: Tue,  3 Dec 2024 18:21:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203182122.2725517-1-edumazet@google.com>
Subject: [PATCH net] geneve: do not assume mac header is set in geneve_xmit_skb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+3ec5271486d7cb2d242a@syzkaller.appspotmail.com, 
	Stefano Brivio <sbrivio@redhat.com>
Content-Type: text/plain; charset="UTF-8"

We should not assume mac header is set in output path.

Use skb_eth_hdr() instead of eth_hdr() to fix the issue.

sysbot reported the following :

 WARNING: CPU: 0 PID: 11635 at include/linux/skbuff.h:3052 skb_mac_header include/linux/skbuff.h:3052 [inline]
 WARNING: CPU: 0 PID: 11635 at include/linux/skbuff.h:3052 eth_hdr include/linux/if_ether.h:24 [inline]
 WARNING: CPU: 0 PID: 11635 at include/linux/skbuff.h:3052 geneve_xmit_skb drivers/net/geneve.c:898 [inline]
 WARNING: CPU: 0 PID: 11635 at include/linux/skbuff.h:3052 geneve_xmit+0x4c38/0x5730 drivers/net/geneve.c:1039
Modules linked in:
CPU: 0 UID: 0 PID: 11635 Comm: syz.4.1423 Not tainted 6.12.0-syzkaller-10296-gaaf20f870da0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
 RIP: 0010:skb_mac_header include/linux/skbuff.h:3052 [inline]
 RIP: 0010:eth_hdr include/linux/if_ether.h:24 [inline]
 RIP: 0010:geneve_xmit_skb drivers/net/geneve.c:898 [inline]
 RIP: 0010:geneve_xmit+0x4c38/0x5730 drivers/net/geneve.c:1039
Code: 21 c6 02 e9 35 d4 ff ff e8 a5 48 4c fb 90 0f 0b 90 e9 fd f5 ff ff e8 97 48 4c fb 90 0f 0b 90 e9 d8 f5 ff ff e8 89 48 4c fb 90 <0f> 0b 90 e9 41 e4 ff ff e8 7b 48 4c fb 90 0f 0b 90 e9 cd e7 ff ff
RSP: 0018:ffffc90003b2f870 EFLAGS: 00010283
RAX: 000000000000037a RBX: 000000000000ffff RCX: ffffc9000dc3d000
RDX: 0000000000080000 RSI: ffffffff86428417 RDI: 0000000000000003
RBP: ffffc90003b2f9f0 R08: 0000000000000003 R09: 000000000000ffff
R10: 000000000000ffff R11: 0000000000000002 R12: ffff88806603c000
R13: 0000000000000000 R14: ffff8880685b2780 R15: 0000000000000e23
FS:  00007fdc2deed6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30a1dff8 CR3: 0000000056b8c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  __netdev_start_xmit include/linux/netdevice.h:5002 [inline]
  netdev_start_xmit include/linux/netdevice.h:5011 [inline]
  __dev_direct_xmit+0x58a/0x720 net/core/dev.c:4490
  dev_direct_xmit include/linux/netdevice.h:3181 [inline]
  packet_xmit+0x1e4/0x360 net/packet/af_packet.c:285
  packet_snd net/packet/af_packet.c:3146 [inline]
  packet_sendmsg+0x2700/0x5660 net/packet/af_packet.c:3178
  sock_sendmsg_nosec net/socket.c:711 [inline]
  __sock_sendmsg net/socket.c:726 [inline]
  __sys_sendto+0x488/0x4f0 net/socket.c:2197
  __do_sys_sendto net/socket.c:2204 [inline]
  __se_sys_sendto net/socket.c:2200 [inline]
  __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2200
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: a025fb5f49ad ("geneve: Allow configuration of DF behaviour")
Reported-by: syzbot+3ec5271486d7cb2d242a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/674f4b72.050a0220.17bd51.004a.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Stefano Brivio <sbrivio@redhat.com>
---
 drivers/net/geneve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 2f29b1386b1c81640562e6ce91d6e8d88f0ffe1c..bc658bc6088546d5d1f116988b93d4dda915a799 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -895,7 +895,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		if (geneve->cfg.df == GENEVE_DF_SET) {
 			df = htons(IP_DF);
 		} else if (geneve->cfg.df == GENEVE_DF_INHERIT) {
-			struct ethhdr *eth = eth_hdr(skb);
+			struct ethhdr *eth = skb_eth_hdr(skb);
 
 			if (ntohs(eth->h_proto) == ETH_P_IPV6) {
 				df = htons(IP_DF);
-- 
2.47.0.338.g60cca15819-goog


