Return-Path: <netdev+bounces-109253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7F2927947
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954A81F21666
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 14:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844B71B010A;
	Thu,  4 Jul 2024 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKJDyBBf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC851B0100;
	Thu,  4 Jul 2024 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104660; cv=none; b=VZJjCWkwQupbbvfUyh+tG7bP2+esLXZEh3sgI7dAZeiOMCVBH1pMR5zSisgoLYOaB42GNo+lttzbpLDYoLnf6e4ttb3HITVYhQi48W1VLgelo5Xb9BKM1pmmMecWDKvW9OD3d62lo/ThZ3EtscqK6cfOWnqJaJutVketzWvB/9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104660; c=relaxed/simple;
	bh=osGTrPVzcqkxHZ3n3L3DSQUiwmQ0IiX+piE4kgIPEFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwbEg6GJPu4zrdSixyDGRfZBgP2wTCnQoAYUNGcWDpH27wQgFZEJP5bzuVOB2IOmaTRkDNoUJ2BXfhV9n6qSGutVDXGCUd341+i+TlhKtECv5sOrtSmh0tNvAapHPUG0fxEalKLnJjde8rMyvB55YPBHEdXOPBp24l2+O2wpavY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKJDyBBf; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7021dd7ffebso413091a34.3;
        Thu, 04 Jul 2024 07:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720104658; x=1720709458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n7Ak2uR/dWTZjvtNbmJG4Hg5R/nijnavlw2ab/tTrrA=;
        b=PKJDyBBfZ7oEkWHsRSVzTDnUXLusxBW9FuqHVtuSzY/uDmDi+brtRoL89ShclDYz6F
         FwMbogkdhJXYk8Tn+sRgXY52QEeQwqAdXQsEuXWCLwRZ2Ay3yOXRdc9zP+9TQfuW1x6o
         joTmBQ8X6aA/G3dKUQInVHdio8xlDCJeMp2ateRleHIplwZLbqMctAGjpKjgPC5pm/Yh
         30sAxKqF2Qjgj3xtJ3qSt4Vsvsi8VREs9Hqqwad4Ofn6a0WowzdSQzMCnl4zCeILC9i1
         tXWBI+P77EUTLr6w/2y79RhPSDCjhhRtlBzlw05JHROExZZX7NaXSF933/feouIxBu6Y
         EfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720104658; x=1720709458;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7Ak2uR/dWTZjvtNbmJG4Hg5R/nijnavlw2ab/tTrrA=;
        b=aQovqm7vU6gy7tk7GQBJ0pw+tZJTjMAtt+0dF2tO5LEMEZmglmUMOZN+I+hPABOTsg
         TVkvUsY9BrKtSYmwBFiB9KsGB7EUS5kGBGfUr2EKWGI0UmK32WcB1FW65bN+zIaEKWxA
         AWWhlBxRKUgWalyc2nQG5LQy5LHL/GWwRkVBzDJyQG69QyjCeOSZZOpUeSya6XhnC6Ld
         IcT+83i2ERqJXQK4qbFbblAFVE+5uREKNUMTm9D1UDBEUfzPnPZI822km00a9s6j5W3U
         EKtx+raUdMoIgdxDNqNRUcQFWkWi2rMF3mccMMTyq4O8i9iE8vB5wdVgw2yqMOpuS5Ju
         Gj5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdOuLpMKtUVdIxc8zHjDetegVrVqrwNaqcd8CkiZ/o7PWYyPO1N11c4hUAA4SiqPuJf+ktYHUdK9qj/bVOKW1NEd2iF7wZnPER26vA
X-Gm-Message-State: AOJu0YzhdZccpAj/VwnYc1/cQnWKyGIC9aMnC17itQnJ1P1cPMEQnt5a
	/ZNo4G8++4DTmHFe3O8YBeTy93jLqhZRTPXAFpfoeqHu+7Mh1MTU
X-Google-Smtp-Source: AGHT+IGk7QlVTcf7Bc92V+E03dQbTz93pk4va96tRqfZF4c48lKdQBqW7UzjWeG7vUIMd/daqmxivg==
X-Received: by 2002:a05:6830:6b83:b0:701:f1cd:350a with SMTP id 46e09a7af769-7034a756368mr2075298a34.11.1720104658051;
        Thu, 04 Jul 2024 07:50:58 -0700 (PDT)
Received: from [10.40.5.113] ([89.207.175.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69260065sm681584085a.5.2024.07.04.07.50.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 07:50:56 -0700 (PDT)
Message-ID: <ddc3d261-6cf1-4e51-a889-962c57008eeb@gmail.com>
Date: Thu, 4 Jul 2024 16:50:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] dsa: lan9303: Fix mapping between DSA port number
 and PHY address
To: Christian Eggers <ceggers@arri.de>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Juergen Beisert <jbe@pengutronix.de>, Stefan Roese <sr@denx.de>,
 Juergen Borleis <kernel@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240703145718.19951-1-ceggers@arri.de>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240703145718.19951-1-ceggers@arri.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/3/2024 3:57 PM, Christian Eggers wrote:
> The 'phy' parameter supplied to lan9303_phy_read/_write was sometimes a
> DSA port number and sometimes a PHY address. This isn't a problem as
> long as they are equal.  But if the external phy_addr_sel_strap pin is
> wired to 'high', the PHY addresses change from 0-1-2 to 1-2-3 (CPU,
> slave0, slave1).  In this case, lan9303_phy_read/_write must translate
> between DSA port numbers and the corresponding PHY address.
> 
> Fixes: a1292595e006 ("net: dsa: add new DSA switch driver for the SMSC-LAN9303")
> Signed-off-by: Christian Eggers <ceggers@arri.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

