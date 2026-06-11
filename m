Return-Path: <netdev+bounces-298118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5C7JDNGsKmoyuwMAu9opvQ
	(envelope-from <netdev+bounces-298118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:40:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD47671EEE
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:40:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=uXNsy4+K;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298118-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298118-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9762330D1CF9
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595A93F8ED8;
	Thu, 11 Jun 2026 12:38:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE04E3F7A94
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 12:37:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181480; cv=none; b=YlR6gT2H4kymh3ym2Y6KFRBGcHMpmTJIzxQaHx1+qaVkMBjVdasTbp/LQFBwpmeWHH17IQLVQ4U81vjH4YiyfK5wfHo7sB2FjRAkHX+YGaEVE8wVlGOfeDEe79s+q+Pr1iDfS/tgC0Cunc0flOpbpQAZb/B9O+Xvomr4GpnNpm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181480; c=relaxed/simple;
	bh=Mz/dtjJFB8K7mJFgV3aWCEtTQaLdZpwGy4k7t9rfP/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFNZ1M46MSo4uAzCpR/pPSaZ9qGrPNJwRGnlMR3qmWoUfhK82INVYw41RYj1x6snMZVOiLWCTL89HzVZ1dz2kKIrfg/KtwshqANlLhqqQqhKUkFU6nuJfZzmYJJ3EssFNM/Ahb6jbXy9qOEBiHynxO5alSidU5wGPosZBSLJVxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uXNsy4+K; arc=none smtp.client-ip=91.218.175.188
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781181475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gomvGYWAOkigl2R+ikTsOAyD89SbDoYkSYMX3yIK3Sk=;
	b=uXNsy4+KkBI+0TlaauVRKwmvdIrvxgx8TJi4A6Vxq6zoM8WmN1fQ6mpAO7lTzLytrQWXUS
	wo9qf7XTyf/CaF0pt4k4qivQEY9D92uU9NRhtyogKdXhYsTsdY9JGL4BTW27+xHSbuFnjZ
	CCEJDYQwC2azGrn/zG6r9KOetW7kl1k=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Shuah Khan <shuah@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Cong Wang <cong.wang@bytedance.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 2/7] bpf, sockmap: Fix wrong rsge offset in bpf_msg_push_data()
Date: Thu, 11 Jun 2026 20:34:10 +0800
Message-ID: <20260611123538.156005-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260611123538.156005-1-jiayuan.chen@linux.dev>
References: <20260611123538.156005-1-jiayuan.chen@linux.dev>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-298118-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:bestswngs@gmail.com,m:xmei5@asu.edu,m:jiayuan.chen@linux.dev,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:martin.lau@linux.dev,m:ast@kernel.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jakub@cloudflare.com,m:shuah@kernel.org,m:hawk@kernel.org,m:rhkrqnwk98@gmail.com,m:ihor.solodrai@linux.dev,m:cong.wang@bytedance.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,asu.edu,linux.dev,iogearbox.net,fomichev.me,kernel.org,etsalapatis.com,davemloft.net,google.com,redhat.com,cloudflare.com,bytedance.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CFD47671EEE

From: Weiming Shi <bestswngs@gmail.com>

When bpf_msg_push_data() splits a scatterlist element into head and
tail, the tail's page offset is advanced by `start` (absolute message
byte offset) instead of `start - offset` (byte position within the
element). This makes rsge.offset overshoot by `offset` bytes, pointing
to the wrong location within the page or beyond its boundary. Consumers
of the corrupted entry either silently read wrong data or trigger an
out-of-bounds access.

 BUG: KASAN: slab-use-after-free in bpf_msg_pull_data (net/core/filter.c:2728)
 Read of size 32752 at addr ffff8881042f0010 by task poc/130
 Call Trace:
  __asan_memcpy (mm/kasan/shadow.c:105)
  bpf_msg_pull_data (net/core/filter.c:2728)
  bpf_prog_run_pin_on_cpu (include/linux/bpf.h:1402)
  sk_psock_msg_verdict (net/core/skmsg.c:934)
  tcp_bpf_send_verdict (net/ipv4/tcp_bpf.c:421)
  sock_sendmsg_nosec (net/socket.c:727)

Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
Reported-by: Xiang Mei <xmei5@asu.edu>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
To sashiko:

Regarding bpf_msg_push_data() reading "copy = msg->sg.data[i].length" with
i == msg->sg.end (appending at the very end of a full/near-full ring):

This is pre-existing code, not touched by this series, and reproducing it needs
a narrow combination -- a pure append at the end so the loop exits with
i == msg->sg.end, a full/near-full ring, plus a prior push/pop history that
leaves a stale length in the otherwise-unused end slot. A freshly built ring
zeroes that slot, so copy stays 0. We don't consider it practically reproducible.

Even then it's already covered: the overflow check in patch 1 ("copy + len <
copy") rejects the dangerous case, and __GFP_ZERO in patch 3 prevents any data
exposure. Not worth fixing here.
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 3c8f1cedb217f..3e555f276ba80 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2872,7 +2872,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 
 		psge->length = start - offset;
 		rsge.length -= psge->length;
-		rsge.offset += start;
+		rsge.offset += start - offset;
 
 		sk_msg_iter_var_next(i);
 		sg_unmark_end(psge);
-- 
2.43.0


