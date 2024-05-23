Return-Path: <netdev+bounces-97748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA668CCFCD
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 12:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015AE283F8D
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 10:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C8D13A889;
	Thu, 23 May 2024 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="jHtuSe86"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CCD54FA9
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458427; cv=none; b=CU+aeBricn3qkfmQEg6ZxUID4eTXTEY+u/Q0lTB0wK3S1oV4cdz+8+vItweCVHIRJXIVd7ODiZ9P/HR96gQCy1vFSjfXzkfWbVJfCqUvlz/Oh8byG2PxxQEaRf6uXFxlxL4mLZP2aO3Xh5kqy78vQJKrEP9ncLiNZSIiGiDW7bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458427; c=relaxed/simple;
	bh=jbzb8EecR0h+uG0IJgc8p0NE5cg5yTP5Sx/LfBad2w0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWBYmLhFXmw1+suhLCHR2xAfYbXxJSw1tgDO6MOGknD1gw1YVGvj6q0SHOx0DfQkdwq5cfx1/b/5VeJrkRs0bo4Ra3KeBUb98AEW7OQBP7yyYvVJBmhlwRJkvj4hQucBXi1SOQgEqHFiWQesCfoPSp4/60C3pMU5v/N0WrnpS3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=jHtuSe86; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 8D5FA207A4;
	Thu, 23 May 2024 12:00:15 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p3Of-5LP7DGZ; Thu, 23 May 2024 12:00:10 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id ADB6B2083E;
	Thu, 23 May 2024 12:00:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com ADB6B2083E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1716458410;
	bh=yMgjnC1uGRpxImTUjsnB4ErQ3r4WMNfPpF9PkdB3EO8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=jHtuSe86E2S8QgwKDBtlN2rbat/1AJ9pyiAk3Ozs18xT4ch1sfl/MiidI42qZ9p93
	 DhSkNv3CGrrTqfWW83MKqjkCOcFpW8hiwTODlUpWnh5h4V5cFbVNXNFK+Zx9EhXEaC
	 fs/IQzkyxUtkZeMSjlg4peTA5QxJXoh5A758Hv9fmdGClCznm4aMCuf9KULlBvyfq4
	 6Yg9Mc1ZLvHPxn8P0D6hZdfMDJXW88ZeNjHVlB+AktxLoeewEgJ/8JOPPoe+SCR69g
	 2Rtbb5Bgm2E/Nz/QT1jQ98WpHVGb2PL2KSEoymgl1t2XfRhLN8TvbjDxrsIiCrpDZA
	 EF+uMkpqVsQQA==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id A0F7380004A;
	Thu, 23 May 2024 12:00:10 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 12:00:10 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 May
 2024 12:00:10 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id CB03231805E4; Thu, 23 May 2024 12:00:09 +0200 (CEST)
Date: Thu, 23 May 2024 12:00:09 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jianbo Liu <jianbol@nvidia.com>
CC: Leon Romanovsky <leonro@nvidia.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"fw@strlen.de" <fw@strlen.de>
Subject: Re: [PATCH net] net: drop secpath extension before skb deferral free
Message-ID: <Zk8TqcngSL8aqNGI@gauss3.secunet.de>
References: <20240513100246.85173-1-jianbol@nvidia.com>
 <CANn89iLLk5PvbMa20C=eS0m=chAsgzY-fWnyEsp6L5QouDPcNg@mail.gmail.com>
 <be732cc7427e09500467e30dd09dac621226568f.camel@nvidia.com>
 <CANn89i+BGcnzJutnUFm_y-Xx66gBCh0yhgq_umk5YFMuFf6C4g@mail.gmail.com>
 <14d383ebd61980ecf07430255a2de730257d3dde.camel@nvidia.com>
 <Zk28Lg9/n59Kdsp1@gauss3.secunet.de>
 <4d6e7b9c11c24eb4d9df593a9cab825549dd02c2.camel@nvidia.com>
 <Zk7l6MChwKkjbTJx@gauss3.secunet.de>
 <d81de210f0f4a37f07cc5b990c41c11eb5281780.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d81de210f0f4a37f07cc5b990c41c11eb5281780.camel@nvidia.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, May 23, 2024 at 06:57:25AM +0000, Jianbo Liu wrote:
> On Thu, 2024-05-23 at 08:44 +0200, Steffen Klassert wrote:
> > On Thu, May 23, 2024 at 02:22:38AM +0000, Jianbo Liu wrote:
> > > On Wed, 2024-05-22 at 11:34 +0200, Steffen Klassert wrote:
> > > > 
> > > > Maybe we should directly remove the device from the xfrm_state
> > > > when the decice goes down, this should catch all the cases.
> > > > 
> > > > I think about something like this (untested) patch:
> > > > 
> > > > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > > > index 0c306473a79d..ba402275ab57 100644
> > > > --- a/net/xfrm/xfrm_state.c
> > > > +++ b/net/xfrm/xfrm_state.c
> > > > @@ -867,7 +867,11 @@ int xfrm_dev_state_flush(struct net *net,
> > > > struct
> > > > net_device *dev, bool task_vali
> > > >                                 xfrm_state_hold(x);
> > > >                                 spin_unlock_bh(&net-
> > > > > xfrm.xfrm_state_lock);
> > > >  
> > > > -                               err = xfrm_state_delete(x);
> > > > +                               spin_lock_bh(&x->lock);
> > > > +                               err = __xfrm_state_delete(x);
> > > > +                               xfrm_dev_state_free(x);
> > > > +                               spin_unlock_bh(&x->lock);
> > > > +
> > > >                                 xfrm_audit_state_delete(x, err ? 0
> > > > :
> > > > 1,
> > > >                                                         task_valid)
> > > > ;
> > > >                                 xfrm_state_put(x);
> > > > 
> > > > The secpath is still attached to all skbs, but the hang on device
> > > > unregister should go away.
> > > 
> > > It didn't fix the issue.
> > 
> > Do you have a backtrace of the ref_tracker?
> > 
> > Is that with packet offload?
> > 
> 
> Yes. And it's the same trace I posted before.
> 
>  ref_tracker: eth%d@000000007421424b has 1/1 users at
>       xfrm_dev_state_add+0xe5/0x4d0

Hm, interesting.

Can you check if xfrm_dev_state_free() is triggered in that codepath
and if it actually removes the device from the states?


