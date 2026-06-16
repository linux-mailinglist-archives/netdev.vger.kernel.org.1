Return-Path: <netdev+bounces-299979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nwHSKZDPMWoaqgUAu9opvQ
	(envelope-from <netdev+bounces-299979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:34:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5191269596F
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:34:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=i0GawATe;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299979-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299979-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5899304CF40
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 22:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BDA3ACA59;
	Tue, 16 Jun 2026 22:34:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988FE391829
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 22:34:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781649289; cv=none; b=gE58/XhOPIBWGBY/rERA23HMggdA8trembvI7bJKxGk74zsCxqHjThtnaBUutPyat+egVj3sXpriP0EUdqLrFCcHimqDVIjX+zJoOZ3GNw0ERiOFclW/RMdZe2D6Q2UamCDIlv8n62Xr2UvGrRVDk13Oebj0sBt2ciVhjEElSl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781649289; c=relaxed/simple;
	bh=MREMlX9+LgltRptf+kqR2KqPhCAifCYS3oH3GLnZZxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/9WvORew+l0mjq8P6VaFq5OHCjsZ4nW9vDxVbl8Jwau6u9VbLt17H8Fcb039ixoh27un6GPOLpkqj3mKxAxdrEor0zBVaSyByS43hla2lViH5ImCXqi+JNN0bLclRfRb7mPm/nys1srJ4UReEW2pftZ6iLmx8giOZv/rLDPE3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0GawATe; arc=none smtp.client-ip=209.85.216.46
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so4152603a91.1
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 15:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781649288; x=1782254088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipTVbRJPrzwAu2tBqpowbpcPQxDZEeCQYuQNdgsgv14=;
        b=i0GawATehAtCjIJ0YgoTI1ZrS8nOQXtGatbWqSQFLsXgEoRhWnO4RHVqUWv3miNwgZ
         rz4AYj4ZeOyWSy+PGklpZ/shTz/EAz/YKiFAHyS9g31hAjfbEveczIDwnoVtjcj8TMIV
         8ocGN6YViRoX/D0kj6fG5SxHi9+Fn5KvnYNz4kgJPCjOqXySJ5y5Ab7a5HkxhljyZYyD
         6lc0RBJzQNqYPPog1v3/znpqMtpmW6Xu2Rpb+vAqabEYXOnV2cW4TLWIbH2M/9dqOUCu
         bXRdalvDHrXRDYR+YOSTSEW2DZ6J7bf18gqEwjzuT8tgoRzsYOCY8h4YBHHLZrQ/53hB
         LMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781649288; x=1782254088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ipTVbRJPrzwAu2tBqpowbpcPQxDZEeCQYuQNdgsgv14=;
        b=Oth4UBlNkaUxOBclR5J/9HsnCU6DQN3109jN4UK95T15RZgCcg0Cc3cyssOpkoMF9A
         7TXlW0ZCPTULKqP33RwTeHGbPyZ6p7BkNFtPy138n6fdQ5CJccW0Vu5MkTcCSRjwKLbs
         gVydK51QVEp2YbCDgCIMt+q/1h9VKA1fDmtierjLQI8tw/TVvqJnqAL8sMUhsnocyQHT
         D7Zav1XRXq83yVEuNA0r5d/iLu/mmcGoryYsyECZTGyaE0GOhxB0uRRhEo2+P14TKSRa
         084J7ZzDiimKs696IMbKij0Cu+yvcqXb/DvG5h2G3LSQS+6XEUuKYS8ZHZ7CZTBTpZhD
         6fKA==
X-Forwarded-Encrypted: i=1; AFNElJ8occ8NLMXs4TA5oXOf5avf2tmtPZbvM8LrwmNxkh3e/rxjoRez6XCZmH/dVdyMOO0mosM/ztw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI4kVssJ3sPJVj+FKonkXlauD/Rr/OEGnVMHrg3s8M0CluzOd/
	PQfw7mdljNZRLJ4dDQPbJeU2h5bLOyZwz7q8UEsY7E+3zEF0DiJPf+kW
X-Gm-Gg: AfdE7clmMTXSSy7WoQf4hkTIEI2ziE2dJSupfGweWSoS2dgHyGIqXo7rFa7w6OfYaJC
	aJ02VgcdVBs7NfaktkONRlJPICgT5mkLTxjHyGDrWi7j7gSfZ9KC1LxVQEos47eVUzP6vHi4i0H
	zubHTwcOxIN82MlypxW99FXJc055s+Z73KA5Dm5hVGaJWepUnWCzbyKoig7t/HMCQhcyUl4PlWy
	qAkE6KDcsWN7amkfvtWBwy5zQfJA1mMckKZHvqxAS5VEP7H2stHoY8b1aoflhG4obOB7ozyKvo2
	uJFPOc7K44vNCjxpiAc4Gp4z2LnShu9ZQXIgGBieA35QgZjrHn8FrtyZIOkmhCaWTuP5ANydksc
	dAOGQ4q+HAOW5d3C9XpGxPl3ih/Z/uF/FMOZ8J38U/+CMMZsGqeG1DMyA6Xyfj6P3646M9RpgJZ
	yeZNuuyKzvJ7d3Yf0ZVlGk6lbDGkVDJ5zYf6M/bA8SPzJLYo2/cd/oH46cG1mBkbe6yEJqBzY=
X-Received: by 2002:a17:90b:2583:b0:35e:d015:d675 with SMTP id 98e67ed59e1d1-37c9345bc79mr1251791a91.7.1781649287777;
        Tue, 16 Jun 2026 15:34:47 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c52092ee3sm4216898a91.0.2026.06.16.15.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 15:34:47 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Eyal Birger <eyal.birger@gmail.com>,
	Rong Tao <rongtao@cestc.cn>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 1/4] bpf: Initialize the l3mdev field for the fib lookup flow
Date: Wed, 17 Jun 2026 04:04:23 +0530
Message-ID: <20260616223426.3568080-2-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616223426.3568080-1-avinash.duduskar@gmail.com>
References: <20260616223426.3568080-1-avinash.duduskar@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-299979-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:eyal.birger@gmail.com,m:rongtao@cestc.cn,m:toke@redhat.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5191269596F

bpf_ipv4_fib_lookup() and bpf_ipv6_fib_lookup() build the flow key on
the stack with a bare "struct flowi4 fl4;" / "struct flowi6 fl6;" and
fill it field by field, but never set flowi4_l3mdev / flowi6_l3mdev.

On the non-DIRECT path the lookup goes through the fib rules whenever the
netns has custom rules, which a VRF installs:

	bpf_ipv4_fib_lookup() -> fib_lookup() -> __fib_lookup()
	  -> l3mdev_update_flow()   reads !fl->flowi_l3mdev
	  -> fib_rules_lookup() -> fib_rule_match()
	       -> l3mdev_fib_rule_match()   uses fl->flowi_l3mdev

l3mdev_update_flow() resolves the l3mdev master from the ingress device
only while the field is still zero:

	if (fl->flowi_iif > LOOPBACK_IFINDEX && !fl->flowi_l3mdev) {
		dev = dev_get_by_index_rcu(net, fl->flowi_iif);
		if (dev)
			fl->flowi_l3mdev = l3mdev_master_ifindex_rcu(dev);
	}

Left at a nonzero stack value the resolution is skipped, and
l3mdev_fib_rule_match() then tests that value as an ifindex, so the VRF
master is not resolved and the rule fails to match: an ingress enslaved
to a VRF can fail to select its table. The same value is also read just
before that, by FIB rules matching on an L3 master device
(l3mdev_fib_rule_iif_match()/_oif_match()), so an "ip rule iif/oif <vrf>"
mismatches the same way.

The helper already initializes the other flow fields the rules path
consumes (flowi4_mark, flowi4_tun_key.tun_id, flowi4_uid and the v6
counterparts); flowi*_l3mdev was added to that set afterwards and this
helper was never updated to match. ip_route_input_slow() likewise zeroes
the field before its input lookup. Do the same here.

CONFIG_INIT_STACK_ALL_ZERO masks this by default, but it depends on
compiler support (CC_HAS_AUTO_VAR_INIT_ZERO), so INIT_STACK_NONE builds,
including older toolchains that fall back to it, are exposed. Built with
INIT_STACK_ALL_PATTERN, a plain bpf_fib_lookup (no VLAN, no DIRECT) over a
VRF slave whose destination is routed only in the VRF table returns
BPF_FIB_LKUP_RET_NOT_FWDED, and resolves with this patch; reverting these
two lines flips it back. The series' VRF selftests pass on the default
config either way, so they do not exercise this fix.

Fixes: 40867d74c374 ("net: Add l3mdev index to flow struct and avoid oif reset for port devices")
Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>
---
 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 9590877b0714..6fa172cb1348 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6162,6 +6162,7 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	fl4.flowi4_dscp = inet_dsfield_to_dscp(params->tos);
 	fl4.flowi4_scope = RT_SCOPE_UNIVERSE;
 	fl4.flowi4_flags = 0;
+	fl4.flowi4_l3mdev = 0;
 
 	fl4.flowi4_proto = params->l4_protocol;
 	fl4.daddr = params->ipv4_dst;
@@ -6307,6 +6308,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	fl6.flowlabel = params->flowinfo;
 	fl6.flowi6_scope = 0;
 	fl6.flowi6_flags = 0;
+	fl6.flowi6_l3mdev = 0;
 	fl6.mp_hash = 0;
 
 	fl6.flowi6_proto = params->l4_protocol;

base-commit: 140fa23df957b51385aa847986d44ad7f59b0563
-- 
2.54.0


