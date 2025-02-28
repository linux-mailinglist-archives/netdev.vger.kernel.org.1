Return-Path: <netdev+bounces-170539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DDAA48EB9
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928C1188FE03
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D88413CA8A;
	Fri, 28 Feb 2025 02:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0XeMSH/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA48C2F37;
	Fri, 28 Feb 2025 02:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740710418; cv=none; b=q3f+a495btoWAKAK9CTpr2bi9XWgKsi53XK3IozImJ5xp8sTY2LLoAVOqXWZufmwvHTGiy2PGGFWnDB49aXgQXJVgv8HB426vdy6JD+9GXS27IexcYfHRqKTNfCYoZAIRFZjYAnAECrVE6EePqTyoT5xo3/X/EJeQSHfOdTqaTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740710418; c=relaxed/simple;
	bh=Ob2dsG0zgW0eN4CQrbKeXTe3FyXBv3AqsIuBlS2ahUo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqGCVK+56q/1b/zTp8aJnC0kSjoJWNnVX3SEvfmKP2rT3KU0fQ6VA5ZHiuHxKpX71AtngfUkzcGb61wtqEjBxNUEMpTSYGzDswkrHjCraUYCIgQXV2LyUsS5amlZ4e+58V1z1xcnNA4gPq54w5CS0V2Cou7SFi8i4cMePFNcrkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0XeMSH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEBDC4CEDD;
	Fri, 28 Feb 2025 02:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740710418;
	bh=Ob2dsG0zgW0eN4CQrbKeXTe3FyXBv3AqsIuBlS2ahUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S0XeMSH/uTHN4Vls9srGbPMx7+RsmhJ+TJY6eFjRPAdpVIwfIapCdmJ30wNl1cWp+
	 wbQftOFeMZTsrVnst/hfBxgxJdCpDczL73l2HzvSfs5RvJJ7z8ytWIaQ29+PK2kfAe
	 guKWkW7I3IM0mFoVE9vCykA0VRR+AD7PYwxFf5Nc2ncgiuTK9vrzr/+wKdDJ3Spcmb
	 YePOl7kQtZfiwvBCSn2U5VEtOZGgNpE1w1qP2OHn/wSZE2YuVn+VoeIGgMeA0zfTt+
	 hL0qSmot78FCs6tKASqcSW5ldkpy9JnzAzJt0G9FmkSaRzBwwnZDmgmsMp8Y6Y4oE0
	 moJoWUbwr/YzA==
Date: Thu, 27 Feb 2025 18:40:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Danny Lin <danny@orbstack.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: fully namespace net.core.{r,w}mem_{default,max}
 sysctls
Message-ID: <20250227184017.100fe713@kernel.org>
In-Reply-To: <20250226085229.7882-1-danny@orbstack.dev>
References: <20250226085229.7882-1-danny@orbstack.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 00:52:27 -0800 Danny Lin wrote:
> This builds on commit 19249c0724f2 ("net: make net.core.{r,w}mem_{default,max} namespaced")
> by adding support for writing the sysctls from within net namespaces,
> rather than only reading the values that were set in init_net. These are
> relatively commonly-used sysctls, so programs may try to set them without
> knowing that they're in a container. It can be surprising for such attempts
> to fail with EACCES.

This does not apply, please rebase on latest net-next/main.
-- 
pw-bot: cr

