Return-Path: <netdev+bounces-289376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MD0fLVs6DGp8aQUAu9opvQ
	(envelope-from <netdev+bounces-289376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:24:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1D557C291
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 913FA30483F7
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3A437E308;
	Tue, 19 May 2026 09:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g4kc4e17"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969BF36308D
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184543; cv=none; b=AgJhdQlSGOW/9BsfjC9hqHnehUtbTdvLK4jiizoUBY3HM+LCb+krMSAkuYUzB+yi5UqRjAWpnkksWLGWlTlTSxdmRmoDbHzpg8FDFdfVN+mSi8ClRsdzrvR3ULiPKuU2S3uCC1dzwKPfG5g+4JWH5ZDHCZit4LSxjekaRJnwnbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184543; c=relaxed/simple;
	bh=NidIrej7UvcItlv/QGIDkIVHZGZk1wkHjVJPh0+r+lw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ftPFbgtiSknlPpnUHeIrBY3lPacr26oHpfLdsA2CGxZE3rdxSDmpoy91A0xzFszFsEQidcK5x3de0FwI3QYYd6N6HTf+VbmH4DbXjk4IZMH0hW+BJ2K5IJ1gP6iBEB0b1HQYArMyQbeu47rvj7WO0TEZP427N2rofM0msD+hDPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g4kc4e17; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-90fbc9782c9so645144185a.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 02:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779184541; x=1779789341; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UL5sa6moiS69L9aQq8Atm/ndGvM9Sc4sCh2Q07gTeeI=;
        b=g4kc4e175mASZeqO0S0rZn2Ye2OJb1xyIXxev8+Taubrtk7AN5Ob3AcBSiATfFpU6N
         yST2sKgEBSNmfiPg+S7IIGmatEE9ky1b3mTCHcodHHN3z5TRIY714YnrGT+x0wuaEAZv
         S1fOvz144GwTcxEHf058ylgPMCKqiC3shgBkHDOY5Y76JfPw0/rQTa3bekTJTqBVyHFp
         1PGZJBRgk9xtiMlqTEIucD+T5jmQextk6GvL5qSR2hu2h7eAqPdLrmVuj2RWsSKPUwvo
         hZ8vXcDoGjoxXgjDGm5BqnDZ2Ae8Onco2OkV9I2lcHdRzE3LIkIG9puPMfj1qCNbJrZ7
         ugIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779184541; x=1779789341;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UL5sa6moiS69L9aQq8Atm/ndGvM9Sc4sCh2Q07gTeeI=;
        b=V45OXXAkE+VEQnheCnDmB4Hbc0gVw7Q8npkJGX0TXbimlbrMLn94nLndkm5vISDmkA
         uwh5IpC4KtZUjLyr2VrZ+57VcqjnpMbfk6c4dmiGpOooDBRgcgt9ahxY8dqYLHVztlTH
         oOijKsEGueBerc3il/Gm+/Gc3Fd6co0xHjTZU5TE1LMSXbDQPtF4Kp3HvyJEvAot46jA
         kQpzZVvauMTnM2c/WkQrPJ+7b1BmSY/QYsVE+IpNTtWU3vBE6bvMPIoqTTvWfr9iIxiT
         q/znDJLFBDWBt0lmlYwxfqRbEIKsAw3MKTZj4wiRG/MVS0ZLK2eeynPwcyFCogGBB3Gz
         zCLQ==
X-Forwarded-Encrypted: i=1; AFNElJ++dDLSbpq18XFNziuMz6ir89u9NriA6oMEZ1cYJVboNx5ZegTT9Icj8NEBQFpdNy4X9uoio+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFs96EgyHefv6Ua/B95PiHDoBr3/ndImPGsRnfp8g6iBiDsYAd
	gbakEqgN3zuRH+fKxKyEyI6kCTE7I6No+9r8ttmiGBeDpgJme0XTJKkreog6dtnCeUpM1sx0ohD
	nVkiXVQCmHKaDEg==
X-Received: from qkax10-n2.prod.google.com ([2002:a05:620a:224a:20b0:90d:7dbb:8d4c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2950:b0:8ef:f1c0:ab7f with SMTP id af79cd13be357-911ce524059mr2772821685a.24.1779184541336;
 Tue, 19 May 2026 02:55:41 -0700 (PDT)
Date: Tue, 19 May 2026 09:55:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519095540.2643318-1-edumazet@google.com>
Subject: [PATCH net-next] net: bridge: remove stale rcu_barrier() in br_multicast_dev_del()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289376-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,blackwall.org,nvidia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: AC1D557C291
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This rcu_barrier() came from a time call_rcu() calls were used in
net/bridge/br_multicast.c.

Now kfree_rcu() is there, we can remove this problematic rcu_barrier()
which causes extreme RTNL pressure in many syzbot reports.

INFO: task syz-executor:77945 is blocked on a mutex likely owned by task kworker/u1024:5:36537.
task:kworker/u1024:5 state:D stack:24616 pid:36537 tgid:36537 ppid:2      task_flags:0x4208060 flags:0x00080000 last_sleep:612797637337
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
  [<ffffffff81914eaa>] context_switch+0xf2a/0x1730 kernel/sched/core.c:6483
  [<ffffffff81201143>] __schedule+0x1133/0x43a0 kernel/sched/core.c:8411
  [<ffffffff8120446b>] __schedule_loop kernel/sched/core.c:8514 [inline]
  [<ffffffff8120446b>] schedule+0xab/0x260 kernel/sched/core.c:8529
  [<ffffffff8121a093>] schedule_timeout+0xc3/0x2b0 kernel/time/sleep_timeout.c:75
  [<ffffffff81205347>] do_wait_for_common kernel/sched/completion.c:100 [inline]
  [<ffffffff81205347>] __wait_for_common kernel/sched/completion.c:121 [inline]
  [<ffffffff81205347>] wait_for_common kernel/sched/completion.c:132 [inline]
  [<ffffffff81205347>] wait_for_completion+0x2c7/0x5d0 kernel/sched/completion.c:153
  [<ffffffff81b8f27f>] rcu_barrier+0x49f/0x620 kernel/rcu/tree.c:3888
  [<ffffffff860091b3>] br_multicast_dev_del+0x303/0x350 net/bridge/br_multicast.c:4459
  [<ffffffff85fb5dbc>] br_dev_uninit+0x1c/0x40 net/bridge/br_device.c:157
  [<ffffffff8568058c>] unregister_netdevice_many_notify+0x1c1c/0x2300 net/core/dev.c:12599
  [<ffffffff8562be43>] ops_exit_rtnl_list net/core/net_namespace.c:187 [inline]
  [<ffffffff8562be43>] ops_undo_list+0x3d3/0x940 net/core/net_namespace.c:248

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_multicast.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 49ceea3ff9742d3043ac605d656b7fcf37dbcb96..8efa3add5d47508fb2b032ff6238ffbbabfd27ad 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4453,8 +4453,6 @@ void br_multicast_dev_del(struct net_bridge *br)
 	br_multicast_ctx_deinit(&br->multicast_ctx);
 	br_multicast_gc(&deleted_head);
 	cancel_work_sync(&br->mcast_gc_work);
-
-	rcu_barrier();
 }
 
 int br_multicast_set_router(struct net_bridge_mcast *brmctx, unsigned long val)
-- 
2.54.0.563.g4f69b47b94-goog


