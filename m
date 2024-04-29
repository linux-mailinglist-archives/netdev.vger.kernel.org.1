Return-Path: <netdev+bounces-92253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E118B63E7
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 22:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B91C1F220E0
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 20:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6902A1779B7;
	Mon, 29 Apr 2024 20:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKNMTFb0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B678A1E886;
	Mon, 29 Apr 2024 20:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714424269; cv=none; b=c02YlnM7ps2lKursE80d0/EG/BKkBIM82GNxyn0vgW5n4huhS350ZT8gNg50NTkV6scSM2YR2J4mUkjbgDCqoJ/x9PnoKBvev1e/g94D7YT2JhmdB6PMFo1RCkP2sV01hYtzAkb+p1VIzIrOije1Rw8B5WbihI24nIXArHsbvss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714424269; c=relaxed/simple;
	bh=dJtsrE2v3jaKw5VkxelZkA6Wz54/g/h4cLRiepnTIdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CAZd9Km7GMXRryrcC+WRkR/otFbSz/PRBAIUjJBcqBR4kxCkAzBJ2ugISa3XP9eP/2XxN0d4V0O+dAj/wq1A0jzOSWbYLnOCV5GlKir4XOUEtpI+a22Bf52U2YgrKQYU3kacfUBzRcR2/3wBP2yFGfUxU4UsPuP+IdofSINBftA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKNMTFb0; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2dfb4ea2bbfso29649101fa.2;
        Mon, 29 Apr 2024 13:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714424266; x=1715029066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJtsrE2v3jaKw5VkxelZkA6Wz54/g/h4cLRiepnTIdE=;
        b=BKNMTFb0NgSBYXh7DYem/OV783M/6eEuYf5w2EZz9wXDS84BuOfbTI+6lST8n2WSb/
         Nj0n/UFH7yMFqbsJtZicgCPhOW2H/AXFf6Vuv7S/gLbKCfxNnLT/sabb4LqJN2270S3o
         GUyDRO6DAhKy+0ZUB5JX2dzn8fj4IByjY6M+wMkd6/iTVIJR/2tHpT5yoOtFfq9cYGOd
         69ISsuLuNIlGvgOZtMiK27EQZIIDZjzCuVpqOFI0citvUIOGTGP4LHlVe2ul+BIyBpQx
         qNTyDCqdC/zT29kizyqBZnZaS/rz87jB6pbaOwM+Qcig/lQc9vgR+guofbUgG6Fupgqn
         k90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714424266; x=1715029066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJtsrE2v3jaKw5VkxelZkA6Wz54/g/h4cLRiepnTIdE=;
        b=XaUhjeob572QiiuYubK8adWRMV4fxg2Y38vSAB2yzU/5fEbZ3X1gVtf9FwhHCUkkCZ
         kDHastA9KPqWIvkM2M/XM1OraMv/rY/V8L9fjGQHkPEP3/ALjoDu+tH5wX4BlzN6EZFy
         czj1N3hc0Eq/hZGEkqHUuziWsUOO48w7Y4CYnqKyddvzhPUaoKB4k2COLWz+afe7HbTz
         g+DML3GFmf69mphKwNfeX5tkIfVERJ4rDtISnAw7iIGkRaXrlrLFb+TI1fvuVsUq/75B
         8OyylawtKOstl47X1BXJ62S/CTIddF26gqTWC7OPq6Q8ocwaGG0CnD89ZDmuSucsbxNv
         S6mA==
X-Forwarded-Encrypted: i=1; AJvYcCU/IQi4gazsQ4XF9mY/M31E3tBpPQU95Gw+q8kBsnIN+UEpaoqmQ09mLWCOOZX7RudmxacWOIE+chsElLeiBwUt5mvoYrs/zPS8P4uOiz8eKIZJ3ocCQj9nDYalGHs8Qk6bFq6bRIDEb+IYi5txdiy1Xc/gdQeEdIOVf6hSVSquyRo7Iw==
X-Gm-Message-State: AOJu0Ywi5nxlG7o3m9SXh4IONXCAgX7eFrxiWeo4rMd/A9sSJLAJ7z4+
	1PYQ6CyVAMGqpKRe2orv6ZjZq4bLT17kqJO6pK2O5F9Spjam4pGWomd2g2K4eBKryWxigXuQHbM
	fdqdzSvP4ABW+s5pKC4jfq5rStg8=
X-Google-Smtp-Source: AGHT+IGQJk2euqsn10YsIrACnj0l2e7c2HREXcW0k86OgPB1dFwqNRU0nLUxm8tatoL1HdNT8yu2SUbnyyzcwIm+48E=
X-Received: by 2002:a2e:928a:0:b0:2d9:eb66:6d39 with SMTP id
 d10-20020a2e928a000000b002d9eb666d39mr6832573ljh.19.1714424265554; Mon, 29
 Apr 2024 13:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319042058.133885-1-marex@denx.de> <97eeb05d-9fb4-4c78-8d7b-610629ed76b3@linaro.org>
 <93eeb045-b2a3-41d7-a3f2-1df89c588bfd@denx.de> <793d016d-2bde-407a-8300-f42182431eb1@linaro.org>
 <c21823f2-4dd7-490a-8b76-7cab422428ba@denx.de>
In-Reply-To: <c21823f2-4dd7-490a-8b76-7cab422428ba@denx.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 29 Apr 2024 16:57:33 -0400
Message-ID: <CABBYNZJk33ZcKc9EPi+Hmqb-pq3vSSzB3wkS4nJ45dxG6dBMUw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: net: broadcom-bluetooth: Add CYW43439 DT binding
To: Marek Vasut <marex@denx.de>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-bluetooth@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, 
	Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marek,

On Mon, Apr 29, 2024 at 4:44=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 4/29/24 8:22 PM, Krzysztof Kozlowski wrote:
> > On 29/04/2024 17:10, Marek Vasut wrote:
> >> On 3/19/24 6:41 AM, Krzysztof Kozlowski wrote:
> >>> On 19/03/2024 05:20, Marek Vasut wrote:
> >>>> CYW43439 is a Wi-Fi + Bluetooth combo device from Infineon.
> >>>> The Bluetooth part is capable of Bluetooth 5.2 BR/EDR/LE .
> >>>> This chip is present e.g. on muRata 1YN module.
> >>>>
> >>>> Extend the binding with its DT compatible using fallback
> >>>> compatible string to "brcm,bcm4329-bt" which seems to be
> >>>> the oldest compatible device. This should also prevent the
> >>>> growth of compatible string tables in drivers. The existing
> >>>> block of compatible strings is retained.
> >>>>
> >>>> Signed-off-by: Marek Vasut <marex@denx.de>
> >>>
> >>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> Is there any action necessary from me to get this applied ?
> >
> > I recommend resending with proper PATCH prefix matching net-next
> > expectations.
>
> I don't think bluetooth is net-next , it has its own ML and its own
> 'Bluetooth:' subject prefix. Its patchwork.k.o project also doesn't seem
> to contain many patches with 'net'/'net-next' prefix. Also DT bindings
> do not seem to use it per 'git log
> Documentation/devicetree/bindings/net/bluetooth/'. But the bot is
> complaining about the prefix. Hence my confusion.

Well usually we require Bluetooth: prefix to indicate this patch is
for bluetooth/bluetooth-next trees, or you can do via subject e.g.
[bluetooth-next v1...] otherwise it could be merged via other trees.

--=20
Luiz Augusto von Dentz

