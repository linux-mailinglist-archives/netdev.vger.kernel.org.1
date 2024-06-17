Return-Path: <netdev+bounces-104173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF7D90B694
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 18:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 853071C23038
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 16:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9E015F32E;
	Mon, 17 Jun 2024 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaY3HPq9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE62015D5CA
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642219; cv=none; b=g7EnnS+V135V4gEudeDqW6Z08cxYu1LUkzzWr1trtODlL1Sz3qZXfUOVskUJc1z2azgH5T5DTAtQkoJ7um5bUORl/XcdV1Xfgb3U+zbiY4E02i2lowrpxXoqFkzJVEllmQJwTFXrZxULgX7WPCbCjfaIsXOQSX4UasjVuZTp8Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642219; c=relaxed/simple;
	bh=cJlgDl4SV9gG2SSsILP1LUsRuyXWmMnNFSROKOXqyic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ls4iGywpuJvDE/YNB0JMUnSmjrP0yHIOkJ72pLGcV+RKO6ID7+ZwaQ/WL4D5KE63+nh7IpLnpWGQfFQuChgRgaIuy3EQW+Px/FMKuZrta01neVHeAUh7687DmIpRH+KQUmE9YII0bbpPXnpbJO7aNWb4girLHV1Uf4VX+k8qP6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaY3HPq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D40BC2BD10;
	Mon, 17 Jun 2024 16:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718642219;
	bh=cJlgDl4SV9gG2SSsILP1LUsRuyXWmMnNFSROKOXqyic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CaY3HPq98NqNrDxj6s0cruyPNXw9ZHlSGZuMzldKqoLDZZnxWMB4Sxg1p7Ey7PPCq
	 lO4TB6p10Stw73rPrFLSl4bg8Z1GmOdgdXf8mvhpgA2dPitsp/gWJkP/GevyecqQeX
	 kDzWbtXwcVk1qHKmeQ02KQOiyOyntpIylBAsnGtU/V8HRJ5fdiTw++VhncazCO+Ydf
	 nQV9y2kqC5VI6th1+0tjLA7hpK3cag/Np2a4UfPke2UlSpZR/+0Mu4rqi2XPxdPwMt
	 NlKBkv31qRFEsMwAYS7saXN3NFN51mddiheE9LYPhQJeSxDrubZ+j8mRfzFLY5INBs
	 Gg2O0Ot0t7xyw==
Date: Mon, 17 Jun 2024 09:36:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, Stefano Brivio <sbrivio@redhat.com>, dsahern@kernel.org,
 donald.hunter@gmail.com, Sabrina Dubroca <sdubroca@redhat.com>
Subject: Re: [PATCH net] inet: bring NLM_DONE out to a separate recv() again
Message-ID: <20240617093658.60998763@kernel.org>
In-Reply-To: <4b4f35b9-6419-49a4-b73e-5d02e3cbc69a@ovn.org>
References: <20240411180202.399246-1-kuba@kernel.org>
	<a25fa200-090f-456e-9885-fe25701dbd94@ovn.org>
	<4b4f35b9-6419-49a4-b73e-5d02e3cbc69a@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jun 2024 17:09:44 +0200 Ilya Maximets wrote:
> > FWIW, on current net-next this fixes the issue with Libreswan and IPv4
> > (IPv6 issue remains, obviously).  I also did a round of other OVS system
> > tests and they worked fine.
> > 
> > Tested-by: Ilya Maximets <i.maximets@ovn.org>  
> 
> Hi, Jakub.  Now that IPv6 change is in 6.10-rc, do you plan to submit a similar
> fix for it as well?  (Sorry if I missed it.)  Libreswan is getting stuck on IPv6
> route lookups with 6.10-rc4.
> 
> Note: Libreswan fixed the issue on their main branch, but it is not available in
> any release yet, and I'm not sure if the fix is going to make it into stable
> releases.

Sorry for the delay, we'll get it resolved before this week's PR.

