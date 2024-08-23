Return-Path: <netdev+bounces-121442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2860A95D2DB
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 18:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17CC1F222B0
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 16:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B364C193427;
	Fri, 23 Aug 2024 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vM3F3Dae"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880BA18BC35;
	Fri, 23 Aug 2024 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429574; cv=none; b=gHHwgfHd+xVjPAf5aeiKx59IWn7nuizCJNiEamiMNL0X5m3YX+Ybi9vVvC5Gx/H1AzOODidFguzKp+DBv0ENzda+6DaZZ2ewbCU+p0HmvO9dVo+WdFOAl+F4BqJKkA0GGFnFai25FIy4EK8kv/AOuonSkzNrXTgjjbP2wVzbfyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429574; c=relaxed/simple;
	bh=dAdbo0TqfFoi5PbDsGhs2vdI5/DTn9XfQXIoKzTq/84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUG/rG8OKDR1Yu8fwixD2mTj+4UT4EqkZu7atQwZnT3EmpJ8usFaafcrXIobjH8KYauW8q1wNc8jo26dPj8m3/jTXqfRdfsiohy5LLqiMDZoASl/G5qS8xfRG5UBqBK5jq/OBPAwWPMyxRdR80PLBE0jzFBKo6b0P2Sy7uOxdwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vM3F3Dae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDC9C32786;
	Fri, 23 Aug 2024 16:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724429574;
	bh=dAdbo0TqfFoi5PbDsGhs2vdI5/DTn9XfQXIoKzTq/84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vM3F3Dae5jX70rFa0kVt/XDabfLLc4fMTbgp5j9oaf32ry38B1Hu5isWTBKZC2kCU
	 f/zrbGUMQHmUqrskACQk2rqG/Kvs11n/HeTnLEKQIn2Gd917cp7Qm6Sc6OCaIoa2A4
	 qtAhnvHr0pwFIjkD9TgCTrwz59+w2lDritKc1NpDVWlb2g7h4yzGDbZwmI+Ju0oQgO
	 jJ4b8Wv3o714WJgS6trAH5i7SCPGWXK6ld5NQA2kKavKFQZdzmErvKkA3pm7Ow07ql
	 jibTIEoxOHUr7JP4znu5s+kWDWCzmjrnFkUuZ/Yb1SrwAw+bfvJhhGrkZi8bwoau7P
	 S1AMtvj/GcfTA==
Date: Fri, 23 Aug 2024 17:12:49 +0100
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] idpf: Slightly simplify memory management in
 idpf_add_del_mac_filters()
Message-ID: <20240823161249.GV2164@kernel.org>
References: <fa4f19064be084d5e740e625dcf05805c0d71ad0.1724394169.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa4f19064be084d5e740e625dcf05805c0d71ad0.1724394169.git.christophe.jaillet@wanadoo.fr>

On Fri, Aug 23, 2024 at 08:23:29AM +0200, Christophe JAILLET wrote:
> In idpf_add_del_mac_filters(), filters are chunked up into multiple
> messages to avoid sending a control queue message buffer that is too large.
> 
> Each chunk has up to IDPF_NUM_FILTERS_PER_MSG entries. So except for the
> last iteration which can be smaller, space for exactly
> IDPF_NUM_FILTERS_PER_MSG entries is allocated.
> 
> There is no need to free and reallocate a smaller array just for the last
> iteration.
> 
> This slightly simplifies the code and avoid an (unlikely) memory allocation
> failure.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Simon Horman <horms@kernel.org>


