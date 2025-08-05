Return-Path: <netdev+bounces-211762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245D4B1B866
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 18:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83D777B0F88
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 16:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD48D291C0F;
	Tue,  5 Aug 2025 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RVeCzVoI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED88242D70
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410991; cv=none; b=AZ/ybP4VfOYloDqFhmPmEz+3fPnocgnBhPhz6RwZhRpE9V41/uVmb0f+579NCcWeLvHFkAFSwSdH3Nc3GjNXLgIpyDoeBzFmO6wsYYjiR5bAIHlx5phN8g07iv4pU0mbS/YSLAqDj1sSdTwfykIePCN4ADr8Q5enh+clMMvPeAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410991; c=relaxed/simple;
	bh=ZYOKsmbUJbiBWaVYtF5AN2TeCHP9emZwxMBsR8kvmcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OoDsemogZVpIXxtKLxS5jARLSLAw8lytM/o2tdLkxm50IaqeSBqIlM/yLn5G3r677kcDjmFo+XwhcFal1D12bL/drJ5cJybWZhYBhcpSiC8GlOpYIc/4gcZkwYHJ6p98IuzeFynri2gWGmUYtIcgZZAZLCUmyxnWQvjMAny6KBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RVeCzVoI; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-af9842df867so148661466b.1
        for <netdev@vger.kernel.org>; Tue, 05 Aug 2025 09:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754410988; x=1755015788; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iTDQePGQpdRLJNbAu36X9SMzRWp9+4YjhDCOEhv/2CE=;
        b=RVeCzVoIJ2Pe/xxgK4EeAqNxZhQfahGLaYYOy3XK5diqmS0255AjHuHW59rTAdqFNQ
         zMYRX3YpBZeoExva5PYVtkLQ7Np8YgzuETTeDOKj3gjTR/D70O9NE/GWWa7FaelanzlB
         KGXkve996ANlWb/PJK5528CVijADVGs3V65rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410988; x=1755015788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iTDQePGQpdRLJNbAu36X9SMzRWp9+4YjhDCOEhv/2CE=;
        b=bBkAvWqpIWildxhDmcxYrU+eFoSrK12Kave+phLgMWHBDOVTVdyJjAvvvY1R21WPgj
         q6DzcFDj38wYgMl/EU1rHjUOK+TtdLe0K0COuWq1FvEV0DsYzMLuvhOk5vKN/OJ3gPBb
         WQ6gR0nToZvwsitTPppOc9+wvxGXT1lvsZwuZnmhc2V/PCv6n0/638nfoZ9dXkSzIhrR
         rzgOKQ9sSv9dh30PPW8JWZdXgXxiSiJOQlbp6IPmEjwJ8DLc5qEQzzq4kyWo/JKm5jcK
         6IKR4FBeMNZ5PyaIQyO2A13BTJa2luQXfdiWuKcimhAV5KAU2XQ7TXS8PH+AAzJOaWCm
         KYMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUda12ysGAY+Shhq3XQR0HPFPHJI4ldJt44DWFx7QKP0YudZC15q5uzw/0xy0EI1sd23ZhQnkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVuGS6KbMTWHQPG04TuqbKFNmqAAe2ABlqfcSNFwzA7GzH6dxW
	BrTJWVTcOB4aGWHc7D9MoKL8kmPFTXFqyAbTCLwORof1oAaDwOoZTZ2vOVAb9v3ajxGiN75s5Av
	ON/7dfL9hVg==
X-Gm-Gg: ASbGnctYzbAHurMwG+5kuPuYHm3cY6ofzyUZv2px6fbWwCMsaeHUlHtPgvbeK5FiA8A
	b4ovN6haOxyUZuByP/unA0XYa04od8N8YRRPB/+E+OPJXUniSVoZcZoCeVG796ticlsYVxpR1PD
	37RwzO/HhNdUIsBlimgw2BolWz8n6n+g+jDVrq/P/2I2SgakDESVQu1hNURIemeLZ8tlX94eDwJ
	ytCFDOtuqeYi0JF6I5gdQaCcP7uwVoBi4O2adU477yQq6fC6ME1GFVK86ep3eKHu2cRLIDQyJuz
	PAUmE/clfK1Hg9jWFcUbH2lYYfcZ9UfCTW4lCPn+TZEkQOKZZYCjr5+iwaYCkvI+YmKXP9o/Wdz
	IxGpPNAKMsmRwpxw7UbwqojUbTn0Ihkgi7YXnZlqrjgrBUAltpiGFW/ZjZIAjDSpA2PAAOtdy
X-Google-Smtp-Source: AGHT+IGFz2rIaQqlb12fFTWt+YLkxpgQkDvirYh2mHBX7ls5fsjZKJBeNi4pwlw+xvEVVCAIgQkArA==
X-Received: by 2002:a17:907:3fa2:b0:adb:2e9f:5d11 with SMTP id a640c23a62f3a-af940174eafmr1335510966b.37.1754410987662;
        Tue, 05 Aug 2025 09:23:07 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91b36e91dsm901521866b.69.2025.08.05.09.23.06
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 09:23:06 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-615a115f0c0so9858725a12.0
        for <netdev@vger.kernel.org>; Tue, 05 Aug 2025 09:23:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+IQYpnvkyGyp984F1UHKVdDLyHW7Lvw9JV+m0CUz3cjItiuVS3Teo5qclCVQYFTBfwhGC50I=@vger.kernel.org
X-Received: by 2002:a05:6402:254e:b0:615:aec5:b5bc with SMTP id
 4fb4d7f45d1cf-615e6cd3968mr11900877a12.0.1754410986307; Tue, 05 Aug 2025
 09:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727013451.2436467-1-kuba@kernel.org>
In-Reply-To: <20250727013451.2436467-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 Aug 2025 19:22:48 +0300
X-Gmail-Original-Message-ID: <CAHk-=wjKh8X4PT_mU1kD4GQrbjivMfPn-_hXa6han_BTDcXddw@mail.gmail.com>
X-Gm-Features: Ac12FXz_1jhs0pDqBU4Pe5bw2lhDIpnR4A0FLpEopYft4GtNE65Xjr2aEymiyfA
Message-ID: <CAHk-=wjKh8X4PT_mU1kD4GQrbjivMfPn-_hXa6han_BTDcXddw@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.17
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 27 Jul 2025 at 04:35, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Networking changes for 6.17.

So I found out the hard way while traveling that this networking pull
seems to have broken USB tethering for me. Which I only use when
traveling, but then I do often end up relying on my phone as the
source of internet (the phone being on the single-device flight wifi,
and tethering to the laptop which is why hotspot doesn't necessarily
work).

It *might* be something else, and I'm bisecting it right now, but the
networking pull is the obvious first suspect, and my first three
bisection steps have taken me into that pull.

It could still jump out of that pull - there are non-networking
changes still in the pile left to be bisected, but I'd be honestly
surprised if it does.

This is very standard usbnet with cdc_ether/ncm/wdm/mbim.

A failing kernel will find the device and talk about it, but then it
never gets configured and you never get any actual networking.

Any obvious suspects I should look for?

           Linus

