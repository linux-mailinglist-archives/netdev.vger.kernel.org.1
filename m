Return-Path: <netdev+bounces-119255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54216954FE3
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 19:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D1A1C216DD
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 17:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CCB1BF30D;
	Fri, 16 Aug 2024 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXzUtzvs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DB078C7D
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 17:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723828701; cv=none; b=RYc3RuEYUDHVIYpPpFwuHTrOEUmPpKVMnQBw06LekT7dYnFNra1TuNG1zJIdX0gnNBO+VhvdFqdpifH6AEqMw04RSGhotAFb7gFEQMhe0G4xm/QeSx7HOgEGRQw1R+Wm4QG2dsCbbvgq4iU6SReOHh28ova9TulHJHR7LO2TkFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723828701; c=relaxed/simple;
	bh=7F1XINyfaaPwmpH1kZ/VqFh7DlR6Lb62y1QJvY5BOv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCMGYgI0OcdnplxyyZr0qf5YsxN2rS/Y2kLrUW7ScGCnvzyw9EGX8EhJF541iXVQVn+MDXgar6GUI6LL8FbNCOOAkunbN9fJJtgRRVWJdYFOLS6+Bc8D6Kttszn3Rvpsv66Do3YPHLiNjjLHbRVV9P3tiKyt+2SR0DkfF0SbUkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXzUtzvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2E0C32782;
	Fri, 16 Aug 2024 17:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723828700;
	bh=7F1XINyfaaPwmpH1kZ/VqFh7DlR6Lb62y1QJvY5BOv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cXzUtzvsCiEC6/KOxahf79AMEyZuBREqaIa7hZTHypE4XDhaU5g1Dk8Nf85KHiTeo
	 FzfW2+kcxcIUGHSTs7J5DUYBU1zJYahxUKLAr1Dfi3gc0B9fbUrB5XhOEyWpsWk26R
	 pbiEGdBS9W1dL/jbGKVIK2UWbjI5SvVU3GruqxqAroSE1VnPdT96Q6djfvjrEYrd/u
	 EJKhJAtpnG68MzozJzTIPlJUxTi0HiNbM4imQ+bnQMsLZWOKq5lk2DVikOADii9Scn
	 BQmLbpvuGXFVyAmEASwLArRqpZ+00YeIdqyyecb7BT9BJcMhJMO0u1AagW2GYQ6v3x
	 dGZyk44CwNSjA==
Date: Fri, 16 Aug 2024 18:18:16 +0100
From: Simon Horman <horms@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: mctp: test: Use correct skb for route
 input check
Message-ID: <20240816171816.GE632411@kernel.org>
References: <20240816-mctp-kunit-skb-fix-v1-1-3c367ac89c27@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816-mctp-kunit-skb-fix-v1-1-3c367ac89c27@codeconstruct.com.au>

On Fri, Aug 16, 2024 at 06:29:17PM +0800, Jeremy Kerr wrote:
> In the MCTP route input test, we're routing one skb, then (when delivery
> is expected) checking the resulting routed skb.
> 
> However, we're currently checking the original skb length, rather than
> the routed skb. Check the routed skb instead; the original will have
> been freed at this point.
> 
> Fixes: 8892c0490779 ("mctp: Add route input to socket tests")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/kernel-janitors/4ad204f0-94cf-46c5-bdab-49592addf315@kili.mountain/
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

Reviewed-by: Simon Horman <horms@kernel.org>


