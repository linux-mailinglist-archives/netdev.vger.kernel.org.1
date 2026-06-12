Return-Path: <netdev+bounces-298454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HO8FG6CQK2pA/wMAu9opvQ
	(envelope-from <netdev+bounces-298454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 06:52:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C80FD676AA0
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 06:52:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=oUwDWbIJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298454-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298454-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 976FB304B6A7
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 04:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108183955FB;
	Fri, 12 Jun 2026 04:52:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1D625A2BB
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 04:52:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781239964; cv=none; b=ksErmANGHZsoKWQdB0ZaQfqOBrGxHhj3lmxR3tSBkSdXGPKn3HIHZ/1CZ6t0IJ5wyd9w2mvjakawsKaLrwgsiVNquDCJwUTMBV1tfACeKP/6sHkg6aDJf2GNs3F5Ihno3QUQ1JOMPmoRFCITEcmAj1EJ32+k14AWcPBe85N5hcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781239964; c=relaxed/simple;
	bh=zdaEu/0sGHSxLts/pXqiH8HAfsnfc5XaTao1qtpd/l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E80jaoTspuks2S3H6usEDfOBNQA2lAZBZPTIY4//tBvLxxBQmVGeXA0x9Q5IxrNrnwXDLM/6+SKWOG3UBaJEg5aO3KbF7BNBzG3JhSUx7DchuakYOJ8MHUk12hqKxe0DXjCHzBhUbALl7lfJs0p8X/a/DsjH+4hVg9Dr96kJQt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oUwDWbIJ; arc=none smtp.client-ip=209.85.215.179
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c8573e75425so189531a12.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 21:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781239962; x=1781844762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHhZvAyUhq+bTu4qJb4yo1RwwXiAsC79cYT+Ge8q5D4=;
        b=oUwDWbIJNyIDJ9tgDPbceSG8wrW3NIOp1x8CUaJ5prfSuRYzWCL+uUfhK47Dyr5nyt
         IRYoA7ECXZ9+h3gfFEW10H1LEQeMJ/uSSwr3UWgm9jQYf8XsFyHMZQOyyMZpJflVr/bx
         XzVfvoep68ECUulMUFtNejhjlCRy4CsaXV1NErgogOrZSwWroHtfcKhtcX4uV14fakRy
         KdTetMwWdeuNyh+x8StTQju3sVqBu8egJnhKpphQ0SCOnsARyf24EDRLkUkq9g19R8BX
         NI/seFL8VdFlfTiiJjz6S3Pol5Ojmd+kyoiz4xirz6FC9jlctgND36ZObG2A5jq/5k0q
         WWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781239962; x=1781844762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HHhZvAyUhq+bTu4qJb4yo1RwwXiAsC79cYT+Ge8q5D4=;
        b=Iajxko3TFqIhYGkuDu/+qc4krqO73QF/oAQnXXtnpDl+c37TI8wUtiYXlpxqdNfBMk
         MHyAt8RRDTfiXekZ80Nk98QNAPZx65NHSxZaG/yqCSVowNORiNUYWxXb7Mp3U6pTdfjy
         6ZnvfVJd5/SjeYuxjBKmb0wVHtNE4fURi3HP03NEn2LL9/0jSc9R7aqZrY4akOGabhie
         +kvFFS6p2p8JWB2GJO7Tphbug7e/dqEFE/1pjcF/4bVj/LM90EP9RgQBdnGDLKyO7KC9
         itBPh5+MLh7E8hr4DmQqzGNVCfAfqM7YNnEa6eOFGFAExP/uQEyPbLN2MjGwhbpZupXF
         nbmg==
X-Gm-Message-State: AOJu0YxpeQQmslMO+MSF7qsPKMH3VDOEkVViArFbUdLKjH0ILWtKdiq4
	9f2kZfHTvICWI5NG4ObcMG/MsT34+tx3nL1zxtRp8qnHykNaCBLlf01m7Ekmsz6OvA==
X-Gm-Gg: Acq92OEKMBZNJiTj6P64jGtbZWnGJ3HSmQJaAwB8fKOPCYr6n2H8o+yDdbMN2Lw/jX0
	80/vzo+PiXdL9LYLDaUzeqDVMbjpKTfLVZgKmwktwhV4KKHlYyPa9xSpsLiCmf7zD3Qzc5TynXj
	lTuKi0i14ujbPZNDJ+6rYo8KZVmnrVgDCpyuCiSLn8+n0P8rkk8ONmxEWO+q2S+/SAHMAu0sLRq
	ynwJ9/SqcfrlzqwUIEROzNzP2jIS3pGGgv0hREjce9D8QrGewZA3txot7GQI7oKyvavZJSrs8Jc
	9zZ+wsnd6ndH/QHKNq6GMOzwLPl5pWcOUyaQ7rtM5I8hBhRf9Bq67vYKxSo7mJbM/9Xa2gyw5nv
	4JPawe1ZiY9l7BfS0evfC4fQuFbS5YN6UZQRIdmfyv6+Omvex9Srua7h/ccgKB9IdNZo3Yc2YXH
	LzvChiBx37f4Cqwegyu3UcaHwIdaCCIQ3RCopaVTEKa8pkjjolJ6es7HtQo3OnSDqRBaE=
X-Received: by 2002:a05:6a20:9f4d:b0:3a3:327:c5c8 with SMTP id adf61e73a8af0-3b78356a9f7mr1582389637.0.1781239962240;
        Thu, 11 Jun 2026 21:52:42 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661b5b207sm827558a12.5.2026.06.11.21.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:52:41 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: pabeni@redhat.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	bobbyeshleman@gmail.com,
	leonardi@redhat.com,
	horms@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	Raf Dickson <rafdog35@gmail.com>
Subject: [PATCH net-next v3 2/4] vsock: fold sk_acceptq_added() into vsock_add_pending()
Date: Fri, 12 Jun 2026 04:52:14 +0000
Message-ID: <20260612045216.105796-3-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612045216.105796-1-rafdog35@gmail.com>
References: <20260612045216.105796-1-rafdog35@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,broadcom.com,gmail.com,kernel.org,google.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-298454-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:sgarzare@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:bobbyeshleman@gmail.com,m:leonardi@redhat.com,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:rafdog35@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C80FD676AA0

Move sk_acceptq_added() into vsock_add_pending() so callers cannot
forget it. vmci is the only transport using the pending list and
is updated accordingly.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Raf Dickson <rafdog35@gmail.com>
---
 net/vmw_vsock/af_vsock.c       | 1 +
 net/vmw_vsock/vmci_transport.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 1f94f0d44c..6cfa89b6f3 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -483,6 +483,7 @@ void vsock_add_pending(struct sock *listener, struct sock *pending)
 	sock_hold(pending);
 	sock_hold(listener);
 	list_add_tail(&vpending->pending_links, &vlistener->pending_links);
+	sk_acceptq_added(listener);
 }
 EXPORT_SYMBOL_GPL(vsock_add_pending);
 
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 635ebf9da4..c2db016cca 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1109,7 +1109,6 @@ static int vmci_transport_recv_listen(struct sock *sk,
 	}
 
 	vsock_add_pending(sk, pending);
-	sk_acceptq_added(sk);
 
 	pending->sk_state = TCP_SYN_SENT;
 	vmci_trans(vpending)->produce_size =
-- 
2.54.0


