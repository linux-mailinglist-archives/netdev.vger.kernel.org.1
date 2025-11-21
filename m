Return-Path: <netdev+bounces-240714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A47D0C782D6
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 10:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 387D7348A8A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 09:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0143314DF;
	Fri, 21 Nov 2025 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6tLm/OH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17B63242D6
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763717751; cv=none; b=n+A7hN1/qG19C2TklO5oC5IsJhhof9RK/UeBk/hXPrs3PG3FVIcQcSAn7UnR5QpXsrdomr68a2HnUBdZfSbG5fnrkUVey1skCmNb2XR2tmQzJqm2x4xSk4m0IMejbymN//u3kqlOQ9sTxQcvTXcuk36fE3AIRCYxvy4gBcWctCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763717751; c=relaxed/simple;
	bh=OPCBn6Drfp3sY/fjk4q6O4wPZDIz9pFy7sRArzF5+8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uL1uRjTa0+3q2R4UD5jEgBiuh8bbelp35Z0/XGIhtgRcf26SnCQABq6U83YFEYQel0HEAvwS5e8zRWozIDIIKnT1eCxrDPgR+wnRCIqjV2HsDRgVHLOgU7VDWKj1hZzi8IDm8ShVr3RfQ3X45mfnWrEKUE9erXp6ZmtIn6WVL6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6tLm/OH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso19749655e9.3
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 01:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763717748; x=1764322548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HWnMXybjdArIiL4MOeBg0Ibe66YlQ9mn3F1o9l3vga8=;
        b=h6tLm/OHCF5usRbn8Qip8tIQigohapNZvoHkKWddr92w5rzAENqdf206R1+4uzCaH5
         WbtA/Mq9rqfpiuVN4hwCr6PjdDhljOw9Kc2pNBJ6lxGT4D1uzITX0KFr1Oe+PAoXPTSm
         nsLaQRlSpbLWgsshGMsSo9Sw9r5Bys4Wj2h975SwBEN3JBL/fxkvqWr//3lt91wKsS/s
         Dw5qQwo+kok9DYGDdAQie368zQjbrJ1wokI8cboUWUs+gFN5+84DIWsSUaqeFXL3W9om
         7nauu6osE/3/mMVslVDb8/+dRna630undrVQOYtUE4aNHN6Bjhg83/FsYWquyq7OBLxG
         9axQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763717748; x=1764322548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HWnMXybjdArIiL4MOeBg0Ibe66YlQ9mn3F1o9l3vga8=;
        b=l0TCF0TMYGFIoPjrYEC0r+OSci5Zez3+4k06q75vQpMRzXA8QZ982bfOTzHCchBkhW
         BKbwObPZMwT71yQ29VDDblz0DQY4CwQD13y+D6L/nMsoFkf3ePYZmcnSzpi/+jXAoM5C
         0A4nQxiU+3y09UGIMcnXGfQzkUSOaNMxWd+TEoAEz1EPdWWuyPUFNQPWdgRViUnIuNFx
         1qqqHH48Q7DAnw1GCnI7weoeZFdbiHxMydLy0nZBhaRlz+dYBSfX1Op5+9+x/2BnFgm5
         ofUiTXjN3cIamC+aeqxNKvRL26GmpM8qQXI3FKhVgZwmXD/kho+Urb9wX2tXOOGSuxGZ
         3rIg==
X-Gm-Message-State: AOJu0YxxiJs2RC4nQiYuKLUrXii+O+kAESO2twblGRClw9iXtgxWQFAn
	peScn7RnemfEv3LtDbrpUb++4p/wKzmDLkT41GKQSUheiCbboVi2+0Ng
X-Gm-Gg: ASbGncsEvjb4z6Z3KS5rA/DBZc4qXaGrSQ4mwaEiDmacmxprtLEhnz/nhighPjrXOIl
	jgvLYyzZXqYPV6jKDWfw2g8DRojcI1XefYj5oWS2RmmuiKSYILPTRaaV3YtoOphBRf3M0eCmC2m
	Vv7zo/wQrtj4bU79F7yTld61sJtF59Lniutayu+VGdfKHFsF3Tm+Wjsfjiy+ONwWzINWZRMmDMx
	G5BNPxIIiBVqpwOFsJ7OQlI3uVsOW3nkn6NwgByEYAnEyfbh4lxPq3JfQXrIfwpTWQG48XtLO/m
	OeGX2e1DfT6qF4bXmtrfEuqf287jEypnq5V9nkKHOaWmEcxuIu2MIPteFO689YzMWIWxXijZhGx
	aG2aY9u/I29/n9fR4kdhlv7K4TvuQlp8/Bs/LsiP6PXCsw3Cfc53HILIeSQmnORqwTVYVV8ovIw
	SKsbv5jvbkYA+zdTmtyKiaQ69eL59eVuUSkCRf7ZTXboN4zBmpn5Blbs0KBZDAJYDl1SwxdU4w1
	PBFZIRVFQ8spT76FB/rqu5Nq3Qb9w92f40rntaZyk+FigvUPpK9Lw==
X-Google-Smtp-Source: AGHT+IGBjyCfMXD4YewuoNcrdxHVPV4+/0BNILOsI9aVDwncHqg5Jsxdzw5SY60jDkZfYYkMTHtzEw==
X-Received: by 2002:a5d:5d83:0:b0:42b:2c53:3abc with SMTP id ffacd0b85a97d-42cc1cedaa5mr1377013f8f.19.1763717747789;
        Fri, 21 Nov 2025 01:35:47 -0800 (PST)
Received: from ?IPV6:2003:ea:8f20:6900:9d47:8de1:7320:72f5? (p200300ea8f2069009d478de1732072f5.dip0.t-ipconnect.de. [2003:ea:8f20:6900:9d47:8de1:7320:72f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa35c2sm9193090f8f.25.2025.11.21.01.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 01:35:47 -0800 (PST)
Message-ID: <b047e84d-4673-4461-bac7-4a862e06c9f3@gmail.com>
Date: Fri, 21 Nov 2025 10:35:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] r8169: add support for RTL9151A
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251121090104.3753-1-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20251121090104.3753-1-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/2025 10:01 AM, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This adds support for chip RTL9151A. Its XID is 0x68b. It is bascially
> basd on the one with XID 0x688, but with different firmware file.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> 
> ---
> v2: Rebase to master, no content changes.
> v3: Rebase to net-next, no content changes.
> ---

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>

