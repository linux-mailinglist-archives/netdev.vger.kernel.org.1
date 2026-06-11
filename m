Return-Path: <netdev+bounces-297899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 38HXJOcfKmoojAMAu9opvQ
	(envelope-from <netdev+bounces-297899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:39:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D69BC66DD88
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:39:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ne4aPDqE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297899-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297899-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8C80307AE54
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 02:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20E82D3ED1;
	Thu, 11 Jun 2026 02:39:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965DE2641FC
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 02:39:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781145572; cv=none; b=j9UF6ARDnCKlEHyRUssrhxQrW73mcl3YA4MBZizemxCijJddM4AMXu7/49bMaB8ECH2nmxiGtO549vagjG33eV2FspBuAoEjxmxBIwhwIokZ3gKfpJbjcaW9pOYDgMW7Vx7u2uRR1DYx4DuzSk5ssGAaEOiQG98It5SPfJrCYXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781145572; c=relaxed/simple;
	bh=leDRZNtVDPP9d73vCCeklctQ8XYsvdkvPUlIE06AW54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jHWrPjdrdRpJnkhvTmvwbL0M34U73NgIEqPbC9V65qm02urLzaMT3ECgAaR5fT8TzApRCo3KNXgaq6WC6JJ3yGI5yNwg/Jd60XmeA34emrYxg/yuIsueLBp7UL0Dwq5PGdE9DBTOJ/nM8lz1CyCpimxtxCA5nXJaXj+7e2qKezs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ne4aPDqE; arc=none smtp.client-ip=209.85.210.180
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8421f0e9c5bso3447818b3a.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 19:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781145571; x=1781750371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zvAByViDtXG7wGWE+kqFWIG/+s+7WeIZBftsduJx00w=;
        b=ne4aPDqEoy2JEPV+lgY436z+BtGQORY42dogdOwaFD4rX0Ldsdr6GNwPxJfpC3qFi1
         F3P4m5Sui7K/WLqDnqL6PS8yzVsqkBiYgfqr5v4E7tDVO6d/hDXWIO+uPKbfqt5XnVeC
         1aSppgjI+XQcpi1/wa0IKvRuqLFp4T4/8jCsUf5L30plCF3gGXcWKcrTw3W94RRv7dQ5
         863YGtoFK1fpRqcx3L3cNvFjAl8PTYHNP7FBY9YAGLAZX4RCkfRjzL/vCOT8fF+oYGTe
         o8gziAclt3GELQ4J5xIc4NU7BACxuWwbjtN92dkbwpd0+boeDddVjk9CyVQQHpyOaPtv
         udrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781145571; x=1781750371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvAByViDtXG7wGWE+kqFWIG/+s+7WeIZBftsduJx00w=;
        b=TEWR7SGrbWks6SOAbZu0ehaMrU1KddEGQcyxgKbuZXamHwdRIXygOkOtPriygZuouq
         UwTtDVkgwmDTQVJ86vAGhPvdPsA56OBb0WDf/mR0cSGg9EbyLaqR58qXLQDnDf/pYg8F
         uAm+TNhXf64aiJVavkVKXnCGfmhrns4LxNjOA5j93FGePdksWkj6/kx8fy7R+QNn5L8k
         j+U2+eECskNfnh/yEh9agHVfaS0olKW54H5jaCJ2aFbUIpTfwDZ/zvvj5H2g3QG2nU9C
         +jZcyN+zRUggwUwKO/VaK3ahbHX1YEztfdsqjefax3wGiOKZjka8uwxJsPzNAhOJxW54
         3mGA==
X-Gm-Message-State: AOJu0YxntFEouDaspWfg9zOKnquahlgpgwniFfg6wOvps+9r32fGYjtI
	lm4ZOs6bQuqwljERUNSNnLbO3A98FX18crzh6M4uYwRmPZySC20TWuQQGkO9FA7oPw==
X-Gm-Gg: Acq92OExK7W7eJ9JL0rdqCWcLefCWTucYIEvwgvtCvJPQPeYjxD8Cmh/9QfT02SX6WL
	T2wnAgRLeDFCyzCuaxdf+MbL35vOKK2YWCPu5q4WWdDYVWHWeVg4DPiU7R7FvZh2qLA+/1WGUz4
	QSubnjAJ8CWk3EOzzw2kqc854HKgU+zE/LUfpdql/9f9PZb85edQc/St8I9EJwsKuEuXg0wYvsS
	HKlQutGvz770kpf5Xvwkz+2AJROAxkpFXeXakSxzqCK3jw4S5mwRNe8GqXyMdNX978ziWxVsc44
	/goxMoJzbDjrrB9cJ3KVa6lNev1plSV21XJtpf9qxNZirloHmm9TFPdOV/6yNArco0sqRpKawzP
	A0LG0mJHzoa9wXmh4CwphN+R2WhIu+OVoqp6GdWZm4QLOQ6rGPdZuqgCEFP9nhsjzBjcrJAERUd
	9WZPr7uIC8JCsA/v57fYBGpBtutAio9Ea+gb0SNUpAcacqhIyfHctJB/LI9b/OHjs73jeXM49oW
	bWWHw==
X-Received: by 2002:a05:6a00:3e2a:b0:842:51af:b3af with SMTP id d2e1a72fcca58-843367eba81mr752476b3a.3.1781145570906;
        Wed, 10 Jun 2026 19:39:30 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-843382e60ebsm202392b3a.45.2026.06.10.19.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 19:39:29 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: pabeni@redhat.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	Raf Dickson <rafdog35@gmail.com>
Subject: [PATCH net-next] vsock/vmci: use sk_acceptq_is_full() helper
Date: Thu, 11 Jun 2026 02:38:30 +0000
Message-ID: <20260611023830.106259-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297899-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,broadcom.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:sgarzare@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:rafdog35@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D69BC66DD88

Replace the open-coded backlog check with sk_acceptq_is_full().
The helper uses > instead of >=, which is the correct comparison
per commit 64a146513f8f ("[NET]: Revert incorrect accept queue
backlog changes."), and adds READ_ONCE() for proper memory ordering.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>

Signed-off-by: Raf Dickson <rafdog35@gmail.com>
---
 net/vmw_vsock/vmci_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 91516488a7..56503bee31 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1010,7 +1010,7 @@ static int vmci_transport_recv_listen(struct sock *sk,
 	 * reset.  Otherwise we create and initialize a child socket and reply
 	 * with a connection negotiation.
 	 */
-	if (sk->sk_ack_backlog >= sk->sk_max_ack_backlog) {
+	if (sk_acceptq_is_full(sk)) {
 		vmci_transport_reply_reset(pkt);
 		return -ECONNREFUSED;
 	}
-- 
2.54.0


