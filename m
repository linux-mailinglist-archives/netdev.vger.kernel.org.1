Return-Path: <netdev+bounces-188654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FD1AAE0C9
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7CAB3A677E
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 13:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92635253954;
	Wed,  7 May 2025 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BE1mNzae"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD08E2B9CD;
	Wed,  7 May 2025 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746624674; cv=none; b=b7Ww3g6OAMUxUUibYKel70bIzbYVvMrxacwXN99S3waA0pJCK3lWIzU5M6T7k31l8hXIysKPo5N2tNevAgj45nKoWpLk5r8BMtIbvP3n959wD7GOPkJK7wRRh+XdFtGZGEf9joK7bTNhVk+85/4RMhZWgCCHoRoj3GY2G4Ob95c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746624674; c=relaxed/simple;
	bh=chnaCVam1ojV4Gi8iMvmPIZC9wt2tOR5DhXwW1v6K6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oahy/V/f4n94CCs/g/5PSWIWP1R/sidSHOaP1rb4lPRSZJvLTNZBgi/bNvOVIb6c5W3vqDEQmp+ZhboQmXRP9XvMYa8NF+7VMKK9sh5afJw4j19+2hnK8SfaXRcqC7UFmkevm4b6ySb2YkRKRznxa0fJ5QMjcMmgiRxo49TChxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BE1mNzae; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso1188226866b.3;
        Wed, 07 May 2025 06:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746624671; x=1747229471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMLUK1+DSffFIbuoUTgm8AIQgo1jz7butcVN72PZbDo=;
        b=BE1mNzaeZagzvBsDFWHORgX4Rh6ohg1mxRJcDocBeqIXSR3Ja4T6CI1Bi5dJ0JNOlM
         1BK6A5M7SZQQVytYfU9lq7P/zjwDwWfsxw7yx7LtqkFEjEYnOXyAHflDxM5R7rambPwp
         6clGF2fioUTN/oMATuAegnx3TNij2FuatBfn2hWSp5MxS40sIn7xXILcCkJAwTzvWPVP
         Hc4dh/H5earTbhYK6uETcx2Z88yjqkDgiHc/LUlyjmVWYR+xOGzKM0HRUlZJCzTRU6hZ
         TzssTINT0w8nBR4U2hXWGtGYC9P7Ja5voM74Ddo+zHQZhcloB5umyWI1nKvs/t7M5qVl
         vEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746624671; x=1747229471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMLUK1+DSffFIbuoUTgm8AIQgo1jz7butcVN72PZbDo=;
        b=lCrq1ZgU7LwVKxXcxvSqQIOXrRqRJTvzmrgyl0q7qXjJ6dBeN9QSGtt/MSqrqym+kJ
         J981F0eRMi0TcS+TgQHQVsghGJCWR8sBnPp4caybI73yRnEGCMU9fDe5BU08TC1zyhPH
         2qQGr0BpqDVMNQhLh1JPi3BgcBrnZjWFls+1Q5UqJqVhrG0Tq3Tc3m27CF8zkm6gLfPn
         UPHQx0kNam/kIvE1D0LlKT801W7eYuYVjMigKQ+4N0tZSRjyeiAaDCSHeJ0T/U24SHdA
         RuZX4BmexJ9cr9SeZkMWJgxqM4mTvQEJUGnOd5fsX9Oz2OGOyShME7kai5iJnx+ucsP4
         TLqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ5MOi78h8iXg4l1Tk4WI4Hzt17Jwed3xPARsKl56+15nLXMthnrW1n376/KmfB9EsTkvzg8lSEAus@vger.kernel.org, AJvYcCUxn0M2Z8D/VoYPhsQlkT0EiU6l3anhCWD07sAROV7Ch6LDAMeEFNKC0vnvO3j/b5U6uo3v84bzEsEV@vger.kernel.org, AJvYcCVZm6krT+ofgHLoRZ8HsXFWYUvNNJhoy/meyVCvA2Ux/gTqwdpheR2q7XTnnCuXEVh5s0P0GSHk7jqHAF6m@vger.kernel.org
X-Gm-Message-State: AOJu0YxOqI5vZ/XE4VpqylGKn7F4f1d80euu7pP0QOoR1VDIPVsVr8TT
	WETjZQ5mm0hdUVK+Roiq3ljZmqA7WaXmdIq/+2SV8+UX0kz7zuNHmdoI902G+IGcG20gksyASNd
	ho1PzPo36rU8Y8bKwsgbPa4Gaql9R2Rls
X-Gm-Gg: ASbGncveZqEua0m/USH4kAXNnTVDfn9s0ixGT8Z7e6DTFrKhjrqxTMHwWl8IBN5AecD
	cHQVVsvIIZSvuB+sfIPbgx/0uVJXjMi5r6EY3JTUJjPmAmfSP/UyOwgVX42GOj40LHh8CC2nIJ9
	RI72Xdkx3GD4jKb7I/qLYGXJvxw15c9psfxs8=
X-Google-Smtp-Source: AGHT+IHNcpkL2VTtUnMUjWG5urZVwKTC1gn3U8TME2PAES3AyvskcpMcC5URq++Hrm3nPn5DpRiyiBRSbFsFOHWWB2U=
X-Received: by 2002:a17:907:d2a:b0:ace:9d90:cdd3 with SMTP id
 a640c23a62f3a-ad1e8d0ba19mr359060266b.49.1746624670744; Wed, 07 May 2025
 06:31:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507124358.48776-1-ivecera@redhat.com> <20250507124358.48776-9-ivecera@redhat.com>
In-Reply-To: <20250507124358.48776-9-ivecera@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 7 May 2025 16:30:33 +0300
X-Gm-Features: ATxdqUEq24ajhDXo1Kn1PDm2eAdnktBxZULVVBowv3DoAhXXZvLonCuEik0YGTw
Message-ID: <CAHp75VcH81AHt5dw0cfYa6Wv8LwZrss9uo2x9ERfK9=47erbdA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 8/8] mfd: zl3073x: Register DPLL sub-device
 during init
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>, Michal Schmidt <mschmidt@redhat.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 3:45=E2=80=AFPM Ivan Vecera <ivecera@redhat.com> wro=
te:
>
> Register DPLL sub-devices to expose the functionality provided
> by ZL3073x chip family. Each sub-device represents one of
> the available DPLL channels.

...

> +/**
> + * struct zl3073x_pdata - zl3073x sub-device platform data
> + * @channel: channel to use
> + */
> +struct zl3073x_pdata {
> +       u8      channel;
> +};

You can also use software nodes (via device properties).

But since the current solution doesn't require any additional files or
something like that, I don't care much.

--=20
With Best Regards,
Andy Shevchenko

