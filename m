Return-Path: <netdev+bounces-88288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB588A6988
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 13:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283FD281902
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 11:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D72128809;
	Tue, 16 Apr 2024 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dq5V+jY7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80149127B4E
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713266555; cv=none; b=tntEnfqo0QwCx9mhrm2I14KKJY5YL49Fcvpl3ILvotIqpY2jfuWxqxbthQtfpUQm6JpPGgPPIggdr7oagGg+9HwtjB+Kk5dJUlvKedX3StxqEI2jAS8EK1YjMV80O6gOFZXASw4qfyIU0qYXo1w8kvat5BEzl4IaeQUwPKbkZFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713266555; c=relaxed/simple;
	bh=buAkJOJzt+8xTKcpzoowXvt/D0os9Lg49hZuBSgdhoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7f4QvOfvjtWf2qRPLYZrPPEA0dsNNU9LH0VPZvAFtBfcfTFOEtP1ZIQ9vnkDO9aNtJWfTXS/TATeBTkysTU2TjSlaQQx10UjMtPZWYVaW5BaW1qztagdQGO0S21VZeClUAK3E4hwLcQKkl1aTk1YEYnLqMlLi6m01WRqA5OgL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dq5V+jY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF64EC113CE;
	Tue, 16 Apr 2024 11:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713266555;
	bh=buAkJOJzt+8xTKcpzoowXvt/D0os9Lg49hZuBSgdhoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dq5V+jY7yI/6GSaQv6dvec7hYEc2h0doxm/nJZ4dOKXEls9qW6wQ5H/ztqKBmLiOE
	 tvWR8iwT9pCQXb9xYGF/j5HbjG7pPJKEG1I8iqtcNAVlondkYLBqnVIaSLhybQrK/3
	 jtYEGdcsDoCCrIQh7k4a4XRVrfnla7gcXswYGc0CPcvRrxUxLVRpjlXSsLqRS4mUfA
	 BFa5MIRs582qeNg73T8LBXMzYDzVC5Bm1+FhBP/NIdpKHdzLFcbydRnNFE+x/BOqOZ
	 A2BdmSxEBRCFCx2fCsFYpMCQwlhoctjeoeZJvlxENdL1FqduCw79k52kIWZCWSw4Mx
	 UniLEvVNnWLvQ==
Date: Tue, 16 Apr 2024 12:22:31 +0100
From: Simon Horman <horms@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	andrii.staikov@intel.com,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: Re: [PATCH iwl-next] ice: Deduplicate tc action setup
Message-ID: <20240416112231.GL2320920@kernel.org>
References: <20240415084907.613777-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415084907.613777-1-marcin.szycik@linux.intel.com>

On Mon, Apr 15, 2024 at 10:49:07AM +0200, Marcin Szycik wrote:
> ice_tc_setup_redirect_action() and ice_tc_setup_mirror_action() are almost
> identical, except for setting filter action. Reduce them to one function
> with an extra param, which handles both cases.
> 
> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c | 56 ++++++---------------
>  1 file changed, 15 insertions(+), 41 deletions(-)

Less is more :)

Reviewed-by: Simon Horman <horms@kernel.org>


