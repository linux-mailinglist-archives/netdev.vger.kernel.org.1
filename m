Return-Path: <netdev+bounces-297892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3Y4pHbUbKmqaiwMAu9opvQ
	(envelope-from <netdev+bounces-297892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:21:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C152E66DCE5
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:21:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Xpj+wVnQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297892-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297892-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1872231275D6
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 02:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EEE318ECD;
	Thu, 11 Jun 2026 02:13:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640BD2773C3
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 02:13:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781144025; cv=none; b=X8n5TaeKCLRLobyF+9QDMNC6HEN/FfKLnhpSx4njJUGuQtaiccHCtNOGeto1FvpxAGGKSncjx/Ith98tXEANsBsZwpWbpq46DzTRdZJVQ6W9XsP3UFtZKoYL3kCPfdoNi65zHaNlQFFZ69R4X5CyXzYHl+ao1ih0xI8+1SVcUp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781144025; c=relaxed/simple;
	bh=CBIsTgpYepvuCGXqFToVF+k6SD6b2t65VP4Atc30Lzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GF8pOpSD7xvCHA6m/5hgWh5GGmHDxAqzlDb7Mzy6wiNLvi5h0ntntJZDLsgvG8pr4cjVLqJnhYZsr7wP/mDbglY5Esdv/m4IzTNA77/KM4CxWi/v7xnOJ/mdYep0EQUXvkwrrh5j3zOQeRNq7dxPAmfhbwLg+IwCimCC+CYJQ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xpj+wVnQ; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36c68964315so3697648a91.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 19:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781144020; x=1781748820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnYLzFvhBsoLcQfgDB5iqWDqZ07p+tRABlGYQccfF3I=;
        b=Xpj+wVnQn0LnixUuSD5hs43Y69xwL1vttwUC2lpZf8cfyliaC6eDIMAMpseHhNGaUa
         Jt9ARBysxHReaNL5DtNXfim+XarmYRJpH9G5oSftklmOORKoHlDZ8vpeKpVzBjxDu1sM
         FochzAhrvYDcRYiFyQd95gV0nrc3CVZpsWV2XfimEsdJoxIDKNLsM4GYRs+A6q05co6j
         mMHTSXRF5y6nWltBslDMo0SVxO9FVCiQ21fgg4tcI1KYLsZK+v2x8blEl0S7iNdiZqie
         5GCv7Xr44cSV+bZBH6TF6NnA1ZHgZLmvghYUTcNoSn+tYXAra6+DLIQ3xtEdCQ6L7pif
         4hHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781144020; x=1781748820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WnYLzFvhBsoLcQfgDB5iqWDqZ07p+tRABlGYQccfF3I=;
        b=gAJBUMSN+INZnH005kbPI/N7Nwmt1ebhtWgmVDDm/PaienXCNYaToME5iV+5akagKO
         5769ikyr+xdiBTZHFC7qqeTHwgKwOoWwph2TZ9J9PdRSQLw625dww9Ozw+DNoJedF8cm
         0CUwm5tp5X5d03u2dojChbmLf6Hbq91vbxTjlAKySb4ezmBRczsmJdS/7u+fYOJOguw7
         Lgbn+2aoTgFlxvlsd99z63t9VPCuLzHu6JmHKigiDBQ9WMqclptVNtDEk/JArm1V8uV5
         a9gUBW4Ri9ZG1WV/3ONR/l0rOLMappT1ZtR8Y6Uf9jvpDK1Vr1g106pIryjD+eGzCm6b
         C/MQ==
X-Gm-Message-State: AOJu0YzJxZJ9SWqUX8Li6vBa0wctZwgqW4NUoECUSM+D0EU5eqaHJeGP
	rNXZaOtZNK9yFZV1RlKSKpVhDPs46JMQHbZ/D7rwfH+9C6ZogeVPzThHfIV5dsBoUA==
X-Gm-Gg: Acq92OEaTaTXMWlnUQ1/8dHW2fBErAdDzEhJqaVWtpaPrANHb7o/NVRrjZaj34EI8R7
	7loPblLWLwEgFgt71rU0nlCwzaaf5aRfKY3waT0Ab1AJzRPOhxJYqFssHedjuHxEGkOlDcX+1zO
	qlqI8Hja5sxrr2N5GX1XTQ9kFs4CSRyrSAQD1J3Y3oiin1+gBrKWwmAklm4gH8PI7kllt5NTu/h
	Wax9HMiSfGPO1c8x0Od7hmjHCLvrhaU8B+8UGiZo2bPBSyZC2oSyHUjdNIpG2RJ4AjxzSWoqKyX
	HeAnE9+Ug5DH0JBTQAp2GUTHVYz+6TAcSVQ3XNRkOFytm7BHpLNXg3JDldumq3V6xVyzakz5yY1
	GgahYq93o+q1d4ohwjxvq4R0mjiwiK1q1lK+R91bwz/bLSGq6MVfOfavUyBXBYfzjUQIZVeUSe+
	/4KCMlnIPsMh0OxIdDOB3mCx2zblykkB1XD8gNnQOOAFU1xpdUc6XGTPUsF+3fAzkj3j2AJxvqx
	VpQuSRIyUYMxgru
X-Received: by 2002:a17:90b:1fcf:b0:36a:95c:7613 with SMTP id 98e67ed59e1d1-3779ecb811dmr908513a91.10.1781144020432;
        Wed, 10 Jun 2026 19:13:40 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a0eb9sm732006a91.4.2026.06.10.19.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 19:13:40 -0700 (PDT)
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
	Raf Dickson <rafdog35@gmail.com>
Subject: [PATCH net-next v2 1/2] vsock: fold sk_acceptq_added() into vsock_enqueue_accept()
Date: Thu, 11 Jun 2026 02:13:16 +0000
Message-ID: <20260611021317.69362-2-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611021317.69362-1-rafdog35@gmail.com>
References: <20260611021317.69362-1-rafdog35@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-297892-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,broadcom.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:sgarzare@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:bobbyeshleman@gmail.com,m:rafdog35@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C152E66DCE5

virtio and hyperv call sk_acceptq_added() immediately before
vsock_enqueue_accept(). Move the call into vsock_enqueue_accept()
itself so callers cannot forget it and the accounting is consistent.

vmci is left unchanged as sk_acceptq_added() there pairs with
vsock_add_pending(), not vsock_enqueue_accept(), since connections
can be cleaned up by the pending work timer before ever reaching
vsock_enqueue_accept().

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>

Signed-off-by: Raf Dickson <rafdog35@gmail.com>
---
 net/vmw_vsock/af_vsock.c                | 1 +
 net/vmw_vsock/hyperv_transport.c        | 1 -
 net/vmw_vsock/virtio_transport_common.c | 1 -
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 2ce1063d4a..73e6416ee9 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -507,6 +507,7 @@ void vsock_enqueue_accept(struct sock *listener, struct sock *connected)
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


