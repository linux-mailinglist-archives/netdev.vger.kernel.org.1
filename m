Return-Path: <netdev+bounces-179434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71F5A7C9F3
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 17:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D137A7A62
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 15:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BCF85260;
	Sat,  5 Apr 2025 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Z6Ga4AML"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B047404E
	for <netdev@vger.kernel.org>; Sat,  5 Apr 2025 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743867280; cv=none; b=k5Uh4FSXsIKgWLo5CUTo+HMXp9KNDeeNN9QPteft7kYtRe3TAN6PQiwirBu76agJhnf+gf6GtAhiAwKVA/LvdgGvAfSmf2HFTk1ST54Vb8fLx6wLKwW4RV2JHzD1zrT5dT7ANiYN6O+8OH4Qy0YDrQ71UeyBAtl0fW2vYAVfoDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743867280; c=relaxed/simple;
	bh=dhg0s+Tdxt0Yh/GYXSr6JRcjMAkmHu2c5yWv9Ek5S4c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sr3mJOOiILwv90YkAuxPztTr5rSAARCxJ9oBnG8Ty5PPeG4SWEHfyI38jzS/EU5TmHz2Z41NIblIQpo+Ytfee6dtGz1ejAuW6andPadyeSIKiimC5emFzh8aygSAjBj1w6aznFodhn1EVCKiNmtC139gEzKUapEBGdsauoRdfJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Z6Ga4AML; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff784dc055so2610222a91.1
        for <netdev@vger.kernel.org>; Sat, 05 Apr 2025 08:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743867277; x=1744472077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8eigrRGHoZoaYacdnXkJxiXpQ3oRUsVusC+XuAzhcI=;
        b=Z6Ga4AMLG2lD1muZXH+j7pJ9t2BeBAf+gmiB1mw1C6kY1UWAcLTVgVY5nhCuwmgBlb
         /ZdSuZTOAb2CPJF5xv8a6E3fdgYXThU3DwF9laskVSJe3zDMQ5IX12h8pnzX3sGVaIzE
         ktVi3XM3D1BXT2SC4ro1RqpFPonofYp9Ltn9NFPtU7uYrsJ7mwj4F1ZZxkzfrTaM6Bvq
         kC3/YqV+pmmTLuhr34/NCog55GShv36R7MsTjOS9Ja/mK2nueCvDFJChwCnbAwp+JoiY
         Y+nuZgsgpgUS+aMgb2NeeWu44mul2N3g6mbF4zUebY+kBrgwuXf7wo7iwJTBxRnuB8Hy
         Is7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743867277; x=1744472077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8eigrRGHoZoaYacdnXkJxiXpQ3oRUsVusC+XuAzhcI=;
        b=ZYhPcL4763uaghl+vOQw2CYulZQM78Gjg9n45e02SuWiAgMyZFMi1hv56MogDxMq6I
         9IYCB7tHwcQRLu5omBthxiphH1R4s2yLkx/ZV77Ob27aBugcHYtaUHu9bkBYAH0cON7u
         YNXfwuyC1JmCt7Jv0fwW+vplOSNRW20vTOdwuOHeVC+HJ+J0IWULf/aONl5G/dTQ9pXj
         EUt7a1O+J9Uwlz0+fbFN9vLCPvLtLMw6upJJBeBw3oTBsa5/ZrDSt62M00YDpjPIRkq/
         2EX/mKV8r6sq4UsvdO2mdHY3d+ufe+M82cLgT3dPygaxvcI23zkqpKm0PZMYrnX/UYTt
         7qBQ==
X-Gm-Message-State: AOJu0YzHIbZ+ZLqGNanY2RsKkHWMkiCtGULJfWe8iSqn9RTqxnTYmYM6
	cQifJn+FRMnN+S574Tbj3qKmf438bmkvnOvLb9jndHlGnk/squgouQgU0oGqYYU=
X-Gm-Gg: ASbGncs8QSspaZ1eZM7bYn+V+dJUvNse3QHkulMWCqMg3p3RSoDZ5PhMNAt9SntFO7X
	Ta77hPtPGrnTuMGeYLSoxQi18aszP8TrSULlfMeOKMPZpcRJFrrLkvmC1reCn0tzxiniKm4tpqX
	wg5iBNAPlcJldPDOd5p8piJhvBL/zYyeha0qccbq2ZdmoN/BmoJNZ05mgfC+ak4N/ZrDNMdSaLc
	gpO+DBqajh6uphzXXOnsI2Kl78/55D+apxzb/wQgCbXMJdafuBuZtbu34V3G3VlmTQz9W5fdpp9
	kh1c8b1YHXvzWdyubmmWA5MM9kIjXtIFbnMT2l4z6lGQcrY3CqQw9bz67ZD0Ps6emUQL7ffZgau
	FJRHwzesSigx+ZwqODQBM
X-Google-Smtp-Source: AGHT+IF1pGISQYn8g6REp9KhbqWdODmg15tXukFVlRCVjTSHD9RYrYP4y5xSdEv71qX/r6GhOC+qiw==
X-Received: by 2002:a17:90b:274b:b0:2ff:5a9d:937f with SMTP id 98e67ed59e1d1-306af789740mr4788105a91.24.1743867277527;
        Sat, 05 Apr 2025 08:34:37 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30584761e65sm5573963a91.13.2025.04.05.08.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 08:34:37 -0700 (PDT)
Date: Sat, 5 Apr 2025 08:34:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "=?UTF-8?B?5p2O5a2Q5aWl?=" <23110240084@m.fudan.edu.cn>
Cc: "netdev" <netdev@vger.kernel.org>
Subject: Re: [PATCH iproute2] nstat: Fix NULL Pointer Dereference
Message-ID: <20250405083434.1c5b329e@hermes.local>
In-Reply-To: <tencent_6D7BD943688C4B5A68509FED@qq.com>
References: <tencent_6D7BD943688C4B5A68509FED@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 5 Apr 2025 17:42:20 +0800
"=E6=9D=8E=E5=AD=90=E5=A5=A5" <23110240084@m.fudan.edu.cn> wrote:

> The vulnerability happens in load_ugly_table(), misc/nstat.c, in the late=
st version of iproute2.
> The vulnerability can be triggered by:
> 1. db is set to NULL at struct nstat_ent *db =3D NULL;
> 2. n is set to NULL at n =3D db;
> 3. NULL dereference of variable n happens at sscanf(p+1, "%llu", &n->val)=
 !=3D 1
>=20
> Subject: [PATCH] Fix Null Dereference when no entries are specified
>=20
> Signed-off-by: Ziao Li <leeziao0331@gmail.com>
> ---
> misc/nstat.c | 4 ++++
> 1 file changed, 4 insertions(+)
>=20
> diff --git a/misc/nstat.c b/misc/nstat.c
> index fce3e9c1..b2e19bde 100644
> --- a/misc/nstat.c
> +++ b/misc/nstat.c
> @@ -218,6 +218,10 @@ static void load_ugly_table(FILE *fp)
>            p =3D next;
>        }
>        n =3D db;
> +       if (n =3D=3D NULL) {
> +           fprintf(stderr, "Error: Invalid input =E2=80=93 line has ':' =
but no entries. Add values after ':'.\n");
> +           exit(-2);
> +       }
>        nread =3D getline(&buf, &buflen, fp);
>        if (nread =3D=3D -1) {
>            fprintf(stderr, "%s:%d: error parsing history file\n",
> --
> 2.34.1

Better, but your mailer is still confusing the patch.
You may have to resort to using an attachment.

Also, iproute2 uses kernel coding style and indentation is done with
tabs not spaces.

If this is all too hard for you to fix, I can just do it manually.

