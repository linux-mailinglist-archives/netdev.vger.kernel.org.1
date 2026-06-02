Return-Path: <netdev+bounces-294263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ur1uBm70HmpFaAAAu9opvQ
	(envelope-from <netdev+bounces-294263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 17:19:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E30662FAEE
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 17:19:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="Npe/dR64";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294263-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294263-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 477F83045A87
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 15:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14C63E9C1C;
	Tue,  2 Jun 2026 15:10:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277C73E8324;
	Tue,  2 Jun 2026 15:10:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413003; cv=none; b=L6WNQO/x+40lFUfvKCM6SaxUx1aB/K5JC89M7QOnFooAeWu6Gs1Ea5jWR7ZT+LxUu2ieYq+nL+Rzbt86TejU9txYS6OMkAwAfdIifl4ly0pws8bLtJgChfJQivfpfnJJk8jVtA5pVtU5ihyyPUZknkHuZ4iJPjJajQuLU2wXAxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413003; c=relaxed/simple;
	bh=w26jlU7AlDxBkU/LbVYLr5daAv3N+igx0ToB78RJA10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D/I3g+dt6ljm8j8YnuS6oiG36jj0w4xo1np0+IWlz3LQhzToTS+YDgG30X1O54qDIBh110t2vCn6domf15zeVWgLzljfykH9HNyby6P25QEfX9MidtZFauZFcqS7iy6ErtXirepBX+77QX1DhI+J+yAqPqR0F3+nAHMmrbJZvaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Npe/dR64; arc=none smtp.client-ip=95.215.58.174
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780412999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yd7cjfqgJSxWKsvypPDqtqk8j3AuHYYfVHvdf66ah/s=;
	b=Npe/dR64U4TFfPw17NdPJbRWQnT0bAOeV4RMLVkQ3NdnRshRLLxuVqr2rZO7Dw3VoeHqbS
	W1ZTM6sqBZJkAqOf2AC4T7dhUWlojMQA6DmNb9QdUl9VylVjWFPz/g9iOp2U+deSL6Zqfv
	29HD+vX/gL5lxQkEzYvlDXPmoUgI2ro=
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
Subject: [PATCH bpf v4 0/2] bpf: Update transport_header when encapsulating UDP tunnel in lwt
Date: Tue,  2 Jun 2026 23:09:29 +0800
Message-ID: <20260602150931.49629-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,linux.dev,nvidia.com,suse.de,vger.kernel.org,fb.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294263-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:gnault@redhat.com,m:leon.hwang@linux.dev,m:idosch@nvidia.com,m:fmancera@suse.de,m:posk@google.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:kernel-patches-bot@fb.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:from_mime,linux.dev:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E30662FAEE

Currently, bpf_lwt_push_ip_encap() does not update skb->transport_header.
When a driver, e.g. ice, reuses the stale skb->transport_header to
offload checksum computation to NIC hardware, VxLAN packets encapsulated
by bpf_lwt_push_encap() helper may be dropped due to incorrect checksum.

Update skb->transport_header in bpf_lwt_push_ip_encap() whenever the
encapsulated packet uses UDP, so checksum offload works correctly.

Changes:
v3 -> v4:
* Address comments from Emil:
  * Make the logic of skb_set_transport_header() clearer in patch #1.
  * Fold the code of fexit_lwt_push_ip_encap() into test_lwt_ip_encap.c in
    patch #2.
  * Resolve assorted issues of test in patch #2.
* v3: https://lore.kernel.org/bpf/20260601150203.20352-1-leon.hwang@linux.dev/

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

 net/core/lwt_bpf.c                            |  12 ++
 .../selftests/bpf/prog_tests/lwt_ip_encap.c   | 145 ++++++++++++++++
 .../selftests/bpf/progs/test_lwt_ip_encap.c   | 155 ++++++++++++++++--
 3 files changed, 302 insertions(+), 10 deletions(-)

-- 
2.54.0


