Return-Path: <netdev+bounces-61305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C00FB823346
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 18:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F9A3B22B2A
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 17:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68321C28C;
	Wed,  3 Jan 2024 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvKAO+eX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC28A1C68A
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 17:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2864BC433C7;
	Wed,  3 Jan 2024 17:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704303232;
	bh=prx3LNsgm9Mbd9+E7OaYCag6KGot3wmO1HUDTXTO7OA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qvKAO+eXE5+8X6EvTrnMiX5RNCaG9AdRy5c/z/KGoZukMtL8xLdgTZX8mut2Exean
	 7rJ0Tg4lLPhrr8irYNXrUEBT7A6nmXyo+H1anxpRREkIHtry1Dv9rHn1ol99q8CBFe
	 /PXs3jM/cCofemzar3QR1N9qFmg2ZqB26yIo6vrovhg6sETvbxen55M4mY6AshpYn2
	 S0GabBziWKd7hFQgO9u6X/kq5sbBg4GKy3B5ussJYH0Xau3XtMAXik6sQLqo9bYJG5
	 SW38BY2ZGqL4aeslluGWd8CnA4AENfGz8IaLfQ0iUb8vOhWjX/C7WrHiXaSyuSeFMm
	 IBYJ64cQxZyBg==
Date: Wed, 3 Jan 2024 17:33:47 +0000
From: Simon Horman <horms@kernel.org>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: ahmed.zaki@intel.com, netdev@vger.kernel.org, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
	Jeff Guo <jia.guo@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH net-next] Revert "net: ethtool: add support for
 symmetric-xor RSS hash"
Message-ID: <20240103173347.GA72773@kernel.org>
References: <20231222210000.51989-1-gerhard@engleder-embedded.com>
 <20231224205412.GA5962@kernel.org>
 <b232b24f-abe9-4f62-ab6f-e3c80524ac38@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b232b24f-abe9-4f62-ab6f-e3c80524ac38@engleder-embedded.com>

On Sun, Dec 24, 2023 at 11:03:29PM +0100, Gerhard Engleder wrote:
> On 24.12.23 21:54, Simon Horman wrote:
> > + Jeff Guo <jia.guo@intel.com>
> >    Jesse Brandeburg <jesse.brandeburg@intel.com>
> >    Tony Nguyen <anthony.l.nguyen@intel.com>
> > 
> > On Fri, Dec 22, 2023 at 10:00:00PM +0100, Gerhard Engleder wrote:
> > > This reverts commit 13e59344fb9d3c9d3acd138ae320b5b67b658694.
> > > 
> > > The tsnep driver and at least also the macb driver implement the ethtool
> > > operation set_rxnfc but not the get_rxfh operation. With this commit
> > > set_rxnfc returns -EOPNOTSUPP if get_rxfh is not implemented. This renders
> > > set_rxnfc unuseable for drivers without get_rxfh.
> > > 
> > > Make set_rxfnc working again for drivers without get_rxfh by reverting
> > > that commit.
> > > 
> > > Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> > 
> > Hi Gerhard,
> > 
> > I think it would be nice to find a way forwards that resolved
> > the regression without reverting the feature. But, if that doesn't work
> > out, I think the following two patches need to be reverted first in
> > order to avoid breaking (x86_64 allmodconfig) builds.
> > 
> >   352e9bf23813 ("ice: enable symmetric-xor RSS for Toeplitz hash function")
> >   4a3de3fb0eb6 ("iavf: enable symmetric-xor RSS for Toeplitz hash function")
> 
> Hi Simon,
> 
> frist I thought about fixing, but then I was afraid that the rxfh check in
> ethtool_set_rxnfc() may also affect other drivers with ethtool
> get_rxfh() too. I'm not an expert in that area, so I thought it is not a
> good idea to fix stuff that I don't understand and cannot test.

Understood.

> Taking a second look, rxfh is only checked if RXH_XFRM_SYM_XOR is set and
> this flag is introduced with the same commit. So it should be safe
> to do the rxfh check only if ethtool get_rxfh() is available.

Thanks for taking a second look.

For the record, unless I am mistaken, the revised approach has been
accepted.

Link: https://lore.kernel.org/all/20231226205536.32003-1-gerhard@engleder-embedded.com/

