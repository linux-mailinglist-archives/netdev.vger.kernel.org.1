Return-Path: <netdev+bounces-232908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D33C09E62
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 20:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967583B4B81
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 18:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818532FF173;
	Sat, 25 Oct 2025 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqM8higo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B4C28850B
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761417223; cv=none; b=hx6PFcvq633yfSugffAGbZUMfnnQdTBryVYcP3llU0cHPhC8Nxpn25XZbaGpam9wX/loj3qWwfDXJ/miBp/a+NMqYSkxBk2+QQgQ1Hxfhp3V+2/TTsDN8GzCUsW1JeVliMd8gf3D4EEPUxWSNd5Nnh2RwYhnRzkFKmRWuaO6F4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761417223; c=relaxed/simple;
	bh=F3N43DawnAsIAG4BgMeOr2TY5qW+Lgw1YKiPXGrjB7M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LneqvwRYKJh+Z5p0LyNxO65g/Cy65+At71dzWNynNA3igvzYPcTIICf1bvD/vAq9Da6H98ehRJK8VrLikrqQZK0o7f5s2P1IghdfZ+aPGSbajelYO2v5CNFuZrxl5ZgnaI78hU7IKC3UUntXukqc0Jem0OgbyA44JGCdBX6z6vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqM8higo; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-475de184058so1913855e9.2
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 11:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761417220; x=1762022020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=njapoqUW468MWxICa8jRinTKfR2SVCoFBRR2d+cCtuk=;
        b=GqM8higodEeQeXNHMng+VjQXUj0Yq7ErL/hh88I0O9MwVBf1PocFCzrSv29TCnkWOS
         GSnOxspLVcZ1sKu0OH+8E9ieEJc4S98wtpeE9T2dspZZOMC+fHzUnBq1WFAQVsh8dXaR
         IYZTSrxT4RgGkgTB6tbaPJCywLEsBEoW8tWlMHoZiE5ik49o3Q6oA38slNBJ79xtaprz
         4sq8a8rTZzMuAOJZRdvlifWK4iBSHpZ8KhT8BSq20BPg1ZKivOW1VZK5QZkJZFTOBZQK
         21Tx+12uQuvyBOG0VdJRwRdNQuFyDZscgFqbaAZkI9AK+DlXkGspvE3CJC8STWjUd3HU
         4blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761417220; x=1762022020;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=njapoqUW468MWxICa8jRinTKfR2SVCoFBRR2d+cCtuk=;
        b=NStbEEXA45GUT2ZrSltPc+H4lWp3agCe4eKUiD+IDs0dzvXBIAPVeQt6ZdFI7nU4L8
         6wUR9e4fZ1L8Bak8Fx+EnEhlzw4HwG8pkceRrbZFenbRsnr1lGmNQVNrqiFD0ALRn1/j
         kgya8+ZBpEprq+Xa5iJ3E4iCKFetq94aYuLz/6pkUMnsH+HumdXbNWx5jrXBF3eSsEhk
         X/LfitUff+3QCkl4P1bH26CT0WgTpiiN63F66FV6wAqRK1NZwTRkF6AosDxn94z9bVWf
         Vf/YJLmXaO9WgIJGwM1CXvuPpLVPda/UeYP2Vac8BrngE9CRnsIxf6VfJrUF5SuBereW
         pG0w==
X-Forwarded-Encrypted: i=1; AJvYcCVQsfaJgAj1Az5lqCedTd11jNsmcF5T2E13Ur9LnBhfbuiATXQLbVWpxnnmNRIbdw+sp1j6Ucc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp+01pPSZFQXlE+RO4ASyYSdMSQs7JNzIF+A5ct9FdPX1ytR6Y
	cqTzffxHE7xOa6KXC0zwinc5EyKwyFIaxTBs8cr39Ygv+iM0kyC5w7vt
X-Gm-Gg: ASbGncvsoDIKR378SPoO/2UaCUwTJyBHzQVM74Zwn+4qcwIbyD3ApYzVb6uvluIg35/
	dl1Emip6fBhsrjIZVtaugRHtt21lv9zz26Vxj5CEA4XlKA4sVsuT5EtAgGORue10EO0sUQ6wVfN
	l09YpfurQtTPWIEVbU7Rq3JdRzF/a6Su5XT+/vD/n9/F1RmE5PmlHDhiToT6cIXrVWNElvQCtzS
	i3erbR5kiF1RwzxNmg852vfPvCcoQVDwn52jtC9deQRUbP/XN/TWK/MO6JsnP4+yqvCqU7lrsyC
	6cQEwGMx+Fdqs5zP+gh5xnWowlf4l0/8QNMLAi9jsUytZuVlr7TWvcGYPFBRp4gwiMxvEJtuomT
	o7sFcO1OwLOk8ni2H++eUigFsY9E0aObzWya9ENLa3ZcQWr9kQw9L7f+nPkDR8RiveJQIz32nl4
	wnhNxQCdIyc0yD+VwisNwymXcy9c5+q6Dqm0zERqLHFl7MwHE0NoOivMaZEOWrJ8CvUE2/9fGfr
	vib217oTcbgGa0i51KBccRjC00ywD2q58cFcUapWgA=
X-Google-Smtp-Source: AGHT+IG+DDe5oIMet8KWoLY/Yop7b4xsXXWiOxNNIX75KW86rgVdoPT8ZCbdmaSertyJd08nHYeHmA==
X-Received: by 2002:a05:600c:1c8b:b0:475:de80:bb2a with SMTP id 5b1f17b1804b1-475de80bc38mr21178885e9.35.1761417219771;
        Sat, 25 Oct 2025 11:33:39 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f39:8b00:d401:6211:9005:e76e? (p200300ea8f398b00d40162119005e76e.dip0.t-ipconnect.de. [2003:ea:8f39:8b00:d401:6211:9005:e76e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952da12dsm5012085f8f.29.2025.10.25.11.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 11:33:39 -0700 (PDT)
Message-ID: <2d840dff-60d1-4b7c-bda8-04704fc4c81a@gmail.com>
Date: Sat, 25 Oct 2025 20:33:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: mdio: fix smatch warning
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>
Cc: "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
References: <8335ad5a-f5fa-4fb6-b67a-d73c4021291a@gmail.com>
Content-Language: en-US
In-Reply-To: <8335ad5a-f5fa-4fb6-b67a-d73c4021291a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/2025 9:26 PM, Heiner Kallweit wrote:
> max_addr is the max number of addresses, not the highest possible address,
> therefore check phydev->mdio.addr > max_addr isn't correct.
> To fix this change the semantics of max_addr, so that it represents
> the highest possible address. IMO this is also a little bit more intuitive
> wrt name max_addr.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reported-by: Simon Horman <horms@kernel.org>
> Fixes: 4a107a0e8361 ("net: stmmac: mdio: use phy_find_first to simplify stmmac_mdio_register")
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---

CI complains about the patch title, so I'll change it and send a v2.

--
pw-bot: cr

