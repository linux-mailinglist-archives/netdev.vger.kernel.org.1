Return-Path: <netdev+bounces-162281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA27BA265D1
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3FA31880237
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E394A20F094;
	Mon,  3 Feb 2025 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptGGcL2a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDFB1F4275
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618747; cv=none; b=OAXJ7piedqgywW7RLRjfQYZRwqBcifpQyfcnLtDmuUdohq8t80kJqJWJt62L4NVrr3bmc1wCBiS+FpJ2tazdc1cWQtQLjlPWaoE0D4fzwh4qWN1azKSqIjyqfO95Gw3NDTpiIRhiRxx1Y4mi6dm9/bhybEJbj/+axnKpm0/l5C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618747; c=relaxed/simple;
	bh=o0btuJ5XVrrXqfhJBLD11unDfV+RTPHzah/k/9gMDl8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6qEx/q3l2Hxx+GHGlMnSseRHYo77k65BaZjsceVRrwV5PPvM3gvhMcQKAx6Vpzf3N+vCA6g6TnxrGLAI4UDKRpz17FEWGt+lDfgOeUCCUjPXqDg/FFifr1VHOPsPbaxJBfMLg0CKYfKYc5Meprk0qYAfPhJPCa6HIN6yYVwF4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptGGcL2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CBAC4CED2;
	Mon,  3 Feb 2025 21:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738618747;
	bh=o0btuJ5XVrrXqfhJBLD11unDfV+RTPHzah/k/9gMDl8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ptGGcL2al+Zlo2zyJfdQPztgf4EhjXlyffR9CNVhCt965kvaFry2btsGQy1ONjqcg
	 s8LTn3neygT+F8euwiUuke+AomOAHr4eqTZU93ZBmgAxNYGc5F9wOf5hXxiRyOqj0a
	 +RlMLOoXG8I65gvBysTYGqRlMPT/+eMh/R/axvq2ZzJAzNMRmjabTkmAVaVK3xaSwD
	 UjZNjMvIXRzFSyRw0eYeVmOUv6l3op2ccCOuQCo/GLkbUJagdUXaMPxD3z9NrAuTRu
	 OH5o1A3tDoFh/R2Vf8/X14Op8K5KPVNXH+k1i7xQ++/s6y5QbCw3qVSBP8CbM7X/1v
	 thuACRx8zfGBg==
Date: Mon, 3 Feb 2025 13:39:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, ecree.xilinx@gmail.com, gal@nvidia.com,
 przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net 2/4] ethtool: ntuple: fix rss + ring_cookie check
Message-ID: <20250203133905.44b9fec0@kernel.org>
In-Reply-To: <Z6E1afDYGcU2NM7V@LQ3V64L9R2>
References: <20250201013040.725123-1-kuba@kernel.org>
	<20250201013040.725123-3-kuba@kernel.org>
	<Z6EyPtp4rrCYSCTb@LQ3V64L9R2>
	<20250203132519.67f97123@kernel.org>
	<Z6E1afDYGcU2NM7V@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Feb 2025 13:30:17 -0800 Joe Damato wrote:
> > I admit I haven't dug into the user space side, but in the kernel
> > my reading is that the entire struct ethtool_rxnfc, which includes
> > _both_ flow_type fields gets copied in. IOW struct ethtool_rxnfc
> > has two flow_type fields, one directly in the struct and one inside 
> > the fs member.  
> 
> Agree with you there; there are two fields and I think your change
> is correct. I think the nit is just the wording of the commit
> message as ethtool's user space stack might have some junk where
> info.flow_type is (instead of 0). I only very briefly skimmed the
> ethtool side, so perhaps I missed something.

Oh, I thought you meant kernel doesn't init it.
Fair point, user space may pass garbage.

