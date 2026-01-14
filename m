Return-Path: <netdev+bounces-249937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0275ED211E7
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 20:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFE393006A7F
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 19:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E644134D90D;
	Wed, 14 Jan 2026 19:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ht73g1pS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612BB33B962
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 19:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420766; cv=none; b=bNEYZApMy2ATYLDVpTUbWqd8ufj8bJrlE9jcwPqTt3Hab4A28+wnoYzsC8fozWAEi7d4pEKOpoHEj2XMG5Bw0xdB0sCamjxsgK1qhMDB8PB/w1FkZ7If5PjT/BMp5VtwlWqV6FY2pQtsd/64i/BcRR7pq1ORvVYzP/OgPmAPKkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420766; c=relaxed/simple;
	bh=DANJmpYLGKjjElweCOMqF6H/rpP7wNFwob1MIjViWw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zt2odAo3bEz5AlwnLyzDpTuVcAZfktbHxznw2xHRl3avwcJpFhi/GapziDrSUDwXY/UUU3OSgRKmUAGJqnI98PUIszonFonXVcSacZxBV2sBg0DTYKugoMsou3o4DU4B+CDnWJ8W2dOQBaMUVszCfaca3aVBHqqpL2OI10v7aD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ht73g1pS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so2186075e9.1
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 11:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768420764; x=1769025564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZbyFPq4RJA0B3guGFnovLZKdiLk/w0AMZyBK3tcos1A=;
        b=ht73g1pSYp6shgYlX46qrQaB1yEybPUFxERVgvqxeM/7N2PCc1GCqGLf1XEBy4S+Sh
         T6yL5FruwbS3gaSwe6rZoGRSvYKFiHYpS10/U3aDLmsYHzN7plkZ7ahTO6uLnMdWDhTA
         j2kzLBPAqR5u4EMEChy7o0dvdu8ZG8/bh8w8rbe97wwdyTk7yQEb+75hrBZa2FmsuHmN
         W6+c0Zluf9KyQj9CWT8Vj/gmdizB8itBgabEs2UwbTrYtwIFIQ0kFxwRI+Y6L0mIDJxe
         4/I47Nru9vQ6zDnP2r961KpbEUseWKeS3RbScqUbMLiFRLHlaS3bNN/pLJDiqjh6L7QH
         7dyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768420764; x=1769025564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZbyFPq4RJA0B3guGFnovLZKdiLk/w0AMZyBK3tcos1A=;
        b=npdbDdFLNMwU4QkneAqBbIfFvjMvZkkljP/Y8CxEv2Znup96eD/yPL7mxn3u69uwAv
         Af8H8dEg81VeQVxGb7CLXLf92K12EbizEIAMlxM4TzQv23asPX9QAaoElhGcSq9tbpGo
         8RLkAoGanCsj4guPWl18CFWxusqbr6eKPmFk0KRTHaV4PxBk6xLkzSvcJX2dpiK69rlN
         oe2jFeq8pp3cnwGQ2JY6lYrJeFQVYHqqkZ82iyZhAJwNJsbckcE701oat76MrnFk+9C8
         DTB7JawTiDrHt6ykRFLg9w3WaTR1I3dm8tKMLnKzO2KaPp8J3g7qFUpUgQ+cC7HoKfq0
         AgxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUypKGIiL5PD6RrldCkU/rKTGqZQIYkDRT6N/892N6jnePos/wtprPOGY7XzD+vMP56EPOzan4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUkuyxgrQ8FvdszKHDPJpEoG9UKwrVHlPfaVUYi0PW9ALlZ4fY
	5dl684LnUc5sbZqVIWC2eFkFkUfaZve/UvHWBMYUUcOSr8loVfsN+r1iJ56Qbg==
X-Gm-Gg: AY/fxX7J9SLegogVavc9FEOPvIz2YSx7Apj1XoV4dA8p8Q0XzvLowK+15DOdVZyYw4N
	9sWaFOh/1VdEMPKOyBjOS8xFo2kAZDpSgC+6r+tUQMDGr+Jzp2JMn/PdHPx8Yt14+J/uZYUSsTc
	HohIbSu1Jg70ybmdy1xqi5zFbFChzHjG4dYw4Z89Kuw2Q7qC9RDiiZSnTH62/mIml1bOJua/VqM
	F1bXjn9A2UJ1KxwvP7n1TDYK9hq4Fl0YP1hSudQjMbMGs98CAUGsyWNwU2ew64FDohROxpvWzYC
	u3dwIpdRhRyV+d8VF3d+Q6ZTnWyqpgWhHH7EDZVLS0gLZVwhBVNKVLqM1536MKgXl/IITqt+8Qu
	nEVn2CXOJCGXbW6Div5kcksOc/Gmx64+TvuOrozjSJlk+jF8Xw/EQMsIzL8sP6NgmSXrv88J6Bt
	tcnY/xFK16C1EjMA==
X-Received: by 2002:a05:600c:c16a:b0:477:1af2:f40a with SMTP id 5b1f17b1804b1-47ee334d0aemr53055025e9.17.1768420763574;
        Wed, 14 Jan 2026 11:59:23 -0800 (PST)
Received: from [192.168.0.2] ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428acae8sm7988845e9.4.2026.01.14.11.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 11:59:22 -0800 (PST)
Message-ID: <84e300fe-3d72-47e3-92cf-11729e60e070@gmail.com>
Date: Wed, 14 Jan 2026 21:59:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 0/7] net: wwan: add NMEA port type support
To: Slark Xiao <slark_xiao@163.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Muhammad Nuzaihan <zaihan@unrealasia.net>, Daniele Palmas
 <dnlplm@gmail.com>, Qiang Yu <quic_qianyu@quicinc.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Johan Hovold <johan@kernel.org>
References: <20260109010909.4216-1-ryazanov.s.a@gmail.com>
 <1b1a21b2.31c6.19ba0c6143b.Coremail.slark_xiao@163.com>
 <DF8AF3F7-9A3F-4DCB-963C-DCAE46309F7B@gmail.com>
 <3669f7f7.1b05.19bb517df16.Coremail.slark_xiao@163.com>
 <845D539E-E546-4652-A37F-F9E655B37369@gmail.com>
 <7662dad8.2840.19bba6249aa.Coremail.slark_xiao@163.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <7662dad8.2840.19bba6249aa.Coremail.slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/14/26 04:42, Slark Xiao wrote:
> There is an error based on your RFC changes.
> It locates in 7/7 net: wwan: hwsim: support NMEA port emulation.
> Error as below:
> 
>    CC [M]  drivers/input/gameport/fm801-gp.o
> drivers/net/wwan/wwan_hwsim.c: In function ‘wwan_hwsim_nmea_emul_timer’:
> drivers/net/wwan/wwan_hwsim.c:239:40: error: implicit declaration of function ‘from_timer’; did you mean ‘mod_timer’? [-Werror=implicit-function-declaration]
>    239 |         struct wwan_hwsim_port *port = from_timer(port, t, nmea_emul.timer);
>        |                                        ^~~~~~~~~~
>        |                                        mod_timer
> drivers/net/wwan/wwan_hwsim.c:239:60: error: ‘nmea_emul’ undeclared (first use in this function)
>    239 |         struct wwan_hwsim_port *port = from_timer(port, t, nmea_emul.timer);
>        |                                                            ^~~~~~~~~
> drivers/net/wwan/wwan_hwsim.c:239:60: note: each undeclared identifier is reported only once for each function it appears in
> cc1: some warnings being treated as errors
> make[5]: *** [scripts/Makefile.build:287: drivers/net/wwan/wwan_hwsim.o] Error 1
> make[4]: *** [scripts/Makefile.build:544: drivers/net/wwan] Error 2
> 
> 
> This error could be found in netdev-bpf website --Checks --netdev/build_32bit as well.
> I just rollback it to previous timer_container_of() function and it builds well.

Ouch. My bad. Thank you, Slark, for noticing and fixing it.

--
Sergey

