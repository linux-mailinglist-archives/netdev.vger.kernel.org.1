Return-Path: <netdev+bounces-197510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB54AD8FBD
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 16:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827781892E2D
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED8D194A6C;
	Fri, 13 Jun 2025 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxLzpo4s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93E91946AA
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749825568; cv=none; b=RQWK7YMg86cDBK56SfbvCYe7ecMeIOT7bDb4ZW5XrZWhrxe3ktZRYDmkrFSBlp6Sv3nLIZ6D7Ml6wlYrmGiZaacD368ae3m9wbepQgg/uYBLrmts+FUjNGW/bIlhGvgVyUWDGvfPzXgtHToVNFQry5aMYTHtqVVSv5Yyt0hh/0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749825568; c=relaxed/simple;
	bh=+w3S/HSojl2FG2GOXJiUVDwemMBlDWRwO7nVEFoxtu0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ok55PMCPEJ7fFSorfuEsxEvpMdCkZqP0SLII7BawAT/Iqe0sCU82SAeDBN83F/nQ3lH/3BTUq1dOcOxwlnv2eiPAGyU4dI3RXwUTMG5Ezy9HDDSaudIBYm84GEIN8tCRI+IP5xKZ59u7LeHlB1E2aOpPfdZ13edOGrFtrgvsz/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxLzpo4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07165C4CEE3;
	Fri, 13 Jun 2025 14:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749825568;
	bh=+w3S/HSojl2FG2GOXJiUVDwemMBlDWRwO7nVEFoxtu0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NxLzpo4sVOytcGnbRxhF5VrZafGSUtbiRqVKB3TVhYAWeo0VJGAS99fDZUqqfw/qx
	 sn0vMAgWyvZhiOcrLeRAsLiOE2FAk12CoO2Q54OcAGOZAhWQclISkzwL7bUM5VamHS
	 O4ZjU409dHiC+X6mvXkNn6GT5NVDuwQaT9fJM6IIRP9jAhIpLnFK3TLUosSUuof99s
	 mL699ngmIq9ZTOahUpWQb7K0gGpLvAC71vUHUEd3jgrlitycZYq276CnpAxSfE7KsM
	 03nDeFgTnkq7AmFJvL4LUkr6CSJmv7eSqt6z7o93Ll1JbvC0Wsoxawo13DXi0Pc+Mo
	 kaRNrd0iIQwTQ==
Date: Fri, 13 Jun 2025 07:39:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 ecree.xilinx@gmail.com, andrew@lunn.ch
Subject: Re: [PATCH net-next 4/9] net: ethtool: add dedicated callbacks for
 getting and setting rxfh fields
Message-ID: <20250613073927.27e92d3b@kernel.org>
In-Reply-To: <aEu4zx_dsc2FCdpu@MacBook-Air.local>
References: <20250611145949.2674086-1-kuba@kernel.org>
	<20250611145949.2674086-5-kuba@kernel.org>
	<aEu4zx_dsc2FCdpu@MacBook-Air.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 08:36:15 +0300 Joe Damato wrote:
> > @@ -1492,7 +1527,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
> >  	u8 *rss_config;
> >  	int ret;
> >  
> > -	if (!ops->get_rxnfc || !ops->set_rxfh)
> > +	if ((!ops->get_rxnfc && !ops->get_rxfh_fields) || !ops->set_rxfh)
> >  		return -EOPNOTSUPP;  
> 
> I realize I am late to the thread, but is this part above correct? It seems
> like ethtool_set_rxfh calls ops->get_rxnfc but not ops->get_rxfh_fields,
> unless I missed something in an earlier patch?

It calls ethtool_check_flow_types(), but you're right it also calls
->get_rxnfc, so it should have been an ||. I'll correct in the "closing
patch" that removes the calls to get_rxnfc once all drivers are done.
Thanks!

