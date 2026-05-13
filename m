Return-Path: <netdev+bounces-287525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMx3EppYBGqjHAIAu9opvQ
	(envelope-from <netdev+bounces-287525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:55:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DF4531B38
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 663833071628
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB7D3FBEB8;
	Wed, 13 May 2026 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ud1+8sjU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K02HUe/r"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824D33876DF
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669675; cv=none; b=b90cK5L6r2nBu7yU+wiGAv96VcyJ2J2ZH7037udYTW97zINeiDb97sEnygxDiyTGmTkm/g9pn7cclOhVA15nWuM01Dv2b5lpZk/xAakQTXYhmCcT02rcp9Pm0U9hYUjf+s5JGhay/8JZIZEEZot3ig9ayEFOiQQSaYacGyRug9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669675; c=relaxed/simple;
	bh=ttq2nGPLIE/1il8H5a57hLhcGZjBjCwtRxosBU4xsEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OhJI7i4VZ9nxDt98fzI/v/BJP6YZ7CYWVNMmDYaJsebPK73qRjhJhBC8mbYtWsN/vFk4AkcR+SVwCzObe+qc0dTf1WhlBHKdmdD/SfbrW5rHX4m0UCsV8AX+AZ4Y+vdr9LmSx0EWXJEKbNF7E2Qsv9blTXM78Qd27leHuOqsqt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ud1+8sjU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K02HUe/r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778669669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAFSeIkpvfQYT7wQ2CerCQBM43nlr6dVNS3iNHBRyXI=;
	b=Ud1+8sjUbcrIvoooo+Y3ZgevTHIGjElv/dQ7RmiBAFFm6gzyMDKQaXCN6Kb2eTNlIiqy/E
	wjGaNLL/BPyK1AkLCLGHYAM2dJFbNp9MMsIQeYuQhTwl/7fbWLnz43+piNxUj28UAD/lWK
	3whU0Q37LfY1g15XgTLgfgyGetrvEms=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381--Fz09e7EPZeeqNmo13SsNw-1; Wed, 13 May 2026 06:54:28 -0400
X-MC-Unique: -Fz09e7EPZeeqNmo13SsNw-1
X-Mimecast-MFC-AGG-ID: -Fz09e7EPZeeqNmo13SsNw_1778669667
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-486fa07f2bbso39498315e9.2
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 03:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778669666; x=1779274466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAFSeIkpvfQYT7wQ2CerCQBM43nlr6dVNS3iNHBRyXI=;
        b=K02HUe/rsMpD/tQD06xhMtM7KoVrVMTQng7xwzABJNvIYhfV7UCCgzvH1z2leR0xNg
         fvPGRdDxbvXm0aHtapEcC5ghAATaYmeVwsnew3WYRyyeJBmtUjVFER3cui4KTaMoxmWS
         JgJDnHXoTA5a61GKJdp/Q5tUQjjYSBTnjHUiOHfHEG+Aef3iN5S0jAmXHBE7O9MJwl4j
         QAZl1jeDDcy80A50Ri3D8ziCx41LR0eZqNwypX+qV7660Re1kzRkbZsfM450eSM5f4sJ
         gLTOq6+piexZxApPH8fFXGQEdREGJctitviFYyG/0fpLmkrc9qQeJGlc92U3KzwDgh+u
         siaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778669666; x=1779274466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PAFSeIkpvfQYT7wQ2CerCQBM43nlr6dVNS3iNHBRyXI=;
        b=KC7PDA61n87jQ2r7ihAoVLqlwN5Qd1rEXLHtipRpU7Zo3Ezy2hQ7lPHfMfZ6Ngw9rg
         aEl1WP5TLtXOksh2kLsdPnJQWSVTXhxiXi0DpwRim2hn2J2E12Lu890R7yU9WeDXZteW
         SzgkWFBCqT1EpJjcbOEkVijhPl4YgYbdt0ZLVbaBnzmGLhoL/uAulz9lXpHL8qDkb3sZ
         3xDeTmTXfZS6AnX/sL0SPEam2wMVSkN9DlVwOeInOlae3n/7n2tomAtPuLBSP8AMZNea
         Jjkasms71nvRPaDbbZa5QeTpQxvloBdL03fz0qD18l6/A5vX3GPGJ3IxDrtjGjVy4c8f
         3YWQ==
X-Gm-Message-State: AOJu0YwFY/4cYcDTiN8oCt2MVvtEBzWQk7Hq0InY1xLWHeprHAvL/n1i
	cE8guIH+Ls1uhjq8pF1snI/7G04bFQhXe5HrT/LwQqpwupdq2Vc60YDYRJ8kTTYLyHscZ3wTdWR
	jm4WQ9ViyshTPPb9kNdtd7ELDRctNlvJk1XNqjrU1t/Lpr2S1VIktn4I6VFRiV7V75jLqOJtqTb
	yGhyAhrmBPfzx8cPAFZXsDASak73Nh8IZ7FK3WKBcjzg==
X-Gm-Gg: Acq92OE/Cv0PlpQCur7lD2SIIfLebS1sN1NQ8XC39xFPkwZbAJcCMYR07lvqQPNXxUu
	c+hVbUWV5e+JCgtZlxgT554bg0H8i1W7/SNf2sdQ2/TcE7EpcMimud2bUeyaHBdR+QdMdJ6RQDE
	PTYRWyv8AtKZ8U/d73HyiNhazMohVLwN0nxR4Pu37BBpxVuQkJuuvgCu521aE46NhCJBTdC3TJO
	8CoeYmOm2FyxnIaK7DLF+iWgDc7CJI+FTm2pUH9Sl3dFKobmqDKWyJQ0adWfpJqf6b2bHhuXJvp
	I2CxTdL1LAuGFnH1alk06sAmM8N+0JpkJb1tWbSmF5YsyfDyVrfpB0QMXvC6Fp9KwmPzyDTL4Zc
	pBhq1ctNjv4Ytj4Wkwt3IqpxWjlRA4lxVNNCbF6uxpDDgAnllaFPb10csrZ52
X-Received: by 2002:a05:600c:4f54:b0:488:ab1d:dcc5 with SMTP id 5b1f17b1804b1-48fc9a4b276mr40460305e9.27.1778669666609;
        Wed, 13 May 2026 03:54:26 -0700 (PDT)
X-Received: by 2002:a05:600c:4f54:b0:488:ab1d:dcc5 with SMTP id 5b1f17b1804b1-48fc9a4b276mr40459645e9.27.1778669666028;
        Wed, 13 May 2026 03:54:26 -0700 (PDT)
Received: from stex1 (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8d27d31sm106419235e9.8.2026.05.13.03.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:54:24 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH net v3 1/2] vsock/virtio: reset connection on receiving queue overflow
Date: Wed, 13 May 2026 12:54:16 +0200
Message-ID: <20260513105417.56761-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513105417.56761-1-sgarzare@redhat.com>
References: <20260513105417.56761-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 58DF4531B38
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287525-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Stefano Garzarella <sgarzare@redhat.com>

When there is no more space to queue an incoming packet, the packet is
silently dropped. This causes data loss without any notification to
either peer, since there is no retransmission.

Under normal circumstances, this should never happen. However, it could
happen if the other peer doesn't respect the credit, or if the skb
overhead, which we recently began to take into account with commit
059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue"),
is too high.

Fix this by resetting the connection and setting the local socket error
to ENOBUFS when virtio_transport_recv_enqueue() can no longer queue a
packet, so both peers are explicitly notified of the failure rather than
silently losing data.

Fixes: ae6fcfbf5f03 ("vsock/virtio: discard packets if credit is not respected")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 989cc252d3d3..4a4ac69d1ad1 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1350,7 +1350,7 @@ virtio_transport_recv_connecting(struct sock *sk,
 	return err;
 }
 
-static void
+static bool
 virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 			      struct sk_buff *skb)
 {
@@ -1365,10 +1365,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 	spin_lock_bh(&vvs->rx_lock);
 
 	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
-	if (!can_enqueue) {
-		free_pkt = true;
+	if (!can_enqueue)
 		goto out;
-	}
 
 	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
 		vvs->msg_count++;
@@ -1408,6 +1406,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 	spin_unlock_bh(&vvs->rx_lock);
 	if (free_pkt)
 		kfree_skb(skb);
+
+	return can_enqueue;
 }
 
 static int
@@ -1420,7 +1420,16 @@ virtio_transport_recv_connected(struct sock *sk,
 
 	switch (le16_to_cpu(hdr->op)) {
 	case VIRTIO_VSOCK_OP_RW:
-		virtio_transport_recv_enqueue(vsk, skb);
+		if (!virtio_transport_recv_enqueue(vsk, skb)) {
+			/* There is no more space to queue the packet, so let's
+			 * close the connection; otherwise, we'll lose data.
+			 */
+			(void)virtio_transport_reset(vsk, skb);
+			sk->sk_state = TCP_CLOSE;
+			sk->sk_err = ENOBUFS;
+			sk_error_report(sk);
+			break;
+		}
 		vsock_data_ready(sk);
 		return err;
 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
-- 
2.54.0


