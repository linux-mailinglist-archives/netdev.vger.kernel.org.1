Return-Path: <netdev+bounces-216959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD7AB36913
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6EB1895018
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB1A35207C;
	Tue, 26 Aug 2025 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u/Wv0hUf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60C92AE7F
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217600; cv=none; b=Sptso0XHzqkXsI/RHSSYaA49rv9g/LNwAYOQOLmQg4mAJcXK4CI++pcZ2L7D0VoZz9Th16X/N64rz6Sw4c08zbfPFVtc32vsx2VAAIlsJmCbctmJm+kquY8nXI6ZjYZ0qqYF/sX04vZJ30mtpnvu8v6mnlQV0bYjzbsziyYOZ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217600; c=relaxed/simple;
	bh=bhFNEuDvT4RavySmzr07krIw8rwd4UJF/HZh8Dt2qbU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ejkLepg4L2f67n1rAH8yN6Tx3s0g3rwkQhqq4tTs5qG33fozrw9jQbyWAR6WRdzCvxJKb9EXCCG6eHxTJxyBy0TycdqoyEVWMELH9WsCr3PSb+yo857tM2jPZ18I+D8yn3/1ZkEV/z9QmjCRNaNtf0RKJ1gN6tE9aCl/Vpep1P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u/Wv0hUf; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7e87069063aso2108291685a.3
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 07:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756217596; x=1756822396; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8prmLzW3HAksApsszOSmPwYRoXft1cT8k30UB45etkA=;
        b=u/Wv0hUfPSjw+5l0QzESrCd53cMcU9QvJicYknK19nlXorV8ORJdFrh+c7v9V0Bdeu
         39litPw6RPsRTEz0hr/0ZKyQI87BBDuqVaVWx8s9mNSlMCrbXyhM2onAvF9czxuQV7Tv
         +2Yks0X6g6XNuA/Ad3QSbGzR/fM5NfW3B2Gg/EEyvnyORb46kidc9l95yebWcQYKmZ43
         37ZibE0ocHmHODY6fzZLmVyZbJHIfki/WXlvWhBsPdEu2ciZ9w1TQ+bcGixoErb/Asnf
         4FbyEMex/uoBUgxwtFErWtHX0BYoH+WoG2Ezgcx1MOqlgLpX2ErXQ98VMfya6p9gmzbf
         N3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756217596; x=1756822396;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8prmLzW3HAksApsszOSmPwYRoXft1cT8k30UB45etkA=;
        b=ljL0TrLiggxqOeyOdArSm+mErGcBeZlTn7QfmADyZe2r/OK6QUfT38tsPwHhkxS81d
         AlTzPcgwPS43zIPZqeQUkVZQh0iazV/5n1b0/lfdnp/VBkjW4qooXbn9HHQrmIUcL0jQ
         w3Tz2ltYR49P9Rm/POf4OvDgNuFXj4YsHwdlwX+mWpG/M9fM4PV4gL1SiRTcxU1r58QT
         e7shEfwi3kAbmg7HGPPNdR9t8uZOPLLYDb1Ettt/UWBWud8of14we9Lw+N9zuTX3XAEQ
         xHhQnfzc0EnMSKQCkNUX/7b+b//QfsSfQGWMhjtU9HuxSY/m/cJqDObuMZ41ITdfI480
         sWdw==
X-Forwarded-Encrypted: i=1; AJvYcCWVMKKRzZYbzKIpnYOCM/4o3IocYV/Sg9/y6V85DYL4jiYwBr6uvUJA2xT7eenFysp1O1L2Zm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfiHXivrZDzKZA0bSwJqHMWdSVJce/rBnXK4LwHvSygRTfb4Lf
	Z8U4qX9XyxBanSRetfQGU1oMOGztnZ3w+M9+5ZXSnpRmZHFKHxQ8ZyZyGbpsFBRVO6tYSJDvpuF
	i1CoGr9vnBQ9j0Q==
X-Google-Smtp-Source: AGHT+IFv7EDSgeVeEesSoMPofl1NsaSUXKu9amA7M4o2fEUSKIEYQb0FgnJYQEmaxIeFPoqfVzmf0uMruB7DDw==
X-Received: from qkbef12.prod.google.com ([2002:a05:620a:808c:b0:7e6:715d:8695])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:3908:b0:7e3:2ec5:69e2 with SMTP id af79cd13be357-7ea10f742c4mr2037271685a.28.1756217596406;
 Tue, 26 Aug 2025 07:13:16 -0700 (PDT)
Date: Tue, 26 Aug 2025 14:13:14 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826141314.1802610-1-edumazet@google.com>
Subject: [PATCH net] sctp: initialize more fields in sctp_v6_from_sk()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+e69f06a0f30116c68056@syzkaller.appspotmail.com, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

syzbot found that sin6_scope_id was not properly initialized,
leading to undefined behavior.

Clear sin6_scope_id and sin6_flowinfo.

BUG: KMSAN: uninit-value in __sctp_v6_cmp_addr+0x887/0x8c0 net/sctp/ipv6.c:649
  __sctp_v6_cmp_addr+0x887/0x8c0 net/sctp/ipv6.c:649
  sctp_inet6_cmp_addr+0x4f2/0x510 net/sctp/ipv6.c:983
  sctp_bind_addr_conflict+0x22a/0x3b0 net/sctp/bind_addr.c:390
  sctp_get_port_local+0x21eb/0x2440 net/sctp/socket.c:8452
  sctp_get_port net/sctp/socket.c:8523 [inline]
  sctp_listen_start net/sctp/socket.c:8567 [inline]
  sctp_inet_listen+0x710/0xfd0 net/sctp/socket.c:8636
  __sys_listen_socket net/socket.c:1912 [inline]
  __sys_listen net/socket.c:1927 [inline]
  __do_sys_listen net/socket.c:1932 [inline]
  __se_sys_listen net/socket.c:1930 [inline]
  __x64_sys_listen+0x343/0x4c0 net/socket.c:1930
  x64_sys_call+0x271d/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:51
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable addr.i.i created at:
  sctp_get_port net/sctp/socket.c:8515 [inline]
  sctp_listen_start net/sctp/socket.c:8567 [inline]
  sctp_inet_listen+0x650/0xfd0 net/sctp/socket.c:8636
  __sys_listen_socket net/socket.c:1912 [inline]
  __sys_listen net/socket.c:1927 [inline]
  __do_sys_listen net/socket.c:1932 [inline]
  __se_sys_listen net/socket.c:1930 [inline]
  __x64_sys_listen+0x343/0x4c0 net/socket.c:1930

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+e69f06a0f30116c68056@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/68adc0a2.050a0220.37038e.00c4.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/ipv6.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 3336dcfb451509927a4ae3c2bf76c574c743936b..568ff8797c393bea28f8423babd4c85d6407f9ff 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -547,7 +547,9 @@ static void sctp_v6_from_sk(union sctp_addr *addr, struct sock *sk)
 {
 	addr->v6.sin6_family = AF_INET6;
 	addr->v6.sin6_port = 0;
+	addr->v6.sin6_flowinfo = 0;
 	addr->v6.sin6_addr = sk->sk_v6_rcv_saddr;
+	addr->v6.sin6_scope_id = 0;
 }
 
 /* Initialize sk->sk_rcv_saddr from sctp_addr. */
-- 
2.51.0.261.g7ce5a0a67e-goog


