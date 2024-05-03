Return-Path: <netdev+bounces-93150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DEE8BA4D8
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 03:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 929F8284728
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 01:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383378F47;
	Fri,  3 May 2024 01:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="NKdPKIpl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FEFD29E
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 01:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714699164; cv=none; b=iiziMmVZcSsBrYkbMu/ZTvM9xKkGFK7SLTzSubVcHF1s054SMAK6czSoKCLMkwgOaOpNm7N/mtblBkP50H8WnNvVc35E5GjkDGtf26o9POQXgFM3QjDAAZSbDuvOLEVwqSHRTPcag3s4jejZwdNPGyasijV9lVus9BBLNLZsYHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714699164; c=relaxed/simple;
	bh=DXAPaHCDQVkA2nXhtFBmXU/phvqYxOfg0VMZeEeP5+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRgWGyOqAQpHGI2myrBoRjvbo8Iqz1IyX1jH3Pcm11Q2+f6J8gHfZQiaBbl1fx/w8BGo3g4OThTurXCVr4L7tZ3IQ7zYi+5uAO1h8I3M/gzFTzvCRv0C1nXtPsnsvenOOePekCoAZvg91wIuypYpcEqWf6YwS62Nklb4Df27vKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=NKdPKIpl; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61ab6faf179so85226727b3.1
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 18:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714699162; x=1715303962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vWwBGEhuguSEXr2IPUO39LX4Y/M1E09CD4Hj8G49S74=;
        b=NKdPKIpllerXMcAEhnlXfy7TXlMMNzs6QT/pf1SDiENNAq4tulhg/tss8UCg47Ryap
         29IqHqMDG5Uvjudp9SQYcq6u7Y5RglWajOjvLHNN752b8iTlV5GVv2Ok+SNdns6HYFhd
         diBJtAWiUoxPSszru+mqXEMl4ReugaSg4MUl6MMIadEPwu11RusVJwKk6t2lFVXbYAqC
         IIXmGAdNUmuWcitmYnK18Rs9GhAQ/66H1Yl/ASgFYLaR34kpOq4mPMz2epmbbpZ560pk
         vH0jJxUttscfbIt9NjuHae45ALWeLyVzGfC1mypc2nhmU6er3aAPuTr1juqXzgHbe3kD
         ce5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714699162; x=1715303962;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vWwBGEhuguSEXr2IPUO39LX4Y/M1E09CD4Hj8G49S74=;
        b=Otkmvu4ZDnzMpRHhHriX1Y12mqjgY3gnoLLS63O9whpeKOmg/0nHZbtzFOlm4hjqJg
         lcsvlmxqucx87M5w1/wyt273Gz4jWWsXe/kDVcv2H8ExTdvpCeA38T7yIyJ4Z2xlNsQh
         zAm2XEwrpp57k5fCMpbUmhko9UU8bceYSnbR4LyKC0lu09/2fw8f+elqdm77nzqEdRse
         G8+w/+YM08+RgGeE7wxazbqBtOUd54/Z3qhd1EJXcShyg8QRr4pEd5qGY4GlBtF3RiIV
         c4Z6rfPhR57NX41V0Y84XYApzB3qo0Eq7ktJapxXjsuPD9sy5TvQa4yuTdreX9NFBGWp
         aAgw==
X-Gm-Message-State: AOJu0YwkRiFY5viHUO2+eUMgajeYl0KfTezOQ8fGvrFF6SicdGbSOXir
	xezT8vuXNxvMgnWWiOhHRVliGOjnnPWJo+SxeVqHdPlyZU90aDznoy/FVy8T+XM=
X-Google-Smtp-Source: AGHT+IGedbUupn6ArlmUeBNuxGMvBI0ZRMIrC69emLZBMvLW4Xi5qSYeapu7z/HTWGlSqezWHYp3+Q==
X-Received: by 2002:a0d:ebc5:0:b0:61a:d455:3dc6 with SMTP id u188-20020a0debc5000000b0061ad4553dc6mr1198546ywe.11.1714699161637;
        Thu, 02 May 2024 18:19:21 -0700 (PDT)
Received: from ?IPV6:2600:382:3111:9530:4a0:4dbc:76f6:2ee4? ([2600:382:3111:9530:4a0:4dbc:76f6:2ee4])
        by smtp.gmail.com with ESMTPSA id y83-20020a81a156000000b0061be65cc0dbsm463606ywg.120.2024.05.02.18.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 18:19:21 -0700 (PDT)
Message-ID: <716f5dc1-3d44-47bb-ac78-c69b64bd5521@davidwei.uk>
Date: Thu, 2 May 2024 18:19:17 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v1 3/3] netdev: add netdev_rx_queue_restart()
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Shailend Chand <shailend@google.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240430010732.666512-1-dw@davidwei.uk>
 <20240430010732.666512-4-dw@davidwei.uk>
 <CAHS8izM-0gxGQYMOpKzr-Z-oogtzoKA9UJjqDUt2jkmh2sywig@mail.gmail.com>
 <5f81eccd-bc14-47a5-bc65-b159c79ce422@davidwei.uk>
 <CAHS8izMzakPfORQ9FX8nh0u0V7awtjUufswCc0Gf3fxxXWX0WA@mail.gmail.com>
 <20240502172241.363ba5a0@kernel.org> <20240502174913.380dcc38@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240502174913.380dcc38@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-05-02 17:49, Jakub Kicinski wrote:
> On Thu, 2 May 2024 17:22:41 -0700 Jakub Kicinski wrote:
>> On Thu, 2 May 2024 09:46:46 -0700 Mina Almasry wrote:
>>> Sorry, I think if we don't need the EXPORT, then I think don't export
>>> in the first place. Removing an EXPORT is, AFAIU, tricky. Because if
>>> something is exported and then you unexport it could break an out of
>>> tree module/driver that developed a dependency on it. Not sure how
>>> much of a concern it really is.  
>>
>> FWIW don't worry about out of tree code, it's not a concern.
> 
> That said (looking at the other thread), if there's no in-tree
> user, it's actually incorrect to add an export.

Sorry, I forgot to remove it here, but I will do.

