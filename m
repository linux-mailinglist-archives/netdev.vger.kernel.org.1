Return-Path: <netdev+bounces-297559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3ebENdQqKWqKRwMAu9opvQ
	(envelope-from <netdev+bounces-297559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:13:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2EC667B4B
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:13:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KgDrAxdc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297559-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297559-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4818F3016777
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CEC3A75A8;
	Wed, 10 Jun 2026 09:13:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921E010F0
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 09:13:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082832; cv=none; b=d6uX6eVHKoZ8m+MDEYfpOmVIJhe3v8B2h4K/AQyDwJ7FvoBm0So97Beo1oI66MJgQAW2AKqf5mH8LYg4NBiidbMzLvM201mxrHk0rQxbwU3qaOahkGmVrJQE1KQCw99VNmYNjuiOL91ozvW9UJlRQYjf/HCy0YFYBE4xY8rHaVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082832; c=relaxed/simple;
	bh=8yiNPwqyK43QFy6Ol5H0aA610nBvzzJ0X5Ewgi6/K4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCgPZj8z52JfOxtbSK9QNXvKd7WDc60dPdn98hJrEDGt3OMi14VEb1cuT6FKdGrNqplXihPk6uLwfqBKjsce/ppJcZyaXFHT3UKQquZLHvPqi4HhxNbDzj9PYZTWBPmBHgHQOxftfzeZ0Uz0zlrSG2c6PJS4JVfk42Wl1tp4PSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgDrAxdc; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bf0ddaf50fso45203795ad.1
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 02:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781082831; x=1781687631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B29ZuDjmbatWsfgDCYAMxPZ1omkDfUZq2rNYK60Wnps=;
        b=KgDrAxdcQf1kAxWyXrM4n0UVyutOTpGUJm90vwOPFrXURM2yZiUsIGNsR+gOvU1XYx
         UmF14LNKnyIHDWdipp1PFc1P3nAPMmjte2dpXYZZSKzQLo37WKbj9VAsXnUW+FEP5qEY
         ZtQPjcenT5Eh2yQnnFoYH93yHOqr3Ow7p/L4hAUeiVMb9EmoR96Vdmd6UZIbSYqQjJQ0
         g+jCz8ietxpH4zWGoPTWOds0YNgQnoFSFnpViT0ngEpepS9UhHmBAYWyitWEJhPxd+qY
         6AVcIlQlg6pxqqOtorCOTrdRIexyT0R9xWQcqjqC0fQkZ97eM4fRMC+3jE91kdvxxO80
         OvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781082831; x=1781687631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B29ZuDjmbatWsfgDCYAMxPZ1omkDfUZq2rNYK60Wnps=;
        b=BRduOGfDyE+lCYjePbieYyTvd1JsjvJi8dBlTwYmopBIrosa0crhDg1E9G8Ax3l9cY
         f1JjwFD3XeBpb8C1wiveM+yJjFXWXFh5lVLrl+MBqHkpJ5jR0wZPfb6FgliQvf3cVEKO
         vEe5jaTvRJt5BjQMrewQvWiJaGXO9Q0u07npgCyCAi18b2OiJzMc9zyTtbjMRV2xb0L/
         AMETI90aj0/I3+zXE7w1ISPZ+Y08fuueFmufULiyuRUtJ4wE6Iz0Q6vIXYGr82ZIxUpe
         mlsCQyKtIaWlVemZaPlejHEHIBbTLJ5pIMoWsOFTqcgf/SClG+6B17xou0czqm2Zh03T
         HG1w==
X-Gm-Message-State: AOJu0Yy+oBhkpLjIwoe41j7uXvKNRV7x9vfJiCYznJTD8B8Mb3pZtasl
	mUrs4HYTxxhmOi2J65OdDC17XUXBHrk5eXwz/KOOmFxv61awgNRdGcEpLDV9MQskeQ==
X-Gm-Gg: Acq92OEJWV/Yum+za6npOAKZXwskLkFbx6ZehISRsqpuQ1kzBz03Hyr+9G8LaoPoJzz
	yStpeBNW+q7Cvdp9yFnvKFfYI06x+ERlrR7WcF+/BETPsZghiQEQie0jHnLx3H13/ypF80dbfkF
	KUSMdMRsB4HduSorHoKfAz7ECAUf/ul1nAtQV+1t+Wsgl50cMLxBVN4mHopx5P6pF8QQUOs0943
	BM38FsX61z7OMw7LeubCd7ovUty9ONi1Q173txKpP6R3Mo35qpCOPH9zaOwp0VHvOjgWfBHkxRi
	/aCJ05SXYvBiyvrEdzIN/7T7tiFMCgURqSqSVexicpLJIc3UL0e+mz7D5v3Tn8lMKSjc05Q/XPb
	kLm9uUjGF3yhbVn/Z350Md1WMYuHB8JCxFDtN5sGXD+bEa6f4N6EQoQrMU/s0aZadq4lGVDnAo4
	8YdJ18O6kBYofAbzjWcCnI2bm0WvkXgtoE75t4glG7SsnvRGtP8r1J47j0kSLGee4eR1a15ovKf
	To+AA==
X-Received: by 2002:a17:903:4b46:b0:2b2:5314:e96a with SMTP id d9443c01a7336-2c1e80fc534mr276460955ad.34.1781082830780;
        Wed, 10 Jun 2026 02:13:50 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e096sm242991765ad.44.2026.06.10.02.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 02:13:50 -0700 (PDT)
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
Subject: [PATCH net-next 1/2] vsock: fold sk_acceptq_added() into vsock_enqueue_accept()
Date: Wed, 10 Jun 2026 09:11:20 +0000
Message-ID: <20260610091121.213324-2-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610091121.213324-1-rafdog35@gmail.com>
References: <20260610091121.213324-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,broadcom.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297559-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:sgarzare@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:rafdog35@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F2EC667B4B

All three transports (vmci, virtio, hyperv) call sk_acceptq_added()
immediately before vsock_enqueue_accept(). Move the call into
vsock_enqueue_accept() itself so callers cannot forget it and the
accounting is always consistent.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>

Signed-off-by: Raf Dickson <rafdog35@gmail.com>
---
 net/vmw_vsock/af_vsock.c                | 1 +
 net/vmw_vsock/hyperv_transport.c        | 1 -
 net/vmw_vsock/virtio_transport_common.c | 1 -
 net/vmw_vsock/vmci_transport.c          | 1 -
 4 files changed, 1 insertion(+), 3 deletions(-)

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
 
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 91516488a7..4ce6660c11 100644
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


