Return-Path: <netdev+bounces-228293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E37BBBC6A07
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 23:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D31224E6643
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 21:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C178027144A;
	Wed,  8 Oct 2025 21:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUo5r+Yv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B9C63B9
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 21:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759957256; cv=none; b=lJKYofAEut7moctTg/OIxSItNdKFMLzEobLQUGPDqBVwZ8wH5vsQdOR7sNvJMfHxAHu5lFErV5ur2ECRFZMwWY/xa2cXgd5VIRaS33P3MtPS5Bb3+Edd+pkozW4NWgdSEDZzbYc778svopf+pqJunKUcZSwLNt3wRfh6uGe9Os4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759957256; c=relaxed/simple;
	bh=pRL8X6g/JNIzyq3rX8jCPnN6sN4MMYLqCFa7F9Rvi/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PH4mKaUXaqr/ODl70faw02oweqycs8ZfUBxcyRRL6j0LiB8tla6JEbSjM7kKesExEkX4u/E3Zc9FhOZeL0PFM6AnSKiqKgTQyQZjd/JkWnCSOUiEiCvwp1hXOlQoXZX0kJhL7wPKEadBqZT7I3m9tfGW1jL1mGP4zpdF42G+lLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUo5r+Yv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e29d65728so1628785e9.3
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 14:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759957253; x=1760562053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iDtrklrAr4mznIm9uSd+HNwwkADRfaXuYX4tg0l21Tc=;
        b=RUo5r+Yvjg7xi6UD5umxKmzaU9yREUFyTz3eMhdRtvgg5Sh+wu1FEWsF6Gc+cKVsy8
         jNuMw2149HitwMULEUJ55dZXh6aA7Dk54PHhmIVKGPUnbGwgVV/4zvBsbX4YEjNI2Hk5
         K3/ahQV0KWwL2sipbsAFpWLHs5bLv+JBgpPiCoB9TS+czRWesYVnzrEHjs4hnFBgsZMA
         oODlcopty1fd6IOb6+ABC9m4lm1i1R/+BpUURvSFUt1pzu8zQwMpFwU/qT9UM3MNQ7vX
         PtvlkkJjf2gZV5QPOoOIRmF3mkMMaPWHKpA979ACyTVIY5+TD65i9niuAuOh7YsfOOWd
         t0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759957253; x=1760562053;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iDtrklrAr4mznIm9uSd+HNwwkADRfaXuYX4tg0l21Tc=;
        b=NJ8DgOZwe43uG2j/1QqRHkdlgtuBB+QGZwEi7vl8+fVBQwkDJppUB7H2kZmUE1gGlr
         aHixqnk0diyjFGNBZlX3vjdilnldWPb6WBsSIlz+hVgqGuDA9IT82DkFRDrERMJqc3YT
         Gq8996XylJyCw3OrwCna+/+zfv1dxXMiLnDfwgznGvyG0rpS/RoxK6p8UD2mcuX+sUSo
         qw7L52oHTAmHTu4pYOHEWMxrdjhsD4tRQrD1STZ5FDERLI16jECsCdWFmIcWezoVT8/V
         Lus4LwKKMDpWRTrJe1EoiYIUzQbbPGJrdbie3PPWR/hAxYv4E6z15/D2d6iTdpGtDHPp
         1CaA==
X-Forwarded-Encrypted: i=1; AJvYcCXiviiahOPWwhJcQb0FQ1xyU+acKNpF1hzqdoTYQ3URgXmB3PMmuBDxcwYd1ROA9cjkmtz44Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTuDoPnLFl2tNVLvodTPL8hKKZRamONTeFkXdf3wv8J3xnCNc9
	UTne9LkxlpfpcghG3kOHHGHogySiEwcZG7V6BCKLZmyonKnJDENzsbmk
X-Gm-Gg: ASbGnct92WXMSXM7RBLc1cLbZsIxQ2id/b+KjZXpTlvdXfqajLY8tu4Hk2T795N1nba
	Eh7u+Bbp0Sd+i1OKwbAy6eT7tbqQfQwhId4FNYRaXRQWkN9MdJEH9cyHUUo+zSd1cYSGrppfm6o
	EGZdTrsffsbENqHzWyDaYtD3tE1w1gy2A9oWOU/Lg+2NViJxyqh1iCxN4kzIkf1dk7GfstW6qyu
	DnM3l38FRHbmyR/28pDI4k1a/dgWbrXQsVioIn3ifO92MaoI2bvd2pLfKYEpcc59RfevrZAYxeX
	AZ26X/C9LkuNNDW1I41YYhfztIa3qrFbriczVvuzg3v9bHDmwX/dc6nkyOsnEUZi3iJe3hX0nd8
	40L5ZONjlaRqKYYYVL1zqxk0UOo0ZE3x834JlueBy+U72o6/8Rw==
X-Google-Smtp-Source: AGHT+IGxb+Gz6EO3staHdhdodqj43F45MH94LfUZB042J+LwlrewlC590Azvrh2TBXThOGOjxCTndA==
X-Received: by 2002:a05:6000:18a6:b0:3ee:154e:4f9 with SMTP id ffacd0b85a97d-4266726c2d4mr3070052f8f.20.1759957253025;
        Wed, 08 Oct 2025 14:00:53 -0700 (PDT)
Received: from [192.168.0.4] ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab960sm31407880f8f.13.2025.10.08.14.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 14:00:52 -0700 (PDT)
Message-ID: <16c0b1fa-9617-4ee1-b82f-e6237d7b5f6f@gmail.com>
Date: Thu, 9 Oct 2025 00:01:00 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/6] net: wwan: add NMEA port type support
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Daniele Palmas <dnlplm@gmail.com>
Cc: Slark Xiao <slark_xiao@163.com>, Muhammad Nuzaihan
 <zaihan@unrealasia.net>, Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Qiang Yu <quic_qianyu@quicinc.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Johan Hovold <johan@kernel.org>
References: <20250624213801.31702-1-ryazanov.s.a@gmail.com>
 <CAFEp6-08JX1gDDn2-hP5AjXHCGsPYHe05FscQoyiP_OaSQfzqQ@mail.gmail.com>
 <fc1f5d15-163c-49d7-ab94-90e0522b0e57@gmail.com>
 <CAFEp6-1xoFW6xpQHPN4_XNtbjwvW=TUdFrOkFKwM+-rEH7WqMg@mail.gmail.com>
 <e8d7bab.2987.19936a78b86.Coremail.slark_xiao@163.com>
 <19a5c6e0-fd2a-4cba-92ed-b5c09d68e90c@gmail.com>
 <317b6512.6a9b.1995168196c.Coremail.slark_xiao@163.com>
 <CAFEp6-0jAV9XV-v5X_iwR+DzyC-qytnDFaRubT2KEQav1KzTew@mail.gmail.com>
 <CAGRyCJG-JvPu5Gizn8qEZy0QNYgw6yVxz6_KW0K0HUfhZsrmbw@mail.gmail.com>
 <CAGRyCJE28yf-rrfkFbzu44ygLEvoUM7fecK1vnrghjG_e9UaRA@mail.gmail.com>
 <CAFEp6-18FHj1Spw-=2j_cccmLTKHDS3uHR4ONw8geiTyWrxN2Q@mail.gmail.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <CAFEp6-18FHj1Spw-=2j_cccmLTKHDS3uHR4ONw8geiTyWrxN2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Loic, Daniele,

On 10/2/25 18:44, Loic Poulain wrote:
> On Tue, Sep 30, 2025 at 9:22 AM Daniele Palmas <dnlplm@gmail.com> wrote:
> [...]
>> diff --git a/drivers/net/wwan/wwan_hwsim.c b/drivers/net/wwan/wwan_hwsim.c
>> index a748b3ea1602..e4b1bbff9af2 100644
>> --- a/drivers/net/wwan/wwan_hwsim.c
>> +++ b/drivers/net/wwan/wwan_hwsim.c
>> @@ -236,7 +236,7 @@ static void wwan_hwsim_nmea_emul_timer(struct timer_list *t)
>>          /* 43.74754722298909 N 11.25759835922875 E in DMM format */
>>          static const unsigned int coord[4 * 2] = { 43, 44, 8528, 0,
>>                                                     11, 15, 4559, 0 };
>> -       struct wwan_hwsim_port *port = from_timer(port, t, nmea_emul.timer);
>> +       struct wwan_hwsim_port *port = timer_container_of(port, t,
>> nmea_emul.timer);
>>
>> it's basically working fine in operative mode though there's an issue
>> at the host shutdown, not able to properly terminate.
>>
>> Unfortunately I was not able to gather useful text logs besides the picture at
>>
>> https://drive.google.com/file/d/13ObWikuiMMUENl2aZerzxFBg57OB1KNj/view?usp=sharing
>>
>> showing an oops with the following call stack:
>>
>> __simple_recursive_removal
>> preempt_count_add
>> __pfx_remove_one
>> wwan_remove_port
>> mhi_wwan_ctrl_remove
>> mhi_driver_remove
>> device_remove
>> device_del
>>
>> but the issue is systematic. Any idea?
>>
>> At the moment I don't have the time to debug this deeper, I don't even
>> exclude the chance that it could be somehow related to the modem. I
>> would like to further look at this, but I'm not sure exactly when I
>> can....
> 
> Thanks a lot for testing, Sergey, do you know what is wrong with port removal?

Daniele, thanks a lot for verifying the proposal on a real hardware and 
sharing the build fix.

Unfortunately, I unable to reproduce the crash. I have tried multiple 
times to reboot a VM running the simulator module even with opened GNSS 
device. No luck. It reboots and shutdowns smoothly.

--
Sergey

