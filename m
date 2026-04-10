Return-Path: <netdev+bounces-277353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBeFCHni2GnHjAgAu9opvQ
	(envelope-from <netdev+bounces-277353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:43:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F863D64ED
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F1C030A1967
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71103A1E9B;
	Fri, 10 Apr 2026 11:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U+wMO9WA"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E40B39DBC1
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775821083; cv=none; b=QEFuudN8QxQ8u5bpeshM2M/imIELwTwGFtn2MfMLULE82CXFcUd3jns563fCvQJZu5qiB4cvNCaOmhHouPNuUenHzK5uqerg6JURSlUTxTtf1KCjw96uuErTNbL7fnS8OKS0tVUcJW+rBZOlOQeR51yNXwZ7O4kd+b0oyqT70nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775821083; c=relaxed/simple;
	bh=1dX4uXwGzRHChAqZIKUJnts7+cVmhDPfr4wixNUYVkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CN/W/++o8WKFWFMa1u4CRIR9PaqycF2CWmeUuoCfIdeWN6o4Z0XZSIjBP4pCR+xoTWRKUWFZEarigcEjNuhb5FIZK1homha3dDmelBd23AGoiPM9/jcH5FDllehjvwqFX380BIvHThQFilpNWiI80ZhaBCg1veXMlcUz0zB4674=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U+wMO9WA; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775821070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KeqZvV+Oy9FQiiKRUD3VowmUdxbmTHkCnn/4hwZRALo=;
	b=U+wMO9WATDP9BfWiPwhR7iA5Nd5PfmBagdYVXBnjUUg5GTlNgvvs9+8klD9yhrYRFER/Qv
	mjvMWlD3UrS3t4CNun37TbB3HwUNtfJ+dV6dnknl7ayAxNv/87zDo/BjN8XJipQLYeFC3a
	TzXfV6JdAz6fbfqxBWEZvyY1sPe8K+Y=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jussi Maki <joamaki@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v6 0/2] net,bpf: fix null-ptr-deref in xdp_master_redirect() for bonding and add selftest
Date: Fri, 10 Apr 2026 19:37:21 +0800
Message-ID: <20260410113726.368111-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[shopee.com,linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-277353-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,shopee.com:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 77F863D64ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiayuan Chen <jiayuan.chen@shopee.com>

This series has gone through several rounds of discussion and the
maintainers hold different views on where the fix should live (in the
generic xdp_master_redirect() path vs. inside bonding). I respect all
of the suggestions, but I would like to get the crash fixed first, so
this version takes the approach of checking whether the master device
is up in xdp_master_redirect(), as suggested by Daniel Borkmann. If a
different shape is preferred later it can be done as a follow-up, but
the null-ptr-deref should not linger.

syzkaller reported a kernel panic, full decoded trace here:
https://syzkaller.appspot.com/bug?extid=80e046b8da2820b6ba73

Problem Description

bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NULL
check. rr_tx_counter is a per-CPU counter that bonding only allocates
in bond_open() when the mode is round-robin. If the bond device was
never brought up, rr_tx_counter stays NULL.

The XDP redirect path can still reach that code on a bond that was
never opened: bpf_master_redirect_enabled_key is a global static key,
so as soon as any bond device has native XDP attached, the
XDP_TX -> xdp_master_redirect() interception is enabled for every
slave system-wide. The path xdp_master_redirect() ->
bond_xdp_get_xmit_slave() -> bond_xdp_xmit_roundrobin_slave_get() ->
bond_rr_gen_slave_id() then runs against a bond that has no
rr_tx_counter and crashes.

Solution

Patch 1: Fix this in the generic xdp_master_redirect() by skipping
master interception when the master device is not running. Returning
XDP_TX keeps the original XDP_TX behaviour on the receiving slave, and
avoids calling into any master ->ndo_xdp_get_xmit_slave() on a device
that has not fully initialized its XDP state. This is not specific to
bonding: any current or future master that defers XDP state allocation
to ->ndo_open() is protected.
Patch 2: Add a selftest that reproduces the above scenario.

Changes since v5:
https://lore.kernel.org/netdev/20260309030659.xxxxx-1-jiayuan.chen@linux.dev/
- Moved the fix back into xdp_master_redirect() and use netif_running()
  on the master device to decide whether to intercept
  (Suggested by Daniel Borkmann, seconded by Paolo Abeni and Eric Dumazet)

Changes since v4:
https://lore.kernel.org/netdev/20260304074301.35482-1-jiayuan.chen@linux.dev/
- Reverted unconditional alloc in bond_init(); instead add a NULL check
  with unlikely()/READ_ONCE() in bond_rr_gen_slave_id() and WRITE_ONCE()
  in bond_open(), avoiding memory waste for non-RR modes
  (Suggested by Nikolay Aleksandrov, patch by Jay Vosburgh)

Changes since v3:
https://lore.kernel.org/netdev/20260228021918.141002-1-jiayuan.chen@linux.dev/T/#t
- Added code comment and commit log explaining why rr_tx_counter is
  allocated unconditionally for all modes (Suggested by Jay Vosburgh)

Changes since v2:
https://lore.kernel.org/netdev/20260227092254.272603-1-jiayuan.chen@linux.dev/T/#t
- Moved allocation from bond_create_init() helper into bond_init()
  (ndo_init), which is the natural single point covering both creation
  paths and also handles post-creation mode changes to round-robin

Changes since v1:
https://lore.kernel.org/netdev/20260224112545.37888-1-jiayuan.chen@linux.dev/T/#t
- Moved the guard for NULL rr_tx_counter from xdp_master_redirect()
  into the bonding subsystem itself
  (Suggested by Sebastian Andrzej Siewior <bigeasy@linutronix.de>)

[1] https://syzkaller.appspot.com/bug?extid=80e046b8da2820b6ba73

Jiayuan Chen (2):
  net, bpf: fix null-ptr-deref in xdp_master_redirect() for down master
  selftests/bpf: add test for xdp_master_redirect with bond not up

 net/core/filter.c                             |   2 +
 .../selftests/bpf/prog_tests/xdp_bonding.c    | 101 +++++++++++++++++-
 2 files changed, 101 insertions(+), 2 deletions(-)

-- 
2.43.0


