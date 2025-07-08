Return-Path: <netdev+bounces-204867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF6EAFC542
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321A63B725B
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 08:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9596E29CB3C;
	Tue,  8 Jul 2025 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="vc41FOPi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBCD221DBA
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 08:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962673; cv=none; b=dEWrxwBHtIoRJblnfJcJPuwbAhxRxgey1wNiVAV/EIE1QMfBig4UetfekmTnNjT0GBS6YHG6KOYldw4PVl9Q/OV+DV+J54POg3Zumb0T6aqEkUym2xLJ+HTSekSIJvsZSzzBILh6a/JQfKOMgmrkQFvmcEM/hP4V8sztVujwUgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962673; c=relaxed/simple;
	bh=btFwVeTmREIEZnqUpysX9F2dt4CcoeaW9HVtPvb0OKU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uDVRRhvv6I9j1PW9/ftKq57qxOmYsWKCM7qtXqFMTLJzRrcWedHZW/58fsGirpFJvV3hv4tyP98FGlXw9FmWU/LjAXz6jOYRX+aIkvDgfMtMW2twR2R+gBVU9QEa5xVWTF0sTUMmnM5tQUfjxH5ZHtGNEtrdUn0fJLENen/Jrmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=vc41FOPi; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-608acb0a27fso5475140a12.0
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 01:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1751962670; x=1752567470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=24dFRVGPxiOPQ14wcYYid+zRefxCt8O1+HU2iy6DtlE=;
        b=vc41FOPiRpV9RKG3aiLcpM8qjZPE7Y4mEEWxrh1EAE56gAf5rm5iFYtbHwXke909y4
         PlV7d2eaK17KKZL2MwnTFaZugxdsyL14WykUgT4KtSsQWBNmB3lx2ivuwJpudXU3V3jE
         P71lzf9kGEdQv3ngZB+83PL09ft4rfqi75ynd9aDZ8lZKa7V3G8l8COmNz1cgWwJcC7k
         2rznUCET01IikumjiGTATWAKBj1t9HcA5/gNAy4kEGC82hqHrJgAsv+s7soJTpi6U/zz
         4G+YFMIokJ1m07z5hGx07499NmIMcE7KZ3hke8iAn279snzBWOZK5XAm3U8YnvTzo+Ae
         C1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751962670; x=1752567470;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24dFRVGPxiOPQ14wcYYid+zRefxCt8O1+HU2iy6DtlE=;
        b=EuE2j2sHAMGi/gRAnBUfHiJGf44UY1ebYb94/bFjT/ETiDfU6t5sb34O8/Iq20YlNi
         NaR/aB9XUUS4UpHpwdahAVBNyloCoFYlq14OqFhSMfRk3F3LTNVmfpFqsZUQ9gd7VKtb
         QpkpJUwbBlaHG3g232UsiRN0FWVERlnN5MHct7DHwQ+l0XiJdgMInXGwIP9LgtjVWCGR
         G4sP1lo5uPAh//Y3pS3FpGT2qKB9UGKWfLMaUuB/kIItyyh3TAuUCSpym1MsVAhaSZrf
         Il5xPC94pP93+hBORp6mJ6m0F7xkEEBxPdFC0NNq4MrMXut5/tFRx9ofdXHWXq9LQW8r
         MWmg==
X-Forwarded-Encrypted: i=1; AJvYcCX9Q8n1SdZr7HS/h4s1GlqSNAH4Ajj8qJvhaytcZFeisEtiVgUv3HISWlxMVD1ieSX265mSeCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Ua9H0ulY3TpKlX74QQgjftH7PcjLMnjHKDm8tx0tvnAVuUzm
	+bn4DyeoQ7lEE6quxw3FcQ72NnL6rm66Wtl2u8L0ihbUBIWCjLh+kSuRo6LHdALgzg==
X-Gm-Gg: ASbGncucWWT9Wn/CHUrBYyvwMeLCmHI6hY28zoobYT6D0kOE850r5bKxdtRcH1nAaKF
	uQVqFlQ85bVKHuztq6BUelX8taOEHXXtVpeB6GhrxFdG1Cpw1YKDRsUDV95KpPb5j3u9k5SEVr5
	gAvSwbwdVZT6ls2WoSzRbE/78yjdCfhX1s8d6o+OtTDe+vs9LUJQ8sEBhIl0rJYgielvltZPhVZ
	+lO0Vt34g5JiFKq/lTjTpENSJAMUdfl/ELW3vHEu4rATWf3OCf7ElGtFB74/j3OTifFR7nKhK1T
	ZyHTfZOINxnjXtCl40KE9ysAQc3xkfS2VHVvOkhZaXS8bdCWgQqoXamsb/kQgCFn
X-Google-Smtp-Source: AGHT+IFm7f1M9UA+aAJqKhCL80um1g0BN8ATSzspyHhyzGV3yuSxZ8i8Fn0NG67RS/zDuG7SuBK39Q==
X-Received: by 2002:a05:6402:518c:b0:607:35d8:4cf8 with SMTP id 4fb4d7f45d1cf-60fd65156admr14881266a12.11.1751962670055;
        Tue, 08 Jul 2025 01:17:50 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fca695d50sm6822392a12.24.2025.07.08.01.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 01:17:49 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <b6d736c0-ea5a-4b94-a633-dc54c6283895@jacekk.info>
Date: Tue, 8 Jul 2025 10:17:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH iwl-next v2 3/5] igb: drop unnecessary constant casts to u16
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <b4ee0893-6e57-471d-90f4-fe2a7c0a2ada@jacekk.info>
Content-Language: en-US
In-Reply-To: <b4ee0893-6e57-471d-90f4-fe2a7c0a2ada@jacekk.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Remove unnecessary casts of constant values to u16.
Let the C type system do it's job.

Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
Suggested-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/igb/e1000_82575.c | 4 ++--
 drivers/net/ethernet/intel/igb/e1000_i210.c  | 2 +-
 drivers/net/ethernet/intel/igb/e1000_nvm.c   | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/ethernet/intel/igb/e1000_82575.c
index 64dfc362d1dc..44a85ad749a4 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.c
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
@@ -2372,7 +2372,7 @@ static s32 igb_validate_nvm_checksum_with_offset(struct e1000_hw *hw,
 		checksum += nvm_data;
 	}
 
-	if (checksum != (u16) NVM_SUM) {
+	if (checksum != NVM_SUM) {
 		hw_dbg("NVM Checksum Invalid\n");
 		ret_val = -E1000_ERR_NVM;
 		goto out;
@@ -2406,7 +2406,7 @@ static s32 igb_update_nvm_checksum_with_offset(struct e1000_hw *hw, u16 offset)
 		}
 		checksum += nvm_data;
 	}
-	checksum = (u16) NVM_SUM - checksum;
+	checksum = NVM_SUM - checksum;
 	ret_val = hw->nvm.ops.write(hw, (NVM_CHECKSUM_REG + offset), 1,
 				&checksum);
 	if (ret_val)
diff --git a/drivers/net/ethernet/intel/igb/e1000_i210.c b/drivers/net/ethernet/intel/igb/e1000_i210.c
index 503b239868e8..9db29b231d6a 100644
--- a/drivers/net/ethernet/intel/igb/e1000_i210.c
+++ b/drivers/net/ethernet/intel/igb/e1000_i210.c
@@ -602,7 +602,7 @@ static s32 igb_update_nvm_checksum_i210(struct e1000_hw *hw)
 			}
 			checksum += nvm_data;
 		}
-		checksum = (u16) NVM_SUM - checksum;
+		checksum = NVM_SUM - checksum;
 		ret_val = igb_write_nvm_srwr(hw, NVM_CHECKSUM_REG, 1,
 						&checksum);
 		if (ret_val) {
diff --git a/drivers/net/ethernet/intel/igb/e1000_nvm.c b/drivers/net/ethernet/intel/igb/e1000_nvm.c
index 2dcd64d6dec3..c8638502c2be 100644
--- a/drivers/net/ethernet/intel/igb/e1000_nvm.c
+++ b/drivers/net/ethernet/intel/igb/e1000_nvm.c
@@ -636,7 +636,7 @@ s32 igb_validate_nvm_checksum(struct e1000_hw *hw)
 		checksum += nvm_data;
 	}
 
-	if (checksum != (u16) NVM_SUM) {
+	if (checksum != NVM_SUM) {
 		hw_dbg("NVM Checksum Invalid\n");
 		ret_val = -E1000_ERR_NVM;
 		goto out;
@@ -668,7 +668,7 @@ s32 igb_update_nvm_checksum(struct e1000_hw *hw)
 		}
 		checksum += nvm_data;
 	}
-	checksum = (u16) NVM_SUM - checksum;
+	checksum = NVM_SUM - checksum;
 	ret_val = hw->nvm.ops.write(hw, NVM_CHECKSUM_REG, 1, &checksum);
 	if (ret_val)
 		hw_dbg("NVM Write Error while updating checksum.\n");
-- 
2.47.2


