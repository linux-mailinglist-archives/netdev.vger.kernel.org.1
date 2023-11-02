Return-Path: <netdev+bounces-45821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 602357DFC6A
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 23:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 181CA281D74
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 22:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B547E1FA4;
	Thu,  2 Nov 2023 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jqfpFZJp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949F0224C4
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 22:30:31 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC94EDC;
	Thu,  2 Nov 2023 15:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=G6ROTX3/i26xHE7RlpY5IFNyJGFvI/2topyQtl8SOM8=; b=jqfpFZJpXbVr10t1Ve5lrWXj9H
	UESXuwg/8yGcOfYM4sDPvoF0l1MBrirBPG4LxJ7k5QpC7+88G4i+lc+9ydy2+wzgv1W3VhogZgI63
	kBJpllcfkvVCKCMDjpxhyJCA+Cu6EyzaRUQ/HZIJ9AoX2lSn3qDghHHkddk4OA4HoD77NtAKRZP8J
	nwSu3rXaYSy5af/hG1gG9GkFdZhJ6L6lFwxofaNigqYs1f4MEqifC6Bj0jyz9U0eWu9Vw8QXmzssT
	4rBuU5hHW2+IEf8CGqhFnta+Q2nT1gVA0Wc+eTpvSaa/I00fULMSran9vUTxwaBathezmxDBR1Zel
	hvFYb96A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qygCf-009zAh-2z;
	Thu, 02 Nov 2023 22:30:18 +0000
Date: Thu, 2 Nov 2023 22:30:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Philipp Stanner <pstanner@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH] drivers/net/ppp: copy userspace array safely
Message-ID: <20231102223017.GO1957730@ZenIV>
References: <20231102191914.52957-2-pstanner@redhat.com>
 <20231102200943.GK1957730@ZenIV>
 <7a26cd1bafb22b16eab3868255706d44fa4f255d.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a26cd1bafb22b16eab3868255706d44fa4f255d.camel@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 02, 2023 at 11:02:35PM +0100, Philipp Stanner wrote:

> We introduced those wrappers to string.h hoping they will be useful.
> Now that they're merged, I quickly wanted to establish them as the
> standard for copying user-arrays, ideally in the current merge window.
> Because its convenient, easy to read and, at times, safer.

	They also save future readers a git grep to find the sizes, etc.
Again, the only suggestion is that regarding the commit message;
_some_ of those might end up fixing real overflows and you obviously
want to see how far do those need to be backported, etc.  And "in this
case the overflow doesn't actually happen because <reasons>, but
not having to do such analysis is a good thing" is not a bad explanation
why the primitive in question is useful, IMO.  Granted, in cases like
256 * sizeof(u32) that would be pointless, but for the ones that
are less obvious...

> I just didn't see it in ppp. Maybe I should have looked more
> intensively for all 13 patches. But we'll get there, that's what v2 and
> v3 are for :)

In any case you want to check if there are real bugs caught in that.

