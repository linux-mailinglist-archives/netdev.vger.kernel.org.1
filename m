Return-Path: <netdev+bounces-153632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E21879F8E4A
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 09:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06641896B5F
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 08:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2571B0F2C;
	Fri, 20 Dec 2024 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="YOgGBYj+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD751AF0C3
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734684710; cv=none; b=qOI9rs3fE+pMVg92MtKsaNoaY19pSKUgKG18S2VVJ7x4FRzkDIx6/d/LO2FuaZVOhOG4M+NECHBGOaUa0bTfigVReJgIAvzKGhVsK8PkWRPW4t5ul3r03QsUdqmjlNCecFj2S69oEsR8UfAXAFNQ4TcU/8PW2LUAFb8tiNAjykw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734684710; c=relaxed/simple;
	bh=dLvlvrSDVECLfSSOZLPtBio7oxSxaD/euh821NhhzH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oPPOnxZhcWCFt8p3iIbdJu+NvF/F2or9aaUdbriepx9xthlH2rJZLWsmeGuYefWmd7R9OSALQtqyW+2ErjKUFoqe+G7gE5dukonqxC/8goJiPSWerA0/np2qOUX38H199mwncgVHoV1BYYdsAV7W7Du6WabkZ5wtjaW1NuVIARs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=YOgGBYj+; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53ff1f7caaeso1668896e87.0
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 00:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1734684707; x=1735289507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HlP9TSmbf2+mm+BDSbQWH0BPbAWuSsitnZyKaFurly8=;
        b=YOgGBYj+VhQ3doJVNpZboMnj0+JKvbXVO/UPYP06dqULx8U1j2F7chAZuZlZMf0GAH
         xBzkkNmghnfzfqfkMMo1c4nudBJqtZYunJRm+vOSlDh/MtgRnmOkbh3Er71uLGAzoxai
         bp18zIcCKjIPlGuVJKDH7rSRXKg7KOGDSaknrZNHb/8bmrmN+4jTBY2GcGAPZ49W5qKc
         Bdy3eE4GhWiwehqq6Z54VvqhjYA2vPcMuiBrdJKUJXP9XQ1exayVRfHGHZ1yI7EZNlqE
         GpYop2BzY4t4qvgBrLZRGh4HPh/VwpUSgl4U/ZAahyDi0/tiVLEMQ2dPK8ksHN5k41Do
         8dQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734684707; x=1735289507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HlP9TSmbf2+mm+BDSbQWH0BPbAWuSsitnZyKaFurly8=;
        b=IF23g5dmISPR7ALTdFguhbdeRIyyscGgm+j7UUS0yPx+/99104fu6i1H/Hil/tvvut
         Lp070Ub7cYmhCPAIs8mJjRF649g9b/SOga9kSkWbvNm5iUGthlYHxi2Rp4WYD2sXtJ1v
         VsBQfGcEYHyKgstOd1DeELq8qM4WSefn+0XhScyr4dMXUD5MBwYvUFzJZvtylbHanczc
         1iH/KqmfJyVmvAe92nFC/Ah/jFXYr2mmYEVOh/LXiTjx3JQSPYBBce2xs4RVn+lS0fPn
         wcBhET5G7DQQSRH3BO8sPI2Qblvxvy1X7rbXn4cvSLk6FKF2Yys117aNSrUDSdHR0C+x
         UiKA==
X-Forwarded-Encrypted: i=1; AJvYcCUctPMk0Tw2o0druweFrGUrqdW11Pj6dIdMSVxKbbS14jnXae7VD6W2I5dcwR2CV7zJPRqPdoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm42oruB0HAYYJ6SokDQ8HmXTzP785iX+KUOUl8IDIisJA4zFV
	myGdDv8RJwEtcyYLbzk4Nagpmw6IKvEjPrYVHYffmO1ksO+cFfv3tU3kRJN8GFY=
X-Gm-Gg: ASbGnctLGNe5FK7zZTAyym07IMzwsXCuY/4T2OA7lcmzocaPBs0TjUJXar+XSw6P6Kf
	YsilVkhHiNO9qzshKyCEY6V0aVIeSFLtCC8+lWRSiWp298S4RI4SJh95uaRdDfM+dCHLke4lAs4
	mwiMpVczck6Xuv3t1qNbqch341yjeXIF1B7THqugEpmvGBtE0muT3anKwRW6M/ILVL/60fjmmlo
	7AjbfH+HqOwh8smR/jLbsYphw0tJ1UDa23LF1zqt7tT22drBEJTKgc4tAyNcRMbOGFCCxENfKTw
X-Google-Smtp-Source: AGHT+IFWZfCVQxkIx3QiVtrU+By8AKq3j5SPak95YvS6Y5V5U72ZXcudCvty8vOxCPaa6vwS7SEBxg==
X-Received: by 2002:a05:6512:3e2a:b0:540:2311:28c5 with SMTP id 2adb3069b0e04-5422956c4c7mr506746e87.57.1734684706832;
        Fri, 20 Dec 2024 00:51:46 -0800 (PST)
Received: from [192.168.0.104] ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54223813806sm421610e87.114.2024.12.20.00.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 00:51:46 -0800 (PST)
Message-ID: <b32d3aa4-33ba-4b9b-b7d3-181c451f8528@cogentembedded.com>
Date: Fri, 20 Dec 2024 13:51:44 +0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: renesas: rswitch: request ts interrupt
 at port open
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Dege <michael.dege@renesas.com>,
 Christian Mardmoeller <christian.mardmoeller@renesas.com>,
 Dennis Ostermann <dennis.ostermann@renesas.com>
References: <20241220041659.2985492-1-nikita.yoush@cogentembedded.com>
 <20241220041659.2985492-3-nikita.yoush@cogentembedded.com>
 <Z2UtCBwofyoHlZi0@mev-dev.igk.intel.com>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <Z2UtCBwofyoHlZi0@mev-dev.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Wasn't previous implementation more obvious? This ts irq you have one
> per device, no per port, so it better fit to one time initialization
> instead of checking if it is first and last port.
> 
> Anyway, it is your descision, patch looks correct:
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

For data interrupts, after making them per-port, it is better to request only for opened device, to 
avoid unneeded calls to shared handlers when some ports are up and some are not.

And once data interrupts are requested at open, it looks cleaner for me to request ts interrupt at open 
as well. Although I agree that this is matter of taste.

Nikita

