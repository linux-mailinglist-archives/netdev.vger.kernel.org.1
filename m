Return-Path: <netdev+bounces-143177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E2A9C1592
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 05:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0540C1C20C14
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 04:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427DA13D278;
	Fri,  8 Nov 2024 04:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkNe8C3I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE86322E;
	Fri,  8 Nov 2024 04:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731040920; cv=none; b=TdH8UVfN7B5Fnzgq22uOzd2P2/Bq8JvbhCsWXFwP+Awus7hSJXhvMjE6Akcx2bJBKDA2f+NJuLKJ4X+11H0cqAzEpfifZiebk4bNpBZTDqoX9uGWgiRzNs3zfDvh3KGAZHglVSmq/V7r3GFS2lri71kV1ne5/wppqJWZQfPY+fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731040920; c=relaxed/simple;
	bh=42icZBoK9V7F1r9cTIkKrKqQHCaMvesCSobJJBfi1e0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q1hQg2hujNJjyfFJJYHWLrDOsfujPCwcMkMBOCmBO75w8IJjuxp0qgwVLub1FySvXG0b004NNY/RErRO5bzPuq0NeIK3yyRFUUMhHCNdgr3Wg9F8AajDDoRjXH3H8J2ZwVCEImh6IGjAn+bVJkrhIaRVsS0qJIooAWD8+BUB6vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkNe8C3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B750BC4CECE;
	Fri,  8 Nov 2024 04:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731040919;
	bh=42icZBoK9V7F1r9cTIkKrKqQHCaMvesCSobJJBfi1e0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TkNe8C3IhTDmGkcsXoR98/Jui2Yma4S/ZLPNEurJkDuAJtmYPviluiLwir2SAkrGO
	 jei7wG7pSHpDeoYfYi4vQn7NfmDjWEGwmmq28P0htVc4F4tfhv4KtGWnPSTejZvlFz
	 d9F8a3as6uTUox51Ze3UVNn1CfoY8859trJtVcMir2cdg5dvhoJoNzETXX+zgPPKT2
	 Svx8YWTgfqtfnn+QoJa41jfgqxIrF6/tHD+dhOlbfXErIHDqmKHHeRBS/bYhVj1CIT
	 QwTVF9mJD7kFfKG02Fw5szHsZeDwjqFA1lrGpLu+CXa72hPKMiO7LC0u8DtJ4kCX93
	 whTbzG/7GBV2A==
Date: Thu, 7 Nov 2024 20:41:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Khang Nguyen <khangng@os.amperecomputing.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston
 <matt@codeconstruct.com.au>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ampere-linux-kernel@lists.amperecomputing.com, Phong Vo
 <phong@os.amperecomputing.com>, Thang Nguyen
 <thang@os.amperecomputing.com>, Khanh Pham <khpham@amperecomputing.com>,
 Phong Vo <pvo@amperecomputing.com>, Quan Nguyen
 <quan@os.amperecomputing.com>, Chanh Nguyen <chanh@os.amperecomputing.com>,
 Thu Nguyen <thu@os.amperecomputing.com>, Hieu Le
 <hieul@amperecomputing.com>, openbmc@lists.ozlabs.org,
 patches@amperecomputing.com
Subject: Re: [PATCH net-next] net: mctp: Expose transport binding identifier
 via IFLA attribute
Message-ID: <20241107204157.683bca11@kernel.org>
In-Reply-To: <20241105071915.821871-1-khangng@os.amperecomputing.com>
References: <20241105071915.821871-1-khangng@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Nov 2024 14:19:15 +0700 Khang Nguyen wrote:
> However, we currently have no means to get this information from MCTP
> links.

I'm not opposed to the netlink attribute, but to be clear this info 
is indirectly available in sysfs, right? We link the netdev to 
the parent device so the type of /sys/class/net/$your_ifc/device
should reveal what the transport is?

