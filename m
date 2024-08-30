Return-Path: <netdev+bounces-123778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBEF9667A6
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 19:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533BA1F25539
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 17:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525501BA86D;
	Fri, 30 Aug 2024 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USydwINU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8411B5EA9
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725037796; cv=none; b=BxdLNmaybyQ2z0I1Bev6YUthm/TqWZn1h3rNwxrFRuNIf+TyppCR+V6EwCaLzxC7fYmfNSKnsLlf5d/avtBbQVPXroEgY6rArhJLpLWWCvMytPQS2+bbG5h19EzdImk7J3eqJReK9UXDBDTi98mGrVC3elreENaVSZ8LXXg2mh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725037796; c=relaxed/simple;
	bh=7dyE+MjT3/YsHv8gKBiEHSNkvzp8O+x7/xCvko6J1n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+AVRFsG9+4Dbo2b9hNX8BtVIRB+vbKvfWSBgBap0No37436jaA6CfN3hEH36HxRix2ZjA1etmd/vhuUNs8ikO0TjWGngFiP+jJe9W5QrKWx0oMqAH/aDseP3xcQxwnke2HEroJLRGOoC8R7ChuxVW+LWEK4KEgafJovbeVsmIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USydwINU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BABFC4CEC2;
	Fri, 30 Aug 2024 17:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725037795;
	bh=7dyE+MjT3/YsHv8gKBiEHSNkvzp8O+x7/xCvko6J1n8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=USydwINU0m767DfzkkhrlwM8F7G3obS/SzN+IMAT4ze4AQ5QFyYWVk6CDpm6Q0Y4S
	 u2ylHqff54Mwvbpsw1XdC+UkqNANIAU2Fx3ynLQyngVSP5SBjaHJ4L3xeSDFMhD8Yr
	 vtyQAA3Lgjhw/tlVr3sXKTUyH+FSpsjlJMcLAguCVlzO14Iq44MJvR+LmosHth5ykL
	 5aHS3R9R34JVJ2BwclaKbP2yfKDE35nDRt9CtaDZzRHXRluY/0N1MtYLvbDt9ALqkp
	 vl4SYHILP3CzGnUIDXh/Drgg7U6cNSd8dxE3WKWJ2EmkWlGNTWkymcGdtUChryyCaR
	 /OwHVcU5GwVJg==
Date: Fri, 30 Aug 2024 18:09:50 +0100
From: Simon Horman <horms@kernel.org>
To: Srujana Challa <schalla@marvell.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, sgoutham@marvell.com,
	lcherian@marvell.com, gakula@marvell.com, jerinj@marvell.com,
	hkelam@marvell.com, sbhatta@marvell.com, bbhushan2@marvell.com,
	ndabilpuram@marvell.com
Subject: Re: [PATCH net-next,v2,2/3] octeontx2-af: avoid RXC register access
 for CN10KB
Message-ID: <20240830170950.GA1368797@kernel.org>
References: <20240829080935.371281-1-schalla@marvell.com>
 <20240829080935.371281-3-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829080935.371281-3-schalla@marvell.com>

On Thu, Aug 29, 2024 at 01:39:34PM +0530, Srujana Challa wrote:
> This patch modifies the driver to prevent access to RXC hardware
> registers on the CN10KB, as RXC is not available on this chip.
> 
> Signed-off-by: Srujana Challa <schalla@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


