Return-Path: <netdev+bounces-243305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C331C9CBB1
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 20:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE3D3A879E
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 19:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6F82D3A6D;
	Tue,  2 Dec 2025 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbvhNOR8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B7E2C21E7
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 19:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764702664; cv=none; b=U1IbhR7O413l9NEZGDroSUgtf1KjfkqWdSvr8vg59KMLayXVUewNaHLkCG4ywFiscwba3YJGPJBB3HUjvQpGA0F61GtnSoYwXtY4g9P6nWLqAU5tAQnOUyzH+hmXEQ3ejElU26rrK9Ckz/F/oCjChHWltOUibie+fXHPI1Lx2yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764702664; c=relaxed/simple;
	bh=Ae640Ee86InL2k/ZiK65Gw8rrEj5J518vdVt9OblFCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kcjvQLTfRKsJdYQwWUANNInVrD4DwKBYMzhZFTyUWvU27ox6fWCYxiJcwhCt1s23TaCL8/z6w1LQyf8L/6FF+b/AaBxOLXUhQVxJA+EJcyyhK36loLA/9DcOn69neq9Zj8xzo3mCucpymHlo53X9Kwu7DbCojvGzBTnR25jkex0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbvhNOR8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47778b23f64so34435685e9.0
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 11:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764702661; x=1765307461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/FUr//0TUGWxEnNiBNXorIHtkzvmnOQuNFmiIiuZ+wU=;
        b=lbvhNOR8ET50v2g2b0aRDV7qtOIz9mTJrKQKrqUSVLPijPTRgcXa+fPWo3O/QMMeKi
         MJJa7KqElvc11XwtIxU6Xp6YZOUCvNOP+oltVqVpT730pHy6YAdOYaMp1YlMVSgNaDOM
         jIIYIGQRBfozBVoThrxkWVTwWMqAzrLiSsc4u7I0UzqWAueT4n03kOHYzuHe/l5utKCr
         giO4F8htRyDRtiLH0uU3ejGOIzebG3TTp7gpzeRgZ9J/rdRvEaIXVCW/EP2qqrj9fXKF
         WweJCOonObmhAcEXYjV+30OW/xwhAEhJ9y6n2PlFLWio6hfnDuCMtwoGzZRN0j5YSsrG
         4WdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764702661; x=1765307461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/FUr//0TUGWxEnNiBNXorIHtkzvmnOQuNFmiIiuZ+wU=;
        b=fzbjvS2T1ZFMptL7MscYPZpUAW/tlPzJLX+qKpOOdNElrK++4vpAmABarNp5X8z9GN
         fJIDHkVM1eAoNgcUqffe7F5sxPjcdXDpIhp43Po4+qfjGJRoHQA0THVzl/NTopcYNT9S
         DnWzekiW5/T+iKHns7JKi9rTLRLDXZN/H3J/IY1eJXJAxkSaurzqVtDz13ffhC4x28xf
         IhtxNSQ64IiZm/YdPQVve9vn0vkkRmIOFQDggMmDjK7Gvianmzj3K4MvbW4D+QnmotDl
         w4tAs6vvJT8uq2e8OmRSMOKUPxbNZVE6dz2DQlea1ktIzfZOQcY8unclPhWuLCS15+8b
         o6+A==
X-Forwarded-Encrypted: i=1; AJvYcCUtvk5L4Y5/YHITCGspTbeWa2A8C4Jxjdn0V+VXVCpOh/dzcg3CcgyaKMELAT3leAjYrHVNlNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4G7NHHuLTLA6++Elr2S2Wx3P47AINh4q2LfytzB/r/6lVyOvu
	OB48Yu21jtCcsQKKhNtuODJmbQ0Wo0OKuUyZEMtIg3XaHiHNMiAb0VAk
X-Gm-Gg: ASbGncvlrBFahc2Ls/g3Wx1JMrKHyZnss9zFcTW9L4PnlWyRfp44jb3zYX7lekvNwNN
	cztPyrx37Y9m2FiIC8D1OVJOA4WgarF0eNPRi3v4sPgAw4r6SCHQjHGp/+dSJh/X2aJiGOt4HrI
	SnhNAr+H0GRp+5RGw//E5Fvs/v5UsesVD9Y9hk1A2Sdhe037ABdn09mTRbehnO1CmlDFJZIp38X
	hfVhIuU9km+D+f0CFyNFbrzeb4NlgIJl7QesLesK4bEDW5Y2KfxNZW/Pn10uYwSuhs/R8GjNWLP
	bG9NhP33JlCorgnJyTDH/sClYy8NfofCYQWJmwIIWOucUmBocfSEIdGXhwBt+RaWjrmOkGZI5kn
	AoVbWUFuAk8XuIvMmX6QEtca/5DlGFA5V7c7w1/u/5Dt/jkbN6/xZVqDGsow2BA89JLJmXNnlgK
	C/3KpUHOoCizUyPhPhgQZQhkSUM/oPC8GqXTUHUxSfNKMrwKSFR7NAu0Q8l7fpfip7xT0stEh8Z
	Y+McOQLwlmBMkBfaxJgl/WKgDygylavCq1dQ1hNYN2+I2p921Lv9w==
X-Google-Smtp-Source: AGHT+IEgZF6obM1hz4fa+Aa1eE42zQzGnr5+d/JhxTBfn+xzybZBw+XMc01RajHHQ6tlE7TseQ1RDw==
X-Received: by 2002:a05:600c:6304:b0:471:9da:5248 with SMTP id 5b1f17b1804b1-4792a4ba83cmr7942335e9.26.1764702660647;
        Tue, 02 Dec 2025 11:11:00 -0800 (PST)
Received: from ?IPV6:2003:ea:8f22:cb00:61e9:ed14:30da:92bc? (p200300ea8f22cb0061e9ed1430da92bc.dip0.t-ipconnect.de. [2003:ea:8f22:cb00:61e9:ed14:30da:92bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792a620b13sm3397225e9.2.2025.12.02.11.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 11:11:00 -0800 (PST)
Message-ID: <82984a56-5bea-48ef-98ed-20d83377808e@gmail.com>
Date: Tue, 2 Dec 2025 20:10:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2] r8169: fix RTL8117 Wake-on-Lan in DASH mode
To: =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?fran=C3=A7ois_romieu?= <romieu@fr.zoreil.com>
References: <20251202.194137.1647877804487085954.rene@exactco.de>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20251202.194137.1647877804487085954.rene@exactco.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/2/2025 7:41 PM, René Rebe wrote:
> Wake-on-Lan does currently not work for r8169 in DASH mode, e.g. the
> ASUS Pro WS X570-ACE with RTL8168fp/RTL8117.
> 
> Fix by not returning early in rtl_prepare_power_down when dash_enabled.
> While this fixes WoL, it still kills the OOB RTL8117 remote management
> BMC connection. Fix by not calling rtl8168_driver_stop if WoL is enabled.
> 
> Fixes: 065c27c184d6 ("r8169: phy power ops")
> Signed-off-by: René Rebe <rene@exactco.de>
> Cc: stable@vger.kernel.org
> ---
> V2; DASH WoL fix only
> Tested on ASUS Pro WS X570-ACE with RTL8168fp/RTL8117 running T2/Linux.
> ---

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>


