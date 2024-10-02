Return-Path: <netdev+bounces-131256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 765A398DE45
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 17:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84701C227C7
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F2A1CFEC0;
	Wed,  2 Oct 2024 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USCeC8Ts"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7DF79D0;
	Wed,  2 Oct 2024 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881365; cv=none; b=pSli7dy3ePNK2MCxBlk88+b8mB8sDPKav7Ubpf8dqE0lGmUfuP8aNRKWBbUPz9SrnlxL1cgfh/Z/MJr/4nCEX513bBrlW5Zady9+F57d2tm9GxyHLIi/iYIV3eYQu/0KuwIz1tsWn+Vh/ijSbjXT2vYVMOK3Kos5H7YD3yqykao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881365; c=relaxed/simple;
	bh=kz9sm1H/Jlf/oEv+C9AfkkFYmdw5m1tzE+Yzl3hFmpo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5alMInaQDiXlKVh+MlJ9iWzYUWKLQiJInzfJ1+GIltx7N5vK0atziY4YVYHV/T1XBOTCJSpD7sOSW3zxun8tHJJPfJvgBinK+JoT9wY0mT/XpiIuOogeeAh59duYPzcxAArTJjC0aE9HRYkJKASRDUgGBWoL1DfIT8CLLOYcOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USCeC8Ts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D53C4CEC2;
	Wed,  2 Oct 2024 15:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727881364;
	bh=kz9sm1H/Jlf/oEv+C9AfkkFYmdw5m1tzE+Yzl3hFmpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=USCeC8TstSTdqIGCHLaZgmrxfsQsxkaGjKUuUKYkBvSQ8mWejI2vLqzRET1fyiCq7
	 fpjIXg5qXfHlpmqiMJrCmnZb44nVFqXZE2ieA6j2FBxRVMJcr4rPbJm2Kj0pN7ds/R
	 SaN55aqo7u2BY4Rj4jS/1nJFydtFb41/oFecoWdwTQ3yzh6woET3IrUTrh2NKiHCqM
	 tdzR2RvLFdGOLHHuTbshBnb+JjTnsrLDaIjlNkdfrP/2CCvmyxUHEDwHjhLfN2H8Nv
	 +sxp5n3wFitshEO6RIP5yp3dtZqNQ0vgM0M3cW1TUmoxLnxbW7qjlK848RYF7610ux
	 THVRRDCMiwhpg==
Date: Wed, 2 Oct 2024 08:02:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Simon Horman <horms@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, thomas.petazzoni@bootlin.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net v2] net: pse-pd: tps23881: Fix boolean evaluation
 for bitmask checks
Message-ID: <20241002080243.0842a2fd@kernel.org>
In-Reply-To: <20241002170047.2b28e740@kmaincent-XPS-13-7390>
References: <20241002102340.233424-1-kory.maincent@bootlin.com>
	<20241002052431.77df5c0c@kernel.org>
	<20241002052732.1c0b37eb@kernel.org>
	<20241002145302.701e74d8@kmaincent-XPS-13-7390>
	<20241002073156.447d06c4@kernel.org>
	<20241002170047.2b28e740@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Oct 2024 17:00:47 +0200 Kory Maincent wrote:
> Should I drop it?

Your call, if you want to change things for consistency that's fine.
But you'd need to repost against net-next and without the Fixes tag.

