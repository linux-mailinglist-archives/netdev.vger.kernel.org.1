Return-Path: <netdev+bounces-262077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GCGMDZuomkn3AQAu9opvQ
	(envelope-from <netdev+bounces-262077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 05:25:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A961C0413
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 05:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8120D30677A1
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E88327C08;
	Sat, 28 Feb 2026 04:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1r4Y7387"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7B22D8DDF
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 04:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772252709; cv=none; b=BC5v3Fm4NmV1P4gWRgrOBeOvOA1J+7eoajo7sYBJZ6ELCNubQy5ymXRfCcfMOJW0giEnve8Cmy4XG689OqVNinY/DvJPHMwj7W7tmoIp65fq+7FTDUFwcQZKRZrTD9J8oeth2fKnLqOVEu6inYN2R9iPGBK5MKkbWawLBcGyCp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772252709; c=relaxed/simple;
	bh=gHQE9PJBs5YibR5ZX+P43LUxEImbIRFyIanyDFA34d4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VUoXcipBTXLKCQTZxLKknOSdPrlGz9qVuuMhUqhipsf+2pCFlNJUGeBcX9SkYnK8NAT4X2t+gyxDnMqtL4g2bGkPuO4fBU3nugHpRdXN9yNLoXiw/H3SNdbPRIDlUeyJrR68EQMOiaNveM67fJhKtJ/Pt/owWoGI1g9Iw8giTVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1r4Y7387; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8cb3ff05c73so2113355885a.0
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 20:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772252707; x=1772857507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+hnl2+tOrDl+viUfn1bt+UhrtPdai8Y/6jthVt+Pk8s=;
        b=1r4Y7387kWLGmQRlZZKwadO6pM9UpXatprVOIQVtqhL6/pl7BAIsSD6l/pVTxHI/pG
         NicuhsMlq0i5AfwVo6fUeq8i0xqgDzdDyuwVUfFXEG3yZRXyjiX1ja2JbkaZGbaKwY1c
         2hLkjnGrXZ3J6ky9nsEeDKr59qLma95DbSAJv+fa08Fu3uznc6Y1kyHfKQ13X7c1s6vO
         MoFrR9hKFW0HYAdYtRa3Cld89sRmithXn5r5n0IE+DYFjM18axLTMlcvrm2zacfU+sHG
         5lqaMillklURndK0QJ0b0oqDFGRPVzqKxESgP5EPmtpXe6MqKY0+7XmgJis65F9bMiLv
         bObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772252707; x=1772857507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hnl2+tOrDl+viUfn1bt+UhrtPdai8Y/6jthVt+Pk8s=;
        b=sWiQunTIwSZIhrBeLB0RstfvUR531PQwO3iiVwohKSjqqFLV82a0pMoQToaYTPLNsp
         hmAsc4LGx7+1krW08VEgR7uenGZyxMD2t0r4Tcr2h0HrbAy4BjO6d1eacx13dg2iX8JK
         Q9OLQT4QPexgvkCKg6Az+TALi7X9Jz3A1bcURdIz7bon0bN5twh9upIAzNbqBCKrcwP0
         1iUlmyEL9cAa4N+V8TOePqc3IiRb42UudB43Bn6VFn1wsR5hsptZqahw/x0O7bY8AkmQ
         a9qOPNYwkvsBiBcRKW9YEfzVXbJ2o8wo5N1KQZ7MvkWOxWnhWBF8Tt7rD7WSo8tSIKIg
         oCEg==
X-Forwarded-Encrypted: i=1; AJvYcCXH3oJpLHHHteZ7TYQxtG+GY2FxidKhKzpcMUiwGAfEY4JPH6PxP5FnmBfFQJ2x6gOlndQ76HE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNJL6k5P4OYtc36HRudvYMIbJEzSZIWtkDo5fG6qKFkC3g191C
	f5n6ApIk2lS/tLM8pe+8QtVHmz7vCc/8ML2VdjqV7JAqRRQJ1E2xZOTBOcIbOJFuFByDyXYcNjA
	QA8WByeKKLRrNiA==
X-Received: from qkba2.prod.google.com ([2002:a05:620a:a382:b0:8cb:390f:2d9a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4891:b0:8ca:2a04:3ff3 with SMTP id af79cd13be357-8cbc8e8096amr653887785a.30.1772252706854;
 Fri, 27 Feb 2026 20:25:06 -0800 (PST)
Date: Sat, 28 Feb 2026 04:24:57 +0000
In-Reply-To: <20260228042503.3726451-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228042503.3726451-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228042503.3726451-2-edumazet@google.com>
Subject: [PATCH net-next 1/7] net: add rps_tag_ptr type and helpers
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262077-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 54A961C0413
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


