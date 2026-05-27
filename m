Return-Path: <netdev+bounces-292409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QD+mG/ElF2qu6wcAu9opvQ
	(envelope-from <netdev+bounces-292409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 19:12:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF665E838C
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 19:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B89633023062
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF6744CAE0;
	Wed, 27 May 2026 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boEBHft9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cEU/hSam"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E90B44CAD4
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901856; cv=none; b=SlDA4Qs/JtS8ADGVpOmFkY6XCJLzMev3zgCkIglGEHNBZ8K7YRDa12/O2zM2hXjdMdENYQUC2S2+GJtK+Mdhs33fEfAH+zUeCvSPogbfNzoTgTRpOhk8IsztL/8g6qZwFELWSyNYTfivaBob2zcq8BEwdSUKLw+2G1QEiBzi3Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901856; c=relaxed/simple;
	bh=Y9H0GY6k4T9clxSJ4yaRMplKa33pAMEcbXdMFf6KU6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AErDcijeEtoPLUTa1NFtFVAmnfsp6jO2XaxFkj/GCng9D9D3SON+OJgBv7MiJ7SapJcdHY+BMgOPYpno+2F2qka0S61hMuD8V/Jz+LnroOweY399V+UKVwDXFrhQx3imzK8XqiXlLOSlwocVPjDmrmd7PqX/YRkhob5VdCcWndQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=boEBHft9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cEU/hSam; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779901854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1yn5UxI8QEgnLkFElBqvhz3nwZebD8rthNLyz5wiHFs=;
	b=boEBHft9Oadn3tNlHOFhEe0noYQL27a4s/vIBFQmYYN7KwZ6LnlftVer449qfpW9IavWmo
	nD964/1x5i7am3Fa9dAy1HQ/A+d+fcXjBK5UjSTtqt7mpwt3T7PYgkAXWSlWD7mGQM+ezb
	2QrC7dCy6rMgkM/132M7xDeQRSNiOYA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-479sjoSzNCuqK-fkSdrhDw-1; Wed, 27 May 2026 13:10:52 -0400
X-MC-Unique: 479sjoSzNCuqK-fkSdrhDw-1
X-Mimecast-MFC-AGG-ID: 479sjoSzNCuqK-fkSdrhDw_1779901851
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49043386b3fso53175505e9.3
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 10:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779901851; x=1780506651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1yn5UxI8QEgnLkFElBqvhz3nwZebD8rthNLyz5wiHFs=;
        b=cEU/hSam9VUD2VtmoNRQcDnEQgkJFC5q5GsCkutgzOaIkpHMqK07PAl+3oldB2fV9D
         rOOb5UeYM01Di7kvN7DD5+6NYxO2VFygXSVNPKiUVvo29BFvYOf6hOY/K/648ZBLx/5i
         B+JqYiE4ipVBogl/VWZFKYAw3nbpSiGIMopmGyxwdBvpUadXiM7UyoJMWvX1uuMIPkAG
         MDuu9asx3uYkkeNjQNnG3u1zwrss2EhZrhawPMhbVy3XhoUsfY5WKrnB2JbnKsN3Oibw
         +ydcxpRsk5gWO0bwvNcsM98HQz6f2fJsvK72Vrbb46DEsLgBBMuJDkuCMlVD2ANj3JwL
         xk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901851; x=1780506651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yn5UxI8QEgnLkFElBqvhz3nwZebD8rthNLyz5wiHFs=;
        b=Gt9eiUlvioTTtY52CqbtoagvYcbuWnk7IRntJ1LGWo+nyrHtvzLkOG6ktUrn0FEQw8
         fj5es95b+DBs7MGfYUKUserH36crsEer9/yLk5lvvWQLvAzZjMpIXbupIs4jBsRyAWIM
         4CLh92RKtADOg7dzhiFAEDogvFDyNcs4lrSrVyjUMPDC9UV2VXfUPLjTtHCZahQSU5R+
         LbAbPd3FXo7Lhx6WU2N/ru7sc+ublchXHRENMXcdZccWB5FEURb5ymII3uKPos7uOz1Y
         wF/iScslGNHXFDmVeCLN6t2cdNLkUnEQeNp1HH14uK6vye7hPFTB6rflZTpA5WUpe0dK
         nCtA==
X-Gm-Message-State: AOJu0YxDlRzFeBvdY+1COD6xlGpN4w51SD7WS6axrq4I1PQ4bCV3Su2p
	rz9mX1ducoKp71OBob7YWaj/Aczf12793BTgwRMpaNNbaEWzmYokxVpLADFl+vKlilp4FTgbsLV
	2dXxnQVgFHH/zEea0zTR5CqHYe7j7yzgexBw1wxPHHdlJGu42Y/jIWulK7WAMb8MeEnm57JV2mH
	oEg2iogXNVYD6Ua89E37X1Vg4npazSdSC3K48u98n8hA==
X-Gm-Gg: Acq92OEgF5VfJK8cD0VFBKManA4Ujpuq4zIIaNbRZ7duu37q9AodGOMI8sctufvdQY0
	RNveyorp3ELFcnbbQwOlG5/J7cgeq3Kak+MwQOmec+sIY0tnjTRgObLn6odbVoo+VSBpZdRnw94
	bdaLxE1ux/N93bl5HneELmKC2mRRtwxuWY2Q2ODcx7s8MPjUMuPzeuEI4vAia5idxr+zcwta+Gf
	0PwbuGKpN0wr45nOnH6ymBhH9yB6FSu7eCMqk465drD5j1oxA/MGcV+pet24CH6Q3DvtGmy7wI9
	dup48gYbzPoXwLh/tOGPsJY+udJAKu+s5v+JLdCyrtZJ0f730KB5ny28RAAOrjEXoZCSnvpDVHS
	gMWcmKBsB3hTIjZrPyXI1CpONBJSggJoUT95xvTjxdtVEmrf7qc70ybeeaA==
X-Received: by 2002:a05:600c:35c8:b0:48f:f7cc:f703 with SMTP id 5b1f17b1804b1-490428e2d58mr447180355e9.30.1779901851427;
        Wed, 27 May 2026 10:10:51 -0700 (PDT)
X-Received: by 2002:a05:600c:35c8:b0:48f:f7cc:f703 with SMTP id 5b1f17b1804b1-490428e2d58mr447179465e9.30.1779901850888;
        Wed, 27 May 2026 10:10:50 -0700 (PDT)
Received: from stex1 (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4908097a320sm30225605e9.3.2026.05.27.10.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:10:48 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH RESEND net] Revert "vsock/virtio: fix skb overhead overflow on 32-bit builds"
Date: Wed, 27 May 2026 19:10:46 +0200
Message-ID: <20260527171046.130211-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,lists.linux.dev,kernel.org,vger.kernel.org,linux.alibaba.com,google.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292409-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DCF665E838C
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


