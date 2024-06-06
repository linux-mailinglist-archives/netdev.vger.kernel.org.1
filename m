Return-Path: <netdev+bounces-101473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD398FF0E8
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 509E1B3124E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2945719B3F4;
	Thu,  6 Jun 2024 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TO8KEY3g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B2819B3EF
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717686211; cv=none; b=tLPqsYI98kAWiZNtFB4nm1RNn9oUZde+zgIV5uh9iBUT81ZLEGjl/h/CIIwt/k9YC8vXn+OJr1TtK6FfGuASai3Xsd8t2gKuQX7pA3r5chEfD9cQUNBl5no2MAA6cB+/dhauWV7Aau+WIWhel2r+OaLUhJoqBHHowG7rp1nvMuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717686211; c=relaxed/simple;
	bh=xqEgjvYGXGrNumAT0Fkq0aykzig6+28oZTY3mAVDAwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QhZQy8qrMjosfCd9wQ8S1vU16Kz6FxwjzL1t+toYwd6L2DIYjVHHLwva2GysLt7EegK3YuJMh4KLs1Wp/qX+dnYacjhMUvIkTUzPTJ+1D3YWoJUDAb84pV54hz191ppWh4KVfMbHlXIGI3NRU06bRDXJLG4wFpH9yrbK1DjEDFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TO8KEY3g; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7024cd9dd3dso876899b3a.3
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 08:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717686209; x=1718291009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jwC5YEDMskJq3diNklq/1nR6Hy9TYkeOXFQhqyPobY=;
        b=TO8KEY3gWQCwagUX14eRU8n6eNnfu7PlM7Clg4IEhzYWqlvqPGpeiGmmQYrlqTK9jE
         j0RU2/WQytLHYwXNiIYe+/KMlojXv56lBNu0A7EK2rB0nCl3FV3/cD8D3kNq0RnoxBor
         EX2UbPIb3PtYfanxBG9FZNj6g9dnf0YuRtyyHrlE/d5ZNz1KapLPfDbUt2sGlsiXh0C8
         z1XZv6YhmesmIS4cfXKtiDQpwNKas0b+u7/z9SRRX4kbOv2PVcO3JiRkdi+vO7pMnvWU
         QwWy7ZlnXmRmsniVxNtDec1ONaNxxViK8B5kX9ObhxgWAweywYI6i/SNd6B/KthxMCGQ
         Cbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717686209; x=1718291009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jwC5YEDMskJq3diNklq/1nR6Hy9TYkeOXFQhqyPobY=;
        b=lWQ4OrUW1kLPB8kGVFAR6ldFa/IEVKA08B9XT+dU/ukwLhD/oQNNb+wdEolrcR66A8
         Zdm0aFh33467zNQOPXBy6jbuP/NtYOJFL/qLiXXACnU63nXDCgtSmyQO5v1FkGAKXKBn
         Gv6In4NpcsGuOkTR/bwO+P3eLsB5JVAOCt8G3biuJ4zUJUz1dcBCAIzyH97JFePrIs0h
         bnz2JqPhItpF2nntgIrwtJkR6BRx64V3yZDxLkbaZ3SR9hBOFDm43/DiW55DHCVdQcwT
         6islhOgkg4008tKmZj4GjdQnF+uG+QQawz+aQex0FrN2mbBBO4TnjRwoZZsiC/6THykH
         E5xg==
X-Gm-Message-State: AOJu0YwYtlHs3kgjOcAaLeWqftu+twA2RCa8SYA32QL6TBVg1BdsicOx
	dcVj/Qh74eGaNPQvYdFn0kStKHaNDiPg5esfWT64DyT6KtJdFeKt
X-Google-Smtp-Source: AGHT+IHuZBaGeY0uixRNmsDOro3RnfvbRr9VDJukjHR0msFIHJok6h2jUDvWiYdrdRTVVJktxwpmVw==
X-Received: by 2002:a05:6a20:2447:b0:1b0:25b6:a749 with SMTP id adf61e73a8af0-1b2b70fd7aamr6068451637.48.1717686208875;
        Thu, 06 Jun 2024 08:03:28 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de264ae03csm1215853a12.68.2024.06.06.08.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 08:03:28 -0700 (PDT)
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
Subject: [PATCH net-next 2/2] tcp: fix showing wrong rtomin in snmp file when setting sysctl_tcp_rto_min_us
Date: Thu,  6 Jun 2024 23:03:07 +0800
Message-Id: <20240606150307.78648-3-kerneljasonxing@gmail.com>
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

A few days ago, sysctl_tcp_rto_min_us has been introduced to allow user to
tune the rto min value per netns. But the RtoMin field in /proc/net/snmp
should have been adjusted accordingly. Or else, it will show 200 which is
TCP_RTO_MIN.

This patch can show the correct value even when user sets though using both
'ip route' and 'sysctl -w'. The priority from high to low like what
tcp_rto_min() shows to us is:
1) ip route option rto_min
2) icsk->icsk_rto_min

Fixes: f086edef71be ("tcp: add sysctl_tcp_rto_min_us")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/proc.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index ce387081a3c9..4aeef3118442 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -409,6 +409,19 @@ static int snmp_seq_show_ipstats(struct seq_file *seq, void *v)
 	return 0;
 }
 
+static void snmp_seq_show_tcp_rtomin(struct seq_file *seq, struct net *net,
+				     unsigned long val)
+{
+	int sysctl_rtomin = READ_ONCE(net->ipv4.sysctl_tcp_rto_min_us);
+
+	if (tcp_rtax_rtomin)
+		seq_printf(seq, " %u", tcp_rtax_rtomin);
+	else if (sysctl_rtomin != jiffies_to_usecs(TCP_RTO_MIN))
+		seq_printf(seq, " %lu", usecs_to_jiffies(sysctl_rtomin));
+	else
+		seq_printf(seq, " %lu", val);
+}
+
 static int snmp_seq_show_tcp_udp(struct seq_file *seq, void *v)
 {
 	unsigned long buff[TCPUDP_MIB_MAX];
@@ -429,8 +442,7 @@ static int snmp_seq_show_tcp_udp(struct seq_file *seq, void *v)
 		if (snmp4_tcp_list[i].entry == TCP_MIB_MAXCONN)
 			seq_printf(seq, " %ld", buff[i]);
 		else if (snmp4_tcp_list[i].entry == TCP_MIB_RTOMIN)
-			seq_printf(seq, " %lu",
-				   tcp_rtax_rtomin ? tcp_rtax_rtomin : buff[i]);
+			snmp_seq_show_tcp_rtomin(seq, net, buff[i]);
 		else
 			seq_printf(seq, " %lu", buff[i]);
 	}
-- 
2.37.3


