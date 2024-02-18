Return-Path: <netdev+bounces-72742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA806859788
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 16:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0751B1C20B75
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 15:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE43F6D1A3;
	Sun, 18 Feb 2024 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZlMtBNXJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0265131A66
	for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708268989; cv=none; b=AJm9ghzo/LcF1+2Ae/dreOCUVIE//h8WctR0WlWHYXLPwQyf6Zsa3r0E1779NrMcDSfX4O1Hp1R9OJacTze2DQ3WVB4+0VWinmo1heZwo1Pm67LCbKYa4TioA7AlE+cp0hrncmlPAmtnhUt+mrgWXJqb3tNfkU1xo1GfEb9/j9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708268989; c=relaxed/simple;
	bh=P/XamzW0k9s56aZD49kwH+EPycwY+7egqwFjukjRjaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AITJhG5oB/PgyAuybu3EQ3+5/sSXgH53er2nPQcF/lZ4OdM0LLIwm59R385/YcFisKxxBiqWGVURSt3WfIeOA43MVuzg6rtc3D2wl22ZU+EYNI1DVGOtsl/R6r5ecGbkL2i4KSd3XgobHRfwdUAaB9b6zRSwyd2eDwVmkDl5TRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZlMtBNXJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708268985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bwoL5JJuhSW+kyiPUR3qQ3qzkCkjo9wXmM88MH4kw4I=;
	b=ZlMtBNXJQzRIpGj+lC/8+vZ5EJrLklaaZWNlydXJjpGw3wHbt0Ksukem/37E4QNVW4Admi
	ZggwWXUJc9XvxnMLppk//MIc4Jp8SAlnZ4fJRCu6y86PTqz9+NFGcRxloXw0qUD7smzH0V
	YszaKnKvFTvV9cIsMNk4SyvUHCLgS1E=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-grlXirtjO8OhlWc1K_CDWg-1; Sun, 18 Feb 2024 10:09:44 -0500
X-MC-Unique: grlXirtjO8OhlWc1K_CDWg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c5c8ef7d0dso3435870a12.2
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 07:09:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708268983; x=1708873783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bwoL5JJuhSW+kyiPUR3qQ3qzkCkjo9wXmM88MH4kw4I=;
        b=NsQstx5izzNqv+DoTzAnSakfjRgD1yZFW5CAh8gBiw1fg9livA/GOTzNL1rtHrfIoR
         Wero7xblcnoc9R0oxG32Cm/7n9ZFXwiZfx5LybO1mLkHwJbHyMQspk/Skbt0KM0nlZHl
         qsVY3hviBl+H6w6i7Y0wHkk16wzayzEmoVfAQzmyoKb1FLozNBslP3k3FQUccHjTgKiQ
         SZ72TLLUSVak7w5uh9u8yzx0JkeljJRdwXrwlpEnXyGTCapzE6P2CxEW2HKneJk03+Se
         7Xc8gdebzjuHOoFHsq86g3jsg6Oti3D0DWYw7Jdd6YQ9OK9Q6JoznChj8rLpmjXEl236
         LHYA==
X-Forwarded-Encrypted: i=1; AJvYcCXePohuug6KnBYtQwQGCei9BVhHYI3XBBzVKAfZCNr9xn9zUR1YYNXRvbs5QwymCCtPtf/BVyu3GZGeEIQZ0ygwoMgN6ICb
X-Gm-Message-State: AOJu0Yz/cQWFP6pWFIbCZTpccxetlnLxxQp6Nmcx73bCq5fq1F/Ya5XJ
	FUcRAp9Oizyrzz1+WABlEj+FUbwf4bHz2Js/rh2X/kJTMXbfk5RSqbyd6ta/hNwHzG09vUvnEx+
	rqV41G5hX1dVZuEuyQWafzVuMvGXpZMuU1OvLLjTNnIwTUU/1SG8mfA==
X-Received: by 2002:a17:90a:4dce:b0:299:3f5d:b5e8 with SMTP id r14-20020a17090a4dce00b002993f5db5e8mr3512992pjl.20.1708268982947;
        Sun, 18 Feb 2024 07:09:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWB+1HQKH3/cx4XDOVkxwc253bedsLJk+TmwcSSZJ1ojNUMxpmP+dQC/vu/lwyZiKwv8B7sQ==
X-Received: by 2002:a17:90a:4dce:b0:299:3f5d:b5e8 with SMTP id r14-20020a17090a4dce00b002993f5db5e8mr3512975pjl.20.1708268982585;
        Sun, 18 Feb 2024 07:09:42 -0800 (PST)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:6883:65ff:fe1c:cf69])
        by smtp.gmail.com with ESMTPSA id nb11-20020a17090b35cb00b0029658c7bd53sm3479311pjb.5.2024.02.18.07.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 07:09:42 -0800 (PST)
From: Shigeru Yoshida <syoshida@redhat.com>
To: john.fastabend@gmail.com,
	jakub@cloudflare.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>,
	syzbot+fd7b34375c1c8ce29c93@syzkaller.appspotmail.com
Subject: [PATCH bpf] bpf, sockmap: Fix NULL pointer dereference in sk_psock_verdict_data_ready()
Date: Mon, 19 Feb 2024 00:09:33 +0900
Message-ID: <20240218150933.6004-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported the following NULL pointer dereference issue [1]:

BUG: kernel NULL pointer dereference, address: 0000000000000000
...
RIP: 0010:0x0
...
Call Trace:
 <TASK>
 sk_psock_verdict_data_ready+0x232/0x340 net/core/skmsg.c:1230
 unix_stream_sendmsg+0x9b4/0x1230 net/unix/af_unix.c:2293
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

If sk_psock_verdict_data_ready() and sk_psock_stop_verdict() are called
concurrently, psock->saved_data_ready can be NULL, causing the above issue.

This patch fixes this issue by calling the appropriate data ready function
using the sk_psock_data_ready() helper and protecting it from concurrency
with sk->sk_callback_lock.

Fixes: 6df7f764cd3c ("bpf, sockmap: Wake up polling after data copy")
Reported-and-tested-by: syzbot+fd7b34375c1c8ce29c93@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fd7b34375c1c8ce29c93 [1]
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/core/skmsg.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 93ecfceac1bc..4d75ef9d24bf 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1226,8 +1226,11 @@ static void sk_psock_verdict_data_ready(struct sock *sk)
 
 		rcu_read_lock();
 		psock = sk_psock(sk);
-		if (psock)
-			psock->saved_data_ready(sk);
+		if (psock) {
+			read_lock_bh(&sk->sk_callback_lock);
+			sk_psock_data_ready(sk, psock);
+			read_unlock_bh(&sk->sk_callback_lock);
+		}
 		rcu_read_unlock();
 	}
 }
-- 
2.43.0


