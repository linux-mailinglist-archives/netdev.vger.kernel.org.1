Return-Path: <netdev+bounces-68425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1119B846DD0
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 11:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE4A286B63
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 10:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B6D7A72F;
	Fri,  2 Feb 2024 10:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEXnmJJx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627CA22067
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 10:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869356; cv=none; b=JQb8s3aDbAXfRBrjUisBIwBAJfzD5csLdWsxBFGnZuFEnUwwQEBFrSftDTZrb3wXFb9u6LktYkltUFPpwFEe7gMq0H4ZWKRNggNeImj369FR2iv8AwxCOA+dY6PGbDAqe80ElTwHtiL55Yxstb1Fd94WYqBEpRXf29LbFEZyM68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869356; c=relaxed/simple;
	bh=rG/QNrbZCu57sdPVa3hAspHt8Aw0OWGDa4HAt4safIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noIegglTJdS6KQv+GKKOE/GFmq+n5xav076nCSbCeJfw6smY9PD7kgWOZ/v0w/5lELb5F3SifQQ8fwluJIOZOaXiXKXH+xBkOG0bBzjkA6XZjy2vUxbwzNOrR/Q02xkRwVFbEoRlnmrUgfDOt6w3Btx/Is0ecDhjke60VCfUP30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEXnmJJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F214FC433C7;
	Fri,  2 Feb 2024 10:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706869355;
	bh=rG/QNrbZCu57sdPVa3hAspHt8Aw0OWGDa4HAt4safIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HEXnmJJxfL5LsMWWbNU7vkqFmx3C7kqM4JMKKPd/OTqHzQpAMYXO34FweOuYKyNLL
	 dnKZqHgxvLK5w1gRtfo64BCvThLBBWDCeHPJZXArB5oGjCe3n1cpa8tfoZSgvK7znF
	 UeILbpq11H6Le9or+37+AkA1DEja6Mk0kIOT81HmuvbxwvCbCQkCxw6ia93T33+ISs
	 10OFc51j0TyhHpebfWqZarva+yBPckhuQzl1L74n97GUnHm704KH17QA81gBNbxSGP
	 7AEn+0dkdVBoLG/p4vqKE9kn/g7vI0l/BqkdPxyyc5pCT9XeFJZCnsvRdTIQAWu1UB
	 YgamFTzGcvK9A==
Date: Fri, 2 Feb 2024 11:22:31 +0100
From: Simon Horman <horms@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v7 3/4] netdevsim: add selftest for forwarding
 skb between connected ports
Message-ID: <20240202102231.GK530335@kernel.org>
References: <20240127040354.944744-1-dw@davidwei.uk>
 <20240127040354.944744-4-dw@davidwei.uk>
 <20240129203401.GR401354@kernel.org>
 <9bba3a59-9281-4029-958f-71b17c5670a7@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bba3a59-9281-4029-958f-71b17c5670a7@davidwei.uk>

On Tue, Jan 30, 2024 at 10:57:45AM -0800, David Wei wrote:
> On 2024-01-29 12:34, Simon Horman wrote:
> > On Fri, Jan 26, 2024 at 08:03:53PM -0800, David Wei wrote:
> >> Connect two netdevsim ports in different namespaces together, then send
> >> packets between them using socat.
> >>
> >> Signed-off-by: David Wei <dw@davidwei.uk>
> >> ---
> >>  .../selftests/drivers/net/netdevsim/peer.sh   | 127 ++++++++++++++++++
> >>  1 file changed, 127 insertions(+)
> >>  create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer.sh
> >>
> >> diff --git a/tools/testing/selftests/drivers/net/netdevsim/peer.sh b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
> >> new file mode 100755
> >> index 000000000000..05f3cefa53f3
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
> >> @@ -0,0 +1,127 @@
> >> +#!/bin/bash
> >> +# SPDX-License-Identifier: GPL-2.0-only
> >> +
> >> +NSIM_DEV_1_ID=$((RANDOM % 1024))
> >> +NSIM_DEV_1_SYS=/sys/bus/netdevsim/devices/netdevsim$NSIM_DEV_1_ID
> >> +NSIM_DEV_1_DFS=/sys/kernel/debug/netdevsim/netdevsim$NSIM_DEV_1_ID
> >> +NSIM_DEV_2_ID=$((RANDOM % 1024))
> >> +NSIM_DEV_2_SYS=/sys/bus/netdevsim/devices/netdevsim$NSIM_DEV_2_ID
> >> +NSIM_DEV_2_DFS=/sys/kernel/debug/netdevsim/netdevsim$NSIM_DEV_2_ID
> > 
> > nit: NSIM_DEV_1_DFS and SIM_DEV_2_DFS appear to be unused.
> > 
> > Flagged by shellcheck.
> > 
> > ...
> 
> Hi Simon, thanks for flagging this, these were leftover from previous
> changes. I'll remove them in the next version.

Thanks David,

much appreciated.

