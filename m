Return-Path: <netdev+bounces-298455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c014C+yQK2pS/wMAu9opvQ
	(envelope-from <netdev+bounces-298455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 06:54:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D42676ABB
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 06:54:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WxCTf67I;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298455-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298455-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B004318C410
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 04:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6E8397E66;
	Fri, 12 Jun 2026 04:52:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9E73955FB
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 04:52:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781239969; cv=none; b=qj0BHmulXPv7RCdrmH2itvkX35IQPLIXkAvyaTydfO4YI/TaX/Ig6pH1XK70IVyJ/2dvsrO+QJEMWqvF8fRz/8zUjevx/m+gc6tBFIMYSEkjCWSGqcHJza76uNns77XoO6lwdqbzNkzvTD5dsWaKMUnKx6+y9zYZx/NnwlrCF48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781239969; c=relaxed/simple;
	bh=T5KX5my/pwkB1VBFQsvsOQjLPEkU3WFPk0POQo19dM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yf9PRzlj6NufsGMFgS5K0KxAv0J1z8GdyVKhfmY+Orp6nyD6srwMPqQB/DQAYQ7a5me/5h4e4dG3ct5A8DOTCie64QTUemzUyd4pTYb3fSfmwocmjAbWcVLZ3tDqA9vE4P7cewfquy7Tg6B96k8jpByL9xUlZvLLjgxMG9zd6sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxCTf67I; arc=none smtp.client-ip=209.85.215.175
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c857fba35cfso247814a12.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 21:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781239968; x=1781844768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmatnySEe7N6+CsFplL1yTSQwiL8lRoVJvOz58vrZgI=;
        b=WxCTf67IO+t9kUmy8tf02e2Yv7YKZYh7gZsAa81hMSv9G3HfuElDNrN3etIRPsf+As
         D3pcC0+JAFdFrFiR6W5KhNyjbJVn1FR+nbYTFTu9HiV5NAOFVGKFaMsPaXnr8yegoFef
         Tw5LlLE3C4783/MU9nt6fsYV7ckOy1bGLddeOWH5E0af2sEs728Ki7obwWCFF1TNK0HM
         mCYyrvOINckUs2+UTtAmTcgvIHecy8LZiuoIP4wuljGj2JEL4di+iXeJ0soZcr5QnaTq
         PvG0Ex2nR1nwPYLBhMLWo4qpsko0MIUYvdaXzl4aASTSSwNLQnKgLCTR+OnKSL7WOXhS
         LfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781239968; x=1781844768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qmatnySEe7N6+CsFplL1yTSQwiL8lRoVJvOz58vrZgI=;
        b=ejd8udhy55nUMhdxZkIIUWwfRuDkjC7bUUBVHzVHJo0l8tAoxuj7pJKO8MhLQdY7sY
         +PPzzCyRuYsjNJeHd0wxhbuetH6Fga1PseB3Wpkp5pEEfJGrB7c274VJSSLgxFfs0awH
         ljkMdwNG7eOUv+I3kWuqJ/ANH0DBVzSKRDvNgyuImjiAZyfKCioFz/XsKwUVgzA75vhZ
         jx/GZV8kqg/+gzFeCkIUq8xaL7dK7wSzpaKoJva5ospvDTTh3Vb55ZUVs/HEW0OZXnjR
         tbLMQbEhshlAmb4oS55/YkD+LaWHaBeqd3L3q6v3ExtvPWJae6he3y3TXdddjVgZ27Ls
         qDtQ==
X-Gm-Message-State: AOJu0Ywo/cKlvlmiuVXV1iWQU4rHkLJsGqLoFuDfiDITLDJc7iveqXmW
	jVvMNGV9vJFePebOMLjtSqs82AWSRmXglL6W2S6vYNDS775KUcLoO6tXW0JJNF73lQ==
X-Gm-Gg: Acq92OG8thHZU6apiGp+x5PfCxmDnV1EAfJpe6WUTSccSqO7GPIF6qnEoszlKYMCwe/
	0MtCb4ReyxCn1oN59vSJ25Rzqx6ItpQBcsUt/0vSPESzG+rbDbVN9TJULQPLH9iRrBnmSxm3O7N
	SxoW8RBN1MfbLZJGmSSOPyEusmkFTESoC4Bo2TSrQ01KOWfXVWWsf5JAnU6EX2B+cWWAf/wmmZQ
	/SPCFGmvL70YSPbnlV18ES688ESJuxR7gQZXFsDmlGmUaxpmOHdMLKxxAcy8HMIcsNbDQ7qJSN2
	rp03D5BF7MZQV+THbG6jmDLm3FUHuqVNMeAm/AxwAcxvvAZSG+FSzMCrjgEKWbTi8lyEhqLbeUO
	AyWjbRrUg/hy8F1a+rV6GaYK2sgNZDio2pjalJ35tH18I55yA6/moyzurPAQz5nqZ5SdI/yagt5
	mDSpqh+JAO1uQx60N/zILKzNjFabaotEs+gFW17p5FnTEMXDbcf3W/zkG5ha49oKi9o4Y=
X-Received: by 2002:a05:6a21:a8c:b0:3b4:85db:1bdc with SMTP id adf61e73a8af0-3b783fb1e96mr1684565637.34.1781239967697;
        Thu, 11 Jun 2026 21:52:47 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661b5b207sm827558a12.5.2026.06.11.21.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:52:47 -0700 (PDT)
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
Subject: [PATCH net-next v3 3/4] vsock: fold sk_acceptq_added() into vsock_enqueue_accept()
Date: Fri, 12 Jun 2026 04:52:15 +0000
Message-ID: <20260612045216.105796-4-rafdog35@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,broadcom.com,gmail.com,kernel.org,google.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-298455-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82D42676ABB

virtio and hyperv call sk_acceptq_added() immediately before
vsock_enqueue_accept(). Move the call into vsock_enqueue_accept()
itself so callers cannot forget it and the accounting is consistent.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Raf Dickson <rafdog35@gmail.com>
---
 net/vmw_vsock/af_vsock.c                | 1 +
 net/vmw_vsock/hyperv_transport.c        | 1 -
 net/vmw_vsock/virtio_transport_common.c | 1 -
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 6cfa89b6f3..24916dd4e9 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -518,6 +518,7 @@ void vsock_enqueue_accept(struct sock *listener, struct sock *connected)
 	sock_hold(connected);
 	sock_hold(listener);
 	list_add_tail(&vconnected->accept_queue, &vlistener->accept_queue);
+	sk_acceptq_added(listener);
 }
 EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
 
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index b3394946b2..0de8148877 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -410,7 +410,6 @@ static void hvs_open_connection(struct vmbus_channel *chan)
 
 	if (conn_from_host) {
 		new->sk_state = TCP_ESTABLISHED;
-		sk_acceptq_added(sk);
 
 		hvs_new->vm_srv_id = *if_type;
 		hvs_new->host_srv_id = *if_instance;
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index b10666937c..4a39d48db9 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1582,7 +1582,6 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 		return ret;
 	}
 
-	sk_acceptq_added(sk);
 	if (virtio_transport_space_update(child, skb))
 		child->sk_write_space(child);
 
-- 
2.54.0


