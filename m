Return-Path: <netdev+bounces-87158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C38E58A1E4D
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 20:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A351F25697
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 18:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D2E2556E;
	Thu, 11 Apr 2024 18:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DP1Vk9rT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414B5D53C
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858651; cv=none; b=UFptWugveqSRwFwHsczQs0stVb2sR7kxbuHIRAjM0OG0SCSRfl3bIYoZkNBMc1iHTiPKDQz7Q/BZTVJe8u4G0smec1TV5QIAwjtJhf/q3PORQ+jEa4UNDUQy7QU7bsi9G5VOH5Tm4XGyZD+XmSsQNlFWEC9XRZ1zMz0SoE7sL7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858651; c=relaxed/simple;
	bh=5/EupfAGI2wAJbOcINHvdOeUOnovSqCHDoAi0fdeJZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GX16WswSdZ3y8xPw6FJDbGRZ23SssGK4KssdNvVm+j/hWlbRZwrZ5p9p5LdHDyKVtrKPogE1O2JweKlYlakuFByat94BfT5t/VZcz1ChERNYNxeCpdhtnU22066GdbXitLainmXomqX2Pb764mzEQsZOZOTmWBtsxAGp2/epPnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DP1Vk9rT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A79DC072AA;
	Thu, 11 Apr 2024 18:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712858650;
	bh=5/EupfAGI2wAJbOcINHvdOeUOnovSqCHDoAi0fdeJZ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DP1Vk9rThXotTVXWFTOh65esnp24HvjkcWzghmDIoU5HiJQrVa8na7WT/nUlAbS0Y
	 3JBemCN8onUYk+PDXK22N6pLPMaKuQIlNcREWTRgN3uxkrF0sDVnpswBmOMVxKuxY2
	 626WAuuM/BF5tKZVk7uTKi2xtWuu0Rpq6wSGwzMbRr5Iz9tgmKnsR+cDWULiFmo5ok
	 Tr1U9hH9WRa16VmMJuoSWh0AxChM4vlwZrhk+Ld/crDpw2Vlq6BzQpYPTJu5Z+koKj
	 LbvhloKeJQFJm8Gd3/ct0irLaMNYHH8/on9euDX4xLMLgjqgvTua3pNo5k/7aLy03k
	 gVp7IT/SBWySA==
Date: Thu, 11 Apr 2024 11:04:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Eric Dumazet <edumazet@google.com>, Stefano Brivio <sbrivio@redhat.com>,
 davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com,
 jiri@resnulli.us, idosch@idosch.org, johannes@sipsolutions.net,
 fw@strlen.de, pablo@netfilter.org, Martin Pitt <mpitt@redhat.com>, Paul
 Holzinger <pholzing@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH net-next v2 3/3] genetlink: fit NLMSG_DONE into same
 read() as families
Message-ID: <20240411110409.67d32aa2@kernel.org>
In-Reply-To: <20240411110313.245b321c@kernel.org>
References: <20240303052408.310064-1-kuba@kernel.org>
	<20240303052408.310064-4-kuba@kernel.org>
	<20240315124808.033ff58d@elisabeth>
	<20240319085545.76445a1e@kernel.org>
	<CANn89i+afBvqP564v6TuL3OGeRxfDNMuwe=EdH_3N4UuHsvfuA@mail.gmail.com>
	<20240319104046.203df045@kernel.org>
	<02b50aae-f0e9-47a4-8365-a977a85975d3@ovn.org>
	<20240411081610.71818cfc@kernel.org>
	<b2e7f22c-6da3-4f48-9940-f3cc1aea2af2@ovn.org>
	<20240411085206.1d127414@kernel.org>
	<6a561c3b-02dd-485a-aff0-04f1e347adf0@ovn.org>
	<20240411110313.245b321c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2024 11:03:13 -0700 Jakub Kicinski wrote:
> > NLMSG_DONE is part of the first recvfrom and the process is stuck
> > waiting for something from the second one.  
> 
> Perfect, thank you! I just sent the v4 fix,
> just to be clear you were testing on -next right?
> Because AFAICT the v6 change hasn't made it to Linus.

Oh, you said net-next/main earlier in your message, all makes sense.

