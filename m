Return-Path: <netdev+bounces-169638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E7FA44F18
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 22:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5BF4189BB47
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 21:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672E720F098;
	Tue, 25 Feb 2025 21:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="iwkrKkZf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8B820C02C
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 21:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740519814; cv=none; b=MTMWmSzyKk6+BZ3/glbk3aHzrwqetzBIqi/jwoZvvUbI6Y6BGldHkGLbqARXxF6eLZd5nyTYo+OibqMIJyyE8MEB7C4B4uEgSiUB8Jp8pfyPQO8QUUk7rlMDL6+kl/5hsO5j/JMxIBL0+L53QdAzyHXev4BEkzyRnLR5ej73VW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740519814; c=relaxed/simple;
	bh=v6VBRIDfPPAuGSOJ6DX9lU3J+goTuMImOESXIUQcXCg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=lCUbV+1r37Lp6r4x88AniA5DZS63Z3ym+CQknJPFDD8yFwjisF/T2KhD0c4Do5a6/acODXVY7RzN7/kFUmKb/GZwjxgi6PchOZLmSrdvAVEs4Am29EiHA1vXw2IRlRXrqdxTwOyArJs2/7pCF/ACnljPbbL+M+DCP1GwkkXZyL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=iwkrKkZf; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f31f7732dso133320f8f.1
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 13:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1740519811; x=1741124611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v6VBRIDfPPAuGSOJ6DX9lU3J+goTuMImOESXIUQcXCg=;
        b=iwkrKkZfK5JLovU1AIT6FvRG5xXzwhjAndt70ieTPZUZ3hWeCAwvl8WsEhTub+jbMZ
         FduPMPMiLE05BfqfKEoWYZDTGo3AkijYv2FS/e3thDGMoBC99j/OdpbWJK5mCfnw+MEO
         wUjVUS9YC9Yc5V7JFngbKuVXqBV5ti6ueYYhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740519811; x=1741124611;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6VBRIDfPPAuGSOJ6DX9lU3J+goTuMImOESXIUQcXCg=;
        b=PFgm5IUVpOWTuZ3X2/nT92K0Ezf48uMa1F8tWYoz8mmnuIc7B3l5UfjFIC+Jk3rjsw
         Xk9G/kcoQ4wSyVe55KrVuFVil5erYYqEyom8Hw2RL35piHVEA6NlErnKdTEIIQyqLjp8
         p5jnXYECnEz29bQgU1bTHNjxJy7A+gR9SoOJbW+pRgelbNUvknc7npI54p2zs42+IlYn
         EI25L8t9vv3BhMDOvaEJO7dD5EAjbhVLXpFdLYKMM2MXbIIgb6m0iiqB/I15j1GByRQr
         8O1XpUYQWC9dAMul6MqzbqhEUFdZuA4iziEI7I0jRj0k9TpTF4N+dSB0rGtTM83FImBy
         K4WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWElHGOuwqqyrDqtd8eW+BM7quZPUwmXVsH5bBZFaaQPvQ7VQCMuIJwwWNWsmxbHuQ1VWDHfMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza6LGj1NTB7D9hXj0C79lkv9p7tNIHaKReD2Won2hZEgy6UedI
	ZoKr24CgnXBTTaYfXqDybfSghlkUYk/cAIkfDG32XiexUHKo/AeOIx6R7hr4H04=
X-Gm-Gg: ASbGncurAU8CEXZPPwbH1Wwyei8hRq+UDxwSDGlNEmOW7LHerdO8Vw/Kime5RVLvEDJ
	N2eFPUtMFmMHp3u4ZK9pwwC49RKECH2dPzDMnaNZ4CUfsrxWdPlV9VA7dCE5ytKBQwl8sUO39z2
	wB68SsKS3komKm6DsChIghKwFANRCX1doFoFh3fkip3pqrjcXBLFwrg51eg4usZuF4ZeI1nw35V
	AJNpGSmSWMHn0phViHmqNpKQQ3csH31A45VFJeyXHM2Ida8BQ7WewM2KRxjLN0WMCy7SuXvy5im
	2eCkMC8BTYh3avIQZdH30pqmVZM82JOeOSyT+Lpgl8XLXbY7+FqsP0I03GzN8T9TiQ==
X-Google-Smtp-Source: AGHT+IHSlhsBYfXGudlA126ARnimf5DJid2NXAt0zMRZRmjxnTP+DlMFj1fR7Dt14yukNzUQAYX1Dg==
X-Received: by 2002:a5d:64a7:0:b0:38b:f4e6:21aa with SMTP id ffacd0b85a97d-38f6f3c50b0mr11926957f8f.5.1740519810679;
        Tue, 25 Feb 2025 13:43:30 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8fcf29sm3520900f8f.100.2025.02.25.13.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 13:43:30 -0800 (PST)
Message-ID: <8052b316-9f72-42c7-9e11-e23e690d80c4@citrix.com>
Date: Tue, 25 Feb 2025 21:43:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: hpa@zytor.com
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
 akpm@linux-foundation.org, alistair@popple.id.au, andrew+netdev@lunn.ch,
 andrzej.hajda@intel.com, arend.vanspriel@broadcom.com,
 awalls@md.metrocast.net, bp@alien8.de, bpf@vger.kernel.org,
 brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 dave.hansen@linux.intel.com, davem@davemloft.net,
 david.laight.linux@gmail.com, dmitry.torokhov@gmail.com,
 dri-devel@lists.freedesktop.org, eajames@linux.ibm.com, edumazet@google.com,
 eleanor15x@gmail.com, gregkh@linuxfoundation.org, hverkuil@xs4all.nl,
 jernej.skrabec@gmail.com, jirislaby@kernel.org, jk@ozlabs.org,
 joel@jms.id.au, johannes@sipsolutions.net, jonas@kwiboo.se,
 jserv@ccns.ncku.edu.tw, kuba@kernel.org, linux-fsi@lists.ozlabs.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-serial@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux@rasmusvillemoes.dk, louis.peens@corigine.com,
 maarten.lankhorst@linux.intel.com, mchehab@kernel.org, mingo@redhat.com,
 miquel.raynal@bootlin.com, mripard@kernel.org, neil.armstrong@linaro.org,
 netdev@vger.kernel.org, oss-drivers@corigine.com, pabeni@redhat.com,
 parthiban.veerasooran@microchip.com, rfoss@kernel.org, richard@nod.at,
 simona@ffwll.ch, tglx@linutronix.de, tzimmermann@suse.de, vigneshr@ti.com,
 visitorckw@gmail.com, x86@kernel.org, yury.norov@gmail.com
References: <3BC57C78-1DFF-4B83-85AA-A908DBF2B958@zytor.com>
Subject: Re: [PATCH 02/17] bitops: Add generic parity calculation for u64
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <3BC57C78-1DFF-4B83-85AA-A908DBF2B958@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Incidentally, in all of this, didn't anyone notice __builtin_parity()?

Yes.  It it has done sane for a decade on x86, yet does things such as
emitting a library call on other architectures.

https://godbolt.org/z/6qG3noebq

~Andrew

