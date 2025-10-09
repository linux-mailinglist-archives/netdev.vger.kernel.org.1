Return-Path: <netdev+bounces-228316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD49BC772C
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 07:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AA0B4EFFBF
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 05:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A790261B7F;
	Thu,  9 Oct 2025 05:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgwPnMC/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE352609D9
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 05:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759988329; cv=none; b=TPBUrUJs0nVE0ookWFGmVDIPfNdbMGkKjvuXiOSzJhU2Eph55W5gecuoBPMx2yiLT607xrUmy8Vp9dIpd6HfxMPQ6wl/oIWQIXOok+TuXNCrSs7oCK3HFlc71uyV8c6Ad8ZXueIzaKmNop1oX8uwqeSvfN9A3i+0EdEOpWGoE9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759988329; c=relaxed/simple;
	bh=npR5+hdrCx438MidrYA4MYFDxbFLQwa9+iFgs/BnSQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krgLCAnuqusZj24lSb+h7+dBWq+vzMlVtUoq7USlE1Ms+kTxsEiwQJXOHCZn3wCQaTWV5AgBHaC2ztuoVvaN5HVZVexAE2b3Su5wY3Prbw1g8GoldGBc3VnuLnt2SsPQ+7Egajw0MmlTeS9lCcYMXdhSzvgJN3Q73rD8oEJUijY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgwPnMC/; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77f5d497692so684942b3a.1
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 22:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759988327; x=1760593127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aKbCLdA0D3ZyyrFcf4HmlfoknTM5HGR4JdTF6XUV7wY=;
        b=GgwPnMC/5b7I4MiftvL4t9BJjpH5GOyIo74rEteiiesxPSVrFENSx1m83eXCLspkM7
         w7p/dXj55rMPH8icSGq1nUZS4W6wWsEGGS+j9X69BMDOE/HvZbNlDDiPX3wJgbXBU1pg
         3mz1E6auBbLHqkmvbMz8WEOcTeDtYK4zJN524dONEf18ZNprdbFrucgaf5GZ7YBRT+1e
         LATpWP3xvoWk5MI+QaeQvKhdhjuFQMhzd08g+o/AUrXPviPyH8Cas/eShcKXxNEAB8vW
         GHvtk3rNFJFR5xdzL9UX5dfhJaHPjaYFQF6fAM+1h55M5q8tsMsLMHRnfvXFfw13/z0f
         8ZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759988327; x=1760593127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKbCLdA0D3ZyyrFcf4HmlfoknTM5HGR4JdTF6XUV7wY=;
        b=fYw61zlGnNgbpVv/noRizg1bXhAhX83A0KrDcb7YRzgmdyU1O5HhjGeZl5Ker0ebI5
         KatWODR6dHXn+ycsllZafqdOFnFMnUCn1rKQwbQAuaqkCZCYW1hDtClRnduqWLL0kEFW
         7+bead8/LA7dPmwUUD3sY3rHW+U+dE/HKbLB1t4FZ8pBDHewGzSlq2BNXEBiTAcFXWSi
         gA0NufktlRWoEw1dr1fEyyrujJXEu9Uw2NveG3EkvQ09wNqSS82q6gZaFnKAy1SR/TUW
         uQFNsZ1eVBj1gYbxOkXAatAbggngBnIMeFCqgy4y1nwKaA1i9nruHSkH3/HureU3vGbS
         BLBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDfi9UK69R+FyBt5sHr4DFCI77zl7VDAI6HFHk7XsXsGeZnTzzZ0Ds/UZ1be/5uYXRhf6dtB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZgnide1LdKdZSj4/LlSUq4JuOl+ZApI5Q8AiqeQt7Pmhu7/Of
	2DxSAUsxIN8OCFaTkssEHJE/0QhS+5gBhJRR0cYqhykPMIiimMLadCpf
X-Gm-Gg: ASbGncvtMhCNDuXD7utY3sv/LmVl02EXSI7gfHqhDA6AwQ1MTIlD8Z0gf904zDVqVnB
	PeAe4RXWpGANKc8Xnu9tPT5pKHAN9CY2OzoaAk5EvbaMGK+y58NnvA0gSiK9UEd9ELo65pfeZa5
	9Ubxw6Uxkkeol+N3ImeBdiVyT+kpBKjkRnGnOesLzBG43YolGUkTEuDMeXN9p3gdhb6vOCOMTim
	NZGqcd5zGk0/77dUfkTBAyFkfovI74TpvKALixAMJkhd5DKtrnsPK6hB/+TAbmt3WeN13mOhDET
	LIS1YHBiZDnW39h8MtjL91H7fV7DBcLqQLgmOZScBJutXANcHlX0CzDN1ROLr9tXkjzM8vehpsj
	Dao+cf/uYPDPOJ+xtPJKr5mz/+0TUq3CmviDUP2IoeMLkE6lZ94UYIGJFdUy4Xqtj7WI=
X-Google-Smtp-Source: AGHT+IHZ44y6ZFCxVyEDZOYJddPo2NG2UBmtyjURIoIIViVofpipLRjydPLmmlTTcL3OK6IoivH0yg==
X-Received: by 2002:a05:6a21:33a8:b0:32b:70a3:afea with SMTP id adf61e73a8af0-32da80da519mr8783258637.3.1759988326785;
        Wed, 08 Oct 2025 22:38:46 -0700 (PDT)
Received: from [10.0.2.15] ([14.98.178.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b51113776sm5508816a91.14.2025.10.08.22.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 22:38:46 -0700 (PDT)
Message-ID: <5fe7d13e-e608-48a7-8205-514c461a145d@gmail.com>
Date: Thu, 9 Oct 2025 11:08:40 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usb: lan78xx: Fix lost EEPROM write timeout
 error(-ETIMEDOUT) in lan78xx_write_raw_eeprom
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 khalid@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251004040722.82882-1-bhanuseshukumar@gmail.com>
 <2025100407-devalue-overarch-afe0@gregkh>
Content-Language: en-US
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
In-Reply-To: <2025100407-devalue-overarch-afe0@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/10/25 11:21, Greg KH wrote:
> Hi,
> 
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
> 
> You are receiving this message because of the following common error(s)
> as indicated below:
> 
> - You have marked a patch with a "Fixes:" tag for a commit that is in an
>   older released kernel, yet you do not have a cc: stable line in the
>   signed-off-by area at all, which means that the patch will not be
>   applied to any older kernel releases.  To properly fix this, please
>   follow the documented rules in the
>   Documentation/process/stable-kernel-rules.rst file for how to resolve
>   this.
> 

Hi,

Sent a v2 with cc: stable tag.
v2 Link https://lore.kernel.org/all/20251009053009.5427-1-bhanuseshukumar@gmail.com/

Regards,
Bhanu Seshu Kumar Valluri



