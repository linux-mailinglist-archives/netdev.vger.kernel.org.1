Return-Path: <netdev+bounces-32820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB61E79A80B
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 14:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61AFA281130
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 12:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB3EF9EC;
	Mon, 11 Sep 2023 12:52:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64333F51E
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 12:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D7CC433C7;
	Mon, 11 Sep 2023 12:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694436775;
	bh=FLzPw3p0kQxrFTa14LvGrYlCQW3W/+6yIDuqpLfXJFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pWXgRRNQTEZLQUVmks5n63JKpzn1IcUYG0nZctUPAA9+QHguHMvUYqfSO79BAailm
	 tjrPUycJio4JW3o+rLHZRQbQeZEOpBz3IibOEMimFqgpb3jzcsEIUo2QqUP/lyOpEp
	 tspRxpDXjkxt7FRdoOhak7UBji2B6ICw0qU8SY+BKNTgffpaUmzIcbTCWZfeJ/6dGs
	 O809Qedx5NwqRDA/pzs0dkhzC0FEXSI2seAulU/5pP/HZgJVahsFttDupx9NMP0DmK
	 nGh0ofetXAk3krk/2na8dlV1gJy9SYaRVuHTLoePxX72/f/vXnXAyYntDQwzGFB1E3
	 w06WJOmO4ETEQ==
Date: Mon, 11 Sep 2023 14:52:51 +0200
From: Simon Horman <horms@kernel.org>
To: Jeremy Cline <jeremy@jcline.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: nfc: llcp: Add lock when modifying device list
Message-ID: <20230911125251.GA23672@kernel.org>
References: <20230908235853.1319596-1-jeremy@jcline.org>
 <20230910152812.GJ775887@kernel.org>
 <ZP5L6/zF6fE+ogbz@dev>
 <20230911055904.GN775887@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911055904.GN775887@kernel.org>

On Mon, Sep 11, 2023 at 07:59:04AM +0200, Simon Horman wrote:
> On Sun, Sep 10, 2023 at 07:06:19PM -0400, Jeremy Cline wrote:
> > On Sun, Sep 10, 2023 at 05:28:12PM +0200, Simon Horman wrote:
> > > On Fri, Sep 08, 2023 at 07:58:53PM -0400, Jeremy Cline wrote:
> > > > The device list needs its associated lock held when modifying it, or the
> > > > list could become corrupted, as syzbot discovered.
> > > > 
> > > > Reported-and-tested-by: syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=c1d0a03d305972dbbe14
> > > > Signed-off-by: Jeremy Cline <jeremy@jcline.org>
> > > 
> > > Hi Jeremy,
> > > 
> > > thanks for your patch.
> > > 
> > > I don't think you need to resubmit for this,
> > > I think this patch warrants a fixes tag:
> > > 
> > > Fixes: d646960f7986 ("NFC: Initial LLCP support")
> > > 
> > 
> > My bad, indeed. The lock in question looks to have been added in
> > 6709d4b7bc2e ("net: nfc: Fix use-after-free caused by
> > nfc_llcp_find_local") which itself includes a couple fix tags, should
> > this reference that commit instead as it won't backport without that
> > one?
> 
> Yes, I think that is likely.
> Sorry for not noticing that.

And further, sorry for being vague in my previous email.
Having now looked over 6709d4b7bc2e I agree it is
the correct commit for a fixes tag for this patch.

> 
> > > Otherwise, this looks good to me.
> > > 
> > > Reviewed-by: Simon Horman <horms@kernel.org>
> > > 
> > 
> > Thanks,
> > Jeremy
> > 
> 

