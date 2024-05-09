Return-Path: <netdev+bounces-95156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E68388C185B
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 23:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82F0EB20D07
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 21:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B78785C65;
	Thu,  9 May 2024 21:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="SvQCTsBu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FCE85264
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715290021; cv=none; b=qXYcP100QmBTFl2Rp9kSBWddMcZy1ZmiQmq2SkY0Xzr1agZnsCflfDdzgEgP2LRVi4DAh3FjblwOmGC7/LV6k8Cul5EnnSMwgzENggB8G74Aw328Vum/GVD7aihNMoI5BFScxhPAoQgdHpwlGEAul63MDS35sCsMpsZ7pQ7+Bi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715290021; c=relaxed/simple;
	bh=sh2RVcH3kYXx3pxWSDGSev2r56o7qSVgAC52eozUMkE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qhzSzOaI7ne1XWA3i8xd/fOz3VO1ebXSXAssduKLGdMo0YX5yAUHaYSESalmUP7ikp2x2CIycQv57qis5NFQ6INZGuN7h1ZLy3tNwtmk7S1wvwFjKvhKe9SVUVPlfRIuUCKsUv2tfk4ZZs0wF0v99FMUlqhIE2X0G9o0uksCaQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=SvQCTsBu; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59a387fbc9so350522166b.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 14:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1715290019; x=1715894819; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJpnYp9Gok3jjEaTByhEx/g2RIutD08xBpO53TQkyBA=;
        b=SvQCTsBuu9qYbfTyxs3r99RzaTnjBQyOb9AbGUAGwSU6PvO6IKULoplLnnYOcEi4lm
         7uve9FtRUWnD1D/OoxXL54vWkU6gxdW5fRILK+MpXDhrDyh+kXK49S4Goc+QhBoOP/vO
         ViFCamhIdClhN0tuwRO3TqThqoRY0wLj6CJ/otNCKPuCNCVvnBH644uxNGk1rBRvVc3u
         0uXFgip7VOU2jdyZqCNBdY9eVd4LcwkAx3y/s1mzCI61nb2gAjuXWvcejeeoOCvJ0d5y
         TUGh6b1cLBP7AC8mVdpEuXjadJtHMShTNzt5sFB+xqP+958DDHuNl/3JGFMDdYfLWyKJ
         LgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715290019; x=1715894819;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJpnYp9Gok3jjEaTByhEx/g2RIutD08xBpO53TQkyBA=;
        b=DuemjAK+QUCILIjdUkvpWwFhWDt5iCbS5um6O5cI81HbGdFAZ3cLluFuiO1PKnVgm9
         jsNGP7TucrHJVknAcwYA4Xm9PE6M0lk+POhVoFEanVkV/LWx+8p0vgSx/UcuKNMyr0Xf
         2rmsaMNeaqMCiQw7lyYk1ME3GkKXetSd8Ab5zFzrbGnnsHR4NOAbD+O1KnEGcTIuyUj0
         kp5lG1TvU5pYeJqj56PSfMYrYAKmB/pADmCKMpgEjVf7rUEBf/VLV5BYTdQWVts7+TlY
         8QxUt3I7zz7AQogW65zqL3eeJ0qBLPChEXMAVZ8PEDHwfnTNJ6LOmWWMZ9m1kAx4EYs2
         4wMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpo+tfhwTDo8bRhElMhPTNeTzmqZh4/rARWiOJTmXPi3RUtLVTW98qi4XIRMyn8P8Smzb7HJ3Rz5uCVy3374toDd1ZTgok
X-Gm-Message-State: AOJu0Yx9tbGaJErPhH7YGahPDSxzTlMWiODIYDOPAwUtIgIVG413BbzI
	i4t2KSX+a596djEsq1ZNHzQ5eVnH/my7js4Fyhjpcv05ZVU083tpEPqZX2GIwnz2DzwlUfLcAEv
	aBT4=
X-Google-Smtp-Source: AGHT+IFtYo+0Pn0orW7bPoagGtyFqlCu8vgHBbRxWWEscfR2+qoH0iwqBQyJ2OIx7eQMwYd7E6Jpcg==
X-Received: by 2002:a50:bac4:0:b0:572:9f40:514d with SMTP id 4fb4d7f45d1cf-5734d67aadbmr523850a12.29.1715290018651;
        Thu, 09 May 2024 14:26:58 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:aa3:5c01:9c2d:df77:ab3f:a592])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2c7dd9sm1065430a12.69.2024.05.09.14.26.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2024 14:26:58 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] net: smc91x: Fix m68k kernel compilation for ColdFire CPU
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <98259c2f-b44a-467e-8854-48641984e468@lunn.ch>
Date: Thu, 9 May 2024 23:26:46 +0200
Cc: Nicolas Pitre <nico@fluxnic.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Arnd Bergmann <arnd@arndb.de>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FF387A27-547C-448A-AF52-8E170C05C094@toblux.com>
References: <20240509121713.190076-2-thorsten.blum@toblux.com>
 <98259c2f-b44a-467e-8854-48641984e468@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 9. May 2024, at 22:36, Andrew Lunn <andrew@lunn.ch> wrote:
> This seems like the wrong fix.
>=20
> commit d97cf70af09721ef416c61faa44543e3b84c9a55
> Author: Greg Ungerer <gerg@linux-m68k.org>
> Date:   Fri Mar 23 23:39:10 2018 +1000
>=20
>    m68k: use asm-generic/io.h for non-MMU io access functions
>=20
>    There is nothing really special about the non-MMU m68k IO access =
functions.
>    So we can easily switch to using the asm-generic/io.h functions.
>=20
> So it rather than put something back which there is an aim to remove,
> please find the generic replacement. This _swapw() swaps a 16 bit
> word. The generic for that is swab16().

Thanks. I will use ioread16be() and iowrite16be() as suggested by Arnd
instead and submit a v2 shortly.

Thorsten=

