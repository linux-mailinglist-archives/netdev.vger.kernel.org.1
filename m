Return-Path: <netdev+bounces-71059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C19851D68
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 19:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B95284071
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 18:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1213B3E49C;
	Mon, 12 Feb 2024 18:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcrUjt+n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD0E45973
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 18:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707764231; cv=none; b=L0xIdhbu3iFrSLoSG9Mfpv3jjifJPxvZDCqt3N1lT8l+CoF6n/JDAuvUaYbJcZradNURQbh8IvBuTz1OtAE1fTu6oHigfcq9QO4LWFNAZ4zjm6ZOWMDHB+wtHSIOsEjKzCWuRSJGsMKNVi/Wodwx+Y9h9uHXXz0uoDSZgSerBjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707764231; c=relaxed/simple;
	bh=Zv/o+j2rMEm7TxrJziuabT8VapZOPKb8f8kno8CkC6o=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=UsqJpTvyaT8+rQAVk5gUe9HxGsOx5Htdi4bRswdDwDZhdREh8rdgIz0MC4I5nZ01r3TSLQh0uAu6s4egof0eOtEpeL4W5vHd7q6tAhtaRcuExdBgKJ/xjWiAWTUkU+XyVpAq3TShwDVe2sRz0AGmUeFj1lY9+AzODNqVsVpnJf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcrUjt+n; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so5239631a12.2
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 10:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707764227; x=1708369027; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Z+4CmvonEkAdLD4jGgqFoHPK5DNX3X8m4mK30v8ZgA=;
        b=HcrUjt+nPVe/CaIrQeSt7dziyJX0l6I2NhA4/WZVdXi3xACCGCjtn5yhtx8grMtxVl
         7YxlFYUiRpHNUQ5hq24juCx5NfNu9Ufx2Sy1/yqNbwGSjS3Z+pG1rL4YRXNP7hUJ+IyW
         HASjfeY1MnuX1odPxcciClyeyeQfRbWq9lkBNOAurs8NhyHL1vfxMH8Z33LEtecyhW8P
         O9lcjuf4uTQ/D6rb2hVrEB0LbSwGfEI/DytGZNHHOyahxFKoN0fVyRxAGuSMzS2e7LnW
         1/gTyBJgYQIqlzVou9ovSImFltPHFzPxAqqJ4/2ZM/P1YgZSs382IeIZSZB3keXvAxby
         /vwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707764227; x=1708369027;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Z+4CmvonEkAdLD4jGgqFoHPK5DNX3X8m4mK30v8ZgA=;
        b=f27prrLL2jIKIKawqOUzIx0MOAV3l1VFra7t9MAiVAe/ua0HHrLUb6CW3IVJk1LqY1
         yhrTEa76QBUmtifzbccFjdEIbwb6stSOEWRSYX8wM+vMhjjHQGBV/zLKgdRznvK1TdDq
         fQezwTIdhlqpkXklcdYNRjQk2xLGDbMTjSBGGpXWScgIXfaXxoVsIszN7uXQwb0JEuPU
         yG8e4NI5AG/9iW3kJsEYXAHo0x2/8KI7cSFe6sacAf9I8jbvLHh37J2NmoobFVKM5sh6
         hd5Ws6CcUlBKSrQn5WSNj7o4HQLNssFCQuFb+nV5hMt1YOv+EjRpC52xGufwaDYZnB6v
         Hb3w==
X-Gm-Message-State: AOJu0Yw8KSZkib/gS9dhWuYxGhD2EmTaDpmNxSn8sLT3koXH3wTh8DUY
	hRXxvXpqg14ozFzL6gknHfI8VponwKy+MNJ5EC4cpZoGvyQX+FGM
X-Google-Smtp-Source: AGHT+IGfL5Bdp5XhXXMrwj4zjfnWd6YD+1abgBeE6WCSQZNQLDeTVA+Epbyk2p/8aZUd3mquYI7HQQ==
X-Received: by 2002:a05:6402:61a:b0:561:b9a3:f589 with SMTP id n26-20020a056402061a00b00561b9a3f589mr2116282edv.4.1707764227336;
        Mon, 12 Feb 2024 10:57:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV3Yrk5y+BTAqwopbDbEYN+qaSpI3J37p6Y4cZD1wLbfy7/ARrOsNl2uSScDdJ6oVy0w0o8k8Qf97RE6RWU/A2mKoa/Xf8lH+MXBRJsPRzYqhMcPCNWuwDcB705dIg0FO2Y/PvD8Txi4H+sv8KzW9TaGfKQOqY6aQoVgNab
Received: from ?IPV6:2a01:c22:778f:2300:f4de:66ea:cd50:b2c7? (dynamic-2a01-0c22-778f-2300-f4de-66ea-cd50-b2c7.c22.pool.telefonica.de. [2a01:c22:778f:2300:f4de:66ea:cd50:b2c7])
        by smtp.googlemail.com with ESMTPSA id t22-20020a50d716000000b0055fe55441cbsm3154227edi.40.2024.02.12.10.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 10:57:07 -0800 (PST)
Message-ID: <89a5fef5-a4b7-4d5d-9c35-764248be5a19@gmail.com>
Date: Mon, 12 Feb 2024 19:57:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/3] r8169: extend EEE tx idle timer support
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This series extends EEE tx idle timer support, and exposes the timer
value to userspace.

Heiner Kallweit (3):
  r8169: add generic rtl_set_eee_txidle_timer function
  r8169: support setting the EEE tx idle timer on RTL8168h
  r8169: add support for returning tx_lpi_timer in ethtool get_eee

 drivers/net/ethernet/realtek/r8169_main.c | 61 +++++++++++++++++------
 1 file changed, 46 insertions(+), 15 deletions(-)

-- 
2.43.1


