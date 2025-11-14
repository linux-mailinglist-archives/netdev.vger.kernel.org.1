Return-Path: <netdev+bounces-238624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F179C5C2B9
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 10:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D9193BEAF2
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 09:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DA1304972;
	Fri, 14 Nov 2025 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMGmbbxM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0A7302CD8
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111255; cv=none; b=i9Mg/G5TUhBCqZUi5jnphjDmqOkOIBAGEMNIUppRDNsFQTlB9c0j2bEWo5/NkgHmlbYgxCaEoW82RG3ul4QUIuMlT7ZEQvgxwT4UlOm7xWR48kZIzf/9ZJyK8ZAqNjOrb51YSIu/RReOAMUhiv2/rt60mv4BarCWPE08quW0a1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111255; c=relaxed/simple;
	bh=JSs1H0agWCrllX0zoQ2RL3I5lwImx1IPLl+3KiI90Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaP1d21wcD7FXrzu8xzt5X0nHlwbnNnnV5vafVaBowF8hta47LzJOwrTaDppbzwYLE6rXPeOWtYwAvNnQ7a6qMTBvyU1v4qI3lJmcbecB1TruOZuqVdqQm1t4jbYYLLGL5svqeijdqG1KK5mVIwi3hZkUc+sjz7fN5pQQvOnv5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMGmbbxM; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7ad1cd0db3bso1527233b3a.1
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 01:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763111252; x=1763716052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2rYHecsq4zvxvYBq75VRFVLEWv3/K1IVEP6Qf5yN8cw=;
        b=nMGmbbxM20gInv957Miu6DoXKryX7tpTPA+KiZJbreuV3fnX22uSPH01wEoBncqDsG
         FCAjzVr0BcJoKsbvKotF5+G/QLKD0FEZOPdLF+0p0olOGDWmUIVqWxvm8QWGPW78M4L4
         Pl7b6KSwFjUwaa1AIBAKlkHvAgiCuHmF2vwVKaorQU4CVrVJQjTYZ4Dov4wXBDy50Whs
         mH1bSnI+ezR1D7m/3P7Xshky7SAMBsg5LR9Y4O9r6qZaBj4pjqhh4xxyRdd4NrGFw34f
         0JhUD5i5YJtY+JsWG1RhxfQyGarbPQRaYMWTbEdk/CJYy9x5mH1JEiLrzg5juzKQdcAq
         9nCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763111252; x=1763716052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rYHecsq4zvxvYBq75VRFVLEWv3/K1IVEP6Qf5yN8cw=;
        b=I7l0msmQrPVVtziW2xr7IrdCxu2N2kcWblGC+1Fu/dmgGlyMUO6xS7r2RKU651lo9p
         DxinnTCKyotljeZC5pdHYCgj7tet9aZ8+vuY3iwK8NWf9xrYo22pywWWRfl7qmCnCTJb
         21X2FHJScF0PY9gJGrkrYALHkUH3KV3F/cNuCovMAzWbX3lLHsAjFad8Izhl8kNnGzbu
         NFLIrwgsvopJtK+vOphU1W/oDWvo9pxHqa8HKerwh+02WHIS9gp0SbLQcjf0YwIpQ5rc
         1Zw7B5n4xLfiYS4RrQWufW2sNFlmQgTSjVulHtrtwvBqqztTMVYP4bKAFWggSf5OD71o
         PWow==
X-Forwarded-Encrypted: i=1; AJvYcCUbuUESzA0CIS6wWzRM/UKlnBS58+NRR3vvkHwyFScMQhRe96p09CUbcS/+5xe6Fal0iUnWAeM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc+0cescyyjePx7S8xxtpeO7/Q5WWyV7jFpXir7jfTyPXbvWDa
	sgEoxvUQiIfqWQbH3ef/UD1Un+LQ8c5bdsh/yS/fCGNOm36LidIbg2QZ
X-Gm-Gg: ASbGncsp7GVcgLKtaNCUti1Q578r2dsFIJqaq1Teiene4RQWpCX8viaBRJygSWB6GNG
	R/aTzQyZv4bUfegv05NqaNZUTjLoGUXRZ2R+aj+aji6ul/ADeFkyjNwYVX90euI6tHarMBvqif4
	PxHBwNPL9j0qgRn6ZNZy2GngWjPsOMx5sTTT2z9TyMRKowLAM692qEszv7RznxSLwpq1aiJsADS
	sLa4vmECm9XHxM5CRlgLWYszIFaxp+hNzA1ZMmZh83Cw0P3otAI2qJNUK98J9rW4W8xxQstSUfs
	f6TC7Nlyw5wZsIlcsA5wZvJfDS+Re9X1bk4+wE25VXfQlES2xczAF0SDKmLX0lsvJxIVlu758Uu
	aeVFdgwGAO/nAZU2XQrxdkkeEpGgorkRIY9RMaKVBnssMjxOOBsfPWIsEwm+aIh90R9nzb4vRWi
	8=
X-Google-Smtp-Source: AGHT+IF1HyHMzrr+Mh1xwS8BniwAv9DG6MkLy9OtJ5wmhJOlJxohZkmPSeXsb+2DhZbbA0kfQQDTTQ==
X-Received: by 2002:a05:6a21:33a9:b0:35b:5127:d4db with SMTP id adf61e73a8af0-35ba259d9demr3424696637.53.1763111251549;
        Fri, 14 Nov 2025 01:07:31 -0800 (PST)
Received: from fedora ([110.224.242.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924aea0f8sm4629086b3a.5.2025.11.14.01.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:07:31 -0800 (PST)
Date: Fri, 14 Nov 2025 14:37:20 +0530
From: ShiHao <i.shihao.999@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	i.shihao.999@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, mchan@broadcom.com,
	netdev@vger.kernel.org, pabeni@redhat.com,
	pavan.chebbi@broadcom.com
Subject: Re: [PATCH] net: ethernet: broadcom: replace strcpy with strscpy
Message-ID: <aRbxSCXsWCar8tw8@fedora>
References: <20251113082517.49007-1-i.shihao.999@gmail.com>
 <20251113192218.3c17dabc@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251113192218.3c17dabc@pumpkin>

On Thu, Nov 13, 2025 at 07:22:18PM +0000, David Laight wrote:

> No one really knows that TG3_BPN_SIZE is in any way related to the destination.
> So this doesn't actually make the code that much better at all.
>
> Since tp->board_part_number is an array and "BCM5717" a constant I suspect
> there is already a compile-time check that the string fits.
> The strcpy() will also be converted to a memcpy().
>
> So all, in all, this makes the code worse on several fronts.
>
> 	Davidi


Okay. I got it thanks for your time david.

