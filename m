Return-Path: <netdev+bounces-110429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966B992C49F
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 22:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33934B21B25
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 20:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2A614F9C5;
	Tue,  9 Jul 2024 20:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9DtBC9s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E2A13C8EA;
	Tue,  9 Jul 2024 20:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557445; cv=none; b=B3nUdFTF/sLWU+fxmtEM9sBUOVo6536HgxBlLqVY4OayFVPJHdoFaIgSPQLYuPegEP0+QTjPQ92k0oHrvDZstyvcfZBGz+3eOf/y9HZP9B5NWbqz4Tdy08+Dp3cTD4Apq1nVAA+ao0ZE+LrhkTgYpOiP3TKanu1PzPgDSEkPWgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557445; c=relaxed/simple;
	bh=eK+ElAZ3HYE+YOrVt86IwYpztcjk8MJ4RaWg/ldd9Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiKZh2pzF018ePYYCGqwr7NW6YMB6FN5+gmVQzbPELU6544QZXyQVZZc7wfPucnqYWuHWHnx+g9Xg7NXBlkSvJ5h7Rvxq0RnGduMimY313TIdTQ604PbKxauCwy1O53ZEV1P5XD6Ya5qLDe5k5EwpLqDcTUe2uD4V2zv00N2ldU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9DtBC9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B87C3277B;
	Tue,  9 Jul 2024 20:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720557443;
	bh=eK+ElAZ3HYE+YOrVt86IwYpztcjk8MJ4RaWg/ldd9Cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U9DtBC9srjnRK0WtbLFP7KzD/PxN/xKQOSTV0VrYbYP57KmGsPBmsqSDhak0Mc+bC
	 LQbkUnQAiW6aicKldsxTDDpncBMP8lsjiLvi8cK7t/Rrsugam4nZV1oOCNhjnM1uYj
	 RljnWAlgEH1wTb7t4xHNyXX4OD5gcl9augH+y6JWEW7JF7SDYMLgn32H6CSvFSq4cW
	 RkPMvBbPy/RqK2EarHe+gk9/w1/bu9XWu5fmgunD64hJzqDgskHA3djuBeuE2HJgLV
	 1q7Rb/njZnhbths+sxqiiJH+ynPiS2zTo9sVfSKrnpIQsxjDy5NrQcejJzG2dTgzHJ
	 84BfqBGl+MKKA==
Date: Tue, 9 Jul 2024 13:37:23 -0700
From: Kees Cook <kees@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	linux-hardening@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] netdevice: define and allocate &net_device
 _properly_
Message-ID: <202407091334.A7BAB27@keescook>
References: <20240709125433.4026177-1-leitao@debian.org>
 <20240709181128.GO346094@kernel.org>
 <Zo2bYCAVQaViN6z8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo2bYCAVQaViN6z8@gmail.com>

On Tue, Jul 09, 2024 at 01:19:44PM -0700, Breno Leitao wrote:
> On Tue, Jul 09, 2024 at 07:11:28PM +0100, Simon Horman wrote:
> > Flagged by: kernel-doc -none
> 
> How do you run this test exactly? I would like to add to my workflow.

Details here:
https://docs.kernel.org/doc-guide/kernel-doc.html

But basically, either:

$ ./scripts/kernel-doc -none include/linux/netdevice.h
include/linux/netdevice.h:2404: warning: ...

or:

$ make ... W=n
...
../drivers/firewire/init_ohci1394_dma.c:178: warning: Function parameter or struct member 'ohci' not described in 'init_ohci1394_wait_for_busresets'
...

-- 
Kees Cook

