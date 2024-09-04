Return-Path: <netdev+bounces-124987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191FE96B81D
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016231C2216D
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FF61CEEAB;
	Wed,  4 Sep 2024 10:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fK9SMpCa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98201CCB24
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 10:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445160; cv=none; b=kj80DwZpkKDPxPmLDx666+rF/8hwFMtjUX9C7M1cBX92FBxoToDvZOOM76Dg8VU9q8GHeYFZnnI7KQQ8oVqNtdzvDJY6dRpTgqSOyGlMyeX2oxvU+D9/sMj+wh19qQcXMmVvc4RW+UnFOTjbJiRfqw4e+gVVvKaIBWXTnbUPZxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445160; c=relaxed/simple;
	bh=jswY8cShcfmytLTEefAsK2NEhre6gcSfJf7tU5omfnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Susd15Bs6uMQaHlaFnTs3l2/oSJoMCMSASBG1MATuPtJa4GmvtiZ83UYTRQlid6mZxFXZty+YQxSDfsti9y9M6tYErwdTVEhpJVY5hdIGuwobLgqO388pH4Of4tCzdNMqJTPnjMDDGSDygKVbPQVnHlkaQkE31Y72uua68VlsOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fK9SMpCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E065C4CEC6;
	Wed,  4 Sep 2024 10:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725445159;
	bh=jswY8cShcfmytLTEefAsK2NEhre6gcSfJf7tU5omfnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fK9SMpCa/i7hYGRfUjxVYItyYXaKfm1Pp4Fb9sYwZba7H76Q/PJ1ya6zrbPFVNDiw
	 eOmRfFQUXcZfiunUH6GvEk86/I4xJg0j9up/a0NX0WzbsZLwNw5r5TSfqwWqMwPKKd
	 2qougyA/4G2IU1fHPQdAxBb7PkWTl1OmWuYn1biDUdGgD0Tbg5cyS+2Q4qcUczKDh3
	 b1A0IGX38iFlb/bEqVfNydtK5HbHhy+ZRsULxN66qSWzyfyA3a9ODnnF589JLk5LA/
	 EEjtC9X2ZFA9ij5yCa/dAnstaKaftXtoMe23nj4R2MGDZoTEah+Q3+OMFh+pn5ma4n
	 S/EURjLhcYE5A==
Date: Wed, 4 Sep 2024 11:19:15 +0100
From: Simon Horman <horms@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH net v4 2/3] net: sched: consistently use
 rcu_replace_pointer() in taprio_change()
Message-ID: <20240904101915.GJ4792@kernel.org>
References: <20240903140708.3122263-1-dmantipov@yandex.ru>
 <20240903140708.3122263-2-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903140708.3122263-2-dmantipov@yandex.ru>

On Tue, Sep 03, 2024 at 05:07:07PM +0300, Dmitry Antipov wrote:
> According to Vinicius (and carefully looking through the whole thing
> once again), txtime branch of 'taprio_change()' is not going to race
> against 'advance_sched()'. But using 'rcu_replace_pointer()' in the
> former may be a good idea as well.

Hi Dmitry,

If this is not a fix, then it should be targeted at net-next.
As the other two patches in the series do appear to be fixes,
that means the patch-set should be split into two: one for net
and one for net-next.

Also, please consider including a cover letter with
patch-sets with more than one patch.

> Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v4: adjust subject to target net tree
> v3: unchanged since v2
> v2: added to the series

...

