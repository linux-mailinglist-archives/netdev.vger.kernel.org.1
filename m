Return-Path: <netdev+bounces-288947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKg0AN3WCmqc8gQAu9opvQ
	(envelope-from <netdev+bounces-288947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:07:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C67195695CF
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79999300A325
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 09:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863543E5A17;
	Mon, 18 May 2026 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C3I7nypt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NW93tZzJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663D23E4C9D
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095226; cv=none; b=mQlcFiFEgYtL6SxEozSfJwtQLCvlzaKQ5Hbge6vbiEDJKTXAM+eZdZ1scPjjptcgA4aeAX52RcsKfgBO3nnt1W5P5qXXk9VWYjX/o5ncy8vG9rhW3VyPXUT+9rx0B53LtSjbuR5IWoyS+Ck+7DVqXJ0RAWUE1g2t8z0edv+egAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095226; c=relaxed/simple;
	bh=4Jgas6XMDUNHabFy3gLOXXGPd/CXV5aZuFt6IpzE+ME=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Mz67HIuiYd1K4bDg3keMEsesvsm4yWVRLV0P5mFAhOvQJdmeGl7ybx6C1exQ5yLopUryxFMq9MBZqOn8hNGuJG7azNR/fx+UtaTS024Ii2xFBgBErUphqBPctMaic7i+OvccPH2v36atpjLlSVBRoOLCz8jUtomrzmAQpOKnq/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C3I7nypt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NW93tZzJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779095222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WVr+ozlWbMHYAfpi/swl/ldM7Por8GhrxE5XtzjKwI0=;
	b=C3I7nypt0CqHtwM4x6/+buG5pneBPdx7dxPyjAH8sUT6icPpIQD/952T9ZtAg0O5RLL8op
	t6vnHBCctI6KI7LSuIjAHeJ/jZuDwIiMQ9tbOZ5HHxXqWV1HHkcRmG2w1SHiGRY8gPRivP
	YBHbm8rm+eTxYSK4lE2xRjSfYojjGQM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-iG7szTnYM0mObEYSZJgszg-1; Mon, 18 May 2026 05:07:01 -0400
X-MC-Unique: iG7szTnYM0mObEYSZJgszg-1
X-Mimecast-MFC-AGG-ID: iG7szTnYM0mObEYSZJgszg_1779095220
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48fd2b502e2so15164595e9.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 02:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779095219; x=1779700019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WVr+ozlWbMHYAfpi/swl/ldM7Por8GhrxE5XtzjKwI0=;
        b=NW93tZzJ0TMy1f/345XjJDPEgfL1iOqk8JawoVks3FSzoQoW19IN+gmDRowBVBM1Mg
         OC9l9TilTHki3qhS40JGpYugXmvcYMWd0Jf8yvm2Sob4x4xYHTAKuUCiC6zb8uw9DXHp
         gwvMoZDB1Y/2Nq+QQuKdkLW3qTfSV6gIAy2UTB+EGtsCUvAMTLIF+RdaoJ3fw56mnaLq
         7ctK6HFNwqNr7f9wLnqUbKWCZbrDFlvY66bTSoWshOt7HtTQJcPUa9gEy11C8dKY0dBO
         Fyf7A7BUQiSidt/Fy9/mV/NH94LJ2trrcWGH9Lhx4USWR03W845OziA28erEUmm+pnEA
         FfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095219; x=1779700019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVr+ozlWbMHYAfpi/swl/ldM7Por8GhrxE5XtzjKwI0=;
        b=RgpHBbD8yhmRm8hB3HfYm+Q4qBV9eSGGeZaTO6iXCQu2mBUOn3PXxM+D6kr3ci/LpB
         xR9R3KLiQH3100aa+L8WiXpTA7f0hlOBseby3dfH/uqOLSHbiGoZGILb+Bik2HySwCab
         PIlYm56og/38m8hj7BzoKJabn8Y+ohgmuUgnCyMwLA8CqFZR8apfMJ5XGaASqLqQWq8W
         hN1R6DAYB3t6Rp/a32D5L7wiVgS3qK5n9wm9aZeVZH8b5QscV0eXRfr6c0MdzfAJj8+Z
         PnIY/2DXhCXjK55VJQ47rROSQHMdrbB6Px+R89vJy28KDhzyEj0ES20L+7K5aQ4Dv1Uq
         dehg==
X-Gm-Message-State: AOJu0YwFYe4w2hCPs4aQi7PqgARmXmawZ8G9fFEAvBD/+LUsEjgxzz3O
	q2llV7htqhsgKHnpED3B5wup3oFzBRDQb7FP6dxJOXT1RDyn+a1FGaPBJO1cvUSZHbF9dLd3oSV
	bejWpd3Yhahq0tCrAmJMg6OeCPaBYy43MAsFcRJX5rcsGbEC5X2Y/AFeBlAqgZdUkFFYVtAawGe
	q7KiMH2UzEZcISprwlPgub3GZ3DELhcCMQZ0Q6GDeT9w==
X-Gm-Gg: Acq92OEd+FlwS0w/ve84UTUUUw9ZUgLqeEV8UXDKkzfWbqX4vBZkjq3GUE5g1KQGKry
	wl3/yB0KmL2CBGqVUfe0s4z285/GGaq5seprOhppbdPeBqBb2VbiqpL/OYcwN2UEmaLtm3YQjbp
	iCY9D+VEYz6z5KyNVz0RgCdbh8QhrketF+7VnCEeCYrBhqUDNMvnRyIJocIyEkDMqD+11p2C489
	+M/uFeE/gvpd+oPfBj+lidCctlRVRdiSQkoxchjeyuMM5Qb6cikOt3ivDUXrRP4d2RI1erAdys9
	655NHv73L4/ZY8qALGyr5ybmvFJH6Tg8CaOLVvIdkSzLxTGi4ozHkUmQzZfdNfwi06H6TQRK9pn
	R7yZusVwqe6mLxQGD1fWrsLXsiiwxxI5tSxO7K2F9E8w1tg1YKJrQRwba+w9L
X-Received: by 2002:a05:600c:8184:b0:489:1c1f:35f1 with SMTP id 5b1f17b1804b1-48fe60e1451mr214884255e9.4.1779095219335;
        Mon, 18 May 2026 02:06:59 -0700 (PDT)
X-Received: by 2002:a05:600c:8184:b0:489:1c1f:35f1 with SMTP id 5b1f17b1804b1-48fe60e1451mr214883165e9.4.1779095218657;
        Mon, 18 May 2026 02:06:58 -0700 (PDT)
Received: from stex1 (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5e9d5d9sm279478545e9.15.2026.05.18.02.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:06:58 -0700 (PDT)
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
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH net v4 0/2] vsock/virtio: fix skb overhead accounting to preserve full buf_alloc
Date: Mon, 18 May 2026 11:06:54 +0200
Message-ID: <20260518090656.134588-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C67195695CF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288947-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Patch 1 resets the connection when we can no longer queue packets,
this prevents silent data loss, and both peers are notified.

Patch 2 increases the total budget to `buf_alloc * 2` for payload
plus skb overhead similar to how SO_RCVBUF is doubled to reserve
space for sk_buff metadata. This preserves the full buf_alloc for
payload under normal operation, while still bounding the skb queue
growth.

In the future, we plan to improve how we handle the merging of packets
to minimize overhead and avoid closing connections.

v4:
- Split the buf_alloc check to be sure the credit is still respected and
  to avoid overflow of buf_used [sashiko]
- call virtio_transport_do_close() and vsock_remove_sock() to properly
  close the connection and remove the socket from the connect table
  [sashiko]

v3: https://lore.kernel.org/netdev/20260513105417.56761-1-sgarzare@redhat.com/
- Split in 2 patches [MST]

v2: https://lore.kernel.org/netdev/20260512080737.36787-1-sgarzare@redhat.com/
- Close the connection when we can no longer queue new packets instead
  of losing data.
- No longer announce the reduced buf_alloc to avoid violating the
  spec. [MST]

v1: https://lore.kernel.org/netdev/20260508092330.69690-1-sgarzare@redhat.com/

Stefano Garzarella (2):
  vsock/virtio: reset connection on receiving queue overflow
  vsock/virtio: fix skb overhead accounting to preserve full buf_alloc

 net/vmw_vsock/virtio_transport_common.c | 29 ++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 6 deletions(-)

-- 
2.54.0


