Return-Path: <netdev+bounces-157533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE6EA0A98C
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 14:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B171B166027
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 13:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38951B0415;
	Sun, 12 Jan 2025 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtlcNNJB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2399C175BF
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 13:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736688651; cv=none; b=Tx+Mpar7qikfEnQnyE6v31kQ+N3Jedx2zqzq1pF3p4HmtLZ/SAaN+5dr9H4GTFOnhaonuWaqLM3nKstZQoDYRhPfcvsr/lR1isQM7skbtnXFGKiRK66zhanISnURgDEVm7xGaQqj3XhcfaovqJCZLU1R5TQCbxS/TbNL+pgk+24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736688651; c=relaxed/simple;
	bh=jPx1NDxNEud4owSbvYgV5w/KsZRT+U7tOEdh19pm1Z4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mnrlYcJ9XHNWR6MgyUTlP2n9ZxDPZsGhuwlom9N1uMxDXRSPWMtbItzx2rOl3vK352HeApJO6yaqe6VAxVN1T1KNyjOZoeDKt9yYwN8UawuRBJsgv/UZmUlopoqb5sT5fIqa+Fbnob8g2VH2oaONMhXSHbNeZi2mvt6oZfByvKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtlcNNJB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4363ae65100so36060545e9.0
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 05:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736688648; x=1737293448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D1GoVZaTZhrjTjAe0U0XKWytSXKvgBIDeabv1Mucsks=;
        b=JtlcNNJBbMUQJX7Kp2wXb3XbcGPYlgdjdqTpPSMEd4qP7f0mxiJ03jR5onA0bnFDuS
         gRrGqjq4E6+ESPe+m1qpFlqskICVE7FBUFYWyFwo7FkqHC+T6TcxxDH7MhXkdwlN8HIM
         H2AWsAn8Ojt0adlAHPAcU9O41w1Z2pYL+ntg5Tp0IWaNeQjmp9PuHnJBoCyTe0c63woV
         QcjjML7VK55spq5bpznvcFpydQG+ROnbhy757P/4jjp0jDzt52USKvJBpCD9w9bC2GK6
         Mft048OGncEp4zrEskYgneiElZDitap68RvWq1rBii7fD977SWf5la4I6A2M5EZfnYkY
         hEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736688648; x=1737293448;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1GoVZaTZhrjTjAe0U0XKWytSXKvgBIDeabv1Mucsks=;
        b=n+Cnl+1cyQotXbz7IABBvzVf0dM6YnHtAsKnp3Pk50W1YRr7+jY9Nu57l/pzgZHDfl
         jW6SyJ6PEQeBjEQWzHFnfQi8EPtOPP4/i2YmXi67jMktfqEX2xKGlv+gySU1pMxaYkrU
         qa+67Akg+Qw7m7dOrgg9PPJthqfIoqgYEy7xqXmivRvsKVMQcq9xHQHCQpCG/1gbE1jy
         wUTd7uQOoFa1Mb8+QzKcVEeijWmvVDKcJ/S7YJOFxsJCPYuH+W0e+Tyt5n8uiSa6XIA3
         hLxn/R6+BHOWEJBCImGJYBzYet0veY0jQfigPlyk46kkYeILVD72yy9m0JPzTMC9rM0A
         gndA==
X-Gm-Message-State: AOJu0YxRORMc1fDGNlyQgkMEJMi2pFROYSmyl9PbIu79GYdVHyzZ9RAf
	XA1QXSMy0RGLe/jreslgM8V+l90k/1zFU+/y+OZv/JmABhwORBYY
X-Gm-Gg: ASbGncu87HGEnthXT/fK3NDYDGh4SreKSgQiThl1b4ngsIxg++8AqcFJG88cANHvmXm
	6kkyXDyb2pIE3JVwTNbqF7eN4qizZODerEgdfWupsFihX8emUjX0nMgYLtu9/rUahmB6effZM2f
	+kjCx1SLfgbJo2zb/xpC7ztxmWkLn1L6MvR3qwzve4WrtUnvPpdXXWkL/Lf0N2giqSAbQF7huno
	9G/kG3jifKztww5zoUBFZVX5dY/xnDMcWq7dBz5St8j/dIVuBBe5CcCuZnH8qkp3iQV5+SLFW4S
	Vc1RNUY2dn101BzjxAk07R1PQJGMmxkdUpBgahOsR5wvCEeB0qlgt9UaLK6O3nzwgynGEbuX0RU
	Ev/mxTCaH9YThrtVgKsBKXfWPmqzbDsmUpeNkEG1E2hlnL6/I
X-Google-Smtp-Source: AGHT+IFZ2NA3WrMcep7HTitCK3uk0msrnZRjo9p50aB/zwrqPfCPIXyygZliW53Caii1dVtS141pWg==
X-Received: by 2002:a05:6000:186e:b0:385:dc45:ea22 with SMTP id ffacd0b85a97d-38a87338d84mr19290549f8f.39.1736688646778;
        Sun, 12 Jan 2025 05:30:46 -0800 (PST)
Received: from ?IPV6:2a02:3100:b0d5:ab00:44ab:526d:76d3:604a? (dynamic-2a02-3100-b0d5-ab00-44ab-526d-76d3-604a.310.pool.telefonica.de. [2a02:3100:b0d5:ab00:44ab:526d:76d3:604a])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38a8e37d012sm9638367f8f.8.2025.01.12.05.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 05:30:45 -0800 (PST)
Message-ID: <6ea44ad3-3600-4271-af56-7fedb90a9f03@gmail.com>
Date: Sun, 12 Jan 2025 14:30:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v3 05/10] net: phy: move definition of phy_is_started
 before phy_disable_eee_mode
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <5e36223a-ee52-4dff-93d5-84dbf49187b5@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <5e36223a-ee52-4dff-93d5-84dbf49187b5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In preparation of a follow-up patch, move phy_is_started() to before
phy_disable_eee_mode().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/phy.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 7138bb074..ad71d3a3b 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1318,22 +1318,22 @@ void of_set_phy_timing_role(struct phy_device *phydev);
 int phy_speed_down_core(struct phy_device *phydev);
 
 /**
- * phy_disable_eee_mode - Don't advertise an EEE mode.
+ * phy_is_started - Convenience function to check whether PHY is started
  * @phydev: The phy_device struct
- * @link_mode: The EEE mode to be disabled
  */
-static inline void phy_disable_eee_mode(struct phy_device *phydev, u32 link_mode)
+static inline bool phy_is_started(struct phy_device *phydev)
 {
-	linkmode_set_bit(link_mode, phydev->eee_disabled_modes);
+	return phydev->state >= PHY_UP;
 }
 
 /**
- * phy_is_started - Convenience function to check whether PHY is started
+ * phy_disable_eee_mode - Don't advertise an EEE mode.
  * @phydev: The phy_device struct
+ * @link_mode: The EEE mode to be disabled
  */
-static inline bool phy_is_started(struct phy_device *phydev)
+static inline void phy_disable_eee_mode(struct phy_device *phydev, u32 link_mode)
 {
-	return phydev->state >= PHY_UP;
+	linkmode_set_bit(link_mode, phydev->eee_disabled_modes);
 }
 
 void phy_resolve_aneg_pause(struct phy_device *phydev);
-- 
2.47.1



