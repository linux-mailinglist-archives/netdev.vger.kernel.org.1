Return-Path: <netdev+bounces-265179-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMt6Hh+QrGlEqwEAu9opvQ
	(envelope-from <netdev+bounces-265179-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 21:52:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F093B22D939
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 21:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BF653046BAF
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 20:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDFF377ED6;
	Sat,  7 Mar 2026 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ITkjOxaP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF96637A488
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772916673; cv=none; b=iwok4FlcXoj5gKLy2qC9vhGAXxwFVGVGGjTFGgtD8EIbObkDUoLWPg+hh0YugYUE6O8CORmW5kuk7izfRGGtYapwetVJn0Iklic9QCwpiMU4sXL4kVuvFd9Rohj9NITlcdoNgZd8Aq5yElohHeKUn3WXsc5ZskZ09MTBcFaQ3aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772916673; c=relaxed/simple;
	bh=rQz0G09ECTye/1V+FFrPEYbTDw+YCYeHWPbDy66SMRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kUBYyJ9nBaEyk6tCp4YETuo/YTXKojfFjtoXW9AEtYrYUbTP026a6F3hg+Kc6foLem9PAJY68c4Ejfchemcx6RNu9NLEsHjW016wvucADlZpRqPEGNmh2v0Pq1W7suDcob5kGpQlJddQIFw8vshi6a9nfy8keLCv/QKOaud3Cu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ITkjOxaP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-480706554beso113840675e9.1
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 12:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772916670; x=1773521470; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TEKXuJgPJhSEn7xi7NpdjtrZ7sxjabMNE5jL/D5Rdk=;
        b=ITkjOxaPCo833NGBF7BtbDeuTdXB9wRblgPeP69oqN5l1Jtktxi2Xc6TCW3CvFIkNc
         1kPIJz1/rWvbN3UPyyd2EYL/UPBHFMj2IedioLIxaAV9CyTYodYO8EURt3rUJ3K1B6+4
         beFdAx/s6lMXT4li2RGeUta4w/8Y/ytCozoUe6kkiT/HhPqy0pHmOTTmJ6iodI1MzSvx
         x1qc7SSbL1y1Rjy3BBjiW3BPmxYqp4YOaj63K6fE2ZSEkq6Q5P0sRPOcp1mxeDgU7pqw
         MK7DHz+8rES9kus4a09R85wLCkTFp1rH/+1zaUr98XoJoSKc9o8QTEN5LC/ka84sdR9n
         htDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772916670; x=1773521470;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8TEKXuJgPJhSEn7xi7NpdjtrZ7sxjabMNE5jL/D5Rdk=;
        b=XDzggtwgRIbD7PlhXuNrOeG/bWP4uupj4wUaxmBQVUsJNve8NctWy/GPBYLUXeM3un
         Xfi9JX/b/EB5TpJcJetRMqQL2829yNtdm0bxM4VDxFO6uqTmiJlGhL7u7KmYoZE9BV2P
         LH2X9Aylu8Z3EdjIQXJGRPFweFZDS8CNj/RqzlyTD56faeDImBkX+nGQ76f/WTgMKbDW
         3x9i0fJnIKRtyBy2K9pSRYFUTOPRQ8EfoTz/QSYROj5H2c7sCpxSAxAo0xPvyAM1kvh/
         X1t53jkKhW8DgLfKTCTy1Qw2cfDSPcgXROBAlK2ubA9nhRvJmrQZg5QH5jyHAQLVo3nK
         u+yg==
X-Forwarded-Encrypted: i=1; AJvYcCWcuH7cqO1bv9DP9xCIJNjzTwGyPiMlL9LwvwU+p7wiQVIBbB/668fBMoasGgYd9tO5Imce4SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Zi7WSMmYDMw2/Y9FYvg6k9fucJwG6ZPoxhvJrg3B/UYoE+/7
	xDqu2LLh4iMxxPx3LKXqZA27VsCeq4jgV49qjbQehitwWVQrCFsvZEukeaHabGwq2D0=
X-Gm-Gg: ATEYQzyT7wad2srSXVGQ4E1IlevY+SuDP6EKjVzP7UTwCTNOODJlGmG2dscQKJXUYQg
	02FBbK0zDfskpe7vh731MSWYepXUtf3J6QUQsbRyqGFUj8S5GLjxCLQ8QYwPOoElpQPA/WPP1In
	Ks9LAiFoCSqqEWFvam1ifcmMVOg7pWqfMGrILKGZuFLFoLShd85e+SRq5agzCkIZMKbD5BBYFMa
	zacx72cBLRsBzwz+OpOyBj95/hPcb/5SSOvFEdHBLcK+72bc6jDtbTDMMPO+ye66Ubng7q+ozBk
	O2ZbxSg5U+fbOvHy7mRrxpahjfICz/3WQGXaqszR84J7sbSJsQMNUfpNqw8TZnFbZonMaxTBg3w
	5IKJZtlk6w+ApanE/C5eMQ0Z/Nfmhj4IWzyisf6ErdOds2Pudh2UzGJCuG6buaRzeL3xlWqZJ4P
	5TwHZfoYIuQw==
X-Received: by 2002:a05:600c:a00f:b0:485:358b:e80c with SMTP id 5b1f17b1804b1-485358bea63mr7375885e9.0.1772916670131;
        Sat, 07 Mar 2026 12:51:10 -0800 (PST)
Received: from localhost ([189.99.238.164])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ffe88aa2d6sm5497582137.2.2026.03.07.12.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 12:51:09 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Sat, 07 Mar 2026 17:50:54 -0300
Subject: [PATCH net v4 2/4] net: bonding: Fix nd_tbl NULL dereference when
 IPv6 is disabled
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260307-net-nd_tbl_fixes-v4-2-e2677e85628c@suse.com>
References: <20260307-net-nd_tbl_fixes-v4-0-e2677e85628c@suse.com>
In-Reply-To: <20260307-net-nd_tbl_fixes-v4-0-e2677e85628c@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1772916658; l=2801;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=rQz0G09ECTye/1V+FFrPEYbTDw+YCYeHWPbDy66SMRc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLCmgfW5DEXGJb2EZsh2R6vAsikXWKiPtCnscGYQnGo0rUUoES4G2ViJ1aKYt66Gh8fF8JsbZUl
 wHGhFS0aC1AU=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Rspamd-Queue-Id: F093B22D939
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265179-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rbm@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid]
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

Fix this by checking ipv6_mod_enabled() before dispatching IPv6 packets to
bond_na_rcv(). If IPv6 is disabled, return early from bond_rcv_validate()
and avoid the path to ipv6_chk_addr().

Suggested-by: Fernando Fernandez Mancera <fmancera@suse.de>
Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 drivers/net/bonding/bond_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 14ed91391fcc..33fb5f168cef 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3377,7 +3377,7 @@ int bond_rcv_validate(const struct sk_buff *skb, struct bonding *bond,
 	} else if (is_arp) {
 		return bond_arp_rcv(skb, bond, slave);
 #if IS_ENABLED(CONFIG_IPV6)
-	} else if (is_ipv6) {
+	} else if (is_ipv6 && likely(ipv6_mod_enabled())) {
 		return bond_na_rcv(skb, bond, slave);
 #endif
 	} else {

-- 
2.53.0


