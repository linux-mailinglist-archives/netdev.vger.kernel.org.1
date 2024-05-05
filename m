Return-Path: <netdev+bounces-93501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016BB8BC18D
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 16:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5F81F21450
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 14:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F55E2C1BA;
	Sun,  5 May 2024 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pz9pExyL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C34E1E48A
	for <netdev@vger.kernel.org>; Sun,  5 May 2024 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714920867; cv=none; b=Jh1gZ3ywNoXR3EZLdV2zKog3i2+yf5bXau8G4HIMslfsyxDre+kV3Wt+rtuU5cWxZKKi3lBtrxZOa6NA2cMIfQwc/nkcXgxyiAN5U3kFILa5JgUgSLj6Eau/fxtwI2Faf81l4q/B1OOc6DHToQiq/gecI7KU2PURV3jR7/S3RfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714920867; c=relaxed/simple;
	bh=FBBDxXnBj+N7D8Ug9psXLJ+Tww4W+KQP2bE96yR+kd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRwn7+YA0d/eauHMrGcUEotiYdPwGW65pgETdNxnhuclt3Dh0kWvFvIkn5KNCxYeoIIwoWB9CCjdIxdccHytO9kTAKuOuIchP2UVs40+ACAzDK/l7p0kxmCDsoDY0HrS+uGKbJpxpcde0OOztR4uPpvDnqsOGRp/BUgacVIMLMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pz9pExyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEE0C113CC;
	Sun,  5 May 2024 14:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714920867;
	bh=FBBDxXnBj+N7D8Ug9psXLJ+Tww4W+KQP2bE96yR+kd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pz9pExyLAhK0Xuz4R7i9IeTWixnuNkyQ9YEBWnPY450TEip7mkIjaK7CDOGCWq3es
	 7/fUe4G46wmv8zQ13ahLEBOU5JohX3NVcsk3OBNzH0iiSENv5f7Su7+1Lbe23VPzo6
	 phhZvGvCOUItMEMOFQcTwnSndSUHpORnX9VEexxHMzVjgtAZyrtnxzWQcVAtT0wT3q
	 ZBmzd9FtgI1pCUnuCPa6cE7leDBPz6erRRlW1ubhDuUEgFmQK5khMWNCCwCicYIj4r
	 coGgUsCG4jpjQQOjdWOCZmuuisIBzW1BXIuvggKMe3x01jTdYmhWY2/5QZJG/Mf0gM
	 qhvDPPc5zPrJw==
Date: Sun, 5 May 2024 15:54:23 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 8/8] rtnetlink: allow rtnl_fill_link_netnsid()
 to run under RCU protection
Message-ID: <20240505145423.GG67882@kernel.org>
References: <20240503192059.3884225-1-edumazet@google.com>
 <20240503192059.3884225-9-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503192059.3884225-9-edumazet@google.com>

On Fri, May 03, 2024 at 07:20:59PM +0000, Eric Dumazet wrote:
> We want to be able to run rtnl_fill_ifinfo() under RCU protection
> instead of RTNL in the future.
> 
> All rtnl_link_ops->get_link_net() methods already using dev_net()
> are ready. I added READ_ONCE() annotations on others.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


