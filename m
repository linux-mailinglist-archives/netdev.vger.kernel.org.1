Return-Path: <netdev+bounces-257974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEAlNrYjimnqHgAAu9opvQ
	(envelope-from <netdev+bounces-257974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 19:13:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7955C1136B9
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 19:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D99D430071CD
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 18:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741F338A715;
	Mon,  9 Feb 2026 18:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AbH3+lvh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2043E38A2BF
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 18:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770660786; cv=none; b=m8Cbvd0+dcD/UWambMmWeM7WEE4wnxud5/HVMjbKsBJAYUxfDOHGDpRuGIsusOfHcKrgae+UQAaR1cXtGPXta50W0b6tDpaOWaZMVtzO1Px9eWJa275i6kiyuLW9MnDC+qqT8+stecVISz7aCDuzPYZVAo14DwPg6H5x2loKAGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770660786; c=relaxed/simple;
	bh=PeEEdOtlWgGbz3Jd1O6AJXyAdP02Oo5lyj4NDiwFBIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvab8GBYemnjFsUhEJH3fIs5/b6C0rgb9RzvPmfN9f0HPtWhD8D4D+beueMkr1MCXmqipORZ2rp8rt9QePeJigRT73Nj1X4SrwoaNLoh0ZlMsf+/2KQwHChXJrj64KcTijLjOnS2lbJ4jedfc0n8yuzbcynnk9hLSqa+Nqw2LJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AbH3+lvh; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c710439535so2191485a.1
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 10:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770660785; x=1771265585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gj5UuRmjNHB03u99WDJiaFn+Q1sTfKxV+46xet6mPYw=;
        b=AbH3+lvhP+aCORsv+XB1KhdCwpglgXrHZjqVkU+at4UulhW31gAR4Awws1C6o1J+mk
         JDXBHUW/sit5R1Kj5WFCo/oUPlZPyo3Yx4SnpcKMu4ImkFpNYQXh+KcuDQOQejf4l/Qv
         EJdxMLnr7Ec+N6WGwOXyknd4938ooiOd+8c7r6QvG9695qbM4ooG7Tl+frmQUSEImYEY
         sRgHqqrgEfwKF1EETl1aReDnQFvMk0vo9/d3MvtU5sMbbiKVIfNGooHYmOdDKnqmXNYU
         Sgg5JCFvw5n5hpXjHlP9F/udM7pk2R5sQGFLZg/t9I/c8cYX+7xFnJteVmVEd+sC4vDt
         ckFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770660785; x=1771265585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gj5UuRmjNHB03u99WDJiaFn+Q1sTfKxV+46xet6mPYw=;
        b=V3ulG7EFkCAzcwmifuAVTIpXADZ8VeqZ4DzysOVulmHIXZD8Jh2SRpscF1joq4SSnE
         sBtmW66bD/jFZQ26VHNOHV4atIFr2eIQj29NU2o+Y6GsHaaj02fzGeFtZ5O/x2XckWBe
         QF8to4WXF4VM0L2gUlmEny0aKVtQw0CQUIiujUAMDOryCuP7GDqpgLiimmAjrsUK0sGW
         mpMkcFw9rxxbSkl04wpGVF2VJrst65T2x8tXySZT8GQ4+eMCcyEwQJ/UxVnOeqBfOWlp
         dBzWJnPos+z+I/m41z9uaBPXqnnYsd/ZVdtm3aJ04tpZjXoMAiP10+RuW/PAbkMvGca8
         3HQA==
X-Forwarded-Encrypted: i=1; AJvYcCWq64vFu5IQV/A7WuVaIRftCtR+sl99YChJ8MYk6pSj8OuCQjnO0ClBdTHg9CuRtMv/jMZMuRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1oOyxEKghYT1DML5Gy3UFJANAgR7NOMsbyOMt1h3SBzNIwQFd
	RIO7TDjXr6bdM7bPMKhzryyYsWmUI6UvLkuqzWSvz+YnhXCxlgsn19mGus2ftsds9hM=
X-Gm-Gg: AZuq6aLVk8nPwkRXyvdTF7zjSuaakrR0brOJn6Yrf4Kh4ojLg3XwUCyV6wrcW+buAYp
	5lRy4oHj2iReIE+i6Rf+gKHhYAGa7MVVaeFJxZfhmHHMTdw3AZFgn7MUJfGIYbtAqN4X2HDLdvN
	f/12RPjSfUXITiFB24VU0XMCDXjhUz73C+tLyT+Jm1stgKUDq0l2x+glDrjWn5ZQaptT6uUYPZ7
	6UEbh4wES/V4kunYTCknKq5Dp5PuOb+MwupqGf0N7U+B1oojeoulDtTOF3J4YTHPL51syu0lLnA
	nR6NNPcVHOXQ6Mc+50IXFH+haGZBB5I21azrIkyVEC45LoKtqBqMCLiEWYiVw06jkCYa6Quagr4
	z+RcmjwLlMTwPXvBWnY6VI3WcmJB8p6BeyOOuq+S7u7kC59hnkk9Ad8clmuQ2w7/XfP4ZR3qqno
	j7mFOOJ/LT1BtGe42P+nHPutZmRMGba9/aBVHxfU64Ji5limCBYVri7qvMiYrqwy0ja/MonRzXw
	H33Cw==
X-Received: by 2002:a05:620a:3909:b0:8ca:358a:d636 with SMTP id af79cd13be357-8caf1acd680mr1662509285a.87.1770660784822;
        Mon, 09 Feb 2026 10:13:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-896f79d34bcsm39740876d6.0.2026.02.09.10.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 10:13:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vpVkt-0000000EmNV-2zIP;
	Mon, 09 Feb 2026 14:13:03 -0400
Date: Mon, 9 Feb 2026 14:13:03 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC 0/2] Retrieve tph from dmabuf for PCIe P2P memory access
Message-ID: <20260209181303.GB943673@ziepe.ca>
References: <20260209175317.1713406-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209175317.1713406-1-zhipingz@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-257974-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7955C1136B9
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 09:53:10AM -0800, Zhiping Zhang wrote:
> Currently, the steering tag can be used for a CPU on the motherboard; the
> ACPI check is in place to query and obtain the supported tph settings. Here
> we intend to use the tph info to improve RDMA NIC memory access on a vfio-based
> accelerator device via PCIe peer-to-peer. When an applicantion register a
> RDMA memory region with DMABUF for the RDMA NIC to access the device memory,
> the tph associated with the memory region can be retrieved and used to set the
> steering tag / process hint (ph). The tph contains additional instructions
> or hints to the GPU or accelerator device for advanced memory operations,
> such as, read cache selection.
> 
> Note this RFC is for the discussion on the direction and is not intended to be
> a complete implementation. Once the direction is agreed on, we will work on the
> implementation or a real patch set.

you didn't cc the DRM people who really need to look at any changes to
the dmabuf contract.

Jason

