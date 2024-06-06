Return-Path: <netdev+bounces-101472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D68F68FF051
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13F71C221B9
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E74E19B3CE;
	Thu,  6 Jun 2024 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izP4Cj8Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C832719307E
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717686207; cv=none; b=GnacMYHOlkunGC59JP5R+B3hCq7IXLOWJhLzDTP8grigoMp9MiQKjK08+STSgqEpFc4YFjaF5aESFqasqunZEtEO8DBGlq1F5DWgUMZbSCZ6IcpprdLzLpd1+UV/1gH0jorQtYUZzs3hpBCk+2RX0nUvtNR1zr+JA/Ma2osCSDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717686207; c=relaxed/simple;
	bh=zc0lRE4HIsM+kEzvoXCmIQ7aMCxMIG/xZ9+VtekXT5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MOu7g9VzTnBy7JuQVNLcJrNHLtuzChf7gnmPXrYiya2oXPV6t56QXGgB3N3VW0vzOQxy2o2hs7qcPdKGLIyri+NTLOjVfbz91SeHtCKQwyXXzMa8NawOphHmAKOE7buBXK7VwVHhHQ84fKVCn2xX8xLmbUMbwPl+OLD+8Bhksf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izP4Cj8Y; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f4a5344ec7so8031855ad.1
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 08:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717686204; x=1718291004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfYJjjBtqofpxNk/4Tw/V4e/Q8e9et5dmP4zWmiUcl0=;
        b=izP4Cj8YxAlVOlB6OkHmyqljc83Ndrx+t0vBwftV3dPi1tozraYG/zrj7YfuaWqgOV
         jmz5SvNPFfa5pp32EXrMyll27FB9kHq9k2oqMlrJ4G327JweNpIyK7VWc7UYjqPMoSKd
         AbO/IfprptoIp1J5wWaT4MJMqaszeQ8blFBT8fpY8hC2O0rcPiC4BiYrfkpsKsMi2Wou
         9icY5Y3cCJ4W4PUvWZznxbUtTK+6UTUiqybCtsLGfFgfr348Y6d69H1q149MWoMsNsnt
         WAw3JhndFXQZbZdj70g0L2TOoJWr4fzaLKyQn7WtxkL/L/TX81NyMvhYkGyODFWwZW9N
         y/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717686204; x=1718291004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfYJjjBtqofpxNk/4Tw/V4e/Q8e9et5dmP4zWmiUcl0=;
        b=WclmDvxf648KcS2Thnaf7EvB4VgXZocNkzMYlii2Ol3xJI+1Zt1GJpxuXt23k5Mm4v
         NMdrKhYTJUj3u+kBAoISrRqnyqOI7Il9erzWsG1hrIjMfIFfSvfCze3J1PwkSjf43VCr
         k9OBvN0dWrCWqsE3GFt5OnKt2pzRn7bnte69EHgDbhlMbNnpB6WdYd62fUIWDoCsviyz
         Sq0i6gXd5g+zl5L3dGMZnlClrbkyG/GJBoRO8Mhw9IWcFyYRuli0SmsgKqbCVGka3EZK
         pJXSKxREOMzdqIXl/d3KhU7St1y8sK+PsoydOYAxxQ/P+3ayFKJ1T4meFjMb+uUPaepU
         immQ==
X-Gm-Message-State: AOJu0Yz7EiS7si6VRodEW6SbvoHLhNpO9lETvH3Bk500Gqw/WEx9mrmD
	e+3gjVsDECtdlhA+/XET5wpjIq36KJjTP3bv+hjdPDWIVmMcX5nm
X-Google-Smtp-Source: AGHT+IFm12OyVfS2QgPPLBeoFnnyKscsbb8AbCIGoNZOLlB0sxQPsXnMyjcS8NM1JfTtWbXY45xHJQ==
X-Received: by 2002:a17:903:41c8:b0:1f4:58c6:d5b with SMTP id d9443c01a7336-1f6b8f1513dmr38019955ad.28.1717686203896;
        Thu, 06 Jun 2024 08:03:23 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de264ae03csm1215853a12.68.2024.06.06.08.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 08:03:23 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	ncardwell@google.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 1/2] tcp: fix showing wrong rtomin in snmp file when using route option
Date: Thu,  6 Jun 2024 23:03:06 +0800
Message-Id: <20240606150307.78648-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240606150307.78648-1-kerneljasonxing@gmail.com>
References: <20240606150307.78648-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

TCP_MIB_RTOMIN implemented in tcp mib definitions is always 200, which
is true if without any method to tune rto min. In 2007, we got a way to
tune it globaly when setting rto_min route option, but TCP_MIB_RTOMIN
in /proc/net/snmp still shows the same, namely, 200.

As RFC 1213 said:
  "tcpRtoMin
   ...
   The minimum value permitted by a TCP implementation for the
   retransmission timeout, measured in milliseconds."

Since the lower bound of rto can be changed, we should accordingly
adjust the output of /proc/net/snmp.

Fixes: 05bb1fad1cde ("[TCP]: Allow minimum RTO to be configurable via routing metrics.")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/tcp.h  | 2 ++
 net/ipv4/metrics.c | 4 ++++
 net/ipv4/proc.c    | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index a70fc39090fe..a111a5d151b7 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -260,6 +260,8 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 extern int sysctl_tcp_max_orphans;
 extern long sysctl_tcp_mem[3];
 
+extern unsigned int tcp_rtax_rtomin;
+
 #define TCP_RACK_LOSS_DETECTION  0x1 /* Use RACK to detect losses */
 #define TCP_RACK_STATIC_REO_WND  0x2 /* Use static RACK reo wnd */
 #define TCP_RACK_NO_DUPTHRESH    0x4 /* Do not use DUPACK threshold in RACK */
diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
index 8ddac1f595ed..61ca949b8281 100644
--- a/net/ipv4/metrics.c
+++ b/net/ipv4/metrics.c
@@ -7,6 +7,8 @@
 #include <net/net_namespace.h>
 #include <net/tcp.h>
 
+unsigned int tcp_rtax_rtomin __read_mostly;
+
 static int ip_metrics_convert(struct nlattr *fc_mx,
 			      int fc_mx_len, u32 *metrics,
 			      struct netlink_ext_ack *extack)
@@ -60,6 +62,8 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
 	if (ecn_ca)
 		metrics[RTAX_FEATURES - 1] |= DST_FEATURE_ECN_CA;
 
+	tcp_rtax_rtomin = metrics[RTAX_RTO_MIN - 1];
+
 	return 0;
 }
 
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index 6c4664c681ca..ce387081a3c9 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -428,6 +428,9 @@ static int snmp_seq_show_tcp_udp(struct seq_file *seq, void *v)
 		/* MaxConn field is signed, RFC 2012 */
 		if (snmp4_tcp_list[i].entry == TCP_MIB_MAXCONN)
 			seq_printf(seq, " %ld", buff[i]);
+		else if (snmp4_tcp_list[i].entry == TCP_MIB_RTOMIN)
+			seq_printf(seq, " %lu",
+				   tcp_rtax_rtomin ? tcp_rtax_rtomin : buff[i]);
 		else
 			seq_printf(seq, " %lu", buff[i]);
 	}
-- 
2.37.3


