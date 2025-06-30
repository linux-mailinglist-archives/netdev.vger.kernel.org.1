Return-Path: <netdev+bounces-202585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C11C7AEE4F5
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30971895FDB
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EE825D1F7;
	Mon, 30 Jun 2025 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAd73jTr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7658460
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751302199; cv=none; b=BhFJ5aQLrrYHz3EK/M0h79Hu9t+lCdv8w6KqV/LflellQIxv0yTVZeJtm14Ive7rUTL+9e/BykgVAOashEhFL2wJEnwBP0WyBRSL4ohzj6SGFXkpSwgdtOpQN1IePVU45lvTRN2YqY5vMt252hHdJPt6mKceSCU+h8YTstVhXEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751302199; c=relaxed/simple;
	bh=amikl6o2wzAqKCLElLnXacASC7JbfG35i+pN+kkodpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cC/U5+uEnwQSMIsxmXcdjOVBqKxvI0vGn2rIHo0mrLrugDmXDOkBXAP+DtOxtQcSoNUO5/glYiQrD56AyXY3BpVxNXpl7KZcF+KtQIwQjlIgPIOF/gMeVHq29yk+u7lShIjRMql1uRnD07W3wMG5RRz+V1y9I9xg92YwvZ679Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAd73jTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54999C4CEE3;
	Mon, 30 Jun 2025 16:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751302199;
	bh=amikl6o2wzAqKCLElLnXacASC7JbfG35i+pN+kkodpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OAd73jTr4Qx4sIewZhiPHeppN6ESqOnFVQaqI9pRlM4B2HGWGcZsuGSuhEOXM4LV9
	 WigopD4UURVkN76D6r2SkpJlcDJ8LXCuMKxM7fC2YPTYPsQlAOrIu2U8kjj/0TvSzy
	 C1qfPvpQDyWsVQNChAFxeB0ilLCfAwZuV+NAcQ7374+MAWNxzGseYkVtF5py+e5jvs
	 gGgnhbRXWgrGEUty+jBhCNfuccsVb+6DiTVAfzO5rQ3FzU6uprQAtdb21HYljU0okB
	 dz1QTgsHW21xBhXeNGwUi7IxQXhkGZOGN356knnqAxrnV73fdF9ql1KuPBe/iu6PtN
	 pAqpYIE4UXbCw==
Date: Mon, 30 Jun 2025 17:49:55 +0100
From: Simon Horman <horms@kernel.org>
To: Dennis Chen <dechen@redhat.com>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net] i40e: report VF tx_dropped with tx_errors instead of
 tx_discards
Message-ID: <20250630164955.GK41770@horms.kernel.org>
References: <20250618195240.95454-1-dechen@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618195240.95454-1-dechen@redhat.com>

On Wed, Jun 18, 2025 at 03:52:40PM -0400, Dennis Chen wrote:
> Currently the tx_dropped field in VF stats is not updated correctly
> when reading stats from the PF. This is because it reads from
> i40e_eth_stats.tx_discards which seems to be unused for per VSI stats,
> as it is not updated by i40e_update_eth_stats() and the corresponding
> register, GLV_TDPC, is not implemented[1].
> 
> Use i40e_eth_stats.tx_errors instead, which is actually updated by
> i40e_update_eth_stats() by reading from GLV_TEPC.

...

> Fixes: dc645daef9af5bcbd9c ("i40e: implement VF stats NDO")
> Signed-off-by: Dennis Chen <dechen@redhat.com>
>     Link: https://www.intel.com/content/www/us/en/content-details/596333/intel-ethernet-controller-x710-tm4-at2-carlsville-datasheet.html

Hi Dennis,

Thanks for the detailed explanation, it's very much appreciated.

One minor nit, is that there are some leading spaces before "Link: "
a few lines above. But I suspect you don't need to repost just to
address that.

Reviewed-by: Simon Horman <horms@kernel.org>

