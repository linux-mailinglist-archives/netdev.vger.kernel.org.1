Return-Path: <netdev+bounces-17334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EFF7514C5
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 01:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3970D1C210E5
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 23:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43B11D304;
	Wed, 12 Jul 2023 23:53:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82721D2E8
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 23:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6ED0C433C7;
	Wed, 12 Jul 2023 23:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689206008;
	bh=XTe/N96829qmSOTi0noddU401DVDGDi948n//ybUaKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X/MIJEmqzql5D9FK6ZokFkfbEjmhhWXeS3IYoz7ZdR6AmL9bRgcNV6glUcwSJr5Wg
	 xdMltVxEoGceE3+PtTtAqkP434vYu/J1zfH0C/jXyXzZdgBTkHCnxvcH81qhhSZ5J7
	 S6mjKwHl/zLI2OCaar/iZQi0/0ku9ct82qT4QgMKRNBHvjzGHBdhuCvVTHfr/En93K
	 d5LBG2sNCSMlr63nB8K4vvpZMKFz7bdx2tkHFLhvljFDfbf7NQ7pF2G0pwylaFWa/H
	 6lcacDBns9iyQWToW98SGhgkPv2bPsRcoQbl3jVL5UYqW/2bWGoi/Y0rOoT+Kk1ZpH
	 D+1LUH/pUcKFg==
Date: Wed, 12 Jul 2023 16:53:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>,
 <sridhar.samudrala@intel.com>
Subject: Re: [net-next/RFC PATCH v1 1/4] net: Introduce new napi fields for
 rx/tx queues
Message-ID: <20230712165326.71c3a8ad@kernel.org>
In-Reply-To: <4c659729-32dc-491e-d712-2aa1bb99d26f@intel.com>
References: <168564116688.7284.6877238631049679250.stgit@anambiarhost.jf.intel.com>
	<168564134580.7284.16867711571036004706.stgit@anambiarhost.jf.intel.com>
	<20230602230635.773b8f87@kernel.org>
	<717fbdd6-9ef7-3ad6-0c29-d0f3798ced8e@intel.com>
	<20230712141442.44989fa7@kernel.org>
	<4c659729-32dc-491e-d712-2aa1bb99d26f@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jul 2023 16:11:55 -0700 Nambiar, Amritha wrote:
> >> The idea was for netdev-genl to extract information out of
> >> netdev->napi_list->napi. For tracking queues, we build a linked list
> >> of queues for the napi and store it in the napi_struct. This would
> >> also enable updating the napi<->queue[s] association (later with the
> >> 'set' command), i.e. remove the queue[s] from the existing napi
> >> instance that it is currently associated with and map with the new
> >> napi instance, by simply deleting from one list and adding to the new
> >> list.  
> > 
> > Right, my point is that each queue can only be serviced by a single
> > NAPI at a time, so we have a 1:N relationship. It's easier to store
> > the state on the side that's the N, rather than 1.
> > 
> > You can add list_head to the queue structs, if you prefer to be able
> > to walk queues of a NAPI more efficiently (that said the head for
> > the list is in "control path only section" of napi_struct so...
> > I think you don't?)  
> 
> The napi pointer in the queue structs would give the napi<->queue 
> mapping, I still need to walk the queues of a NAPI (when there are 
> multiple queues for the NAPI), example:
> 'napi-id': 600, 'rx-queues': [7,6,5], 'tx-queues': [7,6,5]
> 
> in which case I would have a list of netdev queue structs within the 
> napi_struct (instead of the list of queue indices that I currently have) 
> to avoid memory allocation.
> 
> Does this sound right?

yes, I think that's fine.

If we store the NAPI pointer in the queue struct, we can still generate
the same dump with the time complexity of #napis * (#max_rx + #max_tx).
Which I don't think is too bad. Up to you.

