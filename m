Return-Path: <netdev+bounces-204869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5E4AFC546
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97C41BC09F5
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 08:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB4B28724C;
	Tue,  8 Jul 2025 08:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="n99aPzf/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD08C184540
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962720; cv=none; b=SFCypw1SBv7iqO8/Zj3GOSbjmvTUzLNsKNIPb1l7IaIdDkg2u0ZPuhAAqh2febbUtzY6vn8A3U38KHsqJMLmn/FUNqG0aUH4RmDKrI38z+Z6LQNGF9L+CVOjKCbiz9RL5+lMyLIwTAffyK3VRrFy5GbliCsbANLcu9MbBpkCYjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962720; c=relaxed/simple;
	bh=jAs2ENUFhzrm5luMQi4G2/6AxfpTlaHhZJ4St0jt02U=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=q9cYqszefrJsiDmjX216rbzcvMlMpmMQlJLRQM6aTWit2caW7tgCUvMaKaGri8USSXfi7fGINOcX70XGswmgofJZSEqG784sddC7PJOLWUyCWdkABB0CF3NKxLzaI0ooXbQHwnnKkyj9cnoa3iVVFdazm9NQD0ofc4swxwHBmCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=n99aPzf/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60867565fb5so6728858a12.3
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 01:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1751962717; x=1752567517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BJiSUu3hWE44EXsDXKkg8pF1uNLtKLtK6eYZS81KaN8=;
        b=n99aPzf/iTA1Y1fHx2bnghmUc80MT7ZYbGZM8YcmNW2s7jNGcUdcFr6562s6mckwiH
         E0+uFUxu99VtoFEcGbIYd9sqgV6Wf+shJnTDCDAlxP1Dqhn/s3C3bFz3TgreemOblrOw
         x7rYzrPm2XYybblLGBotN1255CFuOF2YUf/fY5VP0ETo6vsWk3e6Ob7PW4OfAilpa4Rn
         CIsGlugIlads2M2jllmvqGQTdC6aZZLkGfUMLIfXypoAMXAhlZ0lZ8F/ds6gRo5ZhwB5
         IkHR7lYdgea5HkufyxLMEzVRhhzukwNH6pj48JsteJB6owpXn0FaKNVgPIuyBqGbuJuQ
         DhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751962717; x=1752567517;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJiSUu3hWE44EXsDXKkg8pF1uNLtKLtK6eYZS81KaN8=;
        b=qCpyFWRLEpixf4JOBnt5QSatCyD7Jggzrp3M9sV14dOF6tBYTSmIRYF0YHWVAJrXtu
         tW7BFlkRwVbd8RXe2WPflCH3ytn6IEjS3l35Axgs8k7bTf9RfBxgj4Ty6JGiQiDMa36m
         hoDZzEnxsnidjRB7zgAW7x3JvKwjX+mdK7iPwKkQ0qo+vjEwlriZx2TVZ6sjBZc9UWMo
         4Z6v5NRfPel/Zb9wdmTKddbgGOc7t0414GBeXvWtlTsk7gCRn0OwbhUSi5OCD73Ct5Ph
         GIr8IXJXXaoEQZ/bXZVQVpYSqK8HdfXz8e+Gf5G+9MW1+gg3RE26CHDZ76LB7daFrVqj
         80wA==
X-Forwarded-Encrypted: i=1; AJvYcCXmtGcbBZ/c9GflLW3XjkpcsGDjXbey58+aDqtvOxwHKhZ04m86slM28F+ZlDQzAaFLiK5jYc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAwhVZVBxfk8gLKxZ9z1eokWTxbfmmAMBd5c4XqK6vHy959HVF
	NG9n9oBL/dpsDjkWAwUvYc6MLqEW6oA0mKWdE2F8IUaaOrf+C1VLUHmroCpkNVXkaQ==
X-Gm-Gg: ASbGncsAFRJYjPncoCXkutCAwBLreYh/QlAO6xsnKPVVvem1kmlmlL1prVR3cyjFw0b
	R7YJqZXUYjk2dbbpsbxOCHNT9E3pVHdEPGryq2H45llLm8OhTyD0548nsKjTOSLOLtFXo9UBB6v
	DrY9DkXYRq4rqIiEWivmIFddZ5oSNVoOcEqWZSvSA27GPjvXPaCZvTfnXkLwSpFmAeIUKqMF4L4
	xXvd3ke/sr08wAjXsUgnLbSP8Pz5ZoRAGSs7e6YitFx8lnHTB2NzkkRNiK9vfbN1X4qnoKV+WPI
	WnsuaR0jREFGm3yD1G8g+7ArwCZ1zgVb7dGf7OWvAULU2swUkoRfrKoy/cN+W9uh
X-Google-Smtp-Source: AGHT+IH6lR2m+v3knkC3IYA1tue00Z6M59zefIm0jwHX8zDQCkZwXr6vajUJk9ZtXJhj60dlCyqTbQ==
X-Received: by 2002:a50:ab07:0:b0:60c:3d54:4d2d with SMTP id 4fb4d7f45d1cf-6104ae32aafmr1281314a12.22.1751962716902;
        Tue, 08 Jul 2025 01:18:36 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fca667681sm6881085a12.16.2025.07.08.01.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 01:18:36 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <33f2005d-4c06-4ed4-b49e-6863ad72c4c0@jacekk.info>
Date: Tue, 8 Jul 2025 10:18:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH iwl-next v2 5/5] ixgbe: drop unnecessary constant casts to u16
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
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c   | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 4ff19426ab74..cb28c26e12f2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -1739,7 +1739,7 @@ int ixgbe_calc_eeprom_checksum_generic(struct ixgbe_hw *hw)
 		}
 	}
 
-	checksum = (u16)IXGBE_EEPROM_SUM - checksum;
+	checksum = IXGBE_EEPROM_SUM - checksum;
 
 	return (int)checksum;
 }
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index c2353aed0120..07c4a42ea282 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -373,7 +373,7 @@ static int ixgbe_calc_eeprom_checksum_X540(struct ixgbe_hw *hw)
 		}
 	}
 
-	checksum = (u16)IXGBE_EEPROM_SUM - checksum;
+	checksum = IXGBE_EEPROM_SUM - checksum;
 
 	return (int)checksum;
 }
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index bfa647086c70..0cc80ce8fcdc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1060,7 +1060,7 @@ static int ixgbe_calc_checksum_X550(struct ixgbe_hw *hw, u16 *buffer,
 			return status;
 	}
 
-	checksum = (u16)IXGBE_EEPROM_SUM - checksum;
+	checksum = IXGBE_EEPROM_SUM - checksum;
 
 	return (int)checksum;
 }
-- 
2.47.2


