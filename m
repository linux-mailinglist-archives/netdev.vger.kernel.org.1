Return-Path: <netdev+bounces-64405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887A9832F3C
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 20:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99221C214A2
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 19:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5ED4F20A;
	Fri, 19 Jan 2024 19:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NYhW7MKf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D9C200DA
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 19:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705690988; cv=none; b=ci8KNm/LyBPEBZgRIc+hguBtNN+5Jj3bsHbDn8konMf93s1JMOvBKTeIm4zFG+N+PRSaanViXsw/a6VJsQFtyvmIHjq7yEH97RkKIJEiX5OM8/fvJA3Ka5zsdSYNEoOOvR3mr2vitMQ3w5gtrGAzpxQunbqTyZ7I9uyEWFeT+sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705690988; c=relaxed/simple;
	bh=CGy1Nz9eVU9O/e7G5XpXqiO4R6y95O83Vvp+b6vdO54=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i3ojfoSQHpdoejFGguNgdMz3zy3YLhvXLmb4ntL0MZ9ZOx/ucJbaRKByZuEcf06uS5o9ND7Z9TlVDByVcY9zrzLmQkYaQTAotXIefeCxQgQ37f00m2cK9JYjxxKEccqCUahoDxTWPWPE/mrzbnGz3On5MQpYMi2J9xvBAbs4t6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NYhW7MKf; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705690987; x=1737226987;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i7LZlavglZtaiPYTFqnDYw7pfcok0Wu9rQi6dGaa4SY=;
  b=NYhW7MKf4TCzsqjC0yt87BIGz9W055vYsxKV3+ZoqMzpSI8CaTzd9MJ3
   GhVXa0cRbQCCgF9yixxOK2dWeiDU55013+itowrVPPZ0yQ74oj/HS/RUS
   ZHI7+DqKh0Q4dlSnyvfI+k06JLAtR/4WexxsH+jSwWPE5PVflpEmu2YAi
   U=;
X-IronPort-AV: E=Sophos;i="6.05,206,1701129600"; 
   d="scan'208";a="607549463"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 19:03:04 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com (Postfix) with ESMTPS id 63300C1C3A;
	Fri, 19 Jan 2024 19:03:03 +0000 (UTC)
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:44654]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.39.189:2525] with esmtp (Farcaster)
 id d2832fa8-dc34-4ffd-816c-8a4abb344ebe; Fri, 19 Jan 2024 19:03:01 +0000 (UTC)
X-Farcaster-Flow-ID: d2832fa8-dc34-4ffd-816c-8a4abb344ebe
Received: from EX19D038EUA003.ant.amazon.com (10.252.50.199) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 19 Jan 2024 19:03:01 +0000
Received: from c889f3b7ef0b.amazon.com (10.187.170.36) by
 EX19D038EUA003.ant.amazon.com (10.252.50.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Fri, 19 Jan 2024 19:02:58 +0000
From: Salvatore Dipietro <dipiets@amazon.com>
To: <edumazet@google.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <blakgeof@amazon.com>, <alisaidi@amazon.com>,
	<benh@amazon.com>, <dipietro.salvatore@gmail.com>, Salvatore Dipietro
	<dipiets@amazon.com>
Subject: [PATCH v4] tcp: Add memory barrier to tcp_push()
Date: Fri, 19 Jan 2024 11:01:33 -0800
Message-ID: <20240119190133.43698-1-dipiets@amazon.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D038EUA003.ant.amazon.com (10.252.50.199)
Precedence: Bulk

On CPUs with weak memory models, reads and updates performed by tcp_push
to the sk variables can get reordered leaving the socket throttled when
it should not. The tasklet running tcp_wfree() may also not observe the
memory updates in time and will skip flushing any packets throttled by
tcp_push(), delaying the sending. This can pathologically cause 40ms
extra latency due to bad interactions with delayed acks.

Adding a memory barrier in tcp_push removes the bug, similarly to the
previous commit bf06200e732d ("tcp: tsq: fix nonagle handling").
smp_mb__after_atomic() is used to not incur in unnecessary overhead
on x86 since not affected.

Patch has been tested using an AWS c7g.2xlarge instance with Ubuntu
22.04 and Apache Tomcat 9.0.83 running the basic servlet below:

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

No patch and tcp_autocorking=1
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

With patch and tcp_autocorking=1
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

Fixes: 7aa5470c2c09 ("tcp: tsq: move tsq_flags close to sk_wmem_alloc")
Signed-off-by: Salvatore Dipietro <dipiets@amazon.com>
---
 net/ipv4/tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index ff6838ca2e58..7bce79beca2b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -722,6 +722,7 @@ void tcp_push(struct sock *sk, int flags, int mss_now,
 		if (!test_bit(TSQ_THROTTLED, &sk->sk_tsq_flags)) {
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAUTOCORKING);
 			set_bit(TSQ_THROTTLED, &sk->sk_tsq_flags);
+			smp_mb__after_atomic();
 		}
 		/* It is possible TX completion already happened
 		 * before we set TSQ_THROTTLED.
-- 
2.42.0


