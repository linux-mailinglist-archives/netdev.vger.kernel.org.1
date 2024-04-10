Return-Path: <netdev+bounces-86470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3199189EE9A
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 11:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54EC81C217B8
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40337158DC6;
	Wed, 10 Apr 2024 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="l/73Yqt/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0841156C69
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740460; cv=none; b=DHUHGi8RuJjw36uqdmWfmJEW370KE2yeMKDhuW1csnaHy+YKrk9BTZ1RjIvNlNxRCkfHFN6LwkgMmPKZySWNCx90XqlAeFjJcFzT5Z4QIMFtzCR3VMEqaSu1uLuM+60Ing8SLWXzn0hWKJ8+p6su+UtlgWt6wbOVtrjetwn2bhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740460; c=relaxed/simple;
	bh=fKIfncCeS0Ye9l6YcxLJ6F5HB/8T4+3wEV70f2ZHVmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kzpCsgdai6RY3rzYUj4wNMEU8HmEx6Nu26HykZhvsAGTYAAKr5yosinPiGex7LbQpyN53OTI+x8qBaps03epzmDIPJ5MlwwNMNQ6gDAnM/jB9z4N+rENPJU7mf1KmSBdVqRryGNfrka1cg+fUZUlJ14t63HoNi9NQX3M0Y/CShk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=l/73Yqt/; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712740459; x=1744276459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BK24ToIiz+hSvcV+7vaeD0RxSxTbfHLYBnGYOLRqMqw=;
  b=l/73Yqt//TI0NGZR+yWZZF/g420WfH/NS/GEM9TkjmgT6J9hCo/fYbvg
   uu2BvQZUGGV5huE5eHnlBEezk1Bl6okpEHSEnD5d4ZxF0fZ9E8ZZFL/oq
   FGMxslPgRUVhqy3P3F0SJeEYp+Kkwp8I1u6crzeKSTgqog0voAD4opq6n
   4=;
X-IronPort-AV: E=Sophos;i="6.07,190,1708387200"; 
   d="scan'208";a="337994701"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 09:14:13 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:8308]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.40:2525] with esmtp (Farcaster)
 id aa449eac-36b6-41cd-89ff-3791f8e6ee7c; Wed, 10 Apr 2024 09:14:12 +0000 (UTC)
X-Farcaster-Flow-ID: aa449eac-36b6-41cd-89ff-3791f8e6ee7c
Received: from EX19D010UWB001.ant.amazon.com (10.13.138.63) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 09:14:11 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D010UWB001.ant.amazon.com (10.13.138.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 09:14:11 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Wed, 10 Apr 2024 09:14:08
 +0000
From: <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
	<alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>, "Itzko, Shahar" <itzko@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky, Evgeny"
	<evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>, Netanel Belgazal
	<netanel@annapurnalabs.com>, Sameeh Jubran <sameehj@amazon.com>
Subject: [PATCH v1 net 1/4] net: ena: Fix potential sign extension issue
Date: Wed, 10 Apr 2024 09:13:55 +0000
Message-ID: <20240410091358.16289-2-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240410091358.16289-1-darinzon@amazon.com>
References: <20240410091358.16289-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: David Arinzon <darinzon@amazon.com>

Small unsigned types are promoted to larger signed types in
the case of multiplication, the result of which may overflow.
In case the result of such a multiplication has its MSB
turned on, it will be sign extended with '1's.
This changes the multiplication result.

Code example of the phenomenon:
-------------------------------
u16 x, y;
size_t z1, z2;

x = y = 0xffff;
printk("x=%x y=%x\n",x,y);

z1 = x*y;
z2 = (size_t)x*y;

printk("z1=%lx z2=%lx\n", z1, z2);

Output:
-------
x=ffff y=ffff
z1=fffffffffffe0001 z2=fffe0001

The expected result of ffff*ffff is fffe0001, and without the
explicit casting to avoid the unwanted sign extension we got
fffffffffffe0001.

This commit adds an explicit casting to avoid the sign extension
issue.

Fixes: 689b2bdaaa14 ("net: ena: add functions for handling Low Latency Queues in ena_com")
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 9e9e4a03..2d8a66ea 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -351,7 +351,7 @@ static int ena_com_init_io_sq(struct ena_com_dev *ena_dev,
 			ENA_COM_BOUNCE_BUFFER_CNTRL_CNT;
 		io_sq->bounce_buf_ctrl.next_to_use = 0;
 
-		size = io_sq->bounce_buf_ctrl.buffer_size *
+		size = (size_t)io_sq->bounce_buf_ctrl.buffer_size *
 			io_sq->bounce_buf_ctrl.buffers_num;
 
 		dev_node = dev_to_node(ena_dev->dmadev);
-- 
2.40.1


