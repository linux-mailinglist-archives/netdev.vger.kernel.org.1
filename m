Return-Path: <netdev+bounces-229667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F69BDF8E6
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85C944F23CB
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C406F335BB7;
	Wed, 15 Oct 2025 16:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uv5cY7w/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD71330D41;
	Wed, 15 Oct 2025 16:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544487; cv=none; b=FFcyXAFNGiydMRvhNap3IFeejw9A5JpzGZxYs1ykKKeILxvDc7hMr4jcTvW8VVSE/JYFgIfPl8sc2N1CImOa0ft1MHJMRfDfgj1lf7/u+7YEVsYh3oUTpM3vD/l+iHE9Ag6+luwt9BcZle3A0TPp+dHSkmmV4GjIW8AiUPziIK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544487; c=relaxed/simple;
	bh=T0y5eIFSjnQ3NKyt3cDPuOjJjEWbutGOBAvGeGBCSuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4o6fKtIh1Fb0QFXzKqqVz51azrL5z6MdI0FmNSasl+/MbRe0Cezvbq3Vo9wbMtv3M63U/8pMDRp7RrBDm0bURx5ssoOV02HinC5fncphlhyQR0kCi4X86zE+vBxkLbnBqlkdPQcIwarhUYQSEOOl2OgrNDxfA5OrxTCSWMMIDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uv5cY7w/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65015C4CEF8;
	Wed, 15 Oct 2025 16:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760544487;
	bh=T0y5eIFSjnQ3NKyt3cDPuOjJjEWbutGOBAvGeGBCSuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uv5cY7w/e9ySfXqgSDXDW0M4XcEG/3Qpbf2WAwHBfBEDaEAe3f7qWZKfq5FIXL/de
	 YG5pyrV6Ep7+T0CYLxR7Wdivvw+qqvWHAOznQ3yu/gQbZym5RfxI4rKT8NPDYw+D6H
	 fVgicFgDTViffSEB7hnFAWg1Lh395dKjNg33JpXCGG8ctbatA2mMZlKTi4n2AAcby0
	 kK/wCmppJb/XtHQ5q1QldDx/jZd9f065uML/qZFkAZIAu3gsPCwag3ZN69bRDUJZiy
	 j6MpyjLJ0H6T3bnvJ+LRREFu8zebDlpJwhyRc1QLhG2Eh5KxnmvLiUUhcEsTrA3p6y
	 fL+4gPJW7zcWQ==
Date: Wed, 15 Oct 2025 17:08:02 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 09/12] net: airoha: ppe: Flush PPE SRAM table
 during PPE setup
Message-ID: <aO_G4qCvGhlXq_JS@horms.kernel.org>
References: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
 <20251015-an7583-eth-support-v1-9-064855f05923@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-an7583-eth-support-v1-9-064855f05923@kernel.org>

On Wed, Oct 15, 2025 at 09:15:09AM +0200, Lorenzo Bianconi wrote:
> Rely on airoha_ppe_foe_commit_sram_entry routine to flush SRAM PPE table
> entries. This patch allow moving PPE SRAM flush during PPE setup and
> avoid dumping uninitialized values via the debugfs if no entries are
> offloaded yet.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


