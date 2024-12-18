Return-Path: <netdev+bounces-152745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7959F5B2B
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 01:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761361891035
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 00:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03CB320B;
	Wed, 18 Dec 2024 00:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="TeGK7Yto"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F9B33D8;
	Wed, 18 Dec 2024 00:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734480567; cv=none; b=nFL0HTL3Cjj5s1ZhFpWztARLSfCf9g1E8GdbKX7leBhTQ/jUfl4V67RUzqiXOsHZuHh1+vL58jP1DsoXhGhoDmHwZUBuR8nCQcL76jfFiUbJezujzjhXMWIZcgzvpCSAeB+b3O7XxvvkZX11ggLWpb+y69UKQCy9kwdQ8ewrzPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734480567; c=relaxed/simple;
	bh=9+cKn7QEeUDoB/RqtHyOeDf93MZ40cdw5taP99fDmLA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bJcTute60ZQ85OuCpHPBLrtOO+vVZq09WBUQH5j8E/X/e65Z1g5Jv3Jqk7pOi5G1uxd9CrHF9LAS4HQfTipc0nobi1ElnTkppLwx/3ddHlptBdq4pMxljD589Ss7/UlgOaTsx/Ym+33nfr8pl8MvtuFCvAur8RNXTWWCWpadgVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=TeGK7Yto; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1734480562;
	bh=9+cKn7QEeUDoB/RqtHyOeDf93MZ40cdw5taP99fDmLA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TeGK7YtofpEdTn+QXHIgNzR2pOGglZjJqbtojjMg1Tsmjx/tuyLs+ugkaW+dT6S+e
	 j6mKVbwECq2s2WOMUKIH8Jr60sbHrY9yi3E42aXwpXp9dEcwAB1hW+Fn0RtusNilBw
	 Tao/4iXfmANzhcix3jyFfW1pPtcNBLiUrojVFKp0lubuL/fCfBy7dpsGgoYD0ewEq6
	 dZqmjCvcUZ1Lhy/7+oWarxrJqYy0ju6LeD/MLuG55VK9JTel7887DfWH0hDvRIZ2q6
	 Kgh/SpPkma7La/XNv6Ik/+3gj/mOUgGKK/fEDVFXg6ASG/maJ62//SRYYCrXm5mfme
	 A+1JrniUidSvA==
Received: from [192.168.72.171] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A8FE26F531;
	Wed, 18 Dec 2024 08:09:20 +0800 (AWST)
Message-ID: <0ea0aac339c2ee7522510f1dab5f69a27413434d.camel@codeconstruct.com.au>
Subject: Re: [PATCH v9 1/1] mctp pcc: Implement MCTP over PCC Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Joe Damato <jdamato@fastly.com>, admiyo@os.amperecomputing.com
Cc: Matt Johnston <matt@codeconstruct.com.au>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,  Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Huisong Li
 <lihuisong@huawei.com>
Date: Wed, 18 Dec 2024 08:09:20 +0800
In-Reply-To: <Z2HLJD8z3wFNvnlV@LQ3V64L9R2>
References: <20241217182528.108062-1-admiyo@os.amperecomputing.com>
	 <20241217182528.108062-2-admiyo@os.amperecomputing.com>
	 <Z2HLJD8z3wFNvnlV@LQ3V64L9R2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Joe,

> I suspect what Jeremy meant (but please feel free to correct me if
> I'm mistaken, Jeremy) was that you may want to use the helpers in:
>=20
> include/linux/netdevice.h

No, I was just referring to the new(-ish) dstats infrastructure in the
core, with dstats collection in rtnl_link_stats64() as of 94b601bc.

However, your suggestion of:

> =C2=A0 dev_dstats_rx_add(mctp_pcc_ndev->mdev.dev, data_len);
> =C2=A0 dev_dstats_rx_dropped(mctp_pcc_ndev->mdev.dev);

make it even simpler! I would agree with the recommendation there.

Cheers,


Jeremy

