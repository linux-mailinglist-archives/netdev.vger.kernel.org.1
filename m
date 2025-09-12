Return-Path: <netdev+bounces-222412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D43B54213
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 07:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A771891490
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 05:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ED019DF5F;
	Fri, 12 Sep 2025 05:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huTI0XAZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120BD9475
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 05:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757655059; cv=none; b=AvcZXjgt1/reDcoci2EIZ3NixFLDwlZUL5OWjUcaQBvvr37L52Gxm//rIh9LgmDYlUjPGpBYv+rbLpOzKd6bIJig9VdlWAlNfWdUnHTYTMO/fJAsgLHkFxrZ3TGrTk1e4Z4UD2kkZpMqfdC7R6sw2mFAAhDOrLdINR7QPt+HK8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757655059; c=relaxed/simple;
	bh=W+OSo7LmQWJRP3NNZ9QN0GsDiU1D26WWe3ACou34Zco=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=h2XXdM79EpOspGHRTQUD3Q9WqXGY8a/M1E+GdY8jRnxyAiQo9ncqoNGpAQWGwdpy34kZrUptnOa51TTDoxHUL9Y9V2U3WP9qYuJYH3Ma5KBQrNnPzDanDBWbh39QXZI9fxoQtsTQmqBX6udmjmHnJUeABKQXI0Vz5LiHC5DbsyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huTI0XAZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so12757555e9.0
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 22:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757655056; x=1758259856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JEFCSKdbKEGUh5juYJLQeJKaHw2t8ajiIvauVo3QkOo=;
        b=huTI0XAZDHIoMsAQtqrdUo2kRgh8Ha3ZZMSn9FklB5nBXpNpcRsjTCcCKnDfXQWa9B
         6Y83EDSsMjg6yP09wYbwzEHKw+sVNgIvQH+lmOtMZVVc5KWQjBy1SdSUziUB0ICL5ucE
         b8pplR/0EzLFpi8D89JhHj2/OYzY1FM45o4zBwVrPsf7KtiDZtInY0SMD7v7mmwT4jTY
         cd1c4o12Ye5A8DdSiUL4lszUqxU0qefVSnflhqMQcpmQJBsReg+oK/JCX697WACO3n+d
         M782Pb41jF6I5CaXBYUWnd4278DV/85Hk3lOns8u+uO3RMFR6IBMY1qCqiTG75Pj0Q4H
         9anQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757655056; x=1758259856;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEFCSKdbKEGUh5juYJLQeJKaHw2t8ajiIvauVo3QkOo=;
        b=GoxnG70RR7Rv0iiMfAWFBg0jwyK/nNATPJN2D3+3C0JT6aYQMCLLYHBs9LdFpv0bWL
         3ZzVDVFq+kInOOOS4eGFtJTbsqkF6mnhpyY3N/3Iu7pnf98R0FEuBkK/yO85gD6Q1VCp
         XvF2dsseiPLlVc5HpdYPDn30Fp4g5t5P9ZQK1YvuK/Jm6H01MRpBum3pHX50j+N9w5aJ
         aAuLzon98lJmjHcHR4gm7BoWGcRtuH4g62CrEfN1Qe7plhYVA0W7zU0bfOhjyFBTkozg
         htA+P1RR/OoM71Zq5FqpZFNvwhNrICkCBoWOA/ZemEhk74z+czroJ5fZytxIWoFxBPNr
         M5Ng==
X-Gm-Message-State: AOJu0YyNlIyBR4QpgovFUHJO9vj77ZyneRIRFF2LbRJC3vlP6leS6NbS
	yVhKMQVLmlHa4NXBs2Nw3FVBwZULvfKyfZi4gM0rSB7M51h421PdXjHktzU2gw==
X-Gm-Gg: ASbGncvpRTWg4b/5CJpobvmTNpadFA7nwOoPeCIJk5vWO1DKY5ypkYn+r6DNBtIxZrK
	K0s8bXuZy6DjueqnwQ1afWRCRBOWAjZJ3R00de+HvkzdmRxwlYoA3+3z7iV6iv+gSDW+iTpRMqi
	aCFCAxOFFD4+HLRluPO0UnuMZp2vB/sVFz4rXsrnJKBM3Qm6D3vBqastySKenVT/QzgEZabG9G1
	Wo5Zf4DTmB06al6qPY53cDuIq8PCJKYR1L8C/vrAeIoncf7CgPEDXgZTEB+oxHaAVQh04W4zTFC
	2zscfTXFItuGMOf5hKA/SpBjzGA6jS2AAbG1g7AlLoaB4jnvczCOcgORxKWo5sASKsutAgewPmx
	PGlr55YkA49pCZ8Au4XV2y4ISChckthDe5izSzQzh9khzpVR59euyGN/afWFM9DIZj8xsM3jPsL
	kgePkKTUpqEPYhDdU42K38LHh8VwSmyztHhbyKMrbnfm9/GnbPvrOY7+9nKR6nLA==
X-Google-Smtp-Source: AGHT+IHUS5sQ+/dG+WaqckPSPNKdHzAb4MDrBjNZ7Kk3Lx8pckUlxCV1ey1Y1oQGQD/zKodkm5liGw==
X-Received: by 2002:a05:600c:3e1a:b0:45d:e4d6:a7db with SMTP id 5b1f17b1804b1-45dfe9c6a1fmr48539435e9.5.1757655056044;
        Thu, 11 Sep 2025 22:30:56 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f09:8900:19b4:30c1:b5e5:56a8? (p200300ea8f09890019b430c1b5e556a8.dip0.t-ipconnect.de. [2003:ea:8f09:8900:19b4:30c1:b5e5:56a8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45e016b5cbcsm51851435e9.11.2025.09.11.22.30.55
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 22:30:55 -0700 (PDT)
Message-ID: <c651373d-374b-4a67-9526-1555a11cb8b5@gmail.com>
Date: Fri, 12 Sep 2025 07:31:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/2] net: phy: print warning if usage of
 deprecated array-style fixed-link binding is detected
From: Heiner Kallweit <hkallweit1@gmail.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <f45308fd-635a-458b-97f6-41e0dc276bfb@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <f45308fd-635a-458b-97f6-41e0dc276bfb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/2025 9:18 PM, Heiner Kallweit wrote:
> The array-style fixed-link binding has been marked deprecated for more
> than 10 yrs, but still there's a number of users. Print a warning when
> usage of the deprecated binding is detected.
> 
> v2:
> - use dedicated printk specifiers
> 
> Heiner Kallweit (2):
>   of: mdio: warn if deprecated fixed-link binding is used
>   net: phylink: warn if deprecated array-style fixed-link binding is
>     used
> 
>  drivers/net/mdio/of_mdio.c | 2 ++
>  drivers/net/phy/phylink.c  | 3 +++
>  2 files changed, 5 insertions(+)
> 
--
pw-bot: cr

