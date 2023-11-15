Return-Path: <netdev+bounces-45643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5A67DEC1C
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 06:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00217281A19
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 05:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD74D1FA5;
	Thu,  2 Nov 2023 05:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqDFwTYb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31381C20;
	Thu,  2 Nov 2023 05:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0153C433C7;
	Thu,  2 Nov 2023 05:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698901653;
	bh=bEaqdWR5b16aP9FDPsmLQydpfrRhMcFq4QOwyVtFKS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TqDFwTYbT8gI8nvfa1xBpWQh9zmD09Z+mSW4JUajvZ+0YIvjbFd8KLQ8ha0Yzp5Ub
	 E8uUwtAOMjzxKY6WJy9nwXKFL42E4PtHR6/CHL2Uw6kZJnAqxT12zgwmWktS6Yyh4g
	 moP5nIAyrl331+He0lEmuZ8RFON57hqb9gTLg9F5N2WQcHQ/fSKlC8hB48XvTGuNzR
	 mHJXoi1I4WrOjLGfu36QE/7BhbzrT/MyOq2INwpRZIFE/CQI9doBRuz1HU2/ehCMTI
	 pfqAeEqo5YiNcWkzG21X8vmkgIKVYTIpF7DgoQ8e6hAHM1DY3XXN3/6pnIqNN3hWJX
	 H8F4kwsqfpiSg==
Date: Wed, 1 Nov 2023 22:07:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, kys@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, edumazet@google.com,
 pabeni@redhat.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net,v2] hv_netvsc: fix race of netvsc and VF
 register_netdevice
Message-ID: <20231101220730.2b7cc7d1@kernel.org>
In-Reply-To: <1698355354-12869-1-git-send-email-haiyangz@microsoft.com>
References: <1698355354-12869-1-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Oct 2023 14:22:34 -0700 Haiyang Zhang wrote:
> And, move register_netdevice_notifier() earlier, so the call back
> function is set before probing.

Are you sure you need this? I thought the netdev notifier "replays"
registration events (i.e. sends "fake" events for already present
netdevs).

If I'm wrong this should still be a separate patch from the rtnl
reorder.
-- 
pw-bot: cr

