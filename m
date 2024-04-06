Return-Path: <netdev+bounces-85391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A73689A936
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 07:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9048282740
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 05:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2869200B7;
	Sat,  6 Apr 2024 05:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjBDtGns"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEEEA50
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 05:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712382391; cv=none; b=KWufb3tQSik1oeV9SNf1a3iMasXu5SOOjVISeCH3skN/s4iFMttQCpvUQ58dUFqWbr52A6bG70KSjnMGOEDSXs7QNum1C9orcYL0PkyhXLuISwcDzRnfnuWL95DjDZJfJhp+ftCFBKxCuHCzph/sAwb9w0ypnpf0ifbRSjUhReI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712382391; c=relaxed/simple;
	bh=Rh5H7ixZCofyZ7cuscRQW9/f2MSZZ4IH6V51+zEH7l0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FgXKS8Luix38WX01JLzS/o6tTuNMFDS/NnNohopQ67nbfMDc9ptbqpE7/9bX3bkum7gOM8m5eqJmLk7z2vByrgFDPykNh82AjLW3kv5Vpp9t/yghz4OM4rB21LZeiu2FtwGSDWuIqYO9QxTVd9wWZVFYXptaSbXvRTSRhCdf/Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjBDtGns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B55AC433C7;
	Sat,  6 Apr 2024 05:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712382391;
	bh=Rh5H7ixZCofyZ7cuscRQW9/f2MSZZ4IH6V51+zEH7l0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cjBDtGns4BwIlwlOuW0XIkLK7GBrp1XJcFpn6TXDyfYctYaKgEKnWhU2+MhY6A5d1
	 OppLbnySCBPGbhd6jtUwpGOAyHPou5AkYygQh3vuyv8R7MqlCGSDb2a4vrP6o7xacW
	 UQ7fq4wCWY33R2WtIAG9Lra2Zob35ifOitkTdwA/7E/7nLoc2M35imRpbtio1niVCs
	 hAn5sdoYe5Mb7g00ulHC1vp1UhJLwi1hdzXi+Faxl4mO+aMttxZP7GJDKvHhZxRuPH
	 dypmhveIIi87Ej8DAKMPdzr+INwEemljJSgMZ5qUwibe+v1h8E7P9YqEFtzOw9F4pd
	 K1Xrf26DlPcZA==
Date: Fri, 5 Apr 2024 22:46:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 Simon Horman <horms@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net-next 3/5] ethtool: add interface to read representor
 Rx statistics
Message-ID: <20240405224629.1f5a77b7@kernel.org>
In-Reply-To: <87ttkf2h71.fsf@nvidia.com>
References: <20240404173357.123307-1-tariqt@nvidia.com>
	<20240404173357.123307-4-tariqt@nvidia.com>
	<20240405215335.7a5601ca@kernel.org>
	<87ttkf2h71.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 05 Apr 2024 22:25:21 -0700 Rahul Rameshbabu wrote:
> > In more trivial remarks - kernel-doc script apparently doesn't want
> > the group to be documented (any more?)
> 
> I took a look, and I believe the behavior of kernel-doc has remained the
> same since the struct_group() helper macro was introduced. That said, I
> think allowing the documentation of struct_group() would be a reasonable
> choice/maybe worth updating the script.

Thanks for investigating! Dunno why this started getting hit so much out
of the sudden.

