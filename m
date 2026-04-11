Return-Path: <netdev+bounces-277632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yENkHE+c2Wk3rQgAu9opvQ
	(envelope-from <netdev+bounces-277632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 02:56:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF50E3DDC83
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 02:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6A5B3048F29
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 00:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9B22DEA6B;
	Sat, 11 Apr 2026 00:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qezc6sNQ"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960472DC76C
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 00:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775868980; cv=none; b=PjJXB+mqTb2Q0NfJ798KOKW/AJUPee+KiQbtPh0u7GW6VJMnUkndjl/2zKknSBEhJJqjvp7HlfrgOH0bWLuXqfx6VgQNcu44PmyfEwAYIMpKDklYMJgGqLiNomRjBRe8ehL5hip3DjooX4Cma/x9PsH7izy9YH6z3YClpVXkp9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775868980; c=relaxed/simple;
	bh=UhPSy4/fYWFce1bfD0ev/eMwNHEg8KlSDVFosOxJ3fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jVxKL7gUDjSNKsywdJTVU8P1qEjtG5X69FLT/oUzCq+tmgrsmHTGj7dH9VdWbdvNE81/DE7IWUasxwhetj2r3i+7ORkIiDpGoBMPVEmzVYl299HbCU68mh9yirY8F6cJWLoV9KhxsDbFDEgrATpRQcTKXWhluliMdCFKhJkxY+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qezc6sNQ; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775868966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+rNhtKG0xmkmJ2NDX0q52BAZOuiro8T9jp4DQQcDi/Q=;
	b=qezc6sNQmJe1dqqayCHSuJr7eDFEpTZCp8YePETtpJlFlhWTDulKSZg5qtzsJl0sDb81sM
	ksecNx0Z/Nh8wuL4bp9jWP/BAZmzO+0mFPPiowWz1vmCDg3hNMpZrO2M6gtee5kykTorUy
	2XLjGaAM/TsD3LAktt82w3dmM0QZ/zs=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
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
Subject: [PATCH net v7 0/2] net,bpf: fix null-ptr-deref in xdp_master_redirect() for bonding and add selftest
Date: Sat, 11 Apr 2026 08:55:18 +0800
Message-ID: <20260411005524.201200-1-jiayuan.chen@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[shopee.com,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-277632-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,shopee.com:email,linux.dev:dkim,linux.dev:mid,linutronix.de:email]
X-Rspamd-Queue-Id: DF50E3DDC83
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

Changes since v6:
https://lore.kernel.org/netdev/20260410113726.368111-1-jiayuan.chen@linux.dev/T/#t
- selftest: drop the redundant ASSERT_GE checks on bpf_program__fd()
  and inline the fd into the bpf_xdp_attach() call
  (Suggested by Daniel Borkmann)
- patch 1: add Acked-by from Daniel Borkmann

Changes since v5:
https://lore.kernel.org/netdev/20260309030659.xxxxx-1-jiayuan.chen@linux.dev/
- Moved the fix back into xdp_master_redirect() and check IFF_UP on the
  master device; return XDP_ABORTED when the master is not up
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

 net/core/filter.c                             |  2 +
 .../selftests/bpf/prog_tests/xdp_bonding.c    | 96 ++++++++++++++++++-
 2 files changed, 96 insertions(+), 2 deletions(-)

-- 
2.43.0


