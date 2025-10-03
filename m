Return-Path: <netdev+bounces-227724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC545BB62D3
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 09:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F351AE06AB
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 07:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C792417D9;
	Fri,  3 Oct 2025 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yfqz/380"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B0222D9F7;
	Fri,  3 Oct 2025 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759476809; cv=none; b=oKWG4Fzpaf4yFX/YR4aD0ZJBtPULL0zmDTHVhzRhuzOaxlUz9GOb+c+r64NNwDg4yzWOd0Ch6Vr2te+8FgojiUJcbI2KoOCIFSSznZMqcWuyJu8DSZKtj2DjJEh8bcbyZrlf8u0slr+YXn+cA3Jbs1eCg+q8RUNVCx6t594ORiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759476809; c=relaxed/simple;
	bh=B4tE9QKrxptfIX5Q80EK++1ZwvbcKDyl6d3JAR58kYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnBHV9fAlqrXhBpl54ZlBhKPAAPn1a1PFFIbO0TiwWJYCIes+BRZlyOldVvdRf3rsEDcvdEVpWnbMzJqoqtU+N0hhaKfaF375r8Z+ssOFivQVsdzW9wuhHY4WC26kYnjwZ79HpawlT9fbqQ0sFmwQkmsumybHhu6r6klQB/sLB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yfqz/380; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0742CC4CEF7;
	Fri,  3 Oct 2025 07:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759476809;
	bh=B4tE9QKrxptfIX5Q80EK++1ZwvbcKDyl6d3JAR58kYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yfqz/380QdLUyU2l8Kjh+C0qekBfRS3wt8evAZ0Y0QZaIjYltFbPiNWZYtJJgwDEH
	 BLCrDcf3IuR+NrHsHOVb8V5lNbA1PjsFBW2AJaXV47fROM8qJK/PhX8EwQJEC0q+Nc
	 0ijQeiR26fdx7X8i9R28t7IFrU+s63rJj0+Ure1uqUaEEtrmWSvlbXyvND/PF+Z+Fh
	 YDQ+PD8+NxuMkecatTl1ZRwZFrNyylGFm5b8nfYECYVa+xGe51789Us2V1Yj79tXt+
	 EsLtDiuMNPdcHIbxWy34kVDUwePYiw3RsIxfEdCgn13whq5EM2V93wncGiOPkl4k+W
	 6GHqKpMgRZySw==
Date: Fri, 3 Oct 2025 08:33:24 +0100
From: Simon Horman <horms@kernel.org>
To: Erick Karanja <karanja99erick@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	david.hunter.linux@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: fsl_pq_mdio: Fix device node reference leak in
 fsl_pq_mdio_probe
Message-ID: <20251003073324.GA2878334@horms.kernel.org>
References: <20251002174617.960521-1-karanja99erick@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002174617.960521-1-karanja99erick@gmail.com>

On Thu, Oct 02, 2025 at 08:46:17PM +0300, Erick Karanja wrote:
> Add missing of_node_put call to release device node tbi obtained
> via for_each_child_of_node.
> 
> Fixes: afae5ad78b342 ("net/fsl_pq_mdio: streamline probing of MDIO nodes")

nit: no blank line here

Slightly more importantly, although the code you are changing
was added by the cited commit, I think that the bug existed before then.
I wonder if the fixes tag should be.

Fixes: daa26ea63c6f ("Merge branch 'octeontx2-fix-bitmap-leaks-in-pf-and-vf'")

> 
> Signed-off-by: Erick Karanja <karanja99erick@gmail.com>

One minor comment on process: as a fix for networking code, most likely this
should be targeted at the net tree. And that should be denoted in the
subject like this:

Subject: [PATCH net] ...

And if you do post an updated version, which is probably not strictly
necessary, please be sure to observe the 24h rule.

See: https://docs.kernel.org/process/maintainer-netdev.html

The code changes themselves look good to me. Thanks.

Reviewed-by: Simon Horman <horms@kernel.org>

...

