Return-Path: <netdev+bounces-188758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD9BAAE81C
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 19:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8471E1B68F38
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 17:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DFB1DF748;
	Wed,  7 May 2025 17:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joAy1pSb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF964B1E7B
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746640083; cv=none; b=hV4HU/CkohMOSsmkxSdkYAjJ5OO2DlZhLeePgtJ3IkZnCV65dvGSGuWANQMqh+sS/PAyeQIStx5Jt0KrNc6U+0VIRSFYrt+4u5d/9aSDZBePvK/j7fhzUto7bOQFPa0PMfKZY18GjwJ2pToqGdH6OOFpOWw2GkLKjbwdfdIWkFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746640083; c=relaxed/simple;
	bh=kBFSxNa7pSMUNAap1ENd44xFvmHNyHCL2gFTR6BrVfI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tMUJ870tXeBRNf+ykfSB+wspnjK1LhcN+XXKXD8Nv4subctChepIh0/QzzeCUqiXsgRs05ugIIWx9F2HgbdWi7yWsSGQnidxFzE9QEF4Lw3f4y3C4pD+x6ZHGeLqtCNE2SI6aqmSDlMIpygGVRvG8DhzSPV/9xtQ8Dw7OPLPpmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joAy1pSb; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6ecf0e07954so2442746d6.1
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 10:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746640081; x=1747244881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQSmPTDbULmzMF5gJg4AJqSu8sXW4nk4u9j8nFhsi9I=;
        b=joAy1pSbjP9P08lZeFAi+kUSi/+eJ0KVfsbQKcVhi93a/G+Nbwr8jIBEAq13wLECeF
         Mun34Yj84pKGyHeD+/Ee/w53r+qxrZgAmGIxYRftxymUK3e56/PWr24YzcZ2sGGr1ESO
         FSOZqCZ0hbfndEVTzxd6aB963oa+8wp0sKESUc1DoF1nDlNOZX1Vq+udvRujeDW8pArB
         dFsrRuldctMqwiLkI+/GoAu2YysHtoedeC1dLMSNjvsz5gWaaFgk7D9okBOUVcnp95Fi
         GYdNPOw1OZzFa9wFNLBrLJbY1+ujHP/4Rq8PDe2M3EC9U+quitgxe/jriV+sh/EwD1De
         yQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746640081; x=1747244881;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QQSmPTDbULmzMF5gJg4AJqSu8sXW4nk4u9j8nFhsi9I=;
        b=CrMKdkHHPtWYVO3Iy33lrqcU/aNnIi6CJkeCvtLj+ElzL+8equ/aKHIcFo2daBb5Hx
         DtsgSiIFfWwjhV3kCpzeaoUV58xnk/kANFD5SAI/tN4+rn8I7TTuzg4ExSKtHThQa4aE
         q6CZofTbZqepJuO5Q+XcQb8VRezFKveYsR1YvgCHt/4arRWUsH3BSfbaNOdh2sTkHGQ8
         B+pxS9mjJr2Rc0s2nq1vTPw7Tm4TGfcXpnwfBoItLyu6Va1paOgsmkpAKixEtdt98iQN
         TDkRvJLBfAUQzkW/LKVMMizss2O+gA91XFAnJZWx9ft5KNBcXyPvjzPe1VJ1O+lGpR1N
         c8+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhqN+PU75wWr+K8+lxqjdaEIUFfkpQh9yIItKnkrHOeP/4zpHgr7Ojr9Vj2XrM7tToUOyqWCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ3o6fhxseCIyGtHvevBvSvFZ2cnTxT7aK1xGgtluqsjKgB9hy
	Dz/06AzhyfWFoza5NJLAuSqxka/i4UHLC5boa0G5bCyW0xWrmXA4
X-Gm-Gg: ASbGnctaw903ZrmhqoF4vh2ry8iHUpwfs72EBSrn9Eq9E5n2loFygSX47/I/0ILDcdD
	J8IAqLRxpPIAq7QKFgC5iAjJQeqli8TzW+JB8/QSrWRYP7jQMAQU+6ITaakboYeyXrGDZCdcxUK
	Hu+w5X3JyrAGUTmfhGqG4Rqj624k5MgZLoKjiYn303rmyhI5w6yy0xSOHjmTD8ypFYLGFv5PO1S
	e2b5EaNHdiZmt/8T06vq/elJIpdGj6kvXwljkgxg/CyD8+KCbCje1f73Ri2sxvbRojTHk+F9LKR
	Ujb8Q95Tbd60Ww89rSMP3pBjQd3r72E2eykTIJI1BLPT6e3OV62jX6RFiWcN/e5HzBnzzdSmNGx
	oQt/g6HsC2FdXEuoL8enzB7cVj7qmoAk=
X-Google-Smtp-Source: AGHT+IGfGRCqCg93LEMzDK3ypi3hdHaxZz0AOBWRpxRd2uNuNoA/VmcLD/gtGuUnj++rH1zAvgcWbg==
X-Received: by 2002:a05:6214:5c9:b0:6f5:4508:fd84 with SMTP id 6a1803df08f44-6f54509024dmr46081966d6.35.1746640080568;
        Wed, 07 May 2025 10:48:00 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f542798fbdsm16807316d6.99.2025.05.07.10.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 10:47:59 -0700 (PDT)
Date: Wed, 07 May 2025 13:47:59 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: David Howells <dhowells@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, 
 Andrew Lunn <andrew@lunn.ch>, 
 Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Hildenbrand <david@redhat.com>, 
 John Hubbard <jhubbard@nvidia.com>, 
 Christoph Hellwig <hch@infradead.org>, 
 willy@infradead.org, 
 netdev@vger.kernel.org, 
 linux-mm@kvack.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <681b9ccf970c5_1f6aad29428@willemb.c.googlers.com.notmuch>
In-Reply-To: <1352674.1746625556@warthog.procyon.org.uk>
References: <20250506112012.5779d652@kernel.org>
 <20250505131446.7448e9bf@kernel.org>
 <165f5d5b-34f2-40de-b0ec-8c1ca36babe8@lunn.ch>
 <0aa1b4a2-47b2-40a4-ae14-ce2dd457a1f7@lunn.ch>
 <1015189.1746187621@warthog.procyon.org.uk>
 <1021352.1746193306@warthog.procyon.org.uk>
 <1069540.1746202908@warthog.procyon.org.uk>
 <1216273.1746539449@warthog.procyon.org.uk>
 <1352674.1746625556@warthog.procyon.org.uk>
Subject: Re: Reorganising how the networking layer handles memory
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

David Howells wrote:
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > On Tue, 06 May 2025 14:50:49 +0100 David Howells wrote:
> > > Jakub Kicinski <kuba@kernel.org> wrote:
> > > > > (2) sendmsg(MSG_ZEROCOPY) suffers from the O_DIRECT vs fork() bug because
> > > > >      it doesn't use page pinning.  It needs to use the GUP routines.  
> > > > 
> > > > We end up calling iov_iter_get_pages2(). Is it not setting
> > > > FOLL_PIN is a conscious choice, or nobody cared until now?  
> > > 
> > > iov_iter_get_pages*() predates GUP, I think.  There's now an
> > > iov_iter_extract_pages() that does the pinning stuff, but you have to do a
> > > different cleanup, which is why I created a new API call.
> > > 
> > > iov_iter_extract_pages() also does no pinning at all on pages extracted from a
> > > non-user iterator (e.g. ITER_BVEC).
> > 
> > FWIW it occurred to me after hitting send that we may not care. 
> > We're talking about Tx, so the user pages are read only for the kernel.
> > I don't think we have the "child gets the read data" problem?
> 
> Worse: if the child alters the data in the buffer to be transmitted after the
> fork() (say it calls free() and malloc()), it can do so; if the parent tries
> that, there will be no effect.
> 
> > Likely all this will work well for ZC but not sure if we can "convert"
> > the stack to phyaddr+len.
> 
> Me neither.  We also use bio_vec[] to hold lists of memory and then trawl them
> to do cleanup, but a conversion to holding {phys,len} will mandate being able
> to do some sort of reverse lookup.
> 
> > Okay, just keep in mind that we are working on 800Gbps NIC support these
> > days, and MTU does not grow. So whatever we do - it must be fast fast.
> 
> Crazy:-)
> 
> One thing I've noticed in the uring stuff is that it doesn't seem to like the
> idea of having an sk_buff pointing to more than one ubuf_info, presumably
> because the sk_buff will point to the ubuf_info holding the zerocopyable data.
> Is that actually necessary for SOCK_STREAM, though?

In MSG_ZEROCOPY this limitation of at most one ubuf_info per skb was
chosen just because it was simpler and sufficient.

A single skb can still combine skb frags from multiple consecutive
sendmsg requests, including multiple separate MSG_ZEROCOPY calls.
Because the ubuf_info notification is for a range of bytes.

There is a rare edge case in skb_zerocopy_iter_stream that detects
two ubuf_infos on a single skb.

                /* An skb can only point to one uarg. This edge case happens
                 * when TCP appends to an skb, but zerocopy_realloc triggered
                 * a new alloc.
                 */     
                if (orig_uarg && uarg != orig_uarg)
                        return -EEXIST;

Instead TCP then just creates a new skb.
This will result in smaller skbs than otherwise. But as said is rare.

> My thought for SOCK_STREAM is to have an ordered list of zerocopy source
> records on the socket and a completion counter and not tag the skbuffs at all.
> That way, an skbuff can carry data for multiple zerocopy send requests.
> 
> David
> 



