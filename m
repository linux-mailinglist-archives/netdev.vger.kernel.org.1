Return-Path: <netdev+bounces-60147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C05CD81DC66
	for <lists+netdev@lfdr.de>; Sun, 24 Dec 2023 21:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8A01F21313
	for <lists+netdev@lfdr.de>; Sun, 24 Dec 2023 20:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637A1DDD3;
	Sun, 24 Dec 2023 20:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+yEvxK7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486E3E554
	for <netdev@vger.kernel.org>; Sun, 24 Dec 2023 20:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4B5C433C8;
	Sun, 24 Dec 2023 20:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703451257;
	bh=FPCG58btU2Pfe22jy/htaVL14/kJhkueyJJoZMn6M54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+yEvxK7yzrpMU/A+B5bNrjWXXqmxhiYd2vPP33ZmWLP+Y6+OWQlR4vrYf/F4rN8t
	 DlzrYqVnO81R7NvmxR9acvnEuS5cOHogaN+P3kKQlH7GCfdH8+r4K9i/8nQKC2lk+A
	 DzAk70vDDYa9xVsNqyRstRqHw+CD6PnO1Ba2Ad1vcSeDFhN9JM7u9cXokcgdojsTlv
	 017+iv3wuW9g/SP5FLkga+7xDxSBmwNJs2TqI+AYuJp0o3NaT/eEh8o+R8XZlKJDCq
	 MQVoxhWbd7yBjc2qBeB3GfFp/kPdLy+0wu83dpXzs+TsDtK9Unby/4FGV8lKtjugdu
	 l7kRfL7Iv+2Gg==
Date: Sun, 24 Dec 2023 20:54:12 +0000
From: Simon Horman <horms@kernel.org>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: ahmed.zaki@intel.com, netdev@vger.kernel.org, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
	Jeff Guo <jia.guo@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH net-next] Revert "net: ethtool: add support for
 symmetric-xor RSS hash"
Message-ID: <20231224205412.GA5962@kernel.org>
References: <20231222210000.51989-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222210000.51989-1-gerhard@engleder-embedded.com>

+ Jeff Guo <jia.guo@intel.com>
  Jesse Brandeburg <jesse.brandeburg@intel.com>
  Tony Nguyen <anthony.l.nguyen@intel.com>

On Fri, Dec 22, 2023 at 10:00:00PM +0100, Gerhard Engleder wrote:
> This reverts commit 13e59344fb9d3c9d3acd138ae320b5b67b658694.
> 
> The tsnep driver and at least also the macb driver implement the ethtool
> operation set_rxnfc but not the get_rxfh operation. With this commit
> set_rxnfc returns -EOPNOTSUPP if get_rxfh is not implemented. This renders
> set_rxnfc unuseable for drivers without get_rxfh.
> 
> Make set_rxfnc working again for drivers without get_rxfh by reverting
> that commit.
> 
> Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>

Hi Gerhard,

I think it would be nice to find a way forwards that resolved
the regression without reverting the feature. But, if that doesn't work
out, I think the following two patches need to be reverted first in
order to avoid breaking (x86_64 allmodconfig) builds.

 352e9bf23813 ("ice: enable symmetric-xor RSS for Toeplitz hash function")
 4a3de3fb0eb6 ("iavf: enable symmetric-xor RSS for Toeplitz hash function")

-- 
pw-bot: changes-requested

