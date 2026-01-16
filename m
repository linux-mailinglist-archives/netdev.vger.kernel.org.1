Return-Path: <netdev+bounces-250644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E388D386E9
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 21:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A6E7301F332
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 20:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279983A4F4D;
	Fri, 16 Jan 2026 20:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ikk2K7fK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s4drjzkS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B1C3A4AAF
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594536; cv=none; b=hA5jbjHCWREGg2WRS2AjCZOE2hvPXJXbhnE8ic+XfSD6hPVG9n6ijYLvxo6lVnlmO3LgfPu/cHA2Lpu84pije6T794Pne8YvYWXY0bzFAC5y8kjoevcSjYL5mWAKmnO13rgwOMJda8n8N5v37+sMiQ6jzQc1uxYuJ6vUjsFDtzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594536; c=relaxed/simple;
	bh=JvMvAj7ZpINza73ylybZV6srp9RLkEGmGWUWUCTvQu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udmv0UKg13UviUnb9Yx7K5NV4XH5uW/LdHYid/SDwxSVAHWFJKdWFKr1Z3+eEu7AWXmepK7M68VByAGLLB5fBXu9jjpNGYEUZQdxZvM27MUuMmt76KfCYR44ptgrTqgeBovealNGHWBgjL+UKVrlr6lUIggL2OukwWHw8fhJe2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ikk2K7fK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s4drjzkS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768594534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=voXLQ/q07d6hv5Ud8qhwOuK2vYxSCpA8ze6BckDLUOE=;
	b=Ikk2K7fKu+yhX632CRyRdw+euhGq7BDZcMvRwm+TI6sWGJ/NiH1iG1fZzvX7hvJz8xgCce
	KpIW0FqAwdgMWKDA173gNynimPy8HkuVW1ok92xMT9D3cq5CHa4GRzyitCCTbILrTDqPsw
	U3FQS44NhhAKdO1npnwCa/xPOmdX+fo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-04rJyE1JPrawACI-vwmYcQ-1; Fri, 16 Jan 2026 15:15:32 -0500
X-MC-Unique: 04rJyE1JPrawACI-vwmYcQ-1
X-Mimecast-MFC-AGG-ID: 04rJyE1JPrawACI-vwmYcQ_1768594532
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43009df5ab3so1808825f8f.1
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 12:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768594531; x=1769199331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voXLQ/q07d6hv5Ud8qhwOuK2vYxSCpA8ze6BckDLUOE=;
        b=s4drjzkSE7J8Ch70zdEa41Rb6nvttyuts1gOncRU5ubWNQGo1ZN5AdUwTBA7Od1Wsq
         CQcwnwkaoyVOp/11t121ssTNnVmRhK1x6+xfxaMzpjY6BBWUE1pMa7ssHwhqw5fcJJHS
         vSMkpIpNl9cd0TgSI4wa4Aet25nVRZH+ZFy46Kk86t4DaFME/8Ay9daZle4pvsBi+1AY
         6byvPdkO9ua8aoe7vUflNtvWFb1e7YIdpCxtCQBjw0yR6cZ8rvptc5UAXGilss/31VGn
         hqCsRKClvb+itmKlRTt3T77bGh1eHu8AVihLEppmm9jf1tRgnYIrLnFck0sB1ZztBN39
         URzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768594531; x=1769199331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=voXLQ/q07d6hv5Ud8qhwOuK2vYxSCpA8ze6BckDLUOE=;
        b=lnm6z5uzgBGSKKuCy/4vi+tqLFRC1YVnQnoTzhWrIdCgwc7GreB0GAKZ7vqnst1oIj
         rlMkIyhjOxFhWWqup+DWObv3ga6ohOCTD/5ie45isUUOya+w71xKMOiEqNAjkCvdOkmE
         StHmOCaujrRCjH23lqECD2KyCStOK2VdfcFhuSrPMhNTM0Dt8RICNQ/MZzcaFGOCenRw
         QiX82r4xCwK2rT5EngHmXxA0jqJ4Kdgp1zAfjVCehGyCR7sghoF+RxCW9U5oozNXiJqv
         Jlg5xbctqfQcMdf8XBqSJ5VLh5ANFZH6iKZ5IqPi0yB1NnQ8aBmRcsofFapsg62jftOJ
         +V8A==
X-Gm-Message-State: AOJu0YyEhGJIAN0Nrat8K68iSuFbpUtWUj/E6sIczRWCrINhrku3Dtqd
	h8Y+f4i6153qPsSWjm4AJaavUJdPjU7HvLaieMbKlpwMwWixzGCk0YnHniBSV21ykCKCdmPJusI
	PmzlYSn3ke15JqAk6KiKnTXGorsJa/XFn23SvYZwElCizM3TobTxajVXbURdxfz+9sKDjn+Nxa/
	/WgN/ikEt0k6p5B/adbUAZFziFI25dZRcistpmWT9LKQ==
X-Gm-Gg: AY/fxX73mVfuI/Gl8f2UfBWwbJ+K+P3n5B3c5R26fT6cYqNLxyVka6Cgc/5ErsZJQbF
	RIz36JX/sB9pHdh7XwgmTs0R5TWDqXWunDixzCpbowpyIM9NsAK4QEAtnE/N09CDB0vKM2QW+6I
	XR/zAZyvEuSuXnsjSueel1aWD3Vl2cIIEW281Do3nBjTPF0RSXDfVcHbTEXZhr9xJRxa0gY18R9
	elAXgZOCvqAih7LOcAfLo3M+D8RroiE6RrMMqseqJzndQhyb4g2DdZIPcDu/fwpoTP4/6r5vee2
	wsrp0kyFABZlLZCt4l5u6Ml3rMND0MgUuFItV4zOSUw6vj1O0Eh3W9HjXz1tIM+f6hpm+qxBQo4
	WtaNgLP7q20gxopvMijHmSszsClM2NFeoubcU5+8kEbUUTNhKljCyGp1hGkJZ
X-Received: by 2002:a05:6000:238a:b0:432:c07a:ee62 with SMTP id ffacd0b85a97d-43569bd48a4mr5632696f8f.62.1768594530847;
        Fri, 16 Jan 2026 12:15:30 -0800 (PST)
X-Received: by 2002:a05:6000:238a:b0:432:c07a:ee62 with SMTP id ffacd0b85a97d-43569bd48a4mr5632658f8f.62.1768594530330;
        Fri, 16 Jan 2026 12:15:30 -0800 (PST)
Received: from stex1.redhat.com (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992681esm7109861f8f.11.2026.01.16.12.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 12:15:28 -0800 (PST)
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
Subject: [PATCH RESEND net v5 2/4] vsock/test: fix seqpacket message bounds test
Date: Fri, 16 Jan 2026 21:15:15 +0100
Message-ID: <20260116201517.273302-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116201517.273302-1-sgarzare@redhat.com>
References: <20260116201517.273302-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

The test requires the sender (client) to send all messages before waking
up the receiver (server).
Since virtio-vsock had a bug and did not respect the size of the TX
buffer, this test worked, but now that we are going to fix the bug, the
test hangs because the sender would fill the TX buffer before waking up
the receiver.

Set the buffer size in the sender (client) as well, as we already do for
the receiver (server).

Fixes: 5c338112e48a ("test/vsock: rework message bounds test")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index bbe3723babdc..ad1eea0f5ab8 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -351,6 +351,7 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
 
 static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
 {
+	unsigned long long sock_buf_size;
 	unsigned long curr_hash;
 	size_t max_msg_size;
 	int page_size;
@@ -363,6 +364,16 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
 		exit(EXIT_FAILURE);
 	}
 
+	sock_buf_size = SOCK_BUF_SIZE;
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
+
 	/* Wait, until receiver sets buffer size. */
 	control_expectln("SRVREADY");
 
-- 
2.52.0


