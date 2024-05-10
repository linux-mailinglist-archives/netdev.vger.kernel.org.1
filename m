Return-Path: <netdev+bounces-95437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 709C28C23A3
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1141F1F25C49
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983B716F26B;
	Fri, 10 May 2024 11:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBV0dG2B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF2D1649A7;
	Fri, 10 May 2024 11:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340677; cv=none; b=LZzO28iAcgXZgtOKuGQn0pMfXqw2j21a4joGiumK0iesetSF33/zbAq90ODQOsbX9rtAa8MPNmJz8Ewj18wRZ1LwZkYtgp2slifLa3MRAMUK6sE2EMzmkKqG8URYkfbWDbS2cuOS0ZeuIZMfpi58rwN++LJVcy5ZrddsozllBSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340677; c=relaxed/simple;
	bh=NfdbhdAVAHRQBJ44L3ExJheIZgF/ZHuT3uIBv1oTXPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9CyQckAWEmgCTvdVlq5OTwrOJkYnJPAl88Sb1A4PfqaRwD/4d88CrSTyPA8gVD1momIp65aJFfvsz5/zDTc8n/a/hVCgFxHKZ8od8ucrc0qivYzZVjTxMQe8VDJ28sofzVIApP1Fi62v7lJ7qu8Qc2qTuFHKBWTTzRvbOuEbZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBV0dG2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037A1C113CC;
	Fri, 10 May 2024 11:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715340677;
	bh=NfdbhdAVAHRQBJ44L3ExJheIZgF/ZHuT3uIBv1oTXPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RBV0dG2BWIsiXPx418+HG6tphobPCsXnb3TKw3H3qbhccPpkA6eXVbvjNQ3CCxDFz
	 +IdSGOatLt+uMZFDR2mtZ3N3NrdqoUDDyHkdnJqgWHC8kRfboV3V8JiSKc7m1Ybki/
	 R0lPZsTlqsvzuArwLkqher+ozrOAzIkgZRxkgHNGFwpsQe1csx9f7DrK5j1ywJwt8j
	 T19uCTK7WskRE0x6MbZv7AE/8lCBh/ltqIvVnldYgoPy32wfBFpmf0FS/y+kfaTnmA
	 MyixvwzUlTaLiI2Agdw8qmZsk/cUkaItvcBTaz/1m9a9gYP0DJAwXC5NCe2cg55QEW
	 yPhhHOz5YXJrA==
Date: Fri, 10 May 2024 12:31:12 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v2 14/14] net: qede: use extack in
 qede_parse_actions()
Message-ID: <20240510113112.GQ2347895@kernel.org>
References: <20240508143404.95901-1-ast@fiberby.net>
 <20240508143404.95901-15-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240508143404.95901-15-ast@fiberby.net>

On Wed, May 08, 2024 at 02:34:02PM +0000, Asbjørn Sloth Tønnesen wrote:
> Convert DP_NOTICE/DP_INFO to NL_SET_ERR_MSG_MOD.
> 
> Keep edev around for use with QEDE_RSS_COUNT().
> 
> Only compile tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


