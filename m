Return-Path: <netdev+bounces-262185-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ED+yNY1Jo2nx/AQAu9opvQ
	(envelope-from <netdev+bounces-262185-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:01:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 870AA1C7C24
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E29683072BCE
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 19:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DB3430BAF;
	Sat, 28 Feb 2026 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WBW7VvjU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5498B430BAA
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300825; cv=none; b=Ev7A8va4gBWWyCkjURLQ6oXOl646a/4W0LXudI6ImMrWdEE5ZpXiY1c4lO4uCgff4nImMt6n6/A8eGh5PZ1MHsBJsqQk+/ywV4sLilc5RHl6vjS5e3EmvljqttTtt3RBKxRE9+1fUJy/5L9mb2gSNcbUQt4v12qxL8GivbCmrmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300825; c=relaxed/simple;
	bh=6Vq2LsRK/4jiYa/npkCuXmW6QF4BbW5GSecwBZSxdcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XmLyAnNLXdMNS7JBr9/r87W5x8w4uOMvR89oYjKWH0UKJERrH9uSXdVqHysxQAOTCqEtw37X6p2+pUXb9LFkyAoaEZc3sds6vGMU4GOymj6yqDKHj6nVq9B7EP16ejOJHwVqgDNxJn3wkSPoSJrhs7BimjPwk9D+rvqYPL20cBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WBW7VvjU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so33624575e9.1
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 09:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772300823; x=1772905623; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COP0NwgzPdsKfGpPNF1RnyK8e2xrZgwnox+a68B1Ldg=;
        b=WBW7VvjUcPFlx3wZvEXOT/olZZEWTHFLLjp/OQdVBg7bmEh8aaMvJ+MiCnzkC8LK/e
         G6adkcJ6v17R1ZwB2P6KIkccP7OIygT/556mtVzwRqYLwkXBpvAGKZrzrhCB3o6qbnp3
         m3TQZDa3D4fDc9nTmrU5erqAxwO6MxCChX47PhIfdaNF+2K/Gg060BAQfOCxtow4dIQV
         kj1LLYKr7bxQq8+kKatbiTL2e9nRESfR4pXvVb3h1+bm7Qy0u5MkG2IIv7/339DERR0p
         Q1IZ0+IMiuTe7radC5sLxaYYZw/FreAj6y7951Pae5HXAzJW0m+8fD5M2ZfBl2bie/GA
         yidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772300823; x=1772905623;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=COP0NwgzPdsKfGpPNF1RnyK8e2xrZgwnox+a68B1Ldg=;
        b=tqr9Xl+zlnFjZx4L0FpfAN2GT56Eua//Bs4w2uIvY37B+Tfhmj8d2eJHnC149IAhXV
         a4eXtQVSDW9X4vBMddhlO4D6PsMHHRucOXOBqhOABIBEIO8nXYkr4o9zzSvBP4nTWmrL
         dag3NlIwa9MAZeQEYOsszlxy/0LcdlB95xjSkTckvYCG15CXKhINQ5X4mX8+REbBuikd
         LP5Wbsx3j2HDHsDjmbqhetREPMen24w92qsG2WJAzX+Mh1nFeyDDzz2G/WqqXdC4lWpM
         YX0rtGXRqhYrxuwmt4XJs77zo2oZEsL8VfXC7MKyDN19Swfjby5uX9iuZPv3zJZ7Ey5L
         8pmg==
X-Forwarded-Encrypted: i=1; AJvYcCWjmgG9G+4f5jMGFQYrmiwCwenTgdRViU8zcsGs1XT8RpCVg4ycXGWe6pSu8lqBYmKjlU45iK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVT/sL/uVUvaEfMijn4IizgessKFa78UZTS4mOiQWGk6yC75Qn
	j5hDQ16ZjOw9DDFCAhOakyhpqt4ewXXtIw/WqJoUp34Rse8EROj8zYvefaS3HlTSu3o=
X-Gm-Gg: ATEYQzx3CFm/Hld/fEyQaMkbOdHj6XUrwGYYaIoxiASxMMwdOuDBnD9SUDgedGyd2KJ
	feva+PQxmqRo/Zmk3Y+Y6W5AkrBm+kymaGEN8KVhTsP2lTjUhw9Kq9a1NQvqU2dgSZNqf6kqJ8R
	wW3xTBLrDfAGzYH9PvON+FcmUdt9Qa/paEcxx8+MYimWtwXSqW+cEqerGa35cW4IPTeLYgyFtGF
	gTySQcAA9RFofS+FROEmGxhdi9BRylgMPujOTYyRWpqAd5oYtyTaM02C0p4c043IR+4DaRnEUgu
	uMnkJkMGb5UJZcnhpGNxjBME1XMloAMD3AkGxcu7aQaHIHHjMu2F0ljPv/UwMZuFdx1qSm37kKw
	MRsJ6JIBcFOEfE3mE+pJZFibu4vwqcJYbbDkroGI5icqLY/RunMa5+3+IWtzWpjX3j0PJlMpojU
	P9vDvdgKL2
X-Received: by 2002:a05:600c:c490:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-483c9bb1fb0mr111358285e9.10.1772300822706;
        Sat, 28 Feb 2026 09:47:02 -0800 (PST)
Received: from localhost ([189.99.238.12])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ff1e845aabsm8703044137.7.2026.02.28.09.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 09:47:02 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Sat, 28 Feb 2026 14:46:28 -0300
Subject: [PATCH net 3/3] net: bonding: Fix nd_tbl NULL dereference when
 IPv6 is disabled
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260228-net-nd_tbl_fixes-v1-3-2b2a274df9bb@suse.com>
References: <20260228-net-nd_tbl_fixes-v1-0-2b2a274df9bb@suse.com>
In-Reply-To: <20260228-net-nd_tbl_fixes-v1-0-2b2a274df9bb@suse.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 David Ahern <dsahern@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Hangbin Liu <liuhangbin@gmail.com>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, bpf@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1772300803; l=2807;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=6Vq2LsRK/4jiYa/npkCuXmW6QF4BbW5GSecwBZSxdcI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QH6rfP/je5CBrV2Jby9mnvCs0cF3g4KzP79mNzoDtuBgIKQoDkGjqs0qNmfdqL272G6H56/P0nd
 IxpFrS7ofxgo=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262185-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rbm@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 870AA1C7C24
X-Rspamd-Action: no action

When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
initialized because inet6_init() exits before ndisc_init() is called
which initializes it. If bonding ARP/NS validation is enabled, an IPv6
NS/NA packet received on a slave can reach bond_validate_na(), which
calls bond_has_this_ip6(). That path calls ipv6_chk_addr() and can
crash in __ipv6_chk_addr_and_flags().

 BUG: kernel NULL pointer dereference, address: 00000000000005d8
 Oops: Oops: 0000 [#1] SMP NOPTI
 RIP: 0010:__ipv6_chk_addr_and_flags+0x69/0x170
 Call Trace:
  <IRQ>
  ipv6_chk_addr+0x1f/0x30
  bond_validate_na+0x12e/0x1d0 [bonding]
  ? __pfx_bond_handle_frame+0x10/0x10 [bonding]
  bond_rcv_validate+0x1a0/0x450 [bonding]
  bond_handle_frame+0x5e/0x290 [bonding]
  ? srso_alias_return_thunk+0x5/0xfbef5
  __netif_receive_skb_core.constprop.0+0x3e8/0xe50
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? update_cfs_rq_load_avg+0x1a/0x240
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? __enqueue_entity+0x5e/0x240
  __netif_receive_skb_one_core+0x39/0xa0
  process_backlog+0x9c/0x150
  __napi_poll+0x30/0x200
  ? srso_alias_return_thunk+0x5/0xfbef5
  net_rx_action+0x338/0x3b0
  handle_softirqs+0xc9/0x2a0
  do_softirq+0x42/0x60
  </IRQ>
  <TASK>
  __local_bh_enable_ip+0x62/0x70
  __dev_queue_xmit+0x2d3/0x1000
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? packet_parse_headers+0x10a/0x1a0
  packet_sendmsg+0x10da/0x1700
  ? kick_pool+0x5f/0x140
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? __queue_work+0x12d/0x4f0
  __sys_sendto+0x1f3/0x220
  __x64_sys_sendto+0x24/0x30
  do_syscall_64+0x101/0xf80
  ? exc_page_fault+0x6e/0x170
  ? srso_alias_return_thunk+0x5/0xfbef5
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  </TASK>

Fix this by adding an early check in bond_confirm_addr6(). If
ipv6_stub->nd_tbl is NULL, return before calling ipv6_chk_addr().

Suggested-by: Fernando Fernandez Mancera <fmancera@suse.de>
Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 drivers/net/bonding/bond_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index a1de08ee3815..013d037b644a 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -90,6 +90,7 @@
 #include <net/tls.h>
 #endif
 #include <net/ip6_route.h>
+#include <net/ipv6_stubs.h>
 #include <net/netdev_lock.h>
 #include <net/xdp.h>
 
@@ -3251,6 +3252,9 @@ static int bond_confirm_addr6(struct net_device *dev,
 {
 	struct in6_addr *addr = (struct in6_addr *)priv->data;
 
+	if (!ipv6_stub->nd_tbl)
+		return 0;
+
 	return ipv6_chk_addr(dev_net(dev), addr, dev, 0);
 }
 

-- 
2.53.0


