Return-Path: <netdev+bounces-136286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FC49A1363
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E7928463D
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA624206E86;
	Wed, 16 Oct 2024 20:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSXbqmpd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBCC1C4A14
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 20:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109088; cv=none; b=JMFyVrk9gWSii2Tifwdbw2U8MdNwF+ikPY9QGsUVgYvod3rd02bhtAiB7kt9CBISDkPAoI5F6NMYZ2HhPTgrJ8c2OQJ+vQgx4Es111ZK+MIuznHCRGqOwp7iw6roaykEhLGT7VA+4U7u61yvmoENEKf8GhQHX4q1rP1pxGMMCvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109088; c=relaxed/simple;
	bh=gzJuToTC5DCHUrvhxERmOT0R2lnbphWq0cSvaTZTAbo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Zt8ulpxpE3isY8Rv9mKMjHyqGKHGgNxhNPsrLpUzI2LWO+YmFslwsydBIUlMy3wIsR65FxRKYfeUnC9k1ZIDFOj3wJtrbxxORh2HQePzofPjxX7pYGUOcu+aSgNuwTOW1Xs20iODBWDgPSW6C40IyxkeL/JMNxg5d+VzAzTUUvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSXbqmpd; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a993a6348e0so10453266b.1
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 13:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729109085; x=1729713885; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTEtg1FgdddGWB/WNxYe2LYW1+pnJ3ANcNuyPtTOlzQ=;
        b=eSXbqmpdzhO9Y5vahuRbf3iip31BcimeZjAcnCQSpSLigfi1MP8p7y3Vwv3SNMzauz
         5b3UQcDxv2NjDtGUdxWfwVFm89QNahD0Dxu9SpJ8OZEUTHlm/gtFxm1rDa3G+wR6ox7R
         Ms+5d2JKvuB91zaz7Yy13Z8ODNu2/XPaqUuFQ4Xhdqcn0+I3KsSLuGsSdLjFa7ZHgFx+
         OotsTRTZuntMEnIByRuXIZAWsr2aDS3CCr/VwO33oC2p9qv0YvtJQiALviE8QMKQL2lf
         Ussc31c5lz3OjgsMADK6CozB9OnyhZF4PFZc6vcZGyJ55ASg1Td8nrgLgPjn1v3aWkVm
         cDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729109085; x=1729713885;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HTEtg1FgdddGWB/WNxYe2LYW1+pnJ3ANcNuyPtTOlzQ=;
        b=m+GiG4dv5ZOQolh4aAFB2ZTBVdw2rlbyXQuZSKD2zVQgU2EeLVuMTYTYcyxZwNTvVO
         vqKRnn7lIy2dLmukSTK+KXEz0OVoie+9EL6pJyS+Cf89U3wJpQJK8SHl9EoKS1q+fubn
         J8dT6nBc4sYDUPH3RshfRG8gYHh62j9gWhS4VUjjcSsUak671Em+Wa4qXyKNF68wF/mS
         8N03bjtIdGOOVoTP8QHRFseakAYlJJ2tJny+Ig+GCBEkZ1aUmB2U9vJb5Vr1EIM8JWVj
         SLveAI1VxPs1Qugmn6kVPVSMg/mc9QNzWN/ojlZLXaAzeGwfeaPWEKsXUPGBtFA9JnZH
         dPJw==
X-Gm-Message-State: AOJu0YyioRdlRmQXUDP7okaER+mRxo+Cevc5Ao/NAcnADmJw4sI5ozQ/
	6esaECNIh+s4CCnGoCpEyOLttFY43SuBw8vj8zAUA8NtHjol8uke
X-Google-Smtp-Source: AGHT+IHjJd/dj+rdH4ApVT3oAob+u0XAQuyMSy9oawmwSNhwaemQDfWvOGqq0UIE5F6dHnKJHHtivg==
X-Received: by 2002:a05:6402:5254:b0:5c9:21aa:b145 with SMTP id 4fb4d7f45d1cf-5c95acab403mr23968731a12.36.1729109085247;
        Wed, 16 Oct 2024 13:04:45 -0700 (PDT)
Received: from ?IPV6:2a02:3100:a554:2300:9878:3ee4:db79:2f0e? (dynamic-2a02-3100-a554-2300-9878-3ee4-db79-2f0e.310.pool.telefonica.de. [2a02:3100:a554:2300:9878:3ee4:db79:2f0e])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d779de7sm1989235a12.63.2024.10.16.13.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 13:04:44 -0700 (PDT)
Message-ID: <358ef0cd-2191-4793-9604-0e180a19f272@gmail.com>
Date: Wed, 16 Oct 2024 22:04:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/2] r8169: replace custom flag with disable_work()
 et al
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This series removes RTNL lock from rtl_task(), what is a requirement
for patch 2, where instead of a custom flag we use disable_work() et al
to define when work is allowed to be scheduled.

Heiner Kallweit (2):
  r8169: don't take RTNL lock in rtl_task()
  r8169: replace custom flag with disable_work() et al

 drivers/net/ethernet/realtek/r8169_main.c | 24 +++++++----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

-- 
2.47.0


