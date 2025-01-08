Return-Path: <netdev+bounces-156186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C69A0567C
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 10:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C9CF3A0104
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 09:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C48F1E47C8;
	Wed,  8 Jan 2025 09:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MFum00QC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57A310E4
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327760; cv=none; b=BK6fvmJLrE9SwCSM2l+ly8XRgrv611kiBCgg3BZ1s9fkmKp2QEujMYqSk1xG9Xg/yxvHcgNMvWkSDv1gfie6PPjtFUjOJbOkbozcDLP6t8M+hncD0dT6+eKsSx3TpjBllEX7IYLrQxpWbxsZGJ3xyLwy7RQhDMz76JuFZzA3pqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327760; c=relaxed/simple;
	bh=BDpuea0x98xGaOH/brrQV7qpk2foL2fZltIoQWXcJDA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OfWoDO3Ql2mR58zv7z3gIcIH9bwtOXw8WCnZ/FbK5NLfsx2EQHot5Ww87UQqtxEX/nSdxlwKvYaS+5w7aQcH0XvM3IkzoxS5lB22QN2DCkpKZpx7YP3iCVUm9ZZyCMzLesKqdIpdyW3cebpYvI8wUvqQa9x+2DWHS/czmCDAtXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MFum00QC; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso15817903f8f.2
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 01:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736327757; x=1736932557; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dNfHlg7+rOJqYIBrKsr5HH/Jvz6rLd05OrWMK+Cy6zQ=;
        b=MFum00QC+j+d2mDTtauIYhucJVzVSaefzQSYr0BELxxO4n8ZMI3/t/xelRNB20uLMV
         19QEeoK0D3SlizjyiBCfEZBovA8kB2ZuiihrzMrLIACtClH3m9Zm9gvSAmg29tcxRiu5
         tR0d24pR4Zz0NQKmBPgA7BQur9idFhEmh1RJydjceV/qU2inuT11wrzhDbQz4js4uyWN
         APDle9opOL1PePRtJ3xiPyOEB+g22/bB3MGP6Mz3wfS5qwDODQJFloFGPgxs9P5iBkhr
         5umBydSjkyRDo3dPQpRY1zdhuie0sACntlxlkHIhb/X+LnyxQuY4Muqs+Bp2uN+UUnx4
         R+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736327757; x=1736932557;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dNfHlg7+rOJqYIBrKsr5HH/Jvz6rLd05OrWMK+Cy6zQ=;
        b=W5jvBKc9MgLpOOQcAj5SBxvjdYOltkeUkEYpEpmPRzylfhwe14jbn/zbWqbkNUREx/
         ifnKXaK/q0tsEFRzazbPKausAsjkYswEGFtzSb1HPL8xIXMXoJh6PmtS0lc9SDUAINpo
         iIi+ILDk79p73/Euf5RnsULJAlF0/lng+iLaa9bNMUZXENA2qTCyECRDSYnlyqa6OVqm
         89YbbtQJzXsGcQMiUrM13GaWFVy/c1juJiqcYjWH9Agb+jWTtJVICIF6C/43ZVXYGyYp
         goJZlepqJ/d22Dq+srUWOvh/tkgCKfqNj1QtO7n2FBrK3ImAdNcbz+TeWax8KFSnJKe5
         158w==
X-Forwarded-Encrypted: i=1; AJvYcCWAeNJ8nqlgLanDe0WaFSlqLNkHvemIND35YqVPkKztuX8ZKyYXCTM6j5qOnr7mK0MLgDi4B8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9akNJWBcKGhuL0n01Eg+7G37EeVEua0f/L2aqY0afzAuPpdY2
	NpPr98PhGtU33Gbj51FX/H49tfOP913ETtO/HKtZS59qJ0TwYxUcJob22IBnKtE=
X-Gm-Gg: ASbGncunYpGQXu+Kva6Syh1MgIkpEtQ+svVBad249eRCTtJONmbbWEoYglcZgthaGj6
	aYZ7VcKQbx/5p3Zcge8tJDWc6dqZqjQorg5NimETrF5OFAVHjbpMcg/AlC8FRfxtZPrIawvMGJ4
	0L9XsIeH2JoJibEvMU5R+1xToGbhXkeBx81x7ZmFFmq0h7pRFROCC3uWVJuVnUJ0haAloZ7T/T6
	T/7v5uhvvRli7UTrxbCrIbIM26ZTh+Dur+QD8msNwLuLCdmCC4tG4kAQwuDgQ==
X-Google-Smtp-Source: AGHT+IHCY6wO+12ioIIeFx5QBHEz/z5fXqeEkaIQcWC8b/Zkck8otn4DFulJBJDQ/f9lbUQDLV7jiQ==
X-Received: by 2002:a05:6000:4714:b0:386:33e3:853c with SMTP id ffacd0b85a97d-38a872fc034mr1308522f8f.12.1736327757259;
        Wed, 08 Jan 2025 01:15:57 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832e31sm51691430f8f.33.2025.01.08.01.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 01:15:56 -0800 (PST)
Date: Wed, 8 Jan 2025 12:15:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: Larry Chiu <larry.chiu@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] rtase: Fix a check for error in rtase_alloc_msix()
Message-ID: <f2ecc88d-af13-4651-9820-7cc665230019@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The pci_irq_vector() function never returns zero.  It returns negative
error codes or a positive non-zero IRQ number.  Fix the error checking to
test for negatives.

Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
For more information about the history of IRQ returns see my blog:
https://staticthinking.wordpress.com/2023/08/07/writing-a-check-for-zero-irq-error-codes/

 drivers/net/ethernet/realtek/rtase/rtase_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 585d0b21c9e0..3bd11cb56294 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1828,7 +1828,7 @@ static int rtase_alloc_msix(struct pci_dev *pdev, struct rtase_private *tp)
 
 	for (i = 0; i < tp->int_nums; i++) {
 		irq = pci_irq_vector(pdev, i);
-		if (!irq) {
+		if (irq < 0) {
 			pci_disable_msix(pdev);
 			return irq;
 		}
-- 
2.45.2


