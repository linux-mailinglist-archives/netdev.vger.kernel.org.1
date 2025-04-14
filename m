Return-Path: <netdev+bounces-182367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C4AA88905
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25B23A5B7B
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B37D2820D3;
	Mon, 14 Apr 2025 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izR/Pwvt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDC824728A;
	Mon, 14 Apr 2025 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744649630; cv=none; b=hvoZcd/NH5ewGnvbtTh69cUjt5m4CE5tIghnCKfOzfhAGuOOWMk+7kSP6w9xrplhSAnHm6YUZhiGfdZLr0t9hvTEP2HGyVXjzt9mSM1M/bO67arCmtxFMx5JVwUCarQyNEvsQXgS4IPxkm+Lu7YoHIYAbmT4j/tkDV7cKT5vFmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744649630; c=relaxed/simple;
	bh=4NQeonf3Poj7gKWn1Uv38diKo2J8RE//SkdLEunnzwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3yRYB9PFmHDZZs6fTOUx+ObWNegHkMXHEN0VxtB+3i6jw9GWW+vL7v9AnAwm0S9r3jF3zrEZf5HeVkrbn5fsLXxx5qXmn7iBB+/AMgrVh4w+B4pYIPC0nEXXxS2kzFaogIR9uRJOGnmYeSR/EK3VHFt7u14GhxRrcOckxRE9ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izR/Pwvt; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b041afe0ee1so3722382a12.1;
        Mon, 14 Apr 2025 09:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744649628; x=1745254428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4NQeonf3Poj7gKWn1Uv38diKo2J8RE//SkdLEunnzwc=;
        b=izR/Pwvt8VI3Ww08u4qE0ZzRXgt+XjX6e4pxknxHTm1u5KGhHFORPilDQIKEnEKEjG
         msJMJaRHnU3rgcWbzcgiLSeR5gb+WdDzdq23oR7kXrbDpHGSC+EtAdjn0MTJKphB2axe
         nQEj0t6kHAcU8NvB3uSzz4n8IKH6EZtSB4WNGsMBmr+pEkbBXoRILqSdjpj9NNv4Dpbd
         V81j61UJNFiiyAWz+accIeHxepfWCnZAotIjwQWjaWvjlYVYVpuVb8O7Qn2RYtqshZkH
         UCm+TxJD4yMquXGuTUqRiLWslhCBlnpunAy+q2Gv46YCjzRel2aBQg+Yf+UBXdMqKPcU
         E0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744649628; x=1745254428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NQeonf3Poj7gKWn1Uv38diKo2J8RE//SkdLEunnzwc=;
        b=mMXnUHNhC0EX1XOEbfi5xhJ7jysTAUnRrRrxhvqcUitbUD3k5IVghcyPrUYMYuO5ti
         1KHzsKeMkjJ25JjNZ+0tcuReT9gHRLJ+hEjDYqw7+I8SMW8TW7NiNcW48fZsS4CEUNz2
         S8Cg0z9huYxt3qKLTVw6LUPQYGlc/w5TpywMDQie1t9Q7tzw+5bd5hkVLY679M1ooWxx
         V9pCiZK3EMzbaAYo78BFjwLDNFlLlSrhqEokXL2hT9Dop6HfZz0OAQJcGukuWXTXQVh1
         V5vCghJoFTjeG+1DU0WYTKfnR7lWoQsKuXV9GlnOYlE/WuzS6wbKWhT8ROxZIaOTVHU3
         pDbw==
X-Forwarded-Encrypted: i=1; AJvYcCURzhCWaz/8UHEbcQXwPTuZOSL9APtmloiRV8LAxQ9BjU/VGGiKyKJJgzw0+SQVQVkHsm5a45PLkgLjR4s=@vger.kernel.org, AJvYcCXRESHzrZ9FR8U8JAwJ8rc6M5EHZFEzuITulQcRobEkhFJDXFKPVdywMPezN/VQAuBO8R2n6Yab@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj1n7lpln3nqe/RVFb+xJzdoUdkt9bB9DWcXWtzu3HcuyP7W0N
	7tOq+2yWfMzOSxiLgf2BKlNQabeMxONUCoaYbnWl3EFKrUM0E7jO
X-Gm-Gg: ASbGncv6cdmdMhwO/jpOdGWYSWfwKbJUt/8TDz5055Mta2pnzsuW7/e6ShIolBuekrx
	Mshaxe/9yOWMfSjx5Tkmc8RqOYyQEE3s7NlWBnlJyApc5nOfZ/mYQlX23bnhkq9RGsW8QFH4+cN
	d1XZ+4exfTF7fbiycZXEZMj6ZRA5tbpdqGqt1LCOFjnSn4HlDr9ZwXOJ5XpS16fzgA6W0FEO2+F
	0cJIVlO0UwbtNKsygjLeTVCjvR+HfdKcOYfD5/iF1s0ghqOFGQNfqHBOmpIB8TuvVjGIQCH7035
	QpnmBP3iwehnpmhCcL/MhW5gPKcep7OXL+SogjNOVnqq
X-Google-Smtp-Source: AGHT+IH9LG98NCrhGJg5hJ1T70mWIlfskBF5uyLHOygxqKCGg8AMyzO3uK9iimBt6WXIYf6tP0aCmw==
X-Received: by 2002:a17:90b:3e84:b0:2ff:6608:78e2 with SMTP id 98e67ed59e1d1-30823644ffdmr21506407a91.16.1744649627796;
        Mon, 14 Apr 2025 09:53:47 -0700 (PDT)
Received: from nsys ([49.37.219.136])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df08233fsm11375765a91.19.2025.04.14.09.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:53:47 -0700 (PDT)
Date: Mon, 14 Apr 2025 22:23:40 +0530
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, netdev@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Potnuri Bharat Teja <bharat@chelsio.com>, Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>, 
	Vishal Kulkarni <vishal@chelsio.com>
Subject: Re: [PATCH net-next] cxgb4: fix memory leak in
 cxgb4_init_ethtool_filters() error path
Message-ID: <wgtpdbcqc7dosv3dtu5lmdsdompy5dkjeckjm3rhlmvsah37l2@ylqjssgcrtno>
References: <20250409054323.48557-1-abdun.nihaal@gmail.com>
 <5cb34dde-fb40-4654-806f-50e0c2ee3579@web.de>
 <20250411145734.GH395307@horms.kernel.org>
 <o4o32xf7oejvzyd3cb7sr4whvganh2uds3rvkxzcaqyhllaaum@iovzdahpu3ha>
 <20250414145618.GT395307@horms.kernel.org>
 <20250414145932.GA1508032@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414145932.GA1508032@horms.kernel.org>

On Mon, Apr 14, 2025 at 03:59:32PM +0100, Simon Horman wrote:
> As the patch was marked as changes requested, presumably due to earlier
> discussion in this thread, could you please post a v2. You can include my
> tag above. And note under the scissors ("---") that adding the tag was the
> only change between v1 and v2.

Thanks Simon, I'll post a v2.

Regards,
Nihaal

