Return-Path: <netdev+bounces-263610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HioJSjUp2nEkAAAu9opvQ
	(envelope-from <netdev+bounces-263610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 07:41:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1110D1FB446
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 07:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6587130104B5
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 06:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A10D381AF6;
	Wed,  4 Mar 2026 06:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q4FEJERc"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2018534C139;
	Wed,  4 Mar 2026 06:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772606410; cv=none; b=iwCHZpoFfjC6Wej/kxKCsY3JKpxT2XXXmvpgSbBqC8/ruylagF8qXsTvxajCPJyu07KDS7Y7jAX+Md2rpgVSEUg5KdRxXftwuphQs0eFhTB7kAusaWgZ/COJUvxlT6X1q24qI+COB9IidB2/y4VT8bCAxhm7rnlLLjgyjvuOHbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772606410; c=relaxed/simple;
	bh=xb+WBcf3xKm11jZGInNI3x0/hLtFqnRsVRRviuPxg3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8BJU5fgXTci/8pq1+5Y/ZOror0ctFoz6AFk349Rmv7ptWzs7DW2QQwj8FIb7dmyHLRLN/Put1eBWwC0tMJ1YYaOgc7I0bSzaJRk4OFbgLw7vd+NaJ5q5aWgCRuukGs/8UrlicaRazLZKEeY2UC+2FECg3zZVPXaaoRN5bFrLrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q4FEJERc; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772606406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ejtUtr9rPgE5dpjPFrLD7UpC6yS26+UMUtgdrNoTYJI=;
	b=q4FEJERc+CBqIxLEbT3FTDIYP1/5pBRUeCveps8tRwH+1xukW2TNOlVzks6XzqS/UpBlUs
	SdATJsKXwnYjyURyZghdvSW37n0GpjhOTXcusTl20iRRcjjVhnukzD74F4SKXEuvV13fhp
	rxGvsnrRfNK3n/JGs9K43f1qmJvEe3Y=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	jakub@cloudflare.com
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Michal Luczaj <mhal@rbox.co>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 7/7] selftests/bpf: add splice option to sockmap benchmark
Date: Wed,  4 Mar 2026 14:33:58 +0800
Message-ID: <20260304063643.14581-8-jiayuan.chen@linux.dev>
In-Reply-To: <20260304063643.14581-1-jiayuan.chen@linux.dev>
References: <20260304063643.14581-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 1110D1FB446
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263610-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,cloudflare.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,fomichev.me,linux.alibaba.com,rbox.co,vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add --splice option to bench_sockmap that uses splice(2) instead of
read(2) in the consumer path. A global pipe is created once during
setup and reused across iterations to avoid per-call pipe creation
overhead.

When --splice is enabled, the consumer splices data from the socket
into the pipe, then reads from the pipe into the user buffer. The
socket is set to O_NONBLOCK to prevent tcp_splice_read() from
blocking indefinitely, as it only checks sock->file->f_flags for
non-blocking mode, ignoring SPLICE_F_NONBLOCK.

Also increase SO_RCVBUF to 16MB to avoid sk_psock_backlog being
throttled by the default sk_rcvbuf limit, and add --verify option
to optionally enable data correctness checking (disabled by default
for benchmark accuracy).

Benchmark results with rx-verdict-ingress mode (loopback, 8 CPUs):

  read(2):                  ~4292 MB/s
  splice(2) + zero-copy:    ~4270 MB/s
  splice(2) + always-copy:  ~2770 MB/s

Zero-copy splice achieves near-parity with read(2), while the
always-copy fallback is ~35% slower.

Usage:
  # Steer softirqs to CPU 7 to avoid contending with the producer CPU
  echo 80 > /sys/class/net/lo/queues/rx-0/rps_cpus
  # Raise the receive buffer ceiling so the benchmark can set 16MB rcvbuf
  sysctl -w net.core.rmem_max=16777216
  # Run the benchmark
  ./bench sockmap --rx-verdict-ingress --splice -c 2 -p 1 -a -d 30

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/benchs/bench_sockmap.c      | 57 ++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_sockmap.c b/tools/testing/selftests/bpf/benchs/bench_sockmap.c
index cfc072aa7fff..ffcf5ad8cafa 100644
--- a/tools/testing/selftests/bpf/benchs/bench_sockmap.c
+++ b/tools/testing/selftests/bpf/benchs/bench_sockmap.c
@@ -7,6 +7,9 @@
 #include <sys/sendfile.h>
 #include <arpa/inet.h>
 #include <fcntl.h>
+#include <unistd.h>
+#include <sched.h>
+#include <sys/syscall.h>
 #include <argp.h>
 #include "bench.h"
 #include "bench_sockmap_prog.skel.h"
@@ -46,6 +49,8 @@ enum SOCKMAP_ARG_FLAG {
 	ARG_CTL_RX_STRP,
 	ARG_CONSUMER_DELAY_TIME,
 	ARG_PRODUCER_DURATION,
+	ARG_CTL_SPLICE,
+	ARG_CTL_VERIFY,
 };
 
 #define TXMODE_NORMAL()				\
@@ -110,6 +115,9 @@ static struct socmap_ctx {
 	int		delay_consumer;
 	int		prod_run_time;
 	int		strp_size;
+	bool		use_splice;
+	bool		verify;
+	int		pipefd[2];
 } ctx = {
 	.prod_send	= 0,
 	.user_read	= 0,
@@ -119,6 +127,9 @@ static struct socmap_ctx {
 	.delay_consumer = 0,
 	.prod_run_time	= 0,
 	.strp_size	= 0,
+	.use_splice	= false,
+	.verify		= false,
+	.pipefd		= {-1, -1},
 };
 
 static void bench_sockmap_prog_destroy(void)
@@ -130,6 +141,11 @@ static void bench_sockmap_prog_destroy(void)
 			close(ctx.fds[i]);
 	}
 
+	if (ctx.pipefd[0] >= 0)
+		close(ctx.pipefd[0]);
+	if (ctx.pipefd[1] >= 0)
+		close(ctx.pipefd[1]);
+
 	bench_sockmap_prog__destroy(ctx.skel);
 }
 
@@ -320,6 +336,7 @@ static int setup_tx_sockmap(void)
 
 static void setup(void)
 {
+	int rcvbuf = 16 * 1024 * 1024;
 	int err;
 
 	ctx.skel = bench_sockmap_prog__open_and_load();
@@ -350,6 +367,18 @@ static void setup(void)
 		goto err;
 	}
 
+	if (ctx.use_splice) {
+		if (pipe(ctx.pipefd)) {
+			fprintf(stderr, "pipe error:%d\n", errno);
+			goto err;
+		}
+	}
+
+	setsockopt(ctx.c2, SOL_SOCKET, SO_RCVBUF, &rcvbuf, sizeof(rcvbuf));
+
+	if (ctx.use_splice)
+		set_non_block(ctx.c2, true);
+
 	return;
 
 err:
@@ -368,6 +397,8 @@ static void measure(struct bench_res *res)
 
 static void verify_data(int *check_pos, char *buf, int rcv)
 {
+	if (!ctx.verify)
+		return;
 	for (int i = 0 ; i < rcv; i++) {
 		if (buf[i] != snd_data[(*check_pos) % DATA_REPEAT_SIZE]) {
 			fprintf(stderr, "verify data fail");
@@ -388,6 +419,9 @@ static void *consumer(void *input)
 	char *buf = malloc(recv_buf_size);
 	int delay_read = ctx.delay_consumer;
 
+	printf("cons[%d] started, tid=%ld cpu=%d\n",
+	       tid, syscall(SYS_gettid), sched_getcpu());
+
 	if (!buf) {
 		fprintf(stderr, "fail to init read buffer");
 		return NULL;
@@ -419,7 +453,15 @@ static void *consumer(void *input)
 			}
 			/* read real endpoint by consumer 0 */
 			atomic_inc(&ctx.read_calls);
-			rcv = read(ctx.c2, buf, recv_buf_size);
+			if (ctx.use_splice) {
+				rcv = splice(ctx.c2, NULL, ctx.pipefd[1],
+					     NULL, recv_buf_size,
+					     SPLICE_F_NONBLOCK);
+				if (rcv > 0)
+					rcv = read(ctx.pipefd[0], buf, rcv);
+			} else {
+				rcv = read(ctx.c2, buf, recv_buf_size);
+			}
 			if (rcv < 0 && errno != EAGAIN) {
 				fprintf(stderr, "%s fail to read c2 %d\n", __func__, errno);
 				return NULL;
@@ -440,6 +482,9 @@ static void *producer(void *input)
 	int target;
 	FILE *file;
 
+	printf("prod started, tid=%ld cpu=%d\n",
+	       syscall(SYS_gettid), sched_getcpu());
+
 	file = tmpfile();
 	if (!file) {
 		fprintf(stderr, "create file for sendfile");
@@ -554,6 +599,10 @@ static const struct argp_option opts[] = {
 		"delay consumer start"},
 	{ "producer-duration", ARG_PRODUCER_DURATION, "SEC", 0,
 		"producer duration"},
+	{ "splice", ARG_CTL_SPLICE, NULL, 0,
+		"use splice instead of read for consumer"},
+	{ "verify", ARG_CTL_VERIFY, NULL, 0,
+		"verify received data correctness"},
 	{},
 };
 
@@ -572,6 +621,12 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 	case ARG_CTL_RX_STRP:
 		ctx.strp_size = strtol(arg, NULL, 10);
 		break;
+	case ARG_CTL_SPLICE:
+		ctx.use_splice = true;
+		break;
+	case ARG_CTL_VERIFY:
+		ctx.verify = true;
+		break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
-- 
2.43.0


