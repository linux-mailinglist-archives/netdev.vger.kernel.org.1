Return-Path: <netdev+bounces-200808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C61AE6F93
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77411189D13A
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 19:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23BC2E3360;
	Tue, 24 Jun 2025 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="WwWGq90+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8307E23C51F
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 19:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750793418; cv=none; b=gX8rcPmHZDqmMIHr/1qu5UnAkxAvSCAsDdpaHtaUiecpFMCInv1mLHp3au+7bqe5n060xU8B7pz9atgdSvTnVflGht107MbJ0QRrCdVVe+8TyDZpHI6vtaeBSIIIdR30zaJmWkyfRo/vpqWuurkLH0WKA8y/8dUPNaq8RkCtMfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750793418; c=relaxed/simple;
	bh=95kehBe6R8bMjrNG+/GmoU/BYyhXXB9zEn8fo8sl8ZI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qjjSeQKFJ830349aZCWRVbmFEASNWdV3xHteQ+yodYnsaXAgY+Fsjib3pXF/l+/K2N6P1Ds1uIPWpeSkcArwrxeYF6/MMKMN87pB0OpyiG4xUkGrP7ur3DBtz6G0VzXmhtA+AGcpz2Y+j+Vtt+hnnJq2lct3UGamqUW5uTkF6Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=WwWGq90+; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60702d77c60so1602978a12.3
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 12:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1750793415; x=1751398215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DMpQ9unMD0vkQzXMI0Rh2M7VMEt4C5NAu9LffZ9WmFQ=;
        b=WwWGq90+NSP3pMUXWJTHWFBjb9IxxAz9wfcjmlwmX+PN0gUzGfjuVwzRv9cL0IWx9g
         MypweQy2BgApDjzcxRKA0f3DP137QcuiKxUWO7RoPoj2V4JRJUL80+erUWDytYnN2ZEe
         EX2roreARQ9ECqljy+IdEQHVJTV06M6+f3vF2xtOkUXUG5UwcL6UcBpBBmGPBpJllvfa
         YKXfnueHEUe2cKiY7RNRzWSnKrdS/JuewkkUYZudpURCZqMsEzOXs5NrmTh6jE2D4tYD
         j5eoklTgiED1xWlW2YnnUYp7Z+5f7GJ87mI0ml+j7F+5Q4jyc/vskeQGVh5TMBrY1p2H
         nboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750793415; x=1751398215;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DMpQ9unMD0vkQzXMI0Rh2M7VMEt4C5NAu9LffZ9WmFQ=;
        b=Lww4uthMVuMNOLeuRCoTMCRakag+g++XZdVHSYk6qcwBotNDi0vYrgYwrfsSjxqdBw
         8PVfLxR0W0Dyis19wT4dq1RPUEsqeZA7y+kpZGnkWfHF4FPz46NBUvrd/ijKOj0vAPGC
         NEN0dwmr7DD3iw7gp7kBHxIK28ZqD0DVP08p8WExnfSm4Co59nObFo+4zxiojaTwZWsO
         E7XDf9HvcYjpMRQCauz22abVxu6vv1EYQBHEHJL8laF66n8r6s9Q582WvY0643s1mFwh
         yXY5KPBBlzoDNhIM8o4en5eB1YWyGcXwIDoFmTmoPGbdOshPdBxL/Bt3udJL0Wx8Zr2s
         dtCw==
X-Forwarded-Encrypted: i=1; AJvYcCVZePUerKx30mnW+7sJ+Ks35+WrKFS5m2zaHbvfAhSw8WmwW9Okblc45TbXKw67wqP2z7zvC80=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMnBIpCVOX5ZO+D+n2Hqn5smHjjBf/oYK/fT4agn8Un/TlS103
	4+nI9gr7M4obnbDov0HjQRQPni2vID52B8iFZOu6K6/xuzWfRILIIaNNyhy6i2JasA==
X-Gm-Gg: ASbGncuITQKiiFk62/TxFMWtIo6QBfGQvT/MKa2SW5bKctcvH70y6oEyUSV4q7Y31E9
	YdkAQqvBo1hNFGdpNneopcZhSMYG9Nj0bZJWIKVngDxPS88dDj0aE8ji1IhuhRlMo73OcXT7tfz
	FGxcbinKznFN2jyxVie4kxPnNgu7L34mP266oNLFFyMmB0IhBo3/HEb/0RcW0IkTYTEdwJOLcQt
	JTfZcgi54SprnPUlmCOEKO1aE4dvQkdccO+Su9DWBbbwavaLyWHtxLmC263S6x+Xg2n5FPpMr2z
	9nlNdBD46/7NkwgFjb2QPTx6fVAhMJ2Foayf+zFgbZx/z/OaWcO2AWqlufkTLOrN
X-Google-Smtp-Source: AGHT+IFezbP2szbIE/wQs/O6ve43dXVC5PTJwpz2lY37bdKGvUZx8jqZCzVi52lj1/qGG/hdQGvRXg==
X-Received: by 2002:a05:6402:3482:b0:606:a26c:6f46 with SMTP id 4fb4d7f45d1cf-60c4dcd1340mr327a12.19.1750793414839;
        Tue, 24 Jun 2025 12:30:14 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f46820asm1455544a12.47.2025.06.24.12.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 12:30:14 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <9aaa80eb-91bd-4b44-814a-65f740f00d5a@jacekk.info>
Date: Tue, 24 Jun 2025 21:30:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/4] e1000e: drop checksum constant cast to u16 in comparisons
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <46b2b70d-bf53-4b0a-a9f3-dfd8493295b9@jacekk.info>
Content-Language: en-US
In-Reply-To: <46b2b70d-bf53-4b0a-a9f3-dfd8493295b9@jacekk.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
Suggested-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/e1000e/ethtool.c | 2 +-
 drivers/net/ethernet/intel/e1000e/nvm.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 9364bc2b4eb1..80435577dc0d 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -959,7 +959,7 @@ static int e1000_eeprom_test(struct e1000_adapter *adapter, u64 *data)
 	}
 
 	/* If Checksum is not Correct return error else test passed */
-	if ((checksum != (u16)NVM_SUM) && !(*data))
+	if ((checksum != NVM_SUM) && !(*data))
 		*data = 2;
 
 	return *data;
diff --git a/drivers/net/ethernet/intel/e1000e/nvm.c b/drivers/net/ethernet/intel/e1000e/nvm.c
index 56f2434bd00a..d1bc69984d71 100644
--- a/drivers/net/ethernet/intel/e1000e/nvm.c
+++ b/drivers/net/ethernet/intel/e1000e/nvm.c
@@ -563,7 +563,7 @@ s32 e1000e_validate_nvm_checksum_generic(struct e1000_hw *hw)
 		return 0;
 	}
 
-	if (checksum != (u16)NVM_SUM) {
+	if (checksum != NVM_SUM) {
 		e_dbg("NVM Checksum Invalid\n");
 		return -E1000_ERR_NVM;
 	}
-- 
2.47.2


