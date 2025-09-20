Return-Path: <netdev+bounces-225011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EE4B8D193
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 23:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A497C1F01
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 21:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD32217F31;
	Sat, 20 Sep 2025 21:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dv8jMxVb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F4D221FCC
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 21:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758403889; cv=none; b=Du088lUMZtSums2plQ/wh53aMZhrWDyr+csgtQK8o4ddDyz3czoPsfwcP4BWumYjO1HngwC0tXsEFRYLIKISwV0HSo167RGKK4ySVeBbjDalksLnkC6O34cGjb/Yihvl+0EtNuHGr66HW4ABLJv41JCP9UxzPNZKIl2R1Wld0R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758403889; c=relaxed/simple;
	bh=62CeYkzFXK4xBZyBijlZFoAzDSnn6XqnmKuy+kgqL5o=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Nh+4zJm4Bfxc4aAHwJnwub10CUwZjEB1w7vZQS6biFqLjfvSr6/kNQXX186ouCWFIk3jw/kcuVHOI+jmSMUhl+GUFjdgT0oeH+MHSdrNLPP/klwgZzdF01a8ktl0jCY7dVz8dcNYrHLTesrMD3AEXvwIDtHyq4u8SFc2NsHdRuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dv8jMxVb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45f2f10502fso20894285e9.0
        for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 14:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758403886; x=1759008686; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4STzZZy7IWBaTAZ+TnjfuaGvwyAS+vLKT0end00Ujgs=;
        b=Dv8jMxVbM/TyqwEHeufmg0MaVb5Utw73I5kUfAyzFVnbhQwZBfIEuevQmqAHN0mIWH
         xPa6SPpI6NuvYwLXdR+akr5rgXwCeabPpuEprvy7Q2mRnJjHOVItZfCKy4l2mJctDS4p
         5bGEoUFXgTX5fjFOGK8ZQLjzJ66oIwaeAwRL/nH9sZAZFPYURiNtIAP4mcVuV8eX4zbE
         F/dFVwDqs4csaIaS8NTX1OtsM4P+RfdVN6M9zToJX985sl5RLWr+FVoRHRiyKY+5O6v9
         444mhgfWuRQxYvukcjoZfPNQ9gkognlZ+kpDcKgdwp7zI51nghqwY7qkLQF1D+dwu3+v
         j6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758403886; x=1759008686;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4STzZZy7IWBaTAZ+TnjfuaGvwyAS+vLKT0end00Ujgs=;
        b=FcHKpj/YR9l+pZn0oLlEMvH5zNUngIS8fB+gIYgVuWQQAISp89jZ51m+2U165R+VmD
         ZeKNoID44wnCJOQHVt9aZSS0Kt3XrMQEKXpGzuIm1aM+cFho5iLKRrSARGDecb/E5hJK
         IdKWWNGlHGTPcycqu/5l5CXbHiXgswCvcIyKUZTQVkM+1YOsBFQpMwwwmg7dcoONStqe
         guYRSQl0Gc5tu9p8syoUEbpFLtpKP+6cVHItfnA6LfXrSkfcfjKNcnpARqW4Mw17BrCK
         Haadq7NaU1XROCc4ZF07Cro4KwAQPnEouWI/h3Y6VTOwP6KztSzkSjPJhAsN4qvBFKAy
         nLOg==
X-Gm-Message-State: AOJu0YxlF5RogYkrvqcZM9jnmYWE1cFlFw5DVCvEzYlJrXQTbQvYFStn
	eDOAIkfpL0F5vF6lduNZ9Gh+6kt/7vC4a8hsqEjTybwjiMyRxdgmhl5c
X-Gm-Gg: ASbGncuIIn55R4NNe8Qng+Ymmq2EoNQuOP3hWA7KIuhycu7RGfuB2LxufSXmN+xGzgD
	bNs9ITH2wQbE6fX67Tvu5EgIoIcqWOuG9oKdi51zyJkqjrq9E/g3+97WgBQTMjCustMfG1A+l+Y
	E3cIcKZE+x/VFyHD+FE8o/BBZADvmkuMMQYMdD9Gurx5Ni4lTU40Ej6rtKhHog7wX79r8PzijOL
	fDegE6FFHnKmSYWD/4RbDbdjhsp9iUiB+KNKv0SprvcOhnWPafxPXyAB9IXGkLOEtyo9pHaYFXh
	pGqoFswLqlYMydeMDMpGDLGeVMwdmdiTUi3MK5p/qigaS/x/Sgb7Pw9pYhFhQ2B2598FN/Rtxpa
	+goGPhT8sh7lUZH+RAgz46EG+BiLiC+NpHggANJJ36tdvNYti/eNNaCb/DXe3zzggpNKroAxwi3
	vXJj1/rZGI22Tta2ZCremyr13pKY00i1Tq7ypwLoKA2RCwUExaREebRDf1Tl0=
X-Google-Smtp-Source: AGHT+IGPZx6T0e+YCLQoCyftCY6VADCmhDAfKD3hH3UqURdGMV4KPo+dJXF/HxNurL5LO83GywTuIw==
X-Received: by 2002:a05:600c:5490:b0:46a:6e5f:203e with SMTP id 5b1f17b1804b1-46a6e5f22a4mr42447805e9.23.1758403885702;
        Sat, 20 Sep 2025 14:31:25 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f30:a300:65ae:147:ed4c:62d8? (p200300ea8f30a30065ae0147ed4c62d8.dip0.t-ipconnect.de. [2003:ea:8f30:a300:65ae:147:ed4c:62d8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7460sm13510378f8f.31.2025.09.20.14.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Sep 2025 14:31:25 -0700 (PDT)
Message-ID: <b86c2ecc-41f6-4f7f-85db-b7fa684d1fb7@gmail.com>
Date: Sat, 20 Sep 2025 23:31:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/2] net: phy: stop exporting phy_driver_register
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Once the last user of a clock in dp83640 has been removed, the clock should
be removed. So far orphaned clocks are cleaned up in dp83640_free_clocks()
only. Add the logic to remove orphaned clocks in dp83640_remove().
This allows to simplify the code, and use standard macro
module_phy_driver(). dp83640 was the last external user of
phy_driver_register(), so we can stop exporting this function afterwards.

Heiner Kallweit (2):
  net: phy: dp83640: improve phydev and driver removal handling
  net: phy: stop exporting phy_driver_register

 drivers/net/phy/dp83640.c    | 58 +++++++++++++-----------------------
 drivers/net/phy/phy_device.c |  4 +--
 include/linux/phy.h          |  1 -
 3 files changed, 22 insertions(+), 41 deletions(-)

-- 
2.51.0


