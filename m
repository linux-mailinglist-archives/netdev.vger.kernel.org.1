Return-Path: <netdev+bounces-61524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 886D38242CF
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4121F249FA
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 13:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8456D20B2C;
	Thu,  4 Jan 2024 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="IixK2XtS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852A42231B
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3366e78d872so445817f8f.3
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 05:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1704375768; x=1704980568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j9AXaxlLDeS6VDdELYsCM+nn/g32Pw4NCE8o6pBpkds=;
        b=IixK2XtSeNonDYWp3OUo7L6ncMUOLo8AtAx5/2MLufSe5HYIZSLT7t5VDLL11oBxVT
         J/3xRVwrWdZEJVPaBJB2N8ksjjwDoHKQzVBkzbv9C6hyG2Y9dMRu6pnA4+a0kLWxVr+j
         jHWQ7xLXsY0uLmhEB/8gXCqBXybzUJa/qf7Gr9+o54uLtz4YB3yJe5wHw/rJxsDZGv3m
         nXCqfPejbBfY5/NvB59kQ4GWsOUNFe+bwlw2cGPS0/d+cHh7Du5Vobt00N47xK6gxK3x
         89MJeIilVtjEVlhkSRsf+fJ77BbRFOC6zp2Wxh5pLYxVnj91ougNf+ssoXgiR5kLJq0c
         7KhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704375768; x=1704980568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j9AXaxlLDeS6VDdELYsCM+nn/g32Pw4NCE8o6pBpkds=;
        b=Q2iCJVqwvQxHW8KcLwV9di+G+ruaUjO2/EeI4wbBTCy4r95amJD+cNi2xwhXV7UrKH
         fV98CHA8h7XWjr3iiwkTKch601qOoeeXl0SYUryVSrc1Krxg+M2SwywNZS3stpvpCEIy
         XfmEXc5CibWs6uEF00KJz38GojEGYOAX4IksxYLumXmPTwAbpPe6URUGyEuffHSWFLW+
         ppAxDzDrXA2HB1UQifSpO+QmWNYfDAkNoRf8urIWQKuMKxu2OSLVKZ1xYeAg7oBdGiw4
         OMbsDX0G8svWni3/pFH1+nZzsYHT/cfaFUhYxozAs6zXkn15KgBk0zSqEptmOoJqK0GR
         ivwQ==
X-Gm-Message-State: AOJu0YzceL1ok9Ox4vRhzyh13Ta1Cq+OX6AtpUtInFrcGJuxz10nt/nA
	6twKTUfI0qI4INlqbIcXf05eYNpY0VaV
X-Google-Smtp-Source: AGHT+IHpd9d2yWBzoUqloGVgm+uYvufN/oVb+p9qzhFHGcGKhl/rJb6lSVZIqnKRmUAl2VAP7oDreQ==
X-Received: by 2002:adf:ce0a:0:b0:337:509c:f1c3 with SMTP id p10-20020adfce0a000000b00337509cf1c3mr212233wrn.246.1704375767628;
        Thu, 04 Jan 2024 05:42:47 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id d5-20020adffbc5000000b00336e69fbc32sm21541136wrs.102.2024.01.04.05.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 05:42:46 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Dmitry Safonov <dima@arista.com>,
	Christian Kujau <lists@nerdbynature.de>,
	Salam Noureddine <noureddine@arista.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/tcp: Only produce AO/MD5 logs if there are any keys
Date: Thu,  4 Jan 2024 13:42:39 +0000
Message-ID: <20240104-tcp_hash_fail-logs-v1-1-ff3e1f6f9e72@arista.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704375759; l=3073; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=FkIXdUprtZtT0poNW5KGyK5Jva2dgtSt2cATJdkaFpU=; b=GVlKradT8/MOHHeyrchyDm29qzSGUs85gwXaNbFlXXpDYlz+ROBEMNh1j37XPyul2c59ZLZIi 10pQwRCwPCBC1QtAQMfwB5b4e7w6EHW+rJXbtDyc6j2S4zWWtdTfF7Y
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

User won't care about inproper hash options in the TCP header if they
don't use neither TCP-AO nor TCP-MD5. Yet, those logs can add up in
syslog, while not being a real concern to the host admin:
> kernel: TCP: TCP segment has incorrect auth options set for XX.20.239.12.54681->XX.XX.90.103.80 [S]

Keep silent and avoid logging when there aren't any keys in the system.

Side-note: I also defined static_branch_tcp_*() helpers to avoid more
ifdeffery, going to remove more ifdeffery further with their help.

Reported-by: Christian Kujau <lists@nerdbynature.de>
Closes: https://lore.kernel.org/all/f6b59324-1417-566f-a976-ff2402718a8d@nerdbynature.de/
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/net/tcp.h    |  2 --
 include/net/tcp_ao.h | 26 +++++++++++++++++++++++---
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 144ba48bb07b..87f0e6c2e1f2 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1788,8 +1788,6 @@ struct tcp_md5sig_key *tcp_v4_md5_lookup(const struct sock *sk,
 					 const struct sock *addr_sk);
 
 #ifdef CONFIG_TCP_MD5SIG
-#include <linux/jump_label.h>
-extern struct static_key_false_deferred tcp_md5_needed;
 struct tcp_md5sig_key *__tcp_md5_do_lookup(const struct sock *sk, int l3index,
 					   const union tcp_md5_addr *addr,
 					   int family, bool any_l3index);
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 647781080613..b04afced4cc9 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -127,12 +127,35 @@ struct tcp_ao_info {
 	struct rcu_head		rcu;
 };
 
+#ifdef CONFIG_TCP_MD5SIG
+#include <linux/jump_label.h>
+extern struct static_key_false_deferred tcp_md5_needed;
+#define static_branch_tcp_md5()	static_branch_unlikely(&tcp_md5_needed.key)
+#else
+#define static_branch_tcp_md5()	false
+#endif
+#ifdef CONFIG_TCP_AO
+/* TCP-AO structures and functions */
+#include <linux/jump_label.h>
+extern struct static_key_false_deferred tcp_ao_needed;
+#define static_branch_tcp_ao()	static_branch_unlikely(&tcp_ao_needed.key)
+#else
+#define static_branch_tcp_ao()	false
+#endif
+
+static inline bool tcp_hash_should_produce_warnings(void)
+{
+	return static_branch_tcp_md5() || static_branch_tcp_ao();
+}
+
 #define tcp_hash_fail(msg, family, skb, fmt, ...)			\
 do {									\
 	const struct tcphdr *th = tcp_hdr(skb);				\
 	char hdr_flags[6];						\
 	char *f = hdr_flags;						\
 									\
+	if (!tcp_hash_should_produce_warnings())			\
+		break;							\
 	if (th->fin)							\
 		*f++ = 'F';						\
 	if (th->syn)							\
@@ -159,9 +182,6 @@ do {									\
 
 #ifdef CONFIG_TCP_AO
 /* TCP-AO structures and functions */
-#include <linux/jump_label.h>
-extern struct static_key_false_deferred tcp_ao_needed;
-
 struct tcp4_ao_context {
 	__be32		saddr;
 	__be32		daddr;

---
base-commit: ac865f00af293d081356bec56eea90815094a60e
change-id: 20240104-tcp_hash_fail-logs-daa1a4dde694

Best regards,
-- 
Dmitry Safonov <dima@arista.com>


