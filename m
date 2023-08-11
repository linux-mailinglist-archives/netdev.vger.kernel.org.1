Return-Path: <netdev+bounces-26955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C29D779A6F
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 00:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840711C20B10
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 22:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04368329DA;
	Fri, 11 Aug 2023 22:09:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6D98833
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 22:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F30C433C8;
	Fri, 11 Aug 2023 22:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691791788;
	bh=5ZQ9asPLQI7pPR2WeTvIJcdjhaYmLi1H/bem9LXgH2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hpCB1Xd+o8bU5lyEBUHxxvF9wQVkjMpBeC9bPcp29YIdVUADmiGdTp5UKae+O7Jus
	 2792slXbafFWGtJ5Ahe8qrrbyqNL4/vbTbyYFaIgSihkarxPw27pGXeSV6cyA1vS63
	 8tZ12AiWho4R0Hbhy4Tm7nQjt/25RCUkkXFQTditpiMUDMAB9irP/oaa+pzHvxGaR1
	 qUZPrT3hDogl6Oy1iQbGVL8kCxPgp8PlEVpK2d55KznMf2P+FFHdGehvqtDyQXS/8X
	 4TcSDv/alpy9UZD9Z20fNnNd42CSrPY7OPKWteHKNssre6b+i48ZG/RB1J4iD8dpaE
	 9NcZ3JIPTKdVw==
Date: Fri, 11 Aug 2023 15:09:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Cc: aelior@marvell.com, davem@davemloft.net, edumazet@google.com,
 manishc@marvell.com, netdev@vger.kernel.org, pabeni@redhat.com,
 skalluru@marvell.com, VENKATA.SAI.DUGGI@ibm.com, Abdul Haleem
 <abdhalee@in.ibm.com>, David Christensen <drc@linux.vnet.ibm.com>, Simon
 Horman <simon.horman@corigine.com>
Subject: Re: [Patch v5 0/4] bnx2x: Fix error recovering in switch
 configuration
Message-ID: <20230811150947.18528aca@kernel.org>
In-Reply-To: <20230811201512.461657-1-thinhtr@linux.vnet.ibm.com>
References: <20230728211133.2240873-1-thinhtr@linux.vnet.ibm.com>
	<20230811201512.461657-1-thinhtr@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Aug 2023 15:15:08 -0500 Thinh Tran wrote:
> As the BCM57810 and other I/O adapters are connected
> through a PCIe switch, the bnx2x driver causes unexpected
> system hang/crash while handling PCIe switch errors, if
> its error handler is called after other drivers' handlers.
> 
> In this case, after numbers of bnx2x_tx_timout(), the
> bnx2x_nic_unload() is  called, frees up resources and
> calls bnx2x_napi_disable(). Then when EEH calls its
> error handler, the bnx2x_io_error_detected() and
> bnx2x_io_slot_reset() also calling bnx2x_napi_disable()
> and freeing the resources.

It's looking fairly reasonable, thanks!

We do need commit messages describing motivations and impact 
of each individual commit, tho, and those commits which are 
not refactoring / improvements but prevent crashes need to
have a Fixes tag pointing to the first commit in history where
problem may occur (sometimes it's the first commit of the entire
history).
-- 
pw-bot: cr

