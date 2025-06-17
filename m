Return-Path: <netdev+bounces-198726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EAFADD583
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 18:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F5A3AF39E
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEAF2EE608;
	Tue, 17 Jun 2025 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxxmBQgt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED692EE604;
	Tue, 17 Jun 2025 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176579; cv=none; b=IWfyfV6lfAq+2R/nKISB+WJrpBbSVYpjrlmfpHpDOPQg97W7LO5Gp9PTDP2HupI8rGOW3nA2+3nPulmkZYDEaaucf1W4kfgERbjC4UZ0RW0e5S9GV6BsarHsCcLqCqJZFjoSiQeeaA4CO5S/OVEc/f+Aj2RrPlTAMhuCsOLQeYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176579; c=relaxed/simple;
	bh=6lRf39IOFGk9vChRDzG45TvkaiHToCiDTjoqKrr0L2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HhMD8be9MEz+hhCqGsd2ujPx2LvDLX+pMacbAOGgULRlhPJRKwEmCRquddy8NCO9Y1BBWA8MbZyrV6f7fW0gFUw/RtKHohREdBRLjM+1M59uKbBxZDuOoPvX5RR6Gna68FjDJ7AvDH6YzekD8jPL7hXo4oL/esXvUyW4HJFWKKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxxmBQgt; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-553bcf41440so3176486e87.3;
        Tue, 17 Jun 2025 09:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750176574; x=1750781374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeAOa9AX6Slj4C7yIZpdSjzaS73WhA9Nhvt0jU+KKiU=;
        b=dxxmBQgtIW4CAx0AFd5S6b13yI8ClGFVrg/jbA7akwaANppmTUufCkhomRFsQ/ArwI
         iupjpubTyIjpxpUcs3AEoTtc6js/bxzaP4djSplfmfdrHkSdHBxGXPQ8hDcCD0+2A/Xh
         2EpCwx2sSEbKal8pG5aVkCt95wbgupkfX/sZVOChCoDUjhT1Q/+A7Dez+A7gzHIE1xPY
         YBAOLtXH26nHI01keZwRBpcnTYZYc6qC8E5rXUyHV+x2hvDDDGH8WUj7WjCvPIpmdfjt
         mtDxIP+1EHWGGm3rZ/hJw80vwSgNRF/vQTJ8sYT4e0ySZ0DGc/qLiFtzMWan6qJ/OIWt
         ydNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750176574; x=1750781374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeAOa9AX6Slj4C7yIZpdSjzaS73WhA9Nhvt0jU+KKiU=;
        b=CVYhEOOn6iWWibAAu+cBar0TmYbbgZytvQf58uzKKc0P3heqIQZjMIuvVBWghtxgwQ
         uMqRc1J5P+kHGO1rJlbqJ5HM0Ks8gUu8XqZsVyDIp6BgGqhv7Xz1OZ7nW4Z1sk81vCJn
         dkDtljxTxum74U0FwqebjbW1fKWY6dz4IFEuOsPgYslRePv1EVXRBzDrzVQRvTCYsgPf
         otLDcS4dC9cDuhzTNabQhnU0TSdy8FnVVL/U41kJYUzsZIf2a+W25sEvPQR7PmuioAc8
         juZCqiJwieR00DR0UE1LDMiPFl8+105deCHU4clPKvepzFSTSOzI4x7V9QXE1foOL3L7
         rb6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUH333XXxP4rKg2COmX+jfhVIe45T81WD9hIZ4HrpWm+AgqOw35A9syR+mRAoFTtqUCerZEGAtv1AeK9KfA@vger.kernel.org, AJvYcCXT5R1z9u7ny1bf0ZF2Oi9wMCDtdg02fXdqK0LZ8EHeK9EiP9fq8e68qOKl2hgeZ0IfJSOq4NKlSRoK@vger.kernel.org, AJvYcCXXnw4aztc1xc/PxwJyDO828ROvVv/HCRyvQwQ4DlfbdWwFG/+5i4gu/zqnuy+RlFvdVzzbLqCh@vger.kernel.org
X-Gm-Message-State: AOJu0YzSrVklxHXS5H7yQj2y2DkU9QAFyd0/CSBgEfPms6NkqEUUgO1P
	VQ+JSWfgI7EAy0BGA0AyKNQDp8KTh017ERLNoMzceO7k8ljHX5FcAVSI9Bx41JpCR77XqooBhe7
	6pTlNSQt1VnPV1LpfDpk/5jFHl3pViZw=
X-Gm-Gg: ASbGncuwg+YZYDBBVHn4RUBIrHnDkDN47F3KqGY8sKkvB0qhccL4vNMR+35i1a5IJOE
	yrnAeHYVwvYeIfEYitKhO+qfhC/5ueRyZPqFGA3axek0WQf9wuvAe8a6YB7abV+HwKDt0nazNLh
	JX6NkuN+VPdAsKqgvx16zOxZVV2rl3wTZgTqIFqpgmqmeiMrTXadpjd2t7
X-Google-Smtp-Source: AGHT+IFKnarzu3vsVViFufKxgE6x2pOd5ugUq1TG2ycTridBUmhnjKV+d/pUZBbN2A7kGXCymCs76fD4YU1LGW/OB1g=
X-Received: by 2002:a05:6512:39cc:b0:553:3770:c912 with SMTP id
 2adb3069b0e04-553b6f42a3fmr3675159e87.47.1750176573453; Tue, 17 Jun 2025
 09:09:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616184820.1997098-1-Frank.Li@nxp.com>
In-Reply-To: <20250616184820.1997098-1-Frank.Li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 17 Jun 2025 13:09:21 -0300
X-Gm-Features: AX0GCFuXOdeJJidoSYPc7Vhn4DpNd-OEuHgzSb7KUMF9M9ColJNBmTcaRq2M4-8
Message-ID: <CAOMZO5DwJ9bk26TBU46_fU0ydwQL__dxUoOULuKyZYWRdbJ0YQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] dt-bindings: net: convert qca,qca7000.txt yaml format
To: Frank Li <Frank.Li@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stefan Wahren <wahrenst@gmx.net>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 3:48=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:

> +examples:
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        ethernet@0 {
> +            compatible =3D "qca,qca7000";
> +            reg =3D <0x0>;
> +            interrupt-parent =3D <&gpio3>;      /* GPIO Bank 3 */
> +            interrupts =3D <25 0x1>;            /* Index: 25, rising edg=
e */
> +            spi-cpha;                         /* SPI mode: CPHA=3D1 */
> +            spi-cpol;                         /* SPI mode: CPOL=3D1 */
> +            spi-max-frequency =3D <8000000>;    /* freq: 8 MHz */

All of these comments are obvious and don't bring any new information.

I recommend dropping all of them.

