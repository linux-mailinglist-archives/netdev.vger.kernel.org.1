Return-Path: <netdev+bounces-30536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3AE787C29
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 01:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEDB81C20F2A
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 23:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E71FC2D1;
	Thu, 24 Aug 2023 23:55:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6987E
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 23:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B883C433C8;
	Thu, 24 Aug 2023 23:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692921319;
	bh=x3CxEd/s2I5FmvE0ZfGC4JVTtLnBusDroKzGw5VIhAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fQu9sArRSItZDAnBgfqCEDwsk1wVNE6lfU7C7QKK6oO/xxImtB5b7nm6VwoMgmb8G
	 2UcO8PwCJQsvRWJyNO39lxhOJ9K6ddiY50pdbSEnd8gc/EFN6onudsB8aaO+B0NGuG
	 Dj+9RT8+JFz1nogsqxRHi4ln6b5p7Vok+3udk2ZQ0Nohkh1IpaH8CiCxraBQhqtL6D
	 HSFURyO83gSpo+TBamgq9V9jaWN0V6ujNsS10yjnYoz44LBMNdv9EAqvC/XtPSOXTp
	 MntF+eDrBJ7cDAzy7CQ+IDd6oLtd2XPVFWFm2LmAgCgLyPFYB9j7LAW8i+QwSg4p/7
	 1tEFhDvz3+Ogg==
Date: Thu, 24 Aug 2023 16:55:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>,
 <sridhar.samudrala@intel.com>
Subject: Re: [net-next PATCH v2 3/9] netdev-genl: spec: Extend netdev
 netlink spec in YAML for NAPI
Message-ID: <20230824165518.3002655f@kernel.org>
In-Reply-To: <bb43b222-eddb-47ea-a36e-84415227439e@intel.com>
References: <169266003844.10199.10450480941022607696.stgit@anambiarhost.jf.intel.com>
	<169266032552.10199.11622842596696957776.stgit@anambiarhost.jf.intel.com>
	<20230822173938.67cb148f@kernel.org>
	<d4957350-bdca-4290-819a-aa00434aa814@intel.com>
	<20230823183436.0ebc5a87@kernel.org>
	<bb43b222-eddb-47ea-a36e-84415227439e@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Aug 2023 15:26:37 -0700 Nambiar, Amritha wrote:
> --do queue-get --json='{"q_index": 0, "q_type": RX}'
> {'q_index': 0, 'q_type': RX, 'ifindex': 12, 'napi-id': 385}
> 
> As for queue-get, should we have a single queue object with a 'type' 
> attribute for RX, TX, XDP etc. or should each of these queue types have 
> their own distinct queue objects as they could have different attributes 
> within.

Separate objects, I think. 
The "key" for queues is a tuple of <type, id>.

e.g.

 <Rx, 0>
 <Tx, 0>
 <XDP_Tx, 0>

are 3 different objects (feel free to start with just rx and tx, 
we can add support for xdp queues later as needed).

