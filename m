Return-Path: <netdev+bounces-211684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB61B1B262
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 13:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1441517B389
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 11:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D0823505F;
	Tue,  5 Aug 2025 11:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6B2MaVK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D37EEC0;
	Tue,  5 Aug 2025 11:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754391755; cv=none; b=lrBsMemnPm1/HIpAxwWgYRC5vsFpKeu+DSXqgJOa8am7nIWv2WfNO+JvGsPxxX+wuLNDjTb2013dA8swfdAmaDLBIWAEclvWScO0WZZ8ClH7UWEiZdJ75elkQgO6q7ftw1lT5i58MBA/UeQ4ORVSDo784GYf+K2fEtvDqXL1jMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754391755; c=relaxed/simple;
	bh=Q6AVZ3crYSPbcwTgsAk5P0b/qCiAu/sw1f4RG5VgLAs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FN75//RwlUrGGiagbdWGeBlqPlOWyxLRuKYMh07aS3SedgrItSKyNRtumTKApEowjOJQ+8Dp8ovr1apobuV4uWf+edbaOvGJ9Hvc3bgJRjTqwRdm2GZzcYLrB9xdYxFkCEd3uDy8Kgkf31DpMbV+m1DrvpilzgE2GP7VyD2ngEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6B2MaVK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso33225155e9.2;
        Tue, 05 Aug 2025 04:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754391752; x=1754996552; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q6AVZ3crYSPbcwTgsAk5P0b/qCiAu/sw1f4RG5VgLAs=;
        b=g6B2MaVKjwf14t6lPd4wfMp866QmakG3yyU3pxThGgCWfIB1k1y/Wu6AnPUIj7UDDB
         3Z+pnxZ3n31mxoQeWEfSIa8ZT8TnyNZeYg9wGxR8GHCjUo08ECZwGwMnR8gBV5IsJPnX
         W3NAR7iDmA6MBbvrOBxAOrFSMvps5tGGoTHufHt5JORLQKFw6DDZ+DK3rgpLHJYnYomk
         SE5H2ZHo31A0Lsqap4sR09WnMUzsKP+1iK/pYSKGMJSCGAdZ9WH3A/f0PABuLow1eGLW
         HBmUhD7f22YOP9EXPEg1U4Zrc7G9KJyTcj0lDpYbYs9pPdG2cebUdi7C12dEeV4D4GtP
         VeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754391752; x=1754996552;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q6AVZ3crYSPbcwTgsAk5P0b/qCiAu/sw1f4RG5VgLAs=;
        b=eYKIpOO/6F+7uECPLDGL2WVQbT7ExRz9gKqcffpbRz8JUyqN2QpOjulQx3pXlnHZR0
         mk/TCktPayJ8dS980TjD6xmP5o3y/JHnFcHeWuezuwE10uLxMjqWeecEpL6dxFPNF1Fd
         BAsBmYNKxFRMJ4dV7/Oul9uJlue7ZLwr1wA0a8+ACcpJaMuO4kvVF4EsEBU8SRGuibGm
         YmjLsCH86O5yzSAiNTYILdwlFeryCzVidXqBecBcfUJiw5NI0c4TMtLUe8KI3bshJ9/h
         Y6+xTMCvxYUFOc3hIKQVM5s8gr1AiZRinh/4Cyd3fElM0CO+cl3ozkYNw2M8aS/Y6SOj
         EeZg==
X-Forwarded-Encrypted: i=1; AJvYcCUw5hsJlBf8sBXvBNO11g6QVZQpuqeHM8f+XVX4w4rGcOAkzPf2h+pjMEjUre1JoTeJnZuUyFpt@vger.kernel.org, AJvYcCW6hML5fJwS3qpY43oeJySjQIgL6bKK36Avraa1XvxPiZzaWnNHjwz8UHYm226IgBUit3DxkWZrO9S13501@vger.kernel.org, AJvYcCWNji2mTLfS+mfaDi44vM1hvBQM6vmdAiJTkuFSpHSr1ZXZDtDMAODg8+G5EHKY22RqN5MtqLUEKoAE@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5oI8fkbjBUhwGBAMNEr66JAI7LTVHYtM43VSIqEjOlg5oqWjt
	Dgkj7HqM4c5sD5587inbXo6/KCmeE300hsUVHtwgA2vUAUcTgUQUjyHr
X-Gm-Gg: ASbGncsnmaoGOp+wqvIEHJYyhWTHSv+3FyVH2sBzgrCeU5TQzjLGmTKugXgvZrtIhXa
	gKXi5zRFm3hbkHe3OmecUOpLCHOx/35h5/XHKFQnOvogvjerc4b+l3r6tlD5kq8q4/bcpzFS+s4
	Ok8TBUNUO68g+csue1UYL4mgcrScOihnks2yofAouKk3bPMgY2pVIH7S1/EwNYIcO1OeHPcNShR
	DDNF4oa9prWkuKIKRTUQS9A8RMtBzShkyK6ojH13L11LKR3ZnJSB1HYDBmfZzXBKSd/0fkz7nHw
	NGNOonis9xgEIVV90PfBHn+oFbK/ItTqJjc+/jXLQOaXvTv2EyXz0oBkysxtpSR4YCMXRPYyERG
	xRB+DKceSuj9V5zBX79mtBC8BDlAm4orCZw==
X-Google-Smtp-Source: AGHT+IGNTHumz3Gpa3Tib39pYe7H9R5MBrwrmX6XQRrfK1QM/epHdEMf42gA0/g+dy+VQXFxNy1dPQ==
X-Received: by 2002:a05:600c:3b03:b0:456:8eb:a36a with SMTP id 5b1f17b1804b1-458c0999041mr73677265e9.13.1754391751587;
        Tue, 05 Aug 2025 04:02:31 -0700 (PDT)
Received: from [10.5.0.2] ([91.205.230.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c48105csm18857449f8f.64.2025.08.05.04.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 04:02:30 -0700 (PDT)
Message-ID: <514283a7173f680ffd3f67d839a0d59a95c94768.camel@gmail.com>
Subject: Re: [PATCH net-next] dt-bindings: net: Replace bouncing Alexandru
 Tachici emails
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Marcelo Schmitt	
 <marcelo.schmitt@analog.com>, Cedric Encarnacion	
 <cedricjustine.encarnacion@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Michael Hennerich <michael.hennerich@analog.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet	 <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring	 <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 05 Aug 2025 12:02:48 +0100
In-Reply-To: <mjeyywrkyhvhhm3v34ys4kgtn4milx3ge65ztdmxh4qovllo3s@lfzjtyysg447>
References: <20250724113758.61874-2-krzysztof.kozlowski@linaro.org>
	 <20250801131647.316347ed@kernel.org>
	 <895ad082-bc6f-48e3-ae1c-29675ff0e949@linaro.org>
	 <mjeyywrkyhvhhm3v34ys4kgtn4milx3ge65ztdmxh4qovllo3s@lfzjtyysg447>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-05 at 11:48 +0100, Nuno S=C3=A1 wrote:
> On Sat, Aug 02, 2025 at 09:43:13AM +0200, Krzysztof Kozlowski wrote:
> > On 01/08/2025 22:16, Jakub Kicinski wrote:
> > > On Thu, 24 Jul 2025 13:37:59 +0200 Krzysztof Kozlowski wrote:
> > > > Marcelo Schmitt, could you confirm that you are okay (or not) with =
this?
> > >=20
> > > Doesn't look like Marcelo is responding, Marcelo?
> >=20
> >=20
> > Maybe we should just remove support for these Analog devices?
> >=20
> > Cc two more recent addresses from analog.com.
> >=20
>=20
> Oh sorry, somehow I missed this one! Feel me free to add me...
>=20
> I'll ping Marcelo internally.
>=20
> - Nuno S=C3=A1

Hmm somehow I messed up and replied To Andy. Sorry for the noise!

- Nuno S=C3=A1

