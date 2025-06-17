Return-Path: <netdev+bounces-198355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AF0ADBE1A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 02:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EA13188F749
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B428635D;
	Tue, 17 Jun 2025 00:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhnDAOHo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5244345C0B
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 00:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750120052; cv=none; b=DH1URO5lfb5OlTDVNcnWKkoAl7TrbRYLdmXvbKbajrYmEh+KxcuHdl/ItzKICBfi9gRNf781q6ANb6LMOiXe4IDi8C/d4yj9o/pJbIhlTURJQ1H8eIw4Ujf7TYmSlzLP6cqmshIpg3xx9qS7u1PHKd8u0BYHENc04N9nvLbMv70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750120052; c=relaxed/simple;
	bh=kCWSN/mECWjeMP782jqMFjBrJ2LwHrL1WSGMwnPCVDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPGgOmdjDCPoSQVSkbePz9crl3xCZbffu01bbcsTg16kuXLsJCRxYYfyie9x52DIlg1xjlbfT8oe0CdKs5cmVRVHBGYAX/KIDyg8dXkt9Y2qDcgp4WFu1s63IQzicQ72bLSn2k4oTqa/LMWEqhg3PApUYyy3ntZrcfBUBeoQouw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhnDAOHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33298C4CEED;
	Tue, 17 Jun 2025 00:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750120052;
	bh=kCWSN/mECWjeMP782jqMFjBrJ2LwHrL1WSGMwnPCVDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QhnDAOHooiqIzIWeRqSIhgW4OWdb0HpMlhlYtG3cZs8toWz1LuNhrr7lQma6tnTXr
	 pxsDy9m/SYu8hvgB86uH2T84fK5Ww1dMD8tACWavN3K6ifgOx7gFF5lCu3wFzy7Vue
	 jusY52MU5t5/BTI4Bw5CI8Ej9fVIz+Iz3f1t6LFam1MieCkLtFXzqKDuEZV8wFYsuS
	 Wa31etPiZd6NBDDDOOYsZkc2tvAPV3Ob/CSA1eeU5tUnEa2a8mnP4PsRlZ6i7OQjiA
	 YfsNHoPy3GQPjcB0Ac6htG/45v5nYjDphlG1ba2EiruHyMrqGu91R8jYDYcAsC3xYa
	 JLcsCCx7lBGlg==
Date: Mon, 16 Jun 2025 17:27:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Arinzon <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, <netdev@vger.kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, "Richard Cochran" <richardcochran@gmail.com>,
 "Woodhouse, David" <dwmw@amazon.com>, "Machulsky, Zorik"
 <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, Saeed
 Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori,
 Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>,
 "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel"
 <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt,
 Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>,
 "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>,
 "Agroskin, Shay" <shayagr@amazon.com>, "Ostrovsky, Evgeny"
 <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>, "Machnikowski,
 Maciek" <maciek@machnikowski.net>, Rahul Rameshbabu
 <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>, Leon Romanovsky
 <leon@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH v12 net-next 3/9] net: ena: Add device reload capability
 through devlink
Message-ID: <20250616172730.5545c02e@kernel.org>
In-Reply-To: <20250611092238.2651-4-darinzon@amazon.com>
References: <20250611092238.2651-1-darinzon@amazon.com>
	<20250611092238.2651-4-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 12:22:32 +0300 David Arinzon wrote:
> +In order to use devlink, environment variable ``ENA_DEVLINK_INCLUDE`` needs to be set.
> +
> +.. code-block:: shell
> +
> +  ENA_DEVLINK_INCLUDE=1 make

This part of the doc refers to building the driver out of tree?
We probably don't want to make a precedent for adding OOT docs
to the tree.
-- 
pw-bot: cr

