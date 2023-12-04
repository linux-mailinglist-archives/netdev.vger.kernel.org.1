Return-Path: <netdev+bounces-53682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66498041A8
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 23:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 400ABB20AF5
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 22:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BCC3A8F5;
	Mon,  4 Dec 2023 22:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WORYnH/2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4D82FC5A
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 22:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB28C433C8;
	Mon,  4 Dec 2023 22:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701728538;
	bh=keW5i8qebroJtN8Z6PS/TiYKwWuHQIjV6wam4mPyNsI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WORYnH/2G61hGitGbL/VX0CUdq2C3ir2YM3iq+lAEOW3m4uhP9BqJvG7jpzljumzn
	 DKPhrKj42dPuYZW+/f1g9cZZ4Bgtuvi8Ja0SlhyUhyNNKuMmap/f205KqCKeJ+rSk+
	 nXx1mkNx9EHilNd1VHUohfJ1zeWVVeXqAgzBhbkYFQW1UqLI/GSK60woG2CIm8clvi
	 GTcNDErjYJHF6Xl6Vb2l5ioa1RnsiSdifLjQAotWeDPf8S6WGvc6SvLRVjiimIg/7N
	 y3e4qBcW9a/AINb42RtyctTvVzl8MDlzwtmmO/wd2xYMJh/zbpqzfEonk79fkwIvs2
	 vu6SHEA0x0yAw==
Date: Mon, 4 Dec 2023 14:22:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Marc MERLIN <marc@merlins.org>, netdev@vger.kernel.org, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org, Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [RFC PATCH] net: ethtool: do runtime PM outside RTNL
Message-ID: <20231204142217.176ed99f@kernel.org>
In-Reply-To: <69c0fa67c2b0930f72e99c19c72fc706627989af.camel@sipsolutions.net>
References: <20231204200710.40c291e60cea.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
	<20231204200038.GA9330@merlins.org>
	<a6ac887f7ce8af0235558752d0c781b817f1795a.camel@sipsolutions.net>
	<20231204203622.GB9330@merlins.org>
	<24577c9b8b4d398fe34bd756354c33b80cf67720.camel@sipsolutions.net>
	<20231204205439.GA32680@merlins.org>
	<20231204212849.GA25864@merlins.org>
	<69c0fa67c2b0930f72e99c19c72fc706627989af.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 04 Dec 2023 22:32:25 +0100 Johannes Berg wrote:
> Well, I was hoping that
> 
>  (a) ethtool folks / Jakub would comment if this makes sense, but I
>      don't see a good reason to do things the other way around (other
>      than "code is simpler"); and

My opinion on RPM is pretty uneducated. But taking rtnl_lock to resume
strikes me as shortsighted. RPM functionality should be fairly
self-contained, and deserving of a separate lock.
Or at the very least having looked at the igc RPM code in the past,
I'm a bit cautious about bending the core to fit it, as it is hardly
a model...

>  (b) Intel wired folks could help out with getting the patch across the
>      finish line, seeing how their driver needs it :) I think the dev
>      get/put needs to use the newer API, but I didn't immediately see
>      how that works locally in a function without an allocated tracker


