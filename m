Return-Path: <netdev+bounces-98365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0688D11A6
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 04:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50811F23206
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 02:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD16BE5D;
	Tue, 28 May 2024 02:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzllVhXJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAAABA41
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 02:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716862320; cv=none; b=mfIk+FhY/xrcUZJYHYmnSHv/2JKHMj/9wEb7R5cuofXENgK41zNNBqbecAsBfmSEeaHhAlgTRQceL3BghhL3ZQFOpuYV9wa2rKERDBCkueRVsCGBkOTRC3qopVYsUDwfz6CawmnY53VmvXnxpUcNlK0pgjnSSP3hgs2CzTIcgxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716862320; c=relaxed/simple;
	bh=DILAFSaIB8Zonx+zUSBYgfTXqZxPgnJXY6VsrQsNbUw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TqihFU0qkctOXgEvlhBfsr3bfkub1IQb2mK9VxqwEg3pP5V/7HUxoegZ0WiuIQsewLFjF3vDYpO3oAI+jYJu1TwdjCJD/fw9rabEPH1ikgKw3U+x2RSst4i/rGYA0tiBeGSkut0omc7p8PC2IApHtC8SjVBGV64O1LX75nqghIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzllVhXJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f44b441b08so2428035ad.0
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 19:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716862318; x=1717467118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TMTVJ9VmCl5Obe+Blb0eZZ3+W7i/Oy+EbfXZVNp8N3U=;
        b=RzllVhXJw05jectcPauROvyN5CRrLuox9dUDcsuf8tRDUXKaheuhgsyie8ZpP27Sns
         K9LwTnvYHTLru+lQh2IDEHcIwddOr4DQXmOndVYRrewhNLRyURwN98wmnJ9Qz+lcuBdJ
         WTEF8cegX3QYyCwrU4879T6Zgk7cD8A+bg8GJyczEPG228AzgZrVYMdJOccXQJ46xvgL
         xZzURqX4FR6c/TdtoQxMi6pr9RXi5YO38IFLmDkn4Vczt1loI5OLEeXtlVEi2MZJRyct
         itIeONg34awQmJgkcfw3uWBtO+MtxDTg8G3NH3TI7mM9KuPkVmDprqTu63SwWw/SyTcu
         M/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716862318; x=1717467118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMTVJ9VmCl5Obe+Blb0eZZ3+W7i/Oy+EbfXZVNp8N3U=;
        b=fGlXMD9aALqbf5puYTgUib0bBmHXhjpYIRSuJmbEsTTq0x0t4KA8cTRgsZBq7D1dF3
         ifN6m+5g7S3UmBPEZcGpMY8J/sebfzyO5s79RoIA12ItDUlyaD1jvQDHOQH1NxUgE8mA
         ylomfGczeeldaL8xJR/4IoAtYuLQs42n7wmsaHpsdkoVhXo8wRqz6jq1+kgEtSIXzRcg
         JEzAjd2RObpD2I2jac8wcVfFfIGvT15fbRGUBtG2e0kdEKngADg56N4aB19EYP1YnbMz
         yJ79ZuSYYROBNh13Eb2acRcBT2iJx/SM+gt3MTA8nLhyXnjONDWSsZs0/0EAgFVL/4HT
         6MgA==
X-Gm-Message-State: AOJu0YwNFWRKxrprBZTsMvjN5WmlLwQiuqs3tg29LA68SoZZcaIKpOLF
	1ZgCP2kS+4l6ilLQiFfMad6FQTu4tTOY0138rQwkkmYTOE1DLyLO
X-Google-Smtp-Source: AGHT+IHlKFlHVFOGRVs79Yr29gXvtEQ1Em+ieb/TpIdHsLZade0GteWpmq2GBgtwnSNDSJpGmid4qg==
X-Received: by 2002:a17:902:ea0b:b0:1ef:9b6:d03d with SMTP id d9443c01a7336-1f4498f3782mr117456405ad.57.1716862317875;
        Mon, 27 May 2024 19:11:57 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c967a45sm68297275ad.167.2024.05.27.19.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 19:11:57 -0700 (PDT)
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
Subject: [PATCH net-next] tcp: introduce a new MIB for CLOSE-WAIT sockets
Date: Tue, 28 May 2024 10:11:49 +0800
Message-Id: <20240528021149.6186-1-kerneljasonxing@gmail.com>
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
like user application mistakenly handling close() syscall.

We want to trace this total number of CLOSE-WAIT sockets fastly and
frequently instead of resorting to displaying them altogether by using:

  netstat -anlp | grep CLOSE_WAIT

or something like this, which does harm to the performance especially in
heavy load. That's the reason why I chose to introduce this new MIB counter
like CurrEstab does. It do help us diagnose/find issues in production.

Besides, in the group of TCP_MIB_* defined by RFC 1213, TCP_MIB_CURRESTAB
should include both ESTABLISHED and CLOSE-WAIT sockets in theory:

  "tcpCurrEstab OBJECT-TYPE
   ...
   The number of TCP connections for which the current state
   is either ESTABLISHED or CLOSE- WAIT."

Apparently, at least since 2005, we don't count CLOSE-WAIT sockets. I think
there is a need to count it separately to avoid polluting the existing
TCP_MIB_CURRESTAB counter.

After this patch, we can see the counter by running 'cat /proc/net/netstat'
or 'nstat -s | grep CloseWait'

Suggested-by: Yongming Liu <yomiliu@tencent.com>
Suggested-by: Wangzi Yong <curuwang@tencent.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/uapi/linux/snmp.h | 1 +
 net/ipv4/proc.c           | 1 +
 net/ipv4/tcp.c            | 2 ++
 3 files changed, 4 insertions(+)

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
index 681b54e1f3a6..7abaa2660cc8 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2659,6 +2659,8 @@ void tcp_set_state(struct sock *sk, int state)
 	default:
 		if (oldstate == TCP_ESTABLISHED)
 			TCP_DEC_STATS(sock_net(sk), TCP_MIB_CURRESTAB);
+		if (state == TCP_CLOSE_WAIT)
+			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPCLOSEWAIT);
 	}
 
 	/* Change state AFTER socket is unhashed to avoid closed
-- 
2.37.3


