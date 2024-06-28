Return-Path: <netdev+bounces-107683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 338FA91BED4
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 14:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0CC01F23DCC
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 12:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC1B158877;
	Fri, 28 Jun 2024 12:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LB1B44hK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C43F15886A
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 12:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578653; cv=none; b=CyTZ5iT9O3u9Til0HB4Is/8/X3nKDgIe6QLQNuOzpiDd7HkCc8IVJ5Gy/klJIDuffFwinsWsOUNPEkKN8QMHyRwN8qNAS5o6L+tFsVQYvMKiy0H25jCk0jXliZlM3woA1dLg25ll15EI1NuU+Gc6vT2qO8nkHW2Q6J9hucRH710=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578653; c=relaxed/simple;
	bh=+VW8sn66gk4SjHZa1n67R6NGG3C5XmNF1JTxUzMam6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+NOYm7Y7HtNaNI5ZbyXCuyga1ghIIKJeq9joJdZR9nIGRm9Je+3o14Le0MQJdsa9foXoKRyuVM9JDvC+Vk403QQ2eadxK1fvOB6mlSYRDe2+cPaSC+aM1IOBQY7KhG0c32vX/9aDuEWZ3/DBI5wjp9bxQ3MKazs2kQyH1v9y6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LB1B44hK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7416C116B1;
	Fri, 28 Jun 2024 12:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719578653;
	bh=+VW8sn66gk4SjHZa1n67R6NGG3C5XmNF1JTxUzMam6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LB1B44hKKXQd6MIxav8vylxxunO2IF634Sjp6vl+0uqRtAtoqanVp34kzVAyoTa7P
	 65AHVxyfKdV2P7Ea7NmT7EqHikulF8yrqtaLRvT0J6luOOnWViiC9UQWYtzJWcOb+w
	 av62sDh1UY+ujLjAq7kP+ldGdwWvmiGcLaDjZxwVs51zEPNm6VrXvkZXskm9UH1v8e
	 +ulBBn/q/kTTa/2llwgTTdOz6waJCKPLqCuPqi3q740bfQRs1m85TX+gKxE9JyMuE2
	 UlYR5TMS+Um8s7enz9FV0xR90Ss3/vSN/ozLY/12YtIiMIQMRdhZfrXflViS2u+2wL
	 JFwhgD76MDE/g==
Date: Fri, 28 Jun 2024 13:44:09 +0100
From: Simon Horman <horms@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH iwl-next 5/6] ice: Optimize switch recipe creation
Message-ID: <20240628124409.GD783093@kernel.org>
References: <20240618141157.1881093-1-marcin.szycik@linux.intel.com>
 <20240618141157.1881093-6-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618141157.1881093-6-marcin.szycik@linux.intel.com>

On Tue, Jun 18, 2024 at 04:11:56PM +0200, Marcin Szycik wrote:
> Currently when creating switch recipes, switch ID is always added as the
> first word in every recipe. There are only 5 words in a recipe, so one
> word is always wasted. This is also true for the last recipe, which stores
> result indexes (in case of chain recipes). Therefore the maximum usable
> length of a chain recipe is 4 * 4 = 16 words. 4 words in a recipe, 4
> recipes that can be chained (using a 5th one for result indexes).
> 
> Current max size chained recipe:
> 0: smmmm
> 1: smmmm
> 2: smmmm
> 3: smmmm
> 4: srrrr
> 
> Where:
> s - switch ID
> m - regular match (e.g. ipv4 src addr, udp dst port, etc.)
> r - result index
> 
> Switch ID does not actually need to be present in every recipe, only in one
> of them (in case of chained recipe). This frees up to 8 extra words:
> 3 from recipes in the middle (because first recipe still needs to have
> switch ID), and 5 from one extra recipe (because now the last recipe also
> does not have switch ID, so it can chain 1 more recipe).
> 
> Max size chained recipe after changes:
> 0: smmmm
> 1: Mmmmm
> 2: Mmmmm
> 3: Mmmmm
> 4: MMMMM
> 5: Rrrrr
> 
> Extra usable words available after this change are highlighted with capital
> letters.
> 
> Changing how switch ID is added is not straightforward, because it's not a
> regular lookup. Its FV index and mask can't be determined based on protocol
> + offset pair read from package and instead need to be added manually.
> 
> Additionally, change how result indexes are added. Currently they are
> always inserted in a new recipe at the end. Example for 13 words, (with
> above optimization, switch ID being one of the words):
> 0: smmmm
> 1: mmmmm
> 2: mmmxx
> 3: rrrxx
> 
> Where:
> x - unused word
> 
> In this and some other cases, the result indexes can be moved just after
> last matches because there are unused words, saving one recipe. Example
> for 13 words after both optimizations:
> 0: smmmm
> 1: mmmmm
> 2: mmmrr
> 
> Note how one less result index is needed in this case, because the last
> recipe does not need to "link" to itself.
> 
> There are cases when adding an additional recipe for result indexes cannot
> be avoided. In that cases result indexes are all put in the last recipe.
> Example for 14 words after both optimizations:
> 0: smmmm
> 1: mmmmm
> 2: mmmmx
> 3: rrrxx
> 
> With these two changes, recipes/rules are more space efficient, allowing
> more to be created in total.
> 
> Co-developed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>

I appreciate the detailed description above, it is very helpful.
After a number of readings of this patch - it is complex -
I was unable to find anything wrong. And I do like both the simplification
and better hw utilisation that this patch (set) brings.

So from that perspective:

Reviewed-by: Simon Horman <horms@kernel.org>

I would say, however, that it might have been easier to review
if somehow this patch was broken up into smaller pieces.
I appreciate that, in a sense, that is what the other patches
of this series do. But nonetheless... it is complex.

...

