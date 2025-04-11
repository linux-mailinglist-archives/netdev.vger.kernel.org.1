Return-Path: <netdev+bounces-181646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22173A85F38
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 15:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2FB63B3A6D
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 13:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD531F7098;
	Fri, 11 Apr 2025 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lX5sPk/E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428F81F76C2;
	Fri, 11 Apr 2025 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744378367; cv=none; b=CuhGj2gQDG259JNo9FxGf/tLPOooQ9AtQDXIEJBsFBcam5/3uaHzMLXVMtY67vjOy+3gAL4fsUwrV9qH6r+TfqpTIPGLniklTmycM2AW2qNYn9rRCL/nfZAFmXKhT3bRhWFbaHn05FIk/T08trAq7ykXn9DiqtgeGwCRHDMac2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744378367; c=relaxed/simple;
	bh=T8OPPQ63sB53cKU/lE9eCiUIlHMKwl45r6Cu0slEsfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gUndhmBl2Q51j+OaQTHmWGbNLGxZ06/Wpfdj8HunOfCRhjWkwxD7lrhNJ4wH5i0rSwJNpIIwp67EkJt6ZFVt8BBNyJ4SWkuEkL9R/VIK/Bsuqhl9xI1+4t+Bxx9+TTcUg74GWXWkN+cpZ7si8iA30TlCyyvP2JcnTiluMcfQyn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lX5sPk/E; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54998f865b8so1952194e87.3;
        Fri, 11 Apr 2025 06:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744378363; x=1744983163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HdsNeALPBRl7TJQey6t9d/l1PV0RD8jB7VsA4lZuNc=;
        b=lX5sPk/E/Aymyu8BjoWPougN+pmHA03vEVvFH0ErnDHVTbOJgSolBIMfJKrfA3nHpz
         MSS7R6ALlRZTWOrW1o6xfJygeNvLurkwrOXI9Oi7CrI0QnWx80T/Tx0HLNhGS5s4NxcW
         2xKnkkvBvhQdEbW8ySZUqfe5HGlQsnLtEVe+9NxdJBgKBbIU/SSs2O6kOPph4lNMnR4i
         NYfzYRcNhipRTA9YUJzggLjQITLnod1OcYKzXyUXfhCrNagZHsYSN48dQu5pe2zZ27wE
         nKB4Mso2ZpN0pNfr3Lxs8PaFF9NFXRPTtcLAEaPde6iPa0gzyr/XTsY5VUwAku2+hY1H
         /awA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744378363; x=1744983163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HdsNeALPBRl7TJQey6t9d/l1PV0RD8jB7VsA4lZuNc=;
        b=dBFqmICDp7bbZZCDeZ5MFe7eImjbvSop6HpCec9ZfA91VVSG6eSrkQgppjkU/SCxxj
         I1WtutXgqMiF/N/NL4AWwwysfECykfYEdeSX3R7icbZGYUB9cHBAUwX1wTRA30HEca0F
         Tf6eI60QkDCgir3PMUQPfQjKJwziEFqjs+uznk2n8/GdzPnbZEm81q69iicI6VPbvzAO
         m+X1dnwZ79H568waUhVI1OvO5p+YJOodJoLWTUNnm+/pgY8jt8OlFSIJ/vxWBo5xQ9Rb
         05TUeBiwRzKC9IXltBfItr3qlt4myac7uDogWHoi3uazoYCfx3IB+Q9SJT1nrRmsY5bp
         dX0w==
X-Forwarded-Encrypted: i=1; AJvYcCW7dQMZ+axi2wmANKeiaowNpezY4zphMSQWW5R7A/e9VL0x7MboMhW1jf5Nm0xWoH0fFbuSOeSH@vger.kernel.org, AJvYcCX5EbHqOIMQNWbbKZLdx+uLPuKG42lDDwgL3n7P1ftNW9zNy78Ub0gGHkF8mIEVnp6kHcW8OlzRAuNL@vger.kernel.org, AJvYcCXAyENw2cI1nq5g+LdeDremB0VBIpKiP74sfZLtwTyJV+7rMr9Bj5cCK/rae6drEG0Rhrwh32Hzrc2A3/d2@vger.kernel.org
X-Gm-Message-State: AOJu0YwWamZqcArGcdkr43JKcfXkyLOjtYSNExuCwX0pGV3ERGNg/g9p
	bYFSZgDMfSNZfyqRS/RRaNvw9+6MxDcLj0z9DUikGAIf7pnWAN9tLCOnx6sjw3uFQEEiwWOKUQx
	Az/nydLj9JHOeKQD1svjKYaIwU+U=
X-Gm-Gg: ASbGncu4RtZJ9s2kqtsrnzMjYin6RVqlwUnNK5yk+K1XLBq8216zUcO7H0pmykxS2hc
	1WGDUUrU/mraso4tNZ3ErbUijLIRLZKNQgFK4yYszxvcnrfWoXhCbVe20NRwOHQs7gA/Pgb1Cqu
	t+DPeoDl/dvxnx7Nj3+LGAecWo3d6T8M6KkUUUVxgQJ3DY5IUizjhwOg==
X-Google-Smtp-Source: AGHT+IE33NDJqid6qPgYC+c0Q5rSljAhPbuipqNwWv+AwO2kvaeyl/9m5RUa6zx/o/+6PMIcz7x+vDzf+xQLmDGeeMs=
X-Received: by 2002:a05:6512:1095:b0:545:aaf:13fd with SMTP id
 2adb3069b0e04-54d452e33e4mr939323e87.51.1744378362995; Fri, 11 Apr 2025
 06:32:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407145157.3626463-1-lukma@denx.de> <20250407145157.3626463-4-lukma@denx.de>
In-Reply-To: <20250407145157.3626463-4-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 11 Apr 2025 10:32:31 -0300
X-Gm-Features: ATxdqUHrNbX-n4olVG1x03xQyfka5HcmTFZKe3_PzzPGFy-GrmPZgKlTzpzOW2Q
Message-ID: <CAOMZO5B6q06nvk3+hzbioGpcW8_JXPZGEebApTU5JZbKvMLzxA@mail.gmail.com>
Subject: Re: [net-next v4 3/5] ARM: dts: nxp: mxs: Adjust XEA board's DTS to
 support L2 switch
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Stefan Wahren <wahrenst@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Mon, Apr 7, 2025 at 11:52=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wro=
te:

> +               ethphy0: ethernet-phy@0 {
> +                       reg =3D <0>;
> +                       smsc,disable-energy-detect;
> +                       /* Both PHYs (i.e. 0,1) have the same, single GPI=
O, */
> +                       /* line to handle both, their interrupts (OR'ed) =
*/

Please fix the multi-line comment style.

