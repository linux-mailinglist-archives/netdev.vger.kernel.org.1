Return-Path: <netdev+bounces-202347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E360AED76C
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 10:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E07C3A5B71
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 08:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A93226165;
	Mon, 30 Jun 2025 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="SVTph91T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5865D224AFB
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751272505; cv=none; b=nPNERR4rUaFGiO9DJAQzovQ5Lv6J413kv2AcgEBNhLZ9oBAo1tzUOQPmjFVunRLPco7f06a2C16a8xNJxGOV5i0J7SVcox2cvfPRXlrD4/6gtVJ/rCZxkFrZeSfM5sBokytPzkfbu/Q8I3dCMs8gB2OwvBQg6BVULJCtHGcDyNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751272505; c=relaxed/simple;
	bh=rMBOamKLbu321mtPz7aZ7dYFuOxhTfaXxuqipbsdKeY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ElGbT0XWxFUpGI06x7MZ7RqQkHNh1bTeaeojSfAjdBnVkIM2tr8Ppb7w53W5VokkNvzV1rBQ+s1z1qVMQ5wwPL+2/OCg+/lAEh2M3tGlbiRYrLysDDVIXHqozu+6zB9vOw3QpfAZ0ToqpQulEtsrz3BJN5N7BGBscGyJH+fHQYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=SVTph91T; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a16e5so4097310a12.0
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 01:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1751272502; x=1751877302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C+gUbT9aHifoGPBMBwjpCJyvBKNl1VAoZReu69+v/wE=;
        b=SVTph91T9BoR12pIYhuO5IAj4GVpDBGktp1BRZQXPhWTq5y/enI+OhEXXOdSmkv4kZ
         Dj/O4cwoxSIkZpy8GyzUsD7PrZOdJG/gN3VOX0FEvffk0FDYWtK75zCxRfVtJCVhsXzD
         TvMXZhzLjB4uMMT11Cbh64agUVInMOO9haM4vIDTFVT+vhfMfd/1hsQXkKZzzQYa+0sm
         qnNqjZceCrZ9AwtJIty8tQmHh5wCfg8DHWUUYAT94+Sc5q9QhxUcj5vXOR3+Rt15jLV+
         nWc26syED7NUYw0p6LI/tp+RGCUk1qXg335hyXVBA2/zai9Byl7DqCMAmJBZ3/Qo4kQG
         8ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751272502; x=1751877302;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+gUbT9aHifoGPBMBwjpCJyvBKNl1VAoZReu69+v/wE=;
        b=OB5mzLW84nxAexjddyJNszBo6Dfw2QhBm3lmIYofdjuMI1D9VqPmZnzKPtrst3SUwV
         f+TupxQyHdbH4D9/4dwb1pOblF9iqMlEY/y9ZlPRUpaXfYTGkm75UZ1XTamwiCb/OZnS
         GmNPybSvyDxNvauTGsOwiQPjTjq1Ye1VFweeGMuWFF6kgpq/9UB8qE+RQ0g4BiIb5CyR
         DSj/8zrtFcVjjDmh3QMwXPfMK0oABg6g5hgmeE/PLEF2p8Hj5E6Y+MtLpcEONMBHBqfL
         MeHBG6X2cCUMQdVJ2Hqx1mZQZ8XJo02yjBiVvJyU+3pvctj8zph5bfMm2K3c0wL3+AW8
         vbEw==
X-Forwarded-Encrypted: i=1; AJvYcCXLYNb5/iAG+AyNFbjtTaTZFLHPTuNfJOS7Be7PseJJV3rtbQEPBLAiFDfiZw2yNglQGe1t3xM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN0LxA9S3oM6Dz+H8nA3YGaUzD2142hFVaFUJ3mJI1Z9tj3r7X
	i9poN0id2V199kr64uLgMag+g+92AvW2kF1/G5a6f96wBRrMcyvddabUNrfog/OF6Q==
X-Gm-Gg: ASbGncthIbHEqwTD8SY77oTXcEhSvZVBeyR/6OJqGzVz5eDGAocG0pT7q05EqAbMdTt
	UgIp39+gYtdjc3jq6RZ0fIMBbXH26pwhD4XHFK+RPF7ACBZEK6VxgjPi9sBL+k9lDKNsI4a0EA6
	gvNSTQxDnzbCxm8KMiAK6EccV0NU/UgTOSLb9VM6xhFNx6Kp9SfcdX0gTNkC/LGTpkYCzXnVG3q
	VVNy26O2H1GP/d5J7P1yyStTmHab/ovYj8gvl/X940qG7xGDwV1E0M4qMmumMZXNnN5/H1P06SE
	e+EhtJuqCX562PPVCcdXqrYWGI2SsaFMS8eerCJ7AEPa0s4cA2YD6ThJBQMjyiic
X-Google-Smtp-Source: AGHT+IH/T30kQj3wWajjJInTipqkpt/+zHcGETsFy1EeW1ixfGoQnxnikZCFVF0R9CqSva1q7DNB0w==
X-Received: by 2002:a17:907:9802:b0:ae0:e065:ddfb with SMTP id a640c23a62f3a-ae34fd8932cmr1006397166b.18.1751272501411;
        Mon, 30 Jun 2025 01:35:01 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363a75csm623995166b.7.2025.06.30.01.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 01:35:01 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <28347e4f-c6a7-4194-8a80-34508891c8ec@jacekk.info>
Date: Mon, 30 Jun 2025 10:35:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 2/2] e1000e: ignore uninitialized checksum word on tgp
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Vlad URSU <vlad@ursu.me>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <3fb71ecc-9096-4496-9152-f43b8721d937@jacekk.info>
Content-Language: en-US
In-Reply-To: <3fb71ecc-9096-4496-9152-f43b8721d937@jacekk.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

As described by Vitaly Lifshits:

> Starting from Tiger Lake, LAN NVM is locked for writes by SW, so the
> driver cannot perform checksum validation and correction. This means
> that all NVM images must leave the factory with correct checksum and
> checksum valid bit set.

Unfortunately some systems have left the factory with an uninitialized
value of 0xFFFF at register address 0x3F (checksum word location).
So on Tiger Lake platform we ignore the computed checksum when such
condition is encountered.

Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
Tested-by: Vlad URSU <vlad@ursu.me>
Fixes: 4051f68318ca9 ("e1000e: Do not take care about recovery NVM checksum")
Cc: stable@vger.kernel.org
---
 drivers/net/ethernet/intel/e1000e/defines.h | 3 +++
 drivers/net/ethernet/intel/e1000e/nvm.c     | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
index 8294a7c4f122..ba331899d186 100644
--- a/drivers/net/ethernet/intel/e1000e/defines.h
+++ b/drivers/net/ethernet/intel/e1000e/defines.h
@@ -638,6 +638,9 @@
 /* For checksumming, the sum of all words in the NVM should equal 0xBABA. */
 #define NVM_SUM                    0xBABA
 
+/* Uninitialized ("empty") checksum word value */
+#define NVM_CHECKSUM_UNINITIALIZED 0xFFFF
+
 /* PBA (printed board assembly) number words */
 #define NVM_PBA_OFFSET_0           8
 #define NVM_PBA_OFFSET_1           9
diff --git a/drivers/net/ethernet/intel/e1000e/nvm.c b/drivers/net/ethernet/intel/e1000e/nvm.c
index e609f4df86f4..16369e6d245a 100644
--- a/drivers/net/ethernet/intel/e1000e/nvm.c
+++ b/drivers/net/ethernet/intel/e1000e/nvm.c
@@ -558,6 +558,12 @@ s32 e1000e_validate_nvm_checksum_generic(struct e1000_hw *hw)
 		checksum += nvm_data;
 	}
 
+	if (hw->mac.type == e1000_pch_tgp &&
+	    nvm_data == NVM_CHECKSUM_UNINITIALIZED) {
+		e_dbg("Uninitialized NVM Checksum on TGP platform - ignoring\n");
+		return 0;
+	}
+
 	if (checksum != (u16)NVM_SUM) {
 		e_dbg("NVM Checksum Invalid\n");
 		return -E1000_ERR_NVM;
-- 
2.47.2


