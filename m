Return-Path: <netdev+bounces-180034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7F7A7F2C1
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 04:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745D216A005
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 02:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D208222594;
	Tue,  8 Apr 2025 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="OOYznk+o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CA5134B0
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744080026; cv=none; b=MWxrcI1gpGVeUolcHSqVlnaH9eVq4j3WR6454LUFlPs3UaNF568CH8VWMpCFB6P2iMFOQV4hZsxSkzpGYk7UpHq2Zs2pLP6aVAI8D8o8txvTefEdqKYor6CqvWYTljU03LiKTXBRfEY2+js9Wb1akT6UNHfb97d8iCj1mZEBIAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744080026; c=relaxed/simple;
	bh=GclX1/Hz3iq2deM9AiUAa1x8irbsRBQP4M+KO8hV3Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBQIBn0fi92PVmdzruqSY745MDfEKMWsRajjEOHC9EjILlKucN5iKopjMxdgNOGRIdOy5K7dWt6Z1m4fYSH44ffLyqxPDsxZkgaExZ666pfTXbkd3Pi/OOvHFsdHqOZf4aKm/TM+n+Zyjoam8TiuGGzkY/gASrJFFiiBsdF77XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=OOYznk+o; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7376dd56f60so3632507b3a.3
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 19:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744080024; x=1744684824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gWF+V5aqsXVIqd0oMQvYZjR+8xVKhb52hKX0MLImFg=;
        b=OOYznk+ozTGWM4dCh0HT8SsxYU/lvDTJ2ZwnfpWLfwLAob1ra7t0JbxlBziEWPzWAt
         3LN0t+U+Dr/gJUJSa0T08MTvltN0gPWx0/5KV1ELvRE/5OyKNKcwtw1ujg3sGqPBDE6V
         5v+KE9ek3jf1HoHDM1ruk0i5A2Bp7sb4WJEW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744080024; x=1744684824;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/gWF+V5aqsXVIqd0oMQvYZjR+8xVKhb52hKX0MLImFg=;
        b=EKa5VowuR3QspEzeG4CMLJCFb62jri+XbsIUrFmELlhM3tv+dLI7cwZWRBneUuTslJ
         rWjrNsq4Fb6cKSbDsvNHKwCDR4QoCglI3qQgbv0RNp2ppoD7XhsNyfPkTmOeKLhLSEZV
         0Wo92friN4MUruKwiV9kBsjpEBiwm+Ll3bRejn8Yl4Mhhh9nVJLnv5XssksIodYX3bs0
         UXL1e0fmN1myi9+9wZ5PbTlJyapDxfmtYK+RzUWm1AeqEnK9bSO/oZUc28B5hpGovInn
         XsxLZqKpvvn3QIlypvdny4B+7XtdbP1wvBnMam9UBTbEZowgdjgL5QEwsSNEMSMLqf7l
         W6aQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKwreJtdAbpyQy32FyJimxz6/w8hLu3nPwyVxDjboPv8xCN71AePBUkmEVXeZ5xgWaJIOAaZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMNKKQfsAjEcbj5PN3afb/Myd/zpe1FBjbabeLFrTLISsUfGv2
	praTWH5GssAyd6bMSOrLw3eXSjrMA4FiLClVgjQ2ym0Mvpdd/1y5LXB+M1P/rDw=
X-Gm-Gg: ASbGncuN+UEZTybNoAcmbVHd47fqqn8QpdFe+fHnpKLz0cNjOhgByjH+y+QM2hCD1+h
	MRauuFKBJhatjxEdHdU3csHCj9xdk6/Q2LkSn/9CxiFZXOoVHU2y3uuYUufxCAtJpuEgHnS344t
	nW4TovLP3+ZJ2Ctmq37GS7wsUKuCWscA5vspsQso/WBVQ9nnD2IK5x2WaY3jyBYte6PmLD4NBDE
	EIIbR91qo4MpLy9fGtXYwekmztQDjlzMbm6XSuWjrKCbWkjjx2p5uNxYallS6RECRVpWLmxmmCp
	t1+BYGzoMBL/obnZKfROwmRzW1eixsneA8/mfupqXDz0YxukxEKn4vt2cK58elSLdQiiX8tHTqX
	9IwEP5tMKfXE=
X-Google-Smtp-Source: AGHT+IGItW8oU02VdzwuAOICAExk7txLelYHV3/6HN2oQp8IwkrZ6XPi3+H/mdREURCTlzD952MRyw==
X-Received: by 2002:a17:90b:568b:b0:2ef:31a9:95c6 with SMTP id 98e67ed59e1d1-306a6153940mr21433400a91.14.1744080024030;
        Mon, 07 Apr 2025 19:40:24 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30588a2f626sm9680533a91.21.2025.04.07.19.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 19:40:23 -0700 (PDT)
Date: Mon, 7 Apr 2025 19:40:21 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	sdf@fomichev.me, hramamurthy@google.com, kuniyu@amazon.com
Subject: Re: [PATCH net-next 1/8] net: avoid potential race between
 netdev_get_by_index_lock() and netns switch
Message-ID: <Z_SMlQBO2rmtkJwC@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me,
	hramamurthy@google.com, kuniyu@amazon.com
References: <20250407190117.16528-1-kuba@kernel.org>
 <20250407190117.16528-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407190117.16528-2-kuba@kernel.org>

On Mon, Apr 07, 2025 at 12:01:10PM -0700, Jakub Kicinski wrote:
> netdev_get_by_index_lock() performs following steps:
> 
>   rcu_lock();
>   dev = lookup(netns, ifindex);
>   dev_get(dev);
>   rcu_unlock();
>   [... lock & validate the dev ...]
>   return dev
> 
> Validation right now only checks if the device is registered but since
> the lookup is netns-aware we must also protect against the device
> switching netns right after we dropped the RCU lock. Otherwise
> the caller in netns1 may get a pointer to a device which has just
> switched to netns2.
> 
> We can't hold the lock for the entire netns change process (because of
> the NETDEV_UNREGISTER notifier), and there's no existing marking to
> indicate that the netns is unlisted because of netns move, so add one.
> 
> AFAIU none of the existing netdev_get_by_index_lock() callers can
> suffer from this problem (NAPI code double checks the netns membership
> and other callers are either under rtnl_lock or not ns-sensitive),
> so this patch does not have to be treated as a fix.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/linux/netdevice.h |  6 +++++-
>  net/core/dev.h            |  2 +-
>  net/core/dev.c            | 25 ++++++++++++++++++-------
>  3 files changed, 24 insertions(+), 9 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

