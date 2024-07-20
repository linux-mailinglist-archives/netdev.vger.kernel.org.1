Return-Path: <netdev+bounces-112294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 406D693815C
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 14:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC389B2138C
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 12:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAF37E0FC;
	Sat, 20 Jul 2024 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYqfVG6M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDB8257B;
	Sat, 20 Jul 2024 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721479464; cv=none; b=BJJ3TpvV1wd24K8/c6Q1lq8SKicgEET3AqCWFrR2LBAj9pLWppDsX+XSxZPSUG5TMfbZBEOvT28dX26nKBrFKjMlvNRitJSvnnMitW1kdEJi9MG8DDwktjAUlpdLZMoIPGg0ZOK6nZgwxPJ+TzHgDD6BfsxZ98x0mMpsXFO6YsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721479464; c=relaxed/simple;
	bh=1nsnebR961oPwpt1bU6VHdK6v98hEAP+QPoTD+y2kHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCPqO+4MUlXAuCcFbwqiaizSlYOz2le526aupWpksMQppeol8ndHtD1REPnAxrALMhaROVvFP8QxXIVuMLazIdxuCvUddYA8Rc4v1BCv2MOeOMMcsS+ZbVX8Hu17j344kq6b9V8XSUEZXvJ7xGHCuR3Oz6cgi2olvW56p4xLLRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYqfVG6M; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c9cc681ee0so1535531b6e.0;
        Sat, 20 Jul 2024 05:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721479462; x=1722084262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nsnebR961oPwpt1bU6VHdK6v98hEAP+QPoTD+y2kHU=;
        b=QYqfVG6MJZDwBa+ALAdbTabX8v8CaXEqlmuUSzd9lxi/iHW/4liApVR1mv1GC8OUZa
         G0zn2an9KqxVyJfp4Omx+V4HQhGIwHuVrFGCr/8hhFDHUEDOZ9nONY430k9L+v9Z5p2J
         UzM2hdp0YuBmG3Ba6EI7/qJ/BeAAE9O7a2xOgdj+s/smO0UisjhLqw+L/7b9MxakK09c
         WYdQYjISSA3l2ABKn56x073a8tZvKfRR8wXDyXngz0blLGKW9F6d+irj1hjEnKc1A2fq
         967pXejdqgIrKtkO5sCIrtNDINGo1tgOeHI3/dOqEvXKC6a1at5Bhac1qjDCYnOtAPbs
         pNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721479462; x=1722084262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nsnebR961oPwpt1bU6VHdK6v98hEAP+QPoTD+y2kHU=;
        b=bDnrQ+RnDVvAS7V4KBR6u6BI+mSnhmMikXqP28vQu7rd26Pc1YnvXC4VrLsTU2BmNY
         NJB/ZQFojeIhyvV1dZmTvH9+rGcf+xL4EEeaqgMH3UGZ42c6sJ1XfgNj/UG5E7Z7dYm4
         7+Gw7kOUnUdr+vPwE8sZnzT7LkaXK0qMcZu/bIvWZyVxrm3uzZrB8OfE4CQJVaw/Y0w8
         Y1A26X2jX2Gb9+V2/ljIxEVeE+H6Fj8p98bl/vbNmyiSTSuqCad2ZDxUuHgFPRBnmPDm
         Undg7ksZM3CBR0ao441AF0ltWIcXUcbzAaBkzMT2Q6gqHPHeJIUV2vP0+53kZJ11VzTS
         v4eg==
X-Forwarded-Encrypted: i=1; AJvYcCX3zYUE2XT47LT98asTNQ7wSmTEHXEbFbUjg+PTwGutsX/DjgMwEUXdlnU5NvvWBeGOIIruWKA9VwqqmKzdxrn2a921JuCe
X-Gm-Message-State: AOJu0YwQzXp4oiefV1BqF2sltXW5eZiZ409bcI3fC+DXpaWJIIFsSo1G
	6057RlN9BqG2ctupXK2pv2b7qS3wewv03dZk9fPQIIOr7AksOrHE2BC0KIR/L1WN2vCpmFKtKDL
	jVxHCvBPi1U597482dXFFov2sP7Q=
X-Google-Smtp-Source: AGHT+IEceOhq05EmeqOrV8bmatPizQhGl9TG3AHZbMQocp7H4pzROq5uSk8z+WR9e0ZBcSN6ixBEXE8ewWe7oE/Iai4=
X-Received: by 2002:a05:6870:a11c:b0:25d:f654:9cd6 with SMTP id
 586e51a60fabf-263ab5622a2mr1248158fac.38.1721479461898; Sat, 20 Jul 2024
 05:44:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717193725.469192-1-vtpieter@gmail.com> <20240717193725.469192-2-vtpieter@gmail.com>
 <20240717193725.469192-3-vtpieter@gmail.com> <ZppuQo9sGdYJWgBQ@pengutronix.de>
In-Reply-To: <ZppuQo9sGdYJWgBQ@pengutronix.de>
From: Pieter <vtpieter@gmail.com>
Date: Sat, 20 Jul 2024 14:44:10 +0200
Message-ID: <CAHvy4ArOx2MhMmrgeosPbr8NLE6Kf=wWuL23+g-+2=Uf9UaFtQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] net: dsa: microchip: ksz8795: add Wake on LAN support
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: devicetree@vger.kernel.org, woojung.huh@microchip.com, 
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, 
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 19 juil. 2024 =C3=A0 15:46, Oleksij Rempel
<o.rempel@pengutronix.de> a =C3=A9crit :
>
> Hi Pieter,
>
> If I see it correctly, the only difference between KSZ9477 and KSZ8795
> code is the register access. Even bit offsets are identical. I do not
> think indirect register access is good justification for duplication
> this amount of code.

Hi Oleksij, thanks for the review! I guess you're right - I must have
gone too quickly for the easy way out. There's actually one additional
register access for KSZ8795 but it should be possible to get around
this as well. I'll work on it but it might take me a few weeks to get
this ready. Would be great if you still have a KSZ9477 family board
around to validate.

Cheers, Pieter

