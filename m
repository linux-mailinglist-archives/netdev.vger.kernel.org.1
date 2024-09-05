Return-Path: <netdev+bounces-125623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B1896DFD7
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 18:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43AFA28D63B
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 16:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386BB19DF4F;
	Thu,  5 Sep 2024 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ro2BdDp9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DDD1487FF;
	Thu,  5 Sep 2024 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725554007; cv=none; b=IOmuvwldhhhXqlIjzpUfSv19fYOUyQtZWrEG2mbiS9xis6vkpZ9p234QoMoaR4Yt2E7ukBk+z3Eav6tiPBCFkw5gT9TcGTo5s1bODyXqM75JJbrZKWpcpp7bCDXQdBkVH05y3I/XtqpvNZIPZRRV5s3wjB39y4A7gm4a4Pz3Ffo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725554007; c=relaxed/simple;
	bh=wEMceimxJHNv2zuW5H0hOUsHDPbnyCz3+Fa+k7WGkR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MNGnD6RkAR7rw/bd2uYBSb2pyIJ55i4wyASwTY79lqjiQoFvNVB05yckiU1ZXTRJZoS0XqK35ZIMcp84ulG3cN7DW06UTlQocfPlsK8hUn0Bdx//QIehz5am+xYnp+zP+jURCh8k3UHhCVp23tczuDVae+K4ZRfAsdFQULmVMW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ro2BdDp9; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e1651f48c31so1219293276.0;
        Thu, 05 Sep 2024 09:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725554004; x=1726158804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LTWgqh5aVPRNhnctzqq6KL5x4HBngQvxkP/ZwnzN2WQ=;
        b=Ro2BdDp9rDmKDI7RVzCC7IK3XVOOZagg2+JNBhSSrUk8+S25yL1Ax8F6v/Lo6m2oIX
         X7DOZjka5r9xVGBBjw7kUMIhU6XpHOyJEkmCNsap0HUeHIiKPI2Ip8f+645RfpjK+sGl
         Q7qkrwlOgmm1UoVyJ988KjBVtALCLTOv/jCbIp6sL2ghhS8Fae5R9Vxhv0gI2Ug1GV5A
         TxHYu+Mw8OpDgf/LISZHEimcGVAZRNV5cUcbsgVfjDw9HpWMxcFt2Hq9YxMt8WH8I0W3
         DyZP6MLQseI2u6IDrjzfjMr0DgBWHs2OJHl4DVEemlvHsFVbhqyNzQEJeLpB6hkf9fOS
         ewww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725554004; x=1726158804;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTWgqh5aVPRNhnctzqq6KL5x4HBngQvxkP/ZwnzN2WQ=;
        b=Vt/QtE3l6+Duscg9N+7D51GUhjXHlqm7gFU7rZz8xsnQMvP6tNRuz8XJyel9jNPW05
         9UJNoqEXk83It4l2aw2W/ptSDBfv4qhm10JJIBJKC7U7MGVv7Mv01jCB7coo8qn+9EPD
         rFJxvzjxgAymBHR7yzaIamxij//CLBXbqV6MwCtZkryT6iWSQT9HebFlzcnrWi7yQSX6
         6hTgwX3FE+rAcIyG5wxUQMSb06fxB4KP+5FHTFpXbJq5zQ2+JMdXfGEphawRKfZJo8Ly
         12rojLFqN4mDTaPE9K1OnF5xJrq0oFUV9cVnhFbCxrxCTQOFo0RchBVurrR3J7fXP8h0
         BXSw==
X-Forwarded-Encrypted: i=1; AJvYcCVgr4+WZ0WgM/+GVtjA7WPSobZMHPLcLmUIsORX+oOil5UPdWJqem1fQ5+aEAEx+MDosDsJm3hM@vger.kernel.org, AJvYcCX2CP+NYL0poXXIEdHPFgxfUji6ccKp0tXxXpGdz/8UwKwgd3xhW564PRwFi0lj3E9sJUKxS4uAjR17Z1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP3nMNCxclGWcBzeAGJqF5ynMYuazbFWn53A4E2yBCmoGsP8kW
	nLSIWpF6/1eymAvKCFg37H2wvWb1DJrnt+xGqj6033+h4hDzF9TV
X-Google-Smtp-Source: AGHT+IEMcxlD77tgrm99u5MsQ4wFzjCZ+6TYVifvNB8FvCWzXjN2F9a9Z0zejzTyIg5z07NQdf4uNA==
X-Received: by 2002:a05:6902:140f:b0:e11:706a:bdfb with SMTP id 3f1490d57ef6-e1a7a00a2cdmr22184973276.18.1725554004279;
        Thu, 05 Sep 2024 09:33:24 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801b5a995sm8511821cf.57.2024.09.05.09.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 09:33:22 -0700 (PDT)
Message-ID: <23d937e5-3aac-4a8f-b7c5-ecde386d36c8@gmail.com>
Date: Thu, 5 Sep 2024 09:33:19 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: mdiobus: Debug print fwnode handle instead of
 raw pointer
To: Alexander Dahl <ada@thorsis.com>, netdev@vger.kernel.org
Cc: Calvin Johnson <calvin.johnson@oss.nxp.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20240905143248.203153-1-ada@thorsis.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240905143248.203153-1-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 07:32, Alexander Dahl wrote:
> Was slightly misleading before, because printed is pointer to fwnode,
> not to phy device, as placement in message suggested.  Include header
> for dev_dbg() declaration while at it.
> 
> Output before:
> 
>      [  +0.001247] mdio_bus f802c000.ethernet-ffffffff: registered phy 2612f00a fwnode at address 3
> 
> Output after:
> 
>      [  +0.001229] mdio_bus f802c000.ethernet-ffffffff: registered phy fwnode /ahb/apb/ethernet@f802c000/ethernet-phy@3 at address 3
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

