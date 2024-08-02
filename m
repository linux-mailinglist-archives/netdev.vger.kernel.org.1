Return-Path: <netdev+bounces-115416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ED79464C6
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 23:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F541C21766
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 21:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D52F50284;
	Fri,  2 Aug 2024 21:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MjV1T+oM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90FC6FE21
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 21:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632631; cv=none; b=KpcimRHUWt231dPgomoT3rSM1AFVJ0Gg44LQZLbLyZGS3Ap4UFf0AV8bxpvfNshm8gf87+cXjuyO90IKVnhBeBb3GAV70jaVze3N3WmOCUqpV9eN7wi8dBCRkI9dfF7by6tQ4X7COd8WWUdtNHtP+XSS4WHz/dgK1HebtOScBN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632631; c=relaxed/simple;
	bh=g1ws3w0Di7lti2/42seyLnX7XSXs8Ks2FzqDuuO8k38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqaLemGwhhrmSygZbioQx4C27w4ciNlQDsxLuoTQEcga2dYTPWn/SanROCdKgJ5q/i8r5nr6FHstXcXDmF0e+rACuCxU+nBeYcPwEOG2eUe9a9KZByf0If9EHos2KDp72X1kxEhZSG7qn2WPTv3cDbKxTCSFGQpazWoLuACFzwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MjV1T+oM; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52efa16aad9so12168104e87.0
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 14:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722632628; x=1723237428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1ws3w0Di7lti2/42seyLnX7XSXs8Ks2FzqDuuO8k38=;
        b=MjV1T+oMoV9Qt7M5/CV5/4n2519teLLJy1w1NUvcr2IiKC7EhPTCxYJarh5eKpr16s
         dg3Ed1C0zdgLKgmmCQkBJmtPZ3xawpt678/K8vLZnX1fNWhsohPn15qCpHMNBPbeDYp2
         B49Ga0x/mmN/Bb4+tyyzpT6EisRNvN7EJXsy7LoY5HN7PQpfUMT2ixqDS9g8RKXM5Zfl
         8QlzMgf1iZ2QL5yFfpbn3sWQUUDhXQ5Q/jhi7McF3J+m1RQtYB6j0HPc0UZOLy2r9skV
         Vn+2miHFDjLbC4xNsPzP5bnJlFpZYLwwmsguu6OowImwhCFj2XzftzxfI5+y3dIEVSK5
         RniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722632628; x=1723237428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1ws3w0Di7lti2/42seyLnX7XSXs8Ks2FzqDuuO8k38=;
        b=fQfcqKK5gLkHh/AMmI5qkgmaMW23eGfb/IS85KO+WyXFo5excuGNpzzQS+5sKK/lXV
         lc+8Ab3LpeZM69tMoT/eLmuCXE/iVIiwg2eKGO2oAzmpJ7vjLMHA0kSucpADgKlJjYIm
         VpY6KUcAzNe4dTt3tfn1BHubpnVsepHVMtAGqVwrUhx2OqNj3KyeocqyoiVFu43FEu/R
         RWkFuAvuxXyvEyzNTVS1CuK2y1/RRXbNSKzE7giJJ3DQ5LcW71yG+R50HKI1EFoqCSAr
         pXfm7rZX3OfSBHx6CQNIHkjhikHuB+0a/QV91gXP8iWo9ws/+a16e79YVvnkMEaG91Y8
         zNlw==
X-Gm-Message-State: AOJu0YzOh0Rr6Ookz371igDZuYqSxQNOLOo3kqjIx/6D0+6OrQwvY5fp
	nbLmu55+7TMM9Lvv37SbOwA/f2sZLYLtzJXB75KZrHxi+GBEJ+cuU5lv7KEDkzLVrrLIcV4hapo
	Cpl261srZF7Wf88PepILGsPQR+ixqxG6lvjE8Rg==
X-Google-Smtp-Source: AGHT+IGztMKIab+OCtyYIDvqYN9zD2lQOuwu5TzL9SNqwpSjGGgswmMvrF8iAI1ubdL7WKIhRWvdTbe4djnOay1B/S0=
X-Received: by 2002:ac2:4c47:0:b0:52e:f950:31f5 with SMTP id
 2adb3069b0e04-530bb36bd23mr3034748e87.18.1722632627773; Fri, 02 Aug 2024
 14:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802080403.739509-1-paweldembicki@gmail.com> <20240802080403.739509-4-paweldembicki@gmail.com>
In-Reply-To: <20240802080403.739509-4-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Aug 2024 23:03:36 +0200
Message-ID: <CACRpkdY+TwqXfAXfL6HKrAAVpYOv_BqaGdc_QrqFPGoscRnkng@mail.gmail.com>
Subject: Re: [PATCH net 3/6] net: dsa: vsc73xx: use defined values in phy operations
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 10:04=E2=80=AFAM Pawel Dembicki <paweldembicki@gmail=
.com> wrote:

> This commit changes magic numbers in phy operations.
> Some shifted registers was replaced with bitfield macros.
>
> No functional changes done.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

