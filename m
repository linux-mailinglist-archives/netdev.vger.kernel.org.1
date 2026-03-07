Return-Path: <netdev+bounces-265180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBqhLlWQrGlEqwEAu9opvQ
	(envelope-from <netdev+bounces-265180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 21:53:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4ED22D957
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 21:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C04E301FFAB
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 20:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D59F3603E4;
	Sat,  7 Mar 2026 20:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NyJaqgXI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83E6270EC1
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772916679; cv=none; b=RHW6RTUGOEqGHhqEWYw2PhvYOaQg2TYlw53shSqQwUvEFBFsR28ACEhPHyFZF1fbDI2Ob9uNxjpUv1lL1SiYgfRMp0tc6ITEyOr/YqOgB/EiQinMGYCHJZZbE4xf+6RfIbp6ORYVw7Ir6sa2M3IYAvYOdAv3Bj9MnAE4T8eIZiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772916679; c=relaxed/simple;
	bh=LfIxcEnbfF8UcBAlQpsEC60tpSn836JRskSf+FgYy7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QUUoef4xSwGeb7685pqdo4cxJQtlyxSAgDYFYrRTD7xC15wWkTGUiueMt6DjCm5mvX9vqWWEBWDYE8ISMAWjT6DKrx8ak+M5JqL8i2NSL8rM5Vy8tlNmeuef3dyrv6mMWXrF7MMYCpQaVb0LnEESw2ecxhTRE8LVHoOAto9XYy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NyJaqgXI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48534237460so2571175e9.3
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 12:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772916676; x=1773521476; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8YSb3tz18QqaSJGIXy5ZYeSWZygMaMUDj6N+n+MakU=;
        b=NyJaqgXIlqFmQfADBmL2KrY9It4WrL7J0rOKiK+s03mgGOTAK2bCRLgTuAe96ZtQFa
         2b7xtY5kWcLPmVpZGDJBCtofd8xSMpNot3ne6FWrPRxKkvjiPqf6d3xUmduUlxbQ2pn/
         1W5R4SZs0+BjBOO+yLasxVfYLROMWaKgD3eF+Ct8iK2d2dh7uRjtgswMpgrwzWldsdhx
         78Z6vsnGg0tlp9ztQOLzRsnYnWvw5q78gbXUXM64IKpXnWZNakuzGxlWNi0zSHsJ7Qz8
         wXJJOKZKPq3NXKzFDCBqdgJah1Q1dJHwYuqnRUSS9MtWVtugq04oCmFvhL2x6p3LWlu3
         c5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772916676; x=1773521476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+8YSb3tz18QqaSJGIXy5ZYeSWZygMaMUDj6N+n+MakU=;
        b=otjf8QhGomxF5IVulU6MVx0UaAOmCMZeQiLmiNoFFiYDTWMIlC+pdbrrk0WLZwWYoS
         uRYD05OTtD5nrYxrOw4/MJvm8Q/cT0/T/ghvWK65AOKzfiLFzkHGkTV85lY3OqbvVPTc
         O2wMTKULyEAQaJl6bIKfSDKxQ9UemdUT4TuepsiBdMpfvbzCbbW3a655xemyZc4s1ugm
         w1A6Gngmy5rL+cOyRSkky5PN/0zUVa6yrtd9W/GYj729GTYqUJ0EBcjjZKc5oHsYqs+E
         p/4oC/twGM4mKQoKUsQPOW8QkWQUsiMmQb0JbgpUXkyZHirm0KAPcBLc67Yn5JYgQNpA
         ixsw==
X-Forwarded-Encrypted: i=1; AJvYcCW/LEbLKfKzcfTsVldHNii8UmUP1hsBnfd3oyL60isApbs0OjHUsnNBCNBv3fkaYh5p7D1g8XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/KCYxKypSMi1012LcnJ1mxbvy84qa9Ea4pktAZD02N7oX+Fzr
	4y3OrFiNjlAtXfeXUD4sqG75rkFNipDCxJw5GyiHHlYCxhMrwXWqUmxOgBoToO9RCKk=
X-Gm-Gg: ATEYQzxMJAo4lWSNQPbwGhUCjIcUE7hgWgHsYMJ4atjLI4d8AdRLVn6LYutFi6tnyZ+
	PGABffJDKItpesms4vIEl+m1CciD9gAfsB46slon1ZJNA1SBk0GwpfMppW8vo1IdlK4HpInBIzr
	eJYR1YBw0N+bRK8oP9pxHYcDElKCXFbRt5huOO5yXXl/mw6f2nXMxEI1But7hVIicurxRIw1J4m
	84WNQ6tFYebydj7vV8k5JWWdqAIPWjkaS++o4S0wTbGp1fJdkNSnPHsLtd7MyT/XbiMlQQbrNMD
	41lA/3VAkPqdhKcbW+qQjIIYOw5mOs3ILiYfVKLXlRDI0uGj8hmo2RNZDAO/op3OQyr3a3n+2sU
	VKYgHKf9dx47STOlDLVU5bbvaZ80VP3H6k8ObNSueZxIaEIm16Qf4CyDIcaOU17d7IxNOsmAxvR
	hr9a4hlGmGJg==
X-Received: by 2002:a05:600c:3e15:b0:485:2f8b:55e9 with SMTP id 5b1f17b1804b1-4852f8b5ca8mr40634795e9.26.1772916676004;
        Sat, 07 Mar 2026 12:51:16 -0800 (PST)
Received: from localhost ([189.99.238.164])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b09b20d3bsm5854727e0c.16.2026.03.07.12.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 12:51:15 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Sat, 07 Mar 2026 17:50:56 -0300
Subject: [PATCH net v4 4/4] bpf: bpf_out_neigh_v6: Fix nd_tbl NULL
 dereference when IPv6 is disabled
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260307-net-nd_tbl_fixes-v4-4-e2677e85628c@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1772916658; l=1991;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=LfIxcEnbfF8UcBAlQpsEC60tpSn836JRskSf+FgYy7k=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QA78kdashxAZg6QDOFTFJ5DdZ4/gEYZMYataFMliZwhtsqkFf/nfobnSy0f0fdVlTgoSW3hutmQ
 V6JaQ4aFi8AE=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Rspamd-Queue-Id: 5D4ED22D957
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
	TAGGED_FROM(0.00)[bounces-265180-lists,netdev=lfdr.de];
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

Fix this by adding an early check in bpf_out_neigh_v6(). If IPv6 is
disabled, drop the packet before neighbor lookup.

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


