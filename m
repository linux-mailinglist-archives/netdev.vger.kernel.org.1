Return-Path: <netdev+bounces-96275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153258C4C71
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 08:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 676D1B20FFC
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 06:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A70DDF60;
	Tue, 14 May 2024 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAFHnLHX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1DD9445
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 06:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715669362; cv=none; b=kkEwUAWkX2ohyXAUOkHUQFk0j+33tIGD/5LlQX2R25qdmnADlQMjiSrAJCe3vEVFF36DL16dHPV0KjgK0J32ZooXbFdvEYBm9Rrz0fuuBZlLiLwj50WwFOAUo7HIYYDMEMmyEsqF2qOVTuPNBCJt4QgxdmYlkjCXfdVsAO2UepE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715669362; c=relaxed/simple;
	bh=PDzKc79S318OemLHor1K7GIJ+kE5Sm0oERs3lt7ZrvY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=HVycGCqe+RtXx7CUIpNDEXi3PsMY9TQr7WF1ty0sbCVGjnNRKOrBYlSYQD6bRq9qh0A4zHhA1NnwLXcVlstSAmCH1PKLrxPi7ljz5vUf9JhQbGrJdQ6Kl6EWr6/FQsp8bZU1l8c5oERnY1+btuOj5By/Fo/OvlGDnm89na34b80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAFHnLHX; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51fdc9af005so8344500e87.3
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 23:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715669359; x=1716274159; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yxiaa4hduWK+DM84FSG/cMAgyGyl+7SzV18oW9pcprY=;
        b=DAFHnLHXaRhTleUmu5t6xAX6SkFGxan+OrbOhvybHIJyU63NoFFBpvrg1njDjNz+s7
         63Dt9bvq/XVne7gIQWIkmbklQ05xKTlMfcF6+AGQdHTUUf+FPHtLWEVOwOMtJ0IwGqri
         u3FUZtivjdm1Pvvrv7tLgh9AKQw+bHuyZ9CdhpnofMtdM2UYV2uYIEyiTrNn9bwpkZLQ
         +2ZPp1O6aPVbzkGoH0qYueT6GAcDWkbRVCe/4ISxRLERk4PngTVYJLdf3kDoJ2PnvdSS
         BWymcrr/jt/wOtvITALEFZz+E03w+KCRWoRkB7uj30TSKwmQZGRwAFLT2OYKWgupF3yt
         9rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715669359; x=1716274159;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yxiaa4hduWK+DM84FSG/cMAgyGyl+7SzV18oW9pcprY=;
        b=pAC+wy+2sP8KFFpmfFLI2HjTTzkJm4r4zEWetPYIEh7sBoV5cuBQVcZkzxpMJ+tku0
         qWcz9A3uxluo/+SuELPpAbrv31Pepk0sdVlslvLQUikrtJcfa/hnZMjjDBEykX1zQAnJ
         Yci46SN/6PylwpsakYjC6onVue6FLAPlAy+cVqe/+BnwyIW2oiobdMXgtoa+UnDzEgRA
         pK1gHoYl8QXF6Y++7sukNwjVqsB1jZRxBmnooBmeX+ZGH8oQWmVCumSweI3BGezVPnK0
         +JZKgJ8TyH/mGxA6162CFOs0u2vU3SzkwIehKYB2DafKGKDgK+0N1kp4QhtR8gvCZxK/
         wlZQ==
X-Gm-Message-State: AOJu0Yyv+88pPjDEch4bATOgIKpAIDAYvRAfA8Xh0gkNeDcrKG74ML9f
	uEbcItNE4znaYeSRdXN//SdxSlNKNZRavmLGM5QVJWcLd2kLLk6v
X-Google-Smtp-Source: AGHT+IGDFGWYG0YU/QKpJtAML57P4AodweCld/2DqocXBPGMs+8RPN4lPBl6BMsH/gZqubEZzjhMcA==
X-Received: by 2002:a05:6512:31c7:b0:512:e02f:9fa7 with SMTP id 2adb3069b0e04-5220fc7c565mr13714073e87.1.1715669358533;
        Mon, 13 May 2024 23:49:18 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9109:bf00:c19f:1548:8365:252b? (dynamic-2a02-3100-9109-bf00-c19f-1548-8365-252b.310.pool.telefonica.de. [2a02:3100:9109:bf00:c19f:1548:8365:252b])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a5a17b01948sm689519466b.175.2024.05.13.23.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 23:49:18 -0700 (PDT)
Message-ID: <6d4a0450-9be1-4d91-ba18-5e9bd750fa40@gmail.com>
Date: Tue, 14 May 2024 08:49:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Ken Milmore <ken.milmore@gmail.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net 0/2] r8169: Fix GRO-related issue with not disabled device
 interrupts
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Ken reported that RTL8125b can lock up if gro_flush_timeout has the
default value of 20000 and napi_defer_hard_irqs is set to 0.
In this scenario device interrupts aren't disabled, what seems to
trigger some silicon bug under heavy load. I was able to reproduce this
behavior on RTL8168h.
Disabling device interrupts if NAPI is scheduled from a place other than
the driver's interrupt handler is a necessity in r8169, for other
drivers it may still be a performance optimization.
Therefore add a variant of napi_schedule_prep() with a more granular
return value.

Patch was verified to fix the issue for RTL8168h.

Heiner Kallweit (2):
  net: add napi_schedule_prep variant with more granular return value
  r8169: disable interrupts also for GRO-scheduled NAPI

 drivers/net/ethernet/realtek/r8169_main.c |  6 ++++--
 include/linux/netdevice.h                 |  7 ++++++-
 net/core/dev.c                            | 12 ++++++------
 3 files changed, 16 insertions(+), 9 deletions(-)

-- 
2.45.0

