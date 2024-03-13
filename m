Return-Path: <netdev+bounces-79715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9A287ADB0
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 18:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B3F1F24AE6
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 17:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A52657DC;
	Wed, 13 Mar 2024 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="1zFo+Put"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBA6548FE
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 16:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348370; cv=none; b=N5lV/zv9QvUxKMFShzrYEmF05EcS6dMnfXk4V63EZndjn4csjmQ2ew2jTOapGK7tMtpk2MP82TEPbEV7/C/oX5lSG1EmHA8tN/5kbcM7jaVm64xV+tB65D5dBwvHvbt6sRKsEwAAYsLKWClHXmq41Z/3MQ396uI7cB+QUfz5S6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348370; c=relaxed/simple;
	bh=ajc2IbycekOxu605IlaTMSlYD3JXuB2TOsJLd5kzZO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S7oOTaB/oRx7E+a0CMr/1p2q/MGL9oVtYf0oqzTOTphDLMFIAtTYqv91lLAz596hl0gwwPKOK+p5IWpmqEieZ/BssOqeMY5FQ3n5dpzdme9E5ZmHlaLVaBthO/vif57QB/wbAnFr5azjEOfKjbEnZhZbwx+XSyLZnaUp6JvLC8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=1zFo+Put; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33e9990da78so3038015f8f.0
        for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 09:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1710348367; x=1710953167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I10skRo+xJIHU8KIXlV1mDs/JMDkXVfJlvajfNuXpHQ=;
        b=1zFo+Puta4qGlQrNZu8Oj+G/jh0NTEKs6psfON64Qr8Skc6JtaW4c/lsKzbRAKmZog
         RWeorU5rsFX0iUFX+tBr679QrMOJwRZmbXd1fy6som3+i+9dSR5aKpyrGYkOCI7wOWzP
         IeAOHwEKmhkBnplmFT5m28+qzJ3MVNFUKsCGyonGwumB5Y/OMBLZqLJL/KhSTiqpQAmT
         ewl0wcC2xO6CXZVC1RCGwnZGU2NCZpNhYugaoNs71fbr7EmyShjJOkLzRjmqZZJbUnbG
         HL/o9sp7wrr1wJVoVxvF55m4pAphg7ITBTPqWfISmRdcvgOAHZ9I+I7jCR9XlItfTRnj
         zeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710348367; x=1710953167;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I10skRo+xJIHU8KIXlV1mDs/JMDkXVfJlvajfNuXpHQ=;
        b=RorqN8Y0IYWDUx3KuSSK5szD9epollarDJtKeh0bV80Y1/gja9JliPwE6pEdkprzmZ
         DpeW81J3nVmwky/CZQQIRIhz83EgWUOh6ZPKQMA+SpvtoeancswWoYnoojyc0NQXvaZO
         uAIrQ/HbCwRcHvvyp2HcHLxbcfWyVNKuvENHsfALJFQ23w432mUr7FhXtYv3QHIa/cMP
         9FQM84y2PYrhreq2JKo7OoZg7TXOQyEwDU6KcvY2XRwh9gV1uE2zr3nQ2PTML/wFKiXU
         +Pv13O+ocURoxO6ypqlOIAMf/Hfxu0NnKbzoQrCiL4GlZgqEd3tlL/gkEeMMf5kwa5AR
         eJCg==
X-Forwarded-Encrypted: i=1; AJvYcCVIzFg3XIiN9Y8uz0o9ORb5dLWGec3btPZVlqVHtGb2+BqK/SIAJwvJzee64nmDBkG35FPUXypTdKUugoZ0ENXrsJXQ5pG+
X-Gm-Message-State: AOJu0Yxk1azbMjNvjxO+NDZRiR80XwIbKmYbKa8kJskjghBI7kS92nNY
	7xd9JvbwTefmo9Bg/+eU481I8S/oWaSgW/YDCLzy0d2D46X5AqkZjzWl/s1aLRQaGbVaMA1EpIn
	Z
X-Google-Smtp-Source: AGHT+IGWIclefnqKkRNfhzAm5AV6cZPb6k0/Y1Pzmv18kbz2iK6rqLRCwPWFZ1x0FQ8itmDFk5nHmg==
X-Received: by 2002:adf:ab12:0:b0:33e:b6a9:a7f7 with SMTP id q18-20020adfab12000000b0033eb6a9a7f7mr1907557wrc.43.1710348366871;
        Wed, 13 Mar 2024 09:46:06 -0700 (PDT)
Received: from [192.168.0.106] (176.111.179.225.kyiv.volia.net. [176.111.179.225])
        by smtp.gmail.com with ESMTPSA id bv10-20020a0560001f0a00b0033e033898c5sm12153101wrb.20.2024.03.13.09.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 09:46:06 -0700 (PDT)
Message-ID: <cde09a86-1f34-4372-8dbf-7682157aea2d@blackwall.org>
Date: Wed, 13 Mar 2024 18:46:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: VLAN aware bridge multicast and quierer problems
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev <netdev@vger.kernel.org>
References: <123ce9de-7ca1-4380-891b-cdbab4c4a10b@lunn.ch>
 <5f483469-fba4-4f43-a51a-66c267126709@blackwall.org>
 <08ecdc22-74bc-477a-b5e5-1aa30af2c3b6@lunn.ch>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <08ecdc22-74bc-477a-b5e5-1aa30af2c3b6@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/24 18:36, Andrew Lunn wrote:
>> Hi Andrew,
>> Please check again, br_multicast_rcv() which is called before
>> br_multicast_querier_exists() should set brmctx and pmctx to
>> the proper vlan contexts. If vlan igmp snooping is enabled then
>> the call to br_multicast_querier_exists() is done with the vlan's
>> contexts. I'd guess per-vlan igmp snooping is not enabled (it is not
>> enabled by default).
> 
> I will check. However, if per-vlan igmp snooping is not enabled i
> would expect it to flood, but it is not.
> 
>        Andrew
> 

There is a querier in another vlan connected to the bridge as you
mentioned, that is considered global if per-vlan igmp is not enabled.
Why should it flood in that case?


