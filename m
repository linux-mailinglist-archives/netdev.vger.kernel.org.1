Return-Path: <netdev+bounces-48361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7A27EE265
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2448280F51
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F25D3158D;
	Thu, 16 Nov 2023 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6G+X4uI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D74288D8
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 14:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5E7C433C8;
	Thu, 16 Nov 2023 14:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700143895;
	bh=igr4mm6gCs3yZwbKAqLnwDfYwPhInnayAUTBL3TDa5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s6G+X4uIzTXUzyZEwTazaR1mw5/Ni3QQQAcoUgf+dRZXEe5XFhUouoh4+hjjulgql
	 iCVLy8TKUaNSh+JIwWUHmPOM/Dk1I6B1HZnIPl9NaltxdLqSVi7zCDX1Yg0IKFEslq
	 YHhyoyp/L7Xh0dbkZH7zHrpvIXkxLo1zqBeUe5lSiO7jmD1bzriNjpEz51VOzJVTKe
	 yQp4H6z+I0/bBfKzNbNdiaY1OrYlKpJa60il0smduGZedPbKhVCWTiKZv96vClg89G
	 HpwvtMxQ2ooHjGx7h6a0oZIdoBDezmYTKmEfzznWMa/ejlbmNQn+60Hdd0FZ9iv9Iv
	 8CLLVIvCCzPMw==
Date: Thu, 16 Nov 2023 14:11:29 +0000
From: Simon Horman <horms@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	victor@mojatatu.com
Subject: Re: [PATCH net-next 2/4] selftests: tc-testing: rework namespaces
 and devices setup
Message-ID: <20231116141129.GB109951@vergenet.net>
References: <20231114160442.1023815-1-pctammela@mojatatu.com>
 <20231114160442.1023815-3-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114160442.1023815-3-pctammela@mojatatu.com>

On Tue, Nov 14, 2023 at 01:04:40PM -0300, Pedro Tammela wrote:
> As mentioned in the TC Workshop 0x17, our recent changes to tdc broke
> downstream CI systems like tuxsuite. The issue is the classic problem
> with rcu/workqueue objects where you can miss them if not enough wall time
> has passed. The latter is subjective to the system and kernel config,
> in my machine could be nanoseconds while in another could be microseconds
> or more.
> 
> In order to make the suite deterministic, poll for the existence
> of the objects in a reasonable manner. Talking netlink directly is the
> the best solution in order to avoid paying the cost of multiple
> 'fork()' calls, so introduce a netlink based setup routine using
> pyroute2. We leave the iproute2 one as a fallback when pyroute2 is not
> available.
> 
> Also rework the iproute2 side to mimic the netlink routine where it
> creates DEV0 as the peer of DEV1 and moves DEV1 into the net namespace.
> This way when the namespace is deleted DEV0 is also deleted
> automatically, leaving no margin for resource leaks.
> 
> Another bonus of this change is that our setup time sped up by a factor
> of 2 when using netlink.
> 
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Simon Horman <horms@kernel.org>


