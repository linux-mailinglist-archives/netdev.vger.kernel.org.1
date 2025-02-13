Return-Path: <netdev+bounces-165842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C23A33821
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 07:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 994317A1282
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 06:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A063205E23;
	Thu, 13 Feb 2025 06:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bm7bP1ay"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43E6EADC
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 06:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739429250; cv=none; b=dfscdvHujekbZ7YNUz48VA6JAqez5mEU/cX+nFMxFl9+mkUbv6xsxKNe1Lpc7k2EhYm7t6EFWvVSYCBx8i6YSsf16AyE7uI9vh7gyt/gVGszIMGDz1RCHYvG6PjnqkPuaout9HPfGSzgRgmo8GzSM1qgpKnul8W7WMByR73KP0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739429250; c=relaxed/simple;
	bh=WDAGFYBJ4ZWGTYJcXuFI9hHtIY4Hzo5WeLoku06t21s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=EeaBI61xejyzgai34eoeJeJDyxYisxEq8siWVwV15KAPeo66xwsf/YHsFn2V4oY/CGWnm0hNcSURAYAAoRJtxlx1drtvqT0aXXDuktHh76ElDVFv6pxg1zQM+pUQlTdhPgi38kd1nfYE5OaZJQ4k1naQjNsq1UG7Hq1Fvk/R42M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bm7bP1ay; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4394036c0efso2831165e9.2
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 22:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739429247; x=1740034047; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fk1r1bTNGfst5ZFUkTrOxzDNlqTft5Wi5dKa+sgyUJc=;
        b=bm7bP1ay8qYimi/+UkZCGMekTPzfkfo45SUTVPdyHuR8CQBPaTdpU5H8MMEjDoHfWX
         Hh9udOQ8qwV7l+4FhrOLjHuW0IQHE5eZ5cQRx+swBHP29I1IvxlWx9TpyHvopKRb9OlP
         9/JyvwhxLf+9Ao7PSvkx1tNYG+KMB3ctDWo/fkomZEK+llly2tSOUpkY+SaiWw37bOxx
         vHKawUPg/1ClLKYmOUIlwGb0/nzH1VwtvSggKnZ+ptET7BDUNE+1AdWyYPrty9bJcnpg
         SA6ljs7w1BV26FZPkLP0w0ojhJ4hY3/a4sbBTDYuxPm3AbMy8mhJMwqwybKFPC0nlRtT
         CB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739429247; x=1740034047;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fk1r1bTNGfst5ZFUkTrOxzDNlqTft5Wi5dKa+sgyUJc=;
        b=dDnD9+YXkfVhcFDL4ftEuoS5nzUgZk3KaHhcKdRdpoqRS73bw5biHXkPorSNrZK/r5
         /2Gb8nu7VTzGZohi5TB+lAorwO6Z3mOTfn+kpabaJqDwV7CWNvELNQ5N88uW4InOQpw9
         Mb5qM0nVfOmL6wYp8BxzAVCkkgTkAgobGdLNkLwZr0A84uay3cZLsqUe0Jgsw6FopRNz
         9F2qDPd7qFTayn6f0qFjh7dR5nA7WZ0d5HbAyk8ynf2WvfBGSRHa151H/EBu92tKT5er
         i1wm3tzYQyswD+K2pzEJa8rrmqhihtsRG4qdhGUNPtT7XXawrZJJ8i/RDahKkcxniRh2
         iQOw==
X-Gm-Message-State: AOJu0YzliGIP5GGwVb9s6hcQWArPAxoCmMjMPIWglMan8RNN43dKNzOg
	gyLtP16aCgez4AJTGGOt5dBNS1ugcZ4Ryo5sro4qAUsmC6klZB8t
X-Gm-Gg: ASbGncv19j9AA5DfykvzrE88utZOfd6IqLhbomI08oGF8lYzo3BxugiGKoQb3FY0uUH
	zoqoicQbaPCKedUjjZMDGqHTpbTRO77zRenH9+l3YulOVhkJTnsc44P9z8p7oRMVJsNn2G4vJI6
	iX0cHNyfvger9i0bkqDQw/Ar5D62ATBhtpW79We9u2pySwDNNS39pIukcqwnAZiFNzBWdTYmbnu
	oHXiMilrbIJDQywcOOUx6F2dLiX/nFukpeyXRQ0GvqgxOcv5XNw5RI2fuIQAQY+sNq4zAIlWTEP
	kNrFDwFIPbkqfg5d04cdyoReQN6CVs4Q9wOShdBlBfbuToPoqRKHdTCLHx5yP4L8BBI9V6vTPVd
	DPkiAWDQGfiGdn+hf0JWb7+wX21TOWOncx8OxT6PioUn8FCmsFEjrghVNBjvk+qriFa9SsXa7nF
	bpgN9s
X-Google-Smtp-Source: AGHT+IH0q/xqq97L+F6xM2Fd+VdVGhnHcvS+6pLS08jcKK5hbFmv5reiBQv/SpjNofT8lUr3adByJg==
X-Received: by 2002:a05:600c:1c1c:b0:439:3ef1:fc36 with SMTP id 5b1f17b1804b1-4395818fdfemr57498335e9.18.1739429246786;
        Wed, 12 Feb 2025 22:47:26 -0800 (PST)
Received: from ?IPV6:2a02:3100:9dea:b00:8068:750d:197f:b741? (dynamic-2a02-3100-9dea-0b00-8068-750d-197f-b741.310.pool.telefonica.de. [2a02:3100:9dea:b00:8068:750d:197f:b741])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43961826cd4sm8372235e9.24.2025.02.12.22.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 22:47:25 -0800 (PST)
Message-ID: <ca05b98a-5830-4637-be72-c11d7418647a@gmail.com>
Date: Thu, 13 Feb 2025 07:47:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/3] net: phy: realtek: improve MMD register access
 for internal PHY's
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The integrated PHYs on chip versions from RTL8168g allow to address
MDIO_MMD_VEND2 registers. All c22 standard registers are mapped to
MDIO_MMD_VEND2 registers. So far the paging mechanism is used to
address PHY registers. Add support for c45 ops to address MDIO_MMD_VEND2
registers directly, w/o the paging.

Heiner Kallweit (3):
  r8169: add PHY c45 ops for MII_MMD_VENDOR2 registers
  net: phy: realtek: improve MMD register access for internal PHY's
  net: phy: realtek: switch from paged to MMD ops in rtl822x functions

 drivers/net/ethernet/realtek/r8169_main.c | 33 +++++++++
 drivers/net/phy/realtek/realtek_main.c    | 90 ++++++++++-------------
 2 files changed, 71 insertions(+), 52 deletions(-)

-- 
2.48.1

