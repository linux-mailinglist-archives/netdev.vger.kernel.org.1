Return-Path: <netdev+bounces-200336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CFBAE4989
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 18:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F89C1884538
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82A12701C4;
	Mon, 23 Jun 2025 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="wYXlvtkh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EC22673B5
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750694292; cv=none; b=Hufxhd1gj5fj2ZhBWJNXW8k9QUwFlHT/ed6ygQo0KTtP016rW++oH7lxdiokVIWnN+CkaVF4zuFDMNVfG0y2Fr+dipnYwaweKjvoBtTKkEvL3ZtcsEzuuw15CSvzrS4GbtA/eTzJSE2kvozM40Lt9N17VBO4ByC4aiBiDgy1eMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750694292; c=relaxed/simple;
	bh=dTJ7o7lwO1w/Ico/bJN6spnwHd8zplEFB//q51c4kDc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:Content-Type; b=EvcItfwa0nuVEDk8JTE+Aej8sF2gqGGPrFTQHMfUFmwD9nArIIWwZirwMfVNxxDz0SMCz3K5WlYB3V6HKSFMFG2BOyuyo3hy8qV31BCkbrV+fpZXQgcCTqVA7IDrZ8iSvpTaizfZjjKInGGKXkY5RSQPBUPWyojBOzoXMtKi/64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=wYXlvtkh; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60727e46168so8345657a12.0
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 08:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1750694289; x=1751299089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:user-agent
         :mime-version:date:message-id:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THMPC/stGELIuIM3zh7ri4wYgq1jRpgRTNCcMv21/aw=;
        b=wYXlvtkhjrk6Pb1JfldCdf+RcGBxBguVDh+FTJXmtpopodBf8dsr5MTcVYu75PPtbl
         SoeQM1Wo+HFtDd/PLfyv29tXfPdeLr6uhhMCbKDjq0CjzyGaSgxInnMDSQgppUrlU9CZ
         IzuocJ1dOnLWbQmg9TA/s2g9bIOA8EYSCvwfZL7XIwpPp5J77ccns5iWg1nCT/8hwxV0
         RVXhpYT9lTXHgyNRTVazAzXJjlIj2D0LpJFaHp6+2z7tEjFHErCAfeCBFDNvk/tsLFlD
         sQ9iwK0sjQx2wZAGN0v9cbb4cJ1pQrNoUs5kLvVbvi9PDBULRZ6v+m3/mFexdEApizkP
         aZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750694289; x=1751299089;
        h=content-transfer-encoding:content-language:cc:to:subject:user-agent
         :mime-version:date:message-id:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THMPC/stGELIuIM3zh7ri4wYgq1jRpgRTNCcMv21/aw=;
        b=B5wZuKLpr8nXSUXOv5d8kPf6zCbPw+2ZuvyNl/g5g7YsvXiw84gk+hc3E6lwBYqOHm
         Nt/Yjdn+da9jw8tlqB0m/OtvC96zwSoBrUSEGdO3oH/tdsyPUT7GNFTEEv2qQn0ep2y4
         bKHQubITINGagBEYP4gpumM6UFlgU9kxNFxqkpUmBUs0Z/TIFtDiyOrHzpp0THd7cqYb
         QAhw8omzWDSZtJgW+ywrOhr9sa/L2GtsGY1LnBVM5f1VQ9lk9Iai9vHO2Suq5hx7zfLG
         X8JvqOpza1c2qnxaqmU4/eJYdWjgQo9aHfoKk4e8PzbLzmGi06jSL4xC8IpS+FAe6hNL
         +rew==
X-Forwarded-Encrypted: i=1; AJvYcCWJpX49oHPiQo/4mg6q0vyeQG0Iouwn9dDCEXYDbMvf/WnDKBPsX5C7xw0fQdjbkCX2V3Wg4G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDFmDbD5vmbJde0JbfXToUL+QzSVpShfM2Fa1G0ve/eVIr6evD
	m0lSzDgxASr4TancFz4b6HcIq7vFMfM02bINjtU7oe8jkOmJ8l/9VZyn1f05GSMcQA==
X-Gm-Gg: ASbGncumqVGC77MxXz4L8wCSfcfNCOdYKXBbEhRrFlR4gU+gN9cDb6TPvLCUVK65Khx
	zgCbv8ukwhc7iXrKHgwkbifqnBVLZOODQcep/CLXLKA0WSZcjiy8GsDMUlwRfJ2d0uFleM209h/
	qtWiavsZSauE0B8QtxISOGx8qnpgsNlXE5p8DMdwH7VIM5ZsvrE5zvqUAhgTNzD9b5XuJPAfrtF
	lWnw4zSBG31hOg5L8WSllXZYKchpJS1JkSiyQpuIew2HFEk/BYX+dxy5ZGE/HKoouV//bFMWLDJ
	d+zBGKKc7NT75HCyHcSLi3OafIGi27CfFywJ1BuMC6N6HJsK4Fe7DAETR2tdDcUG
X-Google-Smtp-Source: AGHT+IFS1S4nhEd7PY/HQFvRpwpefcPz4PA7zagt7CZWM4PTwwR7omhizl3rqwwz9enGP1MYSe3wjg==
X-Received: by 2002:a05:6402:d09:b0:605:2990:a9e7 with SMTP id 4fb4d7f45d1cf-60a1ccb50cemr12831827a12.13.1750694288741;
        Mon, 23 Jun 2025 08:58:08 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60a18cba458sm6315762a12.59.2025.06.23.08.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 08:58:08 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <fe064a2c-31d6-4671-ba30-198d121782d0@jacekk.info>
Date: Mon, 23 Jun 2025 17:58:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/2] e1000e: disregard NVM checksum on tgp when valid
 checksum mask is not set
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

As described by Vitaly Lifshits:

> Starting from Tiger Lake, LAN NVM is locked for writes by SW, so the
> driver cannot perform checksum validation and correction. This means
> that all NVM images must leave the factory with correct checksum and
> checksum valid bit set. Since Tiger Lake devices were the first to have
> this lock, some systems in the field did not meet this requirement.
> Therefore, for these transitional devices we skip checksum update and
> verification, if the valid bit is not set.

Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Fixes: 4051f68318ca9 ("e1000e: Do not take care about recovery NVM checksum")
Cc: stable@vger.kernel.org
---
v1 -> v2: updated patch description
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 364378133526..df4e7d781cb1 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -4274,6 +4274,8 @@ static s32 e1000_validate_nvm_checksum_ich8lan(struct e1000_hw *hw)
 			ret_val = e1000e_update_nvm_checksum(hw);
 			if (ret_val)
 				return ret_val;
+		} else if (hw->mac.type == e1000_pch_tgp) {
+			return 0;
 		}
 	}
 
-- 
2.47.2

