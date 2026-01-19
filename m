Return-Path: <netdev+bounces-251046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBE7D3A60A
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 11:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D355B309B1BC
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 10:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB7C358D24;
	Mon, 19 Jan 2026 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6CzPu6l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4673587B7
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 10:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768820236; cv=none; b=QEC4IRnRnthc7JiCnS3/YRuzuB50ciLM0EvUbuswML/Z+ZhJHcNksGjzqwp8uihhkQrKy5cdXv71ksmu5vNoG/szWXS3WKkCwzDzc3JbOHE9JuLxPEdtUd2y25aVmQveet7Rt8LLNHAeXWQvD/yy81NldJmn1Gut2fPxZ1G0Fuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768820236; c=relaxed/simple;
	bh=9w14KZHWbtXQ4bZuOIO1KWG6UqHqkSJxbWGAEo86CBA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JwtJfgJM26YfJSPd01gsjhwhLlPO/o4GRzMUzrgK3+TxU+ZMPIShvM3scxEAYW+6MO4ZjcC7fBJ2LBktMQcLg6KjNRyUm2wrfyINuBMNTvV6vDNOZo8gypFq1CzsYdMvOdhdv9I3YxawGkK0YKKcV3Hp3ma/Jj1zeETKqrgJLuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6CzPu6l; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a0ac29fca1so26149055ad.2
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 02:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768820233; x=1769425033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tnggbONwgIdaiaOJGG3BcWc+1OF/p9b8lGQ6zKeztQI=;
        b=a6CzPu6lmahhgSnh2RBWbSCX//eq7LXCBcn0pfv4Ix7o4Ly32mM0TXapb7SuVPzWBY
         y+d8rua3zPnWYuxLwCYitcy31qUZiHsP6uPNJ3Ga0tKkGZk5XplXAo2p6XR9H70ahfsh
         ZLik7vO650PIuF58s3rJWVQB9qDDSN1UuPwxn/opt/dU3j6sWu/kZVE4H1RrFVYZvobq
         ebZzVzQwz+oFxnh4tzZcFaK2Cb0BOgNOS04PWE9Exc+O9kl4kXW/bFA7RStBrC5sm4fC
         EW/2Nu/TfleP1KzM70Sqr4+o/udnKPIv7UR+n81h5Z/qGm1lxzDNxPWtwE2za6cEObM2
         UlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768820233; x=1769425033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnggbONwgIdaiaOJGG3BcWc+1OF/p9b8lGQ6zKeztQI=;
        b=wUHAg3wHeKRk65yXj+Fx6Ijrjxipbd0Dm1qF8Fuk9R0zXrsQudSYUjRWYi0DL8+1+a
         99KtKCa+4E9XaRULIhMSMz213cklSEeAeXXJwYwBaNNzYe+bWvscmlvKgUoMa3Veextt
         dYi1NRU/tto5o9lHH4IUaIpkdoKCnzFG9vc7o2A3mYC85wtJ7WT0HFU6GVDGVJmxxavS
         WXQqGq2k8fHiyI2YehuO7/hAur+bIm3DB353WZFi1hfhgg25oJDXceNVKE7uI772VVGk
         NW52WMnwAzfSyD1kDzfzmB7ZDgrpqMA7BDeeyzNDZS3NzmbUnvV41flatJ6QARi6TibW
         aKPA==
X-Forwarded-Encrypted: i=1; AJvYcCW9aZx9KDtkqW3N4Nvc0g6iPotw+nethpb+pFzJAyP+hUEM/o6rsuKjR9oQ8u8xEiNXQ5lmWR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt318tX9Iau5ENaacRLBxbFzMqt3MoMw+P5Qweeu8vSDoEC310
	7jm0Ab9tux+XqaUeeZJ0ucgfkGLz9AZTCZFdZw6cOuMVH1NWhZWvWM+y
X-Gm-Gg: AZuq6aJO+x00xQD+4FdbILjZXZccQ5b17uzhCvi4xkrImQaMOGdrAS3Yr8EiWiqzgVn
	08zlPvwduags+tNViNv9JAw009BuRgDjxgKUR3hsD3GF3Z7/qRSImLqc9UCi7lrxdQ1TimrtcEB
	pFwIOCDL1IC3vDZ3I+XI0gkKWm3BEPW9vnbtF1UcqBJ9elnCroJsGDtZQkDKZ5CBZMJ9wtR73pE
	8/es6vBhyz8MTU/yxEj8S53zrSd6QVBO1YVdVmGKKblp845MhjfRtOQpdSx3XatHFHH7+Tb8yW9
	K858i/HQBNm0WBdY1Nx4peT3HSJDVDgfoKy/486BagfytNcs15Ex5fNaqLnkmhvzVs4unAcnUUp
	SAQVgqNudiGuLkHdf2V1CgEA27/Okx8T2YoArfGV0TucHfD+1yJdmhO9V//0POC36kN7IpOPQSf
	dHUfsVK9RjDq2VKJv9
X-Received: by 2002:a17:903:2a84:b0:2a2:d2e7:1601 with SMTP id d9443c01a7336-2a7176c829emr111579475ad.48.1768820233442;
        Mon, 19 Jan 2026 02:57:13 -0800 (PST)
Received: from insyelu ([39.144.137.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190c9e85sm91362935ad.26.2026.01.19.02.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 02:57:13 -0800 (PST)
From: insyelu <insyelu@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	nic_swsd@realtek.com,
	tiwai@suse.de
Cc: hayeswang@realtek.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	insyelu <insyelu@gmail.com>
Subject: [PATCH v2] net: usb: r8152: fix transmit queue timeout
Date: Mon, 19 Jan 2026 18:56:47 +0800
Message-Id: <20260119105647.82224-1-insyelu@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the TX queue length reaches the threshold, the netdev watchdog
immediately detects a TX queue timeout.

This patch updates the trans_start timestamp of the transmit queue
on every asynchronous USB URB submission along the transmit path,
ensuring that the network watchdog accurately reflects ongoing
transmission activity.

Signed-off-by: insyelu <insyelu@gmail.com>
---
v2: Update the transmit timestamp when submitting the USB URB.
---
 drivers/net/usb/r8152.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index fa5192583860..880b59ed5422 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -2449,6 +2449,8 @@ static int r8152_tx_agg_fill(struct r8152 *tp, struct tx_agg *agg)
 	ret = usb_submit_urb(agg->urb, GFP_ATOMIC);
 	if (ret < 0)
 		usb_autopm_put_interface_async(tp->intf);
+	else
+		netif_trans_update(tp->netdev);
 
 out_tx_fill:
 	return ret;
-- 
2.34.1


