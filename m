Return-Path: <netdev+bounces-68870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE74848901
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 22:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DEB61F22D55
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 21:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D75811C8B;
	Sat,  3 Feb 2024 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGsJbjqb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4D612E5E
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706996446; cv=none; b=o67pq/d83JTygZ9QqbZLulOlMoLqc6n3MvRPZdv68dMdE8hhlYFJnZGQ0yyjRzobXDgQB+lmhJlUtyfMcmhvqj6PzzoiZmcbfaZe6s71r2pv9iu+Ia7zN1Eix/Kw01l7JyaiWfMOEC+gZ5vYXyzt4m9DGOfgkcMA8P83SN2hUjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706996446; c=relaxed/simple;
	bh=KPfVvcYcQxNSadI3OnN9vqbE1Dj7KMsiqKNKP9VM9eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJHZV5QebLak3Ws02wis7aJ0lzb/00QrFGSaabTPJ1UG6YHPv+As8oROxW3schjYcGrtdHmCTcWb6dP8x5B43sVJURY16BOUCxZqevemc7rlhP/sumamwnwl7JgrkX05QDk+hv08uxNPk/WE+prkFiaVFphQgWgfnr7JN7g0S2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGsJbjqb; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6da9c834646so2563878b3a.3
        for <netdev@vger.kernel.org>; Sat, 03 Feb 2024 13:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706996444; x=1707601244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=848N9Pc2A4ZF/3fbl1PHER1ZeqHYE8bth3ix4nZ6vew=;
        b=FGsJbjqbDnxKTiJ6L5ob8/7cJ3BstNREk2H8Y4xYkVCGhg/0Y019ClX6gc3VjvAuvj
         cx+Thr8aMCv2Q/ax+mglNUvBcdPgi6r62xeOObPEiWVDyEjPJawbC/srd9mMU+x41rSr
         WYPRm48nTmhkMsTY0iX56WxaczwkLICILsKfknqhIalJ+FpwoJXZ0wIt88w5de1iC+Z8
         PmuuskSInpbxgmIdixpWGvUGCuuchI0jNeyZL5UhKJ3Wq+cD++loritGl9eiuMrzEt4i
         6CqDMcpmtxKJm/80bj1rXa9takG/HseiBeyucjgi9GW2vJXIyxd85OIVVfUmSQrkPRAB
         esYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706996444; x=1707601244;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=848N9Pc2A4ZF/3fbl1PHER1ZeqHYE8bth3ix4nZ6vew=;
        b=ap50MrswQeoqpvL/dX1HpjAwrCBXbwCNmzmnH0eqfToCpOJWCdc4Gl/RAUIX3lz8ie
         o6sD2Vs2RsTH5TvMw0Bte1Ck8AKQYAoj/ZcVfvTF77SuVEBe6+dx6QONeqyh8wtTKmSm
         lOaYnAly23OE3kcXpdBK0Bd8T5gIfOWc5025oYpta63ERXXMTGaqawfw6hHaU24GuEX9
         GRzdQRUtISz676kkPvduxtd3ZoBvB4U4Q7JbKyPs0JG69NN6XzAMU/YKWIdhH3HxfiO/
         9WD8B3BmnrYi+RwBTdBXU5HQQ/zdDVLt0X7S5mySp9JqIjpTHznI2Q5LAgP2ZVKDE2pf
         7f3w==
X-Gm-Message-State: AOJu0YxTvIgV6v7jhZNWIZKp5eYmasMs4gtFVJZhJLXJmCnEnaOMO7SW
	WGVTuv5fDq1j3WiFuFtVkA1cdsk9khO/se+wOikxVmsChkGkNx3x
X-Google-Smtp-Source: AGHT+IHG2VVgrdW+h3Bmo+nKXSAvSqjnoCUsFTNiuyhhkncziqgPjMgJ+uRc3QKEube23G/xJLNfGA==
X-Received: by 2002:a05:6a20:9c8d:b0:19e:4a68:46d0 with SMTP id mj13-20020a056a209c8d00b0019e4a6846d0mr6743462pzb.60.1706996443703;
        Sat, 03 Feb 2024 13:40:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXRKcj0+mm/zP0oLY73yZBWzH1VOAy/ZKOs/tJu2wI1xIXKkGzeQjRM1N5RPWWV7q3eR2MUoedCJiia5QSwQ3dHVd0/WzLyu5FZLqtyAlNTAsAVuVnAdN6F4n16j8l32Cn3Z8l2PD3dZJpnh61DIk6sP1NLGaISSr65fzq/kS2xfxjPnRV3bwihq1GIMcPyMoyR1tiYfu7aXQOH1bJMKTeO/bZ8iarclU/5qVP596CSnigiOQ445NycC2CXFyjeuiRunlBq3VlyvA6mtJMtIdrihvejRr+DhPQ=
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id q11-20020a63e94b000000b005d6a0b2efb3sm4095519pgj.21.2024.02.03.13.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 13:40:43 -0800 (PST)
Message-ID: <339dde78-f8fb-4d52-b148-b9fb2340eb07@gmail.com>
Date: Sat, 3 Feb 2024 13:40:41 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: phy: c45 scanning: Don't consider
 -ENODEV fatal
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, Tim Menninger <tmenninger@purestorage.com>
References: <20240203-unify-c22-c45-scan-error-handling-v1-0-8aa9fa3c4fca@lunn.ch>
 <20240203-unify-c22-c45-scan-error-handling-v1-1-8aa9fa3c4fca@lunn.ch>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240203-unify-c22-c45-scan-error-handling-v1-1-8aa9fa3c4fca@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/3/2024 12:52 PM, Andrew Lunn wrote:
> When scanning the MDIO bus for C22 devices, the driver returning
> -ENODEV is not considered fatal, it just indicates the MDIO bus master
> knows there is no device at that address, maybe because of hardware
> limitation.
> 
> Make the C45 scan code act on -ENODEV the same way, to make C22 and
> C45 more uniform.
> 
> It is expected all reads for a given address will return -ENODEV, so
> within get_phy_c45_ids() only the first place a read occurs has been
> changed.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

