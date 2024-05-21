Return-Path: <netdev+bounces-97316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8634E8CAC0F
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 12:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2488F1F21445
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 10:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45446E2AE;
	Tue, 21 May 2024 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="mxujZo5+"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36606D1BC
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716286568; cv=none; b=jOoB+Zc+jO55QTugEqUxqZv6C4lepRWD0XlJbpA1XkQOd+zK2yTJ0tMj1d6e30YgHtFKvoA8ZdBa70nVahdLPOhBWMq3g1OAlN4pAu9B+WNilClVTaXbZMMZF+D3yBOjTco5Z+wzbXfeorL1r+oBckF1rCbGXfiDPqBb7l3OTcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716286568; c=relaxed/simple;
	bh=BDKk5qD6rzPsRyQ9L2OvSHS9V4jAU+X+H8YA+cTwOrE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQi1+1B0DoCsxzLSJMCon15vRejHWguJIWZ6Z4Zcw1SUAGqweJIfr9DyTERJB6ZbnHVeCIGoOmJ6GE5IfKr5QdHYDMyHxvpqSfPo2tIqKji/Yjmh8W33ojyEU9aTmwzixqehHsWJ6blsbkrSWD3fxo2c5mgceEI/bDkdo5LdoVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=mxujZo5+; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E912B2076B;
	Tue, 21 May 2024 12:15:56 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y_sFLTS4qn53; Tue, 21 May 2024 12:15:52 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 1CA66206DF;
	Tue, 21 May 2024 12:15:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 1CA66206DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1716286552;
	bh=VqQzmxYzPp0D3hrnjRIJFjpxF3BQAPjuW3OEFfyH1dY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=mxujZo5+K0CymT4Bv96mvu2FdNhEo7JkhS6D7iTR96R9pP33K6fxrbJ+nPzHnAS/w
	 9TfOd0rXya/XJyXbm0vewgGGDWOYGm9/m64bqHqtrxctFRyTOFA4sr/n9OSuPG0s0g
	 YPcdM5nN0TZ7qSaHKc9wNEArPmrv+J2bbVUkbdmNEkjCArI7hM/QolBg2TK6bAKqmq
	 u4s9m3dLJviMDhuFuH+KKFaTkhqlCopHbBinfLS7A49TTnmFAwetvrTG9mcnd4NJpH
	 vbGtH6AUk8t5csNY+YmWzqtDJL13u1oiSVy8v/n+o22meccyGrlBQT7GPHaXzXQ7hN
	 Fa/dPs1C9WXVg==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 0FBCF80004A;
	Tue, 21 May 2024 12:15:52 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 12:15:51 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 May
 2024 12:15:51 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 4594031810D7; Tue, 21 May 2024 12:15:51 +0200 (CEST)
Date: Tue, 21 May 2024 12:15:51 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jianbo Liu <jianbol@nvidia.com>
CC: "edumazet@google.com" <edumazet@google.com>, Leon Romanovsky
	<leonro@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"fw@strlen.de" <fw@strlen.de>
Subject: Re: [PATCH net] net: drop secpath extension before skb deferral free
Message-ID: <Zkx0V2nUonltp/pR@gauss3.secunet.de>
References: <20240513100246.85173-1-jianbol@nvidia.com>
 <CANn89iLLk5PvbMa20C=eS0m=chAsgzY-fWnyEsp6L5QouDPcNg@mail.gmail.com>
 <be732cc7427e09500467e30dd09dac621226568f.camel@nvidia.com>
 <CANn89i+BGcnzJutnUFm_y-Xx66gBCh0yhgq_umk5YFMuFf6C4g@mail.gmail.com>
 <14d383ebd61980ecf07430255a2de730257d3dde.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14d383ebd61980ecf07430255a2de730257d3dde.camel@nvidia.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, May 20, 2024 at 10:06:24AM +0000, Jianbo Liu wrote:
> On Tue, 2024-05-14 at 10:51 +0200, Eric Dumazet wrote:
> > 
> > I think we need a full fix, not a partial work around to an immediate
> > problem.
> > 
> > Can we have some feedback from Steffen, I  wonder if we missed
> > something really obvious.
> > 
> > It is hard to believe this has been broken for such  a long time.
> 
> Could you please give me some suggestions?

Sorry for the delay, I've just returned from vacation.

I'll have a look at it.

