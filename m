Return-Path: <netdev+bounces-212213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E87EB1EAED
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9C3161B0A
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819292882A3;
	Fri,  8 Aug 2025 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9x5sVXI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F36B2877C5;
	Fri,  8 Aug 2025 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664845; cv=none; b=LfafIV0HNvo7MzvHkiWpM9JCd7WQmRQivBZRLNem77+ezP2ixjYOQgz0OaLKd0bgLkCpr1S3kh36ZLpoOND3L/DwfDTREC9C+HpptXY8x3tSrVXndglxPIXo+Itm5uO5ZxB/IrRfA9a/Owaw0wHG6oL1uHZ3WIKIubG8pllZuTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664845; c=relaxed/simple;
	bh=c2RmXB2vgtc9JkGJKPTZJ3+xhYJ6MmNCUF1JsHQp8Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Skclyl+JXxkGZ1kkaQyqPaDP6LF1WSQsIERw3rzOEzc6Upx71nP5ooQlE9ICcD9bA9aE9Qb/DbbthHuOAQ39gbksHbXE4e35pCc6qRQFB+zXiJXS3BeUbJ18jVH+UjoYB5yq4df3b0RrGt8r9aZzp1EWioOmOQ8UH58RI6fdekA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9x5sVXI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-455b00339c8so14564115e9.3;
        Fri, 08 Aug 2025 07:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754664842; x=1755269642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssMrL+g2mHRnxPNV608Yq9cyP8KWXAoTfnZBuzxF5uk=;
        b=E9x5sVXI3ZzEp0E5SpQhe2gerIgKh8Zi8UEvwj5p9exyUKsYikEdYcJ2Bryexqb6im
         dEEAh2dooglyaOQsyJw2JDIgBt0EHiQWGRiX644CUa/MSttObxRFEpLw8h1wHPwIC0yH
         3YCy1zQqgJ6OPPqWpLF//dYVRYmgWny4S9yOHDnocGecpL0kq2dVWWHNtUNPyF9MmZop
         jPUy0MvThv08kwit6W0Ue24IIAenWQKiKjTX5lnc5TtTrD7ENi7ZbRBK/zD138DmY2jS
         fJSdCXj7245i1shJRX4YZqj6xihUo5Rpc41yRx4ZW/9UC1g9ldSfV/VOzUbwjU2dbB7l
         3xbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664842; x=1755269642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssMrL+g2mHRnxPNV608Yq9cyP8KWXAoTfnZBuzxF5uk=;
        b=VTYGIClrHXMmT/aBQgg1v3ZS20TCdrd6AJSKviMTVKSR2gu2c15NJslmH6CPrp9Jmo
         IE2U4mNKhECXBChH0Pwxkc6BDz8jo4VfQOUBdp2H3I8qGSeiUW/kYteQl78+rENyQhxz
         O5XQTyDwGhdqUB1dYcZe3Li6OSCuaGU4HzWofkDxdoGm3nPfwzQB4jTtdJNZ8jwoHNga
         sa6yYkfz2jT+VKMbwlEVmDBfvilCg3la/k43d89mpdVZx38Td6GrbmgqMYA2ZhjzaHDK
         DozQJt7IUGD4Omvm2fAyI8bVoaaQcFWLKdmkS7cEAqhEWd0AthD+4fMZBhvuaMKjSYFm
         DcTw==
X-Forwarded-Encrypted: i=1; AJvYcCWLGl3H0YkRgnYmNJIV+09y8RsvJ5DbfdG490hNuuf7DTUHrwRJ2sQzTeWQKMvgxhvL/K9FzGFR@vger.kernel.org, AJvYcCX3Kk570pR6yFVUbDiWQbruTUuC6JbwRVji8nBJfY8fNf0pSC/mI9hTrvBXiTq4JKRSABQFwvxrheitpeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9iOS+lXXmAxsL1da7G14v5RPbbgorEMSaXj4ri8iciCFVSac1
	GEpDiTj2utZpeQ18QsjtmjOyNid6Z8kRwZCNo9W6Fpm8ysHPG8OMt/dJDpOVJg==
X-Gm-Gg: ASbGncseB1pQEhEDoJ0mDuIAVduryNWjf+snOXEVmOJB2BavDKYtLmxoywGyDdpJ3Rs
	9haUxtIvp5JucV5W8T3yKBgjkkn5zrYnY3Q5vrXSrP3EhrDRVIfXlMrI1f+1Y2SKjl1vqmU8yEC
	nmXz+7dANwvRLhBlbc7C1zU8sWR5QpY91eYMwaqfODBPWRw6Bh0JJJJ1hvqH+gCom+X6zNcVJUa
	A9g0cxhR8AygNWzWf4RacDYjBvcyE9BGYvJx8lzVWvONjyjULkKUWcGWwIFYpsqRiQxIRTkmNQ/
	LqcVU+73hPuCBfHRRRDgPOn2tDnVBWG6qiu0MNhlV762pQvZMooVb33OO/8F2sFhQJ9Nv57jmfk
	eYWdo6g==
X-Google-Smtp-Source: AGHT+IF2yqxWhq+2UE5pqm/JczIyxLZ/TbKm+OtkQLKTCDNnkMsPkEOAcPYQ0oGBkzrwDQWGAyibrg==
X-Received: by 2002:a05:600c:4ecf:b0:453:5a04:b60e with SMTP id 5b1f17b1804b1-459f4fa59dbmr28318865e9.26.1754664841668;
        Fri, 08 Aug 2025 07:54:01 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:a360])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm135106725e9.2.2025.08.08.07.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:54:00 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: asml.silence@gmail.com,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	davem@davemloft.net,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	michael.chan@broadcom.com,
	dtatulea@nvidia.com,
	ap420073@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [RFC v2 20/24] eth: bnxt: use queue op config validate
Date: Fri,  8 Aug 2025 15:54:43 +0100
Message-ID: <59cd7e7563c2df8af5e818a2c3c1f4e2ac2363be.1754657711.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754657711.git.asml.silence@gmail.com>
References: <cover.1754657711.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Move the rx-buf-len config validation to the queue ops.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 40 +++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 12 ------
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index a00c2a829b6b..86cbeee2bd3c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16133,8 +16133,46 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 	return 0;
 }
 
+static int
+bnxt_queue_cfg_validate(struct net_device *dev, int idx,
+			struct netdev_queue_config *qcfg,
+			struct netlink_ext_ack *extack)
+{
+	struct bnxt *bp = netdev_priv(dev);
+
+	/* Older chips need MSS calc so rx_buf_len is not supported,
+	 * but we don't set queue ops for them so we should never get here.
+	 */
+	if (qcfg->rx_buf_len != bp->rx_page_size &&
+	    !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS)) {
+		NL_SET_ERR_MSG_MOD(extack, "changing rx-buf-len not supported");
+		return -EINVAL;
+	}
+
+	if (!is_power_of_2(qcfg->rx_buf_len)) {
+		NL_SET_ERR_MSG_MOD(extack, "rx-buf-len is not power of 2");
+		return -ERANGE;
+	}
+	if (qcfg->rx_buf_len < BNXT_RX_PAGE_SIZE ||
+	    qcfg->rx_buf_len > BNXT_MAX_RX_PAGE_SIZE) {
+		NL_SET_ERR_MSG_MOD(extack, "rx-buf-len out of range");
+		return -ERANGE;
+	}
+	return 0;
+}
+
+static void
+bnxt_queue_cfg_defaults(struct net_device *dev, int idx,
+			struct netdev_queue_config *qcfg)
+{
+	qcfg->rx_buf_len	= BNXT_RX_PAGE_SIZE;
+}
+
 static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
 	.ndo_queue_mem_size	= sizeof(struct bnxt_rx_ring_info),
+
+	.ndo_queue_cfg_defaults	= bnxt_queue_cfg_defaults,
+	.ndo_queue_cfg_validate = bnxt_queue_cfg_validate,
 	.ndo_queue_mem_alloc	= bnxt_queue_mem_alloc,
 	.ndo_queue_mem_free	= bnxt_queue_mem_free,
 	.ndo_queue_start	= bnxt_queue_start,
@@ -16142,6 +16180,8 @@ static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
 };
 
 static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops_unsupp = {
+	.ndo_queue_cfg_defaults	= bnxt_queue_cfg_defaults,
+	.ndo_queue_cfg_validate = bnxt_queue_cfg_validate,
 };
 
 static void bnxt_remove_one(struct pci_dev *pdev)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 2e130eeeabe5..65b8eabdcd24 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -867,18 +867,6 @@ static int bnxt_set_ringparam(struct net_device *dev,
 	if (!kernel_ering->rx_buf_len)	/* Zero means restore default */
 		kernel_ering->rx_buf_len = BNXT_RX_PAGE_SIZE;
 
-	if (kernel_ering->rx_buf_len != bp->rx_page_size &&
-	    !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS)) {
-		NL_SET_ERR_MSG_MOD(extack, "changing rx-buf-len not supported");
-		return -EINVAL;
-	}
-	if (!is_power_of_2(kernel_ering->rx_buf_len) ||
-	    kernel_ering->rx_buf_len < BNXT_RX_PAGE_SIZE ||
-	    kernel_ering->rx_buf_len > BNXT_MAX_RX_PAGE_SIZE) {
-		NL_SET_ERR_MSG_MOD(extack, "rx-buf-len out of range, or not power of 2");
-		return -ERANGE;
-	}
-
 	if (netif_running(dev))
 		bnxt_close_nic(bp, false, false);
 
-- 
2.49.0


