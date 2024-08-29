Return-Path: <netdev+bounces-123383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8613B964ABB
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420C42817C9
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442D81B3B32;
	Thu, 29 Aug 2024 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIyjhC1V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E801B3B17;
	Thu, 29 Aug 2024 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946997; cv=none; b=BQ50rVKZ/mrOGaSHiEeIJABfLtW27R+zBpUyQEnnsNeuWcs1GV/21CLz7tQZSMc9yhxsUYTFwlJH8bI+5DzZJSJWk/gu1Oyoij1r7vffLC57uIJpIhDFG2t0f+WxKMIpbBx1qqqnGhTLnB5nLRF8NssfthqaJzqLyQfBvTwfX+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946997; c=relaxed/simple;
	bh=PviRpfpqK9JXskhfZMHtpkS78faBYgJFLUbLZqdOyB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=un/er2pVGh5DyUeVEtXTREhKK6YYb+7YGx9cb/nsEAXN3vyXeGXUuGEVvOx6yQrBY2o1xzEZ/HF0jjN9Ru+kz9mlOwA3B8W0pu8k9o21jdTszROeTghMPm3WoomYaW+gljnT6AH+CSzdfRdsgTpJ9wIogArt+RYRgf7JUNhPbO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIyjhC1V; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3df02c407c4so478468b6e.1;
        Thu, 29 Aug 2024 08:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724946995; x=1725551795; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qiTrQ87i0C2ol472/aHP4mWof8v75yvzDiuuo/uUMDA=;
        b=PIyjhC1VyGQh1NLtxbDFK90uFRIbBpEy+sONc9Q3IT44LiezrcVFByrvQQKZ1iSxL/
         PVsT0KrSDBG/JhzMZMFVZbT+7PAbU5jhowhUFukBtPxzroNn02xNxPz9rrQ7Hhe1o3dW
         Prn1NBrHo2dmPVs0AwEQZN8xdnz5gprHNIGpT/gAF0SjAOtoKXNcP2tXyBDLuNO9ETrr
         PHkANQVrVNgYkuMeJljbm7sOWvGkC/yfpSPPPVBcRsZ4OKoEus+v154Kew0YMALHODRv
         FREGdlAz4MjV0EWA0MjSC8XX4lacnpLTXOnviVXc41Dmrlg16gVgRv6vAQ2k3NOaLRFN
         KnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724946995; x=1725551795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qiTrQ87i0C2ol472/aHP4mWof8v75yvzDiuuo/uUMDA=;
        b=I69qzNKN+IMhbkH25b5YlT6KQafwFXcz/JpDOWaNTaVwiv8O4EZf30FRGttADaGWEg
         EKkmr4T4TEaSna4w71rVUS/D12kxRn4gjryXmDITUGzeJtp2X+TkT0YyoYDOjOcULDQD
         MuU//MUYVK5yGRBYEAW912DhjOyq1iypDI3v7bet2cM1lGC9GZDMlptpc5NMdGx8asCM
         Gr/5VueKYAsk3xuK3nvBCHbd1bl0mZYBOB21C672GDmwIBeuKW4GCsZvzE/mKSsYiGmZ
         41lrdmc5eauIVYNzMwgLlk+/wbQPlPj82WQJakCisfg3/URS743iLfOu6GQ1jifRsRRM
         cWBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNUR8zPoVAe4mkR4RKV60SMzesTey95TgAh7vFawfhxSbVl7NhsMa6QLL3QqQD6oWB4kWFof52v3rkpC4=@vger.kernel.org, AJvYcCVhPPzk405QnHMnfJxnftqS9ZyvcBMRHjd8cSpm0u6TJ/LaxlfqddOD9EgR+8tW7yR7hfo6lKgn@vger.kernel.org
X-Gm-Message-State: AOJu0YxtFhoIDFlJJZTeK6R2pY/RUEgSQ5ARlM9FHaHASNrKGWhx8uuY
	y+8p0SeGu2MgfmeyJ3dGKbBdFoaWqUFlFpDgcfEcGGFhwcswQfH3OH6R2NrCrzl8fXwA3HrwBcX
	s1Ko5P7rgHeSrbsdnIIk/TS2251s=
X-Google-Smtp-Source: AGHT+IGam8FEjzZzD8DHtWtgRT8AnBamm3CGiHHyu6reKzIM7SVI7JUWG1y1zn8wBdwmJhJvG8qYQ2M79G3sWXOlzCE=
X-Received: by 2002:a05:6870:93c8:b0:264:9161:82e8 with SMTP id
 586e51a60fabf-2779031721fmr3605801fac.41.1724946994832; Thu, 29 Aug 2024
 08:56:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828102801.227588-1-vtpieter@gmail.com> <9066b22b221f97287484f1b961476ce6a67249df.camel@microchip.com>
In-Reply-To: <9066b22b221f97287484f1b961476ce6a67249df.camel@microchip.com>
From: Pieter <vtpieter@gmail.com>
Date: Thu, 29 Aug 2024 17:56:23 +0200
Message-ID: <CAHvy4Ar50cT-h9f-1Q7BVLHZuDzGY0enWt_ww2c8tdzEw5_hxg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/1] net: dsa: microchip: rename ksz8 series files
To: Arun.Ramadoss@microchip.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	Woojung.Huh@microchip.com, f.fainelli@gmail.com, kuba@kernel.org, 
	UNGLinuxDriver@microchip.com, edumazet@google.com, pabeni@redhat.com, 
	pieter.van.trappen@cern.ch, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Tristram.Ha@microchip.com
Content-Type: text/plain; charset="UTF-8"

Hi Arun,

> Refactoring the file name will better align what the implementation is.
> But the file header/Kconfig should mentions what all the switches it
> support.
> Because there are two switches KSZ8563 and KSZ8567 does not belong to
> this Family. Instead it belongs to KSZ9477 family with only difference
> they are not gigabit capable.
>
> The switch comes in KSZ8.c files are KSZ8863/KSZ8873,KSZ8895/KSZ8864,
> KSZ8794/KSZ8795/KSZ8765.

Thanks, that makes sense - will do so. Looking now at chip_ids there's
(for me) some confusion regarding KSZ8830 mentions such as
KSZ8830_CHIP_ID which actually refers to the KSZ8863/73 switches.
Often, such as in ksz_is_ksz88x3, the KSZ88X3 naming is also used for
exactly these switches which is more intuitive but it doesn't help to
have two names for the same thing. Do you agree to remove KSZ8830
terms  in favor of KSZ88X3 as part of this patch series (will split)?

PS as far as I can see the KSZ8830 switch itself doesn't exist.

Added Oleksij and Tristram to Cc.

Cheers, Pieter

