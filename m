Return-Path: <netdev+bounces-101223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 625538FDC90
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 04:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1671B210CB
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6362F4C97;
	Thu,  6 Jun 2024 02:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ceP1b+bO"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E571373
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 02:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717639916; cv=none; b=jkzMzPXMdoha1rt5A7Tjom77L/hh7VU1MU6Cu4c6cBoC5THOiCO6KT9LNJvoJnsXycVzX5kV0uMEIYS1TLcs4jVYHYpWLowy9u5Y5ZRw97rJCKRrgfcCBVWTg+3YpHs8ZqT9AxMDX1BOkPbcdxynnM+tc2nJUhmGscekc+3UjfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717639916; c=relaxed/simple;
	bh=kspQWIA4szQriTA8cC7tERCJ6RVwE1tZo3OoI38ZqSw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VFPl9Cr+PxiS1ERE7PZx3sJXU+BCHv4JAyccYdzdiWOWQChPVB8YwI5afp+wyswxzoB2UsmCWDqO0Pj4nS6G0po6MQo73P/RKR0xFkiFIsB+s8aW1czMt0jT4olq4QyGKsrxeYFUY0/EB4DpbXn0RKmtKALoK2g3F9mnkmnx5Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ceP1b+bO; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.2.60] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8B83120154;
	Thu,  6 Jun 2024 10:11:51 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1717639912;
	bh=kspQWIA4szQriTA8cC7tERCJ6RVwE1tZo3OoI38ZqSw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ceP1b+bOvs2GLVg2iMKykZjnDSGW9NGmtz3dDJfvq+NGsnvs6Iibx/zWrdyUZav2K
	 FQHfX91lnwx1Abz8Ac/6o/cP8nMAAV5PctoORf0/ynmLkNydOwHHYBK9/XGIS5Rkng
	 zyX/Phb8mzm/4430+B/O2qKIoP1bPzAwtfncT4cR9MF+RNtw+UdBP0DeNN+7Jo5Fdy
	 zTS7M3EvsVkAO413RD3PGUWMqzWR62lB/1GLm+ike4mjKqV35DrmNe2AlCEQGX22f8
	 eK7CdrE8oP97nAw3WRyJVbqLBHMgzpRfxDdRzF1Gr/dMZ0X7B+6UVVRA/fr2icshMP
	 v6dcudBFlU0kQ==
Message-ID: <ccb2a7fc282d7874bc3862dad1ca7002b713ac33.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v2 0/3] net: core: Unify dstats with tstats and
 lstats, add generic collection helper
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Date: Thu, 06 Jun 2024 10:11:51 +0800
In-Reply-To: <20240605190212.7360a27a@kernel.org>
References: <20240605-dstats-v2-0-7fae03f813f3@codeconstruct.com.au>
	 <20240605190212.7360a27a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jakub,

> > This change unifies dstats with the other types, adds a collection
> > helper (dev_get_dstats64) for ->ndo_get_stats64, and updates the
> > single
> > driver (vrf) to use this helper.
>=20
> I think you can go further, instead of exporting the helpers and
> hooking them in the driver, just add the handling based on
> pcpu_stat_type directly in dev_get_stats().

OK, makes sense!

If we're not exporting the helpers, that means that drivers that use
dstats wouldn't have a facility to customise the stats collection
through a ndo_get_stats64() callback though (as can be done with
tstats). Are you ok with that?

[the set of drivers that need that is currently zero, so more of a
hypothetical future problem...]

Cheers,


Jeremy

