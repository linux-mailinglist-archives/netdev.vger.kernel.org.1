Return-Path: <netdev+bounces-231816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 369E2BFDCBB
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 20:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D6E1887101
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EB12BDC03;
	Wed, 22 Oct 2025 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkWCRWn2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52F535B120
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 18:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761156961; cv=none; b=e93e/spjnT0hS4Lxzk+2JJJ+fzadUwX9ikVPJ/YGKxmMCmGjN36HGcWFHEKijJJ2N93Q8EbLFN+V7XEcUv3H/430by7gZqbccTVCvbiJPknOD8NHwzr3244DpIBW+/pPAGzZiKBbALO7L4hXe/rvLOAV9rSEsllRdsuFPpj/HZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761156961; c=relaxed/simple;
	bh=F/FQ5YUWu+YcwL0adkw4aV8mATYP6rRTj+QeHmQu/6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XkABE0zOUZmXz6F96Uk1Sp7iDe+JpGbTe5Qk1hUYLLCSpfqZsgL0p/8iQldZCZwCIOYkBfAGIl9aP+yNXQz9p6H/3OBsJIuPISqeQ3OCg0yD9gf82tYRLA0o+L0KQZuKZCGcPYVFKkvNiE0waXwzgyJav/ZASci/wpMxL/yBIAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkWCRWn2; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a213c3c3f5so9340944b3a.3
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 11:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761156959; x=1761761759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9QGp0U/4pbaeep/z7J48UOg7Dw8fa3jK3AlCVPGVI18=;
        b=GkWCRWn24QjuLWoF0aAhBNpjxkwYzZ01z5j5TAAjg+CFLm/jMwt1vaOCIWu7YNNREx
         oW3OG1UIyJMloZsHjhKHVygHrV1y+3Vm4AgO1xSQnbdMD5L+bB1MEYN9mgQz3Ll9FJVm
         5o4KqP4uaVGKlapznEwMJQMEHjGFY3jrhLy4nHjCNaKyPFKaYFkV4Bee0D+O6l9h63yF
         gymXaJyNmbFYGHcaCk5MKo644b/Ak5L2FEPodwk7daIA3qzqe7mlujHmKYqB5c5ICmCu
         XnPuyoSQImCuuX62Cxa+V9AUvy6ZSbuYL38aTM1CfT9R9ZiRk4zPb93JuQ5daXsiy926
         aZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761156959; x=1761761759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9QGp0U/4pbaeep/z7J48UOg7Dw8fa3jK3AlCVPGVI18=;
        b=rqEeB+/WLf5CfRVP2B1RN9eezjr/ROKWlEdQ8cAfHw5b81/CDgDXz2/ledq+xnDnH0
         Vn3mP+FBZpOK0+NulvoS950IFXhcyUEi2n6A1TXgVgKsO4+LV3rgfty4/KroOajfqTrg
         IitOZiyuhT40SfjY/2SoKEiJhaCDjXpydvceilbYyYmTONCNuVvBaKmANUmYO0cE/GQE
         lYkq+G6DVW6XgYER7+ksQI557UWFzw+PFYeIQ+HCLXvr7e3OcJ/tOIy+IGy4lUiciUuG
         Z9g+zA3FN98cM6TkQhtkIzJj6v9/3ZKCCeDivSOL6514rWJX+4uUPKCFOx0lcSpE7Jif
         U2gA==
X-Forwarded-Encrypted: i=1; AJvYcCX3HqOsD2nTfLqM7bFTdb3fceRIuYe28S944VNquOv8YbGIogYiT3Zd4MvrclbGQ6GFqg+HoSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7eiDDaFNIuroxzxgU2v2/xJsJ+9yAfpV+IOxf35g6i508Vg8/
	zIWTb1SWAnV75HE9WXxHClyVKRJvuLu8uSmpX6p6VKPYdLvlhXomLjeR
X-Gm-Gg: ASbGncuCN+mf2qzmKWCqQD3NqbkWOlDZkRyEDCFx9aa7ZLcnv9WhOIaqj9xeQDfeEEz
	JRwlRwJby/AO+B7k5dTWtSN24RHkzAOlZweXrTMJhwzNruBMV6nvO4U55C9e0QYvRN/742Q922Q
	filtiG4VSYfWQ/S6cOFgbLt4a59kISbasC6WvfWB8B1lu0b4KASHB3rwsegOq/PX8xEZIBqNdKd
	C6eEGdMhQoIKEqMNSKftI63DmLkfVlZ8P/HvleGwqVVy/GUqU+J28juKnlPBWezx5DhI15+veg6
	9AEqU+C9ADJhotBhR2jkLgzRrx9+VbWHON8mbosPSpRDPYZG5kWt8GyUckEiBqnqCtXPBiApYuG
	jSPl+umaE9LtSGnaeagRQLHNZ3X5fEJIBAURScPgZcV5cTs9o8N8k3PucRjvurt6GhtN8GZ1IEm
	28f5AaPxQ1+WzGTu/mIWSaYv9xaV4=
X-Google-Smtp-Source: AGHT+IFMLQ6LX3tUc8TguSda9gIy2Uw3Gh8Ff81wUitAtyD2okPrCzKkucLqxqPjpTHJn/jjBsd/SQ==
X-Received: by 2002:a05:6a00:8d3:b0:781:24cb:13f4 with SMTP id d2e1a72fcca58-7a220a95434mr26308242b3a.1.1761156958833;
        Wed, 22 Oct 2025 11:15:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a230121ebfsm15114561b3a.70.2025.10.22.11.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 11:15:57 -0700 (PDT)
Message-ID: <6a962d4b-f624-4eac-8a59-5472fb82b591@gmail.com>
Date: Wed, 22 Oct 2025 11:15:56 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/6] net: phylink: add phylink managed MAC
 Wake-on-Lan support
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aPIwqo9mCEOb7ZQu@shell.armlinux.org.uk>
 <E1v9jCT-0000000B2Ob-1yo3@rmk-PC.armlinux.org.uk>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <E1v9jCT-0000000B2Ob-1yo3@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/25 05:04, Russell King (Oracle) wrote:
> Add core phylink managed Wake-on-Lan support, which is enabled when the
> MAC driver fills in the new .mac_wol_set() method that this commit
> creates.
> 
> When this feature is disabled, phylink acts as it has in the past,
> merely passing the ethtool WoL calls to phylib whenever a PHY exists.
> No other new functionality provided by this commit is enabled.
> 
> When this feature is enabled, a more inteligent approach is used.
> Phylink will first pass WoL options to the PHY, read them back, and
> attempt to set any options that were not set at the PHY at the MAC.
> 
> Since we have PHY drivers that report they support WoL, and accept WoL
> configuration even though they aren't wired up to be capable of waking
> the system, we need a way to differentiate between PHYs that think
> they support WoL and those which actually do. As PHY drivers do not
> make use of the driver model's wake-up infrastructure, but could, we
> use this to determine whether PHY drivers can participate. This gives
> a path forward where, as MAC drivers are converted to this, it
> encourages PHY drivers to also be converted.
> 
> Phylink will also ignore the mac_wol argument to phylink_suspend() as
> it now knows the WoL state at the MAC.
> 
> MAC drivers are expected to record/configure the Wake-on-Lan state in
> their .mac_set_wol() method, and deal appropriately with it in their
> suspend/resume methods. The driver model provides assistance to set the
> IRQ wake support which may assist driver authors in achieving the
> necessary configuration.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

