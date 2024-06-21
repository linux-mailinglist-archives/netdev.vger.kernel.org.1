Return-Path: <netdev+bounces-105744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC2191292E
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 17:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0A11F28622
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 15:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57CA5028C;
	Fri, 21 Jun 2024 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ic7wPMZ/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B894AEF2
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718982886; cv=none; b=jNgLBpUg0QaVLZMSgWiV5KWDnQiDEC3sGsKs35KzAuZOeLR9MXyOx87I4wKomFxBhdce49o/0WqrBardbSZYO+QXaI6qrDgOrzp7aqgY4HYPMnROgyGjUU+ZHMbkvdJaiwNhQ5w/IzehMXBX835xpsgqeuc838ygqf3BR70Fe2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718982886; c=relaxed/simple;
	bh=vZRxA8bnfYTODng04m9qKpseMvACrDXcphQt7b8AEzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iY/GKlfKti1zJ5Tf94OmmVDY85sUkXLglLPZolWykXzTGRr2xaV89nzUicmm5cPdhEH5god80WNynRy8NxCt5F9mRy2HXOON4USEfeBEQdaz4qfUXTNXxWGZeM/m03Mi0/z9/GdCrDv8GyfuUBKVuPivW5W0RsNulv1CvDktO1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ic7wPMZ/; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b9778bb7c8so1039894eaf.3
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718982884; x=1719587684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZRxA8bnfYTODng04m9qKpseMvACrDXcphQt7b8AEzU=;
        b=ic7wPMZ/kusm4r8U5i4sIy/sKFZC4qni0Vy3KdS7p5xEYB6dipQhYu8xffTsl+xH9b
         37grGYVWl5WpV5vqpSzO7M+4mZB0b31ljX9zlnTS6wOQ/RlNdUvxQJ1Zpl87JIuZDu5s
         8CAOGnyUZgXD8uixbaYMIALsOAikR6kr8ldPvDRKMwnUtYl3i4Ahx7Pog3sDXOHp4FZs
         HCUJgfrdTljyQbCp5ZKJnsW57jeCFICpzZ6w3zrQIzkndZqXBN2P8VeP8CIm9qOt2G6v
         ibgpR8ysF47nizaJrQ6nD+rx49/A/njKjC6UkbZWerXrCSM+CRNdVWrHJt9ZgTZIfg8H
         IVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718982884; x=1719587684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZRxA8bnfYTODng04m9qKpseMvACrDXcphQt7b8AEzU=;
        b=jUZPlX6FDMdXZhYBoq1dFR1QZ+jGULln7VkznZogJVSMtF43t9b4b7g/T1370w3Xd3
         X0VeVc0Pw58pVAebukN6DP6WVPeVhBHT0j+KW1tjzZX4r1rKBrn3rHYcTJK8R7EonO7Z
         WiJohGWPlcwUaPBL8m5265dBZFpf8CaYInzsrpZdxCwudAtbZiTWyiiseR2V0d5EF74U
         hsvAPUad1S+uigrOKhuN7uaXDXFaf9aIJJ/BND5G5d5Ib9vGlcW7PkfOR/NT/yWhx5Hu
         lPnt72llkTf+24WXyuZoaawwjkILoQKmqtkd8MTAV8uagGSV6GHAvkd26i2JQ882CDay
         tfxw==
X-Forwarded-Encrypted: i=1; AJvYcCV2sIOF7XR+LfrfkDdx732unvuwhvjhsCDVY+/dypL7n9OK06ve94V3UIvvL2dqwCIwsirvKGyZBiyrx72znXzGcX6Y11SZ
X-Gm-Message-State: AOJu0Yy80Asin9tskEIHhstyGH5ijjkQxoBPu5z5E7I2M05wfERkj7fR
	993FdxPLyuqS49N0CnAalaaaUPL4kfi66EUjmPgCM5DD14qGQC7F/jBYMBtfrLBJilQxNQ02/sv
	932mAwbiBSSAeh+8ArP9BOwvkGMbVNrzs
X-Google-Smtp-Source: AGHT+IErmt7wwSoJq+N32SwWTm/evw21O7ZBlJXzt0xH7SifharvEDQEk9b36N3sP5DOcLWdyWf7Dsly55hPjnEVUAU=
X-Received: by 2002:a05:6870:c18b:b0:24f:c9e3:b76f with SMTP id
 586e51a60fabf-25c94a06520mr9347090fac.19.1718982884496; Fri, 21 Jun 2024
 08:14:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621161543.42617bef@kmaincent-XPS-13-7390>
In-Reply-To: <20240621161543.42617bef@kmaincent-XPS-13-7390>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Fri, 21 Jun 2024 16:14:33 +0100
Message-ID: <CAD4GDZykNOn1JnbbsnN6Lm=r=4Vwg6E8CAKg+VCPoCwhgoC3TA@mail.gmail.com>
Subject: Re: Netlink specs, help dealing with nested array
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Jun 2024 at 15:15, Kory Maincent <kory.maincent@bootlin.com> wro=
te:
>
> Hello Jakub, Donald or other ynl experts,
>
> I have an issue dealing with a nested array.
>
> Here is my current netlink spec and ethtool patches:
> https://termbin.com/gbyx

The yaml spec looks okay to me.

> https://termbin.com/b325

Have a look at ctrl_fill_info in net/netlink/genetlink.c for an
example nested array.

https://elixir.bootlin.com/linux/latest/source/net/netlink/genetlink.c#L124=
7

I think what you need is to move this outside the loop:

nla_nest_start(skb, ETHTOOL_A_C33_PSE_PW_LIMIT_RANGES);

and add nla_nest_start(skb, index) inside the loop.

> Here is the error I got:
> https://termbin.com/c7b1
>
> I am trying to investigate what goes wrong with ynl but I still don't kno=
w.
> If someone have an idea of what is going wrong with ynl or my specs it wo=
uld be
> lovely!
>
> Regards,
> --
> K=C3=B6ry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com

