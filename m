Return-Path: <netdev+bounces-85938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F3589CF13
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 01:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55411B21E84
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 23:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88B8149C71;
	Mon,  8 Apr 2024 23:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMwy9lgM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D38149C49
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 23:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712620281; cv=none; b=ApeV/7krFDHXNrR/QUQM7OAv4b8uJoqeQU1y/qgPRzRJRluZ4Cgll3ZYKmCmcbH3MhaX9KbKe6lBvAr68C98s1sBWrMkQX1/J4Vc5X0eFF8FlaYzA+Y2rNTnmkI46adqF45FrREv8wTNQ6FVvhwizGR39kxW2Zn7GKPgeWwNjnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712620281; c=relaxed/simple;
	bh=SmHHLbj6PTOSxng2uyN/AmUVtQaR12xTfK6aPYVlavs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DMHtodvXxKoFe1AWcfjAgC9BKFTVmx2Q7WZiWsPtU/E8Hm748OJ2itdXzWb+CEbUYAwEiv7VCDadJtO2LCAXaheVAapr3YhtFmAes4W+goAWmo5surnf2g1+k82odNjbo9dyBeA2kudw5myGQwkaia+D3peHDEBuvlUKNo5MVDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMwy9lgM; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7e328cd8e04so2054725241.0
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 16:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712620279; x=1713225079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=URhNTL0g80dQnxxqD3gOwlfeZQfrIEaLzEz7hWrQ3Ts=;
        b=dMwy9lgMhZS/3LrioQ8qiWuSpyV2BD5JEykutgEUv2lyGjpeNAT7/3NKcEQ9x4pR4J
         MllLfaJLn46cW+PeCHRWRxvntmB/tjPlEYa948O/sKM/DxDhKanEC0EDm454ttI52lUu
         lw7pJZsbGMkPb/Jmm+Oy55ERxQfk5V7CFwfRFkWd0l4E6AGpfcSxxGYJqeCDqq8uhzqc
         6kH+CFRe93g7kTMgXpcSGsFYcVrWW2W3PsuSeYoEZbSkmrwQrxze1VuFH3BzN1Jk09Hq
         AlklTx4EzlCBb+ZLrYrcFI/Du8cD/nRQ5t99hKc4ndCP4NZk2/xLWtNtIhaajnd4ibn7
         QcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712620279; x=1713225079;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=URhNTL0g80dQnxxqD3gOwlfeZQfrIEaLzEz7hWrQ3Ts=;
        b=LjjoQ8YRc7XTliEXIco3DfU3lH5Mfvh8yrr6c4qnejqdMR9/YB2ZV1tlvasjAjg5gr
         FtIWx3dzDnydFyog4ZbIwFRoMLaSGWoXJHzc2JSbAi5mHdt2dwjF6av6bns4VUBCgedT
         edOUY5E9+L156z0c67fhacNMCk0jOlGZ7JiSvXIylgFXBOQ4bLXQphsv98e9jtTdbUOt
         +BKoLl/FNIK+1Lznv51Qt2H1kTZDdb/9eyUZRzxgPPzU4Ue8RS2hdpDBeyDDkEf32QSJ
         T1RAdc5887Li/6F4QQw3bo8O1JOJaot5vH9U112BFp6OSNf85xdAhWjB/39iWT2vvUaU
         bf0w==
X-Forwarded-Encrypted: i=1; AJvYcCW/hdS6jUCWh2bPQ7tMfdIEhBhOccYLy3kvD3gvFGeh4y6+QyUQvgqZGVMtioSz0DEbPm6+xOBTWBaOXuMugwtRXUKPZIxH
X-Gm-Message-State: AOJu0YxpvE40ORm1JPYTdO2+nd7X0dOL+UsDCJJL3J9WBna5M9gID4ej
	y1DGN9kkO374uOC5eDPt2BVOFtd2oE/uAZEdp2buNo1qoVv8if1k
X-Google-Smtp-Source: AGHT+IF4OtlqC7zHZpSHLo25kHzpNvquTLDedHh1EAbeMnxQzXL6J7rI86/Xb2d2NZ3ej24sTX6IsA==
X-Received: by 2002:a05:6122:4f0d:b0:4d4:20fa:eb0c with SMTP id gh13-20020a0561224f0d00b004d420faeb0cmr7695998vkb.5.1712620279071;
        Mon, 08 Apr 2024 16:51:19 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id mn23-20020a0562145ed700b0069b23e58468sm624094qvb.43.2024.04.08.16.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 16:51:18 -0700 (PDT)
Message-ID: <b515280b-69c9-4731-8e89-29e0b4d2c247@gmail.com>
Date: Mon, 8 Apr 2024 16:51:16 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: dsa: allow DSA switch drivers to
 provide their own phylink mac ops
Content-Language: en-US
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
References: <ZhPSpvJfvLqWi0Hu@shell.armlinux.org.uk>
 <E1rtn25-0065p0-2C@rmk-PC.armlinux.org.uk>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <E1rtn25-0065p0-2C@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/24 04:19, Russell King (Oracle) wrote:
> Rather than having a shim for each and every phylink MAC operation,
> allow DSA switch drivers to provide their own ops structure.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


