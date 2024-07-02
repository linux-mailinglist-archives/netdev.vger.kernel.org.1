Return-Path: <netdev+bounces-108570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B89924699
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 19:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514F81F245AA
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 17:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4711BE86D;
	Tue,  2 Jul 2024 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NB55W28D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E9E3D978;
	Tue,  2 Jul 2024 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719942281; cv=none; b=tx4P4ZHONspReGVgwG8ebp/bQh5CtjY+Pi5drUVOSjE02F6+/K836QRevJ+tVfLL0GJGcR7TO+OgEioctpLMwpWIZvouTBEBgYjwwXEwffMetkz/BSdQPLjZ0UYjZMRa1ka1ITTNsPMB/jSXjQqxC79pWA6fI0ADJwHDJnFl1Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719942281; c=relaxed/simple;
	bh=PjK5GvqBTsMK4HFv10GHs5g18DsWzLixUs35c8qTVCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nchFsiKUcT/TMPAMCwg50zvKX9+cK4ZcRrDYFfR8nkMQKnjFRgiegdzGqTLjQs/ziXRSIeusmauIlJuaNY1NOwMxdEVdpxgoHV420QRtNzKPK6amKTB0JK3t0m3dncPUpFTLRX120Drx9Pw7ChURwvcG+x+Kioz2lUAbTyyxqA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NB55W28D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2373AC116B1;
	Tue,  2 Jul 2024 17:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719942280;
	bh=PjK5GvqBTsMK4HFv10GHs5g18DsWzLixUs35c8qTVCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NB55W28DgwxAIfJS/NlkBqQ+QGxd2DaiQoRy8OIPYXvz4fo0hr85k9nwb4qruXXaj
	 drOx7/3/2Am8LYPDB+X/8X5XgzUx9ajXHTCcSNNDa5m4YjpN6/zVyjQ0cv5+zi/Obc
	 nGNkC/f2KTjJnwuZk8ZcoqnMqSoLCZ5rgztj8RnBnFLCmWSUBnUXJqOUm3G9B1nTwJ
	 m27XuUzpO85kmXHmmxTbqyTBNDf8Wh6L567oh/PCZIteuQOPABHA0xeJ0Wi1izTEpI
	 jAlHjMEcu3/d3/T8AbEjW42MwPJ93OLldDqvP08Bo+skm1uJwUS18MarDIo8MvTIof
	 XRynFgbKG3Mlg==
Date: Tue, 2 Jul 2024 10:44:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Simon Horman <horms@kernel.org>, Igal Liberman
 <igal.liberman@freescale.com>, Madalin Bucur <madalin.bucur@nxp.com>, Sean
 Anderson <sean.anderson@seco.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: Re: [PATCH] fsl/fman: Validate cell-index value obtained from
 Device Tree
Message-ID: <20240702104439.4df3a523@kernel.org>
In-Reply-To: <20240702133651.GK598357@kernel.org>
References: <20240702095034.12371-1-amishin@t-argos.ru>
	<20240702133651.GK598357@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jul 2024 14:36:51 +0100 Simon Horman wrote:
> Maybe it is intentional, I'm unsure.
> Perhaps this can be investigated separately to the fix proposed by this
> patch?

+1, please fix this first

