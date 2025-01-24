Return-Path: <netdev+bounces-160791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9873EA1B7F1
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 15:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475DD3AD8BD
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 14:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82B413AD20;
	Fri, 24 Jan 2025 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hyg2MW6r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35044EB48
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737729332; cv=none; b=fB5+BC+UibIwGqt5/s5MGFGOCwzBEXRaDglCgvga7kQxAgojnO4EeYWVBmpiLgDjp2jNIwI432Kq2DRlcd6EZTXZtOfUx+kfwFJf6Mz0y0A562D6U7Mxa5VieuIQGOhA21PeudrDiCyj6zDkfJ1aE5QelbCiFRfZ/ulBDDaiUVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737729332; c=relaxed/simple;
	bh=tqw4o/GKPnNWOqSfm3i27RdtSC64h3bApxEjgi6XcSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDOtlwKKhMaYRAGRGxb9lpYqsDqt5Qhyld7TTe3cVzvZ7J+5P05X1QOijmu5ngAjfAdqBs81PQB+yo5rXu+0ldF7DZtK4b9UmgPa1xaeeLzC2Ssr8W3hm9yzKCo9Lp8wSvfnAd21lolVMdD7zr7DQMvPv2aTFvjv0phD1iVDumE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hyg2MW6r; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so24389665e9.0
        for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 06:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737729329; x=1738334129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5+Qt0Zoq5UL6Qxp/U1x4G4wPdwvA0OwIDNPcXZmcPws=;
        b=Hyg2MW6r347ZppOcntFO4BlYEkJgnD3M5tzCz0YKEAjmA62CXtgxFpMgq+X/tqbN8W
         hui/BuRvI4bCnESYzfRHvlrz1WXSm2UNljbd+YDqmoILdiUM2tD0JvrZOjImaj6qv7Ig
         MCoLiC6Nlv3z99kWOXDCJG2pMKP6D7MGKXRg8dciMCjYUo2DO4K364/ssknyXPMwtNyt
         xm4Gu+m4k15Ej5INKP42Ap5FdP63A0ZGlHRAA4xZUK2CucuXOtHAYAMYarGmCauu2kJ1
         NZ5Nk/OIZtJn4oEmOMMbg4GpoaVMP4ItqGHLnIP/27rd5SLUejFQjYnmcqo6OC8oQ9Ms
         oqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737729329; x=1738334129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+Qt0Zoq5UL6Qxp/U1x4G4wPdwvA0OwIDNPcXZmcPws=;
        b=GmR/6U7zw3QdAy4PrQhmM1PMpi1wfqWB2JY1lU8bXAd9yQeYwdr1nuxNtw65LaOOet
         CUBzQxNCQog1l2BEMapQ2GdlI1KjmZ5ZNimC+FJg15sH6Nt3NaAFgIIwurPZyPMGg36j
         yzrK+yMeKM6n7RElXi8gRkey06lwf9pb/iGUdQ36ThkERDLwTGO5nVcs+rYQgVGaDMsK
         z0IOEw8KJgPgJCcqExdEgIK86rleTTcFFWLhqMHQhxGnWTZuLo769Pijb92PJSeVOBD3
         TBMmNubi/Q/ZZVjcBENPy+2hBgfi+jwP7t+k6JLljRcfdytszT+Sp+JDr8GIQ97byD6Y
         eMcg==
X-Forwarded-Encrypted: i=1; AJvYcCV9KKhSob+osLAKZlqX2dA5ZIb0zPr748nS0wahgU8yVFR3WsRXELKVw6WD+vquKzEeQS6COlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq30f6oGaHnCmh8knYXzBTodnpEmkBlY7Ui7pEPLWiBbCnGv/l
	cvhN1WlHEdrzz0b82keQ7FD9RDNjdP2lzwAyPmeV3RtbcCfE/e94HYQBG/L4pxs=
X-Gm-Gg: ASbGncsjqcCw9Qd7I7a1CFL9JsjvvFt4LLTuUPH7yFqS4ZtPsvCxLQHhA5gZD5dVXLW
	a/EpiXmGA9Qrjxq2wvrAr9avHgb84eHn/nhqmaPMc/0IyHUXD6TNvTHoEtbR5zXej9QlG2M4liz
	aPCADFxxuvsr5PLMXrmCMGwfML1qJ9LlzFxRaDqc+ee67VmieyZCP42vDKkZ7lEUWyCdlqdhYiS
	l9niQD44eFUAb3WyQdMnoncIKFG4HM+s79LTsI3bmcvtXN+6Q4SMO7OMqQvGsZqcUgzUAYhMKv3
	IBvJzueE0Q==
X-Google-Smtp-Source: AGHT+IE7bMiyF9uAQFEhqau5Ih7ib6+HwTAas1ruEAGeXxqf310qPqqB9zQqihGd3kSjbGxBaW0kew==
X-Received: by 2002:a05:600c:6b18:b0:438:a1f4:3e9d with SMTP id 5b1f17b1804b1-438a1f43efdmr202842085e9.9.1737729328670;
        Fri, 24 Jan 2025 06:35:28 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd54bfa5sm27898335e9.25.2025.01.24.06.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 06:35:28 -0800 (PST)
Date: Fri, 24 Jan 2025 17:35:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thomas Graf <tgraf@suug.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] net: netlink: prevent potential integer overflow in
 nlmsg_new()
Message-ID: <04dbe1d5-51e8-42d5-a77d-59db4bc13957@stanley.mountain>
References: <58023f9e-555e-48db-9822-283c2c1f6d0e@stanley.mountain>
 <20250122062427.2776d926@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122062427.2776d926@kernel.org>

On Wed, Jan 22, 2025 at 06:24:27AM -0800, Jakub Kicinski wrote:
> On Wed, 22 Jan 2025 16:49:17 +0300 Dan Carpenter wrote:
> > The "payload" variable is type size_t, however the nlmsg_total_size()
> > function will a few bytes to it and then truncate the result to type
> > int.  That means that if "payload" is more than UINT_MAX the alloc_skb()
> > function might allocate a buffer which is smaller than intended.
> 
> Is there a bug, or is this theoretical?

The rule here is that if we pass something very close to UINT_MAX to
nlmsg_new() the it leads to an integer overflow.  I'm not a networking
expert.  The caller that concerned me was:

*** 1 ***

net/netfilter/ipset/ip_set_core.c
  1762                  /* Error in restore/batch mode: send back lineno */
  1763                  struct nlmsghdr *rep, *nlh = nlmsg_hdr(skb);
  1764                  struct sk_buff *skb2;
  1765                  struct nlmsgerr *errmsg;
  1766                  size_t payload = min(SIZE_MAX,
  1767                                       sizeof(*errmsg) + nlmsg_len(nlh));

I don't know the limits of limits of nlmsg_len() here.

The min(SIZE_MAX is what scared me.  That was added to silence a Smatch
warning.  :P  It should be fixed or removed.

  1768                  int min_len = nlmsg_total_size(sizeof(struct nfgenmsg));
  1769                  struct nlattr *cda[IPSET_ATTR_CMD_MAX + 1];
  1770                  struct nlattr *cmdattr;
  1771                  u32 *errline;
  1772  
  1773                  skb2 = nlmsg_new(payload, GFP_KERNEL);
  1774                  if (!skb2)
  1775                          return -ENOMEM;

*** 2 ***
There is similar code in netlink_ack() where the payload comes from
nlmsg_len(nlh).

*** 3 ***

There is a potential issue in queue_userspace_packet() when we call:

	len = upcall_msg_size(upcall_info, hlen - cutlen, ...
                                           ^^^^^^^^^^^^^
	user_skb = genlmsg_new(len, GFP_ATOMIC);

It's possible that hlen is less than cutlen.  (That's a separate bug,
I'll send a fix for it).

regards,
dan carpenter

