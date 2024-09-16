Return-Path: <netdev+bounces-128486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D26979C8F
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 10:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B31E285AB0
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 08:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE806142621;
	Mon, 16 Sep 2024 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezh/4Cyq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92C913D2A9
	for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726474256; cv=none; b=d8rYCJCsUMdt2W1IpHMipBaflHXE4mYqNDtSCgJu9hwIzS4tOqNZA4wJXI4uGXgm4tv5eQCfiwaXC3VvUREJ3Qa00vgh3W3Cxz6EN5jSs1X6x7vdHf9BtcZFs4PCjcglpZOhWaRKrtkTiXD55BINa59bgU2jqJkbGbO02OvBrng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726474256; c=relaxed/simple;
	bh=i73Vneh9p83hoMPHxa7rCSnS2KtILe2PThtsUv5inyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=or/pRwhaAGq64fiSDHTGQdVswczZaTCi2m+I9SGF6QxfhF+mWjF4ctNWY6hETb4QSNETmlE1C9B22FJpsWpDAftJqPI24wuS+i4deuehTPDJ6mtp33LoJIRS6YKl8QGKpIvOJeLktft5iKe8793vwC2G+VpdXlXWkuWoTwDdns0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezh/4Cyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5956C4CEC4;
	Mon, 16 Sep 2024 08:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726474256;
	bh=i73Vneh9p83hoMPHxa7rCSnS2KtILe2PThtsUv5inyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ezh/4CyqYOG7r4v1FEEeYoseHhNbJm/aCeKEiksaUsqRIecUyKpaRjhRycc/oBI0X
	 mmizFHRC7Kv+8f+Zj9KVjEK5j/li1DptxdiZo2zo96Qn/tTTyejrKzTMEswzmU6BsQ
	 l9Rp8QkuKOPnkqoWLauzlwoH5FCqmSpjs90UKb63BQN8QHtnSmFXFYDiJKhNfSOeLI
	 YdI8e6H2fnMPLYj+ni2qmfXCAkdOQvPCSlOA9oOAYryM8moXNqZh6uGNJa3Syu5fRF
	 gVbRQmq7AZK7Z9peBuR0wCkU7JnduJXCIFIaiQMEDUGuWsLEa037UhhNVRl0FtcmMc
	 u19cwgr9XVezg==
Date: Mon, 16 Sep 2024 11:10:51 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Feng Wang <wangfe@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
	antony.antony@secunet.com
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
Message-ID: <20240916081051.GK4026@unreal>
References: <20240822200252.472298-1-wangfe@google.com>
 <Zs62fyjudeEJvJsQ@gauss3.secunet.de>
 <20240831173934.GC4000@unreal>
 <ZtVs2KwxY8VkvoEr@gauss3.secunet.de>
 <20240902094452.GE4026@unreal>
 <Zt67MfyiRQrYTLHC@gauss3.secunet.de>
 <20240911104040.GG4026@unreal>
 <CADsK2K_ip7YUipHa3ZYW7tmvgU0_vEsDTkeACrgi7oN5VLTqpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADsK2K_ip7YUipHa3ZYW7tmvgU0_vEsDTkeACrgi7oN5VLTqpQ@mail.gmail.com>

On Wed, Sep 11, 2024 at 04:43:55PM -0700, Feng Wang wrote:
> Hi Steffen,
> 
> Can you reconsider the revert of the CL? Based on our discussion, I
> believe we've reached a consensus that the xfrm id is necessary. 

It is only half of the consensus, the other half is that upstream
customer should exist.

Thanks

