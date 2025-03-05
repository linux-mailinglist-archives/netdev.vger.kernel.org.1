Return-Path: <netdev+bounces-172175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ABEA508AF
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 19:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267531888B99
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 18:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68462528E0;
	Wed,  5 Mar 2025 18:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="kuN8C7Vb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A18D2517AE
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 18:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198152; cv=none; b=WAvmFR5OArW1tKAaBKSynM4mGG7IGF0ZQL+xj6AO1+8lPnrD3V5NXuYfMtgFh+VHLJtOIW7pKZSBswVRiCoWs7GcXmJbhsTYZAuLfCUmiVRLdxsEH2eVHta8UoQQbky10+oEFHxO/IgvaS9+eNyrXn3nMEdiK/h1eJCNE96IE8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198152; c=relaxed/simple;
	bh=TMYJJlrCKSQZCcdMd1zXdYIHHKwYt61VvQSuzMKoqkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OTqFr7iX73Y1fq3toZNdvWddVpxpdhdUy4Jim+iLvJBkKcWlisTi7gR+AXSc9dZKsFejQJdDbb1wOqs45VBXiUSUYQ4ObQcUgKoH+wMoplH0vBndZO6xny/sogRVnAAOTZcMvU/q4Uj+Z57paC6hrMPdwRerTPaLSUuh9s+7iJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=kuN8C7Vb; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2239aa5da08so70262445ad.3
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 10:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741198150; x=1741802950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/JDOLyKKadEy+ulLyQr89yMyXan48P03nG7aI65rkLw=;
        b=kuN8C7VbJx+sE3kTFmgofOOZWfbslO5TMFe+od6O4DH3D+BUmyKhUGyxB+FmXGkifT
         QBjmFW2U2+BEaTVFoGJuGlO3cSY6vsagyHm1HBF6HoHXvv1tPt/4o1RZN5GOEg83QiKL
         n2zE+Y09Hx/Ngpk4z83H+4jVnjMIY+C1mcPX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741198150; x=1741802950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JDOLyKKadEy+ulLyQr89yMyXan48P03nG7aI65rkLw=;
        b=w8bavTuAB162TJYXxqgrujI8Lekzsp2Sv6rgdP0UWmDlcgAf8168BOlI7pYp2lFOE+
         eFoo0yDvV3j2ikjOy7cSO0pKKUFkeTdYt6OdEUt9jI23eXJwJe3LaukF217ZscN0gz2Q
         6oyld+XoTh5iJLf2YwoO+1mdLOzHkm9htRCQ22bVz//Fj0Dg8cS084BJmSnQ2B20LFiu
         JZh2jm7VWoO9S23Tt63g6xl8/xTGdRdpKHoyziEWqj+0JkOKyzKfBspVsY7kDqLw8Yi6
         LSC+spPKwftXKysPXta/c0dRez65y4k3c5p0vQOoYk67YhkiOCOU4sY5aXM8YKnlYlOl
         8cUw==
X-Gm-Message-State: AOJu0YzkzeHKgYouwjtHnkC7hIHKV4yiE71of49CR6sdAuEwFARW+qs5
	y9dLisTd8fTP3VtIq97HTQtplHZYDP91fRFKBMbWVVkdw6zRRa4N2aLmH3dDjveA3yCJO0hzxrJ
	NAs6dUPupZ5SZX8YzUL6jfNWXS1LequiVA4+6yV+j2UDI8vHJEN1GbdTOk9yLa/68JK6fzpfiAX
	TmWzImO+ElqWedvnjT6l4XEYR7hP2fa0C/O2BSDg==
X-Gm-Gg: ASbGncuCIJKWtGYqd9T7K0Xn01prn7h24gFssw23uIjHQPsFyHtUeGUvrFsw3Wi9v62
	bbMmPLHrSZfUnb4/MJu8B837Rh7len/ODCHPqtisGiinEAcJ/SBR3PTdy00vdFhIGlHbilw7rlT
	/aT5+Bj8PnOuBPfDN8Mnob9ycMjsCdNboYNO211QdIlNyB4DGMQmAgcVNNUt0+k5LRJDMQ1BwGc
	HYDkKBZgKdry9IahSg+mRnU9kGUHn4MYYEEaItK5FpJUVKURYzAqAoOyPHSmUh5dxxDtsbB1+33
	klWdxVgAs0yP8JrlKNseKmRW8V/tafuZJlp66LtHb08zKRHrofvn
X-Google-Smtp-Source: AGHT+IHHP9qQRDNcIJ6SYkbk3gQTYwbtsOWJYWum8dEqxwJMevmC/aplCxv04Fpb3qqFTQ3JZrfYzA==
X-Received: by 2002:a17:902:ec89:b0:224:76f:9e59 with SMTP id d9443c01a7336-224076fa0damr12749675ad.10.1741198149933;
        Wed, 05 Mar 2025 10:09:09 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504db77fsm115568055ad.162.2025.03.05.10.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:09:09 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: vitaly.lifshits@intel.com,
	avigailx.dahan@intel.com,
	anthony.l.nguyen@intel.com,
	Joe Damato <jdamato@fastly.com>,
	stable@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path)),
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH iwl-net] igc: Fix XSK queue NAPI ID mapping
Date: Wed,  5 Mar 2025 18:09:00 +0000
Message-ID: <20250305180901.128286-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit b65969856d4f ("igc: Link queues to NAPI instances"), the XSK
queues were incorrectly unmapped from their NAPI instances. After
discussion on the mailing list and the introduction of a test to codify
the expected behavior, we can see that the unmapping causes the
check_xsk test to fail:

NETIF=enp86s0 ./tools/testing/selftests/drivers/net/queues.py

[...]
  # Check|     ksft_eq(q.get('xsk', None), {},
  # Check failed None != {} xsk attr on queue we configured
  not ok 4 queues.check_xsk

After this commit, the test passes:

  ok 4 queues.check_xsk

Note that the test itself is only in net-next, so I tested this change
by applying it to my local net-next tree, booting, and running the test.

Cc: stable@vger.kernel.org
Fixes: b65969856d4f ("igc: Link queues to NAPI instances")
Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/intel/igc/igc_xdp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/ethernet/intel/igc/igc_xdp.c
index 13bbd3346e01..869815f48ac1 100644
--- a/drivers/net/ethernet/intel/igc/igc_xdp.c
+++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
@@ -86,7 +86,6 @@ static int igc_xdp_enable_pool(struct igc_adapter *adapter,
 		napi_disable(napi);
 	}
 
-	igc_set_queue_napi(adapter, queue_id, NULL);
 	set_bit(IGC_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
 	set_bit(IGC_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
 
@@ -136,7 +135,6 @@ static int igc_xdp_disable_pool(struct igc_adapter *adapter, u16 queue_id)
 	xsk_pool_dma_unmap(pool, IGC_RX_DMA_ATTR);
 	clear_bit(IGC_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
 	clear_bit(IGC_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
-	igc_set_queue_napi(adapter, queue_id, napi);
 
 	if (needs_reset) {
 		napi_enable(napi);

base-commit: 3c9231ea6497dfc50ac0ef69fff484da27d0df66
-- 
2.34.1


