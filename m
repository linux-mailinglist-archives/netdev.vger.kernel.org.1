Return-Path: <netdev+bounces-139788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B3E9B4179
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 05:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E41AB21731
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 04:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25AF1E883F;
	Tue, 29 Oct 2024 04:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="AyiMrZSt"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725DDFC0B
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 04:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730174824; cv=none; b=p1+Mr4snoHQI9bb7WeombKuGAFi9bxwD29Y4Zfj3vVsljTMPP/ZNcfJIPNEnZro4YSPCXx14n4AKKoXvCKiUNgDweaa+VyTjmvVuEbfAdK9R0q2BlkIvpfT7hJy0qYztZ5jUIAkpVcqlASEUmfBhS0FPLKb+BAZK3uU/zjDpGSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730174824; c=relaxed/simple;
	bh=uNS0ycjbfPv2iXZYalIkjnOcHGYRixJ7gcMpwq5EKWM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IfRP8XXgbfxmASqMgvXm7TxgrzUcZGoZy1pH3zbgOtLDemcivbW9hTIT/ibrcK9VOugQa2P+RjFK/8ZJ7DnSXzDjlAZuP5yClxFOghTzeicRRyk5/JIjH2rfuvYuFRrpu6rzvFEz9EdPGzfxB7rFO972/AyFPt4zjcBKDTakgS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=AyiMrZSt; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730174819;
	bh=uNS0ycjbfPv2iXZYalIkjnOcHGYRixJ7gcMpwq5EKWM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AyiMrZStwyqVSinfmrETkqjfVRBXynyLo3V+KGtKRVAuCQn1cixiYWPp17omk5qe2
	 uF19xDfY6FAK9zKxi9b9MQW09VyHTa3cNP5JWOB8wGMeFMMvbB1VDaps0myeMwMTyw
	 tlQhH6o6uyj0agk+hPQ04Nm2pV8yrS0Zkg0Koe/nB7uRk4vRTq/+BxHZC8sB79lQAx
	 1OBZx5LBmC9oaUbJeX71MKWBcpoOEBIOXlgJ1oEu4TT2/WbUG0tLeJjCoB0yLL7qYJ
	 OZxG0SiLFNubXCEf7CNG1yU/JaiRAwX1SN7UZ1Vq3xuWxXhKWlZRsmjfdqULlTurS6
	 bltp5/5uufqgw==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 93A2869353;
	Tue, 29 Oct 2024 12:06:58 +0800 (AWST)
Message-ID: <f3d0cafe11000fe1cad7b4ad13865b3bcfd2ad27.camel@codeconstruct.com.au>
Subject: Re: [PATCH 2/2] net: ncsi: restrict version sizes when hardware
 doesn't nul-terminate
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Vijay Khemka <vijaykhemka@fb.com>,
 netdev@vger.kernel.org
Date: Tue, 29 Oct 2024 12:06:58 +0800
In-Reply-To: <4f56a2d0-eb1b-4952-a845-92610515082a@lunn.ch>
References: <20241028-ncsi-fixes-v1-0-f0bcfaf6eb88@codeconstruct.com.au>
	 <20241028-ncsi-fixes-v1-2-f0bcfaf6eb88@codeconstruct.com.au>
	 <286f2724-2810-4a07-a82e-c6668cdbf690@lunn.ch>
	 <e6863bfb99c50314d83e2b8a3ab8f1fabe05e912.camel@codeconstruct.com.au>
	 <4f56a2d0-eb1b-4952-a845-92610515082a@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Andrew,

> > However, regardless of what the spec says, we still don't want the
> > strlen() in nla_put_string() to continue into arbitrary memory in
> > the
> > case there was no nul in the fw_name reported by the device.
>=20
> I agree with that, but i was thinking that if it was not allowed, we
> should be printing a warning telling the user to upgrade their buggy
> firmware.

Gotchya. All fine there.

> Are there any other strings which will need similar treatment?

This is the only nla_put_string() in the ncsi code, and there are no
other string-adjacent components of data represented in the spec (that
I have come across, at least).

Cheers,


Jeremy

