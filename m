Return-Path: <netdev+bounces-301537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fxFEBoxJO2pKVggAu9opvQ
	(envelope-from <netdev+bounces-301537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 05:05:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BCE6BB03F
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 05:05:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KRzBYztp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301537-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301537-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31C14302206B
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 03:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0314A303A35;
	Wed, 24 Jun 2026 03:05:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56FB2F531B
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 03:05:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782270344; cv=none; b=dPtB4eVMSLyKzHxSVLQXtAgGMxS115AICArRJQR+UTtBcK6N0zwiz0yBS+C3TQORitF/zy400uTbbT2NhHN84feirhlVsQiRsNIJSmRHujLIJHKbhEXwzmNDUOuo07I52C7XdVUhZQoYKiMkyuQ0jbPNVIv1U84rouwChUpErmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782270344; c=relaxed/simple;
	bh=UkOS4Zij6j47d8xWr8CqnA6kmSLbAZgrAlBfbN4T7y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qDpa/ddjDlmsSOIRKVs+PqvmBOg2Iz/B6OSXND/r7iPS9YqYjj5h/aKrrz3PySt3hk104C/F+WLqeIO8dQWRzPsS6fvIYwBxhR9ai/ePHlcpHkjq+r/zvg8GU7sq3MYO19Hfu1PNellxB72A2ay+9HZ3YETZ8i19WnAxQSmil/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRzBYztp; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c77d52bec4so10139215ad.1
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 20:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782270343; x=1782875143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BbdGJn9JmuxiPTTq09yI7QrKKiSHAVg6js7lpX16usU=;
        b=KRzBYztpv4IwdLgtSVWmRumi4sDjafdTRv5xsYjiTA0wWCVYBWCJVxVileX/VQXfpH
         e1zziuvOixQkH9PmcjJV5KJC9f7nyt/tKRNb4oz5IH16TE6kkBa/1a4f7k0tV2swYNHw
         keg3J/ZA6WJwi4jgUrDcPq1ec36OZanKIQeQYNy3+RmZS53p6exuGpsXC50KSXERP5rw
         jIPQFW8h77VxpygmNDRZtNn64ff+OgXRjBiUeSPE+IFw3UDHsiEXBSbH7iDB4+vrFTXT
         UOVGFzFUn5EQnc6iexUzIB+KtomLy9A1VQbSU3ywLU2b94RVMmJnnheKJahjOor4T2uz
         7gxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782270343; x=1782875143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbdGJn9JmuxiPTTq09yI7QrKKiSHAVg6js7lpX16usU=;
        b=VuaHx5QY98Hocf6oGNyhOCqviwuMssTSrJP6gaC95c9sK+MTHJQ/WuAZfyeFwdL9XY
         x+xW6fVRWYzQQlp35+iTdtdLnox/D2OvIxj4V5/qRAZak7Lgz8uaVJuw+2Jsw6tCSj4p
         64aMOc7/PpblPJnigdvc5Hit5tgL5b9vE2sVFhycp4HvyVmRsOGAN/AYHyGytzJd3MI4
         fnCUOAS0kKn521ivc0uTCA9ROY0HdBJefuz8Zc6m6UjkQASjUTG4j54pSszoOK4lnZnZ
         jdzSTLYxS+P1RpbamaNKbFOf5TgLR6drvJv19BiOeai4TOS4jnqbzgU6GIVZfZT/ziuw
         Vrzg==
X-Forwarded-Encrypted: i=1; AHgh+RoCgbXQ8FIKsksitreCkQFDHAz12Yw0OCzlQ0PuZF3v2zztz9yqmP/buBaoaOixuwOfo0RDAa4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+DfWLiA1UPmFGhN+QmiBit+cXLnSMsbpnOGH/JVabrWKTZxG6
	5pP1SzKX2/ePNec6sv7JL3Y3Tu2z8xo/5URJ9zzdhlnMxz6kItiB01gP
X-Gm-Gg: AfdE7ckTsYPPiv6ClHX2LOn1mJg5ybtcg3s5sEYf8gXwwJ7+fj3srB7Ywa3ft6SjsXg
	s8LMlpKz2Ec35psbJ0UJXOJZLsgk9xtxFFIFn9Vdxs/EnCj3uJ57sW+nKZ6tYorbg5vKznkuY9V
	gWzYM0CuNoB0qQmZTURatorZg3vnnijv49Xuepv6vgNGG2XCFtOwMEgQLxrLbaZy47HRzQu2LfJ
	YNqqe2/bLOdjke6U3Nq36RwnWPvtgI+LRtU5VyGKbUIDOHPwrJtkUqSwitWp9r16hVVfnvl8aCO
	vx1H65c5q6CkMXRGmZxPVpRzmBusycAb5MpEHGPD+Hpj0z126vRs8sMVKuJvtYd6+EamEthbZt6
	8RKC3D3UEFiIQ5hPHdAOwYOxzQkkVFVm+HGQB3lGCVoeoQZlYt8WPj/Cju1ft1bYqffxzwTHSNg
	pO7pvEl9CGdYpVJ02i5rftB188pgesOTHs9BFQSkTQmhm9BBd7gvJzXyWGpNDv
X-Received: by 2002:a17:903:fa6:b0:2c1:6ed:513b with SMTP id d9443c01a7336-2c7c3eea98bmr53061155ad.16.1782270342806;
        Tue, 23 Jun 2026 20:05:42 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436d6c16sm122243995ad.23.2026.06.23.20.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 20:05:41 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	yatsenko@meta.com,
	leon.hwang@linux.dev,
	kpsingh@kernel.org,
	a.s.protopopov@gmail.com,
	ameryhung@gmail.com,
	rongtao@cestc.cn,
	eyal.birger@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	toke@redhat.com,
	dsahern@kernel.org
Subject: [PATCH bpf-next v5 0/3] bpf: bidirectional VLAN support for bpf_fib_lookup()
Date: Wed, 24 Jun 2026 08:35:27 +0530
Message-ID: <20260624030530.3342884-1-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301537-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:rongtao@cestc.cn,m:eyal.birger@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:toke@redhat.com,m:dsahern@kernel.org,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 66BCE6BB03F

This series adds VLAN awareness to bpf_fib_lookup() in both directions.
BPF_FIB_LOOKUP_VLAN resolves a VLAN egress to its underlying real device
plus the VLAN tag (XDP programs need this because VLAN devices have no XDP
xmit), and BPF_FIB_LOOKUP_VLAN_INPUT runs the lookup as if a tagged frame
had arrived on the matching VLAN subinterface, for iif policy routing and
VRF table selection.

The independent l3mdev/VRF flow-init fix, patch 1 in v1 and v2, was split
out and merged to bpf separately.

An unreducible VLAN egress (a QinQ egress, or a parent in another
namespace) returns BPF_FIB_LKUP_RET_VLAN_FAILURE rather than a best-effort
SUCCESS, so an XDP program cannot mistake it for a physical egress and
silently blackhole the frame at xdp_do_flush(). The code is appended after
BPF_FIB_LKUP_RET_NO_SRC_ADDR (nothing renumbered, tools/ mirror updated)
and is returned only when BPF_FIB_LOOKUP_VLAN is set, so no existing caller
can observe it. On that failure params->ifindex is left at the input; a
program that wants the VLAN device's own ifindex re-issues without the flag.

Changes v4 -> v5 (Toke's review,
https://lore.kernel.org/bpf/87y0g5ca7x.fsf@toke.dk/):

- Patch 1: BPF_FIB_LOOKUP_VLAN only makes sense for XDP, which cannot
  redirect to a VLAN device; a tc program can redirect to the VLAN device
  directly. So bpf_skb_fib_lookup() now rejects the flag with -EINVAL, and
  the fwd_dev out-parameter added in v4 is dropped: with the flag gone from
  the skb path there is no swap to preserve, so the deferred mtu check
  returns to the original dev_get_by_index_rcu(net, params->ifindex). The
  VLAN_FAILURE rewind moves into bpf_fib_set_fwd_params() via an input
  ifindex parameter, so each lookup ends in a plain
  "return bpf_fib_set_fwd_params(...)". The early params->ifindex =
  dev->ifindex that NO_NEIGH and NO_SRC_ADDR report stays where
  d1c362e1dd68a ("bpf: Always return target ifindex in bpf_fib_lookup") put
  it. Dropping fwd_dev also removes the i386 W=1 unused-variable warning the
  kernel test robot reported, since net is used again.

- Patch 2: no code change; add Toke's Reviewed-by.

- Patch 3: the BPF_FIB_LOOKUP_VLAN cases assert the tc helper returns
  -EINVAL and check the egress result on the XDP path, including dmac and
  (for tot_len cases) the route mtu_result; the cross-netns egress case
  runs through bpf_xdp_fib_lookup(); the obsolete skb-mtu-after-swap arm is
  dropped.

Changes v3 -> v4:

- Patch 1: return BPF_FIB_LKUP_RET_VLAN_FAILURE for an unreducible VLAN
  egress, leaving params->ifindex at the input, per Toke's v3 review.

- Patch 3: QinQ-egress and cross-namespace-egress arms expect VLAN_FAILURE;
  an escape-hatch arm re-issues without the flag; and a live-frames arm
  asserts a reducible egress is delivered and a QinQ egress is passed to
  the stack.

Taking the tag as lookup input follows the approach David Ahern suggested
in the 2021 fwmark discussion:
https://lore.kernel.org/bpf/6248c547-ad64-04d6-fcec-374893cc1ef2@gmail.com/

v4: https://lore.kernel.org/all/20260623025147.1001664-1-avinash.duduskar@gmail.com/
v3: https://lore.kernel.org/all/20260617224729.1428662-1-avinash.duduskar@gmail.com/
v2: https://lore.kernel.org/all/20260616223426.3568080-1-avinash.duduskar@gmail.com/
v1: https://lore.kernel.org/all/20260609172052.81613-1-avinash.duduskar@gmail.com/

Avinash Duduskar (3):
  bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper
  bpf: Add BPF_FIB_LOOKUP_VLAN_INPUT flag to bpf_fib_lookup() helper
  selftests/bpf: Add bpf_fib_lookup() VLAN flag tests

 include/uapi/linux/bpf.h                      |  50 +-
 net/core/filter.c                             |  97 ++-
 tools/include/uapi/linux/bpf.h                |  50 +-
 .../selftests/bpf/prog_tests/fib_lookup.c     | 717 +++++++++++++++++-
 .../testing/selftests/bpf/progs/fib_lookup.c  |  36 +
 5 files changed, 936 insertions(+), 14 deletions(-)


base-commit: a975094bf98ca97be9146f9d3b5681a6f9cf5ce3
-- 
2.54.0


