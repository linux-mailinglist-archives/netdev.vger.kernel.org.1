Return-Path: <netdev+bounces-264539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L5UEy3qqWmLHwEAu9opvQ
	(envelope-from <netdev+bounces-264539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:40:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5153E2183F3
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E80C73026BCC
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 20:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC11F3451B2;
	Thu,  5 Mar 2026 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d40pxSfv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE9F34252C
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 20:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772743076; cv=none; b=HpaJ78DCAfEhyqHEj8C8I5bjcYOAbnAB3F/gB+Q1X0nw2F9kQaDSKhNtPgj+zyp4fVPwdpiPupbPIRvNJieZ3PlVfcgvwR2edT/es+n4L13eeNzfHjzoKgzxAB7rjmRUYVn/+h5+lGC9rryNMPkj3v7AJ8rIavE6h4/XS7eakGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772743076; c=relaxed/simple;
	bh=BJNtUYfcCSIEf+KeHSlKgwI0CK0CjGEsuB477WGKkxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jwxKcjk14kmowFigt5giOQjsubw+p/NRRLSeQxos0oiEf9JxUUfx2O1cm5W4bSxV27hXwzrqvWU1QutEjoyME3VsMy9oNJIa5Cg2Z1yxzKbBKlDLuvOpzVdtNPvUoPh3HCi0ci/qTv0TsWFlANHX4lqP8fp0TtUYw652n5KSSzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d40pxSfv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48329eb96a7so56643415e9.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 12:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772743073; x=1773347873; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5iQa15gRV5WHmyp76havDhzqIhlaRupWnpaZaZ9e388=;
        b=d40pxSfvQg+T40WC4baDClvjkGivNBvgPsiskFs140c40hWoSXfX8PN7PeDorTS31G
         U0SZzVGlsToJ3T58uTfVTPrAX8HJQGNSrGfTzwyhZg/AfmIzTpF1wd0yTM2FjJAf+pI5
         l6EqbX6NaGSNrRtO66EENu6yu/ShkLrw2N4nJ4ZPUbreOAdKlQpqxUNm4OLhBIrmim5y
         9NoMIqG8Us39fHAi0ZGTzSdLTVz/w0oRrdGLpW+EmwuQ+FilrwkAQ3qEJy4Mmm2z5OM0
         Fwm8mQYV9EfQxuhHw+GaOpOY9s6tLtnyyR+ASCeNFBxf+Djhos4oExD6BzHKd1YUuncP
         zgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772743073; x=1773347873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5iQa15gRV5WHmyp76havDhzqIhlaRupWnpaZaZ9e388=;
        b=D7461WDKUn7Qnfe/XDF2/0vgYbFrYbwSkASOcGYgC+/t6gXK9uSuqqSBDarmarV7xN
         tVwJVKU4ZHCTZZXumiKrA3sdpw4YIr72gL0WnxLAbIDn847ttil3p+h9vYQ0YVboUEhk
         mZJZWKEXJK1eaRUmZ5DtNCAltGFqbP0IA5NYguG1NrEn1ZDacVmcvndtndBqIzhaAupI
         hG+0Ni7BbIVlvYzcaqhBtZRLAjK1beAsI8ltp0lxRZ1lKGPTCqHeHm0Z3lYf7Pp+QuMF
         Hbb3q/THmCp5/2P6WCkoRwtM+zdD1o3qrmaoz0vl0mH2AYxirAdo0SjYM3AWjMbAigOk
         JA4w==
X-Forwarded-Encrypted: i=1; AJvYcCVL2yCNilqIu7HyY2w2f80qRja6Ln901ui/hPsB8BkwbUC2O1gNB3IjFotaWNy6Ecs0gnZX36Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+0lylFdR9j3qFUDUwmpenG2VHNb66ZIJqjJxcYqBtpqZ3ywWT
	SP/TyYIfADTmDgQ6B2NWYVfqEr1b8JKEoHH9aCC8qxfBofMxBVdEqF2jhzzm0yxxkWA=
X-Gm-Gg: ATEYQzzr1TBY4zwZNKKt4IIBn6pmW7VUnaIhK+clllzAgaHKAFWDEUHaeHcZPRh/OM0
	9iAaP5OXfvXHWSilRrHtaWMHHJlY9HOimyb2wBWCTiKdDAVynns54IbSS65ISaoHRKkRwLGwJWK
	v2rCqlybJxHMkttVjkP8aSttPNHWV8zE/yUGrVJXVE3UKGIlmjpZPXDH6t54VLZDpzMcpIKxfW/
	BSQO1c49tgWs/jUXDRB+eVic9xpnFmJSoVtQjRteZPpFGkbn2KjIWKB1OM3H85UGTtUtaSJxs63
	h+Of5zLVKv3ZHWDH/ge1N5QbHaSg6aHrkqMS3WZuKsgkA/kQWPF/N7tdvr+BNx8wj91lqipM9v0
	onhpzhvUqbrVm+ygMUfJfTCWO7mrMlj6Q9KoEyHqkl8kfUkoxu6CfmRm0xI8e9TanLGTxpMLZva
	hQQ2GJewuS6t41GIInD3rC
X-Received: by 2002:a05:600c:4e8a:b0:47e:e9c9:23bc with SMTP id 5b1f17b1804b1-4851989fb4cmr108131025e9.30.1772743073493;
        Thu, 05 Mar 2026 12:37:53 -0800 (PST)
Received: from localhost ([189.99.238.164])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94df65a2a0esm21503219241.12.2026.03.05.12.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 12:37:51 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 05 Mar 2026 17:37:40 -0300
Subject: [PATCH net v2 2/3] bpf: bpf_out_neigh_v6: Fix nd_tbl NULL
 dereference when IPv6 is disabled
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260305-net-nd_tbl_fixes-v2-2-b7177db1a9f3@suse.com>
References: <20260305-net-nd_tbl_fixes-v2-0-b7177db1a9f3@suse.com>
In-Reply-To: <20260305-net-nd_tbl_fixes-v2-0-b7177db1a9f3@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1772743062; l=2000;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=BJNtUYfcCSIEf+KeHSlKgwI0CK0CjGEsuB477WGKkxc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKpwaygzkyRw1nX1Db8ixqMTwa+zBHSzqsGzeC0nU7VvrPsKL8ySrGdrLXidS6fBHmhzLURON79
 y3rFPuYcGygw=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Rspamd-Queue-Id: 5153E2183F3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264539-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid,suse.de:email]
X-Rspamd-Action: no action

When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
initialized because inet6_init() exits before ndisc_init() is called which
initializes it. If bpf_redirect_neigh() is called with explicit AF_INET6
nexthop parameters, __bpf_redirect_neigh_v6() can skip the IPv6 FIB lookup
and call bpf_out_neigh_v6() directly. bpf_out_neigh_v6() then calls
ip_neigh_gw6(), which uses ipv6_stub->nd_tbl.

 BUG: kernel NULL pointer dereference, address: 0000000000000248
 Oops: Oops: 0000 [#1] SMP NOPTI
 RIP: 0010:skb_do_redirect+0x44f/0xf40
 Call Trace:
  <TASK>
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? __tcf_classify.constprop.0+0x83/0x160
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? tcf_classify+0x2b/0x50
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? tc_run+0xb8/0x120
  ? srso_alias_return_thunk+0x5/0xfbef5
  __dev_queue_xmit+0x6fa/0x1000
  ? srso_alias_return_thunk+0x5/0xfbef5
  packet_sendmsg+0x10da/0x1700
  ? srso_alias_return_thunk+0x5/0xfbef5
  __sys_sendto+0x1f3/0x220
  __x64_sys_sendto+0x24/0x30
  do_syscall_64+0x101/0xf80
  ? exc_page_fault+0x6e/0x170
  ? srso_alias_return_thunk+0x5/0xfbef5
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  </TASK>

Fix this by adding an early check in bpf_out_neigh_v6(). If
ipv6_stub->nd_tbl is NULL, drop the packet before neighbor lookup.

Suggested-by: Fernando Fernandez Mancera <fmancera@suse.de>
Fixes: ba452c9e996d ("bpf: Fix bpf_redirect_neigh helper api to support supplying nexthop")
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index ff02dbe4c94f..3344fa0789f0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2228,6 +2228,9 @@ static int bpf_out_neigh_v6(struct net *net, struct sk_buff *skb,
 			return -ENOMEM;
 	}
 
+	if (unlikely(!ipv6_mod_enabled()))
+		goto out_drop;
+
 	rcu_read_lock();
 	if (!nh) {
 		dst = skb_dst(skb);

-- 
2.53.0


