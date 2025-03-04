Return-Path: <netdev+bounces-171720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12755A4E58B
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 17:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699E542222D
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 16:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4040227C167;
	Tue,  4 Mar 2025 15:50:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F67A27C143;
	Tue,  4 Mar 2025 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103456; cv=none; b=s/T+fkA3DpJPJ2W4V8fozRC4GZtIV2dmoBMS/iz54Dnduqn3eEQl9U8giMY4GJirGc4F7yVZUugiX4gyqXXJBg7pgINM2GuqS+2JTS9Rc/hvUG9w3qmDo830P+HDVTmfUHNIbtQTSI3eLA6iD74mvZfYs3mMyCDXHYVYbUZXtO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103456; c=relaxed/simple;
	bh=bYOVATTnkzMs2SJZRQnL+Y0XdNXrcJz/jzeyCLRjXFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=akidn/K7DlSoLO6wtBFRrr6qaN058Fv1yzGTIh0vrBYbbMzuY8nCZlkuxY5Y7wkwwhqhYP0RWk+sAebWpmOm5reTmeZSwqmVQrEGyfUZaC7lKewadHzaQ5t6zwKoW6rbyvPGz3iXUqA2w8IW5xht65GOTxzq9IN2cQdjEe16+8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e0813bd105so9231442a12.1;
        Tue, 04 Mar 2025 07:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741103452; x=1741708252;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eKbdV/md8q0Krd9aGhKKSA1IstBvgcfVMUcY4XF6Qfc=;
        b=T3oNWZZm5yKQuW5qgeZsOnz25DxBIsY63w0frojMm+dEbIP0jxFIS1Tv0bTtvFR3jV
         sMFMw+m7bN21sk2AD7n1gSBn3vPGCqZT20YdVVtHdnocCYftZmKp1hXJaZxohH+pPwPw
         aDI77aOQg0YwSGncu6BcRVREotUHoa4lp0duNRJf9nacJZxfDdphkCymz3VKXI6/GI/V
         C8aGZFHHQBojZr2EAcN/q1DZ47/imN2UhElQ7KueX6M0aD6a1p8E4YY92MoNvpU9cGMQ
         C+O2rs0aJn0n/AtMNHVrLSh90IjU3bhS2du3gt7o2+7b6uQTaeE1B2POiytU7A/YzcY9
         aWJg==
X-Forwarded-Encrypted: i=1; AJvYcCXaClb6vljFTrPGj+SWyJuG5doFaGWB87juX1bmHGMUt31oeai1CktVgOEhIZ9d9RHIqafJkUiH4+nLgxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGkU2CBmLXLNfg3F8vxbZps1o0JDIkf/J5higjV+vjbOnNmahT
	nvzPNdJXPYsNZf+4Fd1ZtbAmqSYiV1VA0aWzmiVNdWxghAFjPFjp
X-Gm-Gg: ASbGnctpZyIEWU1C0PEnziabQtX+VBA6rQaMZSGO1/bQVoPVqHBgcQhPDwpm85W4Tvo
	tzlpcWKtGw4KPJeyMt0r8U1lMextgXBqohwDD7XNpJ1Wee7ntlc3AsP7lmAedtmdc6rRC1NZ5f5
	zHian7ZqT3mVlEotpnWLLmkJmlX30h6EWvn7n9O5mGY12/1lETEf7LpViudLImCBko6DpPZkOpr
	uBJZJIokF8EVYhb7jlGhnzErjbggfngVM4GyQKG9MClyAyPNgRXXcquoE8xmUYpH4r5f5VmknQn
	SKACSGY/Fy2MbCBCtw2Nq0DtXKGj4ij/0RQ=
X-Google-Smtp-Source: AGHT+IHCsjnL6zC6UvOOmCvLqIcDRLzkuKggRshxs0DxHGmRsvw6+uTUN/HaS8gcF7oKIZmSyxdNfw==
X-Received: by 2002:a05:6402:348a:b0:5dc:929a:a726 with SMTP id 4fb4d7f45d1cf-5e4d6b70f43mr18031042a12.26.1741103452030;
        Tue, 04 Mar 2025 07:50:52 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b6cfdcsm8423507a12.29.2025.03.04.07.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:50:51 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 04 Mar 2025 07:50:41 -0800
Subject: [PATCH net-next] netpoll: Optimize skb refilling on critical path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-netpoll_refill_v2-v1-1-06e2916a4642@debian.org>
X-B4-Tracking: v=1; b=H4sIAFAhx2cC/x3MUQqFIBAF0K0M9zvBZwbhVuIRUVMNyBQqEUR7j
 /o+cC5kTsIZgS4kPiTLpgj0qwjjOujCRiYEgrOusbX1RrnsW4x94lli7A9nhoZ9O3rr5qlGRdh
 fOr+zg3IxymfB/74fL8nrgG0AAAA=
X-Change-ID: 20250304-netpoll_refill_v2-a5e48c402fd3
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=3501; i=leitao@debian.org;
 h=from:subject:message-id; bh=bYOVATTnkzMs2SJZRQnL+Y0XdNXrcJz/jzeyCLRjXFI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnxyFa1vUq1gFBsABCcwZyoYWxaR9OvYG+HVF1A
 ZkP01KAa9yJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ8chWgAKCRA1o5Of/Hh3
 bbrxD/9Xc7FymN7hXv0HLr1jHn84tznwwHitYeUn0a6DupQhtWF/lrMOYUcUONa5Au2P8iCwgZa
 eaHRZ8T0rbgoAwb/foLpXuEzhFXGYhh/RpA8pJbgggI6h4lPB11owo+TjGZAUiod3WBBxdZH/c9
 bN97fh166vQ0sukoWZobyUJ3n/4zMGW8c92uOYgyBq81YYbvy8MvM72hM4aEg95j7fsn0TYgVcb
 92x7Ci4EFjXFVSS6jxUoe7og6NO0Gt0ZRXBXMMqLBT1XQSpbF4KuEwLYu9UWZRN+0GE0PyOZ3xq
 gFr6Aai2miSJ5RXKI+DKD722YC68e+ztOn7PNLs3Qc4MN47b+DUgjUQRC1ixDlrLFFEue7vPgYu
 zGLyApVYGUpkR+Ns6uh0XYxDSj6plMDHoH5KuOKKx8w1TPM4jjtUIUYDKeMeCYDWYcbiAaUcFWt
 yNKrpxjdMCcjWLRX6oOJgeYEXJUbNyK1Q7YjdQ2H7EG1/TTF0JvDVmUSppx9fh9U4GJWsF67htM
 enLWMOA4ycT8Sg6k4JVcpjzpxqa9XwVSwk9ktPjG/5WmTknwfOrsshrOZUM6rcYExqiSAyztXwR
 AyNVAgh1asAb1a7v/WvwT5VVryFBAutVVaak4KqxSoK7VLCDVK4bMKQzkkW8QZ6jHl6rCVQ+wVD
 8tLkdFUH+XA/QGw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

netpoll tries to refill the skb queue on every packet send, independently
if packets are being consumed from the pool or not. This was
particularly problematic while being called from printk(), where the
operation would be done while holding the console lock.

Introduce a more intelligent approach to skb queue management. Instead
of constantly attempting to refill the queue, the system now defers
refilling to a work queue and only triggers the workqueue when a buffer
is actually dequeued. This change significantly reduces operations with
the lock held.

Add a work_struct to the netpoll structure for asynchronous refilling,
updating find_skb() to schedule refill work only when necessary (skb is
dequeued).

These changes have demonstrated a 15% reduction in time spent during
netpoll_send_msg operations, especially when no SKBs are not consumed
from consumed from pool.

When SKBs are being dequeued, the improvement is even better, around
70%, mainly because refilling the SKB pool is now happening outside of
the critical patch (with console_owner lock held).

Signed-off-by: Breno Leitao <leitao@debian.org>
---
The above results were obtained using the `function_graph` ftrace
tracer, with filtering enabled for the netpoll_send_udp() function. The
test was executed by running the netcons_basic.sh selftest hundreds of
times.
---
 include/linux/netpoll.h |  1 +
 net/core/netpoll.c      | 15 +++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index f91e50a76efd4..f6e8abe0b1f19 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -33,6 +33,7 @@ struct netpoll {
 	u16 local_port, remote_port;
 	u8 remote_mac[ETH_ALEN];
 	struct sk_buff_head skb_pool;
+	struct work_struct refill_wq;
 };
 
 struct netpoll_info {
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 62b4041aae1ae..8a0df2b274a88 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -284,12 +284,13 @@ static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
 	struct sk_buff *skb;
 
 	zap_completion_queue();
-	refill_skbs(np);
 repeat:
 
 	skb = alloc_skb(len, GFP_ATOMIC);
-	if (!skb)
+	if (!skb) {
 		skb = skb_dequeue(&np->skb_pool);
+		schedule_work(&np->refill_wq);
+	}
 
 	if (!skb) {
 		if (++count < 10) {
@@ -535,6 +536,7 @@ static void skb_pool_flush(struct netpoll *np)
 {
 	struct sk_buff_head *skb_pool;
 
+	cancel_work_sync(&np->refill_wq);
 	skb_pool = &np->skb_pool;
 	skb_queue_purge_reason(skb_pool, SKB_CONSUMED);
 }
@@ -621,6 +623,14 @@ int netpoll_parse_options(struct netpoll *np, char *opt)
 }
 EXPORT_SYMBOL(netpoll_parse_options);
 
+static void refill_skbs_work_handler(struct work_struct *work)
+{
+	struct netpoll *np =
+		container_of(work, struct netpoll, refill_wq);
+
+	refill_skbs(np);
+}
+
 int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 {
 	struct netpoll_info *npinfo;
@@ -666,6 +676,7 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 
 	/* fill up the skb queue */
 	refill_skbs(np);
+	INIT_WORK(&np->refill_wq, refill_skbs_work_handler);
 
 	/* last thing to do is link it to the net device structure */
 	rcu_assign_pointer(ndev->npinfo, npinfo);

---
base-commit: 5b62996184ca5bb86660bcd11d6c4560ce127df9
change-id: 20250304-netpoll_refill_v2-a5e48c402fd3

Best regards,
-- 
Breno Leitao <leitao@debian.org>


