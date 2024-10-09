Return-Path: <netdev+bounces-133790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CD5997095
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B47D1C21131
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632661E284D;
	Wed,  9 Oct 2024 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXTjl7jR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE221E2840;
	Wed,  9 Oct 2024 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488789; cv=none; b=GZY6hF0d3s6ozRAua7tnwp2t+EHZvKQevNWu5dnyCJ0hRQPhwBd+NqoQ2P66xggwfjtGyP50V+20yv8pl2/eXuovZC9XZDq9TASgzoIWejPfgYovwiRZAo0QNV43bognnwnSJJPrpUNEnwwJ9KJJAmy+8n9mOWlpZc9OmOju+lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488789; c=relaxed/simple;
	bh=mz0QdF/TZzuddFxlTtqYPaUx4gBrjjJi0C8a7WuVOXc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/eg1DAHLkusny6AozBqBHy/daqbOJPrMpmMwyka7pbMdTFtN73CRquDjW7WINVENyP7bVUSg5kS8L5wWBvEQN4OMtTx/GVTCuQ4byWf0uVxnD8diGseJHEZ7ZLUrNGWZUPqudPrdpKoMdzwB6f9N4t+w8+7njdgxG2lf7LYOlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXTjl7jR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B70C4CEC3;
	Wed,  9 Oct 2024 15:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728488788;
	bh=mz0QdF/TZzuddFxlTtqYPaUx4gBrjjJi0C8a7WuVOXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oXTjl7jRub0Xfkc1dNAwi5Ne068xwLuzwJwzqXwcEmAVp/F3M9zYyzDTsToVYvsla
	 rgRY4jIxhoiv9x3GhovJmBiusxhSyQRw+S21ADrlzRAzIYyqabFBiHqtzKtlsQxOE7
	 tFt0qWTJ3V3EfwWOVU4tdyoZJIZUEgGY1tP3Cno+K6ncGKJlRcA1syKWyu2FnRwY7b
	 KxGoD/105e11tTmy5xzG7uJnTGowhLdwJJSG8mqFM7kUxb9KUi4V3USll8hHTVpOwL
	 0F441FzBWx12ouFBDZ4WiYBwBdSR1NekdHpEa4fB6kLGIGhRzwgzlfVxWt3ke7+7NN
	 aX9Hk0T7IRKrw==
Date: Wed, 9 Oct 2024 08:46:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 almasrymina@google.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com,
 kory.maincent@bootlin.com, andrew@lunn.ch, maxime.chevallier@bootlin.com,
 danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com,
 asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com,
 aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com,
 bcreeley@amd.com
Subject: Re: [PATCH net-next v3 3/7] net: ethtool: add support for
 configuring tcp-data-split-thresh
Message-ID: <20241009084626.0e0d6780@kernel.org>
In-Reply-To: <CAMArcTXvMi_QWsYFgt8TJcQQz6=edoGs3-5th=4mKaHO_X+hhQ@mail.gmail.com>
References: <20241003160620.1521626-1-ap420073@gmail.com>
	<20241003160620.1521626-4-ap420073@gmail.com>
	<20241008113314.243f7c36@kernel.org>
	<CAMArcTXvMi_QWsYFgt8TJcQQz6=edoGs3-5th=4mKaHO_X+hhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Oct 2024 23:25:55 +0900 Taehee Yoo wrote:
> > > The tcp-data-split is not enabled, the tcp-data-split-thresh will
> > > not be used and can't be configured.
> > >
> > >    # ethtool -G enp14s0f0np0 tcp-data-split off
> > >    # ethtool -g enp14s0f0np0
> > >    Ring parameters for enp14s0f0np0:
> > >    Pre-set maximums:
> > >    ...
> > >    TCP data split thresh:  256
> > >    Current hardware settings:
> > >    ...
> > >    TCP data split:         off
> > >    TCP data split thresh:  n/a  
> >
> > My reply to Sridhar was probably quite unclear on this point, but FWIW
> > I do also have a weak preference to drop the "TCP" from the new knob.
> > Rephrasing what I said here:
> > https://lore.kernel.org/all/20240911173150.571bf93b@kernel.org/
> > the old knob is defined as being about TCP but for the new one we can
> > pick how widely applicable it is (and make it cover UDP as well).  
> 
> I'm not sure that I understand about "knob".
> The knob means the command "tcp-data-split-thresh"?
> If so, I would like to change from "tcp-data-split-thresh" to
> "header-data-split-thresh".

Sounds good!

> > > +     if (tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH] &&
> > > +         !(ops->supported_ring_params & ETHTOOL_RING_USE_TCP_DATA_SPLIT)) {  
> >
> > here you use the existing flag, yet gve and idpf set that flag and will
> > ignore the setting silently. They need to be changed or we need a new
> > flag.  
> 
> Okay, I would like to add the ETHTOOL_RING_USE_TCP_DATA_SPLIT_THRESH flag.
> Or ETHTOOL_RING_USE_HDS_THRESH, which indicates header-data-split thresh.
> If you agree with adding a new flag, how do you think about naming it?

How about ETHTOOL_RING_USE_HDS_THRS ?

