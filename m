Return-Path: <netdev+bounces-283209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cII8NZ/A9GkDEQIAu9opvQ
	(envelope-from <netdev+bounces-283209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 17:02:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 452214AD7B5
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 17:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AA6E300F786
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 15:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23DA3BFE3E;
	Fri,  1 May 2026 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rN3Mxr39"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2F2296BCC
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777647771; cv=none; b=Wq0h+gaasu2XLWOk8LjyBTmgJcmYS/ov6RAbyOr710cKUkcX2/Y4WW9EH8N39lB5AAwiXzrtqdR74JaMFpvJWgvHEJfcCdPMmtEeIvtVHLtlbB6KWUW9mTGkhXacUF2hgfO/l6XwF2vLdaw6heeGkO7S5YYr882fYODQv2HUCiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777647771; c=relaxed/simple;
	bh=6vcOwLjsbYlpXOk7phaOzFPMRlxGXspi8rfbIWiZGAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jCzS79qTCMmpcnbUTgGXlEdH9JA0BiCLRXDoFlXUVdYcSbNZq5aUmx4NRa2xetNo0JNjsK1RGxAzus0QSdOTOLA2pUFCGGepX9ldzgrNNtTlHFZFFsVCMwQAdybJG7y1x/6OSPNk0rwOOkjot50TpxAwhDk/lmUVF+AlOkb+mgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rN3Mxr39; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so914346b3a.1
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 08:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777647770; x=1778252570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qnbjNtSxRO7hvGLNFET/6xzFio4C1JIDsCaQHn6SRNA=;
        b=rN3Mxr39SQCev99VPaBJr0YxCMUl2P0DNcmirYwusmUufv3Pc8ylnuB1zq6hsnLMJ+
         3loXQ9Rul0dyY/ihsM4+/3JLrKFNEy7ef92Di6OqPUrb21zxrQGto0IKV3k2n2KMr9h4
         nOuwYZCoolk52m5/Bc6E4jR+7iG4gYj0lHWH1yIpxdl5GLiUmyiyxCDQHuuw4zVEqXaI
         5Sot6Y/NuVN4rmJPYktLFeb9MDS4XquZOO4byr9hHf/ilw+mstEoAN7FLhjwmK/QklNb
         c9WxVJD+7hfBo2+erI1VWSfRdn+qUHddL3TAOHnwGROZI+BqQHTXAIZp8Yain/bnt+yE
         k8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777647770; x=1778252570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnbjNtSxRO7hvGLNFET/6xzFio4C1JIDsCaQHn6SRNA=;
        b=jQyTluVlJGp+SdeEc/IhLItOsEWmUurOfUk8uP9AwR6NXz3PftzQQwPGGVek5+7mxA
         ev7lWG61MeOMKmrJRR1c1pyaD2tTG26r6A0e836il36XdFsGiLyYMm0JhPV3BZSXp+m9
         7hkzLg+PhnqbNF/HhYfcXpH/iVlec6eHUX0LvY9bzY/drMNg9RHHY29j53+lOtnZ1TEJ
         y6g+GRxKreCGvrIfueynbZdZ4EEQrg2cf24aYnmuBd5/JO1ypShE4/aPc0RzFepHmM0i
         kDYgTMUMDhqe7TpyMF3p3gc9Wa9lnQ6IzaaxReRXGFdHtb60xhK3Dc8/d0/SYJ/qtkvr
         jZTA==
X-Forwarded-Encrypted: i=1; AFNElJ+3UNTVFwYi4W4HKJWOT2JhSakWk0nB01wdjF7i6GJazaG/lDg7MA9gwMAwN/qkmn9YRNQStfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0dvoPvDxBO0Vvh1xq0nX534HnXojDf4gGiUI6xKdK0ovd9Cmj
	bWjBHdoaRZtn4T7M7+aKA2RvSuTmHicv6aZiKF0JesXtU49OPFM1W5OP
X-Gm-Gg: AeBDievYNM0YdF+WtA7HFqyIqNnRk8TYtEpLcyH7u0/+zd76OcCdpX2kqN8sGxMRjCz
	Wh1K9+u8Pm95OaDd6gBcnWyAvULjeVoTrw63/0K0o/uyvIJKWhg0v4umL9xODXhDDXyFTuyKwmM
	+KZFUccH5Uw0UXSxH/+XE2ZezE/ArqOPtYwOl5oSTkK8ZLMwBIZt3ZZLx+rnSld+2BOVMorf58g
	vP6DtOnxgwxivy8Nwv0CrzUVRLmLPRN4KZE11JgfZDglil7FjOYURwRcjWRMGfo4WTkeKLaJkdM
	O9W/XxjIupj0dyaHJm82RScxff/PWRuTuUQfkB6BJ2KBWNe46OrGbs1IQ3Kr/2BcSzm5kifKm5F
	+F+6pHhqQvss/B7tMT+kutT/YJrZmX0TiBUQyFlUQ9YX4Cpf5Nvk3jdqGsAAc+oqnKhuWCfGdxL
	KQ2/kQuxaYIZh4iEl0+atjWgZdhkCAx2phwabZsClZ5EXK/wZufHOWwxofxsUA6TQKrucge7udq
	9SWtp7hXWw4PIH+c868u8AWf5BfrY+uZRBdl9Q1wjneLpDMrcUhM/1HkHUnbIctC3EFjDf0qVTU
	HHwVeDq2usmUt9n3qkheiRC7TUKkCaIQDNlLjFLXxQA4tid5yl0jp36VsEO1
X-Received: by 2002:a05:6a00:3021:b0:82f:5a77:10e8 with SMTP id d2e1a72fcca58-834fe0bd639mr7969765b3a.20.1777647769486;
        Fri, 01 May 2026 08:02:49 -0700 (PDT)
Received: from tobiichi3227-framework13-cachyos.misaka.net (36-236-241-206.dynamic-ip.hinet.net. [36.236.241.206])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b864c7sm3356061b3a.59.2026.05.01.08.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 08:02:49 -0700 (PDT)
From: Dao Zhong Ma <cz1346219@gmail.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	antonio@openvpn.net
Cc: sd@queasysnail.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Dao Zhong Ma <cz1346219@gmail.com>
Subject: [PATCH 0/1] ovpn: tcp - defer TX from softirq to workqueue
Date: Fri,  1 May 2026 22:54:24 +0800
Message-ID: <20260501145425.757147-1-cz1346219@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 452214AD7B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[queasysnail.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283209-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cz1346219@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.980];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi,

I observed system hangs when using OpenVPN across suspend/resume
under heavy network load.

The issue can be reproduced with:
1. Establish an OpenVPN connection
2. Generate traffic with iperf3
3. Add CPU/memory pressure with stress-ng
4. Suspend and resume the system

After resume, the system may become unresponsive. SysRq output shows
tasks spinning on sk->sk_lock.slock, and RCU stall warnings are
observed.

Kernel logs and stack traces:
kernel: watchdog: BUG: soft lockup - CPU#4 stuck for 22s! [stress-ng-cpu:11506]
kernel: CPU#4 Utilization every 4000ms during lockup:
kernel:         #1:   0% system,        100% softirq,          1% hardirq,          0% idle
kernel:         #2:   0% system,        100% softirq,          0% hardirq,          0% idle
kernel:         #3:   0% system,        100% softirq,          1% hardirq,          0% idle
kernel:         #4:   0% system,        100% softirq,          0% hardirq,          0% idle
kernel:         #5:   0% system,        100% softirq,          0% hardirq,          0% idle
kernel: CPU: 4 UID: 1000 PID: 11506 Comm: stress-ng-cpu Tainted: G     U              7.0.2-2-cachyos #1 PREEMPT  136cb9373f01c1def72b1b5def9dd1fcc7884035
kernel: Tainted: [U]=USER
kernel: Hardware name: Framework Laptop 13 (AMD Ryzen 7040Series)/FRANMDCP05, BIOS 03.18 01/08/2026
kernel: RIP: 0010:native_queued_spin_lock_slowpath+0x5a/0x260
kernel: Code: 08 0f 92 c0 b9 ff 00 ff ff 23 0f 89 c2 c1 e2 08 09 ca 81 fa 00 01 00 00 73 5a 85 c9 74 0e 66 90 80 3f 00 74 07 f3 90 80 3f 00 <75> f9 66 c7 07 01 00 65 48 ff 05 3f c6 d8 01 5b 41 5e 41 5f 5d e9
kernel: RSP: 0000:ffffcf548d9bb758 EFLAGS: 00000202
kernel: RAX: 0000000000000000 RBX: ffff8ec75f9f4d48 RCX: 0000000000000001
kernel: RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff8ec75f9f4d48
kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: ffff8ec8547abd80
kernel: R10: 0000000000000020 R11: 0000000000000020 R12: ffff8ec75f9f4c00
kernel: R13: ffff8ec862d9d400 R14: ffff8ec753ade400 R15: ffff8ec771548800
kernel: FS:  00007f9b4fcd0b00(0000) GS:ffff8eccfe99c000(0000) knlGS:0000000000000000
kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 00007ffb7e1f8e38 CR3: 0000000166ced000 CR4: 0000000000f50ef0
kernel: PKRU: 55555554
kernel: Call Trace:
kernel:  <TASK>
kernel:  _raw_spin_lock+0x2a/0x40
kernel:  ovpn_tcp_send_skb+0x4c/0x130 [ovpn 03847a96bef64ed5cc535ef1935e53bb388bcced]
kernel:  ovpn_encrypt_post+0x95/0x1f0 [ovpn 03847a96bef64ed5cc535ef1935e53bb388bcced]
kernel:  ovpn_send+0x15f/0x230 [ovpn 03847a96bef64ed5cc535ef1935e53bb388bcced]
kernel:  ovpn_net_xmit+0x30f/0x560 [ovpn 03847a96bef64ed5cc535ef1935e53bb388bcced]
kernel:  dev_hard_start_xmit+0x93/0x140
kernel:  __dev_queue_xmit+0x99b/0xa80
kernel:  ? __dev_queue_xmit+0x6f/0xa80
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? nf_hook_slow+0x4b/0xd0
kernel:  ? __pfx_ip_finish_output+0x10/0x10
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? nf_hook+0x9c/0xb0
kernel:  ip_finish_output2+0x189/0x320
kernel:  dst_output+0x99/0xd0
kernel:  __ip_queue_xmit+0x209/0x350
kernel:  __tcp_transmit_skb+0x4cb/0xba0
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? __alloc_skb+0x2b6/0x340
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? skb_split+0x5f/0x3c0
kernel:  tcp_write_xmit+0xad3/0x1a50
kernel:  ? __pfx_tcp_write_timer+0x10/0x10
kernel:  tcp_send_loss_probe+0x94/0x2b0
kernel:  ? __pfx_tcp_write_timer+0x10/0x10
kernel:  tcp_write_timer+0x67/0xb0
kernel:  __run_timer_base+0x33d/0x500
kernel:  tmigr_handle_remote+0x3da/0x3e0
kernel:  run_timer_softirq.cold+0x47/0x394
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? __pfx_tick_nohz_handler+0x10/0x10
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? ktime_get+0x48/0xa0
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? clockevents_program_event+0xaa/0xf0
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  irq_exit_rcu+0x1ad/0x290
kernel:  sysvec_apic_timer_interrupt+0x33/0x80
kernel:  asm_sysvec_apic_timer_interrupt+0x1a/0x20
kernel: RIP: 0033:0x559fc1ece66f
kernel: Code: 44 89 c8 c0 e8 03 44 31 c0 83 e0 01 66 41 d1 e8 f7 d8 66 25 08 84 44 31 c0 45 89 c8 41 c0 e8 04 41 31 c0 41 83 e0 01 41 f7 d8 <66> 41 81 e0 08 84 66 d1 e8 41 31 c0 44 89 c8 c0 e8 05 44 31 c0 83
kernel: RSP: 002b:00007ffe1344e860 EFLAGS: 00000297
kernel: RAX: 00000000ffff5912 RBX: 000000000000000a RCX: 00007ffe1344ebcb
kernel: RDX: 00007ffe1344ea27 RSI: 00007ffe1344ec60 RDI: 0000559fc318d450
kernel: RBP: 00007ffe1344edf0 R08: 00000000ffffffff R09: 00000000000000b4
kernel: R10: 0000559fc333b3e0 R11: 0000000000000000 R12: 00007f9b4fcc6258
kernel: R13: 0000000000000000 R14: 0000559fc316ed00 R15: 0000559fc3337e00
kernel:  </TASK>


Dao Zhong Ma (1):
  ovpn: tcp - defer TX from softirq to workqueue to avoid RCU stalls

 drivers/net/ovpn/tcp.c | 80 +++++++++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 21 deletions(-)

--
2.54.0


