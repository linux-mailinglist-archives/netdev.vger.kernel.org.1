Return-Path: <netdev+bounces-240254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E70D0C71E53
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 03:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B521F4E3517
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 02:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065C02F5465;
	Thu, 20 Nov 2025 02:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hd3Lu6Fj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA022222A1;
	Thu, 20 Nov 2025 02:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763607097; cv=none; b=uPh3eL+fAqKbpuW/hsLo2c4n9xyWhCZw4mrLcNwhAS8/vAKx909GyPwzKcaZIWwZZO7jyBsBEm9Tqmqifa2eBoYE3mgKdlC28U2AhxnrQaQiezTYBdbollhwz7OlSB6xB6pK+qyCawjdOS9UhX3/6kEXf4snqY9tsA4B5oWnMzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763607097; c=relaxed/simple;
	bh=zbaH/vcKUVRbqh3j6eYpAQpdFSEgwbuHVVswVi0BnS4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bk9Jc2Gm6DTuaQCJp9qgbvL3fIvujlISu8K5l1AUaHduGH+2pFCs7D2DXr8iijnnA++gWZuPlvpUSMaC1I+0aN2ad7otRjKoDJzFLpwx+WtgbqarHZh3PNkiuurBRzE6EoSAeMVNSCCjlFJUCFBzCdwYja42ZuX39vr+zWah4fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hd3Lu6Fj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B724BC4CEF5;
	Thu, 20 Nov 2025 02:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763607097;
	bh=zbaH/vcKUVRbqh3j6eYpAQpdFSEgwbuHVVswVi0BnS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hd3Lu6Fje2pFop6r0Cxv4FaHMWWXROwycO3KXUAvDS2qs+4d6nubQ0aU7iEDO7iB8
	 5P8x3tGYREeflM3YlwmV9qoJ1sVfHfLZqHBH/D3ZgDKYA6kyHLNXuBFhdBbNE4Os27
	 EnymGfYhXSfMmavGjstnN4xMiuRNdCHvMVij7M1fGi80I51M1ct1s/mi9BYXxpfO0G
	 GswclCjsBRsJBabmplQq7T6PJuig7UbAi2R7NXFOxKF2GlFsGjy2I4pbKkm/tMiTFD
	 YEp8OVIIIu8VM5begIuPbckXH14us3Im+x3LerAErTOLS/3lPImICrW/V5rmLF8nYe
	 qdUzOWdtgmvig==
Date: Wed, 19 Nov 2025 18:51:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, sdf@fomichev.me,
 kuniyu@google.com, skhawaja@google.com, aleksander.lobakin@intel.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [RFT net-next v4 0/2] net: Split ndo_set_rx_mode into snapshot
 and deferred write
Message-ID: <20251119185135.433c9bea@kernel.org>
In-Reply-To: <CAPrAcgOBa5Q3k5r=G4qixzWRuvK+PEinj9sGVf-nxWYon4BkpA@mail.gmail.com>
References: <20251118164333.24842-1-viswanathiyyappan@gmail.com>
	<CAPrAcgNSqdo_d2WWG25YBDjFzsE6RR63CBLs9aMwXd8DGiKRew@mail.gmail.com>
	<20251118105047.20788ed9@kernel.org>
	<CAPrAcgOBa5Q3k5r=G4qixzWRuvK+PEinj9sGVf-nxWYon4BkpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Nov 2025 09:27:58 +0530 I Viswanath wrote:
> > Also I'm not sure what you mean by RFT, doubt anyone will test this
> > for you, and you're modifying virtio which you should be able to test
> > yourself.. RFC or PATCH is the choice.  
> 
> Just to be clear, would testing packet flow with all the possible mode
> combinations
> under heavy traffic be sufficient and exhaustive? I think this should
> be PATCH once I sort everything out

I don't think traffic matters all that much, we're talking about control
path change. It's more important to exercise all the address lists 
(l2 unicast, multicast) and rx modes (promisc, allmulti) etc.
Then whatever other paths may load to touching the relevant state in
the driver (eg virtnet_freeze_down(), not triggers that, suspend?,
migration?).

In terms of traffic simple ping or a few UDP packets would be enough,
mostly to confirm the filtering is working as expected.

