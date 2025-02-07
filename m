Return-Path: <netdev+bounces-163758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D42CA2B7EE
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 02:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4E918892CC
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136DA2E403;
	Fri,  7 Feb 2025 01:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="TMcs2V8A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CE44C6E
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 01:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738891913; cv=none; b=qNcEle3vcEhrOQ2zbKp6H7J5LX+sZWu+GOCmW7sXMPjaLnaEKn6Byyce/nXye+iQqgY9LlV9xygaW2IyUU3h1NE0Wx+nABtxIm1A1EaecKJwnF/fifLUrhnhE81WI5dl7gZj0FFgriwozWlZZCRpcJsIg+fUGP8VeSIJRez54/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738891913; c=relaxed/simple;
	bh=GUOj2ZnJFMk8jI4YQw6Hs7Ivl5JzKD3GTW85TdS1UPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fp9IwfdeDGHYReb8HTjwPCOZGG7L2Q6bbPcU37ggOgP6CpdauKNrnopGjYPF3q92LdJo11x32cFIzt15o/vhnZwr1XhGoD5L+OFttIsIb/4/b+PYufr2CeLjdo9mnrmtrmXXlkg3XgeJqTeyXbkPEc+Buzz4bhCEM8Fq7nHqhSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=TMcs2V8A; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f40deb941so22969875ad.2
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 17:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738891911; x=1739496711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkdizXVnDff782XdC9GQ7GAh99Z1PbQXJxP3JewgzVM=;
        b=TMcs2V8AEtHfXgEceCWsJCCHvfqC+LK4N6pcubDRs52DW/tQm6N5YnhBPfOuj+KrOT
         t0ZKVvN0VFRU6ZvkGr5I6Q4SlyuiFSsdfmkFHweRhyGYJwonA2vCY0g4ebwJQ3JL0Wdq
         IkJSZ+BBzee6gSQAI0jhzFko9Hok29xop9brg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738891911; x=1739496711;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zkdizXVnDff782XdC9GQ7GAh99Z1PbQXJxP3JewgzVM=;
        b=oFJFd/tGXChpt3ECcIyUMXT/ZWsIdOW3M4M224WTzehGGgRXd448hfQI3xGbJGf8R+
         dGg/V+n9dAd6z0oysaqyQmaEDoamqXWgJL9yWQ3iEHwbkUsVnWq3ZMDt8PkgZ2NA+ivq
         Jb0zEJftYIlUGRCYrNknW8+7oKnEACRENAXnpLiPo/IPwnuBCVvYGi0ZJLmEbSBm+FfM
         9/cX4PHrfolBRMbgEPgddXB4N8ivWUrpqDYdGx5QW4039Yld/F9+sdu3f6rhut1Nxn76
         oVsJ4PPJIrEPoiFmPYFHX9m2Judb7awDF8uwktfQQ3+xjagSSxdePvwVpKN14FP4HDda
         F6jw==
X-Gm-Message-State: AOJu0YyiWyJY/ZyWp2Z0H2mPCd/r/849ELhOKWHN/mNrqBCQslrN9xMN
	wE9ilcie3JWNxuCJ1HGPNpsJSCeJDojvWHB3x3OSBh6aljqQkp9PvY6vAAj+Z/tuc6QsoiyR3SN
	z
X-Gm-Gg: ASbGnct16pAd1j5vEnXc18xHhZo47yFVChVwitwHvNM41TMhKNAnaKiC1DvIiIySYzE
	ZiBn0hp6uPQtgdYB09BMaw2h0zu6YqUuT50bGcYsbEK1nR2KprMeL1jnvNjW+PaXhqKZ0RiDUma
	tfTaBxCLr21yIt7jOHuCxpv/OmzSHx1+4AIxdb99Gwil4UjBma1FsRkiL9DKt8XlEIxRDoZ2eHv
	CIEjy4Ve2d/PH2YNg7mNq4DvwXKqRAcGPgosOtdUYpDZvf7YFy7JCWqXxgDyzFHtJ6ajoNPFzVt
	DEww4KKON2L6KwYFeNBGiz1Dou1qSD8xepeBn7xgJsv+bTfWMFP/f1DOvQ==
X-Google-Smtp-Source: AGHT+IGMVSk0+D0Pm2WrWKIsbJKHGAuK+5twucIHXYMohW7EqwtJaWRIMlCDOxpEZ/uNPENnZ5b76g==
X-Received: by 2002:a17:902:e946:b0:216:7cde:51a with SMTP id d9443c01a7336-21f4e72631dmr29074325ad.28.1738891910784;
        Thu, 06 Feb 2025 17:31:50 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c209sm19268865ad.192.2025.02.06.17.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 17:31:50 -0800 (PST)
Date: Thu, 6 Feb 2025 17:31:47 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/2] netdev-genl: Add an XSK attribute to
 queues
Message-ID: <Z6Vig04c-a46WScr@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	open list <linux-kernel@vger.kernel.org>
References: <20250204191108.161046-1-jdamato@fastly.com>
 <20250204191108.161046-2-jdamato@fastly.com>
 <20250206165746.7cf392b6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206165746.7cf392b6@kernel.org>

On Thu, Feb 06, 2025 at 04:57:46PM -0800, Jakub Kicinski wrote:
> On Tue,  4 Feb 2025 19:10:47 +0000 Joe Damato wrote:
> > +		if (rxq->pool) {
> > +			nest = nla_nest_start(rsp, NETDEV_A_QUEUE_XSK);
> > +			nla_nest_end(rsp, nest);
> > +		}
> 
> nla_nest_start() can fail, you gotta nul-check the return value.
> You could possibly add an nla_put_empty_nest() helper in netlink.h
> to make this less awkward? I think the iouring guys had the same bug

Ah, right.

I'll see what a helper looks like. Feels like maybe overkill?

Thanks for the review.

