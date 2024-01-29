Return-Path: <netdev+bounces-66794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DD2840AEC
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 17:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A6528C4FC
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 16:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF49715530E;
	Mon, 29 Jan 2024 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0djxLq/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826DF155315
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544667; cv=none; b=Pt0E8q4WX/+nlnxxM5AyQfMAoPV4TNrUbSzyRkBrc2dgRKiMn//bBGu44q4WlgTvJNYhoVWtZWtFW1c6ReSOOsz1r3TLLHEedIoBQu88LuqyaVgbZ5ikGfIoOcOqYryCsv+/bf8aOJkCe8bpm6GVhcGPKpvZ9z/DrG7Uik1ZyOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544667; c=relaxed/simple;
	bh=7/pkoIB31RnP/BFRo3uwRe6tZEJPIzei79uUoGIC0qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6CrRr5pxS74am/oXFNgTupSjehMGSiAfNgpIaaVCGdM2uQ8wFvgQca9+EM0erD8IMbv4tocytXi76da+SKtUiyAgRASVHIfX31/NwiPYorL5XPNmQXHJcu4oombehwsm/QD2panxBVirK5lKPL5USTozbTbsHgaxkeB+bqLAU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0djxLq/; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6de2e24ea87so573482b3a.3
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 08:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706544666; x=1707149466; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o7PYUWiqsb1zSfjWHETqhik/5uw/thvb/V9wubr+ozo=;
        b=E0djxLq/sGHi08xni/ynEGA5nBXB1e4cjtYcXB35UCnZr3N651zT8S3nD9MyFK1mZ8
         vXhj+k2iJx7oKysrsDoNp6Gmy82hIjioyb/OYan5/rwRA8fCiHRJEbnrC1Q+Hbmzkdzb
         hYTUTG2aD3drsNgj9UO8Lmnl7OPJ4nouxsaRhIZ/sEsxaTvIiaXvxmwbitzFjQ2+usmT
         GZI6WILyXnDlzG34Tl9rmIzajjtJGpaCDZ208N1MADQWv3MYnNaNyPF031v4KQk8gL2k
         A+vyb/TuYDo8rVnhGGyUHEF3Xk0qfwZAK/pV/VocO186Sz/P6S6wSy2OgX6Nyb82dFYM
         JjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706544666; x=1707149466;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7PYUWiqsb1zSfjWHETqhik/5uw/thvb/V9wubr+ozo=;
        b=roXb/bc+Wg9C33HiJpzW5k5B+7okymPwdGIWVXxiOqb16vpgdXCaMfcNXX9SlX6ZyQ
         2yzE415gb/F85zBQEfW17kbdXyERn9UHw8pLHQl4CoXA/L4qTWPw16k/CiH3zYLVuEkd
         VcxHaAArqt5b2Kmrx2EuXJheb9kxTPYhKaLzjiPosiGKprJt2CoUiU974/mCU9Wia8nn
         aunQnMJuplmMfEZebUppqBIJQkWD3QWT2wjfWl+tY8yUpvNlBud4/bimZOeAsrjEKqxm
         fvAFo1cDypcit/4tkhyDkXF5WCTKFO4t/J1ny2djdEWF+IGpskmO34GyJGbVGLdVULgi
         CEnw==
X-Gm-Message-State: AOJu0Yz/zx+whugGfHSA3NEmujPaTP6G982kLT8cf2p5Qwpw/4kXmMmL
	llzuUZJe2RTLYlJdXSxpL3ltMKJc+UVKLDrr/fHtLetT9caqhpc9
X-Google-Smtp-Source: AGHT+IEOUAH8cHGJNALnkqQH88qFF97N/rwZZLEGJMS9+L49fyhBh6w92vV07KViwaZM1ODoTdSA8Q==
X-Received: by 2002:a17:902:820c:b0:1d6:f263:5699 with SMTP id x12-20020a170902820c00b001d6f2635699mr3206701pln.30.1706544665759;
        Mon, 29 Jan 2024 08:11:05 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:ba1:8853:5abd:d9f3:2a01? ([2600:8802:b00:ba1:8853:5abd:d9f3:2a01])
        by smtp.gmail.com with ESMTPSA id kr12-20020a170903080c00b001d8f82c61cdsm850632plb.231.2024.01.29.08.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 08:11:05 -0800 (PST)
Message-ID: <adc078dd-9085-4a46-92d7-38983c59cbe4@gmail.com>
Date: Mon, 29 Jan 2024 08:11:04 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 07/11] net: dsa: realtek: get internal MDIO
 node by name
Content-Language: en-US
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, arinc.unal@arinc9.com,
 ansuelsmth@gmail.com
References: <20240123215606.26716-1-luizluca@gmail.com>
 <20240123215606.26716-8-luizluca@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240123215606.26716-8-luizluca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/23/2024 1:55 PM, Luiz Angelo Daros de Luca wrote:
> The binding docs requires for SMI-connected devices that the switch
> must have a child node named "mdio" and with a compatible string of
> "realtek,smi-mdio". Meanwile, for MDIO-connected switches, the binding
> docs only requires a child node named "mdio".
> 
> This patch changes the driver to use the common denominator for both
> interfaces, looking for the MDIO node by name, ignoring the compatible
> string.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

