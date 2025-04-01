Return-Path: <netdev+bounces-178548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6B3A7785C
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 12:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80D516A6EC
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 10:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3911F0990;
	Tue,  1 Apr 2025 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdHIdcFv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974A81F098E
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501671; cv=none; b=G/d45jl0sClzZkBder5VSoDbpVeZx/V0SmiY57/RNtxLmeOu4KpQJ6SGiEA0YeEksKJ6PTZK2XQaNcSk6/MYEXj32fy14pYhxFY7YsR7UmWbatLK0IS72mUEpCtorh3eT4hb48xg54jFySffASNxCq6CYPux7YFpHKMcomN83dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501671; c=relaxed/simple;
	bh=TwUbtSRE2uBDBgVN4rSVrh6kpB+iNKhibBxhdi/cMDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsrgZ8P1j1qDS9lnE2yjnIODNKMrRveqD7WgcmYuhMxoMPy68UZT8+M3XSxxeJ/YHa7J7wdq27Om+4epz4Fj6PbBH9GX3bht1E00S7R5kR1q+abn4T5sddKL3ImTMDBCbhJiKhJgSrnJak42ADOVs4By3Yx6lAg0/5TvjTyfO1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdHIdcFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132B7C4CEE4;
	Tue,  1 Apr 2025 10:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743501671;
	bh=TwUbtSRE2uBDBgVN4rSVrh6kpB+iNKhibBxhdi/cMDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SdHIdcFvOSiijk/430tmyjjw/BhUNHk1XOoC0zsmJgAU1Q65zCDFmLiI5OIxTBGBm
	 heFQYAuhqbaF/wSyiI2z4NnDB06DI23Dj1gAO1EbkZtWpSnHLx31xJ3spoO9vhY6Cy
	 Wq8hZYNZ0Ho71P32LWoLUDCuvcN+qfbkd49XzX0a1fgxcj/rh59Br7R9VDN7s3S6bD
	 +aDz+AkFea8iCbAJwIdMuug2rNCjhd+AuY5NhwfJiTaHtg0Be32c6inLqL44JYbRXl
	 VS97PU11K8hcxDEWhIQtpFTjnB3nLuaZ3S9TOCzo9pSdZTkvxcO8h7uodPNhSWmxyw
	 +r68t1VpcwK9w==
Date: Tue, 1 Apr 2025 11:01:07 +0100
From: Simon Horman <horms@kernel.org>
To: davemarq@linux.ibm.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Nick Child <nnac123@linux.ibm.com>
Subject: Re: [PATCH net] net: ibmveth: make veth_pool_store stop hanging
Message-ID: <20250401100107.GD214849@horms.kernel.org>
References: <20250331212328.109496-1-davemarq@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331212328.109496-1-davemarq@linux.ibm.com>

On Mon, Mar 31, 2025 at 04:23:28PM -0500, davemarq@linux.ibm.com wrote:
> From: Dave Marquardt <davemarq@linux.ibm.com>
> 
> Use rtnl_mutex to synchronize veth_pool_store with itself,
> ibmveth_close and ibmveth_open, preventing multiple calls in a row to
> napi_disable.
> 
> Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
> Fixes: 860f242eb534 ("[PATCH] ibmveth change buffer pools dynamically")
> Reviewed-by: Nick Child <nnac123@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>


