Return-Path: <netdev+bounces-293799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEaYAi6gHWqncgkAu9opvQ
	(envelope-from <netdev+bounces-293799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:07:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8BE621592
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 17:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 889BF3086151
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 15:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D6C3D7D87;
	Mon,  1 Jun 2026 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wf9x7CW9"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31003D75B9;
	Mon,  1 Jun 2026 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326179; cv=none; b=DtixW8O+B4baX4r6h2lkze8Z1faT7alPbEj5sT4IymiU0igLOsWg7Gk3VENYTJH23whUJ9IBQOMYST9YxLwV+EVeQT6+hos9SF4O+u37cJBGYjWcvL0TWb7ud4GYADAzNfDJ+eoApXnu3H30RdE1hC8gm1aXT0VDUZMcQQA6ZuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326179; c=relaxed/simple;
	bh=wi4uhkHTWPvW3vtOQi3U5Uu+t3OBcXcFzrWJpvUCSxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aUPuMDw63CoPCGEl+etYFbeBYVWx5bOj/eFHqZWaErZwA3h0bmpVntH6z6z6f19YDFwcz/pTKhVXrvI2X/mPGW5OJxdPFD/fP62z2INz0RDXXrYFT/nhHrp5mGkJIyjwx6xoJem6jMqLnrb6VzfVeWdwfi5GPpSufzJVLhSbv7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wf9x7CW9; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780326165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7ZoYADBK9XZFEaglIzgjbTAZy+ZzDPXzGK/FiK5cnTo=;
	b=wf9x7CW9ZbRShz2Ok32SwBJqzI+YJWVKA3sdoULQu23tDiJ7z9Rel1wKHUilB7fDQYOFkJ
	5xVkMU+2ukQ09fQc8WK7rNQKAxcRJZGVYtsdf6PC1z/hzQhAebIwm9iM4IvhgcI62Ta1v4
	xKlMqm+G+tIjL/AMon2Yngu6E4V+M54=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Ido Schimmel <idosch@nvidia.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Peter Oskolkov <posk@google.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf v3 0/2] bpf: Update transport_header when encapsulating UDP tunnel in lwt
Date: Mon,  1 Jun 2026 23:02:01 +0800
Message-ID: <20260601150203.20352-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,linux.dev,nvidia.com,suse.de,vger.kernel.org,fb.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293799-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6B8BE621592
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, bpf_lwt_push_ip_encap() does not update skb->transport_header.
When a driver, e.g. ice, reuses the stale skb->transport_header to
offload checksum computation to NIC hardware, VxLAN packets encapsulated
by bpf_lwt_push_encap() helper may be dropped due to incorrect checksum.

Update skb->transport_header in bpf_lwt_push_ip_encap() whenever the
encapsulated packet uses UDP, so checksum offload works correctly.

Changes:
v2 -> v3:
* Drop patch #1 and #2 of v2 that aim to resolve potential issues
  reported by sashiko (per Alexei).
* Check target IP version and UDP tunnel in test (per sashiko).
* v2: https://lore.kernel.org/bpf/20260529151351.69911-1-leon.hwang@linux.dev/

v1 -> v2:
* Address sashiko's reviews:
  * Fix TOCTOU issue in lwt to avoid changing hdr after checks.
  * Add check iph->ihl < 5 in lwt to avoid infinite-loop in MIPS driver.
  * Update comment style in selftests with BPF comment style.
* v1: https://lore.kernel.org/bpf/20260525142650.2569-1-leon.hwang@linux.dev/

Leon Hwang (2):
  bpf: Update transport_header when encapsulating UDP tunnel in lwt
  selftests/bpf: Add tests to verify the fix of encapsulating VxLAN in
    lwt

 net/core/lwt_bpf.c                            |  11 ++
 .../selftests/bpf/prog_tests/lwt_ip_encap.c   | 164 ++++++++++++++++++
 .../selftests/bpf/progs/test_lwt_ip_encap.c   | 112 ++++++++++++
 .../bpf/progs/test_lwt_ip_encap_fix.c         |  44 +++++
 4 files changed, 331 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_lwt_ip_encap_fix.c

-- 
2.54.0


