Return-Path: <netdev+bounces-106048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C46391474D
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 12:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD01C1C208DF
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 10:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E237E59A;
	Mon, 24 Jun 2024 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DCDMabIv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACFD4595B
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719224459; cv=none; b=hX7NORkcQ9nA/W/H6CrbUyxdhDEiWdAqFu5m0WGHqpP77XoxUo46t4uz8hOX81NG6nUcPKV8g+iDhpzo1hACYi07QD2eC2S7Qq3I+3SDsIZvDCU5rng0vWJb/Q5K7inlO1ADsulBnBkFmM4WF7doE9fyY2f8rtwtXIoxg9IFHac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719224459; c=relaxed/simple;
	bh=bk7hhY2/QnkoNAc7S1gg4nmxH8h9zebqWMFC8obuO0o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XAv10w0KrPjIIHT6gnFl3lh/GlpA+2/EDzj5RbT2UV4CS00vfcqkVyDxeame87NsbRMZlSBGnnp5mNIbIiXlDD6XYiIiGK0psQn2V+BPRzFGzZR8TDo1XMy4TjugAjcFa98Pxx/RoDVcm3dvHY20Qc9IAS2bON3Nmrcow3hM9tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DCDMabIv; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57d1679ee6eso7304622a12.1
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 03:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1719224456; x=1719829256; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GsLqpJ1xgH3tAmDotBaZMLlGvU0XzqphqYCZfE3egaY=;
        b=DCDMabIvWUqgRtyjaT/h3GRFJFe7LnoXPawL87KGIpA9cnBMIgP3hI7mSw5oP6xHG8
         d4lYyFRvxPd2YbjsswVqfZxxY632/R1KRmyRHX+WpDmKQ1hEfBnZy2GuXkEpwYjJvAEI
         UCRXjjfJgR66OSqVRAU4pt/SvUK+tiN1jfteKKioHX2zHf7YI7viL5dSF0/KtI73497I
         VggroYT4Jrzf38SBErWAC8m47Ma6mZjeoekJE4QPCqJSCpEjAb/zAAxvGUeq/G0NYYm6
         OoN6BqJHIAxVo99fx6fw7TPIudjLQp4VS6LKiuMsRZxMDLkmgk6dH6nIFdKKd+fEOOqx
         7wDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719224456; x=1719829256;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsLqpJ1xgH3tAmDotBaZMLlGvU0XzqphqYCZfE3egaY=;
        b=EOSBREpSDspBHuHYGn1V6vzYGzucu91FUyGu92/VCWd1zJYmETFBGyFo229RUL8FC6
         HDij7Pc+n5s4YTVsnGyUFtKS6bwdjnd7nK2+gQHQ3pWoyC5K7aPb/I6px74jhkz1dCW4
         ZFWGW+fg+2/CoqQnchJ0sze8BfAzfICxoXuh8QVcXvcv+UlxxfRm+loP5BN2OlkKU21k
         oJazmZJJoJYcg+7oXfnayJscADSr98iXYNtm8S6O9C82qdfLrPkNtJ2Z4K5O9B3VWpuW
         NdU/5e7obecpDuraAhudCzFJGt02YmhblwaBTem5ZyU2M5ZZV5c+W9A6dp6i9Hywn9xr
         v4Ig==
X-Gm-Message-State: AOJu0YxJD5CjRYcbuzEN3OLy6rDTpFK5lLVswqCEcengt4K3LC1jfPwJ
	QlIIULkeE+5NqweRkXhucfuOG4B4fm9xOxfom9+SzAJYXfiHTAoDYQPcUo4TUtM=
X-Google-Smtp-Source: AGHT+IFUeIb+nQ+i2oL/00vzZCNRSLyn5VbT8DnHYWAuq/PgIBgygx0aV6pc7GppU1eqnN0Th7YDnw==
X-Received: by 2002:a17:906:f909:b0:a6f:62c5:87be with SMTP id a640c23a62f3a-a6ffe270a03mr375422166b.4.1719224455646;
        Mon, 24 Jun 2024 03:20:55 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf549385sm394118566b.105.2024.06.24.03.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 03:20:55 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Willem
 de Bruijn <willemb@google.com>,  kernel-team@cloudflare.com
Subject: Re: [PATCH net 2/2] selftests/net: Add test coverage for UDP GSO
 software fallback
In-Reply-To: <20240622192722.689abc7d@kernel.org> (Jakub Kicinski's message of
	"Sat, 22 Jun 2024 19:27:22 -0700")
References: <20240622-linux-udpgso-v1-0-d2344157ab2a@cloudflare.com>
	<20240622-linux-udpgso-v1-2-d2344157ab2a@cloudflare.com>
	<20240622192722.689abc7d@kernel.org>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Mon, 24 Jun 2024 12:20:53 +0200
Message-ID: <87v81ywsje.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jun 22, 2024 at 07:27 PM -07, Jakub Kicinski wrote:
> On Sat, 22 Jun 2024 18:14:44 +0200 Jakub Sitnicki wrote:
>> +	ip link add name sink type dummy mtu 1500
>
> Looks like this doesn't make CI happy:
>
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/651680/59-udpgso-sh/stdout
>
> I'm guessing "mtu 1500" needs to go before "type dummy"?
> iproute2 hands over arguments after type to type specific handler.

"ip link" got stricter, I see. Been testing against an old one :/

  # ip -V
  ip utility, iproute2-6.1.0, libbpf 1.2.2

Will rearrange. Thanks for the heads-up.

