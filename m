Return-Path: <netdev+bounces-136401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CAE9A1A6E
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 08:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671F61F23663
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 06:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14AE14A0B8;
	Thu, 17 Oct 2024 06:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4s5Z8MG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43991779BA
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 06:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729145121; cv=none; b=lC961T+WJXUsoQC2PIcZFm8kOQgQod4URglrbP6HC6gk2rEcJBwOHh63R+mq6HRtZwqQs4E3C+8+5Cn8ltV/7YMLgJi7nI5d53A8fI98mG1ANZf4zzMJgLJ3NxyLmqaU4P3qkXEh+2yGpk9g7lppheNgIp1hJV1alcTZNs4MNPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729145121; c=relaxed/simple;
	bh=cVdKgSDtWZWmBeeskRrfzTPArzBoWSwYGMNGM93XmtQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=cUSDRt0vqKxt2HS57M+TObaPaV5ne8Cj9fV1zXjpxQxY1w0m1rnCGy9dYphcZNPjcUJ3fXvkhCmYXIBobwmddDxpiL5tfdSaGV63TUKI0IpiR0nPzMNZjyt5zbOCnyBjyFahXOyTGMf5/SXZW7RM7VSudEsks5CAiQhwhXHsThw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4s5Z8MG; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso1010693a12.3
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 23:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729145118; x=1729749918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilOEOmtwOqLVOebC3n5C+S8TTChq4AiiwBc9RS73wNQ=;
        b=W4s5Z8MGwtxRe8Wq+uh2mCSejN3DdqlR6AY62JR1k6Gdts2ccZKyyrKHfEQunae3y/
         2sybj7lincQ7yye9Q7MzmcXQVb5D8Imdr0hRrVbk8F7g0Ru8Q6E2rEPw0ZsAuBTYMEPV
         A0OjwBcf0pBQMEQQtEL4/E27gtn6GHN74tx0ekGFN6fruo1U1MS0fG4hXkHVFAMM3I9B
         JJJg5qMLplbJbgezJIgrdqShE/jnwg6OZ9dAOwMsCovM3xfHuzLJF8EpAIWI6bZ94BUj
         MlUKtRZ2czBFfnD+W4cWSOcqmNXDP0GoqkYyVhfky9TK9+7hIBaxUlBCqFgwADOJvA2q
         y70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729145118; x=1729749918;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ilOEOmtwOqLVOebC3n5C+S8TTChq4AiiwBc9RS73wNQ=;
        b=ZTcsS3S+A7yElF9CGhjc8yqnM5UKnQ4XXhd14jdLXkuXV9yoIs1bVxrENLRr2Lbt5D
         ifybcjsFnzWvdzKZ82PlGnOUPYaMSatbeI4ujbHILYGC6Qe73HTw+6TvJGF6dzYIHrS6
         DnM2w2u5m8aQYbNaN6VoAMpHA9zV0LpuS5Yv8c39xZ2G9SIYZxvTVIq6ySFpVkr0sT6K
         lUtV0lkKArM21C/KcH7vkFP5bMCvcT7qJHDpo4jaVM/rgnxx10TE13GzJevjEBDAusgX
         DBFap1Zn8ZYx+bw70NBj4OEmh8Uw+DwEWFbP9kGhwZ2a3cVTt4kuQt30zakoGwH2K2F/
         x3OA==
X-Forwarded-Encrypted: i=1; AJvYcCWUvzVz9KNUfYCe25MGfNGK5epkWBbw5kc+eq5az8BWWxkJjTOa2WGWYI4eBLalyCltel0m7Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YweMLlx/RKMDlF62ivdE2D1LYAbAELraLxi6gj0sJ6eQbayR7Q9
	XsK/sG1auFnR4p2IbWtWjA1r6+qc3e77NjfZzaPlxSuH6AWyTniy5qS9h5lm
X-Google-Smtp-Source: AGHT+IF5+juf1ouD/lXnpuoHyjmhpqcJROGkUpxEYqjDGBTU5yM5ZmmzB4QA2dVnw+RqytiglI1pIA==
X-Received: by 2002:a05:6402:274c:b0:5c9:6ae4:332e with SMTP id 4fb4d7f45d1cf-5c96ae43633mr14857739a12.8.1729145117801;
        Wed, 16 Oct 2024 23:05:17 -0700 (PDT)
Received: from ?IPV6:2a02:3100:b38a:4000:5884:eb7d:1eda:4cea? (dynamic-2a02-3100-b38a-4000-5884-eb7d-1eda-4cea.310.pool.telefonica.de. [2a02:3100:b38a:4000:5884:eb7d:1eda:4cea])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d4f97f1sm2330156a12.31.2024.10.16.23.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 23:05:16 -0700 (PDT)
Message-ID: <b8e7df14-d95e-4aab-b0e3-3b90ae0d3c21@gmail.com>
Date: Thu, 17 Oct 2024 08:05:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net] r8169: avoid unsolicited interrupts
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: Pengyu Ma <mapengyu@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

It was reported that after resume from suspend a PCI error is logged
and connectivity is broken. Error message is:
PCI error (cmd = 0x0407, status_errs = 0x0000)
The message seems to be a red herring as none of the error bits is set,
and the PCI command register value also is normal. Exception handling
for a PCI error includes a chip reset what apparently brakes connectivity
here. The interrupt status bit triggering the PCI error handling isn't
actually used on PCIe chip versions, so it's not clear why this bit is
set by the chip.
Fix this by ignoring interrupt status bits which aren't part of the
interrupt mask.
Note that RxFIFOOver needs a special handling on certain chip versions,
it's handling isn't changed with this patch.

Fixes: 0e4851502f84 ("r8169: merge with version 8.001.00 of Realtek's r8168 driver")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219388
Tested-by: Pengyu Ma <mapengyu@gmail.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 1a4d834c2..322a1e930 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4805,7 +4805,11 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 	struct rtl8169_private *tp = dev_instance;
 	u32 status = rtl_get_events(tp);
 
-	if ((status & 0xffff) == 0xffff || !(status & tp->irq_mask))
+	if ((status & 0xffff) == 0xffff)
+		return IRQ_NONE;
+
+	status &= tp->irq_mask | RxFIFOOver;
+	if (!status)
 		return IRQ_NONE;
 
 	if (unlikely(status & SYSErr)) {
-- 
2.47.0


