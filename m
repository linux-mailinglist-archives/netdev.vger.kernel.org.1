Return-Path: <netdev+bounces-97521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 596B28CBDE1
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 11:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD3F1C20C76
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 09:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22ED7FBC1;
	Wed, 22 May 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="S5xQc9Ja"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448DB7D3F5
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716370486; cv=none; b=Fmi6rfMFBpdGpurs9TKd6jVq9sivR9FC1av1bC01uNmY5fb1Vlq5XjRTtVs/QBTbjnYAX072nn14fOlDsLBI14K2q0AN1jyoxiCCZtBJP1F9c8oWoJCFg8zYaUD/d/Ed6FyYB7tSQgc1US9lCeiL9WFyBi2XkrpD8yQYmgv9ZNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716370486; c=relaxed/simple;
	bh=CAnF5JYsV6Y19DaEhQjghUVLprSQY5iWRDUaAMcsNfo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1gj/on9xkP2u1dfULpfKMGn8zcdk86e8wbLEjMO6Uy35Ifh5cBWAiLsEpIklXl+FDnPwsWd2IJbp1jfwk6wwwYiKqgLQl7ZJ97RsW3+oHcA6IZ2GwcehOCYIm/gYFm99U3Et9k/mwl8QTqNqz0HqeEP+JanUuY03KsFhCvzxHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=S5xQc9Ja; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id DE21E2087B;
	Wed, 22 May 2024 11:34:40 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6sN_UPVIvTCp; Wed, 22 May 2024 11:34:40 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 26DFF20894;
	Wed, 22 May 2024 11:34:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 26DFF20894
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1716370479;
	bh=lsUAcm/dVINE800owia3xuxbXU2U+gwHr5DPQIaP2U0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=S5xQc9JaW2sSOGidfwMV6hjUDj9yBlgM9cmV9Qsb+WmrcZ/3kwyx/J6pzoOgrlW4F
	 EdA5ghXUrsS68ylPO5zpbmcQKPFBdDQSZSH5wPp/cIb8fJoYKZ57VzsD4PkoJLsGQF
	 2Rtrh8zp15zfYS0FkV+Tq6ZkQjUgRIT/bEH24tQIXyXeb+km5x96LZ3/1kN/tH1uJc
	 1hjE9Mj4V95W0M02AoaA39kUq7QR7G8yOrFlPLK0of0E61ylqHBPJjS4207N++hcZ7
	 Sajn6fzq+amlZ5HtsmU2RNeXjZBojS2qW+dFJ4A5JWNlWl3wCn5I8OWV+i5nFuWcXB
	 P9pdLC/kF0RSg==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 1998B80004A;
	Wed, 22 May 2024 11:34:39 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 11:34:38 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 22 May
 2024 11:34:38 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 64DE43181959; Wed, 22 May 2024 11:34:38 +0200 (CEST)
Date: Wed, 22 May 2024 11:34:38 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jianbo Liu <jianbol@nvidia.com>
CC: "edumazet@google.com" <edumazet@google.com>, Leon Romanovsky
	<leonro@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"fw@strlen.de" <fw@strlen.de>
Subject: Re: [PATCH net] net: drop secpath extension before skb deferral free
Message-ID: <Zk28Lg9/n59Kdsp1@gauss3.secunet.de>
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
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14d383ebd61980ecf07430255a2de730257d3dde.camel@nvidia.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, May 20, 2024 at 10:06:24AM +0000, Jianbo Liu wrote:
> On Tue, 2024-05-14 at 10:51 +0200, Eric Dumazet wrote:
> > On Tue, May 14, 2024 at 9:37 AM Jianbo Liu <jianbol@nvidia.com>
> > wrote:
> > > 
> > > On Mon, 2024-05-13 at 12:29 +0200, Eric Dumazet wrote:
> > > > On Mon, May 13, 2024 at 12:04 PM Jianbo Liu <jianbol@nvidia.com>
> > > > wrote:
> > > > 
> > > > 
> ...
> > > > This attribution and patch seem wrong. Also you should CC XFRM
> > > > maintainers.
> > > > 
> > > > Before being freed from tcp_recvmsg() path, packets can sit in
> > > > TCP
> > > > receive queues for arbitrary amounts of time.
> > > > 
> > > > secpath_reset() should be called much earlier than in the code
> > > > you
> > > > tried to change.
> > > 
> > > Yes, this also fixed the issue if I moved secpatch_reset() before
> > > tcp_v4_do_rcv().
> > > 
> > > --- a/net/ipv4/tcp_ipv4.c
> > > +++ b/net/ipv4/tcp_ipv4.c
> > > @@ -2314,6 +2314,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
> > >         tcp_v4_fill_cb(skb, iph, th);
> > > 
> > >         skb->dev = NULL;
> > > +       secpath_reset(skb);
> > > 
> > >         if (sk->sk_state == TCP_LISTEN) {
> > >                 ret = tcp_v4_do_rcv(sk, skb);
> > > 
> > > Do you want me to send v2, or push a new one if you agree with this
> > > change?
> > 
> > That would only care about TCP and IPv4.
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
> Should I add new function to reset both ct and secpath, and replace
> nf_reset_ct() where necessary on receive flow?

Maybe we should directly remove the device from the xfrm_state
when the decice goes down, this should catch all the cases.

I think about something like this (untested) patch:

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 0c306473a79d..ba402275ab57 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -867,7 +867,11 @@ int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_vali
 				xfrm_state_hold(x);
 				spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 
-				err = xfrm_state_delete(x);
+				spin_lock_bh(&x->lock);
+				err = __xfrm_state_delete(x);
+				xfrm_dev_state_free(x);
+				spin_unlock_bh(&x->lock);
+
 				xfrm_audit_state_delete(x, err ? 0 : 1,
 							task_valid);
 				xfrm_state_put(x);

The secpath is still attached to all skbs, but the hang on device
unregister should go away.

