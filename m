Return-Path: <netdev+bounces-178999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7DCA79E61
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 10:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06FAB173CEF
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 08:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0812417C5;
	Thu,  3 Apr 2025 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b="ztjyqZ9T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B377221DB7
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743669766; cv=none; b=t73/W/yNHo0O9m0Xib6O/ATkNZjbUE9VRmn5zZQTbD4P/YdWhwUYzvjC1gTgIAKSCQ9ydrvpv6uDr8nCqp+e+tbDa0DQKuB/y0PTTC5o0aGQqlvM/I8V6nqFMn/JlxihTnqadk2geLrWPxE8PnBXWmSFDaWSKUgqWgVMsfZw+FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743669766; c=relaxed/simple;
	bh=7aJm33v5icxCm0qidJHR4iPjTjoB6eUlKP7PS5rRpgo=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=monvSi44thA4rP+3G4uaHskO37j0PIoV9uCdiMi5Fb1En+oEfVeFxROwM07iHf1Q/Ecc/ggSiuJhdU6CZTHfFGoJnjff3UFwBPZYUKmV8Q2flPg0TyiQGly/BYaqv82F0doMAb9MZwXH6pV3Gf7RoVqcCbTBMq+65nYPN3D0fdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net; spf=pass smtp.mailfrom=unrealasia.net; dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b=ztjyqZ9T; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unrealasia.net
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2255003f4c6so6256245ad.0
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 01:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unrealasia-net.20230601.gappssmtp.com; s=20230601; t=1743669764; x=1744274564; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7xA35ksag9J2Xv4q27dqXCVSa6SSb65HZF1swwOeMnk=;
        b=ztjyqZ9TXGK29UdkScKH+W7ZqVArzkYxcekA9txAChAAFotFABxXPwfVRDA9srhUuq
         2tOjJsVr2En5p7OmePEDROoe63pxSjRbaMJ9n+4i+Rqc6lfG71W5OF2/3e/Wl5hGOACY
         ulIEI0vLZf9B5C5FZGGXrWTU5nwUTdXK27wZAdsA/4OPf1GUueJAAeLP1VQOF6aFCOaM
         Rm6HR850cCdHPAEgZtg3qHwlfOzNFiawwDvzjr1NFGUeTQxndBKS6Pcv0J5l0aCG5mwC
         A3p9PFfHzMCcxGlCgxPSgewIhdvOwXadg6Yw4A5+HAout/dwkRhwluXczd5bt/F0CuuD
         gIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743669764; x=1744274564;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7xA35ksag9J2Xv4q27dqXCVSa6SSb65HZF1swwOeMnk=;
        b=VYflRPR7Nk0TKetHvkGW9vsJeolv/ZxwJ8ZysayFkLxLi//Ze8fAtgZgO1XDzwwk4h
         ISVgpdJNW9YaUn5pe25+YxhvEYoR0VxRg01hYadUvbCYWNh2C7XuGc4xzqF+O54TSJ44
         P5jrPMFF8z419LpSAvtficRNJNNbObr90uyAE0E+5YP5W+OqoAI6jkjC0Y11OaGkwKz4
         ti5znH9BYDimLSxa/2ien9fpJkDG2qCghmYtGHa6DIA9SrMZNcm/FgKUh1mvNm6rkqsB
         QWhJ84oxL0dXhqSPMgvtJTgUU3mYMlOkwrPt2TLAZwgXoaN7x/PsT7YUanKroJanrPzp
         jYRw==
X-Forwarded-Encrypted: i=1; AJvYcCVBaQWr0XzttHgHLJRSDUaW26bv2Iy9/Ryol2f96vqSMXbcDE22+A5Xnfk0Pw7JxvYafEvk8/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGYRlZGmwKzV1DOOmCGjtQQ/ZLoPQcvYt4Z2CyliHyP1Jt3bR8
	xQdX++WvjbgV9ogmBy4JxCy01OXoHR7hPf82BsntRQ1ALkgLBQDj1ZufmiKLrSM=
X-Gm-Gg: ASbGncv61m7B9EC/bPf1Iv2fZo118NyZMowkAgP3L603CuRAdAyuZ1Kqr+riEP+Ehyy
	F6AzkFxVd1+xji/KTOzYyWs45CFmnBS1vKmxrFG6sRl+xA1nANmh/wjiP5fYxomCfRXqejZ7NCS
	ObmnZzxA5yRLQDcqVZT+GVMbXknsPc2DufNOZ5GFKk7GMdtYJx3sVM3fhJna2CKi7/iK5GiHiVW
	f27bQ35egCpTAlUYqYB0L4wJVCIuZ14ufzKIc7YtMbL/Y5SsxPLXXqn29ZXBOrpBPFpVJyb+cxE
	124k7Vklq58mafaxzEKImm9MCco3063ou5PoaU/kH1I6BaBooglmIlaEKLA=
X-Google-Smtp-Source: AGHT+IEjowCN4gXZXqm96TUY0x++o8jpRQdsEDVEgbhHSa9RgS155jbANLrw67GahxHTNTH1o9uHWg==
X-Received: by 2002:a17:902:e847:b0:224:b60:3cd3 with SMTP id d9443c01a7336-22993c0dcc3mr20120225ad.19.1743669764333;
        Thu, 03 Apr 2025 01:42:44 -0700 (PDT)
Received: from muhammads-ThinkPad ([2001:e68:5473:808e:fc9e:2417:ec87:2160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785c2566sm9173505ad.95.2025.04.03.01.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 01:42:43 -0700 (PDT)
Date: Thu, 03 Apr 2025 16:42:32 +0800
From: Muhammad Nuzaihan <zaihan@unrealasia.net>
Subject: Re: GNSS support for Qualcomm PCIe modem device
To: Slark Xiao <slark_xiao@163.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>, Loic Poulain
	<loic.poulain@linaro.org>, manivannan.sadhasivam@linaro.org,
	netdev@vger.kernel.org, Qiang Yu <quic_qianyu@quicinc.com>, johan@kernel.org,
	mhi@lists.linux.dev, linux-kernel@vger.kernel.org
Message-Id: <W6W4US.MQDIW3EU4I8R2@unrealasia.net>
In-Reply-To: <DBU4US.LSH9IZJH4Q933@unrealasia.net>
References: <2703842b.58be.195fa426e5e.Coremail.slark_xiao@163.com>
	<DBU4US.LSH9IZJH4Q933@unrealasia.net>
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Hi Slark,

I just implemented it in the wwan subsystem since it works for me (even 
without flow control). I wanted to port it to use GPS subsystem, 
however, debugging in GPS subsystem is too troublesome, especially when 
the driver crashes.

Unless i can have some VM with direct access to the Quectel hardware so 
i don't need to keep rebooting my machine if it crashes.

For now, i am getting GNSS/NMEA data from Quectel with MHI wwan 
modifications.

Regards,
Zaihan


On Thu, Apr 3 2025 at 04:02:01 PM +0800, Muhammad Nuzaihan 
<zaihan@unrealasia.net> wrote:
> Hi Slark,
> 
> I just implemented it in the wwan subsystem since it works for me 
> (even without flow control). I wanted to port it to use GPS 
> subsystem, however, debugging in GPS subsystem is too troublesome, 
> especially when the driver crashes.
> 
> Unless i can have some VM with direct access to the Quectel hardware 
> so i don't need to keep rebooting my machine if it crashes.
> 
> For now, i am getting GNSS/NMEA data from Quectel with MHI wwan 
> modifications.
> 
> Regards,
> Zaihan
> 
> On Thu, Apr 3 2025 at 02:06:52 PM +0800, Slark Xiao 
> <slark_xiao@163.com> wrote:
>> 
>> Hi Sergey, Muhammad,
>> This is Slark. We have a discussion about the feature of GNSS/NMEA 
>> over QC PCIe modem
>> device since 2024/12.May I know if we have any progress on this 
>> feature?
>> 
>> It's really a common requirement for modem device since we have 
>> received some complaint
>> from our customer. Please help provide your advice.
>> 
>> 
>> Thank you in advance!
>> 



