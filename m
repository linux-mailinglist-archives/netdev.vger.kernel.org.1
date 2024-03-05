Return-Path: <netdev+bounces-77395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8D187187D
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 09:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E60A1C2194D
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 08:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9614C4DA0E;
	Tue,  5 Mar 2024 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlx8msgu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEEC1EB4B
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628297; cv=none; b=iYC9iND+udPPLuy6/Yf9lvfIRXpVRAmtwrA9oKvkGQygvlpurh0rD9n8tcqItr1a0mh/F6QFha4HIsGA7GQ9lQE+rgr1oDY3aBQNvt3EuIG6dxS8UNLlgUA8Y0BUSiwH6qZktJqU7I1RIYcrputO9VsA0sKUGhaxDSgr8d2grpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628297; c=relaxed/simple;
	bh=CJIuVculnSbKDWa1q+mdJZjo5smc7vg/M1xxjZbF9zY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRyrNehcTq6zyFQKefIBIhv3saA5uyv1PhMhcXnQfFW5Af8MLFIokKobdLmQHrsnlrj4GliFAsGzTsgluvR/fdIY6aVgVXrChqPpP8zO8nRN0tn0ihzbisYU4R7ggWc4bDCpiD5rwqJaePOxg5yRIoJ4wuuVgVnqq91eDFERdyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlx8msgu; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4417fa396fso663831466b.1
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 00:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709628294; x=1710233094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Wvn25wAIJmvxgshQd315SU++drE/mWtfhqLIvaUcAY=;
        b=dlx8msguDHV1gHqplKBK6S2C5YNVYi5p0mjkCvzKHg1Rs38MR17GxcUp8ZsYr0yZmb
         CW5D658EYRsROhHQ0PS9IKyxcQlW5O95l08T5AfDgMN9OhwA8mNmfVunfEL8YCqtxfcP
         1MKEQyy25GTXfI5XkqcCL9XTfV4zMZp4TT9UEm17DUn9MHu2MwBTg2ALXzVUfxXlX5od
         mKKyUh4YOM7W2Kz+zeHXHXMjjQ0khOkVdrFhRhXjpbLQ5/oGQ+TajsvdlU+szqUZVzSK
         gG/yDRED18MQPmYwMXjbbTvost4vq7z/u3wVmcl1aw3l/5z1pUCSc73lMv1VsKnZ4ggR
         kviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709628294; x=1710233094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Wvn25wAIJmvxgshQd315SU++drE/mWtfhqLIvaUcAY=;
        b=WiyfoLy848zSWXLGXSAvIECCQnkALrnkUTq+918mANPVmapkWVmIhrzk1MmZ3YcTFU
         wYhjVj/2zwsXGN2cOMHH20wSPbi15sC6+eAUxzSZyZevslq8r/KyTAwpTvEhnf5JNXnF
         /wjmr7p8PNjUFPENxm7RY2DCTvtWZbqUOBAEN23lErL63ew+3dQSTOt8sC8EITY+gD/5
         j6CgTSXBoYijVdaMAi4dxDdjWxT+pV7icl3AuWBISwXAq+FFCj10QCrh9x53OrfVX12b
         7pe2GOUSLM389mfj8BW+6KT8kVk9YqDDDe19uq/rdiQsAAzEHHP6yni0ecIyoc9VuBqt
         0KVg==
X-Forwarded-Encrypted: i=1; AJvYcCV0do+KAs+wYVHqjEeIXOSj3cNX5BKaY3TQckFAS/CZ5os0YlbZHfyiThCEJxNRUV3Pe3cBhlVED2jO253lSBEnRjIhpSxu
X-Gm-Message-State: AOJu0YyC/AY9wY6krhAgMyYZwTc8hlkNUQfpYMFvuGo4OcJ1dvKrOYRw
	YOQaVwnuKYqlbd2TuV5gtDxTX957KkmYTjD68Y4/iIYf74jA7Y+B
X-Google-Smtp-Source: AGHT+IGtnXR1j1fzS0X8+rrvJSfvKv6ACdNieDk5DtlaA/VzsNbd3XZYpXivt5v3KDUCGiRZq1dNpw==
X-Received: by 2002:a17:906:374c:b0:a45:8424:163d with SMTP id e12-20020a170906374c00b00a458424163dmr2049141ejc.17.1709628293914;
        Tue, 05 Mar 2024 00:44:53 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id wk16-20020a170907055000b00a4532d289edsm2375770ejb.116.2024.03.05.00.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 00:44:53 -0800 (PST)
Message-ID: <26f86865-79e5-422f-9e99-bbc71933c718@gmail.com>
Date: Tue, 5 Mar 2024 09:44:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 1/7] net: phy: realtek: configure SerDes mode
 for rtl822x/8251b PHYs
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
 Alexander Couzens <lynxis@fe80.eu>
References: <20240303102848.164108-1-ericwouds@gmail.com>
 <20240303102848.164108-2-ericwouds@gmail.com>
 <f587013b-8f2c-4ae1-83b8-0c69ba99f3ea@gmail.com>
 <ZeTmv0S9cbqFOUPS@makrotopia.org>
From: Eric Woudstra <ericwouds@gmail.com>
In-Reply-To: <ZeTmv0S9cbqFOUPS@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/3/24 22:08, Daniel Golle wrote:

> None of this should be done on RealTek NICs, and the easiest way to
> prevent that is to test if phydev->phylink is NULL or not (as the NIC
> driver doesn't use phylink but rather just calls phy_connect_direct()).
> 
> Also note that the datasheet with the magic SerDes config sequences
> lists only 2nd generation 2.5G PHYs as supported:
> RTL8226B
> RTL8221B(I)
> RTL8221B(I)-VB
> RTL8221B(I)-VM
> 
> So RTL8226 and RTL8226-CG are **not** listed there and being from the
> 1st generation of RealTek 2.5G PHYs I would assume that it won't
> support setting up the SerDes mode in this way.
> 
> Afaik those anyway were only used in early RealTek-based 2.5G switches
> and maybe NICs, I'm pretty sure you won't find them inside SFP modules
> or as part non-RealTek-based routers or switches -- hence switching
> SerDes mode most likely anyway will never be required for those.

Then it would be best to change all patches in this patch-set to only
modify the driver instances of:

"RTL8226B_RTL8221B 2.5Gbps PHY"
"RTL8226B-CG_RTL8221B-CG 2.5Gbps PHY"
"RTL8221B-VB-CG 2.5Gbps PHY"
"RTL8221B-VM-CG 2.5Gbps PHY"

And NOT to modify:

"RTL8226 2.5Gbps PHY
"RTL8226-CG 2.5Gbps PHY"
"RTL8251B 5Gbps PHY"

Or are there more restrictions? If so, why is it a restriction?
Perhaps this can help me find an expression to use as match.

Best regards,

Eric Woudstra

