Return-Path: <netdev+bounces-40909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8157C91AF
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53848B20AFC
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC8319F;
	Sat, 14 Oct 2023 00:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdBr2wcD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562E17E;
	Sat, 14 Oct 2023 00:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744BCC433C7;
	Sat, 14 Oct 2023 00:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697242054;
	bh=6kpMwlfSNasU9AQMtLitDygCjCpDKwjI+adsPbqa9OA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UdBr2wcD9YbkjCo7SyrOU7C2P7cOL79UAKLiM1BqeppHoumCz76G9EbxX7WR2a7v0
	 Y60I+lH6kFJnJziGqDlxqaLZNQaM/awAaSidgcGYR+9q83BJ2QxSZEZjTjIuk348Pi
	 ffyBwFqzUhY++R8GyWNdABQ2xssKv/CC5BMpYdyuVHIv/3fh2UddcuGDzzePUzM0Zj
	 ZFZNP9zKbvbYP8evuVMaLBq3Uhtdj7X0PFkWqqfqRdG+UIQQ5Ycc52CB8UiFnpBAQL
	 Xh9FykSlCiuWrvhF9vOqoSKQIaFP4aVwTfh1v/CEpEBtX9JaFGG1pCzHzRUPMxahBz
	 kL3fZdQ9ejoyw==
Date: Fri, 13 Oct 2023 17:07:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Johannes Berg" <johannes@sipsolutions.net>, Kalle Valo
 <kvalo@kernel.org>
Cc: "Arnd Bergmann" <arnd@arndb.de>, "Jiri Pirko" <jiri@resnulli.us>, "Arnd
 Bergmann" <arnd@kernel.org>, Netdev <netdev@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, linux-wpan@vger.kernel.org, "Michael
 Hennerich" <michael.hennerich@analog.com>, "Paolo Abeni"
 <pabeni@redhat.com>, "Eric Dumazet" <edumazet@google.com>, "David S .
 Miller" <davem@davemloft.net>, "Rodolfo Zitellini" <rwz@xhero.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] appletalk: make localtalk and ppp support
 conditional
Message-ID: <20231013170732.587afd86@kernel.org>
In-Reply-To: <82527b7f-4509-4a59-a9cf-2df47e6e1a7c@app.fastmail.com>
References: <20231011140225.253106-1-arnd@kernel.org>
	<ZSa5bIcISlvW3zo5@nanopsycho>
	<82527b7f-4509-4a59-a9cf-2df47e6e1a7c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Oct 2023 17:57:38 +0200 Arnd Bergmann wrote:
> The .ndo_do_ioctl() netdev operation used to be how one communicates
> with a network driver from userspace, but since my previous cleanup [1],
> it is purely internal to the kernel.
> 
> Removing the cops appletalk/localtalk driver made me revisit the
> missing pieces from that older series, removing all the unused
> implementations in wireless drivers as well as the two kernel-internal
> callers in the ieee802154 and appletalk stacks.
> 
> One ethernet driver was already merged in the meantime that should
> have used .ndo_eth_ioctl instead of .ndo_do_ioctl, so fix that as well.
> With the complete removal, any future drivers making this mistake
> cause build failures that are easier to spot.
> 
> [1] https://lore.kernel.org/netdev/20201106221743.3271965-1-arnd@kernel.org/

Kalle, Johannes, do these apply for you?
I'm getting a small conflict on patch 8 and bigger one on patch 9.
If this applies for you maybe you can take it and flush out
wireless-next soon after?

