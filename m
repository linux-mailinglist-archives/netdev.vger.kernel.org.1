Return-Path: <netdev+bounces-222851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5D2B56AAA
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 18:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC223B4766
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 16:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A820F2DC33F;
	Sun, 14 Sep 2025 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHGwqBw1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83AE36D
	for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757868188; cv=none; b=c4n6I5oXFC57wIAZqJAogNjYstLzOHs/swEcaN0AvMRLdjciPLYkSA66SaczcG8inOoX86wLEn1Yojya0I0EjMMB99zArDKYRfBDY8SnT3cfMwvWvQGdr9hLz5BHv2Lx6L/qYAHiL8pGmEg59Uj+ASjP21uqORhIZfyN05gQ2pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757868188; c=relaxed/simple;
	bh=gmD0HzaKEAJA4/H1v5sZTQ7HPLWUvqCjdJJapXdaXgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EDrxP/XbKtNGZWjat46InyO+f0yYyhmerJExc4pnlpFrktm395tAXplcUFC/Xr3eS0lY+ZHGCP5Us9YbICqto/TBVHxCyi5MydM/JpEUFl5simU2pQCo8Z7Vlg4iQuGhQgh050aBON89SxJ1vVGiEFVR4WbOqnXrEvkDCkNYNNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHGwqBw1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b9814efbcso28410425e9.0
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 09:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757868185; x=1758472985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a5sRJy3qAmAfXU+WhhDH3bHXcUhrA6DpIuGwD63nvI0=;
        b=fHGwqBw1n2CGXqkRomIDUmsr9vZZevt5FiSQLUQYlneTAm277PUWFpEKWIWUDhz3jv
         bRA2p9VRQQbTNsErkwf3u1t/fW5voUtySybOL0/XXIuT6eh3CgB86S0ZHpNVnLKTP8FE
         ZG0xZ5I99BMe6MkIm+eh0I6v6+loQ3vGtu7cl6ZYFapCFJTikml5LxQYsRYVyMCE/uR7
         SSW/Kb4Jxdyn1MVpp3hnjF3qyt/s02ixTXHCpUd6d8TIcOytk2LKSqNS9swM5XvF2C5k
         rDfZwvPDY2VZ4EGWjBQRiQJK/ATFqwks04G4TunmKrJGUY2u/D1XK5shmykHn5vp4IwT
         PQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757868185; x=1758472985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5sRJy3qAmAfXU+WhhDH3bHXcUhrA6DpIuGwD63nvI0=;
        b=loQIwlbKrLZOFal5qr7w74XrXV1dFkiBeFrtDzUM16a3TRvpIj7nk7YoXV+OPX564r
         xES1PhcmuWjbPmbO0e9NrRWrLi3yixZhobuRGfESuTL2R4ILRmdamu3EOTtvTm3PLWkt
         qHdCd9Dt+6EhmMshQ7OL00GQGJ8M+QXDjcc7rXCi8h1Bl0Z7YgsFSHJ7mo5abXnnFCUl
         CwRkDGYtmstvHBKdVYTo17fZuCVMOkEUCMwATwhF8eS3RKO7TQ3hIzjHjTMUuI89w1UF
         eI2SG0OqbGD0o8LEluEhUrcObbDeDaaE7CHuGnDCeEe+yU2G/8aI/qYpvn4M4Kn529em
         8hwg==
X-Forwarded-Encrypted: i=1; AJvYcCWk+Ol1rZ7oZa+pTTWEftOm4Eo758YmNF250SBuy/jDE8Ktg+HZJzrpOm6NX1BuVcRlyKaOerE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoVf68UeBGkO1o4tnEUDpZqhfmYv9qzFWvBfnE26nrScJXkvqt
	Cm1ZJAUVWH7f8n5805+YEIFT3842sRzVFC0w2OY0yktmeU92g/x9pabY
X-Gm-Gg: ASbGncuC1UDCTEFrRxCxaXNpU29tiTgM4M87fTSX+mFqK8KjTwAeBHOWK4NU/blBvgo
	TAw5ZuhVREPZJBtO03YAnFrofzmpnFZLyUqiOMYF/vziJs898T1oisKQ7lF6+DDhIuvDBjgzNe/
	P6nNxxtnvCArO//YOCvG2LGVOXvgKBSmdLtBQunSJqISgHpumHn5NRzvlO1nQD5w2pDRxWh60B1
	g8MyJ5YeQZC4LZYn3FQ9QzaWCEi9MqjuF+6OgX+LaR7mR62oKEKYrRYCulBNSJR4f3gk9VDJLBn
	Om3QkTVAbB5VdFYEzNsSNppd6DxxC2BSC5PF1MG9cZmwKBQUSWUtAo8r+2/jGln72HGG4vn/HXa
	Hg95Yp21cdV5c22PVyKHMDZY0EjzueaCT1SX7
X-Google-Smtp-Source: AGHT+IEFPi41NYRy0htk9U8poxQa8lMwb112Ee+UU9w88k/Ude64f71Tk0lt67UG+fzYoA6Pz99sfQ==
X-Received: by 2002:a05:6000:2203:b0:3ea:c893:95b6 with SMTP id ffacd0b85a97d-3eac89399f3mr371488f8f.27.1757868184775;
        Sun, 14 Sep 2025 09:43:04 -0700 (PDT)
Received: from [192.168.0.2] ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e8c7375fb7sm5971558f8f.14.2025.09.14.09.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 09:43:04 -0700 (PDT)
Message-ID: <19a5c6e0-fd2a-4cba-92ed-b5c09d68e90c@gmail.com>
Date: Sun, 14 Sep 2025 19:43:05 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/6] net: wwan: add NMEA port type support
To: Slark Xiao <slark_xiao@163.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Muhammad Nuzaihan <zaihan@unrealasia.net>
Cc: Johannes Berg <johannes@sipsolutions.net>,
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
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <e8d7bab.2987.19936a78b86.Coremail.slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Slark,

On 9/11/25 05:42, Slark Xiao wrote:
> At 2025-06-30 15:30:14, "Loic Poulain" <loic.poulain@oss.qualcomm.com> wrote:
>> On Sun, Jun 29, 2025 at 12:07 PM Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
>>> On 6/29/25 05:50, Loic Poulain wrote:
>>>> On Tue, Jun 24, 2025 at 11:39 PM Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
>>>>> The series introduces a long discussed NMEA port type support for the
>>>>> WWAN subsystem. There are two goals. From the WWAN driver perspective,
>>>>> NMEA exported as any other port type (e.g. AT, MBIM, QMI, etc.). From
>>>>> user space software perspective, the exported chardev belongs to the
>>>>> GNSS class what makes it easy to distinguish desired port and the WWAN
>>>>> device common to both NMEA and control (AT, MBIM, etc.) ports makes it
>>>>> easy to locate a control port for the GNSS receiver activation.
>>>>>
>>>>> Done by exporting the NMEA port via the GNSS subsystem with the WWAN
>>>>> core acting as proxy between the WWAN modem driver and the GNSS
>>>>> subsystem.
>>>>>
>>>>> The series starts from a cleanup patch. Then two patches prepares the
>>>>> WWAN core for the proxy style operation. Followed by a patch introding a
>>>>> new WWNA port type, integration with the GNSS subsystem and demux. The
>>>>> series ends with a couple of patches that introduce emulated EMEA port
>>>>> to the WWAN HW simulator.
>>>>>
>>>>> The series is the product of the discussion with Loic about the pros and
>>>>> cons of possible models and implementation. Also Muhammad and Slark did
>>>>> a great job defining the problem, sharing the code and pushing me to
>>>>> finish the implementation. Many thanks.
>>>>>
>>>>> Comments are welcomed.
>>>>>
>>>>> Slark, Muhammad, if this series suits you, feel free to bundle it with
>>>>> the driver changes and (re-)send for final inclusion as a single series.
>>>>>
>>>>> Changes RFCv1->RFCv2:
>>>>> * Uniformly use put_device() to release port memory. This made code less
>>>>>     weird and way more clear. Thank you, Loic, for noticing and the fix
>>>>>     discussion!
>>>>
>>>> I think you can now send that series without the RFC tag. It looks good to me.
>>>
>>> Thank you for reviewing it. Do you think it makes sense to introduce new
>>> API without an actual user? Ok, we have two drivers potentially ready to
>>> use GNSS port type, but they are not yet here. That is why I have send
>>> as RFC. On another hand, testing with simulator has not revealed any
>>> issue and GNSS port type implementation looks ready to be merged.
>>
>> Right, we need a proper user for it, I think some MHI PCIe modems already
>> have this NMEA port available, so it can easily be added to this PR. For sure
>> we will need someone to test this.
>>
> Hi Loic, Sergey,
> Any update about this topic?
> If you want to test it, we can provide some help on this. Also, I think the quicinc
> center may also do some test. You can contact it with Mani for further details.

Basically the functionality is done, Loic has reviewed it, while not 
formally acked yet. And it can be merged just now. On another hand we 
have no users for it. That is why I have not sent it as a final patch.

I was expected you, Slark, or Muhammad will take these patches, 
incorporate into a driver change that introduces NMEA port export and we 
can merge all together. Or if you prefer this series being merged first 
and then you will send your changes. In this case I need a green light 
from you that you tested this series locally and there are no objections.

To summarize, we have two options:
a) you incorporate this series into your changes and send a bigger 
series implementing everything from driver to the core;
b) we merge this series as it is, and then you send an follow up changes 
introducing a driver support.

Slark, Muhammad, let me know, which way is more suitable for you.

--
Sergey

