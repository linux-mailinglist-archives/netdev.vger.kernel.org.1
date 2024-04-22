Return-Path: <netdev+bounces-89925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4728AC381
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 06:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B3B1F214A9
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 04:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A145813FF6;
	Mon, 22 Apr 2024 04:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="XM6GIBeh"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECBC1802B
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 04:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713761261; cv=none; b=AFWz7B2lIC60SBJXO7rz/x7tFqqa59L5vJkOuHBuw5BJD3f+8iaxse+Z4OpkyVqaMpU+47nsg8f8BmdcbsnU7L2Z5ZbNs7fDXghDJUXco2FGkPNp0ru2J68k+WANmQZtIt+TcMfPT33plRwe76E+jtW6EEF/EDwecGD4U+ntiJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713761261; c=relaxed/simple;
	bh=8MrZuga+CXIPEzmieWHZxLho3OsGByZrFoid2PpNrvk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHVogh2rQjpjKVPwqMq9zdoKW2bAsVMxQajApJUalOAMhbewCchuJVyEn75F7r5jPbU15MOgF1NTrgRxdy1C9CMoDPUreZNLbJA7gV7i7DPg4yL/pY+I7YPMEOUqZmVGGW2msxApkaLsFtzHUjL3vzxzdsSDZhKQPeFbn0S3pms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=XM6GIBeh; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 90FC620799;
	Mon, 22 Apr 2024 06:47:37 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MAZE7TwTdAy1; Mon, 22 Apr 2024 06:47:36 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 54B2B205CF;
	Mon, 22 Apr 2024 06:47:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 54B2B205CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1713761256;
	bh=VucgeYEgJCZCf20uX8QlWSex1gHIUBbLAuqe/GTo7Iw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=XM6GIBehX/5XeVsjxMrprh/MduHynmIWY1T4OPr60qdNqTjT4EeDjPeArVf51g0MK
	 9KN5tMUXrQm5tmzlS5Fw+B+5spA0AWan9RYM8gL1Z5PhqVA2oElOP54dYLxS9uueNq
	 GGl65Vpcltxf1CdYu9JeuOXJ7ESXYYRPvVQVNwvi2yPQ+S7VTHkNz31sa0uJoDQQJ9
	 CL6m810NaS2J0JShCUIlzL/TnaqhhO3iLqPVB36tEFxl10J1mr2knFDj3qQCC3G/rm
	 +Uw66msGcKxzd1dgQvPwpot5GxElP2bDcM9bTDI6btk7+F2swa/Ui6opNOsQ3cS3kM
	 KILxHUsc/T9hQ==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 4611080004A;
	Mon, 22 Apr 2024 06:47:36 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 06:47:36 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 22 Apr
 2024 06:47:35 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 7042B3183F3E; Mon, 22 Apr 2024 06:47:35 +0200 (CEST)
Date: Mon, 22 Apr 2024 06:47:35 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Antony Antony <antony.antony@secunet.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>,
	Florian Westphal <fw@strlen.de>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Andreas Gruenbacher <agruenba@redhat.com>,
	<devel@linux-ipsec.org>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH ipsec-next v3] udpencap: Remove Obsolete
 UDP_ENCAP_ESPINUDP_NON_IKE Support
Message-ID: <ZiXr5z/wsoQhmOGq@gauss3.secunet.de>
References: <ZhkgFE93hIGF1gxM@moon.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZhkgFE93hIGF1gxM@moon.secunet.de>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)

On Fri, Apr 12, 2024 at 01:50:44PM +0200, Antony Antony wrote:
> The UDP_ENCAP_ESPINUDP_NON_IKE mode, introduced into the Linux kernel
> in 2004 [2], has remained inactive and obsolete for an extended period.
> 
> This mode was originally defined in an early version of an IETF draft
> [1] from 2001. By the time it was integrated into the kernel in 2004 [2],
> it had already been replaced by UDP_ENCAP_ESPINUDP [3] in later
> versions of draft-ietf-ipsec-udp-encaps, particularly in version 06.
> 
> Over time, UDP_ENCAP_ESPINUDP_NON_IKE has lost its relevance, with no
> known use cases.
> 
> With this commit, we remove support for UDP_ENCAP_ESPINUDP_NON_IKE,
> simplifying the codebase and eliminating unnecessary complexity.
> Kernel will return an error -ENOPROTOOPT if the userspace tries to set
> this option.
> 
> References:
> [1] https://datatracker.ietf.org/doc/html/draft-ietf-ipsec-udp-encaps-00.txt
> 
> [2] Commit that added UDP_ENCAP_ESPINUDP_NON_IKE to the Linux historic
>     repository.
> 
>     Author: Andreas Gruenbacher <agruen@suse.de>
>     Date: Fri Apr 9 01:47:47 2004 -0700
> 
>    [IPSEC]: Support draft-ietf-ipsec-udp-encaps-00/01, some ipec impls need it.
> 
> [3] Commit that added UDP_ENCAP_ESPINUDP to the Linux historic
>     repository.
> 
>     Author: Derek Atkins <derek@ihtfp.com>
>     Date: Wed Apr 2 13:21:02 2003 -0800
> 
>     [IPSEC]: Implement UDP Encapsulation framework.
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>

Applied, thanks Antony!

