Return-Path: <netdev+bounces-227755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43505BB6AB4
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 14:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 354EA4E3A6D
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 12:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F44F2ED16B;
	Fri,  3 Oct 2025 12:33:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBA12EC572;
	Fri,  3 Oct 2025 12:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.187.100.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759494838; cv=none; b=XOAQy3BWy/L/+4ggMuj5/vnbbeFt9Bdo7IDgXElX84k9FkhVW4TVk4GJcvhrCKZmKGoUrevqpjEO1PvEIkJFWKqlh4wE0LGMOWEB4szfvy3dAhqnz/p5H967DJ1Q06W1m0aIeGJRTiA0Nvy7OgZhR7IP56dBN+XMGrlyO/gce6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759494838; c=relaxed/simple;
	bh=sbMfVrIx7Vyj9h4aPexeTuVOQmBU//u0ZbjjJLVAZpw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JVS0OpdFMAur0cRjEkE59GKtEb30PyCh8rg4cgTiRpHTq6yCoqrg+KP7Isp4piB2ZO06Svelh46hK0QkamdvbM3bxhR+uByOqTQrGYeVPM/j5r66Pj6rdr2/D6ajgVvQxc8cYD5pCZ1GZCv74s3/x1xjm/ukjlAv+OJq+uNBYNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl; spf=pass smtp.mailfrom=piap.pl; arc=none smtp.client-ip=195.187.100.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piap.pl
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
	by ni.piap.pl (Postfix) with ESMTPS id 4B37AC3EEAD7;
	Fri,  3 Oct 2025 14:33:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 4B37AC3EEAD7
From: =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: khc@pm.waw.pl,  andrew+netdev@lunn.ch,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] hdlc_ppp: fix potential null pointer in
 ppp_cp_event logging
In-Reply-To: <20251003092918.1428164-1-kriish.sharma2006@gmail.com> (Kriish
	Sharma's message of "Fri, 3 Oct 2025 09:29:18 +0000")
References: <20251003092918.1428164-1-kriish.sharma2006@gmail.com>
Sender: khalasa@piap.pl
Date: Fri, 03 Oct 2025 14:33:49 +0200
Message-ID: <m3frc0tb9u.fsf@t19.piap.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Kriish,

Kriish Sharma <kriish.sharma2006@gmail.com> writes:

> --- a/drivers/net/wan/hdlc_ppp.c
> +++ b/drivers/net/wan/hdlc_ppp.c
> @@ -133,7 +133,7 @@ static inline const char *proto_name(u16 pid)
>         case PID_IPV6CP:
>                 return "IPV6CP";
>         default:
> -               return NULL;
> +               return "LCP";
>         }
>  }

I'd also remove the "PID_LCP" case as well (just those 2 lines
above IPCP case), the code will probably be simpler to understand
(the compiler won't care I guess).
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa

