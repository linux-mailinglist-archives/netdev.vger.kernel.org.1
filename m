Return-Path: <netdev+bounces-164110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC02A2CA1A
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 18:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF7B3A73A8
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 17:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1DE191F95;
	Fri,  7 Feb 2025 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="bPGNccpg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D13D1885B4
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949104; cv=none; b=DjdZEBN2hV9+kRqfToxxsnoKnZhOcuGnYZ5cMlOLD6CiJGGuTf6GjlRJ2QliMM27xBddLIkGub6BdJyC1tSC/xsFRTMrCbN+DdUvjSyurZSC+0trVx5YKf6TLwipk/PJTr7lHlMohhmbRR/E3h1/PkrH4YUth/PebXSXGnaHFCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949104; c=relaxed/simple;
	bh=iKoA3Dq9s3tWAZm62D5N3xmXxicb6RywtNHezCBtBjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxGEqp4ghPtVYTJkFEYPCSEbppjeXhWaWrv1uvdWqQIPtf7H0TNiRI+yzlaSw9X1zg7jn9dH5V4BBIszEVjHdzAzQXWbs6pdToLAzq26uJNoSUIZeNEvU6botBixOY6MvuqW2TqU4t62lYLBAjUIfunZB4IaPQRp0FVra6kbFHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=bPGNccpg; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f61b01630so8107755ad.1
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 09:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738949102; x=1739553902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1h8iE+x6l6fDJRgf8jTiyVWI9cwMS/v7wWiYAjXKBN4=;
        b=bPGNccpgVP8NAVw2pbgWymIAlF3oqRVcv99rNyir/1U8NVLU3BoRI+TZi6mcoGbwwN
         xrDzjKsGYWyPAsSDalVCxOx85QtuU31dNKp7C6NslBTPBh9DBsc1vFt7FDZ6Xoql6MmK
         janBPaymt43cLvhlsahwguuTakDFFMDvPvpy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738949102; x=1739553902;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1h8iE+x6l6fDJRgf8jTiyVWI9cwMS/v7wWiYAjXKBN4=;
        b=hv/SQUPkw7ogI4ln0LIBGpQvvdwUmSPEjuebofLaPjMX+9CYaMnQMkglizszjo876C
         jNGzXuLXGUw6MybAh7gjcP2Y6SVOME7swuovE5IEOOq/vFD8ERiLlLFKmGQjkJ6NB1A4
         m5dFeG3uJmAb1F+KFUYuCfdGmoh0pCWYN1QhmJk5AywGuRHSQ+V6yi2/8UZW30eBdRvq
         IgpOyrmwVtgnOHnf6ZWZlzxGwXgrZuB2omRpRmRYmjSeDQR//J/PhD2K3v7bEU3wjUyV
         t9mBlS0XwFgplnYKmLpwTLocnWnyd6ONwtx9f7sGg9b+0HhZhlA9qllNuY10ytIiDnwc
         mCog==
X-Gm-Message-State: AOJu0Yy1aGRXLM5EcU08yZ9x7CO+aW+e7jgGYiQMdynH1xnKYnxypDac
	Y+MFUGeM98EZHRdp7dyZ6M2rtmcps8QqZlLahXwyQw17qA81LCYWqXT9oHJaFV8=
X-Gm-Gg: ASbGncsSIrpAlEshUY5jbkp3Yd6JwhlB5hkqE/z7zDoxbcHPxUTe1DqKvZd7/G7lykv
	FfohV7USsvvsRu9agettuwXw1dBIPI2rMGb9azbaY+ol18SkUFJPzLgh67KjH3qALq+aynxSR0v
	N7Z1Wa2TrJTO/LR0LZ3nSOnV1Kuy16czJz/BONn9uZ279oUfhKGibiE9kYC14FQkEQMqHskMaLG
	0hYg/t+Ip+278/X4+BXwIWHKQLjetxLQxkdGb7nk3XbMU0ca8zuSU+0bBT9jYf1rbjx3g8Z8qDY
	IumJYe0TVhMYEYXmGSbd+Xf1DDXMOanBg/UKBzgljIPa1Q5YRg0AOnZgRQ==
X-Google-Smtp-Source: AGHT+IFuPBqihb3KRgNAtHFlI8yllud1dbR8e/Jm9UPR/bBfgMm14QMh/DgJHKaG0i4Y2Ug1DdBN0Q==
X-Received: by 2002:a05:6a20:439f:b0:1ed:a4b1:9124 with SMTP id adf61e73a8af0-1ee05299d4fmr5115662637.8.1738949102366;
        Fri, 07 Feb 2025 09:25:02 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048e20bcdsm3342780b3a.178.2025.02.07.09.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:25:01 -0800 (PST)
Date: Fri, 7 Feb 2025 09:24:57 -0800
From: Joe Damato <jdamato@fastly.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	sridhar.samudrala@intel.com, Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	David Wei <dw@davidwei.uk>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 2/3] netdev-genl: Add an XSK attribute to
 queues
Message-ID: <Z6ZB6SdcO4kBi-Au@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com, sridhar.samudrala@intel.com,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	David Wei <dw@davidwei.uk>,
	open list <linux-kernel@vger.kernel.org>
References: <20250207030916.32751-1-jdamato@fastly.com>
 <20250207030916.32751-3-jdamato@fastly.com>
 <20250207133055.GU554665@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207133055.GU554665@kernel.org>

On Fri, Feb 07, 2025 at 01:30:55PM +0000, Simon Horman wrote:
> On Fri, Feb 07, 2025 at 03:08:54AM +0000, Joe Damato wrote:
> > Expose a new per-queue nest attribute, xsk, which will be present for
> > queues that are being used for AF_XDP. If the queue is not being used for
> > AF_XDP, the nest will not be present.
> > 
> > In the future, this attribute can be extended to include more data about
> > XSK as it is needed.
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> 
> ...
> 
> > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > index 0dcd4faefd8d..75ca111aa591 100644
> > --- a/net/core/netdev-genl.c
> > +++ b/net/core/netdev-genl.c
> > @@ -380,6 +380,7 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
> >  	struct netdev_rx_queue *rxq;
> >  	struct netdev_queue *txq;
> >  	void *hdr;
> > +	int ret;
> >  
> 
> Hi Joe,
> 
> Perhaps this got left behind after some revisions elsewhere.
> But as it stands ret is unused in this function and should be removed.
> 
> >  	hdr = genlmsg_iput(rsp, info);
> >  	if (!hdr)
> 
> ...

Yes, you are right. I originally added it for the empty nest and
then didn't use it.

Sorry that I missed that and caused unnecessary churn due to my own
negligence.

Thanks for the review / catching it.

