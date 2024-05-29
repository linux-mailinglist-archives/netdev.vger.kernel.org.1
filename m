Return-Path: <netdev+bounces-98863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D868D2B80
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 05:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF66BB23DEE
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 03:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2025315B13B;
	Wed, 29 May 2024 03:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMoZFPRB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E6215B150
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 03:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716953473; cv=none; b=EJbtkCueVq7Rysqr3en/7jH9QqKNzX+ug+PUhpVfmajrlw2V+o4DZcxVrPkshlEDe0tiEl53+JRWdmOBiqsIAGefnRM8Oi2E9bwlsmJvNxRWh+n5ljAWmF69NwR6aTXTcXf9DG8xjkgRAxO4HFvxTGvlhkJi+VSZ8RbzFRR5Y1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716953473; c=relaxed/simple;
	bh=b3hqvdDzPxjpCrgkSnRFy45MmR+l+be2AbmhlHTgFKE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WwaF6gVShzvuiAsnxSVH4iTxloky58kbN8XSY5S5Dc4//82tWfr4e0iSG/Aeuxnc/cHw/H0zz3f/T5myNedyF/l22uiuveoMFCguHKvMBVLRlFu1Om/byxgWq3tMtjgDN07MH9Fa0pD4iY7pTp+al9vAcBNRiQkzXLnZ+lqB4Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMoZFPRB; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f480624d0fso13011875ad.1
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 20:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716953471; x=1717558271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+i3usV4p7Z+Ls+/K0SMlIGYcyxbAJxritsP/WdKkrXw=;
        b=SMoZFPRBW8cRKuplG52UQbJJpB9qaDXqdPB+lTCVOePszIeZ0EoyB4QgWHYPjDjRYW
         EIWGTp8SJ/4ex2h//j8CGek52f7d00zGuqoOnbMvotK1UU2IEN8bvx4gA6cf6b9R8PNj
         gqrtEtJZXgqsCjUU3OzFuUHodduRVxYa1ugMpUfpBbH/ujauSqYHXCJuA72kpVTqeDWC
         HPPi1mBNdqCSeRc+vlz1BI+Yc8FFlarWwvBYhx7s4bIeq085luIRaMeCrUD5it2Y27dU
         HeXUFbSQK0O8HY/5/8L54f9o1rLUtKVBL1fZQ4JwW1UA5cR46QJJejsKmHvtKd21O/tr
         nZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716953471; x=1717558271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+i3usV4p7Z+Ls+/K0SMlIGYcyxbAJxritsP/WdKkrXw=;
        b=kH596DPs5SM2G5i9vZU6qUko4TYgXSQ6nNt4loZ4wyz+whtalwFmWLq8eFiEs/fieU
         YPaYMngoFMeFdyuQVrE0Y4x1Afa5UCSNsAMxbs8++sj/4zjYytlDt6mhgG60TrGW8Nyw
         VZM2UDK8gAiBhVHkAPIWhr6qDsVNxS0B7eOgTApyR7VnNHma04vbWOr4o0lU3Q57wgcV
         0XMt++4Uo9GnhdHtkXdo9TXvJ6sZDvhyYCh7HBunu5cPsIZwhpwCevuFA/w4ySzemqoT
         Iky+IexXuAarRTH77GHDwNKCIM7dkHYpl3mwx1dMPNGlf7PfMZ0MhQhE7Vv12V1GRK0A
         oHRA==
X-Gm-Message-State: AOJu0YzVvnbmZ7Q/ADCGqIEDToXkX8AnljYrWoU6ftueFfHHGMIGCRJ4
	AFTa0XX5m+kH1WqJsMYCddaRFyWZlR2ZARDy62d91hxNCYyWPuRa
X-Google-Smtp-Source: AGHT+IHfsWm05YLINaZT1EtKbTWtDyEuCI/5DotJ8WOewZZCQRdi4grk7TeM5JqZZjPDF4eoqFSmOQ==
X-Received: by 2002:a17:902:cec4:b0:1f3:a14:5203 with SMTP id d9443c01a7336-1f448d30a54mr154135985ad.38.1716953470742;
        Tue, 28 May 2024 20:31:10 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c99d23asm90578125ad.208.2024.05.28.20.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 20:31:10 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>,
	Yongming Liu <yomiliu@tencent.com>,
	Wangzi Yong <curuwang@tencent.com>
Subject: [PATCH v2 net-next] tcp: introduce a new MIB for CLOSE-WAIT sockets
Date: Wed, 29 May 2024 11:31:04 +0800
Message-Id: <20240529033104.33882-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

CLOSE-WAIT is a relatively special state which "represents waiting for
a connection termination request from the local user" (RFC 793). Some
issues may happen because of unexpected/too many CLOSE-WAIT sockets,
like user application mistakenly handling close() syscall. It's a very
common issue in the real world.

We want to trace this total number of CLOSE-WAIT sockets fastly and
frequently instead of resorting to displaying them altogether by using:

  ss -s state close-wait

or something like this. They need to loop and collect required socket
information in kernel and then get back to the userside for print, which
does harm to the performance especially in heavy load for frequent
sampling.

That's the reason why I chose to introduce this new MIB counter like
CurrEstab does. With this counter implemented, we can record/observe the
normal changes of this counter all the time. It can help us:
1) We are able to be alerted in advance if the counter changes drastically.
2) If some users report some issues happening, we will particularly
pay more attention to it.

Besides, in the group of TCP_MIB_* defined by RFC 1213, TCP_MIB_CURRESTAB
should include both ESTABLISHED and CLOSE-WAIT sockets in theory:

  "tcpCurrEstab OBJECT-TYPE
   ...
   The number of TCP connections for which the current state
   is either ESTABLISHED or CLOSE- WAIT."

However, the thing is we don't do that according to RFC. The reason is
unknown. At least since 2005, we should have counted CLOSE-WAIT sockets
I think, there is a need to finish the work as RFC says. It's definitely
not a bad thing.

After this patch, we can see the counter by running 'cat /proc/net/netstat'
or 'nstat -s | grep CloseWait'

Suggested-by: Yongming Liu <yomiliu@tencent.com>
Suggested-by: Wangzi Yong <curuwang@tencent.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v2
Link: https://lore.kernel.org/all/20240528021149.6186-1-kerneljasonxing@gmail.com/
1. revise the commit message to let other developers know what the use of
such a new counter.
2. introduce a decrement-counter help so that this new counter can do the
same thing as CurrEstab does. It's also the same as what I implemented locally.

BTW, I just finish implementing the correct snmp based on the RFC. Is it really so
hard to count close-wait sockets? I wondered... Any suggestions are welcome.

Thanks in advance.
---
 include/net/ip.h          | 1 +
 include/uapi/linux/snmp.h | 1 +
 net/ipv4/proc.c           | 1 +
 net/ipv4/tcp.c            | 5 +++++
 4 files changed, 8 insertions(+)

diff --git a/include/net/ip.h b/include/net/ip.h
index 6d735e00d3f3..0fe2994796b0 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -298,6 +298,7 @@ void ip_send_unicast_reply(struct sock *sk, struct sk_buff *skb,
 #define IP_UPD_PO_STATS(net, field, val) SNMP_UPD_PO_STATS64((net)->mib.ip_statistics, field, val)
 #define __IP_UPD_PO_STATS(net, field, val) __SNMP_UPD_PO_STATS64((net)->mib.ip_statistics, field, val)
 #define NET_INC_STATS(net, field)	SNMP_INC_STATS((net)->mib.net_statistics, field)
+#define NET_DEC_STATS(net, field)	SNMP_DEC_STATS((net)->mib.net_statistics, field)
 #define __NET_INC_STATS(net, field)	__SNMP_INC_STATS((net)->mib.net_statistics, field)
 #define NET_ADD_STATS(net, field, adnd)	SNMP_ADD_STATS((net)->mib.net_statistics, field, adnd)
 #define __NET_ADD_STATS(net, field, adnd) __SNMP_ADD_STATS((net)->mib.net_statistics, field, adnd)
diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index adf5fd78dd50..c0feefb4d88b 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -302,6 +302,7 @@ enum
 	LINUX_MIB_TCPAOKEYNOTFOUND,		/* TCPAOKeyNotFound */
 	LINUX_MIB_TCPAOGOOD,			/* TCPAOGood */
 	LINUX_MIB_TCPAODROPPEDICMPS,		/* TCPAODroppedIcmps */
+	LINUX_MIB_TCPCLOSEWAIT,			/* TCPCloseWait */
 	__LINUX_MIB_MAX
 };
 
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index 6c4664c681ca..964897dc6eb8 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -305,6 +305,7 @@ static const struct snmp_mib snmp4_net_list[] = {
 	SNMP_MIB_ITEM("TCPAOKeyNotFound", LINUX_MIB_TCPAOKEYNOTFOUND),
 	SNMP_MIB_ITEM("TCPAOGood", LINUX_MIB_TCPAOGOOD),
 	SNMP_MIB_ITEM("TCPAODroppedIcmps", LINUX_MIB_TCPAODROPPEDICMPS),
+	SNMP_MIB_ITEM("TCPCloseWait", LINUX_MIB_TCPCLOSEWAIT),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 681b54e1f3a6..3908ea7fd14a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2661,6 +2661,11 @@ void tcp_set_state(struct sock *sk, int state)
 			TCP_DEC_STATS(sock_net(sk), TCP_MIB_CURRESTAB);
 	}
 
+	if (state == TCP_CLOSE_WAIT)
+		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPCLOSEWAIT);
+	if (oldstate == TCP_CLOSE_WAIT)
+		NET_DEC_STATS(sock_net(sk), LINUX_MIB_TCPCLOSEWAIT);
+
 	/* Change state AFTER socket is unhashed to avoid closed
 	 * socket sitting in hash tables.
 	 */
-- 
2.37.3


