Return-Path: <netdev+bounces-94814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE7D8C0C1C
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 09:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF5328299D
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 07:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCFB14830B;
	Thu,  9 May 2024 07:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pT1uYH9h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4074E13C8E1
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 07:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715240925; cv=none; b=OYziJkSYtQGpZaB6/+iUlWQwae2n0fO91EN+bFgyOR6DiZaK0HkPndlq5gFJr0C8wI1Aq4q0PQF11R4GFFQWLbW6LT0yVfl9lYRxGqY4UjMYeDplVEaxmJ6yJmMVEtOGsCjJkkiyD+lEsUVN11fnN7B0zIWwZYyusWaX3ZeZekw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715240925; c=relaxed/simple;
	bh=kAmv26lH1uVQtn92167QEGYLNRmF1QfXKCUTwTBlnQY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X/YhZAZs8xasBzGWWAuKDaraO6XQcF/P7AzLi9zRAeTKmBDiMviAxolDFKceAbdKoVaFgkkVP0Ccm64EF5YBOX7tt/X3cy8w/Sk+aRUBHGdH5bWgI5rf/RWkOVbVIsLa3dqrxTxzmASmhapWwx7QH7r2Gv+30vQs941aGB4aC4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pT1uYH9h; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a5a13921661so118563066b.2
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 00:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715240922; x=1715845722; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iRfFlk1Iy/4kaN25ELw7JxuJnBR11K+39qE0xd8JGpE=;
        b=pT1uYH9h7ShV4pnH529X/9CqEPy4kJv9UpisAzc1mlaHW4pNNts9TjkCkK2VNi7l9p
         ic4VT+dBZCpWoauMU1DXcL0CU/vsHGZttdVTpeJk+TASgEaRJfkKuFBi0nMzSUnx9Jx5
         Md4MXLeIbyLhPI9xIYpCB2r+xID7+QOwpJK+UvyGqvbTYXntDBvzuT/z73bwWDme+G69
         O/lUt0195xFsVDsJ/v4yFaCanWrt4vLMErCdOcT5XA6vYaVJoG/LLDb0IuiQLtzqkw0Y
         rasiSwnh5GXqwXpb/Q43vTkyb7jHduBLpETpJPlemtKGG9ijelKh7vbKSJIL80gbSuSv
         HrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715240922; x=1715845722;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iRfFlk1Iy/4kaN25ELw7JxuJnBR11K+39qE0xd8JGpE=;
        b=QhYV+tF1nShgzc4YZa+PCmZzfU3SmymxnrUqSKuY4FZRjmAm7JW3uzaGbPpq3Ia2Tk
         LBQkeGStrTvw1KCeNQI7I0NeCgBPWuEp+VCEJ19Leo11p+7bM8N1I2gPaYJphAh68hkT
         LnDbR3JFOShLkIo+fiZ/S8lDgetH/wUADM+Ibf6J5BxoFJcxIR39FqDWvDqIBbrBlFRV
         TyrH0jwORWBKmkTZdDfopLZL6+wDeenhsH0yFU77CZ0Ukf+CMbWxWLUUKx4AtzYym5oW
         Bzu5PGSlO3HNq/O+nPeEa24R7DLQOgrTtCFZ8W2eqDSJd09I8IAq8Go5hD67yAT9biZg
         8qGg==
X-Gm-Message-State: AOJu0YwR+5V+XYRLlBm5tOk/XYQdMlYZt00BiQ3wqae3LZ1m3zWTqaV+
	iVVDT/UfMexD6xBIaK0JA2g2uyKUQ4lE6jcv82PIbMC03F5OZi62RmtLkT1rX38=
X-Google-Smtp-Source: AGHT+IFUQJfIfliPaHKaD0EFiH2+dWmELCwMKisjYWZtnYbFRweR5qVWTnhGejLAkAJ7HgAA95kZmg==
X-Received: by 2002:a17:907:a4b:b0:a59:cb29:3fb2 with SMTP id a640c23a62f3a-a59fb9b85abmr370116166b.57.1715240922425;
        Thu, 09 May 2024 00:48:42 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7d65sm44783366b.126.2024.05.09.00.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 00:48:42 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net-next 0/2] net: ethernet: cortina: TSO and pause param
Date: Thu, 09 May 2024 09:48:36 +0200
Message-Id: <20240509-gemini-ethernet-fix-tso-v1-0-10cd07b54d1c@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANR/PGYC/x2MQQqEMBAEvyJzdiAGdwN+RTyY2OocdpQkiCD+3
 bjHoqvrooQoSNRVF0UckmTTAk1dUVhHXcAyFSZrbGs+5ssLfqLCyCuiIvMsJ+e0MXxwTetcsLO
 n8t4jyvQv9/SKijPTcN8PglxM4XMAAAA=
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.13.0

This restores the TSO support as we put it on the back
burner a while back. This version has been thoroughly
tested with iperf3 to make sure it really works.

Also included is a patch that implements setting the
RX or TX pause parameters.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (2):
      net: ethernet: cortina: Restore TSO support
      net: ethernet: cortina: Implement .set_pauseparam()

 drivers/net/ethernet/cortina/gemini.c | 50 ++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 4 deletions(-)
---
base-commit: 80e21abd90de5affb4521db3491adb19656c0969
change-id: 20240506-gemini-ethernet-fix-tso-ebc71477c2fb

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


