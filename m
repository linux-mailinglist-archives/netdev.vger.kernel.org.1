Return-Path: <netdev+bounces-227720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFEEBB5FD3
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 08:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80C104E1890
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 06:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FB6212566;
	Fri,  3 Oct 2025 06:43:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718AB46B5;
	Fri,  3 Oct 2025 06:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.187.100.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759473796; cv=none; b=C8nXvHRoxJeE01HbY+737hq4WVl4VU4pSJ1J48cbyY7MsXqXwbQ5dIurls58PlorWzrpduP0Hl02AfU4UYP4tXaRoprtRzvMT9eK39UOdLDz/AoFgGlhZAr/kSK9PahSYtzURYmZ8ZS1NTq9gaozxACSPNfSLSh/t1M31rrbaGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759473796; c=relaxed/simple;
	bh=0cB5I9OcBsrAyHHeP2qTFCp9rOKySUcatAIE98vMy40=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N6XtGehzIpfi850fY4wTBzHdtoCA2b0ShDga6tPV8DXpQ+Ug66lh1iTeeOyOLcnzZJRBYJjQSt7G9ceXklhSaEs98sbUloPa9sOrieJaV1so2kJCWwmuM39K6j2/y9HOtRSPZOlWfopXvfW85ZSVQ5PYNepG6RoAQbSg2ZYaDKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl; spf=pass smtp.mailfrom=piap.pl; arc=none smtp.client-ip=195.187.100.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piap.pl
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
	by ni.piap.pl (Postfix) with ESMTPS id 4D211C3EEAD7;
	Fri,  3 Oct 2025 08:34:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 4D211C3EEAD7
From: =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: khc@pm.waw.pl,  andrew+netdev@lunn.ch,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net/wan/hdlc_ppp: fix potential null pointer in
 ppp_cp_event logging
In-Reply-To: <20251002180541.1375151-1-kriish.sharma2006@gmail.com> (Kriish
	Sharma's message of "Thu, 2 Oct 2025 18:05:41 +0000")
References: <20251002180541.1375151-1-kriish.sharma2006@gmail.com>
Sender: khalasa@piap.pl
Date: Fri, 03 Oct 2025 08:34:01 +0200
Message-ID: <m3o6qotrxi.fsf@t19.piap.pl>
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

> Fixes warnings observed during compilation with -Wformat-overflow:
>
> drivers/net/wan/hdlc_ppp.c: In function =E2=80=98ppp_cp_event=E2=80=99:
> drivers/net/wan/hdlc_ppp.c:353:17: warning: =E2=80=98%s=E2=80=99 directiv=
e argument is null [-Wformat-overflow=3D]
>   353 |                 netdev_info(dev, "%s down\n", proto_name(pid));
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wan/hdlc_ppp.c:342:17: warning: =E2=80=98%s=E2=80=99 directiv=
e argument is null [-Wformat-overflow=3D]
>   342 |                 netdev_info(dev, "%s up\n", proto_name(pid));
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It appears proto_name(pid) never returns NULL there. Despite actually
saying "return NULL", that's right :-)

Perhaps you should change it to return "LCP" by default instead, and
not only on PID_LCP? It should silence the compiler.

This ppp_cp_event() is called in a few places:
- ppp_cp_parse_cr()
- ppp_rx()
- ppp_timer() (with a known protocol, though)
- and others, with PID_LCP.

Now, before printing proto_name(pid), ppp_cp_event() does
proto =3D get_proto(pid), and dereferences it :-)

The pid seems to always come from ppp_rx(). Fortunately it's checked
at start, and it case of an unknown proto it goes straight to rx_error.
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa

