Return-Path: <netdev+bounces-250642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C3DD3873A
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 21:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ED4830B1C0B
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 20:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E762B3A35B5;
	Fri, 16 Jan 2026 20:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ix3S2dJP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ervu5u3W"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474CD3A35C6
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 20:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594525; cv=none; b=K+A+exYFiQl8nRbMTS3cxv+3F7GtHjlO5t1ecFA4DkPUuFrKTYmjJNkn25FtmQMrgdLxeiYmnpRiCl3SnWunkg9wXjlPC/xrmzPk3VxnUXKtkiaj/l1FL3NJiAFTvbia/vEwvzSXjLAxIbliT5xFkFF0UZaGGBAtFNubyhiqmF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594525; c=relaxed/simple;
	bh=ViVCTMWsZOBUvDZkBJy4R4gHYmuB/wp4Twq+n+RK/10=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EhW9BwN0BWoN+3kAtf50YNnMjnOLbJj5mWP7Rwr3QW5zwnlu7BxKuo46WsTMYnzv207l4UG/Nic+jB3HcazZcIXXNd1+7GjV+cRBruIKA+F6GVfBM+QQCqmCUEE1lA4evO94cH0dZBW5SKRdyAUspNQmi0imawRXWyfosZddqpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ix3S2dJP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ervu5u3W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768594523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aokF+MKwgeAstmCjHO7lVmWSXdkq7v/KNJPU3598T+g=;
	b=ix3S2dJPuoSzqC43iy4IZFJTmFiaeqlGdul6CVgnT5Ac9Ggq6WeIGfcevV4W32IB7QvKVt
	O7olm70x4A+Nf/ZZj2hIPv0JNJXlV8JmJ8u+ng5v6J428CZirkj2LqUdp9A6xAs4dznF5p
	94GkQ755fhNavN/bwp8YECXJB7JbHbs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-GB7HZ4n8MJ-iV9_xIFImhw-1; Fri, 16 Jan 2026 15:15:22 -0500
X-MC-Unique: GB7HZ4n8MJ-iV9_xIFImhw-1
X-Mimecast-MFC-AGG-ID: GB7HZ4n8MJ-iV9_xIFImhw_1768594521
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47ee71f0244so28279915e9.0
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 12:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768594520; x=1769199320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aokF+MKwgeAstmCjHO7lVmWSXdkq7v/KNJPU3598T+g=;
        b=Ervu5u3WqeE00GZCKCJqNmQMRMCsg4Da+4+mti27TLgpxjLGWg2M1h2LMG/sK9GMCo
         yjYBSExNEySC3LUHDmajGyjgXnX92DWZpZREKDBPU6fGcMFDZ18XIk/dT88zwO9GDAMx
         L8T+SgunEG5YHXjLUdylnY8w1/zu6KYIwE/C0NE2uj8EiWTB7LCuNs5VvrlwLDfYvuLv
         ec0aNnAns4p049ZdWn+VIbqa/Ed1b42RfQDOopQoPVJzp5l9jZibKtOsAlgHooHkL/YX
         i5fNn2uBNx5rPmfcjPUJ55lBKF9Ms8XrgINMPNd96uSGcmokvghXTU7tcFkKZSCD88qI
         UIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768594520; x=1769199320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aokF+MKwgeAstmCjHO7lVmWSXdkq7v/KNJPU3598T+g=;
        b=Sw9dBhUl4j+EtoYcPQE8m8Nd6T3tDEWE0iJWg6IVyFDoGlZfiMJ+oAQBVFtf3E0Xcw
         DrxeDE5OQ64iZYcBRoSKBXmVF+VTF8lV5bHO4zxTE3LV1f/g93/KAyhd1lNGuRP3eR5m
         TDSBgr56/SkeFtJTyGFHjc82dJqhbjjAxABcXInC0nFAmMN6OtTdxapPrkitSKfByOT1
         YNICHcUAYmzIlbdKfabs6qAXjh4s083OPvSACX4IZ+8smdBjcfXd3j5djVEPftBTT/L7
         DQ9BIoBA5kPZUfecEIZTbRcQPPRs6KEYWk0mfAn1dySNFdFkFWwaeX2fhqWpJGEYjZdQ
         JtDg==
X-Gm-Message-State: AOJu0YyMywo0uaQwhxmimWzrh76LzrTI1qzjurjsaRr1ab+drbthQi5v
	0HG4r75Zo8moE0nPiDTXTprZ1Sv/GdccNyQACbJgJOQgXoYzIBn/7OSiE3FoMZlL7DndgkBHPiS
	7WMvDvvgibtsYpxLzTKyB7YuZmer9dKSTZ9Kil3j2E37mDC1v0E2QimB0omt3yeqwytIOTu7iZT
	SeWCF/fAe5xY5MR6eSfkpxscRcZu1tmuVL4K0n8PAFAA==
X-Gm-Gg: AY/fxX7HiFWff1Hb9JqPoVRzvBv1kRVXbuHWvzeKIA7p+zeJaNhUJ0Ygno7sACKbGZJ
	jPWuu1n0yZj1CDMBtKBzNrFySK1eoJJNe4VPHrgxGar07rOw+ulkaCqqgkiboMXgD4M2zqCAiYz
	2CEaC0SYGCPth+/ZPi03tEdHO8+x0T9IWx8OiyKMSjG/D1za14V6ZkxxkSsxslcRflR4HhzlL38
	rKg3B4UQ14z7AXIXFxh0VQy0mSSqq9AtA7OenR9CmdhMy6Ke0b3L3RTfymoJ3QOEn6X7ZmEvS/d
	dede4ZO+uOZdbyfJbjk09oEK70Q+T7mNnizypFjrMFTGPp9TYX+DQ3qtJ1UbK5bp8dkNr5Z9YJl
	+H8EvADEdnhpKBDKtKlN9dK3311RpNh+fmCP1fPg46ASH19HmeUJ3YfHqmktJ
X-Received: by 2002:a05:600c:3494:b0:47e:e8de:7420 with SMTP id 5b1f17b1804b1-4801e33a85bmr58520735e9.22.1768594520553;
        Fri, 16 Jan 2026 12:15:20 -0800 (PST)
X-Received: by 2002:a05:600c:3494:b0:47e:e8de:7420 with SMTP id 5b1f17b1804b1-4801e33a85bmr58520355e9.22.1768594520094;
        Fri, 16 Jan 2026 12:15:20 -0800 (PST)
Received: from stex1.redhat.com (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699271easm7009669f8f.14.2026.01.16.12.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 12:15:19 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	kvm@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Asias He <asias@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH RESEND net v5 0/4] vsock/virtio: fix TX credit handling
Date: Fri, 16 Jan 2026 21:15:13 +0100
Message-ID: <20260116201517.273302-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.52.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resend with the right cc (sorry, a mistake on my env)

The original series was posted by Melbin K Mathew <mlbnkm1@gmail.com> till
v4: https://lore.kernel.org/netdev/20251217181206.3681159-1-mlbnkm1@gmail.com/

Since it's a real issue and the original author seems busy, I'm sending
the v5 fixing my comments but keeping the authorship (and restoring mine
on patch 2 as reported on v4).

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


