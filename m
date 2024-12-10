Return-Path: <netdev+bounces-150636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C789EB086
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 13:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C6B6283D5B
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 12:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D121A2630;
	Tue, 10 Dec 2024 12:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzZ1jsnG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE9C1A2564
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832667; cv=none; b=mKgdN/35qJac7FAQPNme2LiecvkLLqcY/LN1AT4vzlEmtP0vDTRV7zUfAfZObpp3bPoA48epH/eVQtfjm+NtBDBVo9FqptzupnE4zmsd4QHHV+bZW1eRwNdXYbDo2UiMGVdGS2oykAR4m2SfumBsmAi8gHUqUyc5NunJGBbiMh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832667; c=relaxed/simple;
	bh=WpFJws+1AAKwCgFgJgNhVVsNE/Ttl/8nbJ5O1lIMyT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f85nA39cpEbp/cgUlKfP/enrhOM4YSIeaSOB1xmBwrjgergyTDWVmyVl+reYdETqTjmExvqMM9W0Qt5uFGzuY97KJpiPVlJWOIXC4WVIA98Eg4pMExKstb0FCfCr67dJ4nV9iGdUYs/wpzRibI4bNugdyV8Wwnn3jF+GvteMFeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OzZ1jsnG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733832662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RhM7wkaVMM+fe9bz3ACeYFwdz9wUUgUciwQHUf9mljs=;
	b=OzZ1jsnGOJO+LeUmBHoAPWiU4Og3D5GFb3bfSUrX1kLlI3GPHA9mDsfMJ5sj+SKA/y3Fc1
	cZZVJNkw2vvaXMEYpAeTh26jPoC4cLvjh6vpsA1gEhUutrN/EkEV0PjLR7br0MyrHKdJOG
	AInR+zqvTLDjiLvoPyHQkP1JKCXZAfQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-xkTtjp4jPMKzEEqCtLnIrA-1; Tue, 10 Dec 2024 07:11:01 -0500
X-MC-Unique: xkTtjp4jPMKzEEqCtLnIrA-1
X-Mimecast-MFC-AGG-ID: xkTtjp4jPMKzEEqCtLnIrA
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3862a49fbdaso1886948f8f.1
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 04:11:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733832660; x=1734437460;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RhM7wkaVMM+fe9bz3ACeYFwdz9wUUgUciwQHUf9mljs=;
        b=IN+JyQt3SjFE8n2PdCanARaCJsEI5Kri2AHHUmflhmLaGoYg7sHZa752KgWbcSgtZ9
         F5tWs2ioUkWg3SFiWWtKSoXiwjAuDnDsdDx+hTzOb240VE3Tjjo4KY5uppWbNiWnO79b
         mIDpIQe9z/JHKvEM4l+bQ7TqmSRSip1H4+ZG/eWdw+PwKQFQ7x/GZm+i4Oyek8V/F09t
         kkl7UJy4lEkCY58md+JOeZ8wZlliTXEUQCXbIvWHgtjHVCnNnUKwx86gsjnvw3B88F+B
         ge44ssQTom9QkOcDMXWWXoShR02IXv8NbTIajquzwYvY09y+agu+MqgKN8kmQ7VyDrDj
         rikg==
X-Forwarded-Encrypted: i=1; AJvYcCW5vfNR2iHKoDK7XIWj5NzxC3oKic0dYGpd8CIk+BYxHMngqD9vPIVewfHFWURfsnRkmgqIyfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlpi/ozfdMHeZSrM4fz1kxGmsFU2ctejC1W1lyEVgqiYU4tCvx
	BS8ij6YiPUfxAZLRacPUvndpOg9coa/rlIoJB7eW5Rm5NyyQRq049KmIr/3Ygjn4LkgN3v6PaFn
	t9TjOSircXCMWRfBTaAXaSUVikxcd7qICCX6J9DjoqXP527WL7H1Enw==
X-Gm-Gg: ASbGncuJ/se11TBXrZ8ZL7MY8EqKigbVXr+1P79rLVqk5hl4RdlrswzVxCmZr7Vo3F+
	ddmUefGMHZcxNVVVBDWiee7KF7IOh4YQMHkMLHhOmTdl5zzc7itcFsW72qArD3lXzxQGVqD4aJ0
	+2W0+7RA1LCdD70ez4xnkap4E3iEO+QeA6w6CHPWtmWi6o+//NfuS5xd6/udgstlMFGBuMZ98DZ
	3RWT2WpunURgWu/jqYWKdwEujyswmyVgs4DYwaxid+CxtiitoUzVPVjm+Tpad9d4nJDEJgXFGfX
	ZSI5pM1YIU2mIudvi/vPQ6wVPg==
X-Received: by 2002:a05:6000:1868:b0:385:e38f:8dd with SMTP id ffacd0b85a97d-386453f9d18mr3275302f8f.46.1733832660016;
        Tue, 10 Dec 2024 04:11:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKwb7Q/AAsAZiRE1WgBOMhwvv1eQWNMA/tdwYlA97mx+0mxSgPemTKmBfH3OvniCb4fAfxHw==
X-Received: by 2002:a05:6000:1868:b0:385:e38f:8dd with SMTP id ffacd0b85a97d-386453f9d18mr3275283f8f.46.1733832659637;
        Tue, 10 Dec 2024 04:10:59 -0800 (PST)
Received: from [192.168.1.14] (host-82-49-164-239.retail.telecomitalia.it. [82.49.164.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbefasm226004575e9.43.2024.12.10.04.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 04:10:59 -0800 (PST)
Message-ID: <a9c93b21-71e4-431d-9ab2-e73d47d12dd8@redhat.com>
Date: Tue, 10 Dec 2024 13:10:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/4] net: dsa: mv88e6xxx: Give chips more time to
 activate their PPUs
To: Tobias Waldekranz <tobias@waldekranz.com>, Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, kuba@kernel.org, f.fainelli@gmail.com,
 olteanv@gmail.com, netdev@vger.kernel.org, linux@armlinux.org.uk,
 chris.packham@alliedtelesis.co.nz
References: <20241206130824.3784213-1-tobias@waldekranz.com>
 <20241206130824.3784213-3-tobias@waldekranz.com>
 <518b8e8c-aa84-4e8e-9780-a672915443e7@lunn.ch>
 <87ldwt7wxe.fsf@waldekranz.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <87ldwt7wxe.fsf@waldekranz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/6/24 14:39, Tobias Waldekranz wrote:
> On fre, dec 06, 2024 at 14:18, Andrew Lunn <andrew@lunn.ch> wrote:
>> On Fri, Dec 06, 2024 at 02:07:34PM +0100, Tobias Waldekranz wrote:
>>> +
>>> +	if (err) {
>>> +		dev_err(chip->dev, "PPU did not come online: %d\n", err);
>>> +		return err;
>>> +	}
>>> +
>>> +	if (i)
>>> +		dev_warn(chip->dev,
>>> +			 "PPU was slow to come online, retried %d times\n", i);
>>
>> dev_dbg()? Does the user care if it took longer than one loop
>> iteration?
> 
> My resoning was: While it does seem fine that the device takes this long
> to initialize, if it turns out that this is an indication of some bigger
> issue, it might be good to have it recorded in the log.

What about dev_info()? Warn in the log message tend to be interpreted in
pretty drastic ways.

Thanks,

Paolo


