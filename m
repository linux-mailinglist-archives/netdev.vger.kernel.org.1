Return-Path: <netdev+bounces-190175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2FFAB572A
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 16:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96DA4657E1
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 14:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E22D482F2;
	Tue, 13 May 2025 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNGP+l05"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A702EB1D
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747146618; cv=none; b=ZGmTFnWmylKakK8+rk62K/w0MKSyP3cWNj17ApwET8AaI2M9/B4oUMUmkUVsLp6fz7JediTL8GTaCLzqtSMh5Hjn5MODpDcJn22DpEZ+aUcbuFTN+vhugGimq+kBdmm1yP1Bi1szFOLJpStK5fc2MwFZm1lUhfIIUndT3UcN3hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747146618; c=relaxed/simple;
	bh=oAjlRC/vfVDcXLYdTYJhjRtCmuxC3JGUkrIUKrPnuLA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQ7Vc/cDb31T9KQeQQneGCnZoVktd/fcNKFzuK96pJu9QZHe+bhOVc+5BdOHvvBi4FNcZbf3EtmGI7qv+KRq7F/nd1gO79IKPCTKen6sXqbG+/Xmk4MVKzvSDD1Gl2iMOsZmRQ/CYjU9jTfKRpCB9OVxgxYT+o2zQ5+gKqtWjLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNGP+l05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE193C4CEE4;
	Tue, 13 May 2025 14:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747146617;
	bh=oAjlRC/vfVDcXLYdTYJhjRtCmuxC3JGUkrIUKrPnuLA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XNGP+l05u47e8zlOYR95Lfg+9//vr0qImL4gOkV1901LHFekoS44FHeyWpTgGQDX6
	 8BQiK2O2riEnq4NnFoezeo9baX86jiDgtexqUGPDZjoqpEZczFaAJvRt+Qp4CeZ8ft
	 +xUj7Sj396peLaas9Vs9lTC0oJakEfmNwuiz5k1dx/6jb3TbrgoSAi1Bx9M+0lUo8l
	 LTP9fvEC021rxIaAeIU6MAa0AH6N8fUrB9ercPltrYfx4xMdtioxEOIzS9QINUxgGO
	 4AtHhAmTL0rHYbuJaq7MovhCRLnHYGQRDSo1p+e325HG6LmlpgpBGhlcpqWXSc+zwU
	 hcJNqsBxqxQ3w==
Date: Tue, 13 May 2025 07:30:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, almasrymina@google.com, sdf@fomichev.me,
 netdev@vger.kernel.org, asml.silence@gmail.com, dw@davidwei.uk,
 skhawaja@google.com, kaiyuanz@google.com, jdamato@fastly.com
Subject: Re: [PATCH net v4] net: devmem: fix kernel panic when netlink
 socket close after module unload
Message-ID: <20250513073016.2ab40a90@kernel.org>
In-Reply-To: <CAMArcTXOS4z6v5c2JCdAVg0RKjnoovrftx=cjt-09RXp29NW3Q@mail.gmail.com>
References: <20250512084059.711037-1-ap420073@gmail.com>
	<20250512174442.28e6f7f6@kernel.org>
	<CAMArcTXOS4z6v5c2JCdAVg0RKjnoovrftx=cjt-09RXp29NW3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 12:24:52 +0900 Taehee Yoo wrote:
> > On Mon, 12 May 2025 08:40:59 +0000 Taehee Yoo wrote:  
> > > @@ -943,8 +943,6 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
> > >                       goto err_unbind;
> > >       }
> > >
> > > -     list_add(&binding->list, &priv->bindings);  
> >
> > Please leave this list_add() where it was.  
> 
> list_add() is moved to net_devmem_bind_dmabuf() by this patch.
> So, you mean that let's make net_devmem_{bind | unbind}_dmabuf()
> don't handle list themself like the v3 patch, right?

Not exactly like in v3. In v3 list_del() was moved. I think these moves
are due to cleanup which I requested earlier? There is no functional
need for these? I'm giving up on that cleanup request for now. 
Let's leave the list modifications where they are.

