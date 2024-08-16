Return-Path: <netdev+bounces-119304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415329551F0
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 22:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1EEC2864F4
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 20:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108AB1C463B;
	Fri, 16 Aug 2024 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfvJC+ER"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07901C230D
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723840851; cv=none; b=M586RDsmA4n8ZMQ45+T9wxoOgMOL7n4fIEW0CR3YX1OdiuAHL/gKMh5MWwfj7yW48PvrINkdh9ozPGA8tSHYdFjfjNZ6Ux0eG7He4s30/L4MYyBrRSwxD8o5jfPLu8b5j2PMrZrvbu1/rDfGQi8kOdsOUO8BnsEMUWzXiTc9tgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723840851; c=relaxed/simple;
	bh=8uJXX4e1jZY1O4lbo0WpXTORYwYVn2hsGZWwiw/+5Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cyHb70s5L7smZmHTOq1zBGr1jphqoBORPVYkQyN+e+XDtzQVupAXAY91ntPX8GuTw1s7Ty4XvqzrO5hPVEXid5RjC2uO7gMs3GZ6Gs8VJkDyXUCVEw3dJ9AuYQbgWrbz9uCSWm3hF1o7abYWVDTNRkvhWZUl5IMD52uPuUmIpmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfvJC+ER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDF6C32782;
	Fri, 16 Aug 2024 20:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723840850;
	bh=8uJXX4e1jZY1O4lbo0WpXTORYwYVn2hsGZWwiw/+5Hs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jfvJC+ERqbkcC7PvM7jannB1jNG7FNP1BUKN2GX8zRI/TuS8bkKP3181ysL4wVD+C
	 EgOvlZ3xQQCUGB2Gpyv5nHm2RqPmIqlKwsKca3pEnWa8FJkHw3y1vxU3D8YxbHz5MD
	 EQ/wxzOtIWY88oCX7FeIBxVT4GttGu9lh42ytIHKbD62FBQyf+NWgYgtmTmLPM3Xo1
	 Md70pMXOgMk5fJJ12lv0eKYBcqUXNWiBsF3l2LrVZJyTYtfc0P0+tvH9eh1a1kiCzs
	 jqKxCVAX/z6Wr7wspK7NTIbflY/vDaPIeBdv0AO/hWOSIlWJPp8E0mV4amj2r3oMhd
	 KC6cz826bs7vA==
Date: Fri, 16 Aug 2024 13:40:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <netdev@vger.kernel.org>, <aleksander.lobakin@intel.com>,
 <przemyslaw.kitszel@intel.com>, <joshua.a.hay@intel.com>,
 <michal.kubiak@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>
Subject: Re: [PATCH net-next 0/9][pull request] idpf: XDP chapter II:
 convert Tx completion to libeth
Message-ID: <20240816134049.4f7b6c8a@kernel.org>
In-Reply-To: <987c5606-0cd3-8e76-3a6f-25f2406a1d51@intel.com>
References: <20240814173309.4166149-1-anthony.l.nguyen@intel.com>
	<20240815191859.13a2dfa8@kernel.org>
	<987c5606-0cd3-8e76-3a6f-25f2406a1d51@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 13:31:52 -0700 Tony Nguyen wrote:
> > Eric and Paolo are mostly AFK this month, I'm struggling to keep up
> > and instead of helping review stuff you pile patches. That's not right.  
> 
> Sorry, I wasn't aware. I'll throttle the patches I send for the rest of 
> the month.

I was hoping you'd take the opposite approach and push some folks 
to review :) But either way helps, thanks for the understanding.

