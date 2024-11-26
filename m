Return-Path: <netdev+bounces-147454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A177B9D99D2
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 15:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC1B1649D3
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 14:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F811D5ABD;
	Tue, 26 Nov 2024 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gLCi+t7Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868DABE46
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732632228; cv=none; b=gT0W1aJOQpGEOMkn1l7Aljg2i01sYZbEXPcQfCVGJMkZaTLLUlyLoMNSr7MijFkgepVVVirUuNFsHax/fHZnVaeqjQl3SlWR8dX+qFXru4ED2W/RRhBlkkQWlZEh9mAtMEfwlnuYBhtMa2J3tw3pxttp7BC67BsgUGOzPY1x9Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732632228; c=relaxed/simple;
	bh=/SsEuIhRKHmQyt2qYP/Lg6GbEhY5IkpxyFDVBKyy0AA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fcF2Y1oVJ30jQ6guGhsB+KFBhN2Kdkdgx+Zc8IzWjS0cE+zFOPfR0d80mT4Kr7bdvQhknRYdZOsadr1vU+VGfk1nPf40yIaCOOhxIq9NsQHpmCOjqamfyt29Gwlu62Dr6FxvWHgWu6RwcRd4pmFoemX9Lps9Qu+bvS6aT9PtZQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gLCi+t7Z; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7b6676f4361so248631785a.3
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 06:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732632225; x=1733237025; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KGOhy4cb60SUQLKuoY2MIaRF1gEHIBZxNyf1A8SJdcc=;
        b=gLCi+t7Z7X69+yV2EWh8TILHvH4Ph4N9/EMjBA/Kz/++LsZn10IRl1eywH+93I345P
         qilZtFU3EJmXPFChxo4/5k5pAlDqM217oOg4OUK4m9u/i3zrBN1g7xL9Kgpts4E2j9gr
         uOEPNiQpDc9rz5nojB0OEOeogZ4YH2A3Iuu+Ai9z7k4jXDbFVE/cUs4YlQ4y4+equrrK
         kamX0gyvytAfH8tfhCm+z3fpfwavnxH8xzpUiaZd47MRxnboMsR0XmjRiAMeYLnde//a
         +mTlrdnWDqq2DN/Xd7lGV/0xkw69yq38t8uZg0LhkagxWXQ9+2gIDaPVhb62rbIStIfN
         oGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732632225; x=1733237025;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KGOhy4cb60SUQLKuoY2MIaRF1gEHIBZxNyf1A8SJdcc=;
        b=MxlLdtLxt/a3ZpZ6abK9E5agBbfMHLr6YcUGM8mxQfhP3WLarxFwk+Vjh4pKxGjQVP
         MTYrB+2F1jTslmS5R3PlrNGZ0LS2LV1c+b7TMf/mg2WG8HK35gOfb5pVJX2XrCH28NCz
         K0F5JUtRKiN7iUmQgbATCpmZ6FW39ZD7owc25rXxxJhEwlxzF30i5IwJBg9pMuZNfPqb
         VhrE0TTz6EVywKgbp4fLeC89XFLsBmJGWJPaa8AlOfnmBuFWhYPLnYBXFAx1oHwKpe4U
         I/wDF4WA7DlKCKqRHUzdsY/DlCExZG+U/aBzk3BWn+py2YZEN+4yetQ+xexOU87jdrUC
         YSyg==
X-Gm-Message-State: AOJu0YyoB6BaG3QBbXm3cN8Nxd2c1sE/E9z9vmKOAYQYpQGedJtmKr4h
	+dbWB0rO0YOG9ss6mHhvViqjEVOIyb+XvielYrPJOcuXFaALdAZHDRoClgVHE9WbcVoOmrAab8J
	AV9sR+HLBWQ==
X-Google-Smtp-Source: AGHT+IHh8gMi9YrMk+uXAg6HkU4DqhFWivJumX0mDubrO0H/tNHuZn1B96AXS2wpzrtZRLRHxcvAyUm709PjvA==
X-Received: from qkyy29.prod.google.com ([2002:a05:620a:9dd:b0:7b6:6000:61e2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2552:b0:7ae:6ba2:faba with SMTP id af79cd13be357-7b51453eeb1mr2102592085a.28.1732632225437;
 Tue, 26 Nov 2024 06:43:45 -0800 (PST)
Date: Tue, 26 Nov 2024 14:43:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241126144344.4177332-1-edumazet@google.com>
Subject: [PATCH net] net: hsr: avoid potential out-of-bound access in fill_frame_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+671e2853f9851d039551@syzkaller.appspotmail.com, 
	WingMan Kwok <w-kwok2@ti.com>, Murali Karicheri <m-karicheri2@ti.com>, 
	MD Danish Anwar <danishanwar@ti.com>, Jiri Pirko <jiri@nvidia.com>, 
	George McCollister <george.mccollister@gmail.com>
Content-Type: text/plain; charset="UTF-8"

syzbot is able to feed a packet with 14 bytes, pretending
it is a vlan one.

Since fill_frame_info() is relying on skb->mac_len already,
extend the check to cover this case.

BUG: KMSAN: uninit-value in fill_frame_info net/hsr/hsr_forward.c:709 [inline]
 BUG: KMSAN: uninit-value in hsr_forward_skb+0x9ee/0x3b10 net/hsr/hsr_forward.c:724
  fill_frame_info net/hsr/hsr_forward.c:709 [inline]
  hsr_forward_skb+0x9ee/0x3b10 net/hsr/hsr_forward.c:724
  hsr_dev_xmit+0x2f0/0x350 net/hsr/hsr_device.c:235
  __netdev_start_xmit include/linux/netdevice.h:5002 [inline]
  netdev_start_xmit include/linux/netdevice.h:5011 [inline]
  xmit_one net/core/dev.c:3590 [inline]
  dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3606
  __dev_queue_xmit+0x366a/0x57d0 net/core/dev.c:4434
  dev_queue_xmit include/linux/netdevice.h:3168 [inline]
  packet_xmit+0x9c/0x6c0 net/packet/af_packet.c:276
  packet_snd net/packet/af_packet.c:3146 [inline]
  packet_sendmsg+0x91ae/0xa6f0 net/packet/af_packet.c:3178
  sock_sendmsg_nosec net/socket.c:711 [inline]
  __sock_sendmsg+0x30f/0x380 net/socket.c:726
  __sys_sendto+0x594/0x750 net/socket.c:2197
  __do_sys_sendto net/socket.c:2204 [inline]
  __se_sys_sendto net/socket.c:2200 [inline]
  __x64_sys_sendto+0x125/0x1d0 net/socket.c:2200
  x64_sys_call+0x346a/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:45
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
  slab_post_alloc_hook mm/slub.c:4091 [inline]
  slab_alloc_node mm/slub.c:4134 [inline]
  kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4186
  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:587
  __alloc_skb+0x363/0x7b0 net/core/skbuff.c:678
  alloc_skb include/linux/skbuff.h:1323 [inline]
  alloc_skb_with_frags+0xc8/0xd00 net/core/skbuff.c:6612
  sock_alloc_send_pskb+0xa81/0xbf0 net/core/sock.c:2881
  packet_alloc_skb net/packet/af_packet.c:2995 [inline]
  packet_snd net/packet/af_packet.c:3089 [inline]
  packet_sendmsg+0x74c6/0xa6f0 net/packet/af_packet.c:3178
  sock_sendmsg_nosec net/socket.c:711 [inline]
  __sock_sendmsg+0x30f/0x380 net/socket.c:726
  __sys_sendto+0x594/0x750 net/socket.c:2197
  __do_sys_sendto net/socket.c:2204 [inline]
  __se_sys_sendto net/socket.c:2200 [inline]
  __x64_sys_sendto+0x125/0x1d0 net/socket.c:2200
  x64_sys_call+0x346a/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:45
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 48b491a5cc74 ("net: hsr: fix mac_len checks")
Reported-by: syzbot+671e2853f9851d039551@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6745dc7f.050a0220.21d33d.0018.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: WingMan Kwok <w-kwok2@ti.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: MD Danish Anwar <danishanwar@ti.com>
Cc: Jiri Pirko <jiri@nvidia.com>
Cc: George McCollister <george.mccollister@gmail.com>
---
 net/hsr/hsr_forward.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index aa6acebc7c1ef6547451329fa23dafdc5443a5ba..87bb3a91598ee96b825f7aaff53aafb32ffe4f95 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -700,6 +700,8 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 		frame->is_vlan = true;
 
 	if (frame->is_vlan) {
+		if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr, vlanhdr))
+			return -EINVAL;
 		vlan_hdr = (struct hsr_vlan_ethhdr *)ethhdr;
 		proto = vlan_hdr->vlanhdr.h_vlan_encapsulated_proto;
 	}
-- 
2.47.0.338.g60cca15819-goog


