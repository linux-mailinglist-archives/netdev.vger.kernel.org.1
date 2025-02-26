Return-Path: <netdev+bounces-169655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA23A451D2
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 02:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D3E3174339
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 01:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FFF153BE8;
	Wed, 26 Feb 2025 01:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBb+v2n6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1E263CF
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 01:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740531690; cv=none; b=r98MUDHvvAoOZJMKDGZAxzHdwkSFnmViIiwl+yKjZIpHHYbgGrp1c0IeATqRcxa5lOk0EFcCBNzCpZOthH8Sm0FLigLGBAgIDImheVniPrCkQruHtxtPdVIOCdxyjH7TC3HybchjyPFaeAT82hBK17VIfKGveIZDV1azw5RTcsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740531690; c=relaxed/simple;
	bh=cqDAvg1hS1oxsK1CW7JWXegriKn6gZKBAGqqrcMrXjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LaRajCh7J0zMK7b8AVhrssTaSXMdHjkqPCp1lyQ+vxYZr56xhbFnQ2BN0mMY9/PWKacrjbxNZsk8hiez2tzUfY552xx9of/AYmMshbYCKtwIIoe5ZTlehlSiL2l9yyp5pFW7kE9HiceUk+jUeQTEuTM5Wje5seaaEE3y6ffOuQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBb+v2n6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3594C4CEDD;
	Wed, 26 Feb 2025 01:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740531690;
	bh=cqDAvg1hS1oxsK1CW7JWXegriKn6gZKBAGqqrcMrXjQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MBb+v2n62ajLtiyhQqqq0Mv/CwqXeBJpCFdyIA3kse4wZ7cVpNczSQKYF3EKe1FDS
	 +IAf36cWTbTkgCunzBwQn6nYN37c23BegTSmMm3yxjokT7kfMZJVBA9sZNIqR18ThD
	 YOVC4rIP0H5fsxJdBbWgk6cz++xFoQs44Phlk28uBb3O9xKgJOvWKKqbBE4xz3yO72
	 VY59Pl1FgHa9MR7DySJ9qB+1wfss75D5cVmApTwpkXp1h5/L5XW3GihjZSBJCaqZTm
	 U/+FfcE/Y2cyRBOXwuf5KN8XaUg01eUslRWGZxWNNNlSLi6hRrMunuLEqPUZ3tRUtE
	 lCuDpiA8AyoKw==
Date: Tue, 25 Feb 2025 17:01:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Andrew Lunn
 <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Joe Damato
 <jdamato@fastly.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next] net: ethtool: Don't check if RSS context
 exists in case of context 0
Message-ID: <20250225170128.590baea1@kernel.org>
In-Reply-To: <20250225071348.509432-1-gal@nvidia.com>
References: <20250225071348.509432-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Feb 2025 09:13:48 +0200 Gal Pressman wrote:
> Context 0 (default context) always exists, there is no need to check
> whether it exists or not when adding a flow steering rule.
> 
> The existing check fails when creating a flow steering rule for context
> 0 as it is not stored in the rss_ctx xarray.

But what is the use case for redirecting to context 0?

