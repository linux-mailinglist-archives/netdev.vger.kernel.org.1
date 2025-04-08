Return-Path: <netdev+bounces-180152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB184A7FC39
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 12:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6E219E24E3
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 10:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B572673A5;
	Tue,  8 Apr 2025 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4KaATRB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B9B2206A2;
	Tue,  8 Apr 2025 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108068; cv=none; b=e9R2+rOGyw9+35Ce3Xqvldvhc7p47+xoT/sG5cuknEKkSXJo9Oyg9L/b93qrsJZZoQ5+w8YGFDHyFUc+M1WLDG2O6ZhFQDBg7/RJq3j+soMrrBGpO3zbu8QK0oDi3q668+R2QOL1lOKNbQFD3bHPKmXGgtXPVQ5LcWHAKila1sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108068; c=relaxed/simple;
	bh=55pQGynFM4wtuXYkI645m3WSHyqcML9JlbuwZDktbQo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=NwYozSE2XbCabFz1FnbJ89IWsdW9xiaaMmP6NXEgG6qGPEnc6LgzdX5hk5zC3+9OWGUHJnehvY3J/2yeStpl2nZtdiwp5EjUO+Hv/IKdbpt5zVX1i0B5JBkF16Elrh4nqqCizzM2DToVnIlmYsWwzgg+1Bv1O/JvwUa2So//T1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4KaATRB; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb1eso4290505a12.0;
        Tue, 08 Apr 2025 03:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744108065; x=1744712865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jGiyWeDa8kC0ZVxGs+nfc1I9cal+4HHVVTISi0JKBxI=;
        b=U4KaATRBPGRTmzRw0AhfCYN0Cg2ccpFCGTr6nK2ecMuRO3e6Nv9AH3l4qpdW2eCwY0
         IfOKwU+f4bjhNu8Jk1a8t/1T/TONhudcCq3QRRjxQzQAztr0bXEgw9Nkfq0NPURF5QeF
         EIGJTxRf9wQAbepDuBdbL4xZg/yiNy/N9EdvTO7GIvH7zboQ1djIWdiDGJ5HQLa/eYIn
         NmzmKXWyVZoqQRPHa4W5TaZJNPl2cafe3GY7V+Tuklc06h3KiVIqWvEeBqbm8bTSmcWT
         pHBOVX/A5dCObkJbM6Qmdxjqv7RuRLJDNqVpe58//0id+Ddu2LscZBRDZ9V5zTkYFNQs
         H1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744108065; x=1744712865;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jGiyWeDa8kC0ZVxGs+nfc1I9cal+4HHVVTISi0JKBxI=;
        b=mxJfNQ9pdU6yVDaF54WITyw7KJkiklJHS4PjIinjiIKbqoXPOPU6O9x1Wi6slu/qvo
         doBEXBMJ5OY0BNyEDWWIyNMIl/+V8D6mdqPoRqpnBUvZnVnyCaLcCH1LTaEg3Rv4nEA6
         Sv5oZp3h88o2g0oALkwBf5NaMNaT7MCYMf5Q3qi1w3Im1jxAmjVFij1qM9frM0hU7t3Y
         OeFxBiTxwaX0MB6NNrGNcaTfm5VmXOotPDtBfTxK+MGEVAHSLCzkcSDB3a1qR26pJftM
         l9JnaE4p/6idvL61Hp0NWvnAty5EEZXKQE5xZhsT5PAMKEvjrZE2sfPVQcDdxRWTgpC5
         yHQg==
X-Forwarded-Encrypted: i=1; AJvYcCUF4CY+UC0i7bBdxdtyC2hpKcmpixfYU2DcsC5BerXOYFBlWvVOS2bPyYCwZFJDkUZx54yOuddofhgB1jE=@vger.kernel.org, AJvYcCUbUkQKRl/2ASgtDTLMC2gE/SikAJcyC4ZH6yGArvVxND867b0asgNfEs7am3TW0tTiatQeH5St@vger.kernel.org
X-Gm-Message-State: AOJu0YykXW8co3sQxWMxeXP8ZWhLE5JabHtKDZXJnssx9yEREcLsA1Vb
	Mr6Q9N0OrNB55RcBNmpuInDIVWK4mmYCo/o+KRew5r7JRd8QHzwM
X-Gm-Gg: ASbGnctxcEz2op3O5W+oajO0zMU3m5H/RACXRoT/5ISZCOtxd243Jhs/H6rhzHBi4vo
	p9YB/dOLkbfWA4N9FdwLQukpn6EUz3C1jp1chue75iEZLDknQEV2Wk3XCxlpN54GV3HQU2VIKcf
	nDyjnTU/Ux8aSbHW6jwPLQtfUL4BUDMs54ZOAmAZqi5eWnkVhdDvzu19LTpysoA6T2vsNp22SC0
	M5uq+dT+EceqPQJpnBe5bbaItdIt+DebGK5HzExsRrJhMMmtIeeWdA4nCo77QX5Pm/EOd6c2kXi
	Z6p+d2fkUxFtDFNNHzrSaKEIAE7/Suy6jYgHCptvMkRcqSOPPRUT5Gz9CtD2SRgnQ4H8R6CpMy3
	V7X1pbx3AFFncSHM=
X-Google-Smtp-Source: AGHT+IFNQPp+qYWbfZqtkO0DEQ4a/+aygcjR+F/2tuyTVx3+WT3NZI9Vjq8T/3P5ANkJJknNFqN8tQ==
X-Received: by 2002:a05:6402:3483:b0:5e0:8a34:3b5c with SMTP id 4fb4d7f45d1cf-5f1dc4abc3cmr2630481a12.0.1744108065220;
        Tue, 08 Apr 2025 03:27:45 -0700 (PDT)
Received: from [127.0.0.1] (217-175-223-214.dyn-pool.spidernet.net. [217.175.223.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f0880a476bsm8016752a12.72.2025.04.08.03.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 03:27:44 -0700 (PDT)
Date: Tue, 08 Apr 2025 13:26:38 +0300
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Muhammad Nuzaihan <zaihan@unrealasia.net>
CC: Slark Xiao <slark_xiao@163.com>, Loic Poulain <loic.poulain@linaro.org>,
 manivannan.sadhasivam@linaro.org, netdev@vger.kernel.org,
 Qiang Yu <quic_qianyu@quicinc.com>, johan@kernel.org, mhi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: GNSS support for Qualcomm PCIe modem device
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFEp6-2_+25Z+2nPOQtOzJPgfJM8DAs2h_e6HTQ4fAVLt0+bwQ@mail.gmail.com>
References: <2703842b.58be.195fa426e5e.Coremail.slark_xiao@163.com> <DBU4US.LSH9IZJH4Q933@unrealasia.net> <W6W4US.MQDIW3EU4I8R2@unrealasia.net> <f0798724-d5dd-498b-89be-7d7521ac4930@gmail.com> <CACNYkD6skGNsR-AH=6TWeXLqXeyCut=HGJeWUadw198Ha3to1g@mail.gmail.com> <CAFEp6-2_+25Z+2nPOQtOzJPgfJM8DAs2h_e6HTQ4fAVLt0+bwQ@mail.gmail.com>
Message-ID: <BB06D58C-E27D-42FA-8043-AE767E9B5E91@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On April 8, 2025 12:13:17 PM GMT+03:00, Loic Poulain <loic=2Epoulain@oss=2E=
qualcomm=2Ecom> wrote:
>Hi Zhaihan, Sergey=2E
>
>On Fri, Apr 4, 2025 at 7:42=E2=80=AFAM Muhammad Nuzaihan <zaihan@unrealas=
ia=2Enet> wrote:
>>
>> Hi Sergey, Slark,
>>
>> Using wwan subsystem and it works without issues, maybe i might miss
>> something, perhaps the flow control but i never have any problems even
>> without flow control=2E
>>
>> I am using gpsd + cgps and xgps with a small modification to Linux
>> kernel's wwan subsystem in the kernel to get NMEA data=2E
>>
>> I had posted the patch previously and i can post the patch again if you=
 like=2E
>>
>> Attached in this email is the screenshot of cgps + gpsd=2E
>>
>> Maybe it should be in GPS subsystem but it's working for me even using
>> wwan subsystem for months now=2E
>
>Yes, I would strongly recommend doing the extra step of making it
>registered to the GNSS subsystem so that device is exposed with the
>correct class=2E
>From WWAN driver perspective, it will not change anything, as we could
>have the WWAN framework handling this properly (bridging to gnss
>intead of exposing the port as wwan character device)=2E
>Sergey, is it your plan?

Yep=2E I made the prototype exactly in this way=2E So a modem driver shoul=
d not care about the port type=2E Just call WWAN core and it will do the jo=
b for the driver=2E

The prototype is done=2E Needs some polishing, proper description, and pro=
bably, today night I'm going to publish  the RFC=2E
Hi Loic,

