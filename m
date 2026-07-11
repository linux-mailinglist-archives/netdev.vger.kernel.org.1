Return-Path: <netdev+bounces-306853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Sbi5BLNCUmoSNwMAu9opvQ
	(envelope-from <netdev+bounces-306853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 15:18:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EC38D741A48
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 15:18:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kespDhDL;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306853-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306853-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0CD7300441D
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 13:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372403C4B8D;
	Sat, 11 Jul 2026 13:18:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DC53BB9EF
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 13:18:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783775917; cv=none; b=jCmnIEwsGP5UJjDQzHa/njCg+skD0R8dcuWJZtGgeTnyjtALgPAm8vgx3LGPjVqjzOy+lkz73i0w3/Df5AWaeb2Ph1rn3GxhrJOusDYJwhYPla/2wbPDTDGwo7iuE//pknm015geQLy/mlKB6Bgy2CbQhRiHKHgGqVh2D5aAS+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783775917; c=relaxed/simple;
	bh=mo/EeCFYiIfcjGvM4wIvw/yuBoBf1DhpV0g1hQXiQHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o4CWC94u374EaWtRbyDsf0YPk9P0lGywkZbRLSri/xuij2qdifEHNi9e54C7YofGLLH35nMr5m9kTR1XCjgY5lGJwE6UTnCNvXkuyxpITpEO5a60ptuWK7hL3zubkw0gZjewVIcpC1FmjZYeY23g+EpGkzpLMpcpBngwPknD0Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kespDhDL; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cad8076b01so21980705ad.2
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 06:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783775914; x=1784380714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Ya49dbkdK5J/laqUcndOHoZ1oTeFilKgmxzLKQ+GCE=;
        b=kespDhDLUWhrEyaMHJihcorpv6+/T4/jNQJ+FPmPfzPgZaapSsEk06Y8AIma4hDUEE
         SgA97jrCTj+IO3I/3HQXOb5cIbWLgWdVYDawrp/uGZGnTLT6LiouHQyeg5fPXPph5oh4
         iWfpy+cgn4+By7JdS9ZZLMPjxS44oa3ITjgt8pdr0S6tN2uNLnpfbF2Rh0L8cJlaePUS
         DN0fHNaXThAOF1kHUNjzaT0UhnOhh3gAq2rvFNbGhLvX5bFZ/Bq3K41JoZsXB0HJjjC2
         9CXHdaRmAgCeYqsmNEDMANCwew7BiAMlwRgF7SI1e9U93Yzkyl0mWoceBDzN8EtcPNTV
         /bNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783775914; x=1784380714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Ya49dbkdK5J/laqUcndOHoZ1oTeFilKgmxzLKQ+GCE=;
        b=XiBMLbNKLJ4a4ZJuo5jUnRzStEzxcqJ+6RW4+DHIS/QdprTux4MSjfUOFNM6kAVaIl
         Zie1B9i4IRCIZfEIYizjervRqwEtW3VWiKzVZAQdg49Kwuitbd7cvSW9ToOZo9eliMvQ
         8BEQsUG+6uLPvcQRdnXlpy6z7eydeEl6L+Z+Py5u6hOwf9L8+3/cB8voNPqGMeBV34nn
         yJIZkCPcMtg6pQL0hnpYQL5sGx36qYmYpqzHd4Lbp2NO71ibpXvibAa0zEr+Nknw/i3G
         sGi7IiwplEPfL3rDxxfsjdy+jSc8XFySGDR6Kj+IQuLUQNtcTEeR8wBHhBruszKnx3DH
         OROw==
X-Forwarded-Encrypted: i=1; AHgh+RqHsPMzqiyYq8y0xXx11cxPZPvRqUhqJ6RncIeFBSRXxPoghQtW2X8O0gg1D4fALrLtYL93qmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzEEIp4Jm+19KwFFdLf6xR5di5HKd0BL6rQHba0x+7culARNDA
	XhjfHEvBe/Q9vByg7ZX/KrdReWZ6zz2IsCtW3gpZOakRA6iW8NWblfNu
X-Gm-Gg: AfdE7cklVjneuCkLqCta3Byygr1Fwo0kB9oAwiIWcc/cI3qGoekApqQA6XhQtiYRQ/B
	+g0lw2HBCqvHdmv2LgNGJkrQdmPUntztfFFFE6CU8hoNNcgl8aIK7I+dsfIf20XakxrNtu2LWBC
	DYyFTTv9f8pIzjQKSnz95zMyD6hOj+S7+7pIOIhSkwh0DSmDN5ZIma3QMqDC81PWY6KdB/QsbqD
	UiK8qePbOZ/ZYSD1Dbh2hm9lKnXeOktcSowt28RUfmMGppU4o+YP6yYYoD4j6wGqInoLVlbQql1
	6/OehTJ/M4DjXfq9gO7QgCc8a/b3jzTX6JB4qkWZYHPlIAYaYnoML0DSvP7V0VBOyjzTI0rvSJi
	pssdq4lqvd9yqKFZy7Z+moEmI4jeTGA4cn9BQ4uv6+ppxXQSIpJTVnBQDSJ7Q2dgUuyZrzbGaEI
	TAeXX2WFGEQAlY3wyNo78uQk71o391kzqsVQX9v/UJhZSJ3WlAE0eOWBGp7g==
X-Received: by 2002:a17:903:2f88:b0:2c6:d710:3e58 with SMTP id d9443c01a7336-2ce9f153024mr29088555ad.36.1783775913623;
        Sat, 11 Jul 2026 06:18:33 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d87a2sm47208053c88.13.2026.07.11.06.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 06:18:32 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@gmail.com
Cc: kuniyu@google.com,
	gnault@redhat.com,
	xmei5@asu.edu,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] mpls: fix NULL deref in mpls_valid_fib_dump_req() on CONFIG_INET=n
Date: Sat, 11 Jul 2026 04:50:00 -0700
Message-ID: <20260711114958.1009619-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,redhat.com,asu.edu,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-306853-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@gmail.com,m:kuniyu@google.com,m:gnault@redhat.com,m:xmei5@asu.edu,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC38D741A48

On CONFIG_INET=n builds, mpls_valid_fib_dump_req() walks the parsed
attribute table itself instead of calling ip_valid_fib_dump_req(). The
RTA_OIF arm passes tb[RTA_OIF] to nla_get_u32() without checking it is
present, so an RTM_GETROUTE dump for AF_MPLS with strict checking and no
RTA_OIF hits a NULL dereference.

RTM_GETROUTE is RTNL_KIND_GET, which rtnetlink_rcv_msg() permits without
CAP_NET_ADMIN, so an unprivileged user can trigger it.

  Oops: general protection fault, probably for non-canonical address
        0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  RIP: 0010:mpls_valid_fib_dump_req (net/mpls/af_mpls.c:2189)
  Call Trace:
   mpls_dump_routes (net/mpls/af_mpls.c:2236)
   netlink_dump (net/netlink/af_netlink.c:2331)
   __netlink_dump_start (net/netlink/af_netlink.c:2446)
   rtnetlink_rcv_msg (net/core/rtnetlink.c:7033)
   netlink_rcv_skb (net/netlink/af_netlink.c:2556)
   netlink_unicast (net/netlink/af_netlink.c:1345)
   netlink_sendmsg (net/netlink/af_netlink.c:1900)
   __sock_sendmsg (net/socket.c:790)
   ____sys_sendmsg (net/socket.c:2684)
   ___sys_sendmsg (net/socket.c:2738)
   __sys_sendmsg (net/socket.c:2770)
   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

Skip unset attributes, as ip_valid_fib_dump_req() does.

Fixes: 196cfebf8972 ("net/mpls: Handle kernel side filtering of route dumps")
Assisted-by: Claude:claude-opus-4-8
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/mpls/af_mpls.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index ca504d9626cf..318cb7e2ac5f 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -2186,6 +2186,9 @@ static int mpls_valid_fib_dump_req(struct net *net, const struct nlmsghdr *nlh,
 		int ifindex;
 
 		if (i == RTA_OIF) {
+			if (!tb[i])
+				continue;
+
 			ifindex = nla_get_u32(tb[i]);
 			filter->dev = dev_get_by_index_rcu(net, ifindex);
 			if (!filter->dev)
-- 
2.43.0


