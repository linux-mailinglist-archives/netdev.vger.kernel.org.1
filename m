Return-Path: <netdev+bounces-229033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01472BD73D9
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 06:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05DC3BBEAF
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 04:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3646E30AD11;
	Tue, 14 Oct 2025 04:26:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8717630AD0D;
	Tue, 14 Oct 2025 04:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.187.100.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760416017; cv=none; b=Md1HJyM11zU4ZGUYfMXiUTxlEHY+yCeks5Z8sYM7S493weGLbzwA2sS0DaTLPTLGTqvoABaBLhMgJKlAxgnmemioEhkHQq1WlHOoAuW417OTF39ha/I8wOWKRHd8ryFz2sYAYP2h4ACvlj3qmv5ZLm8hiG4gFgnB+ewunyMsfv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760416017; c=relaxed/simple;
	bh=I0W2jFcD54qH7MWQyl3pPNsj40Rx2hEOEXY4YMj1QPI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tV4TBljvMlvwB56xKtiidgxVF9gupfheDbl1p05ykir/TAu83UBrTlADHO43jYLWZCHo5nsUYTIOWa779LjvGethM8p5o1WPbsfkDTfzNCXJF4qiotEGhw9thnNksM5Ty8BZHOLPKvLdnZUySH35x+9RMPXVIJ2PqNntTNMSofI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl; spf=pass smtp.mailfrom=piap.pl; arc=none smtp.client-ip=195.187.100.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piap.pl
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
	by ni.piap.pl (Postfix) with ESMTPS id BA53BC3EEACD;
	Tue, 14 Oct 2025 06:26:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl BA53BC3EEACD
From: =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: khc@pm.waw.pl,  andrew+netdev@lunn.ch,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  skhan@linuxfoundation.org,  david.hunter.linux@gmail.com
Subject: Re: [PATCH net-next v3] hdlc_ppp: fix potential null pointer in
 ppp_cp_event logging
In-Reply-To: <20251013014319.1608706-1-kriish.sharma2006@gmail.com> (Kriish
	Sharma's message of "Mon, 13 Oct 2025 01:43:19 +0000")
References: <20251013014319.1608706-1-kriish.sharma2006@gmail.com>
Sender: khalasa@piap.pl
Date: Tue, 14 Oct 2025 06:26:52 +0200
Message-ID: <m3h5w2rtv7.fsf@t19.piap.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kriish Sharma <kriish.sharma2006@gmail.com> writes:

> Update proto_name() to return "LCP" by default instead of NULL.
> This change silences the compiler without changing existing behavior
> and removes the need for the local 'pname' variable in ppp_cp_event.
>
> Suggested-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>

Thanks, and
Acked-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>

> --- a/drivers/net/wan/hdlc_ppp.c
> +++ b/drivers/net/wan/hdlc_ppp.c
> @@ -126,14 +126,12 @@ static inline struct proto *get_proto(struct net_de=
vice *dev, u16 pid)
>  static inline const char *proto_name(u16 pid)
>  {
>         switch (pid) {
> -       case PID_LCP:
> -               return "LCP";
>         case PID_IPCP:
>                 return "IPCP";
>         case PID_IPV6CP:
>                 return "IPV6CP";
>         default:
> -               return NULL;
> +               return "LCP";
>         }
>  }
>
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa

