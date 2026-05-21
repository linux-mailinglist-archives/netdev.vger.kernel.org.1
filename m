Return-Path: <netdev+bounces-290402-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ce/JyIHD2qFEQYAu9opvQ
	(envelope-from <netdev+bounces-290402-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:22:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB9D5A5AC7
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E23930E070D
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC773D79F0;
	Thu, 21 May 2026 12:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qy6/Hag8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xp0hxeWX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2AC3C4B64
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 12:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367678; cv=none; b=LDidCaop8u9Bv7NKW/5bXSdaEdtsOwFrVgOXiH6W97vQgNBy2g2iyIgZg2u3evNExQVQYRA9gofPieI4S3ujyi8k8hzWnhRFYdnDImQk1eyhepcw+r59S1/TPdDzFkO4U1tarBLvZBFWItJ7qsl4wsybvdLMxUKzoZw1B4GwHmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367678; c=relaxed/simple;
	bh=Dn6P2bkc/bzBUKXTydPjxy5n5j2Gvoyaa6sXWWpGFqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hv67hROTNXQj/iMyaPR7lTsSBJqOCidKlrqsusqTuVN1GCztiyKLP08ti/kbnDrs8tZN9zf705zDGuh+Zkxc5O+OzsYd6WWMSUveFYBDhiPc6Zjntwfltw60QsqvJzWxg5OvYMthDDpRx5OrDwgxE7K0hCw/qu2+SHsUPuaYmBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qy6/Hag8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xp0hxeWX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779367676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HUBSvYNIEeXrti7M5Q7uqS37K22xV9FH6FOTxmrZ3+g=;
	b=Qy6/Hag8nhqd9XlSzkjcrg1gLHE5aC8BIECNzTU69Z3XIB/h6XJkSjBycrsVISXx0+qz0P
	MevT0mAWEmhthgcoVPw6tgsyUeh7tDnrBeKC6/4DEam7EeUpc/IpLhyMb0vVeB9N6ju3B6
	5ZRtWW7tqJUPEY/iJqBuVqHV0y61ZuE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-Rr8Fq2IeMxe8-1CvBFvR8Q-1; Thu, 21 May 2026 08:47:39 -0400
X-MC-Unique: Rr8Fq2IeMxe8-1CvBFvR8Q-1
X-Mimecast-MFC-AGG-ID: Rr8Fq2IeMxe8-1CvBFvR8Q_1779367657
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d7730e9e3so3579253f8f.2
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 05:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779367656; x=1779972456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HUBSvYNIEeXrti7M5Q7uqS37K22xV9FH6FOTxmrZ3+g=;
        b=Xp0hxeWXTzkG+JHiiHIITTe2WKU43nP0bHUf05TxV1HgTZ6xQpVzHIoO1qlYNHdur9
         fQeWw0tV/vFZMHGFpadBy0tHwJ2LYbI4NCGFVKfmCCydVOGXqaWd7OMce8ymgTD1lPfV
         LTYAEEq6WkMFwCpZhK4KlRaM+Q1UmEH4XrWWo0qLwqLe6a1I7P9pekWJs/NkqTNmHikY
         u777LeE3eaYJjRIfG/bL7TjdsjjTk8mxkqEJS1MgTmvzdQplVQ0IPAnXwprE9PftTvgp
         ZfWh7fbnE7rJhqKcJvBL47iVTUSrTtzfKpve8p+Pws5oCE6j3pw0QJH1DrPl4z+uBTc0
         mYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779367656; x=1779972456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUBSvYNIEeXrti7M5Q7uqS37K22xV9FH6FOTxmrZ3+g=;
        b=kE39Avmmaj+XPnvLQUgGoZ6+pXngz6jygCimsEodIne/FKS+J04zSfb0syaQz8c8RR
         NlXdowwWwm6Gyh4KoNbFZ9YADjjLzgkm9veJa3CxvTb0Z1esX0zTCQ8b8CWMHU6s2dVH
         TfNODKiTF/4MyAUvLO1LAAucgKYl/yreF4ttmthKNW3zVeKg/+k58AMvrvLd6MEG/xTv
         Lm7IF08RCP7boXmaVsGh6+P7qfsbmGdqSHW3nE8Cv7VrTpXWQm84166AxGQk8YiSjw5Y
         MztRovCjdkJfDpAn9b2uRjooACv291cWjfRFtk8mMonRzO8peXCdKNp9PVst2tCkbGZq
         78LA==
X-Gm-Message-State: AOJu0YxT2SP/sGy0kxKnSwGBV2WccrhPKaXikMOCR5+mnmF2e0XeNsFw
	CSq0mHCz9nWuq7VX+V0uKq9FXRKv4XH2XeJjLwRFuo8v63gaZO52KWAODihuwsrza1nNq9KWGHj
	AKfQ3gWl6J/gjXJeGL/Cd0PuuPn0CTxhxYnhHoXk/xelwRZ6mBaYT6heedi+dRS78psEJaHrDQS
	vbPL3tLlpZXwLdmEpMhA5Cog0adp++O1NU6gqh7DsK6Q==
X-Gm-Gg: Acq92OG4sRua57f/FPc39vvKu0ykycIvLa+b9lz1lkD5NkJX/663uoHcnpsm6INkTAr
	ec+iiVDu8vQY+FmqUknwb2at8qL7JPB7wF50+x9Q5jXkUVS9YtbKT5znwi45e99XzgDLGsNNfGA
	zOO5itLNB/UuwQ5cR6myBo2rTE1dgLaeGLAQxh54FWoDdAj0LhCAGdn8ttw3InLSfwNlD3Q/ftl
	/untHnw9mv45vaRvJ9RJftU0SsAcvzkJfd0i3jz/puV3d5nrfZEpJbnT5qEIX6tguBuizryM9jM
	qx1aXQXLe/Ckr4CRiqAFTGmL5gEXNZ0gQVOP+NBMQvSJbKBEJKRVMOUTd1oYBxsW+R2ykDFPFJZ
	/5ZQ7T7Qb4Elu6CyzyGkPyHI8yg7E5TiM4/Colv1j+60I18m0IGiwn/wk31yRtckkOWxJ+M7t/1
	uTskpfGGHMWIg=
X-Received: by 2002:a05:600c:3513:b0:48a:75b9:b0bc with SMTP id 5b1f17b1804b1-490360cce5fmr38604725e9.29.1779367655873;
        Thu, 21 May 2026 05:47:35 -0700 (PDT)
X-Received: by 2002:a05:600c:3513:b0:48a:75b9:b0bc with SMTP id 5b1f17b1804b1-490360cce5fmr38603965e9.29.1779367655227;
        Thu, 21 May 2026 05:47:35 -0700 (PDT)
Received: from stex1.redhat.corp (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d52c8bsm69391315e9.8.2026.05.21.05.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 05:47:34 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jason Wang <jasowang@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	stable@vger.kernel.org
Subject: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit builds
Date: Thu, 21 May 2026 14:47:32 +0200
Message-ID: <20260521124732.125771-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290402-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BBB9D5A5AC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Stefano Garzarella <sgarzare@redhat.com>

On 32-bit architectures, both skb_queue_len() and SKB_TRUESIZE(0) evaluate
to 32-bit values. The multiplication can overflow before being assigned to
the u64 skb_overhead variable, making the skb overhead check ineffective.

Cast skb_queue_len() to u64 so the multiplication is always performed in
64-bit arithmetic.

This issue was reported by Sashiko while reviewing another patch.

Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
Closes: https://sashiko.dev/#/patchset/20260518090656.134588-1-sgarzare%40redhat.com
Cc: stable@vger.kernel.org
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index df3b418e0392..71198bf23fc4 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -417,7 +417,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 					u32 len)
 {
-	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
+	u64 skb_overhead = ((u64)skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
 
 	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
 	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
-- 
2.54.0


