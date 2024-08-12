Return-Path: <netdev+bounces-117781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D624794F408
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 18:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D01E1F21682
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 16:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C8F187324;
	Mon, 12 Aug 2024 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8fGgjQe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB6F186E34;
	Mon, 12 Aug 2024 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479911; cv=none; b=ErloE8vEpgw2/Szb8PgrR49zB4wEMXN98O9h/RbhfAjy2l8vCqH/9atVpt5ZAxe2UPxvernO2SpRABo8rahIWer4fL49Y+kdZgI6t8vX1CkCzSpRfh4TR/VHAhYyIQxXGsDM3hf4s4GVUTziQUay8mvQ4EMx9TfV/qFTUfejQws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479911; c=relaxed/simple;
	bh=0N3l/THIj+g6e1lTf7tTyw4XJWS6sD5AsYtZ4TQRfM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnW24AwV31iBhadDbnRawATnXaW6+d+yBYDepDp8d9rp0JsspD6Ijnc+fxHbXLnMtqlQo0F3Fy+0XsKeD0SlfHpsDoggvdws3JEgrWJD5prmKxIE1q5xU0TF8/eTZHUGH7Ihs22u2ZO0KqaakPD6+p9mYp/6lIb3J80g5bAjFmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8fGgjQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A128C32782;
	Mon, 12 Aug 2024 16:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723479910;
	bh=0N3l/THIj+g6e1lTf7tTyw4XJWS6sD5AsYtZ4TQRfM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g8fGgjQe19NkhVu0IpwASmCKW4QUDop7BzG9NNidxNBLPMvxqNwjQh6z9SmPfVtpX
	 3Hp0bykbfI9BrxZBUj3tfeImiAp6c/REhbE/EXX5Cfz+y+z2H/eCN2VNQITJ5RUthe
	 kcuqGYZTGjIiSxwzsrg8MZjaaV4khWRNY0xft6DvtejsoarfCFp/b0TOzZgxM5cOc8
	 OEWG3Xhl57aseoCPALfuwBKeCBJIxwCc7lvatc/JPYpeTPthE6ZyV5VO+73/lb44/X
	 fH1R4lnnU0GINGjp/+hpix3QN9HeVFxRqmpT2zBtFbCQDtMOpvzWXaOVZkwjOLUbQF
	 OezQiUYm2o//g==
Date: Mon, 12 Aug 2024 17:25:05 +0100
From: Simon Horman <horms@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Breno Leitao <leitao@debian.org>,
	Sunil Goutham <sgoutham@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: thunder_bgx: Fix netdev structure allocation
Message-ID: <20240812162505.GC44433@kernel.org>
References: <20240812141322.1742918-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812141322.1742918-1-maz@kernel.org>

On Mon, Aug 12, 2024 at 03:13:22PM +0100, Marc Zyngier wrote:
> Commit 94833addfaba ("net: thunderx: Unembed netdev structure") had
> a go at dynamically allocating the netdev structures for the thunderx_bgx
> driver.  This change results in my ThunderX box catching fire (to be fair,
> it is what it does best).

(I saw that :)

> The issues with this change are that:
> 
> - bgx_lmac_enable() is called *after* bgx_acpi_register_phy() and
>   bgx_init_of_phy(), both expecting netdev to be a valid pointer.
> 
> - bgx_init_of_phy() populates the MAC addresses for *all* LMACs
>   attached to a given BGX instance, and thus needs netdev for each of
>   them to have been allocated.
> 
> There is a few things to be said about how the driver mixes LMAC and
> BGX states which leads to this sorry state, but that's beside the point.
> 
> To address this, go back to a situation where all netdev structures
> are allocated before the driver starts relying on them, and move the
> freeing of these structures to driver removal. Someone brave enough
> can always go and restructure the driver if they want.
> 
> Fixes: 94833addfaba ("net: thunderx: Unembed netdev structure")
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

