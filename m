Return-Path: <netdev+bounces-161167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AAAA1DBA3
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 18:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ED2C3A41EE
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 17:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E943718A6A1;
	Mon, 27 Jan 2025 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDNqhmtX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C338F17BA1
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738000497; cv=none; b=enlReJFFyUp7kV3Nw/wdxgt6e4HWXmnR5za2luEYQtruC9t6DK+bLDeqVxK+X3wE4eGi6Bh88wLhghvpADfKrif0iZ65F4+Rlq6c3womBJ1mx84iun7zqz82sVHgGOkO4fh+njVpdaVwYG6c75vqsgzKPL4WRXSlPvl1QBoT5e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738000497; c=relaxed/simple;
	bh=IViCoF7hcqWsn0jtSyJ2X8Yq8zYcy5YyiujDaN1V4MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTgTpY/1JrhwcQb1Ng84f/Ob1WF0NjmJGrizB+GT5CDwqTV8GZULtqeek2GV4/FFYBEl0Ok7R3EJc/Mw468vPKdmRQo8ZjNA6FqEHiAqhyjWck7mXOIjjf5W2qxPEWbVuMNVbY37ZCK8ZCEQnTOt140SjpacdsFlkG3Vq2WUugM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDNqhmtX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6047C4CEE0;
	Mon, 27 Jan 2025 17:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738000497;
	bh=IViCoF7hcqWsn0jtSyJ2X8Yq8zYcy5YyiujDaN1V4MA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YDNqhmtXDFrxCkSRM1ecsliSAUYksUOtNwFlLFKbUcbXGpcyVT4TxvworKJkODQT8
	 s3BFxXQoVmHyyW7CcNvRA1e1bRs2IEJaN094yN7/co6LOPU5XJBu4oXlH3lROOgLrd
	 MaOoIlwLfK1ByNYZSiv70lVVUarTE9OOg4FULRqQcDvYVQ4CB0nTxhBRogcVzL3b6b
	 UDO2rvsbc36+d0ps81GFD/xedVjhoOaa5MxzloqzIAT/sn1HzChWtDrfQqo4p7IgCo
	 PDZSqtnABuOnngYeqF12YDiUdZbLMp2vn/Mj6/M43SdeHAace64UpNiLDp6aVNFu20
	 pijquhVlYV7qQ==
Date: Mon, 27 Jan 2025 17:54:53 +0000
From: Simon Horman <horms@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	quanglex97@gmail.com, mincho@theori.io,
	Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch net 2/4] Add test case to check for pfifo_tail_enqueue()
 behaviour when limit == 0
Message-ID: <20250127175453.GG5024@kernel.org>
References: <20250124060740.356527-1-xiyou.wangcong@gmail.com>
 <20250124060740.356527-3-xiyou.wangcong@gmail.com>
 <20250124113743.GA34605@kernel.org>
 <Z5WqCnOiSF72PGws@pop-os.localdomain>
 <Z5Wxh/oUF2meTEBS@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5Wxh/oUF2meTEBS@pop-os.localdomain>

On Sat, Jan 25, 2025 at 07:52:39PM -0800, Cong Wang wrote:
> On Sat, Jan 25, 2025 at 07:20:42PM -0800, Cong Wang wrote:
> > On Fri, Jan 24, 2025 at 11:37:43AM +0000, Simon Horman wrote:
> > > On Thu, Jan 23, 2025 at 10:07:38PM -0800, Cong Wang wrote:
> > > > From: Quang Le <quanglex97@gmail.com>
> > > > 
> > > > When limit == 0, pfifo_tail_enqueue() must drop new packet and
> > > > increase dropped packets count of scheduler.
> > > > 
> > > > Signed-off-by: Quang Le <quanglex97@gmail.com>
> > > > Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> > > 
> > > Hi Cong, all,
> > > 
> > > This test is reporting "not ok" in the Netdev CI.
> > > 
> > > # not ok 577 d774 - Check pfifo_head_drop qdisc enqueue behaviour when limit == 0
> > > # Could not match regex pattern. Verify command output:
> > > # qdisc pfifo_head_drop 1: root refcnt 2 limit 0p
> > > #  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
> > > #  backlog 0b 0p requeues 0
> > 
> > Oops... It worked on my side, let me take a look.
> > 
> 
> I ran it again for multiple times, it still worked for me:
> 
> 1..16
> ok 1 a519 - Add bfifo qdisc with system default parameters on egress
> ok 2 585c - Add pfifo qdisc with system default parameters on egress
> ok 3 a86e - Add bfifo qdisc with system default parameters on egress with handle of maximum value
> ok 4 9ac8 - Add bfifo qdisc on egress with queue size of 3000 bytes
> ok 5 f4e6 - Add pfifo qdisc on egress with queue size of 3000 packets
> ok 6 b1b1 - Add bfifo qdisc with system default parameters on egress with invalid handle exceeding maximum value
> ok 7 8d5e - Add bfifo qdisc on egress with unsupported argument
> ok 8 7787 - Add pfifo qdisc on egress with unsupported argument
> ok 9 c4b6 - Replace bfifo qdisc on egress with new queue size
> ok 10 3df6 - Replace pfifo qdisc on egress with new queue size
> ok 11 7a67 - Add bfifo qdisc on egress with queue size in invalid format
> ok 12 1298 - Add duplicate bfifo qdisc on egress
> ok 13 45a0 - Delete nonexistent bfifo qdisc
> ok 14 972b - Add prio qdisc on egress with invalid format for handles
> ok 15 4d39 - Delete bfifo qdisc twice
> ok 16 d774 - Check pfifo_head_drop qdisc enqueue behaviour when limit == 0
> 
> Could you provide a link for me to check?

I'll send you some links off-list.

> 
> Just in case, please make sure patch 1/4 is applied before this test,
> otherwise packets would not be dropped.

Yes, I am pretty sure that is the case.

> 
> Meanwhile, I do need to update this patch anyway, because it hardcoded
> dummy2...
> 
> Thanks.
> 

