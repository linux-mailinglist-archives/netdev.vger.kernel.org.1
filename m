Return-Path: <netdev+bounces-121086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0A995BA02
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 17:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B688E1F22C5F
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBFF1C944E;
	Thu, 22 Aug 2024 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBMiC3sj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552262C87C;
	Thu, 22 Aug 2024 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724340297; cv=none; b=lRFORyoDW8y6h52xO467VOsy0kpoaP9lF4IDsKz+EV0IKnOpYCTI9X78oH+QV8v5oW6sdAGH5yfxaeAzk9Zbdj9v3ePQKg/gKA/wL/it4qKS2z3GW7pCQjuMwHt4GoS0Jczvgsd3gBmiMdF1ZkORnV0M+QhLRatsfUcHWv7su9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724340297; c=relaxed/simple;
	bh=IN/C6tqSb5TAyPPbGwzLqMQ8NpXjz0YKmJUp1kYFsTY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KqxFRQHam316+jD2cBVZXu5JtjU3Dgrr/JAALd9Laq6smsnhe6am3ENqviQiuaxNiDQJU13O6ECgs+QzoytYrrO5nOZ6n0PNOsq1ZEsE5SjwAZwPx81wwFaDjfg0XWFLO0vIVs/jdeOkoXU59r/+Q7OMgPBQSCtn/DPEyX3ooE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBMiC3sj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69293C32782;
	Thu, 22 Aug 2024 15:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724340296;
	bh=IN/C6tqSb5TAyPPbGwzLqMQ8NpXjz0YKmJUp1kYFsTY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LBMiC3sjZy/BtC1Kq/BlIT9uuRXP+hyVWDFfHMUVivKmYFTp/PakTSoBwUta8dkzG
	 CzxOBzIotpVL9tTQY7iZYBpJF/fZSM2cbPhYejCB8V8bOxbyFGgZKhNwZJ/4YRod6V
	 0DJrbnBbOkJdNvyHfj7ufPYm/2uGYnJ1el2w6/6ob+EgBT/BglideREW28FNGSpHMH
	 9D4m/Q5+ERc50dnRhTMvnYmFE1vuyjC3oLaNqOOXXUJVqLW819Ofm8d9gpBdjbia+4
	 0XVvTi+MBT/EOClq50Tvp1Q0qnGV3LiF10zoZHVrb8g6Enu1GFUEHfFVVZ1mdVb3+L
	 kzzKyXv5pASDw==
Date: Thu, 22 Aug 2024 08:24:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Andrew
 Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org, Michal Simek
 <michal.simek@amd.com>, Daniel Borkmann <daniel@iogearbox.net>,
 linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v2 1/5] net: xilinx: axienet: Always disable
 promiscuous mode
Message-ID: <20240822082455.004a74c7@kernel.org>
In-Reply-To: <aeb2b005-8205-4060-8f72-e7b2f0c1d744@linux.dev>
References: <20240815193614.4120810-1-sean.anderson@linux.dev>
	<20240815193614.4120810-2-sean.anderson@linux.dev>
	<20240819183041.2b985755@kernel.org>
	<7e6caa8b-ae79-4eb0-8ccb-d57471e8a3d5@linux.dev>
	<aeb2b005-8205-4060-8f72-e7b2f0c1d744@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 10:25:06 -0400 Sean Anderson wrote:
> > Yes, probably. I put these patches first so they could be easily cherry-picked.  
> 
> OK, so to be clear: how should I send these patches?

You gotta rebase and repost the first two -- I would have taken them
directly to net from this posting but there is a conflict on patch 2
(as mentioned there).

Could you repost the first two rebased ASAP? (You can leave the rename
of i for the net-next series). I'm literally prepping  the PR
net->Linus right now, if you post soon they will be cross-merged into
net-next by EOD, making it easier to merge the rest.

