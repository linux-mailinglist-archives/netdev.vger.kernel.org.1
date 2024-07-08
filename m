Return-Path: <netdev+bounces-109744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5645929D0C
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1902817AA
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 07:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4F31C68F;
	Mon,  8 Jul 2024 07:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LegcvPgf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653B41CD15;
	Mon,  8 Jul 2024 07:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720423796; cv=none; b=Pp/453zdfJV7LoKFJh2itY3G9NlRUqiHNluqVhTMgYw5wn4y1J6U9WN3xahDIQdrkrWjbFIN3oCy2Jf9sVcy4/35owt24eKo2u6nrSanskVb8AjWrrtDUDsAdDdrcZGHPqkYUJWxmSp+nxIBnKwnv66cTvXF/LHjao5lITmDh/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720423796; c=relaxed/simple;
	bh=A0I4MzbtTvvJyJRp/JKnljUts9C+tJ9eYvgSqnXk+fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okZcPYdIii2WLfMkAA7clrYuKWW6gcrVIFOFxNYrg5YkVtQ5u1JKjtVy7V8F3TMN2mavXgVAGKfqUKDGjSPRqVk744mQFU18xAEsoni4APzUVlHM5nKc29nvGwnwkO8jWNaxgJopLtUdZBTlyBKSPF+qgNF6okGBzp4ZwETAxnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LegcvPgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F36C116B1;
	Mon,  8 Jul 2024 07:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720423796;
	bh=A0I4MzbtTvvJyJRp/JKnljUts9C+tJ9eYvgSqnXk+fY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LegcvPgfnxhyjE3ZR5ztSBdKfj41ZUFxx9ukexiWhuRoebuEsGdT/SMlWmHX34FaD
	 VSBCQ49fxtDb1tBMYZisJHpk+s7kGfKbTRxusze8fg6S+QoTlm4fMsTMrpCDw3U2j+
	 x7PG4XEort6jBSpDWMDBfLnnSk1FYSYagJzmiX301zhXA2kj1G1WfKVInU7Zvz8l/g
	 xODBMX5473EfNgGuerxBisMJKRPE9iTmQQ4DwI7Ihd1c4GQE4PxvR5zPXXwCc6d1dK
	 bJOBkzb5YBekS8wGoOe65SqvskxqjsPkoq7v7it5cFLuRc929B9szuVhDxCC5TWY7P
	 6IZYMGOvu7aZg==
Date: Mon, 8 Jul 2024 08:29:51 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH net-next v2] ice: Adjust over allocation of memory in
 ice_sched_add_root_node() and ice_sched_add_node()
Message-ID: <20240708072951.GG1481495@kernel.org>
References: <20240706140518.9214-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706140518.9214-1-amishin@t-argos.ru>

On Sat, Jul 06, 2024 at 05:05:18PM +0300, Aleksandr Mishin wrote:
> In ice_sched_add_root_node() and ice_sched_add_node() there are calls to
> devm_kcalloc() in order to allocate memory for array of pointers to
> 'ice_sched_node' structure. But in this calls there are 'sizeof(*root)'
> instead of 'sizeof(root)' and 'sizeof(*node)' instead of 'sizeof(node)'.
> So memory is allocated for structures instead pointers. This lead to
> significant over allocation of memory.
> 
> Adjust over allocation of memory by correcting devm_kcalloc() parameters.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Suggested-by: Simon Horman <horms@kernel.org>

FTR, I did provide some review of v1.
But I don't think that counts as suggesting this patch.

> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
> v2:
>   - Update comment, remove 'Fixes' tag and change the tree from 'net' to
>     'net-next' as suggested by Simon
> 	(https://lore.kernel.org/all/20240706095258.GB1481495@kernel.org/)
> v1: https://lore.kernel.org/all/20240705163620.12429-1-amishin@t-argos.ru/

Also, v2 was sent less than 24h after v1,
please don't do that when posting patches to netdev.

Please do read
https://docs.kernel.org/process/maintainer-netdev.html

...

