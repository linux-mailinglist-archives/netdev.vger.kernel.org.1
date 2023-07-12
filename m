Return-Path: <netdev+bounces-17313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A69175127B
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 23:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5FA281894
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 21:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7B2E568;
	Wed, 12 Jul 2023 21:14:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E963FBFB
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 21:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CB9C433C8;
	Wed, 12 Jul 2023 21:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689196483;
	bh=B1zA1eBMfXevQL/+/vT3YjAZ56x9OXlsjsE8c5KjQnk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JKTHx2ATwHkNpYCN+atTPpltex/6GGaHAKhbJEwnsS7FBMbRc7GxxCfPPQjRU2WHo
	 s1YQmZ2zJDtgDcBSDQF1FpeqWEGuAmSbyQlD0N2MOkDgaLUUJ7gOagqqgwrOesANv5
	 Yz+3gNm0NPVMQ+Xymj22+HPFPW9yQHSGpR7bzHKbcaK7/TNVgVUTzgmrzZLCpFG0qq
	 lYX4s4g2OWWDhgNShBsaiWlWA7aLoVNihal2rOSBcX0lb+TMTeOeT85wbJYtvdJ4aJ
	 zQEXqsQcm2Bf9A898ne6VMwBX1Vf0YqTrnCTwuDj0rOT9hKUzgATSIvU8WwRoZ+hAZ
	 mRIjClyG8HzfA==
Date: Wed, 12 Jul 2023 14:14:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>,
 <sridhar.samudrala@intel.com>
Subject: Re: [net-next/RFC PATCH v1 1/4] net: Introduce new napi fields for
 rx/tx queues
Message-ID: <20230712141442.44989fa7@kernel.org>
In-Reply-To: <717fbdd6-9ef7-3ad6-0c29-d0f3798ced8e@intel.com>
References: <168564116688.7284.6877238631049679250.stgit@anambiarhost.jf.intel.com>
	<168564134580.7284.16867711571036004706.stgit@anambiarhost.jf.intel.com>
	<20230602230635.773b8f87@kernel.org>
	<717fbdd6-9ef7-3ad6-0c29-d0f3798ced8e@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jul 2023 13:09:35 -0700 Nambiar, Amritha wrote:
> On 6/2/2023 11:06 PM, Jakub Kicinski wrote:
> > On Thu, 01 Jun 2023 10:42:25 -0700 Amritha Nambiar wrote:  
> >> Introduce new napi fields 'napi_rxq_list' and 'napi_txq_list'
> >> for rx and tx queue set associated with the napi and
> >> initialize them. Handle their removal as well.
> >>
> >> This enables a mapping of each napi instance with the
> >> queue/queue-set on the corresponding irq line.  
> > 
> > Wouldn't it be easier to store the NAPI instance pointer in the queue?
> > That way we don't have to allocate memory.
> >   
> 
> Could you please elaborate on this so I have more clarity ? 

First off, let's acknowledge the fact you're asking me for
clarifications ~40 days after I sent the feedback.

Pause for self-reflection.

Okay.

> Are you suggesting that there's a way to avoid maintaining the list
> of queues in the napi struct?

Yes, why not add the napi pointer to struct netdev_queue and
netdev_rx_queue, specifically?

> The idea was for netdev-genl to extract information out of 
> netdev->napi_list->napi. For tracking queues, we build a linked list
> of queues for the napi and store it in the napi_struct. This would
> also enable updating the napi<->queue[s] association (later with the
> 'set' command), i.e. remove the queue[s] from the existing napi
> instance that it is currently associated with and map with the new
> napi instance, by simply deleting from one list and adding to the new
> list.

Right, my point is that each queue can only be serviced by a single
NAPI at a time, so we have a 1:N relationship. It's easier to store
the state on the side that's the N, rather than 1.

You can add list_head to the queue structs, if you prefer to be able 
to walk queues of a NAPI more efficiently (that said the head for
the list is in "control path only section" of napi_struct so...
I think you don't?)

