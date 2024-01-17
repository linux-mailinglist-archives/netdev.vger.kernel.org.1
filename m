Return-Path: <netdev+bounces-64075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF41831013
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 00:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B7328D8E3
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 23:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A13828694;
	Wed, 17 Jan 2024 23:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="H+7E7v6c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEC822F16
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 23:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705533550; cv=none; b=H3Ryt386LUiFO0NFkPpBQH8y9Pxp/PzavkZj2Sycm8s3KhQFcTe1u/ZQ1E5vtZO34CMH0l1fs0ntYcehXMCzLacl/de0PeQ0kmUWoa00CTrAq4JiBHfpErC7UgFO018KvcWV1k2WAByyyiSXNiflz15k3CG1kMHI8exKpN49XCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705533550; c=relaxed/simple;
	bh=KOHVHySq8/dnEo40Vh6hLVc4Zz+5UNTA4BzLK5s9ciA=;
	h=DKIM-Signature:X-IronPort-AV:Received:Received:Received:
	 X-Farcaster-Flow-ID:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:Precedence; b=liLHcsmaPHQt6RzzCYQac+ebjmqGzcXNm4Rahb/5iyD0XoSVrkwFIVwPLsjzkYYQGVrGqkSwDnptCttEIf5zD8U9vSRUPaTmcNeHd7XnngRchjMvW9xeZFoLTiflQ+IS11JgJVNQ8qv9xxBYJrTLg8PLMfpQfPtLwnKPTP4Zj/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=H+7E7v6c; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705533549; x=1737069549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rvwe37HrMlA6jlrHEklyJUHqeCHGZrGMS0KQRR6hiGk=;
  b=H+7E7v6c14UgUcbtg6T95Fl8PHCUbgu/CAjTrOqasOayVcYcuneBb0ru
   BbaOWi8wC2vuNas30+BCFzp2nzObj8F2pULY0iIVeCudrOKatp9u0YoON
   21WP1THPix251WWAfnpZvn3Wv/qNYvKXQ5CqngHUfAGkiLN+diGGNh6BA
   E=;
X-IronPort-AV: E=Sophos;i="6.05,201,1701129600"; 
   d="scan'208";a="697916688"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-af372327.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 23:19:08 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-af372327.us-west-2.amazon.com (Postfix) with ESMTPS id C10CC60CB8;
	Wed, 17 Jan 2024 23:19:07 +0000 (UTC)
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:13111]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.39.189:2525] with esmtp (Farcaster)
 id 9eb802f3-2b44-4aa5-9ddb-12caca24c79e; Wed, 17 Jan 2024 23:19:06 +0000 (UTC)
X-Farcaster-Flow-ID: 9eb802f3-2b44-4aa5-9ddb-12caca24c79e
Received: from EX19D038EUA003.ant.amazon.com (10.252.50.199) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 23:19:06 +0000
Received: from c889f3b7ef0b.amazon.com (10.187.171.35) by
 EX19D038EUA003.ant.amazon.com (10.252.50.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 23:19:04 +0000
From: Salvatore Dipietro <dipiets@amazon.com>
To: <edumazet@google.com>
CC: <alisaidi@amazon.com>, <benh@amazon.com>, <blakgeof@amazon.com>,
	<davem@davemloft.net>, <dipietro.salvatore@gmail.com>, <dipiets@amazon.com>,
	<dsahern@kernel.org>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: [PATCH v3] tcp: Add memory barrier to tcp_push()
Date: Wed, 17 Jan 2024 15:16:46 -0800
Message-ID: <20240117231646.22853-1-dipiets@amazon.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <CANn89i+XkcQV6_=ysKACN+JQM=P7SqbfTvhxF+jSwd=MJ6t0sw@mail.gmail.com>
References: <CANn89i+XkcQV6_=ysKACN+JQM=P7SqbfTvhxF+jSwd=MJ6t0sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D038EUA003.ant.amazon.com (10.252.50.199)
Precedence: Bulk

On CPUs with weak memory models, reads and updates performed by tcp_push to the
sk variables can get reordered leaving the socket throttled when it should not.
The tasklet running tcp_wfree() may also not observe the memory updates in time
and will skip flushing any packets throttled by tcp_push(), delaying the sending.
This can pathologically cause 40ms extra latency due to bad interactions with
delayed acks.

Adding a memory barrier in tcp_push before the sk_wmem_alloc read removes the
bug, similarly to the previous commit bf06200e732d ("tcp: tsq: fix nonagle
handling"). smp_mb__after_atomic() is used to not incur in unnecessary overhead
on x86 since not affected.

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

Fixes: a181ceb501b3 ("tcp: autocork should not hold first packet in write
queue")
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


