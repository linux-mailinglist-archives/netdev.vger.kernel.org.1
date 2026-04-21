Return-Path: <netdev+bounces-280179-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOkMOy2g52nw+QEAu9opvQ
	(envelope-from <netdev+bounces-280179-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 18:05:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC9743D1ED
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 18:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A346308DC04
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688AF364021;
	Tue, 21 Apr 2026 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rgn6Z7U/"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FC52E2286
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776787159; cv=none; b=jlaCquQgafIJsUeDhJryDnopuIOrqiCoiLNxHi6RrpYGWMmpjyZIUY2u8OGbrmM+Xvc0d4F48rn3Kua6DQ3dk9KuJbb0ZFQwovPFI26g2hOCMDy5h1vfiRQBPMKPQ3cQzrDsG0PsKUF2C6HtFg+aFGN6NtgqfSLLjabbKfy7DWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776787159; c=relaxed/simple;
	bh=k6+jasbC8ffBzSw2C6ofjZu8PltLDxN6zHPlBDQJS7A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sXsQ8hJ9joG5g+nbcEDFVPpCA0IAXYnHsN6uWizdJhgFyVatnQt7CMb2LcnJ7sC70wqX12iGMonnECdJhJwYsLKdvdANwiQs7B6vjMKnO78mmCuFQzAANbnBX3h1xyBSB/PdJi2532GhVrkgbiPALvvNzyJR5FFfnJt+d2Wl+aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rgn6Z7U/; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776787145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+aOQ3Xw/RZsMMWfJ+rkdu/KGc82gkMlhZ8lAN8cJ7wE=;
	b=Rgn6Z7U/ep50s2sSwEmPX+H6pBOF1dVOqSD+yEIoouTNOPZ/4dOR+LdqWKRwkhmPU4iOuu
	dmdF64UUquroRvHI1Ru2Z8Y/otfetGt84RzlBFzvxGuEezxFgQYiMdf6rh/fJv3S8DUR+V
	v9kk1rlOeOc3sZSh1hj8RTLsMT5ZuA0=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	shuah@kernel.org,
	ihor.solodrai@linux.dev,
	kafai.wan@linux.dev,
	jiayuan.chen@linux.dev,
	hoyeon.lee@suse.com,
	ameryhung@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 0/4] bpf: Reject TCP_NODELAY in TCP header option
Date: Tue, 21 Apr 2026 23:58:00 +0800
Message-ID: <20260421155804.135786-1-kafai.wan@linux.dev>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280179-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,davemloft.net,google.com,redhat.com,suse.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kafai.wan@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_TWELVE(0.00)[27];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 4AC9743D1ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This small patchset is about avoid infinite recursion in TCP header option callbacks
and bpf-tcp-cc callbacks via TCP_NODELAY setsockopt.

v4:
 - Fix the test case for TCP header option callbacks (Martin and Jiayuan)
 - Reject TCP_NODELAY in bpf-tcp-cc callbacks (AI and Martin)
 - Add a test case for bpf-tcp-cc

v3:
 - Remove CONFIG_INET check and add comment (Martin and Jiayuan)
 - Fix the test case (Martin)
 https://lore.kernel.org/bpf/20260417092035.2299913-1-kafai.wan@linux.dev/

v2:
 - Reject TCP_NODELAY in bpf_sock_ops_setsockopt() (AI and Martin)
 https://lore.kernel.org/bpf/20260416112308.1820332-1-kafai.wan@linux.dev/

v1:
 https://lore.kernel.org/bpf/20260414112310.1285783-1-kafai.wan@linux.dev/

---
KaFai Wan (4):
  bpf: Reject TCP_NODELAY in TCP header option callbacks
  bpf: Reject TCP_NODELAY in bpf-tcp-cc
  selftests/bpf: Test TCP_NODELAY in TCP hdr opt callbacks
  selftests/bpf: Verify bpf-tcp-cc rejects TCP_NODELAY

 include/linux/bpf.h                           |  1 +
 net/core/filter.c                             | 30 +++++++++++++++++++
 net/ipv4/bpf_tcp_ca.c                         |  2 +-
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  4 +++
 .../bpf/prog_tests/tcp_hdr_options.c          |  6 ++++
 tools/testing/selftests/bpf/progs/bpf_cubic.c | 12 ++++++++
 .../bpf/progs/test_misc_tcp_hdr_options.c     | 15 +++++++++-
 7 files changed, 68 insertions(+), 2 deletions(-)

-- 
2.43.0


