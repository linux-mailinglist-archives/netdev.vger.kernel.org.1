Return-Path: <netdev+bounces-205639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF950AFF72A
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 04:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78A55634F6
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 02:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3331727FD56;
	Thu, 10 Jul 2025 02:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htNbUoDa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB7727FB28
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 02:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752116284; cv=none; b=ThcQEeVilZXwzCboZN8U8FlUh3RHVqptHP/ONtfW+Ed9eKjbyWh3i4b//BHKButQX8kpOsLdEy54UzxUvx5DmNBA2qW/EPrY4tiMSSRpUFQTQlrdKgAVh+vkXsNMm4WpnGRMX8BLsoJUeR+BjhizT0N4tUU3H7VJYe+TfS2HBog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752116284; c=relaxed/simple;
	bh=Gqm8PWF15zuOwtrsFXijzjZhcOtUGc7/VaR9KIJV5Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jm9gTQMzsxfFkDgGfHGEbd5Z66q+nHze6W60XKQxC2zA3mBroYJkPVNMFSkADaESk3VJuIxVfZGrjEfyLzBRbK0sv7BCk9+UfK/pXXpbCE1/7NtIk+2lPbyeQCsuqnYK3eWGSt+nErmdVvaNLsVisjDdoUe2ngS+UclJUV7v+cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htNbUoDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABD3C4CEEF;
	Thu, 10 Jul 2025 02:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752116283;
	bh=Gqm8PWF15zuOwtrsFXijzjZhcOtUGc7/VaR9KIJV5Dc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=htNbUoDaMIKu4yULUOOaBU5mEG1+MQvFmItKmbPcfIXjSxWOKdMPUGDvqV1VIM9oV
	 4m2D5M/9jx4z+xAaLbiTIaW7bnjphKYMLoES8HfyL8DC7I1qjEwfVviKMHP4P1Jgh7
	 eGOSsJd5Z/p8yRR9g9NK8KL8kJiR/vIMTqFnfFTCByIZ4cnLlq/nUQADEe3Ar5UpJv
	 cnP+r492/ThvK7Ry31QupFRwIxrCX2DU+JGS2D/yOQZCRKg+C6L5OAh6vWBd1AvoWb
	 6EsaO1BC9qimjfcn/r4m0XCGVgmVpuJ1o1+ddRWzozbULaeZx0mSDFdpX81qtQ7ULw
	 bQPfJI8H31IaA==
Date: Wed, 9 Jul 2025 19:58:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next V6 09/13] devlink: Add 'keep_link_up' generic
 devlink device param
Message-ID: <20250709195801.60b3f4f2@kernel.org>
In-Reply-To: <20250709030456.1290841-10-saeed@kernel.org>
References: <20250709030456.1290841-1-saeed@kernel.org>
	<20250709030456.1290841-10-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Jul 2025 20:04:51 -0700 Saeed Mahameed wrote:
> Devices that support this in permanent mode will be requested to keep the
> port link up even when driver is not loaded, netdev carrier state won't
> affect the physical port link state.
> 
> This is useful for when the link is needed to access onboard management
> such as BMC, even if the host driver isn't loaded.

Dunno. This deserves a fuller API, and it's squarely and netdev thing.
Let's not add it to devlink.

