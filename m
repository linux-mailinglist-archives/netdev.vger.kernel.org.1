Return-Path: <netdev+bounces-244323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F91CB4DE6
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 07:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 691CF3008880
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 06:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC082773D4;
	Thu, 11 Dec 2025 06:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFtOJ7rZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BC6286D70
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 06:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765434305; cv=none; b=EUL52x5l02O83JAgbpb0mt5Ga0pTOAcs1RSKLRd4XblvLDJcWzp+Q80WMfR4nBayHMUzeLeakXdaWoY6Zhi/PY+SRQfE1UigTmsxx3Zms9JFaWIRSV/Ln9sOf4nn99wzP8SQQ9S7UEbJq3IL36hdpj2TBWe3n4mtEpZKoHb/8R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765434305; c=relaxed/simple;
	bh=Oq9w0VryMvuYfFs5PKrxDOa+y4Rf440HymdqdCTUl2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jORfoLxtSoopxWbsOmA5JMw2XyVOE2uHX/KDZqvDshBGiaTGuArdGUFWQRIyrnp7YvrMQ/DU8sD0CnCVOOAU3/E5FMshv7IQAahzC3VWvtxlwq8nDz25z09pJyzSoUCFBF16wfRk8jYTWGUTHafU5Npj7IRnnGVJfsW1wsIGVP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFtOJ7rZ; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-29844c68068so8324665ad.2
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 22:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765434302; x=1766039102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XaPSMqgFDwXVtwoGnYeBs0ffc4tdGw8E2FYib2USsLk=;
        b=bFtOJ7rZkjJvDAXKsLoTKOMnOC+mAImrL4l+6hxpzVq15Xsc+TL9ZQ8g8AD/+xH2yy
         vq5beSQ8xFkrsYe5rwekBI8lJ/EhGkbCStubU010cQNCQ8t4CIcv1nM33tDJwfiMYc1P
         D1LTIK6QRQo3Kp5auxs9Y4OfJ/IeaIZnAbbEk+FPfWa6oydt9O/6EcntMMIdhcTpRFDj
         PA7zGKlT4U6QVynAEIwDRbfr1qZNg2yD4KV137TQomV8T0MgwMliQ/1c+dBr08+LEnlw
         jOOlLmgZF82zRdMhB1ogDW/on4iNr8lqKF4fHiYJZe2kqwa4V2H2meCx9CvC/y4N5aeP
         i/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765434302; x=1766039102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaPSMqgFDwXVtwoGnYeBs0ffc4tdGw8E2FYib2USsLk=;
        b=RWWIydQwY2K0PRzi/C4O3jHoOQHaV0O99Qul/Mo5z8E0giEaGlMBibdge0had5rGJU
         cy9CLBmchEXHTCtqpt4LxKySW/x3GoxgeKBjuKYQ6QsnM6n5+vVIaCTBycirT7URlihB
         Vlw7/uGQPEXNdKmIYcPDBnHWX/28iqZiZRW3Rp5AfTEYL3wj57i66ArhX0sccB4xtQOG
         JajC9Lxl7OGV1VF9d5bblYyKjAxCm8irwPtvDeGzGF/7e6FQFSWtSBegQF7RKfSVoz/8
         jPyttP/hlt2u5sYRjZWUQMPR2yM/ddsindq3Rohhrs6b063Sbob38GRVwho5YqdHOFQm
         hC9A==
X-Gm-Message-State: AOJu0Yz+fxNjOh4DCJRDOhOZACzi4jGfag5q/yKPUECiM1AO70K5nC6O
	t0KU3c6h9GNeZCioPGggblT4Canz3MHOfQu4Q9PpOPz2lxvLru77BaTvTRCtErNl4twuTg==
X-Gm-Gg: AY/fxX4DIzvrH05TnQNhrfz7d+TDevSzv9YfkrHFCb75D93aodFZ1/VzvBlh9iJ0mOW
	+/fiNC52w5OUzhkdV2xKAuNVppWhEHnc5ENONZWUKEacDP5lG4lhrsNLyJXhfGO8B3QFra1Fjn4
	CPoWVawA3FAL8QD1r94fkulf0GNmf9iBnAxqMyU3XF43zCua0G4HF5LrNYikKqVlk3J8NFtYomv
	ItqCDuEyga96/hO3Ytg0qYO6uEEtlXyxYG3zRP9xazvXb8J2vJ9cEkwiqxan5eNC5AJ0SZZ51F8
	+XgfiSOS6DSiNR2v4HPJOkUMEKXyBkI9to5/Stcyiv0KdIvjkyVunByEFW3nao/MbYO9Qt3hZBS
	RYbuhe3Z8Yx1VqbyDuSl4EpZ4N1A183P5x7cfizP7LhZr2ZRfYC/AqUfDFmh3cGi1rDiwTGEbXQ
	oe/vEQ9xjsu7K44vewSP3dErq9BFYDOT+QYtof4EX3xeObHrYS7XLCiCr3mTk4Qq+GWSEMuahC/
	I6W
X-Google-Smtp-Source: AGHT+IGZUNAWRT4MEWYISXMFNkBW3disGfrc1KwAIqE8NKGjYL44e5oxPTy5BkOX8qfMQjvTLc97Mw==
X-Received: by 2002:a05:7022:6b89:b0:11b:9386:8263 with SMTP id a92af1059eb24-11f296f43fcmr4799213c88.48.1765434301979;
        Wed, 10 Dec 2025 22:25:01 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e30491dsm4920158c88.16.2025.12.10.22.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 22:25:01 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH] net: usb: sr9700: support devices with virtual driver CD
Date: Wed, 10 Dec 2025 22:24:51 -0800
Message-ID: <20251211062451.139036-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some SR9700 devices have an SPI flash chip containing a virtual driver
CD, in which case they appear as a device with two interfaces and
product ID 0x9702. Interface 0 is the driver CD and interface 1 is the
Ethernet device.

See:
https://github.com/name-kurniawan/usb-lan
https://www.draisberghof.de/usb_modeswitch/bb/viewtopic.php?t=2185
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/usb/sr9700.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 091bc2aca7e8..d8ffb59eaf34 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -539,6 +539,11 @@ static const struct usb_device_id products[] = {
 		USB_DEVICE(0x0fe6, 0x9700),	/* SR9700 device */
 		.driver_info = (unsigned long)&sr9700_driver_info,
 	},
+	{
+		/* SR9700 with virtual driver CD-ROM - interface 0 is the CD-ROM device */
+		USB_DEVICE_INTERFACE_NUMBER(0x0fe6, 0x9702, 1),
+		.driver_info = (unsigned long)&sr9700_driver_info,
+	},
 	{},			/* END */
 };
 
-- 
2.43.0


