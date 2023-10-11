Return-Path: <netdev+bounces-39784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 643217C47A1
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 04:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA9C3281D48
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 02:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB2935511;
	Wed, 11 Oct 2023 02:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0n2bizF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB96819
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 02:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D5DC433C8;
	Wed, 11 Oct 2023 02:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696990221;
	bh=SCN+YvrTAvn/rzETs6OSh7GFIZOLCdOcc5xTG+BWl0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A0n2bizFMpZqqKeGhyfo1ozKH4zwv1E5WO/KuO+JorM7wXzRM6u21i+SvPPYJPSgL
	 8IqhnLJh5EdIJKh+kVXpg8RCAGy8fiWXmjx6wag+lF9y2PDpt33HpFV6iz8JSsWBIM
	 QFyLHie+TUizdXcW9qnZcCeEwjxw3/2lrXoEwz9cZ1ctYvcWrhSBPQmqeaysAwknlh
	 BUkjjBOydhkCOQvKK2JxDXFKCCFNMJ5XcTXWPK8kz/gRCkT8fW47b9auOrDVAGrzGQ
	 vzgylqoG1XQ39ay/nXMofyJqIkddLIywkojM3gpXsJy4O0dYN98IQuVdgltPbH1/Ag
	 0z1PUB0veiV3A==
Date: Tue, 10 Oct 2023 19:10:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: takeru hayasaka <hayatake396@gmail.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ethtool: ice: Support for RSS settings to GTP
 from ethtool
Message-ID: <20231010191019.12fb7071@kernel.org>
In-Reply-To: <CADFiAcKF08osdvd4EiXSR1YJ22TXrMu3b7ujkMTwAsEE8jzgOw@mail.gmail.com>
References: <20231008075221.61863-1-hayatake396@gmail.com>
	<20231010123235.4a6498da@kernel.org>
	<CADFiAcKF08osdvd4EiXSR1YJ22TXrMu3b7ujkMTwAsEE8jzgOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Oct 2023 10:56:17 +0900 takeru hayasaka wrote:
> GTP generates a flow that includes an ID called TEID to identify the
> tunnel. This tunnel is created for each UE (User Equipment).
> By performing RSS based on this flow, it is possible to apply RSS for
> each communication unit from the UE.
> Without this, RSS would only be effective within the range of IP addresses.
> For instance, the PGW can only perform RSS within the IP range of the SGW.
> What I'm trying to say is that RSS based solely on IP addresses can be
> problematic from a load distribution perspective, especially if
> there's a bias in the terminals connected to a particular base
> station.
> As a reference that discusses a similar topic, please see the link
> below(is not RSS, is TEID Flow):
> https://docs.nvidia.com/networking-ethernet-software/cumulus-linux-56/Layer-3/Routing/Equal-Cost-Multipath-Load-Sharing/#gtp-hashing

Makes sense, thanks for the extra information. I think it would be
worth adding all of this to the commit message!

Regarding the patch - you are only adding flow types, not a new field 
(which are defined as RXH_*). If we want to hash on an extra field, 
I think we need to specify that field as well?

> Thank you for your understanding.
> ---
> Sorry! My email was blocked because it wasn't sent in plain text mode.
> I've made the necessary changes and will resend it.

No worries! Additional request - in the future please prefer the
bottom-posting or interleaved style of replies:
https://en.wikipedia.org/wiki/Posting_style#Interleaved_style

