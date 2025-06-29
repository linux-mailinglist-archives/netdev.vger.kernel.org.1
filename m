Return-Path: <netdev+bounces-202218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E68AECC12
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 12:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 951407A2250
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 10:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B985A20D51C;
	Sun, 29 Jun 2025 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiUn5tCk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E030BA93D
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 10:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751191679; cv=none; b=dNL8DiYgPKE5pcydFKr4Dt4TcxxnAboSrAI1LZ55HWHXaWfQ6LmOPNuiWvh7T6i791QKYw40zG09QA69xNmS/D5+cMX9TG+keoFkdgvBlVPtkaaQZC7xl9W+XH5aaOe8pagLwCFxvwS633WvF93yNHB4B0WnkmAu/oLAZCjA1Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751191679; c=relaxed/simple;
	bh=7GEYdTQqezCSMpv5lf5/9KTCavIRfGkhfMPEZuuPXqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZqxAAWb5J+xJn+AV97JDoiRj8i4dnriGIK1pzG6K7VOkKdGs29NBBzJoM8XjdFXEcsVFmk7+7e/qpYj9dCIuIBuASzSKi3XQGXhV+lZyUoKM/ZMcBHgtHmfckFJmz0MDROQP4T/Hm6LGQT8vx6M3QnPxxJEG7HZU/njw3WxUlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FiUn5tCk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4538bc1cffdso11841145e9.0
        for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 03:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751191676; x=1751796476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fpRzu7rBrCDgnsJmQ1MLyQ0ZxCoYCHVRVQUuXbUsCG8=;
        b=FiUn5tCkuBNLQNe67UI6ONJIRsVcpr+i3v79/wbHnRl3Qt4JFFPdLWiBkyqb4lPyJP
         NOFiBhECK5JpFdg5yLHIS2zcyMWu3JRqobVH1soixwMvsy67EcDLkQnaXHxA/9W8waOd
         a7inPsMT5GZu5x94OWmJtpqwpOD1MQmJvFKu2BOVQ10Fjm985EYZgTx2sqDEdXkH/Sb3
         Y1lKkdowUvdOx++IQ7RHZvGgpbKXqyQ168JlSYQgkLS1b5swgLvTmPg7zhIA4vN98g+v
         y9U3lGg3xwlNyJ43QoBYetYp+Y2DM/EKW1AMO9642b1pIKwJVfGpQ6hmOZETYc/pJn7q
         5JuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751191676; x=1751796476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fpRzu7rBrCDgnsJmQ1MLyQ0ZxCoYCHVRVQUuXbUsCG8=;
        b=kyG7m+vJi7UAS7my/acd6dOOl8+GRftdT2cEs7QpkkEMa+J9Mb8AQGTU2AamfvefrO
         u8VSwwINcHtxx5T+h8LwNrbJgpowEdBJC5dc0S66TEEAGuF7GsSMuVW14VnY36DZmO2B
         4OwovAkIUsJlvZ+OpWhVD3Nwf3IoEzd7I1/U2rn7pXGxhf699H8QlCtH61Znkg7gnBmk
         8LOxdYwGq41xolN1X851dPybM6nSp4MxPS7/UaLBGrc460DGkqvFiK+1Hs5sos437Yid
         ysavAf4R3trXITjYsZOMFZazaKGApi5usIwdg2XfwBQBe9jLKc53FXHgoO/bxS7FW4dj
         y1AA==
X-Forwarded-Encrypted: i=1; AJvYcCVyUxAgxb3hPljEqAeQcKQzEvc5kEdeIbqgrQ0c/Sf8+FptLIOITb6dEXAEXK7a5rgAxzvvUY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIBXZc5WKrRE7J9OjZ37JJWr0IsCiuZSC9T4qPMgfP92epp58L
	/gvL4CdaK7bEHi3VHu5EuMY8b1hp398Ovusw8SvSvVMug86LdfQnSZaN
X-Gm-Gg: ASbGncuWs7WgkYWVXQPL9SRWKNsMCdBx2m/FjStMQLyYrGuaTOfOqxi2zWQynlnUMv3
	AwTlcVy1iVNXX234VNwTeKWAdYUq3Ny8yfT7+/ajNpHuDv5aHFRCJSysFHKO0juQbj7taEypVRL
	P/VUUxWv2L7bDHSr1rfxFZAj8GdToaPwzfJnwlndVlpBDtzCbU0vrOoJ6KAMSaR6oiInjmj9XVz
	U+a9N73eYxjY56rR1lBAiZCcCE0OrZGVrYLSu1ITym0s75kZDuhd3vlZGpt1J47R1P8m//Y5eI5
	cyz4DEUIrjC/Utnhe3z108HGoGYvOs/bc6xIvCwjij+MYTBCM8JbU8TpCRsPd7Yke+oUPC8cMvc
	+
X-Google-Smtp-Source: AGHT+IEBYU3tvo4Zc4VNVwURgtgrcmiZA+o9v1Pi5K9rpCqit7XV8wId8RqK+o3vjMvAooEc12Pn0w==
X-Received: by 2002:a05:600c:3b01:b0:453:745:8534 with SMTP id 5b1f17b1804b1-4539605125bmr48124635e9.12.1751191675964;
        Sun, 29 Jun 2025 03:07:55 -0700 (PDT)
Received: from [192.168.0.2] ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f918sm7352329f8f.100.2025.06.29.03.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jun 2025 03:07:55 -0700 (PDT)
Message-ID: <fc1f5d15-163c-49d7-ab94-90e0522b0e57@gmail.com>
Date: Sun, 29 Jun 2025 13:07:57 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/6] net: wwan: add NMEA port type support
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Slark Xiao <slark_xiao@163.com>, Muhammad Nuzaihan <zaihan@unrealasia.net>,
 Qiang Yu <quic_qianyu@quicinc.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Johan Hovold <johan@kernel.org>
References: <20250624213801.31702-1-ryazanov.s.a@gmail.com>
 <CAFEp6-08JX1gDDn2-hP5AjXHCGsPYHe05FscQoyiP_OaSQfzqQ@mail.gmail.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <CAFEp6-08JX1gDDn2-hP5AjXHCGsPYHe05FscQoyiP_OaSQfzqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Loic,

On 6/29/25 05:50, Loic Poulain wrote:
> Hi Sergey,
> 
> On Tue, Jun 24, 2025 at 11:39 PM Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
>> The series introduces a long discussed NMEA port type support for the
>> WWAN subsystem. There are two goals. From the WWAN driver perspective,
>> NMEA exported as any other port type (e.g. AT, MBIM, QMI, etc.). From
>> user space software perspective, the exported chardev belongs to the
>> GNSS class what makes it easy to distinguish desired port and the WWAN
>> device common to both NMEA and control (AT, MBIM, etc.) ports makes it
>> easy to locate a control port for the GNSS receiver activation.
>>
>> Done by exporting the NMEA port via the GNSS subsystem with the WWAN
>> core acting as proxy between the WWAN modem driver and the GNSS
>> subsystem.
>>
>> The series starts from a cleanup patch. Then two patches prepares the
>> WWAN core for the proxy style operation. Followed by a patch introding a
>> new WWNA port type, integration with the GNSS subsystem and demux. The
>> series ends with a couple of patches that introduce emulated EMEA port
>> to the WWAN HW simulator.
>>
>> The series is the product of the discussion with Loic about the pros and
>> cons of possible models and implementation. Also Muhammad and Slark did
>> a great job defining the problem, sharing the code and pushing me to
>> finish the implementation. Many thanks.
>>
>> Comments are welcomed.
>>
>> Slark, Muhammad, if this series suits you, feel free to bundle it with
>> the driver changes and (re-)send for final inclusion as a single series.
>>
>> Changes RFCv1->RFCv2:
>> * Uniformly use put_device() to release port memory. This made code less
>>    weird and way more clear. Thank you, Loic, for noticing and the fix
>>    discussion!
> 
> I think you can now send that series without the RFC tag. It looks good to me.

Thank you for reviewing it. Do you think it makes sense to introduce new 
API without an actual user? Ok, we have two drivers potentially ready to 
use GNSS port type, but they are not yet here. That is why I have send 
as RFC. On another hand, testing with simulator has not revealed any 
issue and GNSS port type implementation looks ready to be merged.

Let's wait a month or so and if no actual driver patch going to be send, 
then I will resend as formal patch to have the functionality in the 
kernel in advance.

--
Sergey

