Return-Path: <netdev+bounces-149731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A2C9E6F63
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 14:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E4A1886A0E
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192451F8EFF;
	Fri,  6 Dec 2024 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="G5HqLId7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBE61BC063
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733492373; cv=none; b=WTyKIOCFsBafkghs7fAS6TlNEQ+zDuf7vUdShrznuJY4lLa6/CIsEeOPuq1VT74wQTzZ+Z7WPx2Hp6VWm60sp2in5E6DP88TLxvzC8vImuKUF7DxiwKIoWTMKaGQHH0hyUEc6A63CEpl939f1OggCbkTiQgRCgxtntVzBA8Amq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733492373; c=relaxed/simple;
	bh=4qNCsgKSXvGrOxI5vRlEMxZSj5gPITtbGgOSncV26sI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MgzSxxHW/Iv9ozhW5VflDEeht4tUhZp9FPOIfQ7pe0kev/XX9XAgqqCdtelS/UL1o6e2lwJZ6T0rRQtRnU+CxZt0c4j02kYS4Co4CsxF95RfegZuZQCZ5+h5OP8i9L+NhwvjB9bsEttkcujrfQtFzWmT1TphkLBTr23HWBxr5ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=G5HqLId7; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53de79c2be4so2127310e87.2
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 05:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1733492369; x=1734097169; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vfEXjLuNWQFj5HNW6lnbutw7yxps04+knHW0CAzbmNw=;
        b=G5HqLId7EXsXnKNeGHzrZvM32BH40JvMdj6I47Q5CJeG0rwf5UdhymAuys7H7LgfAe
         rLmI6nVQET1C/AqTiGmW5kgoEdDW5pzjvNzjT18Q4XhXXHzJJLtB/t1XVdTdT3P3ZLQd
         /lKA0JztDOUHSnLkwkE2ul2s2UWWFSDUslRS5XBTeq8ovn9iGIFrpPabZp2pKIBir0VG
         Xsd3pYEEdPbhfzVnf0BqJOl5/6IBNn1lj1FwNS8eR6tCZf6y+7XTmS20u00r+krsknJY
         AA8ph/0Y2+02AgvR6fvpwfYklOCsMBUZ6QCTqX8EJ1VCoQkUue/V6a3IPeNca7jGDEV7
         Tmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733492369; x=1734097169;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfEXjLuNWQFj5HNW6lnbutw7yxps04+knHW0CAzbmNw=;
        b=Itxkj8TjX9WmDnCsK2dJbWKTXRy75Zq8qZuZMD9vb0KCCNgme8ZbRA6oXxsOONIRPq
         62N4UO1oZnKoluuya5CgvqjBzNvZVZfuL9hDCSxZf1geigQZxmTgDA3N/N0Dcdj625yF
         p63muIh7ZGfh0wbACrlfY6yZd8enxDkmy1sNBitA2deldkYFD+SVO75BC6CMCRynxwvR
         0Z6xwyu7tMsyxy7beb5WWGdJ826qlpNoSCo4OmssxQTF9WZ7+7ON5s++P9W0e+TBT3gN
         2Yl3h4reRCHwaB2TcCik3TaHJ73NPNSFcMjuJx1KPeHVP6VYru9eD+jnnu1PTIBKrokj
         YtKA==
X-Forwarded-Encrypted: i=1; AJvYcCXf0p541UCw/kUbtGktmL+X5yDLqFQT5nqsEHSOsVqNuZX9f4VPn1Y1iZdGjg9eHWV9AXpoSRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIjYML5kukSSqK1bRI7rQAYapNGg22r0udQvPcNCjnrMK2SwWU
	BhEJZeGFJIAPBYhl5+y9A3zFEW6queGLnnbtVo6h+B9IYDBRIKxxHclqRoSMuYo3ZgxyT0Pyn6V
	o
X-Gm-Gg: ASbGncsj0JgmRffZYRz6jKsg0vAyLPfVbq6GeJpYVPfQtEscNJSR3IP6i/oDJzpdxAV
	hgyQRdZ9pI38ewA8/SQDwZukjfu3vG2w13FW9s04WUiaRrWTFwg6WA+PZAie5beAI8IQSd8kNrs
	qclQBwoNrlwXN+v168AvEVaNWC+g41Lkt1ILxhaMgMex/CijrMl4LY90S/yAOWViOLm3R9STdwp
	mvtPMwQRrMP3Bq/0OE+8e4JnbItRq8pO7C0vkmpYjGi1MVehmF+hpkxRSd1xZC13n7HJRfccjlw
	dn226y0=
X-Google-Smtp-Source: AGHT+IFt9bSu9TeKmbNqZLuzawoA1KRNOT0MdH1uAzSAQgFpBd6hkgNmQn+ifhCVqBmpC04nxuRvlQ==
X-Received: by 2002:a05:6512:1385:b0:53d:e5f0:32de with SMTP id 2adb3069b0e04-53e2c2f0014mr1071590e87.51.1733492368872;
        Fri, 06 Dec 2024 05:39:28 -0800 (PST)
Received: from wkz-x13 (h-176-10-159-15.NA.cust.bahnhof.se. [176.10.159.15])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229ba710sm503058e87.140.2024.12.06.05.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 05:39:27 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, kuba@kernel.org, f.fainelli@gmail.com,
 olteanv@gmail.com, netdev@vger.kernel.org, linux@armlinux.org.uk,
 chris.packham@alliedtelesis.co.nz
Subject: Re: [PATCH net 2/4] net: dsa: mv88e6xxx: Give chips more time to
 activate their PPUs
In-Reply-To: <518b8e8c-aa84-4e8e-9780-a672915443e7@lunn.ch>
References: <20241206130824.3784213-1-tobias@waldekranz.com>
 <20241206130824.3784213-3-tobias@waldekranz.com>
 <518b8e8c-aa84-4e8e-9780-a672915443e7@lunn.ch>
Date: Fri, 06 Dec 2024 14:39:25 +0100
Message-ID: <87ldwt7wxe.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On fre, dec 06, 2024 at 14:18, Andrew Lunn <andrew@lunn.ch> wrote:
> On Fri, Dec 06, 2024 at 02:07:34PM +0100, Tobias Waldekranz wrote:
>> In a daisy-chain of three 6393X devices, delays of up to 750ms are
>> sometimes observed before completion of PPU initialization (Global 1,
>> register 0, bit 15) is signaled. Therefore, allow chips more time
>> before giving up.
>>  static int mv88e6352_g1_wait_ppu_polling(struct mv88e6xxx_chip *chip)
>>  {
>>  	int bit = __bf_shf(MV88E6352_G1_STS_PPU_STATE);
>> +	int err, i;
>>  
>> -	return mv88e6xxx_g1_wait_bit(chip, MV88E6XXX_G1_STS, bit, 1);
>> +	for (i = 0; i < 20; i++) {
>> +		err = _mv88e6xxx_wait_bit(chip, chip->info->global1_addr,
>> +					  MV88E6XXX_G1_STS, bit, 1, NULL);
>> +		if (err != -ETIMEDOUT)
>> +			break;
>> +	}
>
> The commit message does not indicate why it is necessary to swap to
> _mv88e6xxx_wait_bit().

It is not strictly necessary, I just wanted to avoid flooding the logs
with spurious timeout errors. Do you want me to update the message?

>> +
>> +	if (err) {
>> +		dev_err(chip->dev, "PPU did not come online: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	if (i)
>> +		dev_warn(chip->dev,
>> +			 "PPU was slow to come online, retried %d times\n", i);
>
> dev_dbg()? Does the user care if it took longer than one loop
> iteration?

My resoning was: While it does seem fine that the device takes this long
to initialize, if it turns out that this is an indication of some bigger
issue, it might be good to have it recorded in the log.

