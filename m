Return-Path: <netdev+bounces-64056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AA5830EA3
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 22:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E7CB289717
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 21:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C17B25573;
	Wed, 17 Jan 2024 21:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cY15vohs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452BD2554C
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705526996; cv=none; b=BteBe0nU5lhkZ0UBe0zHtjqrV3XlbRdRk7J+00hXstR23abs4zGwCJGiwUU9F3vmIhjiaml0vb/ceISnVqpshdjHVAh34fwKcmlIjQ5I6dY/hZzwWYKOd6D4MfPXfn7B4W8AUPK4lX22DcycA2DdiBPvAlLusonN6pjqwvOw/HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705526996; c=relaxed/simple;
	bh=UwaXLZn0+dEbKEM5TTIotD/tJGqm08KeIPmYex65yuU=;
	h=DKIM-Signature:X-IronPort-AV:Received:Received:Received:
	 X-Farcaster-Flow-ID:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:Precedence; b=uewA0FC2kwwd4CuXtHgMJukqL6zsvJSjTt2vaTjoN2Ly/UukudpTlcIHOxcSA9hoONI+oe+3MBlnPGo4uMog/hT4AUxrJGKEDmxP+IsZ4UNCEg/64wr8lAQutMqrgiXEhG0DVWujxi9a0wIZqICDAssLJ64gwqTCZ0Pv/2QHCq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cY15vohs; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705526994; x=1737062994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TSs9KnUNwimF7WcIgBlw6sHNiwFEdk2r0n0s67kiEMc=;
  b=cY15vohsU8EuSotw7SN7QrlG3blcM2WEIPn73TQuPsiaHhadzgQGkchw
   LxqHweeJXUdWSAqX3EHDin4K3LQWmdbhnaPxpxsxXGYzGSP2K/KaKdFIL
   ZCXcwoZBAa8EjLjIlRa3Yl79/bt6ha/6R8yHdYmeTDzaRMP1KRtVe5VCb
   g=;
X-IronPort-AV: E=Sophos;i="6.05,201,1701129600"; 
   d="scan'208";a="628264680"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-86a02d5e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 21:29:51 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-86a02d5e.us-east-1.amazon.com (Postfix) with ESMTPS id E6717E9B3F;
	Wed, 17 Jan 2024 21:29:49 +0000 (UTC)
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:35001]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.31.217:2525] with esmtp (Farcaster)
 id 7b337ce4-b75c-487f-a96a-0d8c7b68b35f; Wed, 17 Jan 2024 21:29:48 +0000 (UTC)
X-Farcaster-Flow-ID: 7b337ce4-b75c-487f-a96a-0d8c7b68b35f
Received: from EX19D038EUA003.ant.amazon.com (10.252.50.199) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 21:29:42 +0000
Received: from c889f3b7ef0b.amazon.com (10.187.171.35) by
 EX19D038EUA003.ant.amazon.com (10.252.50.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 21:29:39 +0000
From: Salvatore Dipietro <dipiets@amazon.com>
To: <edumazet@google.com>
CC: <alisaidi@amazon.com>, <benh@amazon.com>, <blakgeof@amazon.com>,
	<davem@davemloft.net>, <dipietro.salvatore@gmail.com>, <dipiets@amazon.com>,
	<dsahern@kernel.org>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: [PATCH v2] tcp: Add memory barrier to tcp_push()
Date: Wed, 17 Jan 2024 13:26:48 -0800
Message-ID: <20240117212648.12572-1-dipiets@amazon.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <CANn89iJwokqZC9P3Ycy4ZWpmT1QhC0qD79y1K1eg2UUAcAj-Lw@mail.gmail.com>
References: <CANn89iJwokqZC9P3Ycy4ZWpmT1QhC0qD79y1K1eg2UUAcAj-Lw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D038EUA003.ant.amazon.com (10.252.50.199)
Precedence: Bulk

On CPUs with weak memory models, reads and updates performed by tcp_push to the
sk variables can get reordered leaving the socket throttled when it should not.
The tasklet running tcp_wfree() may also not observe the memory updates in time
and will skip flushing any packets throttled by tcp_push(), delaying the sending.
This can pathologically cause 40ms extra latency due to bad interactions with
delayed acks.

Modeling the memory access behavior of tcp_push() (P0) and tcp_wfree() (P1)
using the herd7 simulator, proves this behavior can occur. Below is the litmus
model which describes the functions:
```
C MP+tcp
{
  [flag] = 0;
  [sk] = 5;
  [corked] = 0;
}

P0(int *flag, int *sk, int *corked){
    int r0;
    int r1;
    int r2;

    r1 = READ_ONCE(*sk);
    if (r1 == 5) {

        r0 = READ_ONCE(*flag);
        if (r0 == 0) {
            WRITE_ONCE(*flag, 1);
        }

        // memory barrier added in this patch,
        // original code does not order the reads/writes
        smp_mb();

        r2 = READ_ONCE(*sk);
        if (r2 == 5 ) {
            WRITE_ONCE(*corked,1);
        }
    }
}

P1(int *flag, int *sk, int *corked){
    int r0;
    int r1;

    r1 = READ_ONCE(*sk);
    smp_store_release(sk, 0);

    r0 = smp_load_acquire(flag);
    if (r0 == 1) {
        smp_store_release(flag, 0);
    }
}
locations [0:r0; 0:r1; 0:r2; 1:r0; 1:r1; flag; sk; corked; ]
exists ( flag=1 /\ corked=1 )
```

Adding the memory barrier removes the positive witness from the memory model.
smp_mb__after_atomic() is used to not incur in unnecessary overhead on x86
since not affected.
Patch has been tested using an AWS c7g.2xlarge instance with Ubuntu 22.04 and
Apache Tomcat 9.0.83 running the basic servlet below:
```
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
```
Load was applied using wrk2 (https://github.com/kinvolk/wrk2) from an AWS
c6i.8xlarge instance. Before the patch an additional 40ms latency from P99.99+
values is observed while, with the patch, the extra latency disappears.

# No patch and tcp_autocorking=1
./wrk -t32 -c128 -d40s --latency -R10000  http://172.31.60.173:8080/hello/hello
  ...
 50.000%    0.91ms
 75.000%    1.13ms
 90.000%    1.46ms
 99.000%    1.74ms
 99.900%    1.89ms
 99.990%   41.95ms  <<< 40+ ms extra latency
 99.999%   48.32ms
100.000%   48.96ms

# With patch and tcp_autocorking=1
./wrk -t32 -c128 -d40s --latency -R10000  http://172.31.60.173:8080/hello/hello
  ...
 50.000%    0.90ms
 75.000%    1.13ms
 90.000%    1.45ms
 99.000%    1.72ms
 99.900%    1.83ms
 99.990%    2.11ms  <<< no 40+ ms extra latency
 99.999%    2.53ms
100.000%    2.62ms

Patch has been also tested on x86 (m7i.2xlarge instance) which it is not
affected by this issue and the patch doesn't introduce any additional
delay.

Fixes: f54b311142a9 ("tcp: auto corking")
Signed-off-by: Salvatore Dipietro <dipiets@amazon.com>
---
 net/ipv4/tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index ff6838ca2e58..ab9e3922393c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -726,6 +726,7 @@ void tcp_push(struct sock *sk, int flags, int mss_now,
 		/* It is possible TX completion already happened
 		 * before we set TSQ_THROTTLED.
 		 */
+		smp_mb__after_atomic();
 		if (refcount_read(&sk->sk_wmem_alloc) > skb->truesize)
 			return;
 	}
-- 
2.42.0


