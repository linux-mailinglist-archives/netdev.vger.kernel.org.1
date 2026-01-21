Return-Path: <netdev+bounces-251824-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODyXA/6gcGlyYgAAu9opvQ
	(envelope-from <netdev+bounces-251824-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:48:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1B554A9B
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6E3E85C5332
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF89647D93F;
	Wed, 21 Jan 2026 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUZcE6Zm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BIgNmuoq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945DA47B43A
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988198; cv=none; b=Uy9+08KcN9nbn1MAbypISEsITtd6JBOZpygVb8BXLKb8qZIzo097wCvtkemYHFVqpCzNr40urSG1ALAtCyNEFgGAqOeDZMKeOKJTt5acc9tIVW0TR+yFdLNwHHnI5HO47GeCgpRl3hv6UOEF/F2g8HQsOYIvz6PNniEidbumlw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988198; c=relaxed/simple;
	bh=fGsZTd5bffSkjK7pmvupzLZGleZjRWTTlZMrE5HbivA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OzvGK4T7tvSnPrNPHdPgBIlrGmJQ/SMo3477+pnHUMfKspiyr2p/Srwh0DI2jec4hXhCmDv/QYpcP++HhllKStvbf+vghSg6sWrRUVuSefvLUZ3Nog0E7jnAi57XTS+uLRjreepN+9e+K5yogGwu85Ya0nVJFLC6cDHxB7i38sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WUZcE6Zm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BIgNmuoq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768988195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R+pe6lmC40Ggeh//WpcWFgKiyf26tVP3wEil7HyM01I=;
	b=WUZcE6Zm+xs+hiX8bxpvyqt9omobdZkbl3jCvlKDV/BYIHaEBtQ893KUhNob5tqXbMYgzL
	JV76jBbMogsjuYbVWshr3T9opKmCm1f3++pOuLhmEjZGrOmc3VcRAkajnN8HJjf2UNUbcy
	ex4Iub354itPEIlQQjhimmt6RcpQats=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-647Z-caePI-EYHaFgoPvpA-1; Wed, 21 Jan 2026 04:36:34 -0500
X-MC-Unique: 647Z-caePI-EYHaFgoPvpA-1
X-Mimecast-MFC-AGG-ID: 647Z-caePI-EYHaFgoPvpA_1768988193
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430fd96b2f5so6044474f8f.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768988192; x=1769592992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R+pe6lmC40Ggeh//WpcWFgKiyf26tVP3wEil7HyM01I=;
        b=BIgNmuoqhUUPhsL6lO8w44lczsGx5RI9YlRd6qmCZKkcTFf8fq1uq6ODEnwY2duSZ6
         KTu3uDctr6T2G2FCj27QAjEmJj6bKj+uROxRS2WX86BY35mXtzcYRsA4BSeQJJhzqeEt
         Ri1mBbs+OjkcdjPzT2B9+g1wkq+Afi6otDb48O8Di9vgVTBTqrBvJ6HwNF+asaVHWF0n
         10JkqE93952QoBCr9a/lGcbH7rXZvRS89n8vUaIxIFMGLdAbce0yGfTfjNHrkjWDpOsn
         jga0Hdnsp6tSNGObAP375pSFuyBM1SyJ98pwvMf572H0N8jBeXTWVcsXqrtgSBq+vl/g
         /RLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768988192; x=1769592992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+pe6lmC40Ggeh//WpcWFgKiyf26tVP3wEil7HyM01I=;
        b=eab+oVA8/QVa3fF3/XWytQhyzTLiuaC/GZsILcN1bSRINecm+V9a14Z6r3YSkPILFg
         m5YV3fF0x0+FqjWKGmG6azjbkYT49teh3sOfRsXt8hgyx9OebMgzd/1HXwbRU96uRXx/
         4/WxmGr5ytZaX3RIg6t9xOHLFNb9uI4jHwJBe1Cqq4XkdHuJ0Bhp+3q2V/Bi1eJL5MOv
         glr2uwxuW/bSQgiWiNp6GSb1fqyxLsmZwXB/pMOozGE66mXQwO1rIyuoBnqJ4gDgiCgR
         nUQOcX6riLGDPk5l5PO0DbmLev/9MswqDqHKuFehg7e2+sNITwp0amIeJIf6avqRbJrw
         e9HA==
X-Gm-Message-State: AOJu0YzKjSPIyk+PF7pfLWKil7mMBUF/gu8+s5tVrW9o6wkLj9sYi4Rz
	N0vhQ/aYdNWyPrU9DI8tvuMiMOi9dI7M0PQQur03EO65ejFCHl7PxMjCcK2q4eFMcA2gF1ixEYY
	txVyw+Tay91VDlS1mUovSCGusGutyDB7yQyrlnVzEANPzeZ+W1h7r5Ey+6ECh+iQVR4/y29ZIhc
	SVqxw+VOEpv0/suyq0zUwsS95Wg0AdsDhzIaSx/CokVw==
X-Gm-Gg: AZuq6aKHQPiG1OPpTQVcFQXScayZ+ctVc2as6PCXHiEZfcKwgtig+aVbxllQbKTjbZQ
	sVZEnLYyQ21ebrrXLYXUHxrbAApp7xnAs3915zRkZPls9MaCIRzRGF/W23Ja9tWTVHiRfuB4GkT
	PGNpTFMlrEpbxkYm2rtG+VawsEzxwb1RBh35AjhwnFEfKrC98rYzp4/DTCZF2ViQUcABKMLasTa
	gAHFyPltnsoR8GolPiean1xWcY6hvJWsdPB16isEs7LyHBKviru+JV7ty+ezXvkiFXQ3Xw1um+2
	aLTy3goFdLsejE1jAAqu+w/M/s6iyyjOJYOG+7hlUEXGw1ZYTpkWBQyiPO3mjBWd/h3yMTsxg99
	WyBjbu3Ksv9nWaVjXnT569FHU7TJF+TBiIy5yqaga/dv83dmDSz2IM3WYLAUQ
X-Received: by 2002:a05:6000:186f:b0:432:7d2a:2be4 with SMTP id ffacd0b85a97d-4358ff6fb27mr7238610f8f.60.1768988192421;
        Wed, 21 Jan 2026 01:36:32 -0800 (PST)
X-Received: by 2002:a05:6000:186f:b0:432:7d2a:2be4 with SMTP id ffacd0b85a97d-4358ff6fb27mr7238536f8f.60.1768988191774;
        Wed, 21 Jan 2026 01:36:31 -0800 (PST)
Received: from stex1.redhat.com (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921facsm33887841f8f.5.2026.01.21.01.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:36:30 -0800 (PST)
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
	Asias He <asias@redhat.com>
Subject: [PATCH net v6 0/4] vsock/virtio: fix TX credit handling
Date: Wed, 21 Jan 2026 10:36:24 +0100
Message-ID: <20260121093628.9941-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.52.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	TAGGED_FROM(0.00)[bounces-251824-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 9D1B554A9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The original series was posted by Melbin K Mathew <mlbnkm1@gmail.com> till v4.
Since it's a real issue and the original author seems busy, I'm sending
the new version fixing my comments but keeping the authorship (and restoring
mine on patch 2 as reported on v4).

v6:
- Rebased on net tree since there was a conflict on patch 4 with another
  test added.
- No code changes.

v5: https://lore.kernel.org/netdev/20260116201517.273302-1-sgarzare@redhat.com/
v4: https://lore.kernel.org/netdev/20251217181206.3681159-1-mlbnkm1@gmail.com/

From Melbin K Mathew <mlbnkm1@gmail.com>:

This series fixes TX credit handling in virtio-vsock:

Patch 1: Fix potential underflow in get_credit() using s64 arithmetic
Patch 2: Fix vsock_test seqpacket bounds test
Patch 3: Cap TX credit to local buffer size (security hardening)
Patch 4: Add stream TX credit bounds regression test

The core issue is that a malicious guest can advertise a huge buffer
size via SO_VM_SOCKETS_BUFFER_SIZE, causing the host to allocate
excessive sk_buff memory when sending data to that guest.

On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
32 guest vsock connections advertising 2 GiB each and reading slowly
drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB; the system only
recovered after killing the QEMU process.

With this series applied, the same PoC shows only ~35 MiB increase in
Slab/SUnreclaim, no host OOM, and the guest remains responsive.

Melbin K Mathew (3):
  vsock/virtio: fix potential underflow in virtio_transport_get_credit()
  vsock/virtio: cap TX credit to local buffer size
  vsock/test: add stream TX credit bounds test

Stefano Garzarella (1):
  vsock/test: fix seqpacket message bounds test

 net/vmw_vsock/virtio_transport_common.c |  30 +++++--
 tools/testing/vsock/vsock_test.c        | 112 ++++++++++++++++++++++++
 2 files changed, 133 insertions(+), 9 deletions(-)

-- 
2.52.0


