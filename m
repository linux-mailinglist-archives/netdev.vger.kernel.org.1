Return-Path: <netdev+bounces-137960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A279C9AB41B
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 18:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6322A28443C
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EB6136345;
	Tue, 22 Oct 2024 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeuQWrNZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A322E1A4F1B
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614949; cv=none; b=YiIwgW0qX1r+zsNpQmMbidsoiIK3ArJFCzi+wz7mOu+GgrCgVHtu9ZCbXh873iguK/cZJB7yuTlCHMDaDQ0ov1BUvBnEGAuPdipT8JkJyH91FQGwSy9zAn+rsNgvP/T8595KnzBLgS+HLgPu/5aiEykk1bjLMQ4L+678Ugk+IDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614949; c=relaxed/simple;
	bh=Ipo3RTH/frIFdnabEoFZ8Njj6Gbl6avpAc/hKaRMyPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFhLKYmGVqTtennHNsrhtqsWhywQtRXIP1u0DU+iRl2G/sBgXlOfRVoRz7HC8Fn6kNIXldu3AzHj2pJHfPXNb677zYiP+Ku2w8fXsbDa9ywpCaKx08j0zcqvWnDP+dtcS4cNVcLhBbAwmOr23icw7AmeAvjcQSs9h2jJElGCLrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeuQWrNZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3685BC4CEC3;
	Tue, 22 Oct 2024 16:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729614949;
	bh=Ipo3RTH/frIFdnabEoFZ8Njj6Gbl6avpAc/hKaRMyPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aeuQWrNZGY8rmAqAZpW3XzNeI4Lw/yZgY5cjE8j0cblzlNDjDEYW2/QThBAow2h27
	 9Bx+dcXkc0vBBf5OywNTBjBD8ZPwcZXIph9TBWrQhPPfGXbnk+MoPILL+/qJFVk0cH
	 9ayhnUoeyaZAoLdvbZTOek9AEI5Hz3TKZKVS3a/strggqQiG9T9+hUBCfpo09P+E8T
	 nWXRwspqBHxFpfr/EV3+gtZKHSoEcQowofYySdAGllh62CTpb2dLu7cnlfUrp3aeui
	 UUqkQzRboUedgyTMPKfcs2x01vXkzVx61oBFMlBm+dlO/V1pbDEtH63/9ghhiWzhEj
	 MFLtY7LR6k0nQ==
Date: Tue, 22 Oct 2024 17:35:46 +0100
From: Simon Horman <horms@kernel.org>
To: Nelson Escobar <neescoba@cisco.com>
Cc: netdev@vger.kernel.org, satishkh@cisco.com, johndale@cisco.com
Subject: Re: [Patch net-next 1/5] enic: Create enic_wq/rq structures to
 bundle per wq/rq data
Message-ID: <20241022163546.GD402847@kernel.org>
References: <20241022041707.27402-1-neescoba@cisco.com>
 <20241022041707.27402-2-neescoba@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022041707.27402-2-neescoba@cisco.com>

On Mon, Oct 21, 2024 at 09:17:03PM -0700, Nelson Escobar wrote:
> Bundling the wq/rq specific data into dedicated enic_wq/rq structures
> cleans up the enic structure and simplifies future changes related to
> wq/rq.
> 
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>

Reviewed-by: Simon Horman <horms@kernel.org>

In future please use ./scripts/get_maintainer.pl FILE.patch
to generate the CC list for a patch. Likewise for this
entire patchset. b4 can help with this.

