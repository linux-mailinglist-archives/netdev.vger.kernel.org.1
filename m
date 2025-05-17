Return-Path: <netdev+bounces-191275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EE4ABA824
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 06:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6E34A6035
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 04:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259D617C211;
	Sat, 17 May 2025 04:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ER0h8OUI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABC34B1E6D;
	Sat, 17 May 2025 04:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747456197; cv=none; b=uHEgvGFGsyM7gv6GQiIlHE4LHlRvp4Cr4bfzfJSdOscU7kMKss/YMh7MykQzKNU+2MxG+oZlt9uHcM5bICWPkWg3Dh76YGHFFWuWTXUQWBWC8Z32TUY9fj4SKYAidXGQHxY8a3ny1Vf95R+eN+3scU9qHiOQRUpKPFRds0wBqCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747456197; c=relaxed/simple;
	bh=us3uAxHHBB4aGKhkIni/p+p9xN44SMQSaBFPnYz7h1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQ04f2UO78h/DoPuoqob1gf6CgH07sU0dWfQlTBZ6AZn632dQrnzCCCMH0HQF73fN2MZRosmD2huPUDMzNrADaUE+rCd27ExtG5jr7XkRU8tQflYY/9f+AreuS9RBpzcW85PVcFig+Yw6RqVlMhYvyljTh578xAomxkzUYs2fTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ER0h8OUI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22fb7659866so33870285ad.1;
        Fri, 16 May 2025 21:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747456195; x=1748060995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WYJVB6FmgCa4vax+m6B8cPs+U85Y27xAnQt4mT2A9qs=;
        b=ER0h8OUI87PuRMI5k6xAzKIIu39si6pc8wleqW07RBFp8ck4GSl+RZ5EaXwmuoGue2
         7OzfGKbtZx01z4cpTDJmlpiBTOVoA6h3dKdfFLbU0MRhaXosY0KvKGzKjG7g4zuyhA41
         GCPipjJpHPfDXyEcJPNWR9cJjjbkdG0Ri4faJbog4kIRnC8Rk+igAaU6CC5QYXnwsth2
         g1YqVdMDYOIBg9uFqRdQMgh9I3ekiB7pLNKuPoqSEB9zZTRtanEPGyoESP3JX5V0ziVF
         Ueb7tp89VBPmb6ua+dyJLnU5As6C2t/eTthRXuGD9JlPLnJ/YaJBCmrNHkYWZNarEmGh
         bTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747456195; x=1748060995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYJVB6FmgCa4vax+m6B8cPs+U85Y27xAnQt4mT2A9qs=;
        b=H1yRVGAvvjTJaKIbEVKFXg9FdG1sasXKBCrz+DoUtA+ll2Hp04ZhAoj5i5WOcfTjgg
         6jRICpg1qbGCNkwPkidJdN6lt2ZwYkXcxqXXEeKonzhy3wQ660dgSwYvo9WWsrdYOmlI
         /miE+BrWiRyeJVszmQ1//N75crYGBaBI9BrUtB3s4JrwK3CY3yFs/6sCo9g50BgwCovA
         OCSraUl5oW2ARk2ubzmu02rbis747Gvom1g++F63f743Sc7+vu/MpIBBFfwkVDTvoR0K
         WGAY8q+0NpQz0vjcCZOQ/2wUo3B4TFrlA0ERvrLmZ9pXPKYhrwK1MhKRm9ohF/OxMGle
         Ki2w==
X-Forwarded-Encrypted: i=1; AJvYcCUMkY39q3bh4Ts0m1tCmN85W6UeaBC5u3e3yeZN22e7jp/AVceDyVm4hXA0DkZZwjsmiwuQgSfZ2zc7iE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSCpSHrGWtEUXl+iyTblq0Iu9Cubz8faiq2RydG7zDOap3B449
	K57Tj+XoFLVNg0Bgg7C8UI1cuyoKzsBPRDyIbqaFv6LYiuNB48YCEOY=
X-Gm-Gg: ASbGncuHs1eIQBvybq7ZFV8farvPFP2gdAdZHX33qC70OHAN3fgRBoOuabJlCM4habr
	kQ9Ir7nvX19KIeZTOm4EXFqXLFsdmDSX0dL2IMzf7m54ieadyRvEuhd7FPOBwZa4M3HUWjCYffr
	w20aWUpYw6OtidfDBOps6Qp6GauH+bJ4nOwM1Wo+HCW2BwoaL4dk3ulrPS10ASvtI4QzG8WhFTK
	/sw6EGfu0bbN+EbKifjpkPpMRdjzN2Oxk8gaDBhStxkhsdIrvUf/SliX04qf1T6KptZQA+U6c8W
	1Gm649Agl7B9SIDTjRZ7oMohdMWwTw5Ig8/Jxx0dISgDB6yUwJ7IGrfpz1fRWV7egLPT1Hq+DSb
	pAld/frkQsrnt
X-Google-Smtp-Source: AGHT+IGJJZzy2itURKjsuT7s8+o8cSjWrOvDKvt10ByEkvEoiohilq57/Nc4qqFtrzSoG6CW8ynqGA==
X-Received: by 2002:a17:902:c411:b0:227:e6fe:2908 with SMTP id d9443c01a7336-231de3bb4a4mr71703205ad.48.1747456194591;
        Fri, 16 May 2025 21:29:54 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4e97227sm22191455ad.109.2025.05.16.21.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 21:29:54 -0700 (PDT)
Date: Fri, 16 May 2025 21:29:53 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	willemb@google.com, sagi@grimberg.me, asml.silence@gmail.com,
	almasrymina@google.com, kaiyuanz@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: devmem: remove min_t(iter_iov_len) in
 sendmsg
Message-ID: <aCgQwfyQqkD2AUSs@mini-arch>
References: <20250517000431.558180-1-stfomichev@gmail.com>
 <20250517000907.GW2023217@ZenIV>
 <aCflM0LZ23d2j2FF@mini-arch>
 <20250517020653.GX2023217@ZenIV>
 <aCfxs5CiHYMJPOsy@mini-arch>
 <20250517033951.GY2023217@ZenIV>
 <aCgIJSgv-yQzaHLl@mini-arch>
 <20250517040530.GZ2023217@ZenIV>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250517040530.GZ2023217@ZenIV>

On 05/17, Al Viro wrote:
> On Fri, May 16, 2025 at 08:53:09PM -0700, Stanislav Fomichev wrote:
> > On 05/17, Al Viro wrote:
> > > On Fri, May 16, 2025 at 07:17:23PM -0700, Stanislav Fomichev wrote:
> > > > > Wait, in the same commit there's
> > > > > +       if (iov_iter_type(from) != ITER_IOVEC)
> > > > > +               return -EFAULT;
> > > > > 
> > > > > shortly prior to the loop iter_iov_{addr,len}() are used.  What am I missing now?
> > > > 
> > > > Yeah, I want to remove that part as well:
> > > > 
> > > > https://lore.kernel.org/netdev/20250516225441.527020-1-stfomichev@gmail.com/T/#u
> > > > 
> > > > Otherwise, sendmsg() with a single IOV is not accepted, which makes not
> > > > sense.
> > > 
> > > Wait a minute.  What's there to prevent a call with two ranges far from each other?
> > 
> > It is perfectly possible to have a call with two disjoint ranges,
> > net_devmem_get_niov_at should correctly resolve it to the IOVA in the
> > dmabuf. Not sure I understand why it's an issue, can you pls clarify?
> 
> Er...  OK, the following is given an from with two iovecs.
> 
> 	while (length && iov_iter_count(from)) {
> 		if (i == MAX_SKB_FRAGS)
> 			return -EMSGSIZE;
> 
> 		virt_addr = (size_t)iter_iov_addr(from);
> 
> OK, that's iov_base of the first one.
> 
> 		niov = net_devmem_get_niov_at(binding, virt_addr, &off, &size);
> 		if (!niov)
> 			return -EFAULT;
> Whatever it does, it does *NOT* see iov_len of the first iovec.  Looks like
> it tries to set something up, storing the length of what it had set up
> into size
> 
> 		size = min_t(size_t, size, length);
> ... no more than length, OK.  Suppose length is considerably more than iov_len
> of the first iovec.
> 
> 		size = min_t(size_t, size, iter_iov_len(from));
> ... now trim it down to iov_len of that sucker.  That's what you want to remove,
> right?  What happens if iov_len is shorter than what we have in size?
> 
> 		get_netmem(net_iov_to_netmem(niov));
> 		skb_add_rx_frag_netmem(skb, i, net_iov_to_netmem(niov), off,
> 				      size, PAGE_SIZE);
> Still not looking at that iov_len...
> 
> 		iov_iter_advance(from, size);
> ... and now that you've removed the second min_t, size happens to be greater
> than that iovec[0].iov_len.  So we advance into the second iovec, skipping
> size - iovec[0].iov_len bytes after iovev[1].iov_base.
> 		length -= size;
> 		i++;
> 	}
> ... and proceed into the second iteration.
> 
> Would you agree that behaviour ought to depend upon the iovec[0].iov_len?
> If nothing else, it affects which data do you want to be sent, and I don't
> see where would anything even look at that value with your change...

Yes, I think you have a point. I was thinking that net_devmem_get_niov_at
will expose max size of the chunk, but I agree that the iov might have
requested smaller part and it will bug out in case of multiple chunks...

Are you open to making iter_iov_len more ubuf friendly? Something like
the following:

static inline size_t iter_iov_len(const struct iov_iter *i)
{
	if (iter->iter_type == ITER_UBUF)
		return ni->count;
	return iter_iov(i)->iov_len - i->iov_offset;
}

Or should I handle the iter_type here?

if (iter->iter_type == ITER_IOVEC)
	size = min_t(size_t, size, iter_iov_len(from));
/* else
	I don think I need to clamp to iov_iter_count() because length
	should take care of it */

