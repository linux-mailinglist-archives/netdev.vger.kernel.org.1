Return-Path: <netdev+bounces-190614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62890AB7D09
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 07:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002991BA0A3B
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 05:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF752222AC;
	Thu, 15 May 2025 05:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Np7+mz2t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AE04B1E71;
	Thu, 15 May 2025 05:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747287473; cv=none; b=dlItItPJNrC8VnnIwUnCRJk9hsr1mqGsWUQRxRdjRQ+vGl+p159Jsj2ZSngtoquXPEE0HgPfu9JDT35K2NBn3a7ULpZC5YjJVX84QVPxD0D09erL+jZZ+7t/HQHsPXf4y5vvMeJg+iq0rK1Uo/ZJubuIAAKNj+AhVi2OdS+Rnlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747287473; c=relaxed/simple;
	bh=6NVXZ10Q6b6GO2A1IPFTcO2JpK4ofT0DOfPRbqKvEwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1RciRwI1LEiI89IGXlyfXl3dkQjoHbATdWeEtyos8khlaMH7iJ1YSTySo4bS0Qia9R7tVGcnf870TgzjaEVrGhOKGCdxWujmXilrLR5PDCOgyS1/0Qhb/LkZBEIrTd3kWMmAIocTRc6AgmGHlOJ4Wq4ju4uWQyBTYrAG1Z5kc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Np7+mz2t; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a0bdcd7357so381014f8f.1;
        Wed, 14 May 2025 22:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747287470; x=1747892270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jLQbrlzIKJ9GtoyXapCMIV3uHOh2ro9yNZ/nGWGAtAo=;
        b=Np7+mz2tUWkQs363vNoNxpTFg0UDOPrTYbFWU5igprm7NfbkT+BlV/ODj8KLNmsgGE
         xJKOiCeFZOgtjRg0TXigQSJxzN6JdqnFnIU2O6XZTREBjpjLd9tc44I42JqNRTuqybDu
         TYgl8l4YVFCT3qYY8fRt2jcZPcbHoSbf8HJudRhU7oc/JadpkHbTFQljMOJHOpsd4h7u
         BnN/nMS9r9yuKwBq+c23ZNFelOnWNR4J5LNqLqJBsA9Fq8aptiAQr+8vpXPaRL64XiLP
         Ao1xQW/KLPvOY719IFUZFOfT34hQtmVgvHHxVxjOAK/HJtyUc2DVwpeXfG1hov20WieH
         oHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747287470; x=1747892270;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLQbrlzIKJ9GtoyXapCMIV3uHOh2ro9yNZ/nGWGAtAo=;
        b=b6IKUcwBIR7P2M7jyeN2E30l8xuRUmrO+s93DUbLf6mjLXj8WoGgjUnRGzd3Aj7bxt
         B0rxK/BMyEi0Z3QY0NBPfxMLXWxiSeNq6Tp1QiU1Ua5wIVABOUUcwEhLM6HIQ/KSHbp1
         ozkTWUm8dpticqCaOH9WHSo6dxZi6M9nOvGo4IdcfrcRWCJXNstSprVwwgQpt8OqfcMs
         O+WfXJW+2WGyhN6kINcUTP0kBfKlLb/pUohb8xpVrs69NMQuNiwazwyxPKoM1qcoO+ri
         AQD0KWBM7DeGSzMhXf2lAdGq5j+safBAdWpMgSRUv3A5lH7UTHZYwXBna74YP8X4S93s
         VrRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8KLiNPN5hONoi2kMNj7hwQWw1Qz2uXLtKTiz2gxLy1DvIyHYi90WqD49z6GwYrVO/+DiRUmeI0p5gebc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwELJQWBHEQTBmPHMQzFHUDr4RXB9JEsqIk/TO+0OfdKo1s0gTB
	8u1SwZ1pr2kq45sa7pw+u4BbV0mIsGYcOBFlGMez4jlrim7fn8BK
X-Gm-Gg: ASbGncuzzyir1SicbdqF9Bbwt2TsRNopvO1K2OcNKm2hdzAKdZBBX0OXdcK/l46ZB2u
	7+4deIGl3/4DpPOZzKbIIRRq9DyTVLQiEQ0oqu3X4Z54mVIsl+Ldef13MXaL+yZDH+dmRujthET
	C7nVKFsz9N3FmDCKmRAVGnrEbU/uJP0D4OgUGokssuXr2x1PJbccexWBXeOswTfNYIFLEV5BuL2
	UYM1Yf2jveno9VbXpXEZhQi7hRrdyHsxxGViwGUa/Vdikoqjnis5BW6400R7MOIQ6F6NJvakMhK
	JVvBHrJUt4dX9n7YCUgE047Dz/7gcWlU4szFomSdu7jCPDmPxb58wzLRqRrVXanarL7wiXBhdQo
	skIOecgkDTH02tw4q1hgNy7PfhoF19FoH6Ot9/8Kr3l/Qay9dVnngCFB9vZ8H0EUnoJFe+jefuR
	1g8S4D88UT0nsj
X-Google-Smtp-Source: AGHT+IErTXvS2SE7y6pQ3wyruYB6th+GwJj/HVQhxLs3zjSkwgpPKSNq9XmSwptXnPju3it7n1QgeQ==
X-Received: by 2002:a05:6000:2489:b0:3a0:af31:ec76 with SMTP id ffacd0b85a97d-3a34994cc47mr4930553f8f.36.1747287469972;
        Wed, 14 May 2025 22:37:49 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f4a:2300:108a:494:9658:90b2? (p200300ea8f4a2300108a0494965890b2.dip0.t-ipconnect.de. [2003:ea:8f4a:2300:108a:494:9658:90b2])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442f39e852fsm57752395e9.27.2025.05.14.22.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 22:37:49 -0700 (PDT)
Message-ID: <9c4715cb-4b7f-4c0f-8170-da7a9daba7ec@gmail.com>
Date: Thu, 15 May 2025 07:38:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v4 06/11] net: phy: Export some functions
To: Jakub Kicinski <kuba@kernel.org>, Sean Anderson <sean.anderson@linux.dev>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, upstream@airoha.com,
 Kory Maincent <kory.maincent@bootlin.com>, Simon Horman <horms@kernel.org>,
 Christian Marangi <ansuelsmth@gmail.com>, linux-kernel@vger.kernel.org
References: <20250512161013.731955-1-sean.anderson@linux.dev>
 <20250512161013.731955-7-sean.anderson@linux.dev>
 <20250514195716.5ec9d927@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250514195716.5ec9d927@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.05.2025 04:57, Jakub Kicinski wrote:
> On Mon, 12 May 2025 12:10:08 -0400 Sean Anderson wrote:
>> Export a few functions so they can be used outside the phy subsystem:
>>
>> get_phy_c22_id is useful when probing MDIO devices which present a
>> phy-like interface despite not using the Linux ethernet phy subsystem.
>>
>> mdio_device_bus_match is useful when creating MDIO devices manually
>> (e.g. on non-devicetree platforms).
>>
>> At the moment the only (future) user of these functions selects PHYLIB,
>> so we do not need fallbacks for when CONFIG_PHYLIB=n.
> 
The functions should only be exported once there is a user.
Therefore I'd suggest to remove this patch from the series.

> This one does not apply cleanly.



