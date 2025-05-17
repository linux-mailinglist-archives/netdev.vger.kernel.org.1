Return-Path: <netdev+bounces-191260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C83ABA7C1
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 04:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B34BC7A7683
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 02:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87DB770E2;
	Sat, 17 May 2025 02:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mtcpBC1f"
X-Original-To: netdev@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D161569D2B;
	Sat, 17 May 2025 02:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747447619; cv=none; b=GNSufN+eExM6vMFuPmg9wSRWqOjGZ6S0fCIQkLWaOXOPEVJ0ADHJgtOqKD8i6Do12svfXHfD5i5AwL7pZLb4KoutyXAGU4d5+KBPU5QUPAJR/CUyOLB+RTnuxWqyIiHTrEV+PzsyOOkIA2d0920AVIp91qkJHNfWPhzYtjmDeVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747447619; c=relaxed/simple;
	bh=jy523AYz7LCBhTZIuhRNJ37uWOHVOMj/lplsqX8gK/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwntAI1CcLUlkD48U4vsd3wJxit6NvCicqwOUuqkLeIfqex5QtheFLgq6zk2dvDhIhUSZNHWrETZFSn8glmJbvlovFOwd5kVYtpY5UibbyyVajsoIHVtiaKpS2VxsFO7Rwnnk7pWnIlqWNeMFpoDeG6Uc9d6sqjEaRwZEfGHtiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mtcpBC1f; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EdFTN8cwOMPc6cxpPc9w/y1IQHS+NiysypEmD65wI8k=; b=mtcpBC1fY+b1L7r8RKUsHCaPg+
	KNfq9vdWRphwXoxxkj8PSpERVDYWp260ILEQBMj/1uWyE2pjvRj70dnKC1naJMIA9u5zHesUxXj3/
	I/080et+mgh+gkYPpGyZhrBeMv388S1lJOCSwhWup65ZYwSJ9vuC4RIjoKlzI+i32OMODRlxv2gf8
	h6BKXM8oesIo1UKgCXxrdmtZEEaciERvG9ZoHiN4x3dMmZ2562HjSRziX1R6q+g8wLMBlJAsnkM8Z
	YUHBibFzALL3umxrJq6vh2SThu0OUmxdIv5iFgjB5TVu1aOJeUqarTzwSFbwARD1jHhm42qbvT475
	Hk3KL8Jg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uG6wv-00000004hDH-2fAO;
	Sat, 17 May 2025 02:06:53 +0000
Date: Sat, 17 May 2025 03:06:53 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	willemb@google.com, sagi@grimberg.me, asml.silence@gmail.com,
	almasrymina@google.com, kaiyuanz@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: devmem: remove min_t(iter_iov_len) in
 sendmsg
Message-ID: <20250517020653.GX2023217@ZenIV>
References: <20250517000431.558180-1-stfomichev@gmail.com>
 <20250517000907.GW2023217@ZenIV>
 <aCflM0LZ23d2j2FF@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCflM0LZ23d2j2FF@mini-arch>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 16, 2025 at 06:24:03PM -0700, Stanislav Fomichev wrote:
> On 05/17, Al Viro wrote:
> > On Fri, May 16, 2025 at 05:04:31PM -0700, Stanislav Fomichev wrote:
> > > iter_iov_len looks broken for UBUF. When iov_iter_advance is called
> > > for UBUF, it increments iov_offset and also decrements the count.
> > > This makes the iterator only go over half of the range (unless I'm
> > > missing something).
> > 
> > What do you mean by "broken"?  iov_iter_len(from) == "how much data is
> > left in that iterator".  That goes for all flavours, UBUF included...
> > 
> > Confused...

[snip]

> iov_len. And now, calling iter_iov_len (which does iov_len - iov_offset)

Wait a sec...  Sorry, I've misread that as iov_iter_count(); iter_iov_len()
(as well as iter_iov_addr()) should not be used on anything other that
ITER_IOVEC

<checks>

Wait, in the same commit there's
+       if (iov_iter_type(from) != ITER_IOVEC)
+               return -EFAULT;

shortly prior to the loop iter_iov_{addr,len}() are used.  What am I missing now?

