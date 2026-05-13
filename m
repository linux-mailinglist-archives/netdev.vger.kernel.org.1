Return-Path: <netdev+bounces-287526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNR5CN1YBGqjHAIAu9opvQ
	(envelope-from <netdev+bounces-287526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:56:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E61F531B66
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B150C30CC4F3
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002E43FE367;
	Wed, 13 May 2026 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXcAco1F";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="juwA71bu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41863FB040
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669677; cv=none; b=XCawCH/4TktoWhe3xJnZ9UBVwjnekfAyQ1AlspnPmUkvTacSo3YgAupn5LVazNdjJtpFiY68oNa6ohYVVq62TN/H7/AldhKpjoAQN/9HLEEJzMRy6M83+hSRBhZHWrW7l6lRAgFTddeATEwQxZZ82LxiOjvRG/YsD/Oqk5AEx6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669677; c=relaxed/simple;
	bh=IvdEZvwln3zcfx+cvlKQindvsy3EmR5EckwkcdVQXFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IaE9eW6OAlwqnu1htjqgACNsqcCPYlmMZloLusvqdkYBnVYU2E6BPuw8pUkfBP0tKhtP0+pkekypqMdbPrr2dfGQKxFkkkgNvHwA3WkY+cJ6eT4xq2ZusPdg/jz1gB69jLY2mIiIaHDRABtqbvBlwz4jKWCJv2JgGtnM/fjUK9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXcAco1F; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=juwA71bu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778669673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aGSDbvLykcv2buTIXBcK0yd8xK4cY9P0ZJuiRfh0cTI=;
	b=VXcAco1FPQATQIBfMJUIYOUU0DKWvk/VXKWjBHqPkTiLZwhqZWI/1+E6U5d8TenW3GszP+
	cxK/m+e1fDrStXaoLR9JwFkewqLASsQLXJ8F8u7KGNsqTG6AuefQhuDDeIyH+akGgEcg0g
	L8370jTIbbtc+hUsiPT7rkpGjPEekx4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-WgCYTHG-NO6tdWhGGmRc4w-1; Wed, 13 May 2026 06:54:32 -0400
X-MC-Unique: WgCYTHG-NO6tdWhGGmRc4w-1
X-Mimecast-MFC-AGG-ID: WgCYTHG-NO6tdWhGGmRc4w_1778669671
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d7a5b9678so4375109f8f.2
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 03:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778669671; x=1779274471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGSDbvLykcv2buTIXBcK0yd8xK4cY9P0ZJuiRfh0cTI=;
        b=juwA71bu3+DpWVxkvtaiE8MriHnjhdawBICKnY8HPizQRezQBhtVv40XfPXy8NrZ/b
         2EQZtv5O8frk3ZtOqBqC/KPEa+TiW5OPpqpFPRzhaUGTj6VS4NtN7pedKVzJUlFWZI6q
         GYayXwyqIN3Ll062TTyrHI7K39rmaWS37KK6m4WgRjWv6yTyZIMGVRtHolI1j1xAjUD0
         rEQw4hqIjShs3YjNGoUZ5PzPRKLT5yVU4GFaId5CGi1VnaUUFklq5QFPUa7EVLgc+uB0
         3BingDRsYYl3AFV+zLmhdUi936ixDnhgMcJx049m0eT+cEJg/mzCKUi05pRgkhsNzJz/
         tP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778669671; x=1779274471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aGSDbvLykcv2buTIXBcK0yd8xK4cY9P0ZJuiRfh0cTI=;
        b=k7JtkbbmqI8xdEOtRkNHklvuF1LKmgEURvacDpLNm4VexZ5id51YpmxjGokNCtLKjq
         u9ul1/96srSJz0clY+x+TralkrNULCzOIVC6EFgTT5aTObHXhUi2+emfjcPitNiIiGsn
         kUgcg3ZtVt5e7G8c87qqzll/FO05YHLFgZHEmzaP344kWdUrcPYnKGde4lFcAp/FrTdy
         P5Ik8C3Ikh7y4AboW+6vHRjV2pNx7ljvgoMC7Dn+c77cdWIl77eZ4cEogBC/4vTdtEyh
         Dp6R55SJfJtJCIprrpPi72vX9IS4wU5Vwp9hvnGi6t2kLeoLRg7Ab5q/MuRZ+cyIVJ8o
         JY+w==
X-Gm-Message-State: AOJu0YzsSyW6Wsr/c8I8TEqWJVJrj/NvHWMs3WtQz9A/r4XCqC2vR4xZ
	U8ttjdiM8lTkPtR5ITaPy8ZihIXYSMg7M6EbvOo/XJaviCdTF9wHP9J8w+1kLYkUQQ0TAdnUQzn
	f89QSw1JBUmIwCGvfr9nR8RAarx0MmFakH/lPjbirFMaM/cK9vwJ9TCrMV+YDf2+g4ftHaNUEkx
	z+qdgU45aY92plmFiiStj6lII8nsEUc3+MSifa3cFDZg==
X-Gm-Gg: Acq92OEGGV570jRH5v++FL3TwEvE8oCBLk0DH9l5qdN3YTIpdd3eQsBmWe4dAgLN5Wi
	hCv/gJ4SzJe+9vbtWwhNotmjmsP54RFOIy5Vup69dWR6dJL28U6o9+S3p429aQWc5ZNVegr8YvE
	vm92BSjWgRU0ZNe95MRfmu3SP50/fpGwzbi8H55xu9OFTvmJOJBe5Ua60jGL8cbCKmHkG2s2Y8b
	4owom8fFrCpXIBVqqVQh2n1TktwIxwYtrcUdqsC5UGCckDOq+GIMuJDvz3ssK4yD8k4Kj+No+pM
	kpDQ5n9PqSTi09szzph4E23rIFNSjYcV2HMjvGm6l34h0+PEBXzsX/AIFg5MWn6s5iNNu55fTlL
	SNEIY8PF1Pwo9O1EXvwuRtf+WJC5JfneYaC8XbHYJbSQ70c2aCC07XxwIuhu1
X-Received: by 2002:a5d:64c7:0:b0:43d:68ad:3b7f with SMTP id ffacd0b85a97d-45c59228b05mr4395343f8f.21.1778669670856;
        Wed, 13 May 2026 03:54:30 -0700 (PDT)
X-Received: by 2002:a5d:64c7:0:b0:43d:68ad:3b7f with SMTP id ffacd0b85a97d-45c59228b05mr4395279f8f.21.1778669670260;
        Wed, 13 May 2026 03:54:30 -0700 (PDT)
Received: from stex1 (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454917d57aesm40237869f8f.26.2026.05.13.03.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:54:29 -0700 (PDT)
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
Subject: [PATCH net v3 2/2] vsock/virtio: fix skb overhead accounting to preserve full buf_alloc
Date: Wed, 13 May 2026 12:54:17 +0200
Message-ID: <20260513105417.56761-3-sgarzare@redhat.com>
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
X-Rspamd-Queue-Id: 7E61F531B66
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287526-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
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

Fix this by using `buf_alloc * 2` as the total budget for payload plus
skb overhead in virtio_transport_inc_rx_pkt(), similar to how SO_RCVBUF
is doubled to reserve space for sk_buff metadata. This preserves the
full buf_alloc for payload under normal operation, while still bounding
the skb queue growth.

With this patch, all tests in tools/testing/vsock/vsock_test.c are
now passing again.

Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 4a4ac69d1ad1..e22117bf5dcd 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -434,7 +434,10 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 {
 	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
 
-	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
+	/* Use buf_alloc * 2 as total budget (payload + overhead), similar to
+	 * how SO_RCVBUF is doubled to reserve space for sk_buff metadata.
+	 */
+	if (skb_overhead + vvs->buf_used + len > (u64)vvs->buf_alloc * 2)
 		return false;
 
 	vvs->rx_bytes += len;
-- 
2.54.0


