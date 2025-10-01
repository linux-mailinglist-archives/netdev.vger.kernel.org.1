Return-Path: <netdev+bounces-227430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A70ABAF184
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 06:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080CB18884AA
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 04:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527812C17A0;
	Wed,  1 Oct 2025 04:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cvrd7fu8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4B642056
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 04:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759293450; cv=none; b=RYHnc8lsLlBdtlezK8SqsdMcoUe0zFYjnCuwpv00qzdUqkWIZMpawl15FIiat9MkRTcDlMqG8JoAhZhaXezxftbZIzZeg0xSy8BYstW1d0BAt1X+16ffQ3cTKwYMU4mlRou1fdLgPq7+rWyz95EohpqEEyDomesCKPDTeYKgQ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759293450; c=relaxed/simple;
	bh=dCaRnTDskwqEI8sV8rq+5asgm+ypdm2aisI3BH6Ws4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gynJZ9qVQmi86gP4rI954w5WqP+zibdQlgLMYkxzdN3iQWEgMfVEVvHP+F+UQL0MPCRrRHsuLb45T5ICiVt6fjQWkdOfDZhZ0anWsZoKnqOW3duVK8fx2w9oTtSx4bIKKnW9/DrHkY9yUTbBSuNLTWDqlfVa69XBl/4vHZOtO9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cvrd7fu8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33255011eafso6810138a91.1
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 21:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759293448; x=1759898248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MPq6uQImOLbVbQ5YyRJgD3fiIsAq1mSu/jIrrDsClYI=;
        b=Cvrd7fu8b7mqS5IM3RUXwPXn7V9QtEHTglZJ3IixPd9nveV3KsMjd5nD/VXJWTRfrx
         78Mv76BDDawn0HsLm9vznnZZY3xBdQnawgz7PYtc3VNbJmtBOynCdRVbdsNsQyvyJQnI
         1AjMXTXGB43A98GJmdiNw/0bM2Pv9V8itAg4JEv0r1VlMQGjuSclL69aIGweMVteX8n5
         ZoheVGieAXabYH2/kfDMVctZWUdqXY5Sa7E6f/0MynjHhzO9/C38gmibkN/qc/AUvX5n
         RbEIMl2j1CGosDyEiv7SMW0W6pAb+5ros9QnSxSzZJLOUVWO+y6h3fDQ66VldH0kh9NO
         5r1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759293448; x=1759898248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MPq6uQImOLbVbQ5YyRJgD3fiIsAq1mSu/jIrrDsClYI=;
        b=XZVYH2ajudWd0JTaWZh6zDx1fyo9zZO4odQBHTlACZ2ti6QKOSlSkSU291gjtmf6fl
         scZeweG2pHO8I+QNFyyIAC22F9u5yaiXJEXeJwpRtOJ2nO3u2gFPL5ZFmvK7NwLjhB3z
         5lsUOx55xrivCiYCSMt6ryIvqV7FkPkFZwKytwfibY1mkzktXs9UbXoluVLBxXPhl6op
         +KamqxtX2yEuJi1QoeG00cDvYmgaeE2nq9wG6v1zxjQUH7KXljlxLdAInip11pX2pL6S
         Sqc5y6XN3bcOjk8lB7uowLWgePsDLkV/wH2FOKYgSkhqIUJtVhNT0ReJosCXxIcpvDAm
         U3lw==
X-Forwarded-Encrypted: i=1; AJvYcCXlSLZ8S99mHlDmtT3wt8ZSckyGwMg3kCNsRWxNwzeNfeqTddCnHVyh79uk3sG0/rSHP+zc6Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRJM5L/ByhGC4xN8R+1VmiMb9R+PBaF2Si2HVw5CX7QQr+aW6i
	lE9Cvv4DyCCISIeR+00py+YJRfVXZiqPjrlXJ4RcmZr1B2RJimK5/CB3
X-Gm-Gg: ASbGncuCm/4t7fYW47Wene59NrlVM09RiJntNa7emYqu7nhPwI/1/ZI676gRLAn0eph
	1OuBLIiCLY21YvJ1wSBA80Gmu99G+VKdABX3Egkj+FuE+ViQbpOHSKSIB8szoUXdvfPVKxKHNRR
	RVqB+pqu1GRMSm1Qzt+glMOr0+0OHAwjQJ3kzLscwztaayNEoOcVuJS9Xj1Q8RoYtQ0PNVU+4li
	+EkWy/548E0rgaBFMtCeMTMdekzOme/un3ipvSMcCqDiRGhxO1ghnaybCBQoTBfdGEdVHw5dQpu
	4hWeL4q300tQfMoPSury4uvIBasH5lHaWCVdu52VzUH5PCKb/WL1IKY2RP7pPc2/N+UEHLNGp1D
	SfONjfNy9Bkgwv5QJqY69Oji12YTrcqf7425ioDX/FTjeuqn1BaDlNa+GJ0qGc+San8Ihvg==
X-Google-Smtp-Source: AGHT+IFmNzfgvEEahVwLkACMZNqW0KUgxiZlN4x/uBqreI8OJr+lyeHZmUQ14H4cjQuSd5m1Lge6CA==
X-Received: by 2002:a17:902:f546:b0:264:70e9:dcb1 with SMTP id d9443c01a7336-28e7f440582mr28584725ad.56.1759293448001;
        Tue, 30 Sep 2025 21:37:28 -0700 (PDT)
Received: from [10.0.2.15] ([157.50.97.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6882210sm173000665ad.79.2025.09.30.21.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 21:37:27 -0700 (PDT)
Message-ID: <5f936182-6a69-4d9a-9cec-96ec93aab82a@gmail.com>
Date: Wed, 1 Oct 2025 10:07:21 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usb: lan78xx: Fix lost EEPROM read timeout
 error(-ETIMEDOUT) in lan78xx_read_raw_eeprom
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thangaraj.S@microchip.com, Rengarajan.S@microchip.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, o.rempel@pengutronix.de,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+62ec8226f01cb4ca19d9@syzkaller.appspotmail.com
References: <20250930084902.19062-1-bhanuseshukumar@gmail.com>
 <20250930173950.5d7636e2@kernel.org>
Content-Language: en-US
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
In-Reply-To: <20250930173950.5d7636e2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/10/25 06:09, Jakub Kicinski wrote:
> On Tue, 30 Sep 2025 14:19:02 +0530 Bhanu Seshu Kumar Valluri wrote:
>> +	if (dev->chipid == ID_REV_CHIP_ID_7800_) {
>> +		int rc = lan78xx_write_reg(dev, HW_CFG, saved);
>> +		/* If USB fails, there is nothing to do */
>> +		if (rc < 0)
>> +			return rc;
>> +	}
>> +	return ret;
> 
> I don't think you need to add and handle rc here separately?
> rc can only be <= so save the answer to ret and "fall thru"?

The fall thru path might have been reached with ret holding EEPROM read timeout
error status. So if ret is used instead of rc it might over write the ret with 0 when 
lan78xx_write_reg returns success and timeout error status would be lost.

Thank you.

