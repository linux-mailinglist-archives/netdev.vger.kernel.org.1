Return-Path: <netdev+bounces-238278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06788C56F76
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5903B1529
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 10:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D94C2E0934;
	Thu, 13 Nov 2025 10:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EjiRgvLL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A520B2D879F
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030369; cv=none; b=Wfk3GQ7nKGewEnok1+dxViDrG3Haf/FGIPrBWxOqDbWeCpq/gEbEng6QCM9hJcSIIdIKBxa/G0TNzr09ZYYNl3f22xu86lt8vraFeipHDYhS8b2GjlIMTjOXem0WZyi2VrLp5mkPzeP1DVgBvGhrH2kTzk7iD7n4B6HDmPd54fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030369; c=relaxed/simple;
	bh=zE1acdRkFucM++cG5Diu4M/uKaX+2P7RHSjhQXSZvP0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IvgC28JdOKCO4gR00drNBTc9vAHZdMyz063hZUew2IRBNvPkLI+tMR9dvL2WCrX/2PS1N0YRA9t3JmQaHLjST8CcSaEtdegd1Zd0f+JU6c1Umtam9mVNTZrvpeac/O/BKj05BIDhGzxbk6p8LwiyvLM6/hoYBJm9XHEDO/xtF4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EjiRgvLL; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4ed6e701d26so16383051cf.1
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 02:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763030366; x=1763635166; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dz7iI/A+pcGyCsTtJbsaYsqVkr/ST/NlSYWCVUwaguk=;
        b=EjiRgvLL0OGXuxbRm9vBt3TPJUTK48AV5sje9mnT94/qYsfL1IkSWDiCdPqRhu2mkc
         m+5pJ3jl5ffaSLm8rZJTh70/OQAVtPcBVrNBTTc9+zNz9RkuOPN3OeEw+DgrDIyRNmdy
         xHw+Gsz3j8kIX1mlHb2D8qrMpECKwMS8CLRx7PBEev1t68pkOLt5zIJsA5yiS7/f60l8
         jt85mXUuQHF5OOdrzxIQHX+4iKiCTRWWRSYzn8IbkckrFMhl2Ly1IQE+PUlBndmH1X5C
         v6PVzQ9zVn6UHj6vVobCjzTv6R3hUPX915PGslvy9U00RF7ZeawA8dBQDl6hXqbzlD1f
         UDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030366; x=1763635166;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dz7iI/A+pcGyCsTtJbsaYsqVkr/ST/NlSYWCVUwaguk=;
        b=pHX/DdA5XLA0KL2UYS9ju5OiLxyEfMW1ayW/e2Jv5tGrcGl/Vye2g1LuOQ2K52msr9
         flVKdQoxrfIVNCC2PpApqiW7iSC6v904lRZcrz7S33eaguVuOYOA0Z4s8D1FC4+Pi81X
         WeCvKr7n4TGT6lhkXmKwc+eXTDBKBRbfXJBYGKGzVvcl+u9/FRj6TyV6CObW8TEiqere
         dVIvbR415NbK6O+8RdyAHVSvVMegggDkjPcX0ybV+OaWh6Dpxl85l5xoorVowZrBtBxO
         sqLlVD1TDkj5H+9HgiqFgvQ4sY02nKYZ17Ran0ogmFpl1P1KWVQQQ4y8at6mOvxT4pa6
         QjIw==
X-Forwarded-Encrypted: i=1; AJvYcCWhSorb+bvH70q9aC+RzFS5ftNASJdq6G2QZN8w4riBofTF0Lp+jciZ8NiFNX9DasJYIpbOVIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF9PEaZPfpevWXy+xHhqjhiuLm65RRaH7GH7s01JaMqfsdMDKk
	l0aRir5nn9Vfh2olk8UMkq+ApKvWgybwYMd0vSbfWFdwxKHxEazKwgktVxVZh01EFzGP8ASr83t
	R4TVCFYQaRVeb4w==
X-Google-Smtp-Source: AGHT+IHFUWARVyMIFu2VAVW3UDIDt89esSCemXG4yAktQrsrDjzyDHoCkqOwFsZJ9Nmep6JHW8EMQLbBHF+agQ==
X-Received: from qknwc10.prod.google.com ([2002:a05:620a:720a:b0:8b1:43a6:8c99])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:d01:b0:4ed:e13c:6b54 with SMTP id d75a77b69052e-4ede13c70d3mr54721831cf.46.1763030366623;
 Thu, 13 Nov 2025 02:39:26 -0800 (PST)
Date: Thu, 13 Nov 2025 10:39:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113103924.3737425-1-edumazet@google.com>
Subject: [PATCH net] mptcp: fix race condition in mptcp_schedule_work()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang.tang@linux.dev>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+355158e7e301548a1424@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported use-after-free in mptcp_schedule_work() [1]

Issue here is that mptcp_schedule_work() schedules a work,
then gets a refcount on sk->sk_refcnt if the work was scheduled.
This refcount will be released by mptcp_worker().

[A] if (schedule_work(...)) {
[B]     sock_hold(sk);
        return true;
    }

Problem is that mptcp_worker() can run immediately and complete before [B]

We need instead :

    sock_hold(sk);
    if (schedule_work(...))
        return true;
    sock_put(sk);

[1]
refcount_t: addition on 0; use-after-free.
 WARNING: CPU: 1 PID: 29 at lib/refcount.c:25 refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:25
Call Trace:
 <TASK>
 __refcount_add include/linux/refcount.h:-1 [inline]
  __refcount_inc include/linux/refcount.h:366 [inline]
  refcount_inc include/linux/refcount.h:383 [inline]
  sock_hold include/net/sock.h:816 [inline]
  mptcp_schedule_work+0x164/0x1a0 net/mptcp/protocol.c:943
  mptcp_tout_timer+0x21/0xa0 net/mptcp/protocol.c:2316
  call_timer_fn+0x17e/0x5f0 kernel/time/timer.c:1747
  expire_timers kernel/time/timer.c:1798 [inline]
  __run_timers kernel/time/timer.c:2372 [inline]
  __run_timer_base+0x648/0x970 kernel/time/timer.c:2384
  run_timer_base kernel/time/timer.c:2393 [inline]
  run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2403
  handle_softirqs+0x22f/0x710 kernel/softirq.c:622
  __do_softirq kernel/softirq.c:656 [inline]
  run_ktimerd+0xcf/0x190 kernel/softirq.c:1138
  smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
  kthread+0x711/0x8a0 kernel/kthread.c:463
  ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Fixes: 3b1d6210a957 ("mptcp: implement and use MPTCP-level retransmission")
Reported-by: syzbot+355158e7e301548a1424@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6915b46f.050a0220.3565dc.0028.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/mptcp/protocol.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2d6b8de35c449374fec6dc935a459af0ef55b59a..e27e0fe2460f7de579b197e1c6c0e80fac10c1cd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -935,14 +935,19 @@ static void mptcp_reset_rtx_timer(struct sock *sk)
 
 bool mptcp_schedule_work(struct sock *sk)
 {
-	if (inet_sk_state_load(sk) != TCP_CLOSE &&
-	    schedule_work(&mptcp_sk(sk)->work)) {
-		/* each subflow already holds a reference to the sk, and the
-		 * workqueue is invoked by a subflow, so sk can't go away here.
-		 */
-		sock_hold(sk);
+	if (inet_sk_state_load(sk) == TCP_CLOSE)
+		return false;
+
+	/* Get a reference on this socket, mptcp_worker() will release it.
+	 * As mptcp_worker() might complete before us, we can not avoid
+	 * a sock_hold()/sock_put() if schedule_work() returns false.
+	 */
+	sock_hold(sk);
+
+	if (schedule_work(&mptcp_sk(sk)->work))
 		return true;
-	}
+
+	sock_put(sk);
 	return false;
 }
 
-- 
2.51.2.1041.gc1ab5b90ca-goog


