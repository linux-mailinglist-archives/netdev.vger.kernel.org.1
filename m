Return-Path: <netdev+bounces-91799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C458B3F41
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 20:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260052883A3
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 18:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2073F160787;
	Fri, 26 Apr 2024 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iohnqGd6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15EE54755
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714156190; cv=none; b=AkGlsCQlJXzhoSCyZG6oaXqL1cYCROcwqrO6zt4IeRWqQHnGgFqF4o9OlOWMo8ej6HuU2A7TXWXT5+zTkZ6VcCdJflamnn5vBp61NBjZifH5cRFWKcv4u0DHIUjy9tEQtYSO/xOOAEGuknV54KcSE1lG6mNhbNTIggxg6U+zxSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714156190; c=relaxed/simple;
	bh=mCu4M4go0z7z0UPv0dVxjtKKrRzycrwc/HpPtbX3gYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEqD7KJKhZ7sTu1/U1wD/Vm9DMzl2DweCl2kXHL90E1V0KkVQb1ymdEAbeBXvTNY3+sYZ8tOrR5bPpRnZmhn0R3t30BnCzpg4R6a4Y8qWlHZ3aR7h/K8MwaLWtC54cE2d+69D0hsabcZGSCMQD7LbNwPB1iKEualeutN2kzeTYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iohnqGd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D6EC113CD;
	Fri, 26 Apr 2024 18:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714156189;
	bh=mCu4M4go0z7z0UPv0dVxjtKKrRzycrwc/HpPtbX3gYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iohnqGd6ItTP+KRtdLxIftUIYMsrzLqw0wA6MLq9t7xKvSD3JK/R5cjwUwrhj3CJo
	 ZUPftZrE/bwBNA8AGFWKDCUWGWuxeCSXy9x1zDj/J99c/jDdWuH7c15ENyo19bshf+
	 Zuqd4aYA/PgpwUECdsoG1HONwRjjY2ToO0ff1bNnRoNNe7XUeJBhEB8B0chJJpsZop
	 Fk8l407h5O6zPRXJDnvxp2JtJjab0nDAJIk91QjtYvbEtbmHLsdDEBX/PDcMjJO+8/
	 J7X05iZzdAaEtHajitwjAW9HzC3cJAnd5yzqu4z4A1YC9tdBG7s4qFtYre+1sHVj7L
	 3a7wBVK4m+wbg==
Date: Fri, 26 Apr 2024 19:29:45 +0100
From: Simon Horman <horms@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH iwl-next] ice: remove correct filters during eswitch
 release
Message-ID: <20240426182945.GC516117@kernel.org>
References: <20240423143632.45086-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423143632.45086-1-marcin.szycik@linux.intel.com>

On Tue, Apr 23, 2024 at 04:36:32PM +0200, Marcin Szycik wrote:
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> ice_clear_dflt_vsi() is only removing default rule. Both default RX and
> TX rule should be removed during release.
> 
> If it isn't switching to switchdev, second time results in error, because
> TX filter is already there.
> 
> Fix it by removing the correct set of rules.
> 
> Fixes: 50d62022f455 ("ice: default Tx rule instead of to queue")
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> It is targetting iwl-next with fix, because the broken patch isn't yet
> in net repo.

Reviewed-by: Simon Horman <horms@kernel.org>


