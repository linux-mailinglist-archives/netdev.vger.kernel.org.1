Return-Path: <netdev+bounces-294736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id odOFE+8dIGp0wAAAu9opvQ
	(envelope-from <netdev+bounces-294736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 14:28:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BED637807
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 14:28:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AafWywoy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294736-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294736-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE9A8306B3F9
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 12:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB483D331C;
	Wed,  3 Jun 2026 12:26:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C75E47CC65
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 12:26:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489616; cv=none; b=vF9O4wK5LP00qI+QtJUSuKwHJa15fx1Oq2UQ9qf+qHsp5C9t2YVVXKGpqGDAV/cOqHqQBuTkDs2Q45zHKGQzgrrVyW91VaztPCXpjnnaIdgoSy3KwGX+OrepLrLFZiBW1miWyBoZhy40nh2qDvcaj7RRiDHABMng/cob5KHesK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489616; c=relaxed/simple;
	bh=LATkU20ItJcDAgt51w2Kpl/BMGu+r7P8lEqoZDqTk4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gNLhHPDK5CgfOKDVVnjoLXgohq/4VHCAZeSVRtMt1wAFuNrP4PI1leVlySXzPgcFONSIrbHDg86ZDG1B6CqvyckBfBa2eJwze5BZ49JcgmyfwEdpA6yzgSsClU/KfwGFOWAYo0HVOUaCkCz3bYMXIn1qtBcmnuYbj8yx5WPkTmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AafWywoy; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf77d4a4e2so3167025ad.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 05:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780489613; x=1781094413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ir9ee/J9UxTvHkZL8rS9qQiQHxJ7L7pXrHJ3bldJ8Mw=;
        b=AafWywoygTvk0QPuXJug2nrGrNjoT4PGPj7ccndh/myFubHCbkk7IJQkEqmTsSVnPa
         zOMMq38NGNN3v4AC0l5uPJoHD6AgVgEeK13T3GKjQigv+hcxQf9MTjH/E1pUPxcUtHXY
         oc84lmIOMnesyxuIgaGlJjOlyBP1ahPOIvfVGZ227DoVis9qSW/6v4lSBlVwyZWMgKy5
         Qv9Zf5KkWX3uHiNktuMBb1y5jz3FUZH/dWJdUuvO0hp+69jmuyIOg/9Q0S0kDp6q3g9v
         mIVGailEG3Xtb/+Rjx+xScJ9j1P8pGGhySm/kY1cTK+Ds8fvYuOxS2OlrAHY6TSr/IMD
         WJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780489613; x=1781094413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ir9ee/J9UxTvHkZL8rS9qQiQHxJ7L7pXrHJ3bldJ8Mw=;
        b=SfIYMLLEfkrNrRof4gYr8IIVI6Bc+gNhwOVUDCMeCdJrFN/PNgHmPvU1E6nOqBn5Jr
         mj+S+xwV0AN5c2ZdDp3zszCO7OzPm8HwzH1BMyZMRYp7Wd7zOgu3m3dIDn1Eo7cq9Cu7
         Z9MHGk4tr+sIJJAlgIKLt8rsEsHDsV8tgo3OOQAIjORLvctIvHPuw//7bRHAV6JZUmCL
         t3t8FsxgZQ3c5Y3B2QbZSNiBvFSZCw0BrRz8MLve+KInxNV9YvauxVPLdjHk8nH77k8J
         XEoRwRcq0c66ihydRfRK9SY9+M3gop/qFcp0LXxkwGuJMMJh4NnmgmY9+l7qERX3IJJP
         7ltQ==
X-Forwarded-Encrypted: i=1; AFNElJ9t7iGKTy25tYbvHLKLddwalZddQk6L7y/hCMekAVkRBjAa523n7GEWwmHbFY/mmlNhkr1CQSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKQubYS6z0xOUZI3CLshmkvVraES0dTbL6mIYeP1cWgdu7fv41
	zLaQFEwFjFOqDyBqLDo5M3JVFN+rFyBHlj6VKDGR66Oo0939lPkLoX6T
X-Gm-Gg: Acq92OF4p6CDoaJOG8DLVMNTB4VNkN0+hQ8xRsLT1wJWrd41M1QUNwEuLHniWzhKK2U
	+leJROPMAsnSdm/83V4amkIuGQiCD6D5Ufpa+9gMEkXnVDnfrevOr8mC++lhz7wfKj/hNXlMI2v
	pbZH0HlLZvUZ5g+UxXgyvySlOiAejXg34az98VZEsBI75dovmyKiDW/2DAYPuabXWotemoq1w3s
	1B/SjhYh/FILq1mSzTC9B1SzEUI9iyeV8osTVtpEZDTTQboqeDL1A1CgPtrB0CVahehwm+lzs2g
	A3xf7VcTjElGuW8PeOyv1pME7OigAwz5k44hzuiWK785VQG2QsAnkaXykiNf+NGKLSojb4qaRgH
	5waCu285enXnabbiR3+ACE/3cfsLgWIzw2A1CWtRQxjVIX2HsBbxUhtX+wvny94sO5b9FbiU60y
	pMa5GDfogdoVmEuaKKYN1arjVKYjjgu0HywXQTC4GwI4ut1dymS9gB61ugSZ6Py9VCm94cqFQOT
	+MYQW/vMM8=
X-Received: by 2002:a17:902:c40d:b0:2c1:13cd:f801 with SMTP id d9443c01a7336-2c164d71c6amr25892925ad.29.1780489613279;
        Wed, 03 Jun 2026 05:26:53 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f88473sm26810795ad.25.2026.06.03.05.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 05:26:52 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	daniel@iogearbox.net,
	cong.wang@bytedance.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] udp: clear skb->dev before running a sockmap verdict
Date: Wed,  3 Jun 2026 12:26:37 +0000
Message-ID: <20260603122639.615994-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,bytedance.com,gmail.com,cloudflare.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294736-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:willemdebruijn.kernel@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:daniel@iogearbox.net,m:cong.wang@bytedance.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16BED637807

On the UDP receive path skb->dev is repurposed as dev_scratch (the
truesize/state cache set by udp_set_dev_scratch()), through the
union { struct net_device *dev; unsigned long dev_scratch; } in sk_buff.

When a UDP socket is in a sockmap, sk_data_ready is
sk_psock_verdict_data_ready(), which calls udp_read_skb() -> recv_actor()
(sk_psock_verdict_recv) to run the attached SK_SKB verdict program in softirq.
If that program calls a socket-lookup helper (bpf_sk_lookup_tcp/udp,
bpf_skc_lookup_tcp), bpf_skc_lookup() does:

	if (skb->dev)
		caller_net = dev_net(skb->dev);

skb->dev still holds the dev_scratch value (a non-NULL integer), so dev_net()
dereferences it as a struct net_device * and the kernel takes a general
protection fault on a non-canonical address in softirq:

  Oops: general protection fault, probably for non-canonical address 0x1010000800004a0
  CPU: 1 UID: 0 PID: 1406 Comm: syz.2.19 Not tainted 7.1.0-rc6 #1 PREEMPT(full)
  RIP: 0010:bpf_skc_lookup net/core/filter.c:7033 [inline]
  RIP: 0010:bpf_sk_lookup+0x45/0x160 net/core/filter.c:7047
  Call Trace:
   <IRQ>
   bpf_prog_4675cb904b7071f8+0x12e/0x14e
   bpf_prog_run_pin_on_cpu+0xc6/0x1f0
   sk_psock_verdict_recv+0x1ba/0x350
   udp_read_skb+0x31a/0x370
   sk_psock_verdict_data_ready+0x2e3/0x600
   __udp_enqueue_schedule_skb+0x4c8/0x650
   udpv6_queue_rcv_one_skb+0x3ec/0x740
   udp6_unicast_rcv_skb+0x11d/0x140
   ip6_protocol_deliver_rcu+0x61e/0x950
   ip6_input_finish+0xa9/0x150
   NF_HOOK+0x286/0x2f0
   ip6_input+0x117/0x220
   NF_HOOK+0x286/0x2f0
   __netif_receive_skb+0x85/0x200
   process_backlog+0x374/0x9a0
   __napi_poll+0x4f/0x1c0
   net_rx_action+0x3b0/0x770
   handle_softirqs+0x15a/0x460
   do_softirq+0x57/0x80
   </IRQ>

The rmem charge that dev_scratch accounted for is released by skb_recv_udp() on
dequeue, just above, so the scratch is dead by the time recv_actor() runs. Clear
skb->dev so bpf_skc_lookup() falls back to sock_net(skb->sk), which
skb_set_owner_sk_safe() set just above.

Fixes: 965b57b469a5 ("net: Introduce a new proto_ops ->read_skb()")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/ipv4/udp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 0ac2bf4f8759..f5ba36e721cb 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2011,6 +2011,11 @@ int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 	}
 
 	WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
+	/* skb->dev still aliases the UDP rx dev_scratch (its charge was freed
+	 * on dequeue above); a sockmap verdict program may deref it via
+	 * bpf_sk_lookup_*(), so clear it -> bpf_skc_lookup() uses skb->sk
+	 */
+	skb->dev = NULL;
 	return recv_actor(sk, skb);
 }
 
-- 
2.43.0


