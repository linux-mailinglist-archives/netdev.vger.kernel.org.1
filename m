Return-Path: <netdev+bounces-281200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMEnMXup7mkSwgAAu9opvQ
	(envelope-from <netdev+bounces-281200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 02:10:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 719B246B9CE
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 02:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46923300CC03
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 00:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898CB3BB40;
	Mon, 27 Apr 2026 00:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O/hAJjn/"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002CF28686
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777248630; cv=none; b=tzexrAYrE06kM2wIyNS4kDCfgQ/P3qxHTBq6nYiiPkB0il3GGJJICRUb306ctZSfF0qPzYWEu000KGTtOXfluKeSO7S1s2rSWqxddj720SwFLh76uW7xfKKhAi5qykmfcsIy904YTf4c2E1iBXOotkYcx1GEUtLJ/ZXHV12NVeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777248630; c=relaxed/simple;
	bh=1iqpYUjPxCslxVvz08rQIpDZ4UUph8rg3YRDpowLMDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kKFjcq/Hu2DeeSUHVlL2b8Gzy2AhV0rXTF97fQTiW2t+RQAQ5Z3+dROeA8mpw6BBlTQbp3mu4sXvEayEDquhVU0+U+Fo72dfq2loSD+LZfIVEMvE72QrE4IJ3nrW8rTzQ9I0rUxbFnOK38T5+He9ekLAmm5mL8NQOQSsaINiACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O/hAJjn/; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777248616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S+QDUFY9BA6jffJdEkCL/a8joX4lzutnF6V5ZZQZTgw=;
	b=O/hAJjn/0NY4QDZQF50+9ZkYhlr1X5a8cEwtoGzN7oLr2el2jzMk65sB4ghXU2IUXSTNE9
	kwJ5lyyMeYhhAXQC461HHuTlNvcbvNdz+Wx412x9yE1sLOEPtjark8x/489wn5x+W0tzLw
	+6JC2XjTSg34QCXaodFTMAsq2WbnT1U=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 0/2] bpf,net: add missing custom syncookie statistics and add selftest
Date: Mon, 27 Apr 2026 08:09:49 +0800
Message-ID: <20260427001006.14465-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 719B246B9CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,google.com,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281200-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

v2 was reviewed on net-next; per Martin's request the series is
re-targeted at the bpf-next tree's net branch (bpf-next/net) so
both patches can land together via the BPF tree (the selftest
touches BPF selftest helpers). No code changes vs. v2 beyond the
nits below.

For context, the series accounts BPF custom syncookie validation
in the LINUX_MIB_SYNCOOKIES{RECV,FAILED} SNMP counters (with a few
related cleanups in the cookie_bpf_* config guards), and adds a
selftest that verifies the counters move as expected.

v2: https://lore.kernel.org/netdev/20260411013211.225834-1-jiayuan.chen@linux.dev/T/#m9c0ccc349fbed908e2cf34ce34ebd45b6f747b07

---

Changelog
=========
v2 -> v3:
  - Retarget bpf-next/net (Martin).
  - 1/2: fix typo and rationale in commit message — the removed
    guard is CONFIG_BPF, not CONFIG_BPF_SYSCALL, and the reason is
    that the guard is a no-op under CONFIG_NET, not a build-failure
    risk (Martin).
  - 2/2: keep reverse xmas tree order in create_connection()
    (Kuniyuki).
  - Add Reviewed-by from Kuniyuki on both patches.

Jiayuan Chen (2):
  net: add missing syncookie statistics for BPF custom syncookies
  selftests/bpf: verify syncookie statistics in tcp_custom_syncookie

 include/net/tcp.h                             |  7 +++---
 net/ipv4/syncookies.c                         | 10 ++++++---
 net/ipv6/syncookies.c                         |  2 +-
 tools/testing/selftests/bpf/network_helpers.c | 22 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 .../bpf/prog_tests/tcp_custom_syncookie.c     | 20 +++++++++++++++++
 6 files changed, 54 insertions(+), 8 deletions(-)

-- 
2.43.0


