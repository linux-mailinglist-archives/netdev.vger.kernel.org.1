Return-Path: <netdev+bounces-251825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOfjL3ShcGlyYgAAu9opvQ
	(envelope-from <netdev+bounces-251825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:50:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C56354B4D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DA3C864C84
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A3547DD6E;
	Wed, 21 Jan 2026 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AsrTkpLy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mBOWZvf4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5C143E9DC
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988203; cv=none; b=Rl1w2X4BB9psJHEbrFZcQ7AZjP8DUcb/sFBUtP/HniBf3bOihmObgo9QiY4iClm4eBYBqSJZHzNSpTxOksjrdYtKr4Ggd5HUjgPNQmPd4DDIeFW1g6e2OA2VPaO0j685kT5Rl4FPVhEBb8Gv8jm8cxBe4mog6zVvUc3vRYKi16U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988203; c=relaxed/simple;
	bh=QU6xQfM9f00ZpwjUsd6GPQ+PxU3JVUFFAWJJEmaV/o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWHR+767CSXCQWEbGj0J+20j5BFS5m0bOteETGaSkpd5D5KwjRhcYukNrjnF8lwqfHGccSXDFLe8SBFdYxPiy8gDTDocWUmcSHvAnRE/UAsrKVxtGor9ETJxBpQ3saDG7Nh5yMXRIdSfMzXZ8/fkuf1smWWrttuX9xszZYySiWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AsrTkpLy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mBOWZvf4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768988200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7DV1XJTkbFynFHoZNtzuqUf26Hx/N2mSbX7HPLgi2JE=;
	b=AsrTkpLy9xMedKEKV67ajgeoIQOyV4YwioRFOvxvNzGSUrzDUBfskhB+Tc98TitlDzG8kb
	E3z7e/UomGnuoKODhd5xahNnXLstKS0MTrreKeceQLQQuIXPwEkatMEIcBmkYeDvBtidh4
	ERpPDG5SNLjlOnfTq6NS17feY+XF+t4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687--HB8iSK-M6-jTZk_DrQvZg-1; Wed, 21 Jan 2026 04:36:39 -0500
X-MC-Unique: -HB8iSK-M6-jTZk_DrQvZg-1
X-Mimecast-MFC-AGG-ID: -HB8iSK-M6-jTZk_DrQvZg_1768988198
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4801d21c280so38005085e9.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768988197; x=1769592997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DV1XJTkbFynFHoZNtzuqUf26Hx/N2mSbX7HPLgi2JE=;
        b=mBOWZvf4/lGHrh3XqrfKWkliWdWejnSk88BhDi+tWVE5NQjr1CO/QSXEiszUfg6+jr
         SuObPYERvU4XR2R1PrXsHon+dROyaSJsw2SXKDe6bFRvvGkDOl24gGXUerXdvweaRYN4
         H3nMXTPTnq9pmSVM49HF2OcYrmaqHlakD7QAc5eW3AYFkcZCgxFpSqabManMkL6StVw/
         hzVAuW/xzR/mAVkDfEH+aq6CVlbFvMaiuPE68BPsyaEoSCIOQ8WYxNKWLYN+TueBUzDC
         6NOVQWqbjtrDHny/JB70RE1AXCPB5lWI1IL/n36qX9231+3LKO4UWrOjA+RYqZA7dNpM
         Eifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768988197; x=1769592997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7DV1XJTkbFynFHoZNtzuqUf26Hx/N2mSbX7HPLgi2JE=;
        b=o0qmQVjz4yp+gBkZssblcX8OciWDYibfTTtHFffXjL3vDOUOd3oVvr4uWZAQ6zH5PL
         KWby8C2/XV7lYvYBsO5jpC5MYjppqWFcO9lEKPILZWOM1+FdL58euRwKu15IrOPA8y84
         ZXDmGCqnFJPRrgSpqdcu7pRhOowJahVlghSPjcuO/erZYpfX4lXzKwIqB0ozoxXRQegA
         vZvJmcZ3EEVaGG2XGyY+LYGbfLwMcoB+KR4M7k351NX4Dy9LrFOJ0RKTF3SSfha7fo35
         ZNDMWNld1txZeaXsLT8ebpisynp8johytWLnBD8ln+R1PZuS7KgcVcf1gROcRLDF5IDs
         ipvA==
X-Gm-Message-State: AOJu0YwjJovH2yGGdBpnIMDt/C8TiIMGeq9bkElBzVTKnoNnHppl+6s1
	Ly3t6QAPbQi7UGGo/9kQ+wEbTr3LFbc+RXKod3FxDpijE6aVq7GPMhe/iBdSXcC86UCnks0isrw
	y/wDKx4ytp8xhorL2gFMIaZd3qc8giwTmcNiiyquJmHM+LIR48oOYaO9UmfnVmc0+t5V/dYP5e7
	ILcm5rbnGmLhgbaSKDmjj65jOpKnQ5TsuQrO0f33RDCw==
X-Gm-Gg: AZuq6aLs5gtq9wzca3Cu4lew5+5ExlxYunLikapOpjTnsH5v8T0ipyY2KyG6N1FTyLv
	xrTl2IqnSmBoITGe7pffOqjPtJkZh58EFn0VoWVKoz2/+0XeQDCrDQBO2WLa55mlmI9tPMlXN6c
	kAAqnkt3OERrMOrKVDEqXv5+Eiy7FIJeRl0zXivMnwiHyqz0JHvSDh91+k3ttQ/rSaa+mnf3gqH
	8aSt+9pHrUj3yD8/KsR7G9w7l/sRvqTWvu2bm/1yxyYAnuW5gRUnux46difefkS4DGjJqRUTS4u
	ifQezJceCtq9PeUgz6bLE8xJU4knJUhOUT2Zt2EMFSIqxCOViOVJDoVHV1zmE5cbZU7pspuObxR
	qe/xP4fN5uYNyA45ljezkrtEFDkCsmVMItJIZ2AQ0DDWgflErfsTaKW9JNic6
X-Received: by 2002:a05:600c:5493:b0:480:3a71:92b2 with SMTP id 5b1f17b1804b1-4803a71968bmr114132595e9.26.1768988197367;
        Wed, 21 Jan 2026 01:36:37 -0800 (PST)
X-Received: by 2002:a05:600c:5493:b0:480:3a71:92b2 with SMTP id 5b1f17b1804b1-4803a71968bmr114131865e9.26.1768988196858;
        Wed, 21 Jan 2026 01:36:36 -0800 (PST)
Received: from stex1.redhat.com (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43595e0a6fasm7161626f8f.10.2026.01.21.01.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:36:35 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Asias He <asias@redhat.com>,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH net v6 1/4] vsock/virtio: fix potential underflow in virtio_transport_get_credit()
Date: Wed, 21 Jan 2026 10:36:25 +0100
Message-ID: <20260121093628.9941-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121093628.9941-1-sgarzare@redhat.com>
References: <20260121093628.9941-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251825-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,redhat.com,sberdevices.ru,davemloft.net,lists.linux.dev,vger.kernel.org,linux.vnet.ibm.com,linux.alibaba.com,gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 7C56354B4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Melbin K Mathew <mlbnkm1@gmail.com>

The credit calculation in virtio_transport_get_credit() uses unsigned
arithmetic:

  ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);

If the peer shrinks its advertised buffer (peer_buf_alloc) while bytes
are in flight, the subtraction can underflow and produce a large
positive value, potentially allowing more data to be queued than the
peer can handle.

Reuse virtio_transport_has_space() which already handles this case and
add a comment to make it clear why we are doing that.

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
[Stefano: use virtio_transport_has_space() instead of duplicating the code]
[Stefano: tweak the commit message]
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 26b979ad71f0..6175124d63d3 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -28,6 +28,7 @@
 
 static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
 					       bool cancel_timeout);
+static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs);
 
 static const struct virtio_transport *
 virtio_transport_get_ops(struct vsock_sock *vsk)
@@ -499,9 +500,7 @@ u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
 		return 0;
 
 	spin_lock_bh(&vvs->tx_lock);
-	ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
-	if (ret > credit)
-		ret = credit;
+	ret = min_t(u32, credit, virtio_transport_has_space(vvs));
 	vvs->tx_cnt += ret;
 	vvs->bytes_unsent += ret;
 	spin_unlock_bh(&vvs->tx_lock);
@@ -877,11 +876,14 @@ u32 virtio_transport_seqpacket_has_data(struct vsock_sock *vsk)
 }
 EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_has_data);
 
-static s64 virtio_transport_has_space(struct vsock_sock *vsk)
+static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs)
 {
-	struct virtio_vsock_sock *vvs = vsk->trans;
 	s64 bytes;
 
+	/* Use s64 arithmetic so if the peer shrinks peer_buf_alloc while
+	 * we have bytes in flight (tx_cnt - peer_fwd_cnt), the subtraction
+	 * does not underflow.
+	 */
 	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
 	if (bytes < 0)
 		bytes = 0;
@@ -895,7 +897,7 @@ s64 virtio_transport_stream_has_space(struct vsock_sock *vsk)
 	s64 bytes;
 
 	spin_lock_bh(&vvs->tx_lock);
-	bytes = virtio_transport_has_space(vsk);
+	bytes = virtio_transport_has_space(vvs);
 	spin_unlock_bh(&vvs->tx_lock);
 
 	return bytes;
@@ -1492,7 +1494,7 @@ static bool virtio_transport_space_update(struct sock *sk,
 	spin_lock_bh(&vvs->tx_lock);
 	vvs->peer_buf_alloc = le32_to_cpu(hdr->buf_alloc);
 	vvs->peer_fwd_cnt = le32_to_cpu(hdr->fwd_cnt);
-	space_available = virtio_transport_has_space(vsk);
+	space_available = virtio_transport_has_space(vvs);
 	spin_unlock_bh(&vvs->tx_lock);
 	return space_available;
 }
-- 
2.52.0


