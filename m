Return-Path: <netdev+bounces-156384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69600A063EF
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 19:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E1E67A24CE
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 18:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A1A1F37C1;
	Wed,  8 Jan 2025 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htNxcVL4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1441F12FC
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736359587; cv=none; b=OlIIHtAnNUYXqfJasZNzHgPOVNOXOz5bS5MgYejSdubJg2P4Q3FqBe7KzBPeSuxbQJCdOJ+RRAOiVGecTf0meV+ZtoWhxfGZJXxN3TWNnjQOTBqlVipZ4d7vy1hyhbe/nvQsnQayvMsraQJmHJqAqrk8vDmWkhYCaymu9vkQGlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736359587; c=relaxed/simple;
	bh=R4UWrVe5Gaa9ndThzF20AYFG7pj0l2pER0Xs1zgkco0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VeX3XZbfh0/PoQYsFGJiiPjbFTy3qzG6iaSL+RFoDbLnpwEqC4hoqRm92Xrs7YrGIOruuTpAxtIK2PlXlMUobMPA+CWQ05sLOi8R2cTQysDBSy09rtus5ewcsX4EaSeO2U5e/nLhMm+HOQchMzLYohhfrgL1XaP+bE0QItGlKuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=htNxcVL4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736359584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bnu+BVkl+Xe97p0gYpH/rg1OlF1/gslhVoAE9Hfv1R0=;
	b=htNxcVL4JW88T7HtIojA+2ucNAcRQhD9kVAN5PduHtYRbRb8AZQpcSABP6W0xqwsn2QLeF
	bwRyuZRLFDyq8VU5XTYv5uuom4ki/1vbfRpOkVM0CdT3NTsMg/ecehij9r4comU6SFx4fN
	lclYMRxnFaIeelqgXTetSBCJyuV5dP0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-bVyYbPOLMHuoLjTCWF9cnQ-1; Wed, 08 Jan 2025 13:06:23 -0500
X-MC-Unique: bVyYbPOLMHuoLjTCWF9cnQ-1
X-Mimecast-MFC-AGG-ID: bVyYbPOLMHuoLjTCWF9cnQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43623bf2a83so1007165e9.0
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 10:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736359581; x=1736964381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bnu+BVkl+Xe97p0gYpH/rg1OlF1/gslhVoAE9Hfv1R0=;
        b=RBcCQrpgmbIqCav4t5VpYvNxAg9vst39ll1PZXxVbKb7YnRjYcMZix0bdkyMiHBmN6
         NAcR2tjZ7fqoiRV2qYbCIgjwe/TT7q/fj352QJoFWU7ecZW4mqOUE8x+c8RG1geX9yNX
         /VJCKbW4ODgQ79Ut8cvEK/LGAjywmrBcBVFUcRQtJUDMee/tWV8FINXxGY76b2QfJGBu
         cBav7aW/z4mQHQb5Z8BINclYdsZI3K7nq9ZQaGN7MpRX9mMiRYCjxLgniP/NVVXJukCN
         m1hkDJpXxuu3BDBHk7tQl/dkcu7++3vxvsuMJcf6CJsEod20nWaikOMk44rzzhIq3df3
         nC2A==
X-Gm-Message-State: AOJu0Ywl/nAjb84u+BCl7HOE36hR5sE7HmSSjWg/0DyWf7vig38yfcKE
	E+xUsFEJmG73AIL4UAutWDgwilaZOjeKslJr2lNbl6ed54VfaPVJ3niPxPg8tciFBDTdsjP276j
	u0p4mHHFK1BwXTqz53bWV2MTN7r0b7XlM+U15hVLlLGi78oqxM3uKoKcYcRCDyu/gS6dV8s9lT6
	ipNI+4Mw3nx02IM5cnfVzCmcPW8L+5RlDHX/p1ug5S
X-Gm-Gg: ASbGncuXJUlwAaFkwiS0+GEg/0Ywka0K9M9kz5OntyLszka6x4foIpTu7cdyYVUvhgU
	UpXzrx09UUj0vY7duaxKB6US101yxA+bC8PxpgJ17j2ilu3iL5HFhAxX7yupqnrdGO0HzsSUmJw
	KseA1zRsRFzwQaxksvlg3p9QCmF45JlkkWqAnESSvxyelV0LTp7uQ5fnJ3K1Snj64WuHflgr3L0
	z9qjfP+ObTwpyl/2b3Ch41h8P9/O8ZA+0b2oYWeuUsTBt4=
X-Received: by 2002:a05:600c:46d0:b0:431:58cd:b259 with SMTP id 5b1f17b1804b1-436e26f4d53mr37946845e9.31.1736359581579;
        Wed, 08 Jan 2025 10:06:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPzI29sT/XCixMM7XrCBkXw/ioHXUjl2FaMJjmaMr+6Pqs+CX8MLIRg6SGkdexZ2/7lWykfQ==
X-Received: by 2002:a05:600c:46d0:b0:431:58cd:b259 with SMTP id 5b1f17b1804b1-436e26f4d53mr37946165e9.31.1736359580892;
        Wed, 08 Jan 2025 10:06:20 -0800 (PST)
Received: from step1.. ([5.77.93.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847d7fsm53389298f8f.60.2025.01.08.10.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 10:06:20 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Wongi Lee <qwerty@theori.io>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	virtualization@lists.linux.dev,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Luigi Leonardi <leonardi@redhat.com>,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Hyunwoo Kim <v4bel@theori.io>,
	Michal Luczaj <mhal@rbox.co>,
	kvm@vger.kernel.org
Subject: [PATCH net 0/2] vsock: some fixes due to transport de-assignment
Date: Wed,  8 Jan 2025 19:06:15 +0100
Message-ID: <20250108180617.154053-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.47.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series includes two patches discussed in the thread started by
Hyunwoo Kim a few weeks ago [1].

The first patch is a fix more appropriate to the problem reported in
that thread, the second patch on the other hand is a related fix but
of a different problem highlighted by Michal Luczaj. It's present only
in vsock_bpf and already handled in af_vsock.c

Hyunwoo Kim, Michal, if you can test and report your Tested-by that
would be great!

[1] https://lore.kernel.org/netdev/Z2K%2FI4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX/

Stefano Garzarella (2):
  vsock/virtio: discard packets if the transport changes
  vsock/bpf: return early if transport is not assigned

 net/vmw_vsock/virtio_transport_common.c | 7 +++++--
 net/vmw_vsock/vsock_bpf.c               | 9 +++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.47.1


