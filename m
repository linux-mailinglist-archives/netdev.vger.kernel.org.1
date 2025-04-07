Return-Path: <netdev+bounces-179684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FADA7E18A
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03C4017AF79
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEF71DE2D4;
	Mon,  7 Apr 2025 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qKl2Sqwn"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9D51DC747
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035826; cv=none; b=JASSY1udrVmrYZory6n9SJ3eZ5lZyYuZYjVH3ZAoPIzBxrwYawi4K67X/2+l37Chsbnl43FkjsBcWnHg9hDE/0kVwWIEOj+NVpa42Dw234zy798uEMesHm5AG1i6X2TtB5QLCfqeFR9TMKQKczQv6F1R9wkU8n0KnFBTZi8cIkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035826; c=relaxed/simple;
	bh=GrUS7nmfi1SY0aJ/MVjihRp1EO08eS93vornewj9Onk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apl0Sy0Op307mnyq31zmuHBrYai/KK9u5r49SSsMGTArRy/aEo73kN0H+DqTFJEf+6jH5/8ojfTqu/6WIlHmyeL55AFZCDd0fKYCBBZNyHA+EiEyXBvd+7kcLGNWPfWnS5pCC3wfYcdA8RtmI5jrfXMbhBlSWdBd54sZL1q8IDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qKl2Sqwn; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744035819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RqXWt/QORD9OH3iap+B7ewziZ+4G9b9oNDtYRsxkesI=;
	b=qKl2Sqwn7u0DClCEbYAfaFyB2yP5VQGVJ4Hp9zbys19NNYR+vCYztGag0xgO6LIGsCZ8Q6
	2rsACaScnW0iFkzfhNW+M0d86b3WsEHozJ4jErCeUsf2KnmBbX3z7dvJOCSA0Dx2TLMPRz
	EyYt5RHn7giksGXVNk/lMc1kXqJ+WKY=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 1/4] bpf, sockmap: Fix data lost during EAGAIN retries
Date: Mon,  7 Apr 2025 22:21:20 +0800
Message-ID: <20250407142234.47591-2-jiayuan.chen@linux.dev>
In-Reply-To: <20250407142234.47591-1-jiayuan.chen@linux.dev>
References: <20250407142234.47591-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We call skb_bpf_redirect_clear() to clean _sk_redir before handling skb in
backlog, but when sk_psock_handle_skb() return EAGAIN due to sk_rcvbuf
limit, the redirect info in _sk_redir is not recovered.

Fix skb redir loss during EAGAIN retries by restoring _sk_redir
information using skb_bpf_set_redir().

Before this patch:
'''
./bench sockmap -c 2 -p 1 -a --rx-verdict-ingress
Setting up benchmark 'sockmap'...
create socket fd c1:13 p1:14 c2:15 p2:16
Benchmark 'sockmap' started.
Send Speed 1343.172 MB/s, BPF Speed 1343.238 MB/s, Rcv Speed   65.271 MB/s
Send Speed 1352.022 MB/s, BPF Speed 1352.088 MB/s, Rcv Speed   0 MB/s
Send Speed 1354.105 MB/s, BPF Speed 1354.105 MB/s, Rcv Speed   0 MB/s
Send Speed 1355.018 MB/s, BPF Speed 1354.887 MB/s, Rcv Speed   0 MB/s
'''
Due to the high send rate, the RX processing path may frequently hit the
sk_rcvbuf limit. Once triggered, incorrect _sk_redir will cause the flow
to mistakenly enter the "!ingress" path, leading to send failures.
(The Rcv speed depends on tcp_rmem).

After this patch:
'''
./bench sockmap -c 2 -p 1 -a --rx-verdict-ingress
Setting up benchmark 'sockmap'...
create socket fd c1:13 p1:14 c2:15 p2:16
Benchmark 'sockmap' started.
Send Speed 1347.236 MB/s, BPF Speed 1347.367 MB/s, Rcv Speed   65.402 MB/s
Send Speed 1353.320 MB/s, BPF Speed 1353.320 MB/s, Rcv Speed   65.536 MB/s
Send Speed 1353.186 MB/s, BPF Speed 1353.121 MB/s, Rcv Speed   65.536 MB/s
'''

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/skmsg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 0ddc4c718833..29cb5ffd56c0 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -680,7 +680,8 @@ static void sk_psock_backlog(struct work_struct *work)
 			if (ret <= 0) {
 				if (ret == -EAGAIN) {
 					sk_psock_skb_state(psock, state, len, off);
-
+					/* Restore redir info we cleared before */
+					skb_bpf_set_redir(skb, psock->sk, ingress);
 					/* Delay slightly to prioritize any
 					 * other work that might be here.
 					 */
-- 
2.47.1


