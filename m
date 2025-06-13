Return-Path: <netdev+bounces-197636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF69EAD96AC
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 22:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF8E3BD413
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 20:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AAE246BA9;
	Fri, 13 Jun 2025 20:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtkiJDzp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344DC1F3B83
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 20:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749848002; cv=none; b=gNeX2LBuc67HIwCepxrYP9Q3h01e743qcUyZa04J3zvGh/NAgbpzFceuDB13zlRPzqhcEdRRDwVIb94ENo3TfwXLV1NLY5y+Aat/RnN+zAMLOgfOJJbcEVAJ2dtUAXPkA9bddFn0eEQOgaMKAC+tUJmE8avbfOffmmXPU/VFxpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749848002; c=relaxed/simple;
	bh=yfjpJWtuDDRQ789IooBVdTd45W+nF73VrRcfFngwiMM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=ZLWVIaVOamD42gIApRHVTxavdLj8f8v+Hg89uYkhKNTNDbp04oIAtLjVJV2g4z0uqMQLGkLww4st/RPD2aMpj4g30K4GnDVXlMyaxuRkrvy7Q6L4lhV1O4SWjnz8IyciO+XLDB5wjulCgseGPnXC8Dby8wh5cR/kIqdV0bbQZiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtkiJDzp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4508287895dso23329265e9.1
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 13:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749847999; x=1750452799; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rNPl4w+dnoAqPvL2Gw4RJB0Ld8PczbAojgreqQwlxPE=;
        b=gtkiJDzpFdaLGl7GVsa+X7dYqALNXPd0k0gc5oqD41Bg/LAn6zWslttJFmhHt+DREr
         erropr//Kzy2MDkcXkhSrIwkx/AT4Px+rJWQcXF/Zrf/diXD1R/uaZj4nn8t4fu0U0Ql
         NQ8HQsbo5moTLmyTRzmbKkKdho7TVuIqBaBEc1EP0aViR4XZTi4kObsD1+vjkUprfH6/
         0t2R5+MU1U2nxsQiR64AOq9m5FuNU3SShI+/2XSN/AXJ1pkOrFA4+Q5xztwx0CcHQKJk
         KUw4pyHrn41XiMMBKeedSQAKAYl+RqIOv24yS+VzsFH6fdHsW/QfN+Bd+W/BOQI3tnYb
         m/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749847999; x=1750452799;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rNPl4w+dnoAqPvL2Gw4RJB0Ld8PczbAojgreqQwlxPE=;
        b=fxNYDXb/58y8KTXFuGRxPg6A3zIkYIkrJvNqN99TlEVk/CEpDggvVeQC+9mTp2q+JD
         GM/7EuPFVc1uDwmWVSLFFlpU3IjrAFFYmqTIcVnFXmpmT8DVwruIjvg1jslLepgJ0IR6
         2xZdUYeIfzoZ+9ikmfo6v8lYXTODCTmJQHCJTKjrDdauosCNfQLDMRQ54XkB7qbYdqnO
         FUkrFs7EudJ7p5KGe21pjdUB5EtC9DjC+UsImxiNz9RG6Z3T0p5df2UVrfqd15eIAGLh
         shpYWeQtoW2VyngKlAX68fUeD23AioSVNvhj5a92qIVtK/mszipRmR4u0NdqoMMM3qrU
         vHQA==
X-Gm-Message-State: AOJu0Yw43KlcWLmhdEtDJp8cjYrR7hM+6RG+wiomHfuxTUMzKL+T3ZM6
	7KMDNdw0Vc6YKFdmzSDZFOJv6760Zohg0y/vuM12/11qebwt/p8RILDr
X-Gm-Gg: ASbGncsfJUA9mRqgyvddNaxWo6LRh0LjAAgoBb86OyWz7OaW9RaKGiKdadcfh86zQsB
	MB9baF2d1GOvn9ftZBzaaOfZszRLizCPqtdNsrKOVw7cVMlI4fgQz2E77foVynuGqjGIIN9qO7X
	3c3KwmfcYtaKX8KmCkDdA1B6W0sNv2A212uE0PfY2PdCPxY53TxyVLKB5iyRbG9/pqHyJyLrE/f
	6OfRsiXM55HcLAeobpe+Fz9DVI1d1VIYfVi1SjHn4o7EswuZfbqCpyAQACoAOq7BTS7PRjUiUUG
	K+2XFQgJt6zk3XPRKUN8ZSt5Y6unTnsjgjoOvDl4//xEmh8Fu37lHx0ySzOmH+8yxAYrQpiTcNK
	v8Jq55fAwP8WQNNXXroN/maxKJUk9ZBqNhqSuG/Zsl1uhXeDTC0oeAoGal3WpCgaZhAD82m6YC2
	dSVymtLHHoKVGpyZUiDfIJGLM+qQ==
X-Google-Smtp-Source: AGHT+IFHkK73cL59PDFOgnIV0IjUOLejqIrsT1DygLq7IXdNgg/haou61kf2yIgBxu2Bor0WsQ2i+Q==
X-Received: by 2002:a05:6000:2c0d:b0:3a4:eee4:cdec with SMTP id ffacd0b85a97d-3a56d7bd571mr2409710f8f.6.1749847999161;
        Fri, 13 Jun 2025 13:53:19 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1c:2700:11ba:d147:51f7:99fa? (p200300ea8f1c270011bad14751f799fa.dip0.t-ipconnect.de. [2003:ea:8f1c:2700:11ba:d147:51f7:99fa])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4532e224617sm63523975e9.2.2025.06.13.13.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 13:53:18 -0700 (PDT)
Message-ID: <8bcd626f-a219-43e8-a0c2-aa04148d046d@gmail.com>
Date: Fri, 13 Jun 2025 22:53:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/3] r8169: remove phy_driver_is_genphy and
 phy_driver_is_genphy_10g
To: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Replace phy_driver_is_genphy() and phy_driver_is_genphy_10g()
with a new flag in struct phy_device.

Heiner Kallweit (3):
  net: phy: add flag is_genphy_driven to struct phy_device
  net: phy: improve phy_driver_is_genphy
  net: phy: remove phy_driver_is_genphy_10g

 drivers/net/phy/phy_device.c | 43 ++++++------------------------------
 include/linux/phy.h          | 15 ++++++++++---
 2 files changed, 19 insertions(+), 39 deletions(-)

-- 
2.49.0

