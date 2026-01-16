Return-Path: <netdev+bounces-250400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E50D2A364
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8418C30101D1
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 02:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A593396E7;
	Fri, 16 Jan 2026 02:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIzBcoIi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2432E1EB5E3
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 02:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768531064; cv=none; b=d7UEtlDB3FW06JyDDOwX/QJ1pZr35+MB2bfno/d1rWzYetO5SaCLMgBzAdE3xjpOO2yaunhXOdH/Y+lXHcavVRnQ1af4+QD0s8pDAab5KVijIJtn6deL0XXaAxFwIwULDoT//lG+BzXOMgCHY0k2KtoHe4W8qBOog7Xeit6uEPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768531064; c=relaxed/simple;
	bh=9w14KZHWbtXQ4bZuOIO1KWG6UqHqkSJxbWGAEo86CBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R4LmmsnroKm6QmamE3Y3KDJ3VsXX+vMcT+gVu2l+XEJ3WXxKPJXHXuc38uUvKEs28MYFRjPQ7hxSjzYZTwoFHgmepLMwfZcC9UiV+nJclyIGnSHFZtg9XYUUita30hEODzZ0MrW0pmwCZ2SOZfjyM0Q4Usz++MUaLKbf5fbF0h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIzBcoIi; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-29f102b013fso14607465ad.2
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 18:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768531061; x=1769135861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnggbONwgIdaiaOJGG3BcWc+1OF/p9b8lGQ6zKeztQI=;
        b=BIzBcoIiHMp9c/VWTFTrtg5r2qFm//qVuw+466OevwllPK542DoN8bMZ7jAt5kBN2a
         yuz9soixBndmthQgPYWnQ3o/cCL3kSK0yBAD+Ab8ERXVQobOcZtTEx+Mp7Hs8gsw80wG
         2kCWeJCqFgE/HfaVYIsxOJkx1OvD5vuZSLYeJ40GVqyJsVh1TgQWk012tRG2V29FTQI7
         jMY3G+e5j3EfAa4+Z0m6d2RQzA2dyB/sFt6a+57FpdOqyvRK1wpMU3a6D+69SNoAoKCW
         brw13blUDkt0E5/kEmfztTUUkx31L7kJSCfmMAL831ocw4pMR2A9t1cTO9l3rxuwaiW+
         i2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768531061; x=1769135861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tnggbONwgIdaiaOJGG3BcWc+1OF/p9b8lGQ6zKeztQI=;
        b=uQH+TsO5igHu84hN3UaB36vMJcGbLyvJ3cSUoRrZ0uR1LFA4G/VMuVNCmqommsNucm
         xBuEvETu7alRiMRPlLh+dRe9mBYCew4wE3gTkVub3HYaMBDZrF1DE9e53WqBSyjvWzsw
         nuHPTr3c3EiPM0uqfADGBVxr+ibRi70PYpbM5Dc8KuZQ3l4yVsFQtuw4nlYpJcF6Y1Bv
         QTYrakUNKmuD/BSNB5XHA+FvY9/u9Jb0Wp+UDu5oNjSfPCIdRtr5hxGM84IkFHENBMri
         5kpqkmEBT+N+UGj6g4Xpnw02O3ophkgls5H6xW+7zT5QmXyXwot3xHtFCDrgiwqvWID7
         4/7w==
X-Forwarded-Encrypted: i=1; AJvYcCUWZTOiCXYOu5nCfusmh8OLQp7r72TkrPeig8Ff7dEKd1YmhvPPvPz7xKYkiZkjOOdJId6Z0HM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEMq9hJgOHPXORoDa8QeFlxpWECgeK1f0yBQ7fscxb5TCxQhAC
	OP9cgtDb5fCzmAj1qtjJpYtF1DqZk8iRlD/3VizDPrvn5izbLCZKKbJR
X-Gm-Gg: AY/fxX6IV+O1OwjRX1XUXLMX2do6/DSH8ezyQkIrSxrw7tRnrgCTG/lMoVh+8DgEMf4
	V5Te8u4CCi8xKEuXic+bJ7eRVDJpOhKLIQSqLepAabw7RF9jrGJPryvouyWkQVF2PJ8t+OI9r/w
	FKhTaXgIkXg069VjVvwte0HkMd9a9m41e5rBbwmaGorCUIT9Aplilbm3/bkfFRRt/+emFbddBCm
	Sddpy1qGmn/n3QPwp1Fc/dL1W6js8RA3i39V/IL5FMVVqYH2kp3qgNRaTIHWRd2yv02yW/K1Mwx
	yPDHnundAsorTIRnnq3wxtt0DYl8wDAxI6/WZS4fsBMGbdxGCvB944KTQtCT9NIIpCgmsRSsnAE
	6I0VBz2fH7Xrn/h3jMJilpSe8ClZA9abz71LpJTUGy0+Kn9YF8qFQYhSb9L8TiolODKJ0Ibt/5L
	TRQcwxpX7QW3C9KKFT
X-Received: by 2002:a17:902:d48c:b0:295:425a:350e with SMTP id d9443c01a7336-2a718858410mr9787685ad.8.1768531061495;
        Thu, 15 Jan 2026 18:37:41 -0800 (PST)
Received: from insyelu ([111.55.152.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190eeefasm5842615ad.43.2026.01.15.18.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 18:37:41 -0800 (PST)
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
Date: Fri, 16 Jan 2026 10:37:25 +0800
Message-Id: <20260116023725.8095-1-insyelu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114025622.24348-1-insyelu@gmail.com>
References: <20260114025622.24348-1-insyelu@gmail.com>
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


