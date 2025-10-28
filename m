Return-Path: <netdev+bounces-233594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EE1C160FF
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 18:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3ADD4E3E1C
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 17:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5267348473;
	Tue, 28 Oct 2025 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeRHG5qE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087E334678A
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671428; cv=none; b=KsYcxAj0XqWedB2v+MBG4vNfb6EwT/Zbq6DpqFJfmTUEoM4BnCabW0w9DR8/ZB2k+xlRJTfaaSW33X4A0pXVXN5lp3hcBSQyQA/IBsXZMzMrCLn++JeZ724Io8UblIMmvjUrV15wTmU46azC3F1QoZ9wCsXF+s87YCbUHD48xHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671428; c=relaxed/simple;
	bh=m3I9dtve6TdfQpeD/5c1k/FwNdSdObvUw7hMoEvNVYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=In6y0fKyQV+k3dcQVPu8fd6fBMpBY3l26LRWndhcBjkyEM4vTYR4sCOafIcLjb0UDjyIFbHTsm0ekKo05Exq9UR3CrAztu5SOYwa5EJTeZeRBXvqRXmCs/ON0Lnyl4DDLo6XjczfEulQxzzO3VvkJMpgFyQDGiIBc6MKDOXsAZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeRHG5qE; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-290ac2ef203so59724425ad.1
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 10:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761671426; x=1762276226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NkkeBtodNmN2EMa9qJLybudRjmngQqkOpn4I47bN1Os=;
        b=HeRHG5qEN5uTjjY3ibkWq33IiamipujAhi60b9r1rM5RRPJZix2+MocaWLMsgNdzzn
         rCRaFyrKnHeUaypQDn1k3K/dqscVruRVqMTp+igbGbC+db5aiAfFYeE0f5PSLqzGly0B
         Ovbu07ITP9IM/2fwN+YgCr6l72LfCsLXcf98t50rQ2aT51I9i9QHnWZBcPUJfgmI0dRC
         hcDVe7L3na0X+uTihwIrNh/OF7NNAdsSDaUs/thpRtSEuaO3pAwmuCxPhAYF4SvzmzBq
         +g5mLWYTq+KRd+hIVppWWv9JlGPQ/3UNy/vJ92ZwMl4d1BKAHGUXeTSQGuqNK8db6i73
         GIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761671426; x=1762276226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkkeBtodNmN2EMa9qJLybudRjmngQqkOpn4I47bN1Os=;
        b=Toxa0O1tOpwxnRxNYLtGnK+fhFVOVHSnNyzKf+2jYh8cbEOlUmHimsB1Rx/TgJZs18
         3cithMKTI4rPf63Av3SmGss3focFslzgu8N0Ajc21JHR1Fb6qAMJXOqKm0w0aii5xdYG
         fExkThAwHA2GGz8mRIDGXxNN8RMMuW+FIHtcwpmBHLfAoNx3ChnyYWo/Z+QtuxL9ohiH
         2jVydk9UYhfywRLolYfRFGf3n20t7Rcx2TO6iWbpjG407iJlsPUziqusr9V0rgwnsfy4
         9I8vwOv9uGYNDpyFs0sokc0o1oFbOmUJdbb2SvBvc4R41ChZLeR0TVssC1l2xDHQVs0/
         TlOw==
X-Forwarded-Encrypted: i=1; AJvYcCUSrLYZnmbb3yeZhzrkpF3/zULTSNbqo8bMFem+XJ10vhbhMYcSNRrfNSk7RCmcVAM5Bpevh6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9FcfRRvUpQsOSnl/2WFcrm3kCHfQYqbeQpxFY4BI/os/BqloR
	ttlCfMmoRfP2qwDdw8X0B+TfA96abe64K4kRvq2V3nmXD3fdqaKPnKgR
X-Gm-Gg: ASbGncvwn543RdQzhutZwLTXnyIiqVYA7YnjT2YgfkeNGMneQIEhMDTXcmhyRGaWWdF
	in9r19q0WFcsXrdbiYOELvbKzJ1Dr9WXsS0krGgfpfJf7eJkAyjUri6dl4snZcsKWKxWqVk0bsS
	2frcx3lj8AsWd2u5XJOrezwmu7Mr6xA7hxUm3ErVbiGigKlfQxsS+xvUDngTOofGZ1BqzNkDtVv
	y5x3rOhzkwoaQ7vqMBIeie96fNH1sRcPklPKnEX74g0iT84/mZ7ZnNqcpXYW3CpGn8MW4TaHtMk
	H4r3fNLB8HrE3wL9H7FmdrbFAdbzDcU+x20d8dYAFqUbNoQ7g3IsWdVa6/zy4kjpO/sNhyPRGds
	0f/NONiia23UdapmE7IBhUV0gStM5QKApbAn3PE+Wt/r//hd7SEDKFCfTMOJaZ8i9KCGK9MNN3H
	xtwflmT4otYnewVLdpQZI=
X-Google-Smtp-Source: AGHT+IGQ8ffNexl4HmIkFUmg1fdyuZl4JbBMFVH6xuxPDuvHwL2uHadtShWy1RlMi1Xof4Eda3TnCw==
X-Received: by 2002:a17:902:ec83:b0:27e:ec72:f67 with SMTP id d9443c01a7336-294cb391897mr51139475ad.6.1761671426009;
        Tue, 28 Oct 2025 10:10:26 -0700 (PDT)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3bbcsm121911965ad.15.2025.10.28.10.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:10:25 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:40:14 +0530
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest: net: fix socklen_t type mismatch in
 sctp_collision test
Message-ID: <aQD49ukK0XMUHTUP@fedora>
References: <20251026174649.276515-1-ankitkhushwaha.linux@gmail.com>
 <aQDyGhMehBxVL1Sy@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQDyGhMehBxVL1Sy@horms.kernel.org>

On Tue, Oct 28, 2025 at 04:40:58PM +0000, Simon Horman wrote:
> Hi Ankit,
> 
> Please preserve reverse xmas tree order - longest line to shortest - for
> local variable declarations in Networking code.
> 
> In this case, I think that would be as follows (completely untested).
> 
> 	struct sockaddr_in saddr = {}, daddr = {};
> 	socklen_t len = sizeof(daddr);
> 	struct timeval tv = {25, 0};
> 	char buf[] = "hello";
> 	int sd, ret;
>
Hi Simon,
Thanks for your reply, i will send v2 patch with requested changes.

-- 
Ankit

