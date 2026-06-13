Return-Path: <netdev+bounces-298983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cm0eK36ELWqHhAQAu9opvQ
	(envelope-from <netdev+bounces-298983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 18:25:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B0C67F0F5
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 18:25:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=l6+5jb+b;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298983-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298983-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4681830374A3
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 16:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806833FF1DF;
	Sat, 13 Jun 2026 16:25:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D723955E5
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 16:25:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781367919; cv=none; b=r9Fd/Z6d63BUMFqp69Xb1s9wzGX7MiPhMCWAqjhmP9zf12s3Sh5moprXJdPDQ5MsZqkpZ+KVmlWvb59HNq+Tmg/maB2JzKSIOBC/zoyXzDIxZin/GyCevWEsDI8rSaU8BZ0gNR73OwCa5KeUvoOwevdRCqY3SdQjJx823QJLg1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781367919; c=relaxed/simple;
	bh=OgriboyLGBq1OvYCDbQzdpIjXmH4ZidnQhMNU3HNkHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FRn9B/76NLF2KjiaLtgjE6qApTKwZR5WgxEMwRAytP4LWsz3d3foNDCuKjftS78BE8YJRjpvoNB8fjOyPnynz0Jz7PN+QPcHP0zz4fDzlKxlXsRA+E7kgGZykWEkktd3ngPWl93yEZqFwRrUEsvIjLRVp84cG65DQEBATdD1Fqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l6+5jb+b; arc=none smtp.client-ip=91.218.175.173
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781367905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ImC2eKAv7X6MMI3LOcfOOKpY8B6ljjxgZ9VIjTi7C4k=;
	b=l6+5jb+buF7AKHTZk0+70TrkdYkowlgEybabSdGvrERVuWcexnjkAFg8ol0utvGdGsgkcM
	6HvWuJrMtUiZqBZXxS+/rhWmSL6Mo7m8n7d0SPc8BHL5U/P75GLwUx85yPlZNQLT9bvX9R
	pCGK6be/SK7TsE09PEYMwz63Bgq727E=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v4 0/2] bpf: Fix bpf_get/setsockopt to tos for ipv4-mapped ipv6 socket
Date: Sun, 14 Jun 2026 00:24:41 +0800
Message-ID: <20260613162443.60515-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298983-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:leon.hwang@linux.dev,m:ihor.solodrai@linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:kernel-patches-bot@fb.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,vger.kernel.org,fb.com];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20B0C67F0F5

When TCP over IPv4 via INET6 API, sk->sk_family is AF_INET6, but it is a
v4 pkt. inet_csk(sk)->icsk_af_ops is ipv6_mapped and use ip_queue_xmit.
The tos sockopt does not work for bpf [get,set]sockopt() helpers.

Changelog:
v3 -> v4:
* Add 'sk->sk_type != SOCK_RAW && !ipv6_only_sock(sk)' check.
* Re-implement test with LLM assistance.
* v3: https://lore.kernel.org/all/20240914103226.71109-1-zhoufeng.zf@bytedance.com/

v2->v3:
* Use sk_is_inet() helper. (Eric Dumazet)
* https://lore.kernel.org/bpf/CANn89i+9GmBLCdgsfH=WWe-tyFYpiO27wONyxaxiU6aOBC6G8g@mail.gmail.com/T/

v1->v2:
* Fix compilation error. (kernel test robot)
* https://lore.kernel.org/bpf/202408152058.YXAnhLgZ-lkp@intel.com/T/

Leon Hwang (2):
  bpf: Fix bpf_get/setsockopt to tos for ipv4-mapped ipv6 socket
  selftests/bpf: Add test to verify the fix for bpf_setsockopt() helper

 net/core/filter.c                             | 15 +++-
 .../selftests/bpf/prog_tests/setget_sockopt.c | 78 +++++++++++++++++++
 .../selftests/bpf/progs/setget_sockopt.c      | 23 ++++++
 3 files changed, 115 insertions(+), 1 deletion(-)

-- 
2.54.0


