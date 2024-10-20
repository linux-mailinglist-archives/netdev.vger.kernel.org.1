Return-Path: <netdev+bounces-137312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D14B9A5566
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 19:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE141C20E07
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 17:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A66194C92;
	Sun, 20 Oct 2024 17:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmhjz0ek"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CC64431;
	Sun, 20 Oct 2024 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729446100; cv=none; b=ZDWdSChF6w69xy0+0nM+MN71LLvf17oLIge/OQTKpo33TgPkRIUPK4tt6z11NtjVyoKpCRd7Okzhy85+RM9OTB1nv4Bdy/kGq76xcF94YcQydiOy4xWwnh+hnn5HEp1nHo5bEeIUVtCRd8lW9xWzlSIq2gXK/+BCvXctnA36vLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729446100; c=relaxed/simple;
	bh=q+wdm6egVDwjBW+1n+K1DM13AKNIQm5RrbrjL39kHfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f+lj4EzF9vJkm8j+mRDDDmLiPUwSU0XX5g/YbffE2ZPG2usPfZRbuYEUVO4mhYlSjBAOTrijMbXg/FNf3Y+cj0mVLJyIXQJOw9v/IoyurZxNLsAiccBdigs6WABu5zSpF+MjPEs9ah5vYnKE7LTyUP7DRvQRaN3iM0JwR7IWFnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmhjz0ek; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-431481433bdso38740945e9.3;
        Sun, 20 Oct 2024 10:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729446096; x=1730050896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fiDr2EgAXSV5r56uzap2YtxynjiRZajySX4Brk5lIlY=;
        b=hmhjz0ekUaYhM3a7P7e5+WeJKHdnPD8yM5XJLSFI/04Pvz+93lc+7TzY3XcGVG4bBN
         JUxdkEyryfkla4Rm4/W9NB05Q1AVDVODP74VHKM6k/fUetEnEXsyOcTWfd9xk2CkbMBh
         Iyhyo/rk+LhgVg7UWs+Xtfif9a6/Y1dPsVnhveK7NxaaL83Cnd9arO2RYjUDJydTRlxi
         LAvljwcqXeNNsvlbx6kYi3yJa5VnLRRA2E/JPCnfJ+grzMTsdBAO7/1vxQz0Oslggu9y
         etK7aTZcXiDcmDriEu2JgJgYc2xLR/M3ryb6JEbzsjfhQqSacZ+3tK4UM6XM+j6wI8e7
         SCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729446096; x=1730050896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fiDr2EgAXSV5r56uzap2YtxynjiRZajySX4Brk5lIlY=;
        b=o7g9BabYrZpzshmlGsJfyni+xr7eAIssjBVEZsZ7qWQgFDUza5kto0+LiD4hyQw8/g
         OXAekbFEQEa0kkrh3ZtxEq+TMNP1fl3oBYecg72G6eaHAD30vlq4Dmjc5w7o3Wq7FQl8
         a46vOIpYnr0NTB4NdKzNMdElzks/8e81nBS6KytyjH1XHEJePq8s7t5QuCHFLB0b3EFF
         iBfnB7IPIRSt7ZfLzGONSwjSTX3pomg0FVRptS7z2Wxu++Hn4fd9HGS1UmwrPhlAwcpC
         jEMB7/+bPaZGd2XTEJpFIzEelApu0F2y6SPBn3xVS6DbAsnwVP+fAN8fXYpq7ZZqnVzh
         Ehfw==
X-Forwarded-Encrypted: i=1; AJvYcCVie5ELBWQzb1Z4hRLroxZsDrEbo2H9KQcsqlSDd74yrBN6rKo6vwq5kRSuSq8QQH1VmDqm64C/2dV6RAg=@vger.kernel.org, AJvYcCWKj1zsZhM2kHn+eXqnVtVIRzkYCOKZrNnrPFhpFkYiYgeUIqkeHFmB3cnX874kfEpqbrrFXZZf@vger.kernel.org
X-Gm-Message-State: AOJu0YyFc5juq2Zicdl1CZQwu5qWjrySBlf1uNfqgqIToafpVk+hJLaZ
	CpLIt8huJ5kyU2oiYkJl7RAX2AI37aQaMc6Z94xU+6QzNtwPB1/i
X-Google-Smtp-Source: AGHT+IEjdb1hjiYAr224xsUcd/twtKCJPqEUHlaY3Xc9qGyDFR5gNZqKzpYNwMrWHqNH4Gu9MoSQnA==
X-Received: by 2002:a05:600c:4f15:b0:42c:b187:bde9 with SMTP id 5b1f17b1804b1-4316168ffb3mr76253005e9.30.1729446096042;
        Sun, 20 Oct 2024 10:41:36 -0700 (PDT)
Received: from localhost.localdomain ([212.231.124.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5c2b46sm29647445e9.36.2024.10.20.10.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 10:41:35 -0700 (PDT)
From: =?UTF-8?q?Benjamin=20Gro=C3=9Fe?= <ste3ls@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Benjamin=20Gro=C3=9Fe?= <ste3ls@gmail.com>
Subject: [PATCH] usb: add support for new USB device ID 0x17EF:0x3098 for the r8152 driver
Date: Sun, 20 Oct 2024 18:41:28 +0100
Message-ID: <20241020174128.160898-1-ste3ls@gmail.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch adds support for another Lenovo Mini dock 0x17EF:0x3098 to the
r8152 driver. The device has been tested on NixOS, hotplugging and sleep
included.

Signed-off-by: Benjamin Große <ste3ls@gmail.com>
---
 drivers/net/usb/r8152.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index a5612c799..468c73974 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10069,6 +10069,7 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3062) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3069) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3082) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3098) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x7205) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x720c) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x7214) },
-- 
2.44.1


