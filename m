Return-Path: <netdev+bounces-191274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49442ABA816
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 06:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7B537B5E39
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 04:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683401531DB;
	Sat, 17 May 2025 04:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CF8iz/f4"
X-Original-To: netdev@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FE84B1E76;
	Sat, 17 May 2025 04:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747454735; cv=none; b=nn/5y9Uo4YRCmaWkWZc5GRLBppiJrJrRVv1Vk86QVKflnWyG4HuCXoiaWoD/avcS7d2MnhvhAA9TzpqCqq9f5BNKll1qZvTdYFi/oF3Y/g5V/O2AFI3APxuUgV0ro5cLuuYtrwIHvE3kabmlwm6kgFhwXPKf4wvUavQCbb+zCsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747454735; c=relaxed/simple;
	bh=D0dAEmOh4K90pcQdQIKL3X0Y3AGxs7M2ifxMjIEFatQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QI08OsIyQ3kUfHaIqU36g/YsvoWLmHfuFr9hhp+w/1X39dmSaT0kpD+5Wkt5i6InlicEfZ4/X2WiVqB+U8fuu3IoN5fO8iRoO2UAE55B6hRBaC70qwhIpUtLwB1na08EJtN87vWbFsPKj4PaDfAIxZoG7Vz8zmW4/0hGnD7Q9I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CF8iz/f4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EiM07UXD1IjK/D2tylsryfmTCnQxwnXrQzFbpup7egU=; b=CF8iz/f4eUM/SGw2HYS7R0o6u3
	R/yG8H9cWQMA3dY8aupwf2KqDv7BQFUPHznqCX4G2hLt6N8CPemfiVUJRXnCT5jfzoMEZ+qXE1kSg
	bgyq/nvC/rcW7cGr1maD4p+SlXvHDsyJODBtXEiWOtGxuaNgHcNVFjfvzw4IwYrGj5ZNQnPeEYkyu
	MtHKFAcQkMjlSESZel/1l4alrL0YNEsHzRe5cSgVh6QZDz/t8o/i2WtiiA4MrWVbt5Y3TPdJulaZX
	GoQ1h/sRqpQbSTSeeH4gAUg1I6ZLI2fpXfoRtMSTB5jTTF/zW4ypEvRdQKXwDoY+HlijZh65ax9cb
	v2YzRckA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uG8ni-00000005ON0-3RKz;
	Sat, 17 May 2025 04:05:30 +0000
Date: Sat, 17 May 2025 05:05:30 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	willemb@google.com, sagi@grimberg.me, asml.silence@gmail.com,
	almasrymina@google.com, kaiyuanz@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: devmem: remove min_t(iter_iov_len) in
 sendmsg
Message-ID: <20250517040530.GZ2023217@ZenIV>
References: <20250517000431.558180-1-stfomichev@gmail.com>
 <20250517000907.GW2023217@ZenIV>
 <aCflM0LZ23d2j2FF@mini-arch>
 <20250517020653.GX2023217@ZenIV>
 <aCfxs5CiHYMJPOsy@mini-arch>
 <20250517033951.GY2023217@ZenIV>
 <aCgIJSgv-yQzaHLl@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCgIJSgv-yQzaHLl@mini-arch>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 16, 2025 at 08:53:09PM -0700, Stanislav Fomichev wrote:
> On 05/17, Al Viro wrote:
> > On Fri, May 16, 2025 at 07:17:23PM -0700, Stanislav Fomichev wrote:
> > > > Wait, in the same commit there's
> > > > +       if (iov_iter_type(from) != ITER_IOVEC)
> > > > +               return -EFAULT;
> > > > 
> > > > shortly prior to the loop iter_iov_{addr,len}() are used.  What am I missing now?
> > > 
> > > Yeah, I want to remove that part as well:
> > > 
> > > https://lore.kernel.org/netdev/20250516225441.527020-1-stfomichev@gmail.com/T/#u
> > > 
> > > Otherwise, sendmsg() with a single IOV is not accepted, which makes not
> > > sense.
> > 
> > Wait a minute.  What's there to prevent a call with two ranges far from each other?
> 
> It is perfectly possible to have a call with two disjoint ranges,
> net_devmem_get_niov_at should correctly resolve it to the IOVA in the
> dmabuf. Not sure I understand why it's an issue, can you pls clarify?

Er...  OK, the following is given an from with two iovecs.

	while (length && iov_iter_count(from)) {
		if (i == MAX_SKB_FRAGS)
			return -EMSGSIZE;

		virt_addr = (size_t)iter_iov_addr(from);

OK, that's iov_base of the first one.

		niov = net_devmem_get_niov_at(binding, virt_addr, &off, &size);
		if (!niov)
			return -EFAULT;
Whatever it does, it does *NOT* see iov_len of the first iovec.  Looks like
it tries to set something up, storing the length of what it had set up
into size

		size = min_t(size_t, size, length);
... no more than length, OK.  Suppose length is considerably more than iov_len
of the first iovec.

		size = min_t(size_t, size, iter_iov_len(from));
... now trim it down to iov_len of that sucker.  That's what you want to remove,
right?  What happens if iov_len is shorter than what we have in size?

		get_netmem(net_iov_to_netmem(niov));
		skb_add_rx_frag_netmem(skb, i, net_iov_to_netmem(niov), off,
				      size, PAGE_SIZE);
Still not looking at that iov_len...

		iov_iter_advance(from, size);
... and now that you've removed the second min_t, size happens to be greater
than that iovec[0].iov_len.  So we advance into the second iovec, skipping
size - iovec[0].iov_len bytes after iovev[1].iov_base.
		length -= size;
		i++;
	}
... and proceed into the second iteration.

Would you agree that behaviour ought to depend upon the iovec[0].iov_len?
If nothing else, it affects which data do you want to be sent, and I don't
see where would anything even look at that value with your change...

