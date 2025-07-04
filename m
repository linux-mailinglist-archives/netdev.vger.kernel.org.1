Return-Path: <netdev+bounces-204094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F8DAF8DD4
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 11:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495321C815A3
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 09:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCEF2F548A;
	Fri,  4 Jul 2025 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="H3U2ymWm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1282F4A12
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619921; cv=none; b=uez/eaixxjoE703chcoqDIBjZs8CXsLHtqGFJzpvMtkxOC8efG6cwvzwVPDju75FGZx8ILdEAHrbbJCA8A89HFsbGVjVg5omWVG4U4ds6rBl+2E/Hr/GCNQregGdB82qygTESzjooH6kk2zDZLWPhvSs1D3LyjtY7UhogmOQhw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619921; c=relaxed/simple;
	bh=lRw7yJVneIfUXB5qnJ6oSwcGV4RKbOy3n7DSX0pBpsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZUBr5O1O+REv2ikLRr4maIJHeWARNkME7i3x/Y367/cuVQUO82sKnJrBimvGmC2tp8E84hwKyleYnexa7FCLZIqGpJHvjx55yMsRJ67VwteF53h0c2Sh6m0RdpyR4yd8njekoUCn12pb7Jstcc8LxzCKE0zI/YJ0IVKBDRsJ9hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=H3U2ymWm; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0c571f137so143196166b.0
        for <netdev@vger.kernel.org>; Fri, 04 Jul 2025 02:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1751619915; x=1752224715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5lvqW25n8VSdsxeIbb6N6y1V/bckNRxGH4LVpn13n8M=;
        b=H3U2ymWmKJvzY6LVPa7qpM4oO2dpgixhT8WECCxKAxFXOafT6qAvJGd4nfO8CjUfxK
         aqXGukWxDg/2q/LUqBk7Btvs2Ml1HFqRo3+Kfo+p98HdrMzzvxAe1cy8/JZiSz0fnxuW
         X5eTKMlP4Pfk6I8mkB47Ya9AUeTLbl6fmcaiKF/6Pk2UzdwU8TcyPWlmEpzkSaWa5Vie
         BJHeDbf/9wk94WUn05wJ9zJOtbCOJ+NFQIlMQXATdR57st5dhs5l05A3zXn3jpj4DC5L
         yqMxKLiwbH/2IWxa5oQSjBWSQsr2tx76v9qzFAgWb0oQRRHCus7RJvyNFye2zFZYDeFQ
         iUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751619915; x=1752224715;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5lvqW25n8VSdsxeIbb6N6y1V/bckNRxGH4LVpn13n8M=;
        b=nmjKoIsLuOqDKOfEeH134fJOiYKrB49bLQjax8rrd7IRjsz2iN/1jgiX9C+2qNuKhH
         G5LxMXgvhtCZ2cueEil6/PG8G8np/cfs3ibCiYQzsHDNiagJWOiFZGv7R+L3SKYJjk8p
         U3wEK8ebLPgaBqrsEAls4Bk5FjAlLLdC4nOkUr7Ix27pmomVlaVmtSzQE43yOhh1pAL0
         dbxyjoKOM6FzQdwLbFkoIKMG2htsmgWE9wsl/PvU/TizRZ8RZgZ9ISlPV5QZ1NoeYNFH
         PxS+9N9rEgNBqcmt4IvO0P71qJpGwut8cg5BO0WhbiBL5/H+aM5OSWS8qEaiWrAgyHO8
         USLw==
X-Forwarded-Encrypted: i=1; AJvYcCXKtxlW8cfeTsSBeCGzJcG1UC/rkOvOtv9vegROng0xtIXraZKpsqiinxPBl6/R8QfmXv7Z21g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6fOuCtdK30KjsAxr1AxnR5HUWgLO/bKxzBS+3HktGFSObK345
	8aVzN3x1YoW+MFYgtqFWzaO9i6qfsdva5d+InHMHEokbEUcQE/r0F2S+m/xVKBlStX8=
X-Gm-Gg: ASbGncue2CjFd4rxSYbO0j3NFtE0XmIIoAYijfhQ5N7KimQFqsbrcaS8YDCeQTZxlUb
	biB9VNvWU3DbhpdSpjDeQE+5nVK/OpLo8B/Wfkj6ZHGspz406NvmpRFRU860H0q+ClsMwewVHbb
	fVDOnl13ytHgZFel3ADKfED5Y2e+y8HvTEfV81fS75KQ4/2RMaWSdSpJwLz8QD/GacbZwUUue3t
	/jyyYmKlpfdWlTW6VycMPr/NqnHOILmXmsQ2I5ncvlF1aoVTABAsJ/pcrZtw3hJFDK7Ynb2Ftzz
	+6stRNtOwadHlTZB6Dwk4a8o7tCymap1JGvKJK0ys0GfUCa02jYy1teL0ALZktXRhPP4NoN8h/W
	Mp3G4cYyDQx8O
X-Google-Smtp-Source: AGHT+IEZO1zxjcWXhdMMtE+CxCjQoXtX/7S5BwYI92EZAOfHlQnV8tIpwdxwwtnNSgAwSoG0neHl+w==
X-Received: by 2002:a17:906:c102:b0:ad4:8ec1:8fcf with SMTP id a640c23a62f3a-ae3fbd6c7d4mr177062566b.46.1751619915226;
        Fri, 04 Jul 2025 02:05:15 -0700 (PDT)
Received: from ?IPV6:2a02:810a:b98:a000::f225? ([2a02:810a:b98:a000::f225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66d91cdsm137351766b.22.2025.07.04.02.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 02:05:14 -0700 (PDT)
Message-ID: <79a57427-fd4a-4b9a-a081-cf09b649a20e@cogentembedded.com>
Date: Fri, 4 Jul 2025 11:05:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] net: renesas: rswitch: R-Car S4 add HW offloading for
 layer 2 switching
To: Andrew Lunn <andrew@lunn.ch>, Michael Dege <michael.dege@renesas.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Paul Barker <paul@pbarker.dev>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250704-add_l2_switching-v1-0-ff882aacb258@renesas.com>
 <4310ae08-983a-49bb-b9fe-4292ca1c6ace@lunn.ch>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <4310ae08-983a-49bb-b9fe-4292ca1c6ace@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Looking at the code, it is not clear to me what would happen with:
> 
> ip link add name br0 type bridge
> ip link set dev tsn0 master br0
> ip link set dev br0 up
> ip link set dev tsn0 up
> ip link add name br1 type bridge
> ip link set dev tsn1 master br1
> ip link set dev br1 up
> ip link set dev tsn1 up

Per design, it shall enable hardware forwarding when two ports are in the same brdev.

