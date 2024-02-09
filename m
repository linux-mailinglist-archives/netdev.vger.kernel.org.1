Return-Path: <netdev+bounces-70516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9352A84F5B3
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 14:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F28E3B21849
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 13:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E5F381A4;
	Fri,  9 Feb 2024 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xY5/bG73"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774E32E652
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707484794; cv=none; b=AeQTJ9V/eVP5ZkGdYrJ7mDpC/DPyqLndwNlWOFMw7QJCcAC2SbKupjRGNQe9QfKBxX192yuIl2X7v/FQF54zMum2dNUHPZVsPiP+egjc85yvvP0Xam41hcG5QjAzzKu1PsfLq22yrTUGPDlqZMbQj3JIcoJT5PcOz2rAxIVuVK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707484794; c=relaxed/simple;
	bh=F4LZ8gfETFzZf1TBA891lOohxfg7EKDpdAxY49mJJsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COTI6T8fcBMumzEvsMtfubG2AznpoD2z092HLhb41v1i4V1oETXiKAnsHo9YFqENfCWD/AIBnVohVLv3YQRguah/fwrtuR5kfID/GbLoGC48iB7mQF2JmI/T+f6Oyg4lV5l8STlEHdVVDTGIVzowDKP1oN6WdW3gdZ3WYBuYExU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xY5/bG73; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6047a616bfeso9151247b3.3
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 05:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707484792; x=1708089592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4LZ8gfETFzZf1TBA891lOohxfg7EKDpdAxY49mJJsU=;
        b=xY5/bG73SgDoG+PY1vYw5JgAk9YRD52PjXbV2EF3DuBGUTFV+sJq6XFg+F7kre2EyM
         FqcQhFxrOkCdewhOOZt7HXB5kT683ioqbaZpDB/h/IAw0SYuI1yLelH7s6D8frYvzMNi
         snpyhBXA+I5UuQRxQm7MEjERyjVVcLrfVM2dGP7LbxCe3yTfilwfXV2IpoZV8D2yB8wp
         SDsztD6K42hOETD/MQmf7CI1LIaWa11mLJVsoBrcwKfPjOmQkHMTpsedLOEnw0dPCTcG
         ppo80svcJbxH16hE00iHgx4VZTYqcmpu9r0sXj/VNl0ArQlN5kAINDm5Cg8mM7O+sfpp
         FEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707484792; x=1708089592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4LZ8gfETFzZf1TBA891lOohxfg7EKDpdAxY49mJJsU=;
        b=rkycXmM4HzkowsykSeQ7G7Y/stahGExtGdJe5vXOWs0x5x7IwG4K498tFfxfIMpUeN
         UD6QenhwHibcOvivkprUMwnkqB1MeBhH37/WCgBReHqyS4EFO0TPdw/NXT29qrckGZ2Y
         BAjhZcmyn4HxJwQOCJeWDZTS31RNxF4F7Ow3M4CTQhW+A+kTuAPULuS0JAakbYY/Dws+
         qJeRWX6Z7FSfZJmoutqryY1/FfuwrXrue3LZCO2h5UI8CKMgfXMzJPi5RWbv1cYSVXLa
         OkSMtxkGJO7oC1VuIw4LFm+pkyXwkc9nQlC/fLwo9RxLnf7yWuc1+79kdfLNjZ1eDXxO
         tZNA==
X-Forwarded-Encrypted: i=1; AJvYcCWfkOEZqlUB0gT3VDYWk/AmhPEdvEEeBuTnElWOjMq1pHyhAX0UcVXMdqJOLgWeod0MiwTYu5CasQpSBwNTk/g9MPkyzYCp
X-Gm-Message-State: AOJu0YzIMCvRpzomX2f+5fvmKMTinJ1ixhm35S5itjr3CqpqxUOWK7J5
	lhgEUZqEkFuP826G41oVNSzBJvziCtGNTVSo7XyYi+iCFbFvM+gASzw8DOhGKRqc1RSVMenx3zE
	it2A424R/i0J7azInSR9QFVf0N51GMFmMXOz/gA==
X-Google-Smtp-Source: AGHT+IH5AfZ7f+9+QujAl52V+MgXsVLzZqGZAZnr7HEGkUhESSg7oWf6z/iqBbvwJ9J9sqo4Fiu9akNNq2ruPjwcA+g=
X-Received: by 2002:a05:690c:3405:b0:604:9cad:8c23 with SMTP id
 fn5-20020a05690c340500b006049cad8c23mr1269490ywb.11.1707484791659; Fri, 09
 Feb 2024 05:19:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com> <20240209-realtek_reverse-v6-4-0662f8cbc7b5@gmail.com>
In-Reply-To: <20240209-realtek_reverse-v6-4-0662f8cbc7b5@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 9 Feb 2024 14:19:40 +0100
Message-ID: <CACRpkdZruDba+LWUtCZY_E8vL=yxPcU1ReqVnumdzi==pw0=og@mail.gmail.com>
Subject: Re: [PATCH net-next v6 04/11] net: dsa: realtek: keep variant
 reference in realtek_priv
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 6:04=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> Instead of copying values from the variant, we can keep a reference in
> realtek_priv.
>
> This is a preliminary change for sharing code betwen interfaces. It will
> allow to move most of the probe into a common module while still allow
> code specific to each interface to read variant fields.
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

