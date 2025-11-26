Return-Path: <netdev+bounces-242076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A18C8C146
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 22:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D5DF934A7A7
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 21:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1623195E6;
	Wed, 26 Nov 2025 21:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gg81uigJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900B02E6CA0
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764193569; cv=none; b=ILm6KCpS2SdIlbmX0gzPu8SOEkZOgpSFcEmNyQkFcynRJ32O/y62xANA1+PltaPOBkFHycH7pn3heQC1JT4q2z9ELw7DeNbx0nd1R+9QR4C22awG3x3dDJJwAQCySfhMdN2sfC2+8MRTzuAw/47mwGQdpya0L+UK0BbZ2hvqWOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764193569; c=relaxed/simple;
	bh=eHQD5ZWYTKJ5pBQ2l+KQFGoT1AEPijvyxf4X4cwZ+8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDRIgFaQIKgyO0/4uq/dP66r4vHN8rn2GApnRJgdLV23OqJIEgCtYgpDE5D1cRPPsZ0BmC8HZ3mJrPOh1ScQham4Hkd4N9qIVtqjEYSRhcuyJ5H/zoZdufVgbdsjmtqIWj8pCZgo+5ADbLtDI9olNpVP8Ub6fEwVt11eBNRFD/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gg81uigJ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b735b89501fso31603666b.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 13:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764193565; x=1764798365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DR4A76Dv8qf/+6WmZVEh6koqxlO2WxAmz56oNgGMFDY=;
        b=gg81uigJukUZgFx4FvmiB0bv6phOBtZXCOc1OZOI1Sw0Kyh17cNG6dSYyM4q9oexY3
         jb5DUOq1AuaiPZCkee2vJIKTQqW9bS1sTI1T0eVshE87LRyjmyKR1yLFvP3ESy2pFnTe
         tCnKqBnmXCSj3OqG75M1AGnWdkLsBIkhg3EIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764193565; x=1764798365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DR4A76Dv8qf/+6WmZVEh6koqxlO2WxAmz56oNgGMFDY=;
        b=IVWfPACqERQ5MUndUIkNNmj17e9w6wD1OBYqMDWKAY4Kopz/4ka5gV7SOm1wAK+9oM
         iizTPDVa5GkwimyYFaaKtH/HeRWG7dQYpXXqOriZZDHvcoVb91tX1a85S19pHhnSdl34
         EOlH6YIKyBLbFxH1jxtGwvRLCAqx8Ew+I5DvBQ0YvnXOjIPNZz3N3GuM/p689m4wcR0t
         DI89QUCi1w5bllDqeZe3Rg4flY/iiLpCRfvfDv6gek958JcaBsIPZGFuAXYaFXxoAhYP
         5SGefjFIO2vQroXyy7D+88f3wEWd2x/CHY9yppeBV07vA9I42oGP7KstGi/Ps4jV2HUg
         b0Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWxYoOP4/6/VMVe1xyZSUYHQSG1oKNcwIeEkOVxozcnb9gNMCm6O7vfAtjuYqC1BaFHvdnWAJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV+W/jOTYVRLzF3anU5V9Y7LKzsA+KPee53jAy2ERF0M4rz87l
	+DsoBzxC2sfWzsAfyG5t0JUKq6TFJNfwEHf61/L1fduQgYvhouBq36YxMO6nTeEefsP24G+us6y
	vzKYizOvcPA==
X-Gm-Gg: ASbGnct843gLI320+q3AED8SX51LwrMK7JfSNDAGKvgm/waUkvUdQc6ceVTzehyuLHU
	rgjVIZjpcocQQqizxYYm3KNoxGOPx4/fmel7a4mXqjAna3vKrWY6DWcZb9cbsXHi1efMEB1PUfW
	QamgMlGHUy8EoNr27JhNDmtUHP6pjrzTQRISlvwYDXaxfEPI3Y8BoAjSL2RZpK4GFh7ExYpU1aa
	440noB48WR6zMOBYaCOSmRL9I9ME9iLoxbwVRiE4rdfFOE1FWWYCiGMvrr3l9ZsIHIJ3LfdLjKv
	GKrke8lpzKOLvTdz4zA9Pg0n3hV/0MTdlKdNdR2YQxSnXtcRbjwOpWdz7YXGycqx9XhBUV0T8AL
	6PTdcKCio97gXMgVjA76/1EUVtW2od4Msd8XauubKA+D8Ugno7fPdyn/rILxZwsZ1Vv9RoFG7gU
	sLUIFa7LMHsqdPgSqwZKG+sefhkPSge3U7ogTR8DfVaF2RiXoly/ViCY4Nhk89
X-Google-Smtp-Source: AGHT+IElwbqdcgpfXr8y6erfJDj+54wa5Y5n7pHkA2yeeXxMXnbJo4nn0XPKIAsZjltb8sH1axuQ3w==
X-Received: by 2002:a17:907:7fa2:b0:b70:b3cb:3b30 with SMTP id a640c23a62f3a-b76c5595bb8mr870486566b.59.1764193564920;
        Wed, 26 Nov 2025 13:46:04 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cdd60csm1989894566b.3.2025.11.26.13.46.02
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 13:46:02 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64312565c10so445437a12.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 13:46:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbLkDl/myIv8uHFc5W93qSpyJ6JJiwnO+d0yGws9fypOZIH2YbjafcR980C2ablqZk0MrjpXI=@vger.kernel.org
X-Received: by 2002:a05:6402:13cb:b0:640:c454:e8 with SMTP id
 4fb4d7f45d1cf-645eb2b7f7emr8102794a12.30.1764193562184; Wed, 26 Nov 2025
 13:46:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113005529.2494066-1-jon@nutanix.com> <CACGkMEtQZ3M-sERT2P8WV=82BuXCbBHeJX+zgxx+9X7OUTqi4g@mail.gmail.com>
 <E1226897-C6D1-439C-AB3B-012F8C4A72DF@nutanix.com> <CACGkMEuPK4=Tf3x-k0ZHY1rqL=2rg60-qdON8UJmQZTqpUryTQ@mail.gmail.com>
 <A0AFD371-1FA3-48F7-A259-6503A6F052E5@nutanix.com> <CACGkMEvD16y2rt+cXupZ-aEcPZ=nvU7+xYSYBkUj7tH=ER3f-A@mail.gmail.com>
 <121ABD73-9400-4657-997C-6AEA578864C5@nutanix.com> <CACGkMEtk7veKToaJO9rwo7UeJkN+reaoG9_XcPG-dKAho1dV+A@mail.gmail.com>
 <61102cff-bb35-4fe4-af61-9fc31e3c65e0@app.fastmail.com> <02B0FDF1-41D4-4A7D-A57E-089D2B69CEF2@nutanix.com>
 <32530984-cbaa-49e8-9c1e-34f04271538d@app.fastmail.com> <0D4EA459-C3E5-4557-97EB-17ABB4F817E5@nutanix.com>
In-Reply-To: <0D4EA459-C3E5-4557-97EB-17ABB4F817E5@nutanix.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Nov 2025 13:45:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiEg3yO5znyPD+soCkVi_emP=wHrRZk2sv4VS768S3a2g@mail.gmail.com>
X-Gm-Features: AWmQ_bkSLlyCoqZg3bYaZu1P_V2VILWs6lgJjJBJnYgDxxhAqc51xHDCsThFNYo
Message-ID: <CAHk-=wiEg3yO5znyPD+soCkVi_emP=wHrRZk2sv4VS768S3a2g@mail.gmail.com>
Subject: Re: [PATCH net-next] vhost: use "checked" versions of get_user() and put_user()
To: Jon Kohler <jon@nutanix.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jason Wang <jasowang@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Netdev <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Sean Christopherson <seanjc@google.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Drew Fustini <fustini@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Nov 2025 at 13:43, Jon Kohler <jon@nutanix.com> wrote:
>
> Linus mentioned he might get into the mix and do a bulk
> change and kill the whole thing once and for all, so I=E2=80=99m
> simply trying to help knock an incremental amount of work
> off the pile in advance of that (and reap some performance
> benefits at the same time, at least on the x86 side).

So I'm definitely going to do some bulk conversion at some point, but
honestly, I'll be a lot happier if most users already self-converted
before that, and I only end up doing a "convert unmaintained old code
that nobody really cares about".

                  Linus

