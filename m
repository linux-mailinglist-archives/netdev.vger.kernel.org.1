Return-Path: <netdev+bounces-191265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3EAABA803
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 05:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794A41899A36
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 03:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB97E1624C0;
	Sat, 17 May 2025 03:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="sfNTXyIj"
X-Original-To: netdev@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D912F43;
	Sat, 17 May 2025 03:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747453198; cv=none; b=WTIdeSEL6Dj5ZBX1YYPxrFh6Nx1QATwu/vW/9gQdCcXXOcg4Na62gFrfHdyPtZIJQo6Kp14fKA40BTKKR/1GDpide5mtksiyzon33mqKW1fchDwO4oGpXFw0jIIBitwlVX9HXzymK2nvHUHRRsIqU2+OCjT2soAi8spjFWmeWzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747453198; c=relaxed/simple;
	bh=PGa4EiRrgRhiP5aBVe2PFW/nA9HCYtpw8LXxEJrTH4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtIo7O9hPeztrC+O72FB0p+aRf6KEgjmwt9QtHktBvL2iQkWvdm+UabKVuRzYVfmjF7lK6ziWe4JF14CFhkRCX+yY32P0+/RyHCgrLuwq6K1QuvU44+qUtFb7ls1lRBDgt8933ZCuhH27t5OfEeZRvJPXCwzybivXzX38mmlDYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=sfNTXyIj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WZnd2lnN+gk3KobiIvYp7I9K2ei+u81FcKEhBrgtfJ0=; b=sfNTXyIjHQfjSiPPMX4mE6xNEc
	DJqC5Zu3hr9p6GNatC8UWXbN6dwMOVvlQL/ugJpBqC//5dTyyddy6jPlIuYFmi5b1qIXonXFWLwNc
	Y8ylIpyyv4khFlNas4LS7WEr2NUdpQ1QenWPXB1zxxbsOa63bQ46bORZH3+S2OGSmSRiq2Cesk4KQ
	szdFk3hNjC/whgEo5atKCqGlOZ5c7/OsPL2ALic7ymvrfHuuR68at4Uny8xX4eGdHk2RgNWGwDVBX
	LxcTDnZmZgQgT3FcaScVAl5Y6xNsjRlfGYH7sEARwFjAZ6gsoxjpeAUbnIauN9V03cB066fVxneMi
	T7SbTaqg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uG8Ot-00000005EMu-3XwA;
	Sat, 17 May 2025 03:39:51 +0000
Date: Sat, 17 May 2025 04:39:51 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	willemb@google.com, sagi@grimberg.me, asml.silence@gmail.com,
	almasrymina@google.com, kaiyuanz@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: devmem: remove min_t(iter_iov_len) in
 sendmsg
Message-ID: <20250517033951.GY2023217@ZenIV>
References: <20250517000431.558180-1-stfomichev@gmail.com>
 <20250517000907.GW2023217@ZenIV>
 <aCflM0LZ23d2j2FF@mini-arch>
 <20250517020653.GX2023217@ZenIV>
 <aCfxs5CiHYMJPOsy@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCfxs5CiHYMJPOsy@mini-arch>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 16, 2025 at 07:17:23PM -0700, Stanislav Fomichev wrote:
> > Wait, in the same commit there's
> > +       if (iov_iter_type(from) != ITER_IOVEC)
> > +               return -EFAULT;
> > 
> > shortly prior to the loop iter_iov_{addr,len}() are used.  What am I missing now?
> 
> Yeah, I want to remove that part as well:
> 
> https://lore.kernel.org/netdev/20250516225441.527020-1-stfomichev@gmail.com/T/#u
> 
> Otherwise, sendmsg() with a single IOV is not accepted, which makes not
> sense.

Wait a minute.  What's there to prevent a call with two ranges far from each other?

