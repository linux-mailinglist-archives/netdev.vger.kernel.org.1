Return-Path: <netdev+bounces-119562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCA995637C
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 08:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A62DB212E6
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 06:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3DD14BF92;
	Mon, 19 Aug 2024 06:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="cohS6Tag"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097FB142621
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 06:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724047595; cv=none; b=RyhkbZuYtNx5axgJJbLRdCLoFZumV1G8jV2FuXup1UZWbgHT/xzsbhJd4y68lXOOhGgVBnFxkcIy0WHbjAQbI2/wm3D1mZIyjJp+jvzpMRdZxSjPb4JKn82aF/DjvwPWyX1youMkmWhdXdrLUtvWYMyoHHpyc3BSHWYFJEiGmZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724047595; c=relaxed/simple;
	bh=Rtn+cG0SHnDNP07ssEhopb87uurieCU+8eEMtf4EdKY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxSM9k/GUsKUUpMitqdrL7AKBvb24cDptSPOWxz6ywEO1KRJ5DL2u9N1Zx7uyYhTg+/nqBCIHQi6JJUrnjbGFb0FKTeBH+ETY7aCLxJImRyTj7WzGJRKN3Q8iwTdpPGeo4LM7yCKx53ucd1/IXokYSfGjd6biXxMD3LDwsXJvRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=cohS6Tag; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 3D4A8207CA;
	Mon, 19 Aug 2024 08:06:23 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rS5g-ttddOpW; Mon, 19 Aug 2024 08:06:22 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id C0D8C207C6;
	Mon, 19 Aug 2024 08:06:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com C0D8C207C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1724047582;
	bh=/7ciDA0nYyDfMXO1vXz5wlwtP03fhTDXbvz2pbXf6mA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=cohS6Tag43SYNXwM+EEgEpR2WAkDirbhnB18WC8hITr1xhjAyRXg6mEiJcUog+Am1
	 bTCpbVJEsjpq9GatB7Q7vcKO2YDRCV98Isc2A/GF0TuGX6VNR3Q+yGfG0sC5WOumL7
	 nbcxZNWNuFs1VptDT14SzkR8wTZ5lzdYwAj5tcg4wpQrglKEKOklg0IIXvOyakFKvP
	 W40UipfqC6lesHiFRrFqToFglFWG7fi6kPMwY0c6aqHkpqHWOrY8K4w7H1+ltUjTP7
	 KG/TPQmTVmAUBxYYLp7Vnat+X1I5e9ljaYR0LWqAs4OMDWF4pGBjmfX11//tBl4ZEs
	 9MXdnhGrbMRFQ==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 08:06:22 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 Aug
 2024 08:06:22 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id E7D2E3182A82; Mon, 19 Aug 2024 08:06:21 +0200 (CEST)
Date: Mon, 19 Aug 2024 08:06:21 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Feng Wang <wangfe@google.com>
CC: <netdev@vger.kernel.org>, <antony.antony@secunet.com>
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
Message-ID: <ZsLg3YEX/o/GEe+P@gauss3.secunet.de>
References: <20240812182317.1962756-1-wangfe@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240812182317.1962756-1-wangfe@google.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Aug 12, 2024 at 11:23:17AM -0700, Feng Wang wrote:
> From: wangfe <wangfe@google.com>
> 
> In packet offload mode, append Security Association (SA) information
> to each packet, replicating the crypto offload implementation.
> The XFRM_XMIT flag is set to enable packet to be returned immediately
> from the validate_xmit_xfrm function, thus aligning with the existing
> code path for packet offload mode.

Please explain in the commit message _why_ we need that change.

Thanks!

