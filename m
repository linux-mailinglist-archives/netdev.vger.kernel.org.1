Return-Path: <netdev+bounces-30823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069A87892C8
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 02:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0351C210AC
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 00:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2666818D;
	Sat, 26 Aug 2023 00:49:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55AF37F
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 00:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DF6C433C8;
	Sat, 26 Aug 2023 00:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693010966;
	bh=uyTnossv5zy8IIZE2b01UOp7U3twIuBpWTgg0kk/pu0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jVlvc2bgSKSzABlWdyrHFV2Z2DkrR+oNjcFKNtLU7iZZBNz81TnVvLb8aJ2yDiOV9
	 WqPB8CmKX9xafbX+vl86HFR4+65VDAqnLyHw/HwA420MyX3WuKh8Fn31+2QiL9Akxn
	 Stzq/ziOYK5PEvuaZV9LHWjqagYHq9tsJ1WeDA+Qaf11K9z8f/TCtCmE1H+UYWzCmX
	 qp8IgI+DiR5B5br4iA+c4Ud+qlhUAUOF5i4HhKAys/8m6XTxiKMacEdwnDx2AvPXjJ
	 9dBzLvrW2FKh4UbVW6fxsuOwh8isqs9mtVMeeHcoao4WZoEvSSSkEJYcGJC9pVGhzJ
	 2Op5NwJsU2xLw==
Date: Fri, 25 Aug 2023 17:49:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: <netdev@vger.kernel.org>, <jesse.brandeburg@intel.com>,
 <anthony.l.nguyen@intel.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>
Subject: Re: [RFC PATCH net-next 1/3] net: ethtool: add symmetric Toeplitz
 RSS hash function
Message-ID: <20230825174925.45ea6ee5@kernel.org>
In-Reply-To: <eed1f254-3ba1-6157-fe51-f9d230a770a9@intel.com>
References: <20230823164831.3284341-1-ahmed.zaki@intel.com>
	<20230823164831.3284341-2-ahmed.zaki@intel.com>
	<20230824111455.686e98b4@kernel.org>
	<849341ef-b0f4-d93f-1420-19c75ebf82b2@intel.com>
	<20230824174336.6fb801d5@kernel.org>
	<eed1f254-3ba1-6157-fe51-f9d230a770a9@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Aug 2023 14:46:42 -0600 Ahmed Zaki wrote:
> > I'm just trying to help, if you want a single knob you'd need to add
> > new fields to the API and the RXFH API is not netlink-ified.
> >
> > Using hashing algo for configuring fields feels like a dirty hack.  
> 
> Ok. Another way to add a single knob is to a flag in "struct 
> ethtool_rxfh" (there are still some reserved bytes) and then:

Sorry we do have ETHTOOL_MSG_RSS_GET. It just doesn't cover the flow
config now. But you can add the new field there without a problem.

> ethtool -X eth0 --symmetric hfunc toeplitz
> 
> This will also allow drivers/NICs to implement this as they wish (XOR, 
> sorted, ..etc). Better ?

We should specify the fields, I reckon, something like:

ethtool -X eth0 --symmetric sdfn hfunc toeplitz

So that the driver can make sure the user expects symmetry on fields
the device supports.

> >> I agree that we will need to take care of some cases like if the user
> >> removes only "source IP" or "destination port" from the hash fields,
> >> without that field's counterpart (we can prevent this, or show a
> >> warning, ..etc). I was planning to address that in a follow-up
> >> series; ie. handling the "ethtool -U rx-flow-hash". Do you want that
> >> to be included in the same series as well?  
> > Yes, the validation needs to be part of the same series. But the
> > semantics of selecting only src or dst need to be established, too.
> > You said you feed dst ^ src into the hashing twice - why?  
> 
> To maintain the same input length (same as the regular Toeplitz input) 
> to the hash H/W block

But that's a choice, right? We're configuring the input we could as
well choose to make it shorter? v4 and v6 use the same key with
different input lengths, right?

