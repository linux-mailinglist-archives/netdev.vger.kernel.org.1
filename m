Return-Path: <netdev+bounces-235490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A01B6C316DA
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 15:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE32188B390
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 14:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8756A329C44;
	Tue,  4 Nov 2025 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lI690jjR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB4420B800;
	Tue,  4 Nov 2025 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265295; cv=none; b=FDRNCphWC0thAdOf5cWTM4nqpQayX1zs/itQ6yptg41K2dJd7ZfYmLrj4hTni1sP+VdQcvuGERaWsEPI8MTKGMyviEIFUzpdFL6vY4g5pMIai0s91r6IENPDVGOJSneVWHxnmGNjLMlvQlGsullOHBRl/7AtmayTMfrPklFrNzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265295; c=relaxed/simple;
	bh=P4fr0lb3ga+ippVPcMJQtRT1WQjKPshXJCKlm8G0/cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvKf4SGB/7p9MbUS1t/Cnzm4J8ifwImRtcm0ltFUb/gmeuRaeHsUfynlxOLAraN/bR/TvSE5Np5E77oNN2zftNjXCaRLvoCmpndJZdh7/Wi6g82qja22H3pNEl3lypzruWqIc8jEVZHrOl662FcAoZ0skRxL1NYEBk7fxZWaNBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lI690jjR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C218C4CEF7;
	Tue,  4 Nov 2025 14:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762265295;
	bh=P4fr0lb3ga+ippVPcMJQtRT1WQjKPshXJCKlm8G0/cI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lI690jjRw5KPS5i/V53gscq9HzC0e+W5HJ/GlZIj6V9uYvJAw2/LxLb6lkWjayqtF
	 pGKjQdMicE9HN3VJWJVJmTaWp3qZubMtyYI7fg/4Du8dm5fZQsB+R1BRtHP+77e5wg
	 OjEyrOxHFLypd/aToW3KK2EJ89ImLwqBdfWau+89EwfMcscSYp55cc1MYPnAqiOpcI
	 rFJ9XwtlARJFnNhrZBh9SuxqhxnICkCozm7cOIw4Q8LtbwNPzm9OrqPnA8D6Bwi+HU
	 Uo+oaZpBcRhkgaHWyaJDIJhaGhqHOyYXvZqWlD4J0/OICRJhAEcx/XgrahSG3L8tun
	 x+W5y7aTHBLiQ==
Date: Tue, 4 Nov 2025 14:08:10 +0000
From: Simon Horman <horms@kernel.org>
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	khalid@kernel.org,
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 0/2] net: sched: act_ife: initialize struct tc_ife to
 fix KMSAN kernel-infoleak
Message-ID: <aQoIygv-7h4m21SG@horms.kernel.org>
References: <20251101-infoleak-v2-0-01a501d41c09@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101-infoleak-v2-0-01a501d41c09@gmail.com>

On Sat, Nov 01, 2025 at 06:04:46PM +0530, Ranganath V N wrote:
> Fix a KMSAN kernel-infoleak detected  by the syzbot .
> 
> [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
> 
> In tcf_ife_dump(), the variable 'opt' was partially initialized using a
> designatied initializer. While the padding bytes are reamined
> uninitialized. nla_put() copies the entire structure into a
> netlink message, these uninitialized bytes leaked to userspace.
> 
> Initialize the structure with memset before assigning its fields
> to ensure all members and padding are cleared prior to beign copied.

Perhaps not important, but this seems to only describe patch 1/2.

> 
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>

Sorry for not looking more carefully at v1.

The presence of this padding seems pretty subtle to me.
And while I agree that your change fixes the problem described.
I wonder if it would be better to make things more obvious
by adding a 2-byte pad member to the structures involved.

...

