Return-Path: <netdev+bounces-99646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECADF8D5A50
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA051F220A9
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 06:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412C17D3E2;
	Fri, 31 May 2024 06:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Rib3Qmlg"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DA97CF3A
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 06:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717135758; cv=none; b=QICjTMhZkpGWlA6jvj316sZU//G9oRSxCk55lFdUH4JOclhKBnxxs8m/f2h2qEa3LHWwtYFDc68p/OHV/6s5MFrbToidWr0mx9v9Z31gV4tYGw1V9ovV7ToeFbWI4EJEEeKluzGY5pIw27EwpOALD1JpTVIA3v5LHEkhxUQPYLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717135758; c=relaxed/simple;
	bh=lOs0z2lmp4fQVWDKAR/IqIUPcKrf3I89aZAiUplvb4E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aepWTn6FUKbAZZ8eqyXFCn+mpm/6iay99SDPm7ExJUL43r19XTze7bV+MoNQRa8iMT43vh1uxJEhE4HKP0I2Rzxl/TJ2xP4Y1FRgsC//C1YzyxC7NCb2SWV7jGWzNHbcDZWiPvUm6NG49gUxpHL+LjX7Jw3befxCqup9m6NcSnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Rib3Qmlg; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id C5B262087C;
	Fri, 31 May 2024 08:09:06 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WLGg9Cke7IRQ; Fri, 31 May 2024 08:09:06 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id E370D20839;
	Fri, 31 May 2024 08:09:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com E370D20839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1717135745;
	bh=2IMly+dF0E/U1aUXbwhYQXfaSL7Bks+55zD2Lh6CDT0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Rib3Qmlgqu6lbr5R3BRDcuRRTPfQX3rWMJ3hhhl5U+Y1KKKgtGFCpEpziRKlkdRQA
	 kA48WK79eTYclcPsZ/XvyjlhevV3d6M9vFN7O+YdnD2xD9/7ApTVjb4dgvu2eXopq/
	 60B9uxkUjtL1Yc9XindHlCruAkSClK+qUdXuLa8zuRUMV7YHmoxxg/XqZaKO6g70Gz
	 KaGrbSfUcQyHXj2M0aDxhhkbbwDQtkhufxoEbC9NPJSJppN/1UGm0sqCqSms9nYbQY
	 NqqsmYK1smmsyJIm7K2qVXbbMyuc5k1Oqou0yniYGwlnvaJrI7eFmm6lJ3e5eopgIb
	 HwFNkkyAak5ng==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id D460480004A;
	Fri, 31 May 2024 08:09:05 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 May 2024 08:09:05 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 May
 2024 08:09:05 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id C8FBA318295D; Fri, 31 May 2024 08:09:04 +0200 (CEST)
Date: Fri, 31 May 2024 08:09:04 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: Paul Wouters <paul@nohats.ca>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <borisp@nvidia.com>,
	<gal@nvidia.com>, <cratiu@nvidia.com>, <rrameshbabu@nvidia.com>,
	<tariqt@nvidia.com>
Subject: Re: [RFC net-next 00/15] add basic PSP encryption for TCP connections
Message-ID: <ZllpgEvQ4QnfP3m7@gauss3.secunet.de>
References: <1da873f4-7d9b-1bb3-0c44-0c04923bf3ab@nohats.ca>
 <ZlWm/rt2OGfOCiZR@gauss3.secunet.de>
 <6655e0eecb33a_29176f29427@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6655e0eecb33a_29176f29427@willemb.c.googlers.com.notmuch>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, May 28, 2024 at 09:49:34AM -0400, Willem de Bruijn wrote:
> Steffen Klassert wrote:
> > On Wed, May 22, 2024 at 08:56:02AM -0400, Paul Wouters wrote:
> > > Jakub Kicinski wrote:
> > > 
> > > > Add support for PSP encryption of TCP connections.
> > > > 
> > > > PSP is a protocol out of Google:
> > > > https://github.com/google/psp/blob/main/doc/PSP_Arch_Spec.pdf
> > > > which shares some similarities with IPsec. I added some more info
> > > > in the first patch so I'll keep it short here.
> > > 
> > > Speaking as an IETF contributor, I am little surprised here. I know
> > > the google people reached out at IETF and were told their stuff is
> > > so similar to IPsec, maybe they should talk to the IPsecME Working
> > > Group. There, I believe Steffen Klassert started working on supporting
> > > the PSP features requested using updates to the ESP/WESP IPsec protocol,
> > > such as support for encryption offset to reveal protocol/ports for
> > > routing encrypted traffic.
> > 
> > This was somewhat semipublic information, so I did not talk about
> > it on the lists yet. Today we published the draft, it can be found here:
> > 
> > https://datatracker.ietf.org/doc/draft-klassert-ipsecme-wespv2/
> > 
> > Please note that the packet format specification is portable to other
> > protocol use cases, such as PSP. It uses IKEv2 as a negotiation
> > protocol and does not define any key derivation etc. as PSP does.
> > But it can be also used with other protocols for key negotiation
> > and key derivation.
> 
> Very nice. Thanks for posting, Steffen.
> 
> One point about why PSP is that the exact protocol and packet format
> is already in use and supported by hardware.
> 
> It makes sense to work to get to an IETF standard protocol that
> captures the same benefits. But that is independent from enabling what
> is already implemented.

Sure, PSP is already implemented in hardware and needs to be supported.
I don't want to judge if it was a good idea to start this without
talking to the IETF, but maybe now Google can join the effort at the
IETF do standardize a modern encryption protocol that meets all the
requirements we have these days. This will be likely on the agenda of
the next IETF IPsecME working group meeting, so would be nice to
see somebody from the Google 'PSP team' there.

