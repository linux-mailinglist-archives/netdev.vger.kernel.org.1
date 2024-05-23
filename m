Return-Path: <netdev+bounces-97696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AAD8CCC68
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 08:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7972838D8
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 06:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD6313C82D;
	Thu, 23 May 2024 06:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="oypN2mHm"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962F713C69A
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 06:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716446707; cv=none; b=iDMsO9lQBNvOEOFCx0QJdbE69NhGICJ5eRv/gg4qepMICVs2aJRgWNgEk5SinKeCBhGEvWjRdSXB2krHWldNKBxpxB6S/O50awzFVUAN80GhDQqGwPeoJGLD8H5LCPrl6Fni2TK7N6P7h6FwcVr9MkiVPZHHBWfyPB+zKOfksIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716446707; c=relaxed/simple;
	bh=EM8a77A2iiFqyEnlYVvRUbtWs6By5icLa68Sa/dY1sg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8wV42NgYdhoOfhgnKbCNG6j4bp8zM0eRHGKDa9jADykMAXoQLEzYz2GYe1JlJDLdnxCMa9Ute/DKu4Aget5oJMvH5204jznGDVUfAZepKbxU+RkchYw1EYwUBA7VhU/HfB5iP5Mnn8Dx+dcWT96A+g6vYPuU9LsOXdCJiZL2GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=oypN2mHm; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 9D62520854;
	Thu, 23 May 2024 08:44:57 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d9qEVe9sUX4c; Thu, 23 May 2024 08:44:57 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 11EFC2083B;
	Thu, 23 May 2024 08:44:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 11EFC2083B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1716446697;
	bh=2V/wG8w0jyt+Fah1IaXk36eL0w8oceM2xybCoa0vqaM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=oypN2mHmLuCKODOHbgC/WCs56Vf7c+yJSP0BtFABuyaHMOLvPm23fOESmuoeTbc3+
	 xq/gdalqAOZwhiYsPmGXTQ/24xLeHex+szmr2aTi5Ej3EKzIErI2542APnijTYOIEV
	 9xGrMQOOIrzS7mX0DtLv061K9tnG6oa8lF5SLqX5uHZE+hFQfIEF/b3c49hZemPHDI
	 XbxNT3ybDB0wdv9Y/Pa9UVUTOWsFlTL4eXQZWI5YW6AemFu5F+IpRfEiwLAc+wlMUC
	 LIUa5Ef1qManQZ0/XiuCivxLGD8HxzpIK7b3JTe1dZihAJ4rw2eZ9PHytMxq583+B+
	 wX+Aicpvms2XA==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 01EDB80004A;
	Thu, 23 May 2024 08:44:56 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 08:44:56 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 May
 2024 08:44:56 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 1CB133180A0F; Thu, 23 May 2024 08:44:56 +0200 (CEST)
Date: Thu, 23 May 2024 08:44:56 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jianbo Liu <jianbol@nvidia.com>
CC: Leon Romanovsky <leonro@nvidia.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"fw@strlen.de" <fw@strlen.de>
Subject: Re: [PATCH net] net: drop secpath extension before skb deferral free
Message-ID: <Zk7l6MChwKkjbTJx@gauss3.secunet.de>
References: <20240513100246.85173-1-jianbol@nvidia.com>
 <CANn89iLLk5PvbMa20C=eS0m=chAsgzY-fWnyEsp6L5QouDPcNg@mail.gmail.com>
 <be732cc7427e09500467e30dd09dac621226568f.camel@nvidia.com>
 <CANn89i+BGcnzJutnUFm_y-Xx66gBCh0yhgq_umk5YFMuFf6C4g@mail.gmail.com>
 <14d383ebd61980ecf07430255a2de730257d3dde.camel@nvidia.com>
 <Zk28Lg9/n59Kdsp1@gauss3.secunet.de>
 <4d6e7b9c11c24eb4d9df593a9cab825549dd02c2.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d6e7b9c11c24eb4d9df593a9cab825549dd02c2.camel@nvidia.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, May 23, 2024 at 02:22:38AM +0000, Jianbo Liu wrote:
> On Wed, 2024-05-22 at 11:34 +0200, Steffen Klassert wrote:
> > 
> > Maybe we should directly remove the device from the xfrm_state
> > when the decice goes down, this should catch all the cases.
> > 
> > I think about something like this (untested) patch:
> > 
> > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > index 0c306473a79d..ba402275ab57 100644
> > --- a/net/xfrm/xfrm_state.c
> > +++ b/net/xfrm/xfrm_state.c
> > @@ -867,7 +867,11 @@ int xfrm_dev_state_flush(struct net *net, struct
> > net_device *dev, bool task_vali
> >                                 xfrm_state_hold(x);
> >                                 spin_unlock_bh(&net-
> > >xfrm.xfrm_state_lock);
> >  
> > -                               err = xfrm_state_delete(x);
> > +                               spin_lock_bh(&x->lock);
> > +                               err = __xfrm_state_delete(x);
> > +                               xfrm_dev_state_free(x);
> > +                               spin_unlock_bh(&x->lock);
> > +
> >                                 xfrm_audit_state_delete(x, err ? 0 :
> > 1,
> >                                                         task_valid);
> >                                 xfrm_state_put(x);
> > 
> > The secpath is still attached to all skbs, but the hang on device
> > unregister should go away.
> 
> It didn't fix the issue.

Do you have a backtrace of the ref_tracker?

Is that with packet offload?

Looks like we need to remove the device from the xfrm_policy
too if packet offload is used.

