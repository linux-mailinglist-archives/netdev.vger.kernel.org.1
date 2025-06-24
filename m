Return-Path: <netdev+bounces-200807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 368A4AE6F8C
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2C45A4DC5
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 19:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C2F293C7D;
	Tue, 24 Jun 2025 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="JZ2ZlZFZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF1C2E3380
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750793388; cv=none; b=DZK/b+TnMz9TO40nqj17qJvnyjos2stjCPg1R/PrzLhI0ggxOms5QViLnCfRTCOOD804UaILnwHrOVDch2EDZUKp4Y+RW1JxPPvnCPRavMtA/VF4muJJWFu8udDLz3zya4o/A5TF6oTtBTxBZH8augj+t+ZaUgenIt3H80NQ5gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750793388; c=relaxed/simple;
	bh=JQphqSpJyr1qy+KMoH2QoJmAbI8VxamSwuQ/cgKV2UI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:Content-Type; b=BZDTfRBuprzDk+tVDueYNPvyLag7s0b5GTItWBdb3nDjq4/LvtrsC+ilf0dZ1TY6KmkgaoFQrOG0RrR+cRWim5vtvYpqkXMFz1jzIB7Gp/X9WOgS5+UILY+WZ0o7cY7yjyE0z2FUWMF2vqzsg7iHGp4NGjnhfXwJGRYD2jRbRJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=JZ2ZlZFZ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ade5b8aab41so1181451666b.0
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 12:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1750793384; x=1751398184; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:user-agent
         :mime-version:date:message-id:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ws0aKIOxs3tVl5HqThHJotfuM+musWr8w3Tsu+UY7Fk=;
        b=JZ2ZlZFZWHL2ySNvreach2rHQIY33cvUe7Q/qAf6LJPvynFkX4P6SrcB7a1bYWaK/o
         jKP3LiMXjGbq8g4kZ6OSxIUZszc+lJmOa5+0cbyK6EFxfZeVCW4vTJL/de3jZ9KOUVnQ
         UCrBHtXvvGlVfyjbcJW/H8r3kb+yNxxaGJ7WYF67b8jx6Q19EYp4fXnrNLeydD6JasWS
         3prwh40915ohIYJ1gVTl3NRdik2I+n3d89k0ULPrMyxCd5sBOf/Nf/QtnNxmpsd2TyJV
         zhRBzHEbyFJ6awr1r4vwnnoIfPr/9c5nU65EWyBP6I6DmUVwdMOcFlCAygdHONMIctYZ
         uWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750793384; x=1751398184;
        h=content-transfer-encoding:content-language:cc:to:subject:user-agent
         :mime-version:date:message-id:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ws0aKIOxs3tVl5HqThHJotfuM+musWr8w3Tsu+UY7Fk=;
        b=tneJOHeF6mcNcTl0FlW0/BHrzgMuxtpiLvC7GkGoQ6WNscoQIkmVMjNbjCxd21khRN
         d9D8YDkhVA03DsyLBDqxWmBEB8EsUehGb2QdbodG9tmXezHFiDpAVeozqy5wcRx0Utgb
         iNPlhzGWCkptqxykBQG3hm3ujbn9Z+9GG6+U63rdT05sHlcUSVFisN9ljC/1CSOIe9ll
         eq0NWV8LpWrcWu1U+QzY4GKxvHtsKFxv7ker2hFTBdlC3AL2cbnKfaC9YFEWb7J5Bwbt
         8fo413hT1IiTRbY+5fwyHjrxopkuxaC4a9DH5Vsfrl5WazFWWxUb5ixdhHPw/JUycvd8
         l63A==
X-Forwarded-Encrypted: i=1; AJvYcCU0/UfpWcr89nS9PyrgtuKCQBlql5hCpBSugbC2clOHwUj6gK4aZHy29cVGiKaqqQR9J39AcKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwK5VFOTE+o8zsWRCwFVQov//KgN0T2TLuaWcM4SPDlXJn6UQo
	p3wEGKc0LV2+GXCRJWOMftOMGAHlJq2t01tHmOkRMxrWB6Q3ANaNgjDq0NrlAcOpug==
X-Gm-Gg: ASbGncvbytKOhfYUX0XUQ5nF0TSh5gDQ7RWjUsRW2EYkKcnQe14NNU+nPOz10QzcWl2
	KU+2En/WZcmBvFoWmgH82cDX1yv8cP+YQXPJTKV4RwG7AJznTOrZ47hcRgHK/gT7kzlVZ3W+V7G
	TsHf3Ax4dqgAcyld+er91v4DQfksHIgogbuQMa7QWMhrgey1+cXEfeX3nj8Db4E3PWgxDTlsj1O
	bzBIlMvKMDwGSpLbLBdVTN2tppmk6/nAbxaE4lRzQ9BOhjOnxz3tMlsNkTbZXs4jI+iM8T56sjz
	ersp0UkwZ9Vxs3c21Dus5OjmECI+yZunebyyoTxklzKrBmnOvXwMdXh8135lMNLt
X-Google-Smtp-Source: AGHT+IGeqgsx8L6sy3o3oaeB07CiiQupvJ4nu0wpwMNqtSXLbb2/E/jMAzuWpZLEd5MscyMgYpvVfQ==
X-Received: by 2002:a17:907:868e:b0:ae0:a648:54bb with SMTP id a640c23a62f3a-ae0bed82df3mr51970566b.31.1750793384497;
        Tue, 24 Jun 2025 12:29:44 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053e7fbd9sm916114166b.33.2025.06.24.12.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 12:29:44 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <46b2b70d-bf53-4b0a-a9f3-dfd8493295b9@jacekk.info>
Date: Tue, 24 Jun 2025 21:29:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/4] e1000: drop checksum constant cast to u16 in comparisons
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
Suggested-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 2 +-
 drivers/net/ethernet/intel/e1000/e1000_hw.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
index d06d29c6c037..d152026a027b 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -806,7 +806,7 @@ static int e1000_eeprom_test(struct e1000_adapter *adapter, u64 *data)
 	}
 
 	/* If Checksum is not Correct return error else test passed */
-	if ((checksum != (u16)EEPROM_SUM) && !(*data))
+	if ((checksum != EEPROM_SUM) && !(*data))
 		*data = 2;
 
 	return *data;
diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
index f9328f2e669f..b5a31e8d84f4 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
@@ -3970,7 +3970,7 @@ s32 e1000_validate_eeprom_checksum(struct e1000_hw *hw)
 		return E1000_SUCCESS;
 
 #endif
-	if (checksum == (u16)EEPROM_SUM)
+	if (checksum == EEPROM_SUM)
 		return E1000_SUCCESS;
 	else {
 		e_dbg("EEPROM Checksum Invalid\n");
-- 
2.47.2


