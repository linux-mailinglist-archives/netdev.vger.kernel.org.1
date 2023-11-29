Return-Path: <netdev+bounces-51977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE177FCD10
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 03:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DEEEB210C2
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 02:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D595A29;
	Wed, 29 Nov 2023 02:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="z3Og+i3l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DF41735
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 18:47:36 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6c320a821c4so5441882b3a.2
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 18:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1701226055; x=1701830855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXCf82/z1ruojcbqnGD4qR/1vYZRBRQtlqOSPY1eXUI=;
        b=z3Og+i3lQ4xKqaJXNfonCfFToD/ejWPmVJinrWbOCOGH8PWHEcXffkB8XDQqOWieDH
         g0nt696EAIOzunLFn8EnyjJTbxoanUFeyQSf14kuuRcyn5L2EbIEEVhS4NUeQ6VWQw6U
         pslqf9qZuZJbXQVTbFJJTswYaXxF4KLmIzL7OkRfwoXlDR+nP+IkvC2BlaVQgyKsicSX
         JX2iuC99VfSewHwMf5RuI6XQtY6iySDu56qgI0ZIaBWPiMyO63a16DjRt0nwQ8HgCqrp
         c9ukug6S9g8czL9qkApFOp0mF0BgrefH8YY1uNYfWQ+tRJRK0E/syD7BK3hAH+zx8AfK
         Vs/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701226055; x=1701830855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXCf82/z1ruojcbqnGD4qR/1vYZRBRQtlqOSPY1eXUI=;
        b=hYEZtKiuLD+/Dr6V1oSzxehpnlG8DsSMfEPA0lYlJ2wjN5qqziCBga/lvPlnLkATBj
         +D74yfvv3K6hxXM86nitwGreBRufuuHbbOR7jww38Oc7bXPT+5nDz1JhlWzlPotXPdW9
         PsOKZSufQxpYF+RhyXEbsr94PNkN/K2PLEY3n/dC7mmYzAOwcARSDvqD4ebbS7f4kCKB
         FsNhpk8ie1CQ02/n87EgIufwXYIYlv4m0pyB749wvtwXhb15KAyxF+k1zU1sVS7aHxEQ
         OfM1h0VMclDgl/9IMjYxa8mgA4erb7qTQL5DsdX5Z4whXopCnm1Lp5JRHBsbIQ1hPDbt
         P8DQ==
X-Gm-Message-State: AOJu0YzC3yz7fUVRiwee9c1qlywPKRnjWaaTajZo5ZS4Pqi5M8vUKKMk
	TwJBtqkhiIXK5Jz6nYSw8Eo8pw==
X-Google-Smtp-Source: AGHT+IEYN33+oEE8z0o76kZXB011SH7F0Kfpjiz4M4bD3Um2laYdts+lJMKrC6zrZuKqwr4bR971Sw==
X-Received: by 2002:a05:6a20:3d07:b0:18c:4105:9aa8 with SMTP id y7-20020a056a203d0700b0018c41059aa8mr15342292pzi.51.1701226055436;
        Tue, 28 Nov 2023 18:47:35 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id ju12-20020a170903428c00b001bbb8d5166bsm11042697plb.123.2023.11.28.18.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 18:47:35 -0800 (PST)
Date: Tue, 28 Nov 2023 18:47:33 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: =?UTF-8?B?5L2V5pWP57qi?= <heminhong@kylinos.cn>
Cc: Petr Machata <petrm@nvidia.com>, netdev <netdev@vger.kernel.org>
Subject: Re: =?UTF-8?B?5Zue5aSNOg==?= Re: [PATCH] iproute2: prevent memory
 leak on error return
Message-ID: <20231128184733.6fc8247e@hermes.local>
In-Reply-To: <o2sj4kvm3n-o2v307ppr8@nsmail7.0.0--kylin--1>
References: <o2sj4kvm3n-o2v307ppr8@nsmail7.0.0--kylin--1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Nov 2023 10:26:37 +0800
=E4=BD=95=E6=95=8F=E7=BA=A2 <heminhong@kylinos.cn> wrote:

> Friendly ping. I think this patch was forgotten.
>=20
>=20
>=20
>=20
>=20
>=20
> ----
>=20
> =C2=A0
>=20
>=20
>=20
> =E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: [PATCH] iproute2: prevent memory =
leak on error return
> =E6=97=A5=E3=80=80=E6=9C=9F=EF=BC=9A2023-11-15 18:37
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9APetr Machata
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A=E4=BD=95=E6=95=8F=E7=BA=A2;
>=20
>=20
> heminhong writes:
>=20
> > When rtnl_statsdump_req_filter() or rtnl_dump_filter() failed to proces=
s,
> > just return will cause memory leak.
> >
> > Signed-off-by: heminhong
>=20
> Reviewed-by: Petr Machata
>=20

Please check your repo?

https://github.com/iproute2/iproute2/commit/2c3ebb2ae08a634615e56303d784ddb=
366e47f04

