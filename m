Return-Path: <netdev+bounces-279871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PySJfRq5mmBwAEAu9opvQ
	(envelope-from <netdev+bounces-279871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:05:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B93B43272E
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01DAC314242E
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 16:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B964346E67;
	Mon, 20 Apr 2026 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUNMaSWz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1AD34C9AC
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776702469; cv=none; b=lmRQxkspZAljgrddSebh9MMsRbF8s1gQOkjwYy/3OOzc0k29ZIxyLz+HkR4TqFZ1BHscqXUtwi9K0+RVlrCahWBmGEd8e0Xc1GjXjiVexn9Cq9Obkg3mgHDdy2iI0XQK64iFVpXB9qIzgcNkWFW1psGVVrgWTzfcrx1YaLftfvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776702469; c=relaxed/simple;
	bh=evayBaPrs6BX6HReooKQD8y9Hc6cu+bkyz671CEA814=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ethkk5gX9sa8FdbDGEXiO0kuqQE5hAdyxWypSHDYmKMEEc0tZBFS8lZXqgeZ0p9QvdhwWyj/ldwcQKJ6shpwsRf1AoRdRpLa4CdiZllfJB13MeedZ6eKjDSuDP3ZlwRmCo2VKLOnMVaOrV9Uwp1920Cw8fBYthc3oo498BWgJOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUNMaSWz; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8eae9229110so189454185a.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 09:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776702467; x=1777307267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zRBP2HEpjTOd8VHWChKXQR5DE4JBIEeYnfAtHpEwptc=;
        b=kUNMaSWzvqOefGfmV69yBh+UaQx6pfhSpZ8cVLDoScUyXMo6rB8YynkhhOzMCHulY7
         M+Itd3Zm2V5vIq+lF0vxqvzeXr8Y/tYlUml1zw/zT9NHiIKCcp/fTDoj8EoMvkzFLZTJ
         9XYBEAwV9LxmJjSOx2tJv2jg442henexsDlXKTqh2j+BidSgLrjWrXepuqFWfAzRznVN
         ycKl6ukCJ0zUW8ompm44X8FkwSVv59y3c/WtUFVi/cjZYfVkx0/HZ9zaJAm0NPPaMqEc
         D2cji66poGyhIxbu0QE6hLboaGan49+DO0y9sr02BBbT6mVBbuH9MQOrsEmyfgPhVaom
         lyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776702467; x=1777307267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRBP2HEpjTOd8VHWChKXQR5DE4JBIEeYnfAtHpEwptc=;
        b=d86VyMmHQC/OQ7rUuxrdP1/p1XLbyoSsAY/hzXf5BqA1QGJ0BikayY6JEiyufVbkdj
         o593BQCpTV1vuyRzAb4gQsgWNf9q4m9MNVFZiyn6Jm6rjIKhGXOT8BMrJp6iqohChpZL
         Yepvsujc9Eiw2O0W+n71urKKiMRrJHu8PDKLxAb9gAmRZ2hDbiqWZN83HOSwlVSPQ6gO
         WcUn9e29OpHbVNx+uHAkMfPAer42J0mr1RsvtTnoJ8CmnhNJ181dN+Ns35SRJ7sQnYh1
         IaJ+N8g0Sd5iSekdnZCi4zU9nny4umEeYDq5XeqtRPNyhXbRh9z2vAxNvRIscvIQ820k
         YFsg==
X-Forwarded-Encrypted: i=1; AFNElJ9Hw/YrJ08+H68jj/LbpLVDqFSTVek38FJ4QR8PEsCxiLAlU0SWgAgnceLU6DBwv9DKmK4bQZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc9qSIvFsQ/XkQT7BRfe6mS7rJwQk+byEtnVlwUncVMBtS8H7l
	+BADc5Q+xdO883hJrpKueokkdAfTUIe34ri/SGAKDCij8wXStK5/8yO0
X-Gm-Gg: AeBDievFdVqFPu5TOaMdxxLy8zgcJrxsnhRsaD1JQacVwRv3pS+ZPgVsBQB4PLswxQC
	ySB6QrVEX2pzvsI/cl707Il4m2bF1/N3J4TFNMacdsr9t9CbbSofU0j6UoelUGXJ/UwBQl9j6tM
	MvuLfcWox66BFKK4PW4gcd9kFJeE33WRYCKkiw1UK3QW7bL4Iyogvm+Z7GI3HMl9qjGh69557sZ
	1PqpBgHP6kM8oodKC74aMoEIWXgDn3rZ27lqLiw9H+aL0q7x2aUFsNPOWEzaFuXhm2FRgVEbB6a
	blxGH8Pyxh+KCtwVFj/phUMVvQCdg4WxBd6eACFce8iZEzzDI3kSaiHYM07XShMHcMW/aJ46N8N
	fcsYZj2TiO+S4dOWwdf5S1ecDKsYDpbeXQNGJcQY/fynvxpJHJf2TPtbl18sUlOFJfdpEB5Nlt+
	aidV1CI3O6EQ4a8c+hyTEmIsrPgkZx44SSbfUnMZ6+iBY7UvwS25NavLLRKc207f0ZulSPFStmN
	TX/jzzARfnYZUiHen0ijCZ+JV7SDo0=
X-Received: by 2002:a05:620a:4886:b0:8d6:9e5c:36c with SMTP id af79cd13be357-8e78f0584edmr2111339985a.6.1776702466795;
        Mon, 20 Apr 2026 09:27:46 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8eb9becc6c3sm208655085a.39.2026.04.20.09.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 09:27:46 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kees Cook <kees@kernel.org>,
	Feng Yang <yangfeng@kylinos.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] netlink: clean up failed initial dump-start state
Date: Mon, 20 Apr 2026 12:27:34 -0400
Message-ID: <20260420162734.854587-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279871-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1B93B43272E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When __netlink_dump_start() has already installed cb->skb, taken the
module reference and set cb_running, a failure from the first
netlink_dump(sk, true) call returns via errout_skb without unwinding the
callback lifetime. That leaves cb_running set and defers module_put()
and consume_skb(cb->skb) until userspace drains the socket or closes it.

Share the normal callback teardown in a helper and use it on successful
completion and on the initial lock_taken=true failure path. Keep the
lock_taken=false continuation path unchanged, because recvmsg()-driven
retries legitimately preserve cb_running when they run out of receive
room.

Fixes: 16b304f3404f ("netlink: Eliminate kmalloc in netlink dump operation.")
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Validation inside a UML guest on current mainline:

  - An unprivileged local task (uid=65534, no CAP_NET_ADMIN) opens a
    plain NETLINK_ROUTE socket, preloads sk_rmem_alloc with echoed
    NLMSG_ERROR replies from an unsupported rtnetlink type, then issues
    RTM_GETLINK | NLM_F_DUMP | NLM_F_ACK.
  - Stock kernel: the initial __netlink_dump_start() hits the rmem gate
    and returns via errout_skb with cb_running stuck at 1 until
    recvmsg() or close() drives forward progress.
  - Patched kernel: the same probe leaves cb_running clear immediately
    on the lock_taken=true failure, and the larger-rcvbuf continuation
    path (legitimate dump in progress) is unchanged.

A scaling pass on 3500 such wedged sockets in a 256M UML guest shows
about 3.8-3.9 MiB of extra unreclaimable slab (/proc/meminfo
SUnreclaim) beyond the visible queued rmem on the vulnerable kernel,
roughly 1.1 KiB/socket. Real accumulation, but the test hits
RLIMIT_NOFILE long before the guest approaches OOM, so this still
looks like a local availability cleanup rather than an exhaustion
primitive.

No Cc: stable@ on the theory that the bug self-heals on
recvmsg()/close and the accumulation is mild. Happy to add it and
route to net if you'd rather see it backported.

 net/netlink/af_netlink.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 4d609d5cf406..7019c17e6879 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2250,6 +2250,20 @@ static int netlink_dump_done(struct netlink_sock *nlk, struct sk_buff *skb,
 	return 0;
 }
 
+static void netlink_dump_cleanup(struct netlink_sock *nlk)
+{
+	struct module *module = nlk->cb.module;
+	struct sk_buff *skb = nlk->cb.skb;
+
+	if (nlk->cb.done)
+		nlk->cb.done(&nlk->cb);
+
+	WRITE_ONCE(nlk->cb_running, false);
+	mutex_unlock(&nlk->nl_cb_mutex);
+	module_put(module);
+	consume_skb(skb);
+}
+
 static int netlink_dump(struct sock *sk, bool lock_taken)
 {
 	struct netlink_sock *nlk = nlk_sk(sk);
@@ -2258,7 +2272,6 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 	struct sk_buff *skb = NULL;
 	unsigned int rmem, rcvbuf;
 	size_t max_recvmsg_len;
-	struct module *module;
 	int err = -ENOBUFS;
 	int alloc_min_size;
 	int alloc_size;
@@ -2366,19 +2379,14 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 	else
 		__netlink_sendskb(sk, skb);
 
-	if (cb->done)
-		cb->done(cb);
-
-	WRITE_ONCE(nlk->cb_running, false);
-	module = cb->module;
-	skb = cb->skb;
-	mutex_unlock(&nlk->nl_cb_mutex);
-	module_put(module);
-	consume_skb(skb);
+	netlink_dump_cleanup(nlk);
 	return 0;
 
 errout_skb:
-	mutex_unlock(&nlk->nl_cb_mutex);
+	if (lock_taken)
+		netlink_dump_cleanup(nlk);
+	else
+		mutex_unlock(&nlk->nl_cb_mutex);
 	kfree_skb(skb);
 	return err;
 }
-- 
2.53.0


