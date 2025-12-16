Return-Path: <netdev+bounces-244957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2F0CC41E8
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 17:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6149300AB2C
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 16:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951093587BA;
	Tue, 16 Dec 2025 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSLdp/M/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2Rp3LTE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6AA357733
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765898060; cv=none; b=r9hW4trN7zyzYRWtl9SvjPqdAexDyAycnU5+hgBo1zlKrZVPktuhOjhB73LZQYeYiSkIkqOSy8HMoqpipcOE8cRKj8ka3j255b3DnFeQ2Q24GncgTMIIWr1ktIZ96LELcAIyTBGGUdB9c9AbE3bdSmsdUTTjHyb5f6Y2sfP9ePI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765898060; c=relaxed/simple;
	bh=l3aFcFIb/rETTTHoywtwScOBMd14d3C/McfXoy+MH7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fFYFTJ29kt/hf71uiNTmgzIsyt3hqSi+CPAv3/ZnnvlfMf0perV94zcQerC8qGniarP5g7HsUxmKZL5GOEnUpg/a9sUlS5JkIRWkLm7kHrRowC3LJlf+3uyD/Ps2Gls92Wd1kHRHylvW0h6DdxLpVK/IeEfXhHqPYCjlu6Lf3b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iSLdp/M/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=O2Rp3LTE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765898057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KGroo1FRQJLcCV21iN/HVdCn1Y2Qr7NjzdMpGVOhIKQ=;
	b=iSLdp/M/yZA/QDdLjwC6OIgbJXuZWv5pkYdUiGl20ijtFgbnMNoIccJpsIxiYzZolGGJT6
	Ii7EhmkBqQmy6Ra8sWKvg1+2PZlKiGGjMjB+JHrXNMib79yl/Ytblv7EYD+S0EYYnJkrG8
	41yvKPX4OmkH9D3QJcMD/TVTVHOrZqA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-1QH-IUFFM4eviMlkCrWspw-1; Tue, 16 Dec 2025 10:14:15 -0500
X-MC-Unique: 1QH-IUFFM4eviMlkCrWspw-1
X-Mimecast-MFC-AGG-ID: 1QH-IUFFM4eviMlkCrWspw_1765898054
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29da1ea0b97so120293655ad.3
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 07:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765898054; x=1766502854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KGroo1FRQJLcCV21iN/HVdCn1Y2Qr7NjzdMpGVOhIKQ=;
        b=O2Rp3LTEPAPHfbrnLQhN/g4LZBnNRN/U/p1rPmAb4+C+7HuX5CbY9P4LsbxtY1LrN9
         h5nHwT17bgW0pQbhmd0lZE/l9ZZSGtqLFduV8pOpReyFegvHW1cGmFf/euuyTmIXc9Ow
         ++wWt1yqoywvVzDf4QAGY+DoFFXudpJRcKzC+XHJPlnEVs/4h3FLL0tktoTYmtOpPelf
         LeLST5uf4L02LKFkg9fNkvaeZvirQoOF35MGTQ+ZwVojGQAF68cdSLcKKfsVDNmgp+JO
         Ky9yICpi3zlrRV/PbtgkCQlPTN3eY70mrKGr/iWB2sgbhanVxbMYORfkEkmfMrG1/3Ri
         SlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765898054; x=1766502854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGroo1FRQJLcCV21iN/HVdCn1Y2Qr7NjzdMpGVOhIKQ=;
        b=o/DftDCrt9YzEXjDYIr0OJRMoJGvC4K0pcDLszZ4JITXma99H+2Vy//7GXG5LR4uxT
         v3NpoJxerFLA+Ar79oT+lX2gkaGShUyjBEeO1DA/7F5Jjl/nuxMzCUCCLtmzE3EDRKhm
         TWe4B11mkL07kNlxmTEKV1mjqhXvvFcKTjaOeicYBxNpIzXHEKF8VlSXaG/gHZdj2fuS
         niqI/7Rjk0/dMWyV+86YWVvr94/U28ZRsJUGE/hVaxel7qZyCimxNBaPOi9VO6qIkvlo
         Zh35npacgtEbgULCALNnoikKML3NWTXbJrqAL6k8muAfQKxPJY6OLGBIAYK+1serc9VP
         5FEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvBLDrL8nIZzY1mevXYgZM36DaIx5i7M8JDKm6rgAa4jUfkjSE4PR1ZC59EwRbeGkklqQF2UU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBl7zPkvwwSkqY3n2IB1rxOi6QlfnySBFVTEEQlVp3xhq8vt4L
	ybBYA/r3CEJNyGQxVNH08Hns5GeFHj3StcE2nGpDVoT6R/jwGSmQfO3ldjDmNEWNJAH2n1hO5FI
	lRsi5aWqXgm3/jEnh84JI/PvpUc1dYrTCHg5HjCOvv9OmG2J0Wi47xfBo
X-Gm-Gg: AY/fxX71ZavTjGxQZW7DMItQmWJjZib4bAykiaml9XaTNSj/JInZdVM3qhb/EjqJqQ8
	cimlhuAT0G/QjA2JZreg3LQxRR5Y+fDlfANt8sGNk1vVucolJ4zYMqMmrNLIH4WsX9mUkyInFu6
	DMGOcgXbveMPzX2UaHHIfnutYoKfCeCwMw5gQ3ITv/B1TOMHQhDkA6QcH9v8afqB9Kh1QnIkZG+
	8KH6Ho+4dewaj7cwYGV16XrBQGbNJKJwcR+Ek4r/93fMyeO/j4wV2CzLXn2FRCrVLXl3cxLlWIM
	cbR86Pi2iYkpqS+i/HeE4/9kTjL2wPztxatUKweavrnRWcmTTGBNMUM3pdrLtQh9rYWLDlF4nld
	U9CBKymXsm4w1hV6dSP9WtmiE9H29kh/6oPLUfQ==
X-Received: by 2002:a17:902:e947:b0:2a0:f488:24e with SMTP id d9443c01a7336-2a0f488039cmr72599015ad.28.1765898054349;
        Tue, 16 Dec 2025 07:14:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHreRegPQkGmWbCVch5XFt0fM9KZJ4HiBSvqPfGMq3/Z86mPrICGllWYxJgnaXN7I+HROG0mA==
X-Received: by 2002:a17:902:e947:b0:2a0:f488:24e with SMTP id d9443c01a7336-2a0f488039cmr72598365ad.28.1765898053897;
        Tue, 16 Dec 2025 07:14:13 -0800 (PST)
Received: from dkarn-thinkpadp16vgen1.punetw6.csb ([2402:e280:3e0d:a45:3861:8b7f:6ae1:6229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f177ff327sm137688045ad.101.2025.12.16.07.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 07:14:13 -0800 (PST)
From: Deepakkumar Karn <dkarn@redhat.com>
To: petkan@nucleusys.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+8dd915c7cb0490fc8c52@syzkaller.appspotmail.com,
	Deepakkumar Karn <dkarn@redhat.com>
Subject: [PATCH] net: usb: rtl8150: fix memory leak on usb_submit_urb() failure
Date: Tue, 16 Dec 2025 20:43:05 +0530
Message-ID: <20251216151304.59865-2-dkarn@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  In async_set_registers(), when usb_submit_urb() fails, the allocated
  async_req structure and URB are not freed, causing a memory leak.

  The completion callback async_set_reg_cb() is responsible for freeing
  these allocations, but it is only called after the URB is successfully
  submitted and completes (successfully or with error). If submission
  fails, the callback never runs and the memory is leaked.

  Fix this by freeing both the URB and the request structure in the error
  path when usb_submit_urb() fails.

Reported-by: syzbot+8dd915c7cb0490fc8c52@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8dd915c7cb0490fc8c52
Fixes: 4d12997a9bb3 ("drivers: net: usb: rtl8150: concurrent URB bugfix")
Signed-off-by: Deepakkumar Karn <dkarn@redhat.com>
---
 drivers/net/usb/rtl8150.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index 278e6cb6f4d9..e40b0669d9f4 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -211,6 +211,8 @@ static int async_set_registers(rtl8150_t *dev, u16 indx, u16 size, u16 reg)
 		if (res == -ENODEV)
 			netif_device_detach(dev->netdev);
 		dev_err(&dev->udev->dev, "%s failed with %d\n", __func__, res);
+		kfree(req);
+		usb_free_urb(async_urb);
 	}
 	return res;
 }
-- 
2.52.0


