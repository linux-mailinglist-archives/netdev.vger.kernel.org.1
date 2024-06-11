Return-Path: <netdev+bounces-102763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0459047DB
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 01:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0981C22D4C
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 23:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623B8157495;
	Tue, 11 Jun 2024 23:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="naAs/BEb"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9B0156C7B;
	Tue, 11 Jun 2024 23:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718150069; cv=none; b=DU19Ajeyrq6+AMlJcUqngAT/izESzg5FUnMxAP6yXXBwSzpHuy/H+zjAyUBBBknHQAhndhCH13NcwN9c3zCm8ud9CVsuUjYXYMm409LOvPemEHPn3pP4rX6OYnPB2hWB/PRtpjejP84dPY+LRD/zSYoEqjsHd4scvhd3cSRBkxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718150069; c=relaxed/simple;
	bh=18R9DZ9Qtk5UItDyEfDP4dTxRsB0nI9DrG9sBUtKLCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ukzjBnUAShb7ofllt2wr562g9Z9bV21qCdXpsRFBCSHOaumjuL2LEWkf52p13mAClx68a0gISNf/5dCZ4k/edRbblsBdG0fYZax8akEkfoPsbv7TQUdLf2Gx09W0weQJl6HQ1pDaRaKYVJKu3wiZm9BuCL9KH2qhRTJAI3RO6AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=naAs/BEb; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1718150060;
	bh=18R9DZ9Qtk5UItDyEfDP4dTxRsB0nI9DrG9sBUtKLCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=naAs/BEb1VzBfR9c6dqqLneOPn1PgHf+O4+JG6fuzJOpY30iAlF4tBQA49sN3k7iv
	 5O71nULH+0G5AWKwTsDqwp6v5oiic0uSzem9pCTxLzRgTlj4Wb04tbZhyLR9iaj1bN
	 dipUasOTa9rOCKu16Q3EzGfiHcbC7DeIhC3eeIjLJ6QzEY2kIWvo24pHkDNMOoaixY
	 jtWw3EnZtCdsvvAzbeKVsQfeZd41R9VWOxajn+WDrq4lwHySLs0i6KcfuhXmIJ+gJc
	 QkdAASQomV3FsJLPGf5QEl7c+hT5OBqY3uroxICqHDx41XyT89ExnYlhhCCK6qhYyB
	 Dl94sfReVOcMQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 4A3F060099;
	Tue, 11 Jun 2024 23:54:17 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 5BF8E201ACA; Tue, 11 Jun 2024 23:54:00 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Davide Caratti <dcaratti@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 1/9] net/sched: flower: define new tunnel flags
Date: Tue, 11 Jun 2024 23:53:34 +0000
Message-ID: <20240611235355.177667-2-ast@fiberby.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611235355.177667-1-ast@fiberby.net>
References: <20240611235355.177667-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Define new TCA_FLOWER_KEY_FLAGS_* flags for use in struct
flow_dissector_key_control, covering the same flags
as currently exposed through TCA_FLOWER_KEY_ENC_FLAGS,
but assign them new bit positions in so that they don't
conflict with existing TCA_FLOWER_KEY_FLAGS_* flags.

Synchronize FLOW_DIS_* flags, but put the new flags
under FLOW_DIS_F_*. The idea is that we can later, move
the existing flags under FLOW_DIS_F_* as well.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 include/net/flow_dissector.h | 17 +++++++++++++----
 include/uapi/linux/pkt_cls.h |  5 +++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index 99626475c3f4a..1f0fddb29a0d8 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -16,7 +16,8 @@ struct sk_buff;
  * struct flow_dissector_key_control:
  * @thoff:     Transport header offset
  * @addr_type: Type of key. One of FLOW_DISSECTOR_KEY_*
- * @flags:     Key flags. Any of FLOW_DIS_(IS_FRAGMENT|FIRST_FRAGENCAPSULATION)
+ * @flags:     Key flags.
+ *             Any of FLOW_DIS_(IS_FRAGMENT|FIRST_FRAGENCAPSULATION|F_*)
  */
 struct flow_dissector_key_control {
 	u16	thoff;
@@ -24,9 +25,17 @@ struct flow_dissector_key_control {
 	u32	flags;
 };
 
-#define FLOW_DIS_IS_FRAGMENT	BIT(0)
-#define FLOW_DIS_FIRST_FRAG	BIT(1)
-#define FLOW_DIS_ENCAPSULATION	BIT(2)
+/* Please keep these flags in sync with TCA_FLOWER_KEY_FLAGS_*
+ * in include/uapi/linux/pkt_cls.h, as these bit flags are exposed
+ * to userspace in some error paths, ie. unsupported flags.
+ */
+#define FLOW_DIS_IS_FRAGMENT		BIT(0)
+#define FLOW_DIS_FIRST_FRAG		BIT(1)
+#define FLOW_DIS_ENCAPSULATION		BIT(2)
+#define FLOW_DIS_F_TUNNEL_CSUM		BIT(3)
+#define FLOW_DIS_F_TUNNEL_DONT_FRAGMENT	BIT(4)
+#define FLOW_DIS_F_TUNNEL_OAM		BIT(5)
+#define FLOW_DIS_F_TUNNEL_CRIT_OPT	BIT(6)
 
 enum flow_dissect_ret {
 	FLOW_DISSECT_RET_OUT_GOOD,
diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index b6d38f5fd7c05..24795aad76518 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -677,6 +677,11 @@ enum {
 enum {
 	TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT = (1 << 0),
 	TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST = (1 << 1),
+	/* FLOW_DIS_ENCAPSULATION (1 << 2) is not exposed to userspace */
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_CSUM = (1 << 3),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_DONT_FRAGMENT = (1 << 4),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_OAM = (1 << 5),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_CRIT_OPT = (1 << 6),
 };
 
 enum {
-- 
2.45.1


