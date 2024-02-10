Return-Path: <netdev+bounces-70787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DF3850641
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 21:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968CB1F22F46
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 20:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB36D1D6BD;
	Sat, 10 Feb 2024 20:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="vkUTod0C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DA46125
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 20:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707597187; cv=none; b=kW6vTKbo5ShlnhGNU9tkUr9JDQ2xlanYfXxb2GdmVBIg2ITASXZaltrsvYpVycGwhkD2T5/TfPPUnA6ZQM9yM5RDw1a/tu3EgbJvzzAWXv+8jE3rTgliYXsiuyRPVOahV1MOXpbcTGe1Y67IJvwjQ6PJ/EdkNhh3yPpMgCCfc7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707597187; c=relaxed/simple;
	bh=84+yCLXMMkM+OMQ0N0Ng7dhebri50KU7+EvR7BJuAqk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXng3hU5TindmcbXwLjJh//WlBQnXhcbxJP0I4MP6aXadEopW/GlgVwilqTzZlsH/UEzPGB3t6Pn9ZfRiybzTFXOfCd3tEdm9GgHWhNMW9Qa3AFTDwIuAC49JdfajESrRoVrM9qVC2l+SPlYEvDWjtppty8PxCybSytQ8xGtFqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=vkUTod0C; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d93ddd76adso15871915ad.2
        for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 12:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707597185; x=1708201985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuP08TyWACuZ7JTX7QazkzSr+RKXLTc1sigaWa6aZP8=;
        b=vkUTod0C17irUHNY+nwgTAiiJQvo+PBbXjwJm0BBBV8q853Y+BWp+5Wwa7jzb+e3Qq
         Ltu+VoV9tM8ucTWQGrjlMtepiQiwhT2ouC6Ea2tEau0EfnaKN5JcKTOqDDAAaRhWMGAx
         yXAzl/C7U6HXLaOXOkIvtclDLsex1NErVIuTTTDAf/aaYBkJ3Lk0byMN8kD/aPwwrGbH
         g/M96vT95+3S7HAZmyhe676aaX4HUdupYeFKAktOflJ1ooQt6xzNOUhPcZxB7vMpsrin
         NYGZuD5/zicx1n+6c/EOGDLl1FjJp7Y3sY7B5Vvx/khCZyXkWV6yKMVEHL/l7+e9F87B
         mZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707597185; x=1708201985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuP08TyWACuZ7JTX7QazkzSr+RKXLTc1sigaWa6aZP8=;
        b=YyjbrpwttT3crhpEeT1Uo1yTYCrabVQHdJZhV0UITU2PVVuAPowldKfK9FoVQqB8uZ
         GkK2UP39xY78AyDicmUAiYs0qJ8UQ96R9Ni0f/kCDDzWjgZH3f4NzjmpSLf6KM868/kW
         iuBMb5Bb7An3o7lLpileIMOl14x89Inx9NHVcYheI0yNs3V+nSgYLuG0rSXWIiwl1RGj
         qD05V/qTttTMOtbhMeopWGQljcsuji1tmm1duzU+xBeqp9wyl1Rk8I96WEcv3PJfgXJx
         3shMQR/i6CB9UM/pfUc61yYPlgWzF1Huol5kcv6PMpTyo6kynflMbsL/uBvCXVZ+OSdj
         ZnIg==
X-Gm-Message-State: AOJu0YwOf8Y5pAkZpD95byH/Tg9pO8QzGmeSe5BxIamZn9DXigYy+Per
	UqHeKyWuqlvsI6J5Cm00vu6eNNR53RweewFK6ms2vI5tJ/jEA/u+SjIw6NAd5sY=
X-Google-Smtp-Source: AGHT+IFZZ+US/CithIYSU6hGDYhyXSI2EpOgXYfOPpc2eRYbPQz1feYU4QtHSo+JcqRp3lVhZLfBNw==
X-Received: by 2002:a17:903:26c4:b0:1d9:24cb:3cdd with SMTP id jg4-20020a17090326c400b001d924cb3cddmr2126309plb.46.1707597184966;
        Sat, 10 Feb 2024 12:33:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX7rnhX1V62IGsiUI6bPz+Q4Vy4diM9ZTGBSdsAB50Cu4M4hwgqXbdOeCLD9mL2ICCIS6A87Gvuco6iI8NdP5kl5g==
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b001d9469967e8sm3388033plh.122.2024.02.10.12.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 12:33:04 -0800 (PST)
Date: Sat, 10 Feb 2024 12:33:03 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: netdev@vger.kernel.org, Denis Kirjanov <dkirjanov@suse.de>
Subject: Re: [PATCH v2 iproute2] ifstat: convert sprintf to snprintf
Message-ID: <20240210123303.4737392e@hermes.local>
In-Reply-To: <20240202093527.38376-1-dkirjanov@suse.de>
References: <20240202093527.38376-1-dkirjanov@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Feb 2024 04:35:27 -0500
Denis Kirjanov <kirjanov@gmail.com> wrote:

> Use snprintf to print only valid data
> 
> v2: adjust formatting
> 
> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> ---

Tried this but compile failed

ifstat.c:896:2: warning: 'snprintf' size argument is too large; destination buffer has size 107, but size argument is 108 [-Wfortify-source]
        snprintf(sun.sun_path + 1, sizeof(sun.sun_path), "ifstat%d", getuid());

