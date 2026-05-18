Return-Path: <netdev+bounces-288949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sM3iJkTZCmrb8gQAu9opvQ
	(envelope-from <netdev+bounces-288949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:17:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB8A56986D
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B68163053629
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 09:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840043E6DD0;
	Mon, 18 May 2026 09:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cV0Mjq7h";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q0WqA1yB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FA33E6DC6
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095234; cv=none; b=SXRYNdfU3SjTrEMVAYqqhGnWG+41uM3/l+uy9XFynVRpnVP8FXOqBdUzu7A1WsE8QwuUAMdZJwU2BHPLmRqsG/PW27mpT5RwBfdz8Oot3dpzCYIVe9H/bl1JlrSDw+XKTYUNJG2cHh4Nd8z8HOxb1mVrkD3lSNoW7Q0zalcY5BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095234; c=relaxed/simple;
	bh=eYAsyzlcZhIaTkBbynj1OR7+7bApP1e2I2Pa+c+c3J8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3fc6t/D4HO1KIyxZq/qvAQMH4RlOYlfXKCv4IJ8YkYdeXzJkN9MD/b4KXVFmTSF9a4drEQeIGzXZ3eilfS+zqGv/4uYSm/eVne9GZJ5Br2eegQuAxt5B55ZPnyOiu37cutEdBrZ/BC2vy6D6F/n0VLftKhdSIYdbzgVo0psN48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cV0Mjq7h; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q0WqA1yB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779095231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dsBo8SZnL+tIoKyB10yuoDT3WWwlz7J8lfIk8OOzpIc=;
	b=cV0Mjq7h4udO/IE8ULNaDpfN78BaEqHzpoBJGvbUwQYt4qHmLqNy1R0XlV3MGp+juN48C5
	w0b1YSlzAVdB5Yuw1oncQ4OSOAGnVar35K2HMegAvSfYUoFVfKiHhWreWJGXwjeOGo0YIi
	MS2GqlQpEmORBorrV8zxpvK3gB0+zro=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-kdhAj0MNPye7j4LNkNq-Xg-1; Mon, 18 May 2026 05:07:10 -0400
X-MC-Unique: kdhAj0MNPye7j4LNkNq-Xg-1
X-Mimecast-MFC-AGG-ID: kdhAj0MNPye7j4LNkNq-Xg_1779095229
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4411a2c034fso2074891f8f.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 02:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779095228; x=1779700028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsBo8SZnL+tIoKyB10yuoDT3WWwlz7J8lfIk8OOzpIc=;
        b=q0WqA1yBuKqudkMDVa9gbdGVzMuIsrVVXNRSwdw3bjgtKnlxMLvJDWrMYDVPEUDhj9
         0QvedwBtRKqNr2F1FrzlxHjJIDmlaHNTkjOmFKFwsewObfVeXX9z/j5l0LsA+LurGglO
         C+aHH7ig9mUcgvF37isjI/JUvEGBJHCyMacgjX7fVv3Cikju5hbhhdzNY9MJNsmfKCXC
         TvvuMtEd7rfvBcZdRbjvQDJrtxVYVcMnoW2RPb+r9/O/atMX0gSuu+aBKebuGAWQAb48
         xlb6ZaThvvV5Fwn67avpYSW3LgKF2Uv/xlmpcz0ykEMEEAXQJOFlRd8ijkcQQGqcYFtc
         PEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095228; x=1779700028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dsBo8SZnL+tIoKyB10yuoDT3WWwlz7J8lfIk8OOzpIc=;
        b=B5tQDp18ueyp7aXfmv7GBHK7rJkEfucP5vDvSKjqA2e+ly2qAFjJ8yJKlDeRwVvzAz
         X6BaAHxd+/KXOUwMLq3mCfeNclmOa0GEeLc0y5aH41jwfM7tFLlMC8ThrEilfehny/XD
         9aoO2YOx/ySVpMzq+7cLU0ReSuPKoPumEGtjGUpszsrDDCnpTvUc41iMXNLwquJyEyaA
         9P+1LdF35qtNECOiJBm2bVH3UGOrtWnJktjoOSy2i1vBIPR+QP56KIkNnzZCylnpdZ61
         eily4Q+by8AkG2NJWDp25HpGNmAk0rESprmGXEaD4jq7/FipX4xXUXilbopqRIghJIYq
         bhFA==
X-Gm-Message-State: AOJu0YyKVkzQFviarhtuuWFXrN7TsiJMY2LbxlF9Rjw39pJrI/V2TA/Q
	jyUuqE0kaa/MHxkIXRk+/hqib0tZ8jJTCqZB6Rod8OqZidifXCX6n/Yelgr20fnqpkiLWitq0YH
	AOQOUyp4JI7cqWYky17HvA8MlGvtKuISXfqRIPmtrmTSckHnOBGvw3NTsQCBQ/E5MYE5FcJ+OHK
	Ld43t1fq32U6FjKDbKfp2pserXgdikgQA5E+9QIGrcEA==
X-Gm-Gg: Acq92OHRBbUSMv8gd+YYahIrqusLTVDZ2+ntZJGMDUM8j4LWd+oLhiJtTVPvF0ZIdsk
	ZD+3ozdJoXSnPjncTZt9mhRwRfyYGk7vd8nw8naKlV6xPE6ZCySZt+DXsiKgae5mT4Wqe/NWjC6
	/zNL7XTv/OWha6uO0UlzNpQuBLzzIgzACQcVwfQxZMqcu7lQ18JpJrl6G9D3Lm74eiqoAhl0xlj
	cFE+QvAh3hrtFSVXjGn9gBqJOX/vobJmehyCEH/9W6djjBcMAl9u0q9yDDyF8Ar0RALdmh7H6Aj
	cHB/9ocaUN3qHLVxtlP/qFXJiwAA4SlUDaK2QAiUGRLJHXMZrOD6WJOrXo/Rs53r6ba5SYxE1P9
	zdgRXuIiZ0pf091kCBrOeMJ8WWOP5y3/aqZZ8NmwFty75hUSE8ywjd6dd39k4Xx9YyMMORDc=
X-Received: by 2002:adf:e681:0:b0:45e:633e:a7cc with SMTP id ffacd0b85a97d-45e633eb4e9mr14807950f8f.24.1779095228451;
        Mon, 18 May 2026 02:07:08 -0700 (PDT)
X-Received: by 2002:adf:e681:0:b0:45e:633e:a7cc with SMTP id ffacd0b85a97d-45e633eb4e9mr14807870f8f.24.1779095227874;
        Mon, 18 May 2026 02:07:07 -0700 (PDT)
Received: from stex1 (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768072sm35104134f8f.5.2026.05.18.02.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:07:07 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4 2/2] vsock/virtio: fix skb overhead accounting to preserve full buf_alloc
Date: Mon, 18 May 2026 11:06:56 +0200
Message-ID: <20260518090656.134588-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518090656.134588-1-sgarzare@redhat.com>
References: <20260518090656.134588-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9DB8A56986D
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-288949-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Stefano Garzarella <sgarzare@redhat.com>

After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
buf_alloc when checking whether a new packet fits. This reduces the
effective receive buffer below what the user configured via
SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
silently dropped and applications that rely on the full buffer size
to deadlock.

Also, the reduced space is not communicated to the remote peer, so
its credit calculation accounts more credit than the receiver will
actually accept, causing data loss (there is no retransmission).

With this approach we currently have failures in
tools/testing/vsock/vsock_test.c. Test 18 sometimes fails, while
test 22 always fails in this way:
    18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch

    22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
    Resource temporarily unavailable

Fix by allowing at most `buf_alloc * 2` as the total budget for payload
plus skb overhead in virtio_transport_inc_rx_pkt(), similar to how
SO_RCVBUF is doubled to reserve space for sk_buff metadata.
This preserves the full buf_alloc for payload under normal operation,
while still bounding the skb queue growth.

With this patch, all tests in tools/testing/vsock/vsock_test.c are
now passing again.

Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
Cc: stable@vger.kernel.org
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 5028ff534888..df3b418e0392 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -419,7 +419,14 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 {
 	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
 
-	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
+	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
+	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
+	 * metadata. Check payload against buf_alloc to be sure the other
+	 * peer is respecting the credit, and sk_buff overhead to bound
+	 * queue growth.
+	 */
+	if ((u64)vvs->buf_used + len > vvs->buf_alloc ||
+	    skb_overhead > vvs->buf_alloc)
 		return false;
 
 	vvs->rx_bytes += len;
-- 
2.54.0


