Return-Path: <netdev+bounces-92328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E5B8B6A73
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 08:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCFC91F255E9
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 06:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C482E822;
	Tue, 30 Apr 2024 06:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="WqVH6WWt"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D80622618
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 06:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714457811; cv=none; b=tHoOXwjjgYw9MolIXfMK2yuoJuow2U0XTpo9l8aHpg5WDuM02lwvUOCuk8Y6FfCDiu9rAxQ1xF9kwntFZZSuQDRXecio84VDGgHa9Ux35zSh9/YLEy823/V+Ocb/otNUMltFvHA3HhxRX56shOvq9mrYirHW2iKyFMCW+aRaRCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714457811; c=relaxed/simple;
	bh=ORyovM61vzZeh1mBmRb9r+voxEvwy0i9G5xf/N70y9I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOVIHy+rjT0AW3LsQYFSTVZkZFIGda30WENJkOYnpgY9IUoqbsmMjgd5QmRnWqps9qn4AglKozwIp2recniUcUYE35Z+Bb40N3xX8PyXXsey17v8AOrJr7p4pFJUZYXwrrhpxYCYyTuBXU2KOhUumPsqjP96kpTrQBx07Bt3bM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=WqVH6WWt; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id B602420758;
	Tue, 30 Apr 2024 08:16:40 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aNWcarRYDiih; Tue, 30 Apr 2024 08:16:40 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 388C520561;
	Tue, 30 Apr 2024 08:16:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 388C520561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1714457800;
	bh=8i9nuchNnGcnoY8o+v+3ic/fBM9VqZJ7ljsIwbD2D3U=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=WqVH6WWtGiIqg00/ztz/+3mIKbSHyCG4e+UBOSUTKTM2L0gDmoYhkD461jZLizJuq
	 2uy8fxDcitwdmYYAA5CgnRNKjY44c+PeShUuwsLuSY2tfLchcuAAvqoRuEH6twddaw
	 aZuIQSCrD4aLRdGMwUJcvXOROXbZDpzCL1UnnPCeucZEFhqY/NBj3vPfMzHFZ7zxg9
	 EvjwIx2CjV2fPHl6Ib4QIQ5cdCGHE+fz7WF5c+PrcC66JEdExRQKCDYviJ8Vw7OTFK
	 zBJPvPnkSbj78aZ5EO5z/IKlX+CoUFFg0zyBx++dNxQXAFdM8ehJGTGFfXs3wEnPbq
	 i8EpJCMWA0+gQ==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 2AC3280004A;
	Tue, 30 Apr 2024 08:16:40 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Apr 2024 08:16:39 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Apr
 2024 08:16:39 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 34F993182A0F; Tue, 30 Apr 2024 08:16:39 +0200 (CEST)
Date: Tue, 30 Apr 2024 08:16:39 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: Antony Antony <antony.antony@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <devel@linux-ipsec.org>,
	Leon Romanovsky <leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [PATCH ipsec-next v13 1/4] xfrm: Add Direction to the SA in or
 out
Message-ID: <ZjCMxwhiIvAbqvxy@gauss3.secunet.de>
References: <cover.1714118266.git.antony.antony@secunet.com>
 <21d941a355a4d7655bb8647ba3db145b83969a6f.1714118266.git.antony.antony@secunet.com>
 <Zi-OdMloMyZ-BynF@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zi-OdMloMyZ-BynF@hog>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Apr 29, 2024 at 02:11:32PM +0200, Sabrina Dubroca wrote:
> 2024-04-26, 10:05:06 +0200, Antony Antony wrote:
> 
> Sorry I didn't check all the remaining flags until now.
> 
> 
> Apart from that, the series looks good now, so I can also ack it and
> add those two extra flags as a follow-up patch. Steffen/Antony, let me
> know what you prefer.

It would be nice if we could merge the patchset without known
issues. OTOH this might be the last chance to get in in during
this release cycle.

Antony, can you provide an update today?

