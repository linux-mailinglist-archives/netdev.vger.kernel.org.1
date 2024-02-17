Return-Path: <netdev+bounces-72610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBACF858D11
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 04:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815D71F228C7
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 03:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A251B7F4;
	Sat, 17 Feb 2024 03:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="baAYNsbm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB64E149E0B
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 03:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708140434; cv=none; b=tOk8xB9BIvlZpRmgQAykOggeK4L8bfzk4aQYiuHSIoM+A03rDkuu/n0OxFcRSf4Bomu9q90XJsinV6UkLQGOa+fweDWjPpZXCXJV/Yu+kHqkrN8FGfz7cRs0NcUKnRV1P1e4H0uap/39JWj4xo57p1l2tIvgLxI6YruKtd66mJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708140434; c=relaxed/simple;
	bh=lb4cvV1LXgTw9K1co2vNpge7+BqvQQT0p9tPRIYZ8bI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1u+RjfxchBs6vrMh3rMRRE0LJsYSd/w3fbLQgR86KzjAPTpcdwzsaAXIyqSLEGcYVyRQhOBvGlCrNFCbt3S+WYLeoJ4AOISIp4+8lnkXaTYWmaYc6ZZrPBtnfLlTcI1xRsK3KwapJZK8qR8eGxnV3ibrVv4Utf+m89n6ZxgVjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=baAYNsbm; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36517cfd690so1103605ab.2
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 19:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1708140432; x=1708745232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNUiI76F3+Wbspl0N6YjZFJcyO5wIRtjcOISW2fp9uk=;
        b=baAYNsbmbwlm4gjRGTXtQmLBC0s5WzvZnnT36/eaq/45aSbhssKKiw9opWYFPJPWVP
         C0opVr/KZiWD41Ftwz84HboghHwoJKXv686yuFnbiY2e4pOEIfzKiPOfDfIcBLgJD5P2
         EwRLoLMlbWy/Mq95wUOHHBTQwP3fEIjYgOhPQ5x6mTfrwUbKSPKdV7jajxzAhuE1EbGd
         eTyYUAK3KFSuQGRj9Fg9ZjtQssbeirWCgpRIn9NqHTh3jnbN8lGiaozLy6E7xn+aJ04c
         wzpM19s+JaSAvcdunyUrNUeL4GGODY0jyZZrNkuxhePTaFyfR6+iQGBbSMZEnWp5Xe7o
         VU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708140432; x=1708745232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNUiI76F3+Wbspl0N6YjZFJcyO5wIRtjcOISW2fp9uk=;
        b=t132nLC/wTUW2CducUtblw9UGG49ZYwnKsTbJrxao/1qwuKRdwF92k2+ARjaMQdOch
         p9SxPFaWsEua+G5VRiJ5cbKQFJ9ooOorAAJ37uaZSAxSpGatanOjseXsimXhaZeExhgD
         tzxRDR7Hsb/sBvqquBQlA4iQ47lVkMJigGldk01iyN3zbdujkznOkdD6I7x5gdhiGDWk
         KoP3IHThlvBtjvjbpRd8yiFs3BD7sobFzPd0bMI6Lxz1deXslC8sns5bCmlTlldo7/S5
         +tST99TnIprXbsmth5tylT8iHhwnZopK+kAPIz+G1Ow46XsaO0ieOEYz06+hy4cxpVZt
         AwGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWIELz60R999G0RNhbL6uWnDi6EsLcpT/6LTgDLFQMlGDP6pbwwQx6QHIlqFF3qzv4aq1VNEfrmnXoDEHGco65o05NwuLT
X-Gm-Message-State: AOJu0YzMmTFVCsJfpTrnFfAZsh6GlL8XXyLRryizaiU9c081Yapevwse
	SpwDngxLstzvgJY8W0ZNmNZmMY+TqBSUA4o2FM5v5Jc4vbLiHamaYNx3haQPk0Q=
X-Google-Smtp-Source: AGHT+IGfwLmgQQv6/5fgLNB9KZaNXnLgRz6LXfQebQgQ0y1G+faU9N+tu9ExuuBmW15WpSRm36layg==
X-Received: by 2002:a92:d852:0:b0:365:b71:487a with SMTP id h18-20020a92d852000000b003650b71487amr3769572ilq.9.1708140431763;
        Fri, 16 Feb 2024 19:27:11 -0800 (PST)
Received: from [10.1.110.102] ([50.247.56.82])
        by smtp.gmail.com with ESMTPSA id q20-20020a63d614000000b005cd8044c6fesm626075pgg.23.2024.02.16.19.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 19:27:11 -0800 (PST)
Message-ID: <1bfeac24-73f3-4e9b-96e4-b9354be27285@davidwei.uk>
Date: Fri, 16 Feb 2024 20:27:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 0/3] netdevsim: link and forward skbs between
 ports
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
References: <20240215194325.1364466-1-dw@davidwei.uk>
 <ea379c684c8dbab360dce3e9add3b3a33a00143f.camel@redhat.com>
 <cf9e07d6-6693-4511-93a6-e375d6f0e738@davidwei.uk>
 <20240216174859.7e65c1bf@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240216174859.7e65c1bf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-16 18:48, Jakub Kicinski wrote:
> Also looks like the new test managed to flake once while it was sitting
> in patchwork ?
> 
> https://netdev-3.bots.linux.dev/vmksft-netdevsim-dbg/results/468440/13-peer-sh/stdout

I can't repro it locally in QEMU. Maybe it's due to the leaky ref bug?

I'll send another revision and hopefully this doesn't happen again.

