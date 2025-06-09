Return-Path: <netdev+bounces-195727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B44AD2173
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 16:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6159016C1C3
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 14:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D3B199EAD;
	Mon,  9 Jun 2025 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXv0l26b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD0172606;
	Mon,  9 Jun 2025 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749481000; cv=none; b=LMGEzcBkTOJrPyQbr+sinYfdSyOHVbUCS5Xk+seF0SfBwlXl24s6Gs/7wAQJou8KqdhJX6A2FHTnq2tyqersv/CZdKXQ3xOBQ/hykfjTFIH7xppIf/y8gfSUIYhV1jvehTCUi3oLP0KhOPChh1egdRpcTB42l3i08Kawn11sF+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749481000; c=relaxed/simple;
	bh=L2+6Eah1O8TlZJlFrgG8KAyfFea7SFLLoPZ6PJdG/Lk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B6SvqWYy9eFy8C+jTikF/2WuChFrcqeIvZEuiobqfFniaZ86La5ssYhrzf9ZQPqbKoT6rA245O+iQI9OwdZJt+KW3NjJWQ2iBG57I2rZdvj6Rk8KaG+v2ewbaoLsepjOtp9bwF0xL68UGsdXjN0WY7qtGOm1RRAdEnnzRpg1A78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXv0l26b; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a3798794d3so3743112f8f.1;
        Mon, 09 Jun 2025 07:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749480996; x=1750085796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AD8CdEe2djCXyzMtatbTa8JQVgDN2iS28PWMu7pGIKg=;
        b=lXv0l26bxoVH8jLz0F/d/WaeUfKQ1PnoiwKXEgaxuEzYulo6wj5URbnswaj+cOqjFe
         81qZ2NiGTNg18xYzRg0u1yz2lXlzz3cgENx62w8DBX4SCuO/hyZIH2Nbfan6BXHbdGVL
         yGfnjqQ5y5D8KYQeo9+KVuawQuQISAcS7IrpyXrFG/E3Du8urnSIXoO5HKI/+eDJ/9Yi
         wcbAzvbX9ZMgyvJeGrT13Nik78kHi/NCK/Vvqt6QzX8NBdUYZ2Cn8+Fcm/5pnyWMlb+f
         O2erMNNodNmvNviQ11pyGYJ58ydKv7CsYpE+RctFQjNG71thf/JxLJraDBnV6cvXvQUV
         /iVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749480996; x=1750085796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AD8CdEe2djCXyzMtatbTa8JQVgDN2iS28PWMu7pGIKg=;
        b=YaYdl7WWw/y15URMZysZA+9zx0nA9OIABqD8ONlMtlSWkVCH7bZBl5S1/lHEa2/G84
         aNzMc0j1dGNqxvtDV+iIx7NnpEzCtBLzZyleP88BnIZypmnv/Of+74qw5Z0DJzTw7Xji
         dK1hWkw32Tvc2m+5Em3z8HHxD3eo5NiueIxraALr3261okgSksByg5j8itvzR6+D/nAF
         Uw2wx7E2jrk4UcDjq3y9SZUAToETXW1S+mOdRsW3+y+gLeDvinO9VpL+ayMuAOUUoSgr
         2Prf6guc87D4uzzAL1tHWIJRgT93iXrsKlOtKyf4FFJc5P7ocn3PnxsrW2zrvxxTeSPT
         LzXA==
X-Forwarded-Encrypted: i=1; AJvYcCVI6JQw2AOCtTVfA/v9G0ZKbJgbgz0QoiCVegHYWzCiWtYKzwY6cbJDFT8v+w0bLcuzem6SdnO6v/XRv7o=@vger.kernel.org, AJvYcCVU/+ZV+9iDhPHemQc1/SARGMorVzs2D/lAj5SYTOlnKJXp5w0n4qabHZx3oo10EpngUeCIv3ZS7DVn@vger.kernel.org, AJvYcCVxdgI2KAk8sI3FirzWKcwQXrkbF2xbgRvtFUiYgI4+hf38zUlyImbo9ceCbVUcJGB7URrMrgg7@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlk784eUAb+a5tS8CfLe3Fpn4ensLmkwvtSOM4Kbov7nzbL9j1
	FEvNkG1Eoh/J8n4/Jojx0MqRBXR9u0tGS6UOkYxv9vWiW+hnVMux5sIz
X-Gm-Gg: ASbGnctdTkDSv2mi7R/7tfsr6pnYKIjYUzJyjzM6Sqxv4gcnIALiudE+QnXbNcpcszp
	p2ICy97q7lSaBkrKtUj40PxOvP+C75kQvjgIwtxnD5KQkEXoVpGVRqZuWSh3vvf6OKSACRTCi26
	rHMSzLKWB1gfbCD+MdGTyxvAxDqBqtZ20fyVyGOsNKWtEm38UByjh45gC9sPqV+nB7j9eqJrN0j
	CGioH5D9MPRMZqWkT8fPRwvJLpZPxR4HfO9p2hKx04kBqox3Gw0NeHJe0OxM0YNsXlVhnlCW38Y
	ODsJBrndGLtsn9lrncz245vLXEpop5282be8KhB1C7pcayxOt36vGQaby91ZOGPUGeu33H/qH4u
	D7UWzJwQ=
X-Google-Smtp-Source: AGHT+IGX2Bg9tpEHhKD1YfVaIZemrvrQcBkDBqvQcEA5ekwjfXwM5An+osvXDtZHbYPcteYXA6aidw==
X-Received: by 2002:a05:6000:250e:b0:3a5:2670:e220 with SMTP id ffacd0b85a97d-3a531cb01b7mr10249454f8f.32.1749480995918;
        Mon, 09 Jun 2025 07:56:35 -0700 (PDT)
Received: from lucas-OptiPlex-755.. ([79.117.136.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5322a9bbdsm9553024f8f.21.2025.06.09.07.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 07:56:35 -0700 (PDT)
From: Lucas Sanchez Sagrado <lucsansag@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Lucas Sanchez Sagrado <lucsansag@gmail.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: usb: r8152: Add device ID for TP-Link UE200
Date: Mon,  9 Jun 2025 16:55:36 +0200
Message-Id: <20250609145536.26648-1-lucsansag@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TP-Link UE200 is a RTL8152B based USB 2.0 Fast Ethernet adapter. This 
patch adds its device ID. It has been tested on Ubuntu 22.04.5.

Signed-off-by: Lucas Sanchez Sagrado <lucsansag@gmail.com>
---
 drivers/net/usb/r8152.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index d6589b24c68d..44cba7acfe7d 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10054,6 +10054,7 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_LINKSYS, 0x0041) },
 	{ USB_DEVICE(VENDOR_ID_NVIDIA,  0x09ff) },
 	{ USB_DEVICE(VENDOR_ID_TPLINK,  0x0601) },
+	{ USB_DEVICE(VENDOR_ID_TPLINK,  0x0602) },
 	{ USB_DEVICE(VENDOR_ID_DLINK,   0xb301) },
 	{ USB_DEVICE(VENDOR_ID_DELL,    0xb097) },
 	{ USB_DEVICE(VENDOR_ID_ASUS,    0x1976) },

base-commit: 2c7e4a2663a1ab5a740c59c31991579b6b865a26
-- 
2.34.1


