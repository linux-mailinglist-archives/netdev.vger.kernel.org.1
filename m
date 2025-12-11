Return-Path: <netdev+bounces-244337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB96CB513A
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 09:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A63023003077
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 08:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C6429B8C7;
	Thu, 11 Dec 2025 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="aYlzJDkE"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A132D130C
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 08:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765440619; cv=none; b=nP69OX1sh3iML4npMQJxnn/O9SKlCQNbHT16WKEQo86WbrUCub3LZEXsYH4S00w003SgkKd/zXwarzURI6bWBvp2xtk5llpsVLczbWzSjRrAryuSVDNhME+jCzC/B3iZ/NkdV8FZZda3TtIsLvJHvcDJbZ1Xwi4rkjbKx07VUxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765440619; c=relaxed/simple;
	bh=dUksay9luduU/N9yYb3SVkR7EOMDGQ5HTJFD66it7hg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aX+JvRiYcm2TyYuV3HX3Dg4fbji/8VPQuW0ZpAG/TUB1zNzz2QMKnWEFFwJGq/ONq/3hnp90Vu4+dciSs8/BOb8AKBxrrVQ9sxl87jhoPhswQIbMhFu1lCDSI+c8OyNuSGfxMrJwzClsJOMJeLL1lYrcXmsH7qAZUpDKKPAnzS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=aYlzJDkE; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 16A60208A2;
	Thu, 11 Dec 2025 09:10:16 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cNSxhw-E-Lov; Thu, 11 Dec 2025 09:10:15 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 3F1EF207F4;
	Thu, 11 Dec 2025 09:10:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 3F1EF207F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1765440615;
	bh=19Uz5H0yEIVAAxb5YSFj5OD0BR3gcMEBSZRXcPzmLNM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=aYlzJDkEYwQ5PgqOvHz6OxWpXI48h0ua0rnzNUtydNIYQO2LSodauDijxqgy2jZ4l
	 hoW8RpRBcFWajMM9b2eQOqe9GX29AxJyzutiT6TJ6UUitC1lbSPTwHaDpv7wzedqlI
	 KjDfcwpXHnJfc3KH0AlgTQ86DwkZ4JXcGEhH9Kpj0boXHJ6N0ts9R29tc/alt7jpZL
	 B3Neka2QMYylHdBdwKY8Q4Tk4dRmoBR4WsmF+P9FuC8vwa5wWRdlqf7w4hzIXrW3aC
	 y8vzb9zUDGovEZXfTQ/37kiZciuwafp2v/dXu911hnn6PpFsgFgKbLaijYu/kcuZ1Z
	 g6hmrKEwH/f7Q==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Dec
 2025 09:10:14 +0100
Received: (nullmailer pid 2785678 invoked by uid 1000);
	Thu, 11 Dec 2025 08:10:13 -0000
Date: Thu, 11 Dec 2025 09:10:13 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Simon Horman <horms@kernel.org>
CC: Antony Antony <antony.antony@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH ipsec] xfrm: set ipv4 no_pmtu_disc flag only on output sa
 when direction is set
Message-ID: <aTp8ZfrlRUEoYTyo@secunet.com>
References: <17a716f13124491528d5ee4ff15019f785755d50.1764249526.git.antony.antony@secunet.com>
 <aTJ5UrS_3xPrbtSm@secunet.com>
 <aTLlin9RN1N-oeMc@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aTLlin9RN1N-oeMc@horms.kernel.org>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

On Fri, Dec 05, 2025 at 02:00:42PM +0000, Simon Horman wrote:
> On Fri, Dec 05, 2025 at 07:18:58AM +0100, Steffen Klassert wrote:
> > On Thu, Nov 27, 2025 at 03:05:55PM +0100, Antony Antony wrote:
> > > The XFRM_STATE_NOPMTUDISC flag is only meaningful for output SAs, but
> > > it was being applied regardless of the SA direction when the sysctl
> > > ip_no_pmtu_disc is enabled. This can unintentionally affect input SAs.
> > > 
> > > Limit setting XFRM_STATE_NOPMTUDISC to output SAs when the SA direction
> > > is configured.
> > > 
> > > Reported-by: https://github.com/roth-m
> > 
> > This tag does not make much sense IMO. We neither have a
> > real name nor an email address to contact.
> 
> FWIIW, I noticed that too.
> And if that is all the information available
> then I'd suggest dropping the tag.

Right, Antony please remove the tag and resend.

Thanks!

