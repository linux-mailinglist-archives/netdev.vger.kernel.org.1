Return-Path: <netdev+bounces-125500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E0E96D660
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746811C229E2
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 10:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1184C198E89;
	Thu,  5 Sep 2024 10:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvOCVfKb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A515198E7A
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533442; cv=none; b=lsXwnsqmMP/i0bdhhsnREtFrAWzSBCTNGEXQKH/EhFLp2+nWqGBg7ww3ob4JBwLp4axCbkkYWN7wDcko9bxlRhxuQ9jY0b9X9waIqPI3ApACsQKCp82X+X27FpVWDbJ7J1bj2jNMrzm1eooxCxrBnM6BTXYZgLz7kLzpSR1JHms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533442; c=relaxed/simple;
	bh=SFTCXAr2Gn2iSkuuBJ0RQ4WrBzMWo2rd1Rc8PTwIO7A=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZJMCgvxrLNhcRuzRD3G8NRiOxCVAFwne3S+O3vfmQPg99JlUZUaTpDHQ1b5RwNmy4TzTmfiJPqJZ8R/7XtOA9YbKANkdhrPxaOUYAWd0gffEVmoA4zC7pOcGkg/R9IMlcnQZbtFXJR3UKrt8bO/GAxofBigJ+SNJPCS3rRpbyik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvOCVfKb; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c241feb80dso3479268a12.0
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 03:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725533439; x=1726138239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvJKtJLuOMj0WXYuSaOLR8VjQkKsjp0xylqe6ZlvEnk=;
        b=RvOCVfKbJdUstimfv/s13XnA1bZU18vpkEW+jKMHWsFF0YjNi8xQ9Gv1ZQX2J1hOKo
         O/al3A5+r9ScdGehVfPKBJm4ue20ocLhXQVJ/EeQHMty97pNq/wzOY24/zmwjBdqHAZ3
         MKAbAfZsKm2aBv8EpFA7bvvQ10fdhH4idXRwryfEBrsYYa8n0eywrAlEvJdimQ51fZF4
         GkAIuL7EBXKbuFmT26Rc0eYPq3F1ZNMzp0oK91LGD0AKyhJIjt7j1kYRy5/ig1DhsZR3
         zAGHs8zmLhcT57VCLGoftiWKUcB3PzLgEFXWRULDrHEpobaj1cr6HHIv/NK8vZzcKb93
         zZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725533439; x=1726138239;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tvJKtJLuOMj0WXYuSaOLR8VjQkKsjp0xylqe6ZlvEnk=;
        b=ZtnUp0CTDpjDtoHXOQKmfoipBK+K6KMdkmUYYSY/DUaurU1W0l6AxSNi6elOOUCYJh
         shSal3ltEzqmrnNzB/t11MnsS42Mevmjb2wpL7ZA96GSDrmvzh+1dOa9nXW8Z8Aaz3e9
         iRUf2sVTgYCIiu/PygUqleAZEWDms3xcCtdNgB+BYTkXI3Ij2zvhSbz07NU0O/0yIexs
         Nav1Nup9MWm8URpVQf7+Ebf4JUUKRr89uMTnNjStLRERAf+Z01wz15rB7buwBxY6GnuA
         wOT0vxhKOuyeAGNCrgvjgs0KtaHEd/HnAqz67w71KjX/4Mrvo/MoYYPMeqILYOhMU1Eb
         gJNw==
X-Forwarded-Encrypted: i=1; AJvYcCVBiTesNwAITood0ng0CaXZVAADkKYWA5I4rQCToB7zf/NDv+cY/W3e+Ni6/2WSn3gDDbrgUzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlQLQItD2gOdi+21xKaggRDcgnqXqExkqgneAN9GtLV95UvZtc
	CnHor6H/YOOvTvOMoqihP4GwhWphXqi12VZTmrwP4+vD5MlWXFmxkYtQYw==
X-Google-Smtp-Source: AGHT+IHiEKFd8cGQz5iNrOMI6tsC5l2mkgynOcquKjgl//w/w0TtMwpejFAsgIwyaSXIFJXpdC1ehg==
X-Received: by 2002:a05:6402:42c5:b0:5c2:6f35:41af with SMTP id 4fb4d7f45d1cf-5c3c1fa0581mr6496879a12.16.1725533438379;
        Thu, 05 Sep 2024 03:50:38 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc54b287sm1072671a12.30.2024.09.05.03.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 03:50:38 -0700 (PDT)
Subject: Re: [PATCH net-next 3/6] sfc: add n_rx_overlength to ethtool stats
To: Jakub Kicinski <kuba@kernel.org>, edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org
References: <cover.1724852597.git.ecree.xilinx@gmail.com>
 <e3cdc60663b414d24120cfd2c65b4df500a4037c.1724852597.git.ecree.xilinx@gmail.com>
 <20240828174719.5c38dad5@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <f0c50993-f8aa-528e-1128-218cc0f01d57@gmail.com>
Date: Thu, 5 Sep 2024 11:50:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240828174719.5c38dad5@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 29/08/2024 01:47, Jakub Kicinski wrote:
> On Wed, 28 Aug 2024 14:45:12 +0100 edward.cree@amd.com wrote:
>> This counter is the main difference between the old and new locations
>>  of the rx_packets increment (the other is scatter errors which
>>  produce a WARN_ON).  It previously was not reported anywhere; add it
>>  to ethtool -S output to ensure users still have this information.
> 
> What is it tho? Not IEEE 802.3 30.3.1.1.25 aFrameTooLongErrors ?

No, it doesn't appear to be.
If I'm understanding the code correctly, it counts "RX packets which
 SG placed in a single RX buffer but whose length (from the RX event)
 is too big to fit in that RX buffer".  Which doesn't sound like a
 thing that should ever happen (and when it does we netif_err() under
 ratelimit, see efx_rx_packet__check_len()).
I'll put this into the commit message.

On 28/08/2024 23:22, Jacob Keller wrote:
> The description makes sense in context with the whole series but doesn't
> quite work for me if I think about viewing it without context. Perhaps a
> little more clarification about the rx_packets behavioral change?

Sure, will do.

