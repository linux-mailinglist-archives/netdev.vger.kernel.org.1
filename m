Return-Path: <netdev+bounces-123777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38A09667A5
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 19:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022C21C23479
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 17:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FBC1B8EB3;
	Fri, 30 Aug 2024 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGLdY8ZC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEF113BAF1
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725037784; cv=none; b=rifthr0pKqzyJUyClVppbDb5zRx6HxCukq65CYcOSdaUqqwxAzjRtAVKGm6+h4DXiMOe1fYf+54OWU7i4bBk9ARp+Z2QkyEWwOIw1d8P/ufvryMztFyXYuMcO2CAR3hzbeIala5GgRiW7QFvAhhHEv1lq+qUGnQ6DvQH7QnWPmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725037784; c=relaxed/simple;
	bh=4QKC0qAnHHKl+ZYhRQ6ngqofhFqLsGebKrHRcrS7IwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdWoo4OPMOKNM3WF8r6HR91xebXvNsIuxtaWuJCI/Vd7FGbNwlsJt6wNUDucLVM8fEcjbNVmP8SntPdKgN/bgaiBPfvd8SEIUOOuEIT3jFosNd9Kfgf5/XDe2V5N4RASFgOCi+dVprMV0fF2jFkLHpw7pTs9zNpuF/W0srQcw1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGLdY8ZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E167C4CEC2;
	Fri, 30 Aug 2024 17:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725037784;
	bh=4QKC0qAnHHKl+ZYhRQ6ngqofhFqLsGebKrHRcrS7IwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oGLdY8ZCVhtHN9xYnFi4G3Bwmup6jDQTCZ2dCl56zHn4K6yjHnNaLDcQ4T5G4e7vs
	 cKoeDNREw8JM6ZklmFP11xqEqVqiM8bqTVETkxSfZAr8favkxgUJna9luFveRe6+vL
	 e55aY6/O/a2IIGSH+IsSpHYttn0SrrLvIhFGOBJrNZw8aUaEK2z3CUjtkSGsiwqvpl
	 08DXkwyHevpkZI0lg/7YX10ywgWpUrDuXOzjVLAIitbZkBVnaZw+QET2tocVF7Mo+w
	 5bd6J4ZsRc9iG8fdVwehFqmwBZmxFii17HbX7r280ZL+pgSoE9PfpFlqUvFmvuenlZ
	 rb64AOYJMgIiw==
Date: Fri, 30 Aug 2024 18:09:39 +0100
From: Simon Horman <horms@kernel.org>
To: Srujana Challa <schalla@marvell.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, sgoutham@marvell.com,
	lcherian@marvell.com, gakula@marvell.com, jerinj@marvell.com,
	hkelam@marvell.com, sbhatta@marvell.com, bbhushan2@marvell.com,
	ndabilpuram@marvell.com
Subject: Re: [PATCH net-next,v2,1/3] octeontx2-af: use dynamic interrupt
 vectors for CN10K
Message-ID: <20240830170939.GZ1368797@kernel.org>
References: <20240829080935.371281-1-schalla@marvell.com>
 <20240829080935.371281-2-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829080935.371281-2-schalla@marvell.com>

On Thu, Aug 29, 2024 at 01:39:33PM +0530, Srujana Challa wrote:
> This patch updates the driver to use a dynamic number of vectors instead
> of a hard-coded value. This change accommodates the CN10KB, which has 2
> vectors, unlike the previously supported chips that have 3 vectors.
> 
> Signed-off-by: Srujana Challa <schalla@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


