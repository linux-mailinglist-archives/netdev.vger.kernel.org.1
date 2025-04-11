Return-Path: <netdev+bounces-181457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B436BA850A5
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 02:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967B41B686C3
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 00:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63D0D299;
	Fri, 11 Apr 2025 00:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRJ0A6Aq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6AD5C96;
	Fri, 11 Apr 2025 00:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744332001; cv=none; b=lsvAdkPWixBkmtqqx608hIpRdaHDtaY06TMqebNjdWu2s+EGUM2i89S8NcUGm6N9BmoDiBGQY4uNqsR4o6lomjfu2jmhdrPqh/WTb3NZlQNxZTU5Eqwh7uaDnP40qNY7SXa/NwinJsI3KQchyro0mTgUmYGP9bI2/bbLr2XdpqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744332001; c=relaxed/simple;
	bh=mnGvZiGOwOCpuDiXn5hOB8Yy8cepG2SDp5Tiv7JDr/k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYbUmhGGrO8haEErCq7uBHNRLTZ1EBjZkXpgWEL88DvX9d2xxdoGa5V7avxA7gNUDbyK5MYxo5vK8tswK5QRqy4vFn+QDGgO/UfgxA06UkqkO4I4MrGFTKaNhxbhe8dOVN/uzLmdZceWlkUjLlJsLVFelrv3xGgW0kLiEeM9nm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRJ0A6Aq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AD6C4CEDD;
	Fri, 11 Apr 2025 00:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744332001;
	bh=mnGvZiGOwOCpuDiXn5hOB8Yy8cepG2SDp5Tiv7JDr/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JRJ0A6AqKkGwhN4xgL14GqSP1uApNcmBPrL/HFY33SNa2VOjr0AdE+KzIgkvmy/iO
	 KZlE9cB57mO21kKZdYMQoQZ5OW1LRwlcWpSrCsZ1fjit4sjyXauHcor6uIF7zybyLV
	 ZDfFlgh9PTD0f+EmC1dh/D0qC5gbRyQ45h+79O2QdIKfScmfv/ssZuX4Yp4NsbFuy3
	 UBBqobzkdqfQe6Ik1KJ+BKvJYcvDF283SzBH4vHICLC46ieoRHyfdyfKM9pAvNnl4h
	 znIV/43wdm69/9RO8BZyLfNfhXnacVCR+T/c2qMHZG8JtO1fFysk1c/yFCDqTjb/nB
	 4spvJXSUmd15A==
Date: Thu, 10 Apr 2025 17:39:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: Paolo Abeni <pabeni@redhat.com>, Marek Lindner
 <marek.lindner@mailbox.org>, Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>, Sven Eckelmann
 <sven@narfation.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] batman-adv: fix duplicate MAC address check
Message-ID: <20250410173958.788611a1@kernel.org>
In-Reply-To: <94e1ac2c-46f1-4787-ad50-e4a5ab11011a@universe-factory.net>
References: <c775aab5514f25014f778c334235a21ee39708b4.1744129395.git.mschiffer@universe-factory.net>
	<0c288b2e-9747-4a50-a16f-bf4238829ffa@redhat.com>
	<94e1ac2c-46f1-4787-ad50-e4a5ab11011a@universe-factory.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 17:38:30 +0200 Matthias Schiffer wrote:
> >> Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
> >> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>  
> > 
> > Even if marked for net I assume this will eventually go first via the
> > batman tree.  
> 
> Yes. Should I have marked this differently?

Yes, let's reserve net for patches which will go directly into:
https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/
Similar for net-next.

The tree name is supposed to tell the maintainer who you expect
to take the patch.

The batman tree (according to MAINTAINERS) is called linux-merge
so let's ignore that and use batman and batman-next?

