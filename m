Return-Path: <netdev+bounces-51939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1287FCC60
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 02:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4B81C209E4
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 01:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D386187A;
	Wed, 29 Nov 2023 01:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgxppfzL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EE31854
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 01:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4C2C433C8;
	Wed, 29 Nov 2023 01:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701221737;
	bh=4pfYGO8fRNjAPgxw3DksuEpFs8Sjjd4y32tawvssaoI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GgxppfzL6Gv3LJVCQryknJD3+Mud9f2AuIDVz09K/VzJcjatBsGwQPeDvjE4IWVzr
	 tFSUhk0cnnRWZTAI8j/q2G9t5BilJ33oXtUeyMwPrn8TYG2k0RjrWzMGl/M0d1Kk9y
	 mvIhEpv5EDKwcH4SnkTfxAVhiT9mX6eeIJo+wxTvKiaxofoOgLxpqMUgdgRo6wDcvA
	 XuAx6k2fGyZHG79R2pmXelMWv0wWINEKjROADhAGD5ueULQvP8oIrf+uWgsSRHrQKL
	 ILOJ9yr+iOtsgkGzMRU8vtnDhmpHeHuK/YSFlxj93t1NOG4eQ5HSkBMwrq2V8aR3xj
	 FMxACelF+Zrxg==
Date: Tue, 28 Nov 2023 17:35:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Kent Overstreet' <kent.overstreet@linux.dev>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Thomas Graf <tgraf@suug.ch>, Herbert Xu
 <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] rhashtable: Better error message on allocation failure
Message-ID: <20231128173536.35ff7e9c@kernel.org>
In-Reply-To: <36bcdab2dae7429d9c2162879d0a3f9a@AcuMS.aculab.com>
References: <20231123235949.421106-1-kent.overstreet@linux.dev>
	<36bcdab2dae7429d9c2162879d0a3f9a@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Nov 2023 15:23:49 +0000 David Laight wrote:
> > +	new_tbl = bucket_table_alloc(ht, size, GFP_KERNEL|__GFP_NOWARN);
> > +	if (new_tbl == NULL) {
> > +		WARN("rhashtable bucket table allocation failure for %ps",  
> 
> Won't WARN() be a panic on systems with PANICK_ON_WARN set?

Yes, that's problematic :(
Let's leave out the GFP_NOWARN and add a pr_warn() instead of
the WARN()?

