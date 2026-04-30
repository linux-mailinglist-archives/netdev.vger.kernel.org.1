Return-Path: <netdev+bounces-282836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJBpKZJK82ngzAEAu9opvQ
	(envelope-from <netdev+bounces-282836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:26:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEDE4A2C0A
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A12D530058EC
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990D8402B9F;
	Thu, 30 Apr 2026 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lfqm2Ci1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389673B9DA2
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777552016; cv=none; b=f7kWSXFwfFzY3C9NjHgvCH+/gyBcU8tMYdSah1ccqmqIzsGdDGWm76YPDkAweWtpPho3+u9Fjygm//IPzRMx5Aa6U+Dw47k9Mhuo71WEa/2bFldeVe6mwluwzdH7UKq7P9Qtk1l2f3kaybElEfhtmQXe2obRVCEU7CP5y4rJUQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777552016; c=relaxed/simple;
	bh=Q+CUg+VsmZKjq366q44C8YuEEFsvKKcl8wiXNOwD0e0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SwIiI/TwUpRMSlUtds0vvpygY6cAtoeu+y7EFef0lZRR1Gx787NkNpffRDYShik+SgAc7nS9IYApnfecX2m6+1QhgGfvRVrDYv5uLVfMKyO6YK8HNH0M2ALd0RFgtAazbjnUqOmiszdWysN9sfpDryulZ8J39s9y4ZbjgroTNvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lfqm2Ci1; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-7b3e41a97f0so11807497b3.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 05:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777552014; x=1778156814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ee+M/5NYR6efU5/2iPR/zMWzx0RQD/fTLUx2lJ5g5rk=;
        b=lfqm2Ci1kxT7L2zqkmRFBiUldnMQYEIwVlyC4CShIeA7shJH7AX7DHWCBCJDzjX8Zq
         oSCiJaZlezPfdkJSmrVkbW7KC0Z1fX0A1l39JNUwhTEuTh09afUG83wxzG96+LKigBoy
         PSOxxw8GkPzPFK/GiIHBiCsca+mETKzwnaRHcRMfYDdBoDQLLWx1ersgT4w9/Y68/AMx
         g8Ax8Fh0yS8Y2FlERja0efTjNPNH1ED1/zBpcxMkPPrEh6Mf/P9yyL/hGOhQLmguJdLs
         s3EDA3Dy6rkDGCjq/VvjRKEAB4GSUrTTP5BK4235XeG6o+1WfJm4DVmmDEIryxWdbpSE
         XtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777552014; x=1778156814;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ee+M/5NYR6efU5/2iPR/zMWzx0RQD/fTLUx2lJ5g5rk=;
        b=FSTsQowZgY0XQFrRsbmLU21NpsG3ceaxSwRanPuf/UAvCpXtQOGoWterkRD4g6MkAv
         rxiNm5CpmkvST55oE14TM1lk+sD+/xNMHzVC+HL7JEo/jfMaGcqjThR9Qr7C0CWiBh7+
         kuKuqHBGXjMFNKULG6OoRV+ErwvCQgOL1hGYOHzHBIdovL4O9EoqZQxcXSKpDUJ2g62w
         tDP1C/0Up7QPD2S7YE/CZ63dkk818Ncsep3WOdWjHD8mfUYjn2CP5Ae4twVfgL+FURqp
         vV9NjP7+Ue0x/pmg+SATLHvo5/xJdhPR7uIMzGDZ+ScPLW3slJ0+S1xmvhY39XoOGvud
         sxzQ==
X-Forwarded-Encrypted: i=1; AFNElJ/3dVN0E13OKgcxHWTpDIot2ItAyfpePb75DL1PafrcgKOynxLE/6DBqFlJqCAo30EpaiNykGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ+oWoNE1Wuq7FPGiBhU8K8mU6SzdL2PqlxTrGW89rvokQrZjg
	JCjxTqP1iI/yZqruQCkFGqr3ZNAKKbFAwB9E39jdhZ+GRlpXXPoexzA1fG7pnQjkAVKpA3wkLG0
	URIFAWR3k6COOeQ==
X-Received: from ywbnv28-n1.prod.google.com ([2002:a05:690c:931c:10b0:7ba:eed4:c262])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a81:8ac2:0:b0:7a1:3088:e528 with SMTP id 00721157ae682-7bd5286eebfmr19968607b3.18.1777552014025;
 Thu, 30 Apr 2026 05:26:54 -0700 (PDT)
Date: Thu, 30 Apr 2026 12:26:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430122653.554058-1-edumazet@google.com>
Subject: [PATCH net] vsock/virtio: fix potential unbounded skb queue
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4BEDE4A2C0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282836-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,sberdevices.ru,redhat.com,linux.alibaba.com,lists.linux.dev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,alibaba.com:email]

virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.

virtio_transport_recv_enqueue() skips coalescing for packets
with VIRTIO_VSOCK_SEQ_EOM.

If fed with packets with len =3D=3D 0 and VIRTIO_VSOCK_SEQ_EOM,
a very large number of packets can be queued
because vvs->rx_bytes stays at 0.

Fix this by estimating the skb metadata size:

	(Number of skbs in the queue) * SKB_TRUESIZE(0)

Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credi=
t")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
Cc: kvm@vger.kernel.org
Cc: virtualization@lists.linux.dev
---
 net/vmw_vsock/virtio_transport_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio=
_transport_common.c
index 416d533f493d7b07e9c77c43f741d28cfcd0953e..9b8014516f4fb1130ae184635fb=
ba4dfee58bd64 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -447,7 +447,9 @@ static int virtio_transport_send_pkt_info(struct vsock_=
sock *vsk,
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 					u32 len)
 {
-	if (vvs->buf_used + len > vvs->buf_alloc)
+	u64 skb_overhead =3D (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0=
);
+
+	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
 		return false;
=20
 	vvs->rx_bytes +=3D len;
--=20
2.54.0.545.g6539524ca2-goog


