Return-Path: <netdev+bounces-292397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sORTF3YgF2rw5AcAu9opvQ
	(envelope-from <netdev+bounces-292397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:48:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7AD5E7FE4
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 95ABB3026276
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C993C584A;
	Wed, 27 May 2026 16:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwOkeUkM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gy6qKaoI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9919B2EDD78
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779900531; cv=none; b=MTnVpuUjp4BK2OJSq+7px1wHBrjULdSKeyJIlUYhjFdaYsBniKRXS4m+dbsqUqWlCYyX4OrQ8DyI9R63No32yJ7N/5gBkgMBHTpBnVNPgDAOboB6IwWtrG10Z34lC42+KIM2A9V4cFJFzEvHQJ3dIQ/dpRmCShAa49MP8kraxuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779900531; c=relaxed/simple;
	bh=Y9H0GY6k4T9clxSJ4yaRMplKa33pAMEcbXdMFf6KU6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NlRGFBWHjAsKjMfwg7Jhee41wywK7JonWmMh7RBk78z1ZSl0s/xScOuHinhXA7sjGKXOFXERjoaNE7Rqf4bqRd1Yk4Nu1isWFF2F89tmFKW5Y/vejUxpwV2S1SGZw8FtxMJuKWqvAoR5i7r7AwTBbnhtYaH05BvxsUZAUt+Pj38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RwOkeUkM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gy6qKaoI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779900528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1yn5UxI8QEgnLkFElBqvhz3nwZebD8rthNLyz5wiHFs=;
	b=RwOkeUkMOHTdFKghwJ3pFzCfvfLcUerlqqzShxQLFI20x9kDciwSMUuFinBP/o5ZbzdddH
	dNis3S2Vf9rtRR1n/NHFK4pUcbB8SlfuGlqrwhSf4M8VeFIS29RUeMagqdjZ4Z2fH1wTG9
	wWZRLknQ5IeImnl2pcv4Zm5hSBL9LCE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-THDEUJSVPX2_MPJCgK6i4g-1; Wed, 27 May 2026 12:48:47 -0400
X-MC-Unique: THDEUJSVPX2_MPJCgK6i4g-1
X-Mimecast-MFC-AGG-ID: THDEUJSVPX2_MPJCgK6i4g_1779900526
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4411a36715dso7807678f8f.2
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 09:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779900526; x=1780505326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1yn5UxI8QEgnLkFElBqvhz3nwZebD8rthNLyz5wiHFs=;
        b=gy6qKaoIT3VcmggvVeSjZqe6AUBt0iEx7uGKniXDObjLMZBs3xgHqc8AZQLThS+LAX
         bTeHoSr5HpOuSjeKa7HW9oan9e1zpFSeOKby+oFCX963XhPM5jvoCwVkRirYvjH/oLZn
         Bz+laAUSJz7uSzxgJk+lOyhHgvVfspMWBo1sLhoMoXCEXn1uzGeNKTOpaMwIw1aH5sFN
         v8QP7dLccmwSEfEdwsCmOeuMXKzYYamwfEpaODBfKhqpzyOvzNU1to+xgb0dMM3YTH2p
         fpdYvSFGFxUhLaFyIkwVuQ2tXk3RifLUHoRfLu1kTpa9RY4lH57OV3qGcu4ezxm59R8s
         f6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779900526; x=1780505326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yn5UxI8QEgnLkFElBqvhz3nwZebD8rthNLyz5wiHFs=;
        b=dprrCpieC3/BEHvRFCwonEW6vRUvWLZpUrJYccDVBB7diX8cE/XgABuWuJkmGEt1HF
         ChJlk3mrRWdrvbXJhqYqlJhYQxPIXpm/8gzMcLNt4bnUVGH/N5qM0NjJ/ncbNwSghQYq
         GVhkYcVcp3nN9QT3fo8F8vQ8bVcdV4RDZVXnE4oR4w7zgsihXM8RpYxV9Ku5Dfm28JZ/
         kyKKU3VpuN+1ALNfB0L59SwvIWNUeO8Q0+hxp9EhZVtz05DRtY5ndfscGTQdEz3QCMKw
         XtwTx+sIz5qj5RRyDDAHbTp8n56CR7mqHpGleqfyele8rDIff7tG6x3uMjk683Qcxcn7
         vFNA==
X-Gm-Message-State: AOJu0YxLTt1fMrbPbKr3qdGTAuk0h3pcXa+49rocFt8ujT2iuP3drs9t
	NpR7cn+qlkkVj/Uo/ygC/gqlGGCzyMdvTYQFsy/QaqyXBKlROCZlNKAlL0D6R5AXeW8OI9CtR1+
	pKDbd1G6qme/YadocXBv1CwF7BAzJPMzT0gMvH7Fzw6mnj/PxUYaZp7Ete80rrS9fVrkXKe77kz
	Xmb3Iw5WpXdiqu9be7PX0EEe1cdGB0FhEgRjzJDfK/Og==
X-Gm-Gg: Acq92OH4LGp1GuLfoSUcqBmONknRoPEgontcmXw97BadWn3ea+YwWKXQ2nwBtO0bPe2
	mVhjzqzqQDLfrU76NktfbViRSgw/kC9WIqp+iiX6QrA7UlqDCSApUD9Tym51RvAydEKISL2jf5g
	dRhvaYP3xiZTVSJWEXIuuzcgSGJmsg9tANQc8V64uZOlEs7Feewj6oDFbgIoZMajtHJsZS2R1o2
	kmeVzUuLKXwUt8SlXKgstZPYf9BoSFc/7aWo9bj1YvXvWAhGgYHtNsZ6QQh3JExOJWyOFl4FrJY
	sZy1oygMKiJA3uxHg2DSO/hBoWz2HwWcQlLGE40SY8t+cWQcVyg1AI/wL9sV9oobbMYREtJyfUA
	pz7x2gO2EYKoi1Nshmm+dYo2pdHVCI/jC70SFnf+EmAwQbmov/Lzkx1hWaA==
X-Received: by 2002:a05:6000:1888:b0:441:1e1e:a050 with SMTP id ffacd0b85a97d-45eb38b8a09mr40802538f8f.16.1779900525874;
        Wed, 27 May 2026 09:48:45 -0700 (PDT)
X-Received: by 2002:a05:6000:1888:b0:441:1e1e:a050 with SMTP id ffacd0b85a97d-45eb38b8a09mr40802467f8f.16.1779900525261;
        Wed, 27 May 2026 09:48:45 -0700 (PDT)
Received: from stex1 (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5a296bsm6788897f8f.21.2026.05.27.09.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 09:48:44 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	David Laight <david.laight.linux@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH net] Revert "vsock/virtio: fix skb overhead overflow on 32-bit builds"
Date: Wed, 27 May 2026 18:48:43 +0200
Message-ID: <20260527164843.125054-1-sgarzare@redhat.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292397-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2B7AD5E7FE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Stefano Garzarella <sgarzare@redhat.com>

This reverts commit 4157501b9a8f ("vsock/virtio: fix skb overhead
overflow on 32-bit builds"). The fix was semantically correct (although
it would have been better to use mul_u32_u32(), as David pointed out),
but in practice we are estimating the memory used to allocate the SKBs,
and this will never cause a 32-bit variable to overflow on a 32-bit
system, since the memory would have run out long before that. On 64-bit,
SKB_TRUESIZE() already evaluates to size_t, so the multiplication is
already in 64-bit arithmetic without the cast.

Let's revert this to avoid unnecessary 64-bit multiplies on the
per-packet receive path on 32-bit systems.

Reported-by: David Laight <david.laight.linux@gmail.com>
Closes: https://lore.kernel.org/netdev/20260523173557.5cc4f4f6@pumpkin
Suggested-by: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index b143290a311d..d4d26fba9e37 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -417,7 +417,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 					u32 len)
 {
-	u64 skb_overhead = ((u64)skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
+	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
 
 	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
 	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
-- 
2.54.0


