Return-Path: <netdev+bounces-127145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9893897451A
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 23:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193A81F25DD1
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 21:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7CA1AB50A;
	Tue, 10 Sep 2024 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZzdoGB/S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD7B1F951;
	Tue, 10 Sep 2024 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726005247; cv=none; b=pZBpBb3NaFb0/rSssgMcDqOdjGXH3QcliljU2N76/OVc/LMPb017ssko3AhU+e8icp0IA22WnXk5+qHClKcm+pA/FaQ4omTBLxLWb+I3RbSwL+FoTLwIc22LW3AvIR1n7IsBd7GQUtxwR0sZpWc5d3I+M+Xta1LoMCi2XiVgaAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726005247; c=relaxed/simple;
	bh=20efcwGrCmmRUCRbM85q/ah5UCDGq6RVeXY4OoatUg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gIfrFZaupxqFv2TQGvlMn5CWv7pz2fsuqrX4UuqSAFu1mLLrl/1D0aWjfYXgdCmD/o3ZfOzHOhNOEq0ZfEnKHRhpBHP6TY/crS+uiSn9dTE/lIv21MQtt+OFTFLzTVorGT2inrTV17UlsCyqniNt26cZY0zRO3wM+T+EzZEt4pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZzdoGB/S; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1726005246; x=1757541246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/Feo/MLsAUMck2QZbgkKCdlqtAUYqNpsrAyJkLJflz8=;
  b=ZzdoGB/SucvJp/PKFJq4Rg+mUMGvO+JdiOLTSt6ZEVpVADj9ygU3/VkC
   m7lDJjJzzx3AOr2JbOZOn5NiKPQkDRSWEjoQOfbnT1UMkk2zz6vegKJV3
   gwh8aj8DWySV0xGuVxZzWatlu9PTfH3DEZPaw04+1N4EoQcJM2/DQ/SDe
   E=;
X-IronPort-AV: E=Sophos;i="6.10,218,1719878400"; 
   d="scan'208";a="329689760"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 21:54:04 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:64865]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.84:2525] with esmtp (Farcaster)
 id d3a87479-7f0b-41b8-8fc4-b89a51cc6a20; Tue, 10 Sep 2024 21:54:03 +0000 (UTC)
X-Farcaster-Flow-ID: d3a87479-7f0b-41b8-8fc4-b89a51cc6a20
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 21:54:01 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 10 Sep 2024 21:53:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <rao.shoaib@oracle.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in unix_stream_read_actor (2)
Date: Tue, 10 Sep 2024 14:53:51 -0700
Message-ID: <20240910215351.4898-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <58a5f9c2-b179-49d9-b420-67caeff69f8b@oracle.com>
References: <58a5f9c2-b179-49d9-b420-67caeff69f8b@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB003.ant.amazon.com (10.13.139.135) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Shoaib Rao <rao.shoaib@oracle.com>
Date: Tue, 10 Sep 2024 13:57:04 -0700
> The commit Message:
> 
> syzbot reported use-after-free in unix_stream_recv_urg(). [0]
> 
> The scenario is
> 
>    1. send(MSG_OOB)
>    2. recv(MSG_OOB)
>       -> The consumed OOB remains in recv queue
>    3. send(MSG_OOB)
>    4. recv()
>       -> manage_oob() returns the next skb of the consumed OOB
>       -> This is also OOB, but unix_sk(sk)->oob_skb is not cleared
>    5. recv(MSG_OOB)
>       -> unix_sk(sk)->oob_skb is used but already freed

How did you miss this ?

Again, please read my patch and mails **carefully**.

unix_sk(sk)->oob_sk wasn't cleared properly and illegal access happens
in unix_stream_recv_urg(), where ->oob_skb is dereferenced.

Here's _technical_ thing that you want.

---8<---
# ./oob
executing program
[   25.773750] queued OOB: ff1100000947ba40
[   25.774110] reading OOB: ff1100000947ba40
[   25.774401] queued OOB: ff1100000947bb80
[   25.774669] free skb: ff1100000947bb80
[   25.774919] reading OOB: ff1100000947bb80
[   25.775172] ==================================================================
[   25.775654] BUG: KASAN: slab-use-after-free in unix_stream_read_actor+0x86/0xb0
---8<---

---8<---
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index a1894019ebd5..ccd9c47160a5 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2230,6 +2230,7 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
 	__skb_queue_tail(&other->sk_receive_queue, skb);
 	spin_unlock(&other->sk_receive_queue.lock);
 
+	printk(KERN_ERR "queued OOB: %px\n", skb);
 	sk_send_sigurg(other);
 	unix_state_unlock(other);
 	other->sk_data_ready(other);
@@ -2637,6 +2638,7 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 	spin_unlock(&sk->sk_receive_queue.lock);
 	unix_state_unlock(sk);
 
+	printk(KERN_ERR "reading OOB: %px\n", oob_skb);
 	chunk = state->recv_actor(oob_skb, 0, chunk, state);
 
 	if (!(state->flags & MSG_PEEK))
@@ -2915,7 +2917,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 			skb_unlink(skb, &sk->sk_receive_queue);
 			consume_skb(skb);
-
+			printk(KERN_ERR "free skb: %px\n", skb);
 			if (scm.fp)
 				break;
 		} else {
---8<---

[...]
> None of this points to where the skb is "dereferenced" The test case 
> added will never panic the kernel.
> 
> In the organizations that I have worked with, just because a change 
> stops a panic does not mean the issue is fixed. You have to explicitly 
> show where and how. That is what i am asking, Yes there is a bug, but it 
> will not cause the panic, so if you are just high and might engiineer, 
> show where and how?
> > 
> > This will be the last mail from me in this thread.  I don't want to
> > waste time on someone who doesn't read mails.
> Yes please don't if you do not have anything technical to say, all your 
> comments are "smart comments". This email thread would end if you could 
> just say, here is line XXXX where the skb is de referenced, but you have 
> not because you have no idea.
> 
> BTTW Your comment about holding the extra refcnt without any reason just 
> shows that you DO NOT understand the code. And the confusion to refcnts 
> has been caused by your changes, I am concerned your changes have broken 
> the code.
> 
> I am willing to accept that I may be wrong but only if I am shown the 
> location of de-reference. Please do not respond if you can not point to 
> the exact location.

Please do not respond if you just ask without thinking.

