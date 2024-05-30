Return-Path: <netdev+bounces-99237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2648D42D4
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 03:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC154285575
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 01:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60832125D5;
	Thu, 30 May 2024 01:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UT3npzOz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1F310953
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 01:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717032198; cv=none; b=TT/cmTtG70D6LarFOQRalZUnJzMKzlvqodpBqI+3WZW7+FvggL0fBL0/2weOosOallJ8+IErMsu+QrgWp+LorI9pcf8LjwWgrLmFC5XTyEjUvW8cV7zaTF1YR+eEgU69UGJ3ouN0AsLmlvnvNAGV9Q0GWYmxVA+mV+fRWynEReI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717032198; c=relaxed/simple;
	bh=7oq47AFl0/GRO6Usdc6OPFQbqmZE2Fqt0U2r888+Xdw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j10f67lPodQRPnKqvKKRLfK/+PfFMgG6iI+E+cR9UJqTfmvPI7Ohj9SLcbbXWDrqBCXav/hqLT55XkI3RQ11dDXDMfBobrE376mIE8/vMg3pQ411BYC2kg+PNJYk65nMHPo8VinylC3rfthkT3Wtbg7eGNikzkQe/OWyp/qTQz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UT3npzOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516B6C113CC;
	Thu, 30 May 2024 01:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717032197;
	bh=7oq47AFl0/GRO6Usdc6OPFQbqmZE2Fqt0U2r888+Xdw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UT3npzOzoTziZ+aBt6V/UpGI/fV4CFHMyHGXuEv5c8MzRZVbJWQNGx6GRNmohEJR8
	 KHJ0CrkId/qptuguynUZPABJyyMQlrKm53FwRO0krWIj4Si5i73tY3d6Vcknk2qtor
	 QnEdgNzZvRaXTSIYAunIIVZupoZ/IANrjNf4rTpFtIfq7mSFZhp1nZ9Jo5QE/ckBkZ
	 8XqhHV89CKnpJbTyL/QYmMaYw6Wh+nkm7P9QsWTxr+eta3WJSb0UJngS6O9nKm5tMg
	 sEHkDax7Ivw4xFVB7vLgelMuyNO6vMNvpUTzom8uXIHNA0DskTeXQPCkT+X0V2baEl
	 6Z5ro3n/fC2aQ==
Date: Wed, 29 May 2024 18:23:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Yoray Zack
 <yorayz@nvidia.com>
Subject: Re: [PATCH net-next 13/15] net/mlx5e: SHAMPO, Use KSMs instead of
 KLMs
Message-ID: <20240529182316.1383db91@kernel.org>
In-Reply-To: <20240528142807.903965-14-tariqt@nvidia.com>
References: <20240528142807.903965-1-tariqt@nvidia.com>
	<20240528142807.903965-14-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 17:28:05 +0300 Tariq Toukan wrote:
> KSM Mkey is KLM Mkey with a fixed buffer size. Due to this fact,
> it is a faster mechanism than KLM.
> 
> SHAMPO feature used KLMs Mkeys for memory mappings of its headers buffer.
> As it used KLMs with the same buffer size for each entry,
> we can use KSMs instead.
> 
> This commit changes the Mkeys that map the SHAMPO headers buffer
> from KLMs to KSMs.

Any references for understanding what KSM and KLM stand for?

