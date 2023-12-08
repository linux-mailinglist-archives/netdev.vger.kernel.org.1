Return-Path: <netdev+bounces-55398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DE880ABFE
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 19:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D606A281867
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 18:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290A347A43;
	Fri,  8 Dec 2023 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hWhFCNuY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E58284
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 10:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702059791; x=1733595791;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gfOcqJXzX15qwfTDQihaVa+k0N5tKvkZC6tBUoad8Gg=;
  b=hWhFCNuY31is55TAhuZ91sZ2zwr90aX3ttwPXvw9RJ1I0+T6s4KhtHop
   0UplginShrPWTVbL9/whHOQGQ8B9x17C2jXRd+8VT1Nqcdd0Np06JPvcT
   bfqmkzk8rW57h20AZXDkczGIdIBcaRhfSVVTu/e3CBpUDQkaS+9GGMHaB
   0=;
X-IronPort-AV: E=Sophos;i="6.04,261,1695686400"; 
   d="scan'208";a="49453433"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 18:23:08 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com (Postfix) with ESMTPS id B6FAF49890;
	Fri,  8 Dec 2023 18:23:06 +0000 (UTC)
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:61940]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.35.49:2525] with esmtp (Farcaster)
 id ef7df1ca-4925-4449-aa62-b35d853b6a3b; Fri, 8 Dec 2023 18:23:05 +0000 (UTC)
X-Farcaster-Flow-ID: ef7df1ca-4925-4449-aa62-b35d853b6a3b
Received: from EX19D038EUA003.ant.amazon.com (10.252.50.199) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 8 Dec 2023 18:23:05 +0000
Received: from c889f3b7ef0b.amazon.com (10.106.101.42) by
 EX19D038EUA003.ant.amazon.com (10.252.50.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Fri, 8 Dec 2023 18:23:02 +0000
From: Salvatore Dipietro <dipiets@amazon.com>
To: <edumazet@google.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <blakgeof@amazon.com>, <alisaidi@amazon.com>,
	<benh@amazon.com>, <dipietro.salvatore@gmail.com>, Salvatore Dipietro
	<dipiets@amazon.com>
Subject: [PATCH] tcp: disable tcp_autocorking for socket when TCP_NODELAY flag is set
Date: Fri, 8 Dec 2023 10:20:49 -0800
Message-ID: <20231208182049.33775-1-dipiets@amazon.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
 EX19D038EUA003.ant.amazon.com (10.252.50.199)
Precedence: Bulk

Based on the tcp man page, if TCP_NODELAY is set, it disables Nagle's algorithm
and packets are sent as soon as possible. However in the `tcp_push` function
where autocorking is evaluated the `nonagle` value set by TCP_NODELAY is not
considered which can trigger unexpected corking of packets and induce delays.

For example, if two packets are generated as part of a server's reply, if the
first one is not transmitted on the wire quickly enough, the second packet can
trigger the autocorking in `tcp_push` and be delayed instead of sent as soon as
possible. It will either wait for additional packets to be coalesced or an ACK
from the client before transmitting the corked packet. This can interact badly
if the receiver has tcp delayed acks enabled, introducing 40ms extra delay in
completion times. It is not always possible to control who has delayed acks
set, but it is possible to adjust when and how autocorking is triggered.
Patch prevents autocorking if the TCP_NODELAY flag is set on the socket.

Patch has been tested using an AWS c7g.2xlarge instance with Ubuntu 22.04 and
Apache Tomcat 9.0.83 running the basic servlet below:

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HelloWorldServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        OutputStreamWriter osw = new OutputStreamWriter(response.getOutputStream(),"UTF-8");
        String s = "a".repeat(3096);
        osw.write(s,0,s.length());
        osw.flush();
    }
}

Load was applied using  wrk2 (https://github.com/kinvolk/wrk2) from an AWS
c6i.8xlarge instance.  With the current auto-corking behavior and TCP_NODELAY
set an additional 40ms latency from P99.99+ values are observed.  With the
patch applied we see no occurrences of 40ms latencies. The patch has also been
tested with iperf and uperf benchmarks and no regression was observed.

# No patch with tcp_autocorking=1 and TCP_NODELAY set on all sockets
./wrk -t32 -c128 -d40s --latency -R10000  http://172.31.49.177:8080/hello/hello'
  ...
 50.000%    0.91ms
 75.000%    1.12ms
 90.000%    1.46ms
 99.000%    1.73ms
 99.900%    1.96ms
 99.990%   43.62ms   <<< 40+ ms extra latency
 99.999%   48.32ms
100.000%   49.34ms

# With patch
./wrk -t32 -c128 -d40s --latency -R10000  http://172.31.49.177:8080/hello/hello'
  ...
 50.000%    0.89ms
 75.000%    1.13ms
 90.000%    1.44ms
 99.000%    1.67ms
 99.900%    1.78ms
 99.990%    2.27ms   <<< no 40+ ms extra latency
 99.999%    3.71ms
100.000%    4.57ms

Signed-off-by: Salvatore Dipietro <dipiets@amazon.com>
---
 net/ipv4/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index d3456cf840de..87751a2a6fff 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -716,7 +716,7 @@ void tcp_push(struct sock *sk, int flags, int mss_now,
 
 	tcp_mark_urg(tp, flags);
 
-	if (tcp_should_autocork(sk, skb, size_goal)) {
+	if (!nonagle && tcp_should_autocork(sk, skb, size_goal)) {
 
 		/* avoid atomic op if TSQ_THROTTLED bit is already set */
 		if (!test_bit(TSQ_THROTTLED, &sk->sk_tsq_flags)) {
-- 
2.42.0


