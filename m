Return-Path: <netdev+bounces-131642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECB498F1B6
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F038281E4F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BBA1865EB;
	Thu,  3 Oct 2024 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdkSQ2xr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A3A19ADA6
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727966519; cv=none; b=mihp7z2pjPM8C9THHMnCSUshHMRBkP9jayRne2JRcbN3L727iqtKjC+8AFC8e8UDMiNOD4fgoAFCFauxEX5ze7h1Bzm74mFkAlcCuEVsw96zLnLnp94Ev+B2ZvGRZiYtUkjxTPsZ88K7uWzzzMO5QpeqjPhAbZWLOOpVAWu1ZC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727966519; c=relaxed/simple;
	bh=E5JkrKanBs0zdb2UeHwfyOpOpKPNojg2iTaPYE4pQWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6vRml94TJ+zJfHl09a/ZRDHliikfvd+qC+PJ82j+wAqiO/kyHoJDLEVa4MBkUWS0KMBnW9Bd64lAPGCT42pGBJzRYDjYq016jGhyiTRmqcnxCzjHdBRa197q1YkSG089+QKVx7k1XR63yODEvVgCdebAisuFVe71j15xbePK18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdkSQ2xr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB005C4CEC5;
	Thu,  3 Oct 2024 14:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727966518;
	bh=E5JkrKanBs0zdb2UeHwfyOpOpKPNojg2iTaPYE4pQWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hdkSQ2xrH11BM9rlKC1Y4LHWKh/JjdGUU93M3Z8uycLvZKV3U2dx7fHTgRIYiLkfc
	 sjrS4GBtPqvyCs+57+B/EQ79+mvNtLQuG37ehPJ6ly6Dlue+oeX6jPLdB+cmzgU3/K
	 RgfcMEIVY/chLRvf2FYliJTgbP622ZN3J+K91LW61tsZ6OQk516L1gcOZxqxeeF4PL
	 hxepSerDaOcjmL5h/5BfNCQSggeCXsVVlKyNOlyV3I9+NrXPyQCOSjSW3PCCtup8Ls
	 k/fC2Hw+pue3+5YYnQXzfmodGqoVS2G4L/i5YTJD1DiAorpbAdDRUEjO7ZvpH02SIv
	 PC8a5y1cmtfWQ==
Date: Thu, 3 Oct 2024 15:41:55 +0100
From: Simon Horman <horms@kernel.org>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com
Subject: Re: [PATCH net-next v2] ibmvnic: Add stat for tx direct vs tx batched
Message-ID: <20241003144155.GS1310185@kernel.org>
References: <20241001163531.1803152-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001163531.1803152-1-nnac123@linux.ibm.com>

On Tue, Oct 01, 2024 at 11:35:31AM -0500, Nick Child wrote:
> Allow tracking of packets sent with send_subcrq direct vs
> indirect. `ethtool -S <dev>` will now provide a counter
> of the number of uses of each xmit method. This metric will
> be useful in performance debugging.
> 
> Signed-off-by: Nick Child <nnac123@linux.ibm.com>
> ---
> Thanks Simon for review of v1 [1]
> Changes in v2:
>  - move this patch to net-next instead of net 
> 1 - https://lore.kernel.org/netdev/20240930175635.1670111-1-nnac123@linux.ibm.com/

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

