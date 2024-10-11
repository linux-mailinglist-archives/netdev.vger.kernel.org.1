Return-Path: <netdev+bounces-134513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEED999EE6
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 10:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3AE3281D3F
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 08:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B97209F58;
	Fri, 11 Oct 2024 08:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ahZHGrWl"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EA120A5D9
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728634952; cv=none; b=JxIhScPa0pddC2gO/UpTUyrQSvyiMA98BinT54ACU3jGiP5V+dhGCY7ahOBfNm0CXXp4+bgZa3XTdiDYULh5q/vnSkw0nVoCqEIUfFQ6h3bdUET9AwGUhHUrBZ7Aqzu2F9H7LXOJH9+PPz/X1GHbW6yWQUuUk6avqe9L3FyN5T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728634952; c=relaxed/simple;
	bh=gTP/Bb2A2MMHLLkWVlXmt1GY9vL0pTKI2t42qOIi6UM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0KQ5FDmXr7J/wbt+XNZ3+5MZiL1ZhTf73vVdkatSwcN+TSonsVbe46IpsUDukfC3sUsfCVumf5jqa40gqzE5aR80DvAlRRh2blaqM2XoP9X3HtaJbj4BNmmVcmf8dY55RW5IEvus+dd2YXbdKk7B22e8XtkFMr/5Ze8FW616KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ahZHGrWl; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 744BA20897;
	Fri, 11 Oct 2024 10:22:27 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T9s5ZZ4oS8P2; Fri, 11 Oct 2024 10:22:26 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 8F2B320885;
	Fri, 11 Oct 2024 10:22:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 8F2B320885
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1728634946;
	bh=dU2tTew089bkg/e/CgiwN5TT5GoXdcylY1mpCuta6e8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=ahZHGrWlkqtYRTA1OJHdg9+hOEVP0GkKUHh0rFHJPSnXpm3tiB200l4sl/SZ6dlbN
	 GlG3dX5/0gY0lONmZspd2A5+z3uqWdMzyKCn7QQe9kAHHXKTnz9AuLN1C7IIAP0BEG
	 3zRpcJpKHotWtXdqkIju3mhO20zH4roAvj6KRbuaAmSzky2UzWDb6iSlDmWFcxPu0u
	 jdpVifonP1SUboISkjoGq8wBnLKE50xUymrH5BL12/hkWyJ43IFD/2LLBA0TEL/J8Q
	 E2gvrzmTUpxP3SDZKKdw6A7xxrkRmOm9szuVqy3hBSyp/pAXKidT4pSOb1T0Gt1cp7
	 /Y2us5VWRjbvw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 10:22:26 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Oct
 2024 10:22:26 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id E5AC7318415A; Fri, 11 Oct 2024 10:22:25 +0200 (CEST)
Date: Fri, 11 Oct 2024 10:22:25 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Simon Horman <horms@kernel.org>
CC: Tobias Brunner <tobias@strongswan.org>, Antony Antony
	<antony.antony@secunet.com>, Daniel Xu <dxu@dxuuu.xyz>, Paul Wouters
	<paul@nohats.ca>, Sabrina Dubroca <sd@queasysnail.net>,
	<netdev@vger.kernel.org>, <devel@linux-ipsec.org>
Subject: Re: [PATCH 1/4] xfrm: Add support for per cpu xfrm state handling.
Message-ID: <ZwjgQbD+l91PIbkt@gauss3.secunet.de>
References: <20241007064453.2171933-1-steffen.klassert@secunet.com>
 <20241007064453.2171933-2-steffen.klassert@secunet.com>
 <20241008164726.GD99782@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241008164726.GD99782@kernel.org>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Oct 08, 2024 at 05:47:26PM +0100, Simon Horman wrote:
> On Mon, Oct 07, 2024 at 08:44:50AM +0200, Steffen Klassert wrote:
> > Currently all flows for a certain SA must be processed by the same
> > cpu to avoid packet reordering and lock contention of the xfrm
> > state lock.
> > 
> > To get rid of this limitation, the IETF is about to standardize
> > per cpu SAs. This patch implements the xfrm part of it:
> > 
> > https://datatracker.ietf.org/doc/draft-ietf-ipsecme-multi-sa-performance/
> > 
> > This adds the cpu as a lookup key for xfrm states and a config option
> > to generate acquire messages for each cpu.
> > 
> > With that, we can have on each cpu a SA with identical traffic selector
> > so that flows can be processed in parallel on all cpu.
> > 
> > Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> 
> ...
> 
> > @@ -2521,6 +2547,7 @@ static inline unsigned int xfrm_aevent_msgsize(struct xfrm_state *x)
> >  	       + nla_total_size(4) /* XFRM_AE_RTHR */
> >  	       + nla_total_size(4) /* XFRM_AE_ETHR */
> >  	       + nla_total_size(sizeof(x->dir)); /* XFRMA_SA_DIR */
> > +	       + nla_total_size(4); /* XFRMA_SA_PCPU */
> 
> Hi Steffen,
> 
> It looks like the ';' needs to be dropped from the x->dir line.
> (Completely untested!)
> 
> 	       + nla_total_size(sizeof(x->dir)) /* XFRMA_SA_DIR */
> 	       + nla_total_size(4); /* XFRMA_SA_PCPU */

Uhm, yes apparently!

Fixed now, thanks!


