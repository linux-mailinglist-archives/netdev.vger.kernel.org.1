Return-Path: <netdev+bounces-262436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBe3BFWCpGnOiwUAu9opvQ
	(envelope-from <netdev+bounces-262436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 19:15:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DF51D10ED
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 19:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B899301CCC9
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 18:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17564337BBD;
	Sun,  1 Mar 2026 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dx8UkFh/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66D9320CCC
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 18:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772388903; cv=none; b=QkAGDhjJuGJ3jBI3SEMT2LQxVu2sK5LIyABSlXgJgaApxpsqDx0elMTh4GKFHKfwifnvUpyoPtTxN92ipUlDDEhZ+Vxd5AjtFUC8rt2JngANX4/vo2wTSA/Y1zZwTl5LvePNbnmqCn0ncau1w1z4VaKqKy+ElpLC9Tn9n/UU2VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772388903; c=relaxed/simple;
	bh=gHQE9PJBs5YibR5ZX+P43LUxEImbIRFyIanyDFA34d4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fF/oAI3ZnzV1BqRquTdANrAFsQNqzBJc70iROcgKKyaRijzmtcb9nGi7MmttvNoc46Gn9M2bnZPrAAwcJuywVmpw6U2/Jf+3TwU+nYOhv4Z7n4gW9Z7nYg77SGW4666IQGplSaNBuFXAXXHd4bp3OcbKUeuUVqbrFKJaYyOIKgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dx8UkFh/; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-506ae021853so322628111cf.1
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 10:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772388900; x=1772993700; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+hnl2+tOrDl+viUfn1bt+UhrtPdai8Y/6jthVt+Pk8s=;
        b=dx8UkFh/nrucXd3dI3MRp55BNvcxs2/Ejytc8WeN76y8OVWG8RJNt+KhWTePw5nIJV
         EMKTZKTDbgsT8tAgvnyh81MHZOLoCr5vps/6aROB8PCJhhS3B6V8x+ttXEPuTUODaEf4
         7o98bscpSfQyNJFFRI+MgjIKJuHs4yetshDdeygNlp4wOMW6AUDKvibR+BK7uD38WFwu
         pkf/LiqQsJ4/NxLlXbzjkxWAmQhmaWBSziLDNT6K/4MpsHwp+DJ/s79jeCGBYWc1XemC
         +zYTcYRjyznyqZiHnA5B0OfGDZUBT9N6fKp09LOTP/MrdAmrcwHdhTHXCa729EHNndr2
         rQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772388900; x=1772993700;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hnl2+tOrDl+viUfn1bt+UhrtPdai8Y/6jthVt+Pk8s=;
        b=okPZBckpXJA2t8FCjWo0BzTkvVVR3r+Sxknii6oMxGlIwH2vZcAcyhH637kMhzKXUQ
         wtW31Vz94SF3/WWmu/bFSIf49kNhzDchqefBgqkbO6XjazIFlTvOMwHN2dksTOSh/txF
         ePiF4BJslNAzJHkTbRTy4RS5rfm5OPPpl6uZ4u0KgVhza6BR8zbCKGhGXDys4WbJervv
         l/AsvPXlcdrXCa3mIo76mg5WuySR9+5D8RjudhxNAcaOdcw7JHEbAK847be4ioqAhl5+
         suGf3gi9ijL96S8yjL29pUUycmYc4SJqIR0a70EwBELbK0kjvgR+H21cy9HfMi3o69WT
         O3EA==
X-Forwarded-Encrypted: i=1; AJvYcCX/+cf4suYM96Amgrtv/CbXlMP8Yx4DekshQVPwYcVpxmfHgbjGkUVs3gSRTkLQgn0gMPQR/aY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiJgc50Sc/VWGxuVBrT1kz9pgVGeG41Cc63ABN/AdxCOezkeUN
	3eATVUcLKy7MIeS6Q0zlZeWcMEEpPr97v9WLm6+nXSBGI4lL8AdDFJ4Hs7n1UsgBZ2mOGEEQGBS
	kZcB3ZHqxzqiRtA==
X-Received: from qtwq9.prod.google.com ([2002:a05:622a:309:b0:506:9dac:fced])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:346:b0:4f1:b6bc:5833 with SMTP id d75a77b69052e-5075281643bmr130374111cf.54.1772388900340;
 Sun, 01 Mar 2026 10:15:00 -0800 (PST)
Date: Sun,  1 Mar 2026 18:14:51 +0000
In-Reply-To: <20260301181457.3539105-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260301181457.3539105-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260301181457.3539105-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/7] net: add rps_tag_ptr type and helpers
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262436-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50DF51D10ED
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


