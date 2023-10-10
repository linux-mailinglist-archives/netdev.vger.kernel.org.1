Return-Path: <netdev+bounces-39599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFF67C0040
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 17:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0672814A1
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 15:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E304736B;
	Tue, 10 Oct 2023 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRSgeZic"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1374130FB4
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 15:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC52C433C8;
	Tue, 10 Oct 2023 15:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696951148;
	bh=q5zpB8Ae5EwUX+krsgcAEDQQxTiFxoZyHrCg5TuPpm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fRSgeZicmUkwBUqTTVEkR2oFBRPB7uH2+ITFqHwgtoTc5q2FbaeEAe1Ce5BXEPqpP
	 QwzT13xhObh+q5M3efgctZ+RKZPnui+bEzR9pVMCjIJI+fy6e8dvQrCTsYdkZtsrXM
	 MZfJhckFbDfe1gQSXHliI1dzbbxkp1XE0snIMFE7zE55B+UFoU2Zkwcsqiu36cQ4qI
	 GdL4B7hPIFvnln7FyvPe5grLN81/OFmxPBIi5oSkG9EF7L5pJF2t3VoCEjrQ3zsz2d
	 e8jQuXPWmP773MoBiOuy+0imw335Mp2djDq5NITji7sn8iRkVz40DBV1AcjjX4JVD2
	 D+8vbhSx3+Pvg==
Date: Tue, 10 Oct 2023 17:19:03 +0200
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc: Michal Kubecek <mkubecek@suse.cz>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v3 1/1] ethtool: Fix mod state of verbose no_mask
 bitset
Message-ID: <ZSVrZ9fIP62RLQpY@kernel.org>
References: <20231009133645.44503-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009133645.44503-1-kory.maincent@bootlin.com>

On Mon, Oct 09, 2023 at 03:36:45PM +0200, Köry Maincent wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> A bitset without mask in a _SET request means we want exactly the bits in
> the bitset to be set. This works correctly for compact format but when
> verbose format is parsed, ethnl_update_bitset32_verbose() only sets the
> bits present in the request bitset but does not clear the rest. The commit
> 6699170376ab fixes this issue by clearing the whole target bitmap before we
> start iterating. The solution proposed brought an issue with the behavior
> of the mod variable. As the bitset is always cleared the old val will
> always differ to the new val.
> 
> Fix it by adding a new temporary variable which save the state of the old
> bitmap.
> 
> Fixes: 6699170376ab ("ethtool: fix application of verbose no_mask bitset")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Changes in v2:
> - Fix the allocated size.
> 
> Changes in v3:
> - Add comment.
> - Updated variable naming.
> - Add orig_bitmap variable to avoid n_mask condition in the
>   nla_for_each_nested() loop.

Hi Köry,

thanks for the updates. This one looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

