Return-Path: <netdev+bounces-40380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF71F7C7056
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 16:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AFC51C20D86
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 14:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CABE125C7;
	Thu, 12 Oct 2023 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrH2Ep83"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCFE266B8
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 14:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8216DC433C8;
	Thu, 12 Oct 2023 14:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697121144;
	bh=KZZrnpR6jbdzIOr1mKe+cq4MYlkeEtVcZgM/Ge5JRvo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mrH2Ep839+GCWwI/Mj34mOf8AEN3yTsPqcMvnNx8PCCwH/ztOQeatTrAvGfe/zoeP
	 9ALZZ5ueVmQYbECQXWVDZNcDPZkafwMF014eY9HO59VETKt33IQQVGo9wQ08ga5vxy
	 PulcntUaEZZBWdN9PLCtt2FAhwgN3PtonJyziDHB45x5qrVWGi1FT0Z1RoBpYJV2ft
	 /FuhTY4cHrf8W6P2msjRSKrWEBqzGBjXC2WebTL5QjWB6pwWyjwDozjZz03kKhEpgv
	 4C7J+t10mne92pFAPqap7OULLljUJVNzetowxJrKJrPYkEc96TQfDpfvU/GS0GkBDD
	 ZIEB/UXa9ucDg==
Date: Thu, 12 Oct 2023 07:32:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com
Subject: Re: [patch net-next] tools: ynl: introduce option to ignore unknown
 attributes or types
Message-ID: <20231012073223.2210c517@kernel.org>
In-Reply-To: <20231012140438.306857-1-jiri@resnulli.us>
References: <20231012140438.306857-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Oct 2023 16:04:38 +0200 Jiri Pirko wrote:
> $ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml --do trap-get --json '{"bus-name": "netdevsim", "dev-name": "netdevsim1", "trap-name": "source_mac_is_multicast"}' --ignore-unknown
> {'bus-name': 'netdevsim',
>  'dev-name': 'netdevsim1',
>  'trap-action': 'drop',
>  'trap-group-name': 'l2_drops',
>  'trap-name': 'source_mac_is_multicast'}

Wouldn't it be better to put the unknown attr in as raw binary?
We can key it by attribute type (integer) and put the NlAttr object
in as the value.

That way at least the user still sees that the unknown attrs are
present.

