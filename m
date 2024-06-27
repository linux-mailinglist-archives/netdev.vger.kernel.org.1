Return-Path: <netdev+bounces-107481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A54FE91B292
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 01:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D61284788
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 23:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFE819A2AE;
	Thu, 27 Jun 2024 23:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyCbt2eE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A38B1C6A7
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 23:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719530149; cv=none; b=LsiHLDh25Di8+7BrZs+vq46caJEZqj/KSRHXKwGUamph1bov3SBrS83jLRP3OW/rG1Tc3N7AY5D2nHus/PRW/vDzQY0pSxTOk3MeRgCHKZoZy4KC65OJ43rzXRQ02FlBDwB622byVcyWY69fdJ/PedpqjNG5TSqRvV9xr9cWQ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719530149; c=relaxed/simple;
	bh=w2/u9bxkTV3i8fsHrD20bwbvBiDa5x0YQpEfJne60cU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qEZjhELyXry5OUgbZFMGG76/9F9Qxl7UaPYxFkobBdFL4Egs8CUAp7lVZO7karngSKrQljkRJE3KuXw2JJ6SUeUIDOdgXUniTom3Rr/csOoJgADMw8lXjq2pNUfJYPY+h90hzz18I9y5tGw4hK9KbP19HMLiOT7nekbp0XuWtFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyCbt2eE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D91FC2BBFC;
	Thu, 27 Jun 2024 23:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719530149;
	bh=w2/u9bxkTV3i8fsHrD20bwbvBiDa5x0YQpEfJne60cU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PyCbt2eEUrIZwryeyrXbRWXPeZBB/CQVyXcO6L4WlcDUqWubFWPaip1fty5LmoBt9
	 INZjXJ4kvqUMVK/TZkl8hE8DH256hoJzX1Fh4nxqVgvT71GHwltyjNAvUmfoSIcF8G
	 Z/hYYTjmDFIeMJ0UqIcLQTj2Iz8JVRrPZ1akGSmXYl7fyRV1U1E00pto066AsVGIGA
	 Xqu5Yl7zf8RuOYct8UnshHQ1pT/a7F8AGeojpR7HNG/FOplyNwR023CdirDLtaevBu
	 P8+/FeixjwyRxiIz0D3whpjOczwP4oA2GoaDnN79kSkQ4ztPqWn0dNJIA94PPgJkdC
	 ts/1Hb2/HxMTA==
Date: Thu, 27 Jun 2024 16:15:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Milena Olech <milena.olech@intel.com>,
 richardcochran@gmail.com, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Karol Kolacinski
 <karol.kolacinski@intel.com>, Simon Horman <horms@kernel.org>, Pucha
 Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net 1/4] ice: Fix improper extts handling
Message-ID: <20240627161547.757f806d@kernel.org>
In-Reply-To: <20240625170248.199162-2-anthony.l.nguyen@intel.com>
References: <20240625170248.199162-1-anthony.l.nguyen@intel.com>
	<20240625170248.199162-2-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 10:02:44 -0700 Tony Nguyen wrote:
>  		/* set event level to requested edge */
> -		if (extts_flags & PTP_FALLING_EDGE)
> +		if (config->flags  & PTP_FALLING_EDGE)
>  			aux_reg |= GLTSYN_AUX_IN_0_EVNTLVL_FALLING_EDGE;
> -		if (extts_flags & PTP_RISING_EDGE)
> +		if (config->flags  & PTP_RISING_EDGE)

nit: double space here

