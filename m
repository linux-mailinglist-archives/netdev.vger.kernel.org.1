Return-Path: <netdev+bounces-289729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHQfEagkDWrctgUAu9opvQ
	(envelope-from <netdev+bounces-289729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 05:04:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C61587096
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 05:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4932530056D6
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BFF32B10F;
	Wed, 20 May 2026 03:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhglDZjc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584E230C61B
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 03:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779246245; cv=none; b=lQxgPeBckn8az0JvaUkMHsYznZbd0sGNaBY22U5WHu/tQLumCXNOh6FSp0Kla9yrO094DHu6dIpku83t9cHW4cNPrTPppGVGOaEmVTkqkZqV5WdBNC8B8AKruqkJlxt99swieKrbLiBToK+dqhoFeEgno3WxFpJmeYq4hquQqIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779246245; c=relaxed/simple;
	bh=Wiih0f6OIaCvmndCXRWrRH6xlc+Q9XwF+Kgo0p/Z/uI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IRZv/7PiYJ7GcToDHOT0IRXsoSxaCjzq3KskfwrOLgel/hJNBJeX82lPro+ot/fPOpF0V3BXprdXVBI00wpeOVWUQp3Ibav7HXXoLOj12JssIRysRdhUEfYiynArxTKPLxUerIt7pF/wDlyA8d0INXzYPjH2iSiJSdbeJJ+HA6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhglDZjc; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50d6ab4476eso48239601cf.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 20:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779246243; x=1779851043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kovsExyDN+b4Tnm+cUXV8cO+9boS4Oqn0adESQ9JWn0=;
        b=YhglDZjcT1OOMYwihBsXNLmfkbFA8NIhqugUHpULC8akaoJ8XHLPWNo3UzvrKo7pjp
         MlzLm6MCb0oVg18PQ1DySD9370lv/1wgVoqr4QO71BzNhPbG5U6NELTLHKrFEMfXExs1
         4ttvix4yPHxVsPXwi457vFMAT5Bgsq6fK+HYFXqwdIXmn/8ENENWIGhIqmj/mPTe+7AV
         XNRMIT2MHS4iRQL6o5JJhx023Y+vNZYi6PwZtwHB+OdXvF5W4fQE6Tgpv0CH88aGmfWT
         k53Ak/OU7mQM8nKcly+Z2tz2qiElJ6wBV35druXkh5jq+5f/lWGnv6rnVxl8XgM13QQv
         rlrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779246243; x=1779851043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kovsExyDN+b4Tnm+cUXV8cO+9boS4Oqn0adESQ9JWn0=;
        b=p67VFphM6kPNkcfY3paDJLAmnOHPVlxnyepU/blUewJMa7GozHL3qjZkSv3s/6723X
         33Ho6guuH9WrlgTTrHd1QEMCVpQaS8+LHgwyBa/1/0w3ufpviYOfKduABA9H/OLRT6ss
         VG1tYhL5ZabHXbFZNwExRECOwQvSdq2lhwtMtxdXfCWGtn+uRI/7sUzN7piGi1SzKiA4
         D8Dd9g0dZLsMwjCaFGVM8UJp9cJf3iK6b2TR2UiAMk+Th9dPWmcNHg//n2lIYFouIigO
         S5TbA84et4tdK/oPQKZA871J4CmwFGsUqezc4GXqhvMAgFPTGnjo73TUuyEqO6dCRo3Y
         2vxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/k08URSNC0jNcwYFmTbKjCbPj3GI0rw/XlZIbD7gTYLIgQzg0ybactSIb4VvDLwwALZotu59g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYUc89S5bOXwv7ZPlGhObPbKYagDa2bjGZkUCBVYYAa49iesbD
	wIgyqFcaKdFp80/BbIXVZFrwHmRVsq2vJwMbs3zdEAZdQDzQ4//zaztS
X-Gm-Gg: Acq92OEPd4TjdJ4f0LXfyS+p5DH2HEQ2s7eWZ25OlkvkfFj0g9t/G+u9wEXbJQyJR7H
	KDHgvWrt7e6nkE222c/yv6bTNdgUAcd/injJ2XU+QqxK9imy3oLsOnHBROarCBcda5548IwQsqj
	13venxO8xbJnqby4MPEVRjg9tNAZSppMvnvcklUxQ9Z1+QaXPUG7weGXwHB8JwM4LstUP8ZOhpN
	KqvFlqyzaNVVbdyelV0NQh7DMjdU4kWb7cCtk1I61idZ9HI7HX9AItbFlNCl0ZKxDIIXmkmh19q
	bejP9uUnAY3elRKZ8VuPgCX38U2z+/irl2gcOdqBdS7zTvDFvEXyhLAi+2QzqrJer5E2LWgYx7n
	SnqO0jO+V713R0BLBK+BLH30zrQUPHrVV2CHKhv5v5uEp4IISUTsTCTdQgZgjgTBysRy0PSWbL3
	wcabcSUEotN9l9McQkEoccBvH61mLtZjNy3Wck4ocH
X-Received: by 2002:a05:620a:12da:b0:912:67ca:bab7 with SMTP id af79cd13be357-91267cac05amr2355066385a.2.1779246243171;
        Tue, 19 May 2026 20:04:03 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba36e638sm2036138285a.9.2026.05.19.20.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 20:04:02 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v3] ipv6: route: Unregister netdevice notifier on BPF init failure
Date: Tue, 19 May 2026 23:03:28 -0400
Message-ID: <20260520030329.1061183-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-289729-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dbgh9129@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A0C61587096
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ip6_route_init() registers ip6_route_dev_notifier before registering the
IPv6 route BPF iterator target. If bpf_iter_register() fails after the
notifier has been registered, the error path currently jumps to
out_register_late_subsys and unwinds the RTNL handlers and pernet route
state without removing the notifier from the netdevice notifier chain.

This leaves ip6_route_dev_notify() callable after the IPv6 route state it
uses has been torn down. Add a separate unwind label for the BPF iterator
failure path and unregister the netdevice notifier before continuing with
the existing cleanup.

Fixes: 138d0be35b14 ("net: bpf: Add netlink and ipv6_route bpf_iter targets")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
Chagnes since v2:
- Rebase on current net/ipv6/route.c.
- Keep the goto-based unwind path.
- Guard the notifier unwind label with the same BPF/procfs condition.
Chages since v1:
- Unregister ip6_route_dev_notifier directlry in the bpf_iter_register() failure path.
 net/ipv6/route.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index e3d355d1fbd6..b106e5fef9cb 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6933,7 +6933,7 @@ int __init ip6_route_init(void)
 #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PROC_FS)
 	ret = bpf_iter_register();
 	if (ret)
-		goto out_register_late_subsys;
+		goto out_register_notifier;
 #endif
 
 	for_each_possible_cpu(cpu) {
@@ -6946,6 +6946,10 @@ int __init ip6_route_init(void)
 out:
 	return ret;
 
+#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PROC_FS)
+out_register_notifier:
+	unregister_netdevice_notifier(&ip6_route_dev_notifier);
+#endif
 out_register_late_subsys:
 	rtnl_unregister_all(PF_INET6);
 	unregister_pernet_subsys(&ip6_route_net_late_ops);
-- 
2.43.0


