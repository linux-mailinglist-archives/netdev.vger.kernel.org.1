Return-Path: <netdev+bounces-182255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23E7A8854F
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA2D167819
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD1227E1D7;
	Mon, 14 Apr 2025 14:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USIirpXH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808FBDF59;
	Mon, 14 Apr 2025 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640031; cv=none; b=b3u3vgvelwkWRhgIoEtgzK+B5RUvNHVQ87JU/uyo7lSUkPuSuBbKCs3aWOro0qnnCrrER8G8C5FCZOFCJfFQ9ah+TVEu5Kdqap2U1iLHB3uzJ/oZfYIQ1d4dxaCv3F69ji/UtNSV6DPenQ3MlSAKYZKkyM2lpLHaiDHiAjd08VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640031; c=relaxed/simple;
	bh=5yCWkL2WDN1lvZZXaXOpa4x+vmtWrwc1PsatHE9CvEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfDUvy+P+4qb7FG4f/hT7LuWRs78+rR3bi6XtN9rn/hX/cDcgI5PahbawNhDhItLbHobdCYfnWM6mcXQFmeQxFk08D9cGp4Q7i1rdGvAxKMd+yxuDyW7PlvAeXHwff9QMghRha2SC1Fbtb2R830PwPbwpk3xKeAXLzvP6Fzv1K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USIirpXH; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e677f59438so6382793a12.2;
        Mon, 14 Apr 2025 07:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744640028; x=1745244828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yCWkL2WDN1lvZZXaXOpa4x+vmtWrwc1PsatHE9CvEw=;
        b=USIirpXHg/ExInu0LVNuboa1bDFdM2yFL6CzY1aeVsS3ADB3KF7Ln+nQuTEguptFYv
         pY44zulvxFJMku6nCjKghYIw5OV6Ci8MSu/uJZFYCgi5NIOk2fXb+bPuc+EexqFVI5Sz
         hwZw6QlhBjagGm8Y9GLRvN0Du08viqYgk67qTBnh77U7x9F7RAxQnIOFnPEayFDeAQar
         3bT5EDx7uoxFXYhrqc7e4vw9y4oUFSJmV7oImcD1R5F7mFblErAUbonAxp/4onHTujle
         RpvQEk6fSakK2HJSOWfBcr/6BsCLYYwN9y1zO4J52phZtmYNgBzrrOLT3Ja0rzGryFYm
         DfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744640028; x=1745244828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5yCWkL2WDN1lvZZXaXOpa4x+vmtWrwc1PsatHE9CvEw=;
        b=dmcMNQLXPVj/qrKa4HFOtNqtIp3xHUEkrYlcn9DTi1KA4Bz6t1oDaMscvxq/Hg8lz5
         nzyQUS7d7E8T8l+J7H4OXZCG0m5VWQdGIhY2mvRHjotsuKKORZoQtk+ZjY3JiWb1L1SO
         pP2+/JNYTXRyFlNVS8AcAUP9+f2kYKCBY+GUDW4+aB+H79WZ/RXv2bN7/W7GmQxEvo22
         BYKcgOjiUDbz51gnRz/HYK2/q96ji+MlrtrAucmVpOImV3S7mvrzD6tgH5Xg6FT5nsYo
         mFYsfGgkp3AK1I5Uge6W2N9K6DJHCvL9AlPPoGhtEM2pZmKrOTv1/4Xfln9P8CcVe5Ew
         ejEg==
X-Forwarded-Encrypted: i=1; AJvYcCV8RTOPr1/CFf4WUF9kAOIyisi+sLdBFFNdsFpvLY0LHxLpixF9AJ2qWSo1yGkLqiazh9DjTmvM@vger.kernel.org, AJvYcCVdDVPfkN2KZdI2Zb3C/ywzogtJtAO+oTTt6Jyv+GcsXrCUozX8IIRRsvluoyxBDnKT7XdqlRIL8x84v1hs@vger.kernel.org, AJvYcCVlPcR4cS6mNcFpBY+toRb1p2pG4oE3YhsXyY844CLMYqKpAAitZDiqOlXxTSh4mWnCEvHObXVutZo3@vger.kernel.org, AJvYcCXlvm/toHTiMKm7SefouNkqVC92Ih99ir+PInYgie49g6TJZO20DIPL8q/i7DSLjYKv1rZd7PXAzXBMD05qQFxP@vger.kernel.org
X-Gm-Message-State: AOJu0YzUy6egl206HdQGx4DNg7hFrk/M6/jVXMc5rcODCz2yVz3Hi7mv
	e/GLqEvVxHhr+4dgpnyrhQ8iD1cAlMipCbF94kkUSB0ijzS16f+RSajqdzKucG5kw4Wzra+3L45
	9+qnF/6NsNi+P1s4atgNEZpH4JRc=
X-Gm-Gg: ASbGnctKNU6q4LZD3HSU/NVsW7lZakIU0a5Qrzt4RiaWXjVUk5il9OjPAYZik7uFfo+
	x15kfKrnldxg7cqQvphJrdkOFxvEUjHsB1PaubCjAyBnDj94HAE6tVCiuyj3b786faD6Vv9FCLl
	3n4oxdYK03Uzvzxo6QFkcZJg==
X-Google-Smtp-Source: AGHT+IGdK2niE9kOGHFgz3phw2eDwIHKiIBcqYt3j2SaDWPRFCA778bk0mOPayv1vioSQfjlNmp5bZhvzgkDObcF5qg=
X-Received: by 2002:a17:907:84a:b0:ac7:ceb5:d07d with SMTP id
 a640c23a62f3a-acad34d8a43mr1173367966b.32.1744640027367; Mon, 14 Apr 2025
 07:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407172836.1009461-1-ivecera@redhat.com> <20250407172836.1009461-2-ivecera@redhat.com>
 <Z_QTzwXvxcSh53Cq@smile.fi.intel.com> <eeddcda2-efe4-4563-bb2c-70009b374486@redhat.com>
 <Z_ys4Lo46KusTBIj@smile.fi.intel.com> <f3fc9556-60ba-48c0-95f2-4c030e5c309e@redhat.com>
 <79b9ee2f-091d-4e0f-bbe3-c56cf02c3532@redhat.com> <b54e4da8-20a5-4464-a4b7-f4d8f70af989@redhat.com>
 <CAHp75Ve2KwOEdd=6stm0VXPmuMG-ZRzp8o5PT_db_LYxStqEzg@mail.gmail.com>
In-Reply-To: <CAHp75Ve2KwOEdd=6stm0VXPmuMG-ZRzp8o5PT_db_LYxStqEzg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 Apr 2025 17:13:10 +0300
X-Gm-Features: ATxdqUFd1BVDkakdZ1-2ODqFPD3YDHM5A6s2w5TBHFylqqfB6-UoXfU_t2qH6C8
Message-ID: <CAHp75Vc0p-dehdjyt9cDm6m72kGq5v5xW8=YRk27KNs5g-qgTw@mail.gmail.com>
Subject: Re: [PATCH 01/28] mfd: Add Microchip ZL3073x support
To: Ivan Vecera <ivecera@redhat.com>
Cc: Andy Shevchenko <andy@kernel.org>, netdev@vger.kernel.org, 
	Michal Schmidt <mschmidt@redhat.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Lee Jones <lee@kernel.org>, 
	Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 5:10=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Apr 14, 2025 at 5:07=E2=80=AFPM Ivan Vecera <ivecera@redhat.com> =
wrote:
> > On 14. 04. 25 1:52 odp., Ivan Vecera wrote:
>
> ...
>
> > Long story short, I have to move virtual range outside real address
> > range and apply this offset in the driver code.
> >
> > Is this correct?
>
> Bingo!
>
> And for the offsets, you form them as "page number * page offset +
> offset inside the page".

Note, for easier reference you may still map page 0 to the virtual
space, but make sure that page 0 (or main page) is available outside
of the ranges, or i.o.w. ranges do not overlap the main page, even if
they include page 0.



--=20
With Best Regards,
Andy Shevchenko

