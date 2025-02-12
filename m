Return-Path: <netdev+bounces-165385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D5EA31CE9
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 04:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E363F3A330F
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2891DA60D;
	Wed, 12 Feb 2025 03:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ur6sHJJ9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CBE271839
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 03:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739331390; cv=none; b=VZ7tX5Mf7tnP7Mt3tiKkL2KxCgdyFqgDjMWQHPsxeSH8O87D3vQMf5+6h/352g+Ng9genrrOR6Dg1VYTwZoPPh/ce3uizUNoBEbk0Q8YaDW/vpgtyApxvZflAaFLZXk55+krxw3Jcey70B6mBnk3AEMjexBMMZsu83CFgcdkYCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739331390; c=relaxed/simple;
	bh=kv8niypqxXp/La0LfVLsr/NE1LfLnW9BYQTMCXUiXzg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LTpw3BWAt+0iFRXpv5/y9EkuMY4UQwMTM6ZDoC0lg1MDyvSj6OJen033zapk93M15e/7oPQQOEIEHW5WHPeD/eEfP2inGICk40V4/1GpfIV15pyFBewyodU+3WBxczOYXHRyAFD3ILvDP6AJ1tAccPvwKympsnUrBTpu1LFPTs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ur6sHJJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C641C4CEDF;
	Wed, 12 Feb 2025 03:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739331389;
	bh=kv8niypqxXp/La0LfVLsr/NE1LfLnW9BYQTMCXUiXzg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ur6sHJJ98Ub2KiAWbgacfCEX08oDFEy+Lf1je0YKuX3YWXyFpOr7GnZnYmmDLTPxR
	 JBfSgj/DGOd4fqXsW1cnF4ruUDuFy6U0YRHLz+bzyl5B35ej/Q/OQaTOnVntgLLwkg
	 NRRkgSwsw8Yc38vFab6jc3fJdm2S+R2yM8n/txsPeFwW2wLgkSvKTcaEP4Nes3hqXY
	 YvA0A129mle0FDPH/eyL9j7tl66l9k/x4hXbKgQjZTwcGEdN9zQobs2l7dMpxHN1m4
	 H38ZleiRB6MJABBmbYLRL3GSsYEZPxWnGBC+ykqlVezRooToO70Tvxkh0+2JGKYmUf
	 tpjDvWBCqh71g==
Date: Tue, 11 Feb 2025 19:36:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Gal Pressman
 <gal@nvidia.com>, Simon Horman <horms@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>
Subject: Re: [PATCH net-next 00/15] Rate management on traffic classes +
 misc
Message-ID: <20250211193628.2490eb49@kernel.org>
In-Reply-To: <20250209101716.112774-1-tariqt@nvidia.com>
References: <20250209101716.112774-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Feb 2025 12:17:01 +0200 Tariq Toukan wrote:
> This feature extends the devlink-rate API to support traffic class (TC)
> bandwidth management, enabling more granular control over traffic
> shaping and rate limiting across multiple TCs. The API now allows users
> to specify bandwidth proportions for different traffic classes in a
> single command. This is particularly useful for managing Enhanced
> Transmission Selection (ETS) for groups of Virtual Functions (VFs),
> allowing precise bandwidth allocation across traffic classes.
> 
> Additionally, it refines the QoS handling in net/mlx5 to support TC
> arbitration and bandwidth management on vports and rate nodes.
> 
> Discussions on traffic class shaping in net-shapers began in V5 [2],
> where we discussed with maintainers whether net-shapers should support
> traffic classes and how this could be implemented.
> 
> Later, after further conversations with Paolo Abeni and Simon Horman,
> Cosmin provided an update [3], confirming that net-shapers' tree-based
> hierarchy aligns well with traffic classes when treated as distinct
> subsets of netdev queues. Since mlx5 enforces a 1:1 mapping between TX
> queues and traffic classes, this approach seems feasible, though some
> open questions remain regarding queue reconfiguration and certain mlx5
> scheduling behaviors.

/trim CC, add Carolina.

I don't understand what the plan is for shapers. As you say at netdev
level the classes will likely be associated with queues, so there isn't
much to do. So how will we represent the TCs based on classification?
I appreciate you working with Paolo and Simon, but from my perspective
none of the questions have been answered.

I'm not even asking you to write the code, just to have a solid plan.


Tariq, LMK if you want me to apply the patches starting from patch 6.
The rest of the series looks good. Two process notes, FWIW:
 - pretty sure we agreed in the past that it's okay to have patches
   which significantly extend uAPI or core to be handled outside of
   the main "driver update stream"; what "significant" means may take
   a bit of trial and error but I can't think of any misunderstandings 
   so far
 - from my PoV it'd be perfectly fine if you were to submit multiple
   series at once if they are independent. Just as long as there's not
   more than 15 patches for either tree outstanding. But I understand
   that comes at it's own cost

