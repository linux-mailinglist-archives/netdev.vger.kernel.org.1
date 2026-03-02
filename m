Return-Path: <netdev+bounces-262776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAxeHpvTpWmvHAAAu9opvQ
	(envelope-from <netdev+bounces-262776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 19:14:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D19981DE4DB
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 19:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E321A3058DE0
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 18:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C256B337BA3;
	Mon,  2 Mar 2026 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="haQF2xy7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DE633509B
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772475278; cv=none; b=l4JG2jq9enTHyaXF1IlyfWbr8DXaArauw7L9alqh7r0Nk5e9yc1weDvVMOvGhemL2O7fQ6/UzhB+yB1skTtzp6z19WcRgw2hICY+07G4wi4mJhf7sVgQTP240juQaEBKrM/BIAQRZJhSVtWLjb0SqeHBOlp48aNZ8k++ZHRSqwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772475278; c=relaxed/simple;
	bh=gHQE9PJBs5YibR5ZX+P43LUxEImbIRFyIanyDFA34d4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y2s91SumFLc7Xb++gejv4LHaKGsEJ0MzF/3zHKK+/SLatWY0wr1v/id/Nf5OWZzFAVXvPK3qqs0rkBEgAUvOjPcTQHZaOEPN47BYx3xD72jy+OvnJTlV0xJKbfDpEwboEQmLWt+VZhrhkeCA3e7W9rACFnTaqh2yEkzUoLHjVg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=haQF2xy7; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50335bd75bdso458475011cf.0
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 10:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772475276; x=1773080076; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+hnl2+tOrDl+viUfn1bt+UhrtPdai8Y/6jthVt+Pk8s=;
        b=haQF2xy7yBSvOG5w6XJf8p5VS3ZTHGh0VEil7rC1qJanUuUbyigaBrXd3eAdGtH2U3
         38op6ur7SFVWr4FKrfJysGYVzh6AVUI0IO2C1GP+UepdK+fCSL8SN7nq71ocFLgnui8q
         XmSh2ljlnx5ArGwgwToJlPJoe/oCcb4hLtbmaWbLIwU0oxcShQjlgO0veYzGiC44DZLi
         gIFPQzM6SQ5n1Kzc8pDkEiENbAe+dy0Y48iY2YDhmMhRW38nNvPRsjq2IDnEMXGDbr9+
         Hg3lLZ9SnXlnb1ctU7Z/oarZ9G2+o1cEMVKZgZJw61vgVLUWSEwJlzFKnVqZEqvUa27b
         MstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772475276; x=1773080076;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hnl2+tOrDl+viUfn1bt+UhrtPdai8Y/6jthVt+Pk8s=;
        b=wWSm2Tvz/bOItbWEIIeZyYFIbHp/3+x3XnPEt0s78pkSFyHzCMNjyck9jAZlcFynfi
         PfYcSs23CtCbNvjw2du0alz83R+vKKi6/arYxmiIZxlTb5t8w3P2WZUjzDRzUAJNiWmx
         yvRCptesBsDXwKfvLbdU0HulntDwiDM+48OTFJ2qLwdxgzsu8ojUw8ibFuDtincL0QVs
         gKF7F3Gxs75iU83+rRG30786iP14wARUsljEUB12UypoXRtEVYnhuE/lJfAdt11AHjlO
         MvNX5oDjh9e/RjBsMH2OZCT0yMI65eKmCY3AuU6BZm7FyrB9478ADQ8/VIwB5ZWwKfKK
         Wm4w==
X-Forwarded-Encrypted: i=1; AJvYcCX+VAQ3G4bDoud5iUJNmsUWKSZxg0G/WsO0SVWVvkr7JFpSw2vNgzh50T71goMdETegyg277OM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ptZQqfarAUGHhhrU8vHkKpBNYJopMpfjQ9X4Oq+OajSvi67R
	M/zkugF0Sokc/SoxIRw+bLPK7mlaYZhELpfDJyu3Rkr5Bq0X79YZqng/LxjVjwn8hcVPPnzHLy8
	M2kqHJM+y7u59fg==
X-Received: from qttr21.prod.google.com ([2002:ac8:7955:0:b0:506:d20d:b8b7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:58d0:0:b0:4f0:2afc:3b80 with SMTP id d75a77b69052e-5075289457amr174877461cf.56.1772475276035;
 Mon, 02 Mar 2026 10:14:36 -0800 (PST)
Date: Mon,  2 Mar 2026 18:14:26 +0000
In-Reply-To: <20260302181432.1836150-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260302181432.1836150-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260302181432.1836150-2-edumazet@google.com>
Subject: [PATCH v3 net-next 1/7] net: add rps_tag_ptr type and helpers
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D19981DE4DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262776-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add a new rps_tag_ptr type to encode a pointer and a size
to a power-of-two table.

Three helpers are added converting an rps_tag_ptr to:

1) A log of the size.

2) A mask : (size - 1).

3) A pointer to the array.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/rps-types.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 include/net/rps-types.h

diff --git a/include/net/rps-types.h b/include/net/rps-types.h
new file mode 100644
index 0000000000000000000000000000000000000000..6b90a66866c1f75dae768bed84a4eeb9ffb5fc1a
--- /dev/null
+++ b/include/net/rps-types.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _NET_RPS_TYPES_H
+#define _NET_RPS_TYPES_H
+
+/* Define a rps_tag_ptr:
+ * Low order 5 bits are used to store the ilog2(size) of an RPS table.
+ */
+typedef unsigned long rps_tag_ptr;
+
+static inline u8 rps_tag_to_log(rps_tag_ptr tag_ptr)
+{
+	return tag_ptr & 31U;
+}
+
+static inline u32 rps_tag_to_mask(rps_tag_ptr tag_ptr)
+{
+	return (1U << rps_tag_to_log(tag_ptr)) - 1;
+}
+
+static inline void *rps_tag_to_table(rps_tag_ptr tag_ptr)
+{
+	return (void *)(tag_ptr & ~31UL);
+}
+#endif /* _NET_RPS_TYPES_H */
-- 
2.53.0.473.g4a7958ca14-goog


