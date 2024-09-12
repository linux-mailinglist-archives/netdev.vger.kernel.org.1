Return-Path: <netdev+bounces-127899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A38976F76
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC67284E76
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67711BCA18;
	Thu, 12 Sep 2024 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="V5B3B/Nc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8DD158DD2
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 17:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726161759; cv=none; b=bKxQQpAFVibMjf6XXdwDJuLghrfgM0nrLsxIFPKGAmDOysfcyJCZSo5M92DSV0bHMXAcMwcncikqau45yp29OMuCxfrZbQJanH85hjK1t8tYic+LV82A/5BijBrGmrCTX0nWiSF2KpcJNFzDNSvjdCz2Jd4DUOISd7NX2xvttqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726161759; c=relaxed/simple;
	bh=+CPiuDILduzJ8yOWSpYZUgUop3k+LBnc7dRgjO39FqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JP1rjHE7IYFtl0L8C5FoHn0eZnz2TCxwLXl8wfjkv5Fy2Bha6YIE7YrXZdnmMqwnMSpGO1CL1SAN0+FfOMy5lE+K08BjlX4pI9xFOQ5EVkzifRvzPc9kfg/73JaPBqa4F1kHWeuQVhD5F57M2SABesZNhw5Reg1Tej20oRi8vVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=V5B3B/Nc; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6bce380eb96so821441a12.0
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 10:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1726161757; x=1726766557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ovyET/m+2xBCMIdrCLLFfUruKHw9DOajXdhiEGOLTyI=;
        b=V5B3B/NczMiLj40/PusxL1xDu8QYB6/YRr0v2iRgdIO3pVy9tnHPYOy8uLsbENlTo6
         Az/pvydMwOkM0qVqjEq4L96Sozpu4DxXgx7PwYB9yphmnRTSH367fAbMR/GooVvnkmhv
         MvJjCy53jOAnwmfKcT+xA/dIEjRgVVdCioG3f8wd0LnwqNvmydMcOBlC68nky/dNAqDA
         tXFbNdTUE/hk34KpY+Ih19eMKJzvEHGwm8BkVZHB7+67RLmVdGncX27a1z2ySweGIlaZ
         gTTqeejElWPPqH7UqMgRy9IJ8p7qCactDsak+59ZTnbfeY3cj+emd9q0ZqRxYC2DfcXV
         B1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726161757; x=1726766557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovyET/m+2xBCMIdrCLLFfUruKHw9DOajXdhiEGOLTyI=;
        b=F5l1w3fYtG8CcTP7r3vk+EcdH2dNO6RNVecGTiAFcPkI1qkQ0BeqLaFpOER3ajF4lo
         sKw96E1sc+NAXBgi3i3Erz2BmWGnDDNwhSNbxC6p04fsUUowmnAlZ3QX3NNiEHWHz+nj
         s9uDONra1X6ox5pEDRlwnUhedQ1g0xvnXy7dRHXWR+JKEdDfiYK0cyrnhwEaxHvVohtn
         tgwYX96wNIvbAoRVKQygzJRXhJcbK40vlAgWPAGPpVIjODm568/uu3fJkBJ93Y2v9Xrs
         rfNW0Sb1F3vutyy8fxXw92ut4wMx0GNmOz1WW1ZVrOQLwjxG1iZmPFOgs2PpvIsd+mcr
         wPBg==
X-Gm-Message-State: AOJu0Ywq78Eit3U/Jk0MZd5pe6NNSHguAGZee31PygipdMrvt/ta0wfe
	ApAX24YDe7NEEpOzZVh3bUos2fYl3HzvMRDRSs6hlfkleq3wzCcRd9ZHluMX+ySWZM3XSO7irXd
	F
X-Google-Smtp-Source: AGHT+IFH6tx9bfibw/7Yo/9XlyPZnh0dbaYYLqIIAh6gWKuPyQ5micbtfpuZSky+nAzY62tn3Z9MoQ==
X-Received: by 2002:a05:6a21:1698:b0:1cf:499c:f918 with SMTP id adf61e73a8af0-1cf75eb9258mr4815237637.18.1726161757122;
        Thu, 12 Sep 2024 10:22:37 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908fca189sm4818501b3a.23.2024.09.12.10.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:22:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute] man: replace use of term whitelist
Date: Thu, 12 Sep 2024 10:22:03 -0700
Message-ID: <20240912172226.13352-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid use of term whitelist because it propgates white == good
assumptions. Not really neede on the man page.
See: https://inclusivenaming.org/word-lists/tier-1/whitelist/

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 man/man8/tc-ife.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/man8/tc-ife.8 b/man/man8/tc-ife.8
index fd2df6c3..7565c592 100644
--- a/man/man8/tc-ife.8
+++ b/man/man8/tc-ife.8
@@ -120,7 +120,7 @@ Match with skb mark of 17:
 
 Configure the sending side to encode for the filters above. Use a destination
 IP address of 192.168.122.237/24, then tag with skb mark of decimal 17. Encode
-the packaet with ethertype 0xdead, add skb->mark to whitelist of metadatum to
+the packaet with ethertype 0xdead, add skb->mark to allowed list of metadatum to
 send, and rewrite the destination MAC address to 02:15:15:15:15:15.
 
 .RS
-- 
2.45.2


