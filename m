Return-Path: <netdev+bounces-28838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F5B780FB8
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB451282409
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 16:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70FD198B8;
	Fri, 18 Aug 2023 16:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63895EACB
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 16:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68301C433C7;
	Fri, 18 Aug 2023 16:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692374423;
	bh=iP/51u+uQFWCLdwtYcMg4R1ihG1dtKyEgVl061uxXSQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mJBtD6CKFoX0BrH8Ad3opJi+b9L2DlGvibsEXsIdJTZzrk389LSv6twt1jofziuNN
	 DfdWCMQMUucaG4I4phvDTtRCAH2doFcPDLPJTq9BRGoVv0E8GUVCJBJnw8nY5bW25p
	 U/RQQz+W8zP4oimcao2JY5Aj10qeRRYQZDNvcO6M8hN26Zj/pb/zcmjyhLDYxOSVPa
	 2x2ror6HBAGtee5T8184hXFP6rK906QzYUsxANZfMS65aznToJ/DuCmUcXdylCJg6C
	 G1yA89sAAB6YYhHOuSVD5ZWB4jcGtfcQBQN6G7moieEoDgpU12H78grZg8nmRqiMg+
	 /kCwdyCHVHUQw==
Date: Fri, 18 Aug 2023 09:00:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: Sunil Kovvuri Goutham <sgoutham@marvell.com>, Geethasowjanya Akula
 <gakula@marvell.com>, Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
 Hariprasad Kelam <hkelam@marvell.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Linu Cherian <lcherian@marvell.com>, Jerin
 Jacob Kollanukkaran <jerinj@marvell.com>
Subject: Re: [EXT] Re: [net PATCH V2 1/4] octeontx2-pf: Update PFC
 configuration
Message-ID: <20230818090022.50e1c46a@kernel.org>
In-Reply-To: <SJ0PR18MB5216486E191AD5D8B6B12F3CDB1BA@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20230809070532.3252464-1-sumang@marvell.com>
	<20230809070532.3252464-2-sumang@marvell.com>
	<20230809160517.7ff84c3b@kernel.org>
	<SJ0PR18MB5216486E191AD5D8B6B12F3CDB1BA@SJ0PR18MB5216.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Thanks for replying a week late, always a good use of maintainers time
to swap back all the context from random conversations!

On Fri, 18 Aug 2023 06:54:52 +0000 Suman Ghosh wrote:
> >If there is any error in open() this will silently take the interface
> >down. Can't you force a NAPI poll or some such, if the concern is a
> >missed IRQ?  
> [Suman] I can check the return type of open() and report in case of
> error. But even if we force NAPI poll we might not be able to control
> the watchdog reset. If we have a running traffic and interface is up,
> when we force NAPI poll, then the new packets will have updated
> scheduler queue and we will still loose the completion interrupts of
> the previous packets.

Why does it matter that you lost an interrupt if the poll has happened.
Can you describe the problem in more detail?

> Do you see any issue if I handle the error situation during open() call?

No, for years we have been rejecting code which does this.
If the machine is under memory pressure allocating all the buffers 
for rings can easily fail and make the machine drop off the network.
You either have to refuse to change this setting at runtime or
implement prepare/commit reconfiguration model like other modern
drivers, where allocations are done before the stop().

