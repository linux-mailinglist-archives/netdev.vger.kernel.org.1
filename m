Return-Path: <netdev+bounces-232257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7456C036C9
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 22:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E823B2969
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 20:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5E4221FDA;
	Thu, 23 Oct 2025 20:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="zCYlvIKk"
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64D3184;
	Thu, 23 Oct 2025 20:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252554; cv=none; b=N8LQpaCeA0w1zz3Y3KIbeA9KSXqYxeAAYfTdV130zzFkWrXtbBYlaiYClyFajvT6QGB1ISJNfjzAsNHvvHHtnYAmyGhFKQe5/XpdN8IScV6WRnK3RQYqIUuSzMUj0HyrvF/KCQpY8fkfGRJL1qia4IJZOEbmAmTYghpJEYuQk4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252554; c=relaxed/simple;
	bh=q2PlpbC6DOPQ9Ag/NqmWzOb39YBV/wCJHBS+fST6+60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ar8rDr5LEpLz9va2+9d1DudgCjHxbz8gB6Iaw5hmFrLORv7GTkvmgJlcEK6zKS/+j4Cu5FCpqSEtX422SXulda2seg8Kqha7RoAFLiW7Kkwj4IaFAWN8fZN94D/hTM5uIYnQ3jSO3wvlesnRldwPrSJbk5LoDqDGzUAodU3qF7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=zCYlvIKk; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=q2PlpbC6DOPQ9Ag/NqmWzOb39YBV/wCJHBS+fST6+60=; b=zCYlvIKkaYPMPFlwDGw2mH+kHy
	ji2uFpc/zpY93YkSDpu9FoEHpcDKIgoLk3d1IJTG/hzYq/5XO3MmKUS6f9fNoEikBVPAWc5Vl+lzi
	3KhZBG2O91EzgXVm5p5so1G2MAY6t1oR5MkW/QY7Q+PkYFd1kqWnH7pSywWjMkvdujQQA/Plf79ZQ
	s8/pC2lPPs0WO2E9So/gzntHoL0cOf1DvFa/GswS6M03aMshumLFP2Rg20GIgpDkmUlsfJMQVKeT2
	EEjPhtFv8LuUNwN3Mpyt/p9Ic1TzdZuGW2dLOV41Xqm5dFDtBS8sJvd3R9ulA+lEZn/3nY1h0MZwH
	H48fS6tw==;
Received: from i53875a07.versanet.de ([83.135.90.7] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vC2Ey-00069O-2v; Thu, 23 Oct 2025 22:48:56 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, jonas@kwiboo.se
Subject:
 Re: [PATCH v2 5/5] MAINTAINERS: add dwmac-rk glue driver to the main Rockchip
 entry
Date: Thu, 23 Oct 2025 22:48:55 +0200
Message-ID: <4664419.8F6SAcFxjW@phil>
In-Reply-To: <35567cda-0f49-4784-b873-97e378fcee16@lunn.ch>
References:
 <20251023111213.298860-1-heiko@sntech.de>
 <20251023111213.298860-6-heiko@sntech.de>
 <35567cda-0f49-4784-b873-97e378fcee16@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Andrew,

Am Donnerstag, 23. Oktober 2025, 20:57:50 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb Andrew Lunn:
> On Thu, Oct 23, 2025 at 01:12:12PM +0200, Heiko Stuebner wrote:
> > The dwmac-rk glue driver is currently not caught by the general maintai=
ner
> > entry for Rockchip SoCs, so add it explicitly, similar to the i2c drive=
r.
> >=20
> > The binding document in net/rockchip-dwmac.yaml already gets caught by
> > the wildcard match.
> >=20
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>=20
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

just mentioning, I wasn't sure if your review for patch4 was still
valid after I adapted the change to Jonas' suggestions, so only added
the R-b's from v1 to patches 1-3 .

Heiko



