Return-Path: <netdev+bounces-113048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F1D93C7B2
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 19:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2921C219A1
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 17:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2A819D88A;
	Thu, 25 Jul 2024 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="QWkfPmqK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6CA198E6D
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721928983; cv=none; b=KkGx4Kj/7voxdBBj46I1Rhupxo+/y2M5UXRLdW/OIs1vSfWvPUYIHRib/sv0hC99pKBgleaDnEBXWCr5XCrKAMPt3TDu7R9u61bDaoAXFyajDvi1TeVtQgmn7VbnzCe3btbGPbCBmG4v8b3LTQ3/2L50w7BmE6cUhOsamR++RIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721928983; c=relaxed/simple;
	bh=9VX7sV4Sak0j2PjeKw/Uhu1mo5Pb8zqSL48R5CiE4pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/L3BfiAcfkHQo0SNGqcPOf4fHU86aw0kO9hiOvu8r3cBfzhPcuKgAsUrsvK9AR6Bdh344q4vQ22SzE3CNNRP8AgTbCLfpV7KX+rDvd+7P+LwRjij5EB5KjZEjPj2vPsP9O7ufzv4ltYTLdFMOs4oESeN9t8Z5mIkxymThyKJT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=QWkfPmqK; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cb5787b4a5so75546a91.2
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 10:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1721928981; x=1722533781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyXn0hfsHWdk2uakwg5TbDGl3rOxYo7Eh2tEoMeKiyI=;
        b=QWkfPmqK3EmuGs2/edjkVEDNUEgcXwHkArH38Kc8Y9fzEzBapi69mqNwtw0CtNCTrd
         fAlEI46DWR/D10CjlBDdNFv2QpX/KzZEHEk2meSTtpbRSpkAXIXak3F+auDb/Rawa/Ol
         LAF4IusmhZcYQKGDLsGv/rSwgOlggeCH2DJgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721928981; x=1722533781;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tyXn0hfsHWdk2uakwg5TbDGl3rOxYo7Eh2tEoMeKiyI=;
        b=A9DJxd7mgVmatg3pAi1k9vCQx3LsaDr512rjLFIHb/Z/DOujUjMKsTjpbgsUKUy/2Z
         hwmNLKhPhdFWK9I63Hl1WWzLMLQfCUvNRmSBM68mAq/Fny/MofmZnns2PludzQQNUFO9
         Tthdj8KwiKCPL4Jib2VWfvqzEvrYr2i9EmIppkpkSjUzUgbhaHyL0BuVwZltv4n/kiDJ
         bpOf2o0Kkdf6P3sejeWz449bsJ7I7kEXuVad3H2fNYatcLlF3hL1alL1+tNXSpJHiGvX
         lLzKWylFf6JdNiSiYIUuFArAiief3Ab/F4Db0smxVKVaUe1DQWdC0CgJf4gh9vGnMXnO
         ZZtA==
X-Forwarded-Encrypted: i=1; AJvYcCWB3rMuCa+FjhXwQGtr8IFW/I6jaLVa7P31116v2BowRdprlJPk+Ds6y38F4/lxDLZH5rPEIcl2yZcY5AFdl/ueHkWjfcNX
X-Gm-Message-State: AOJu0YwVFf7mLrDNsu7VwI/roMvrUvdClKhRTrBSZMdF1UQIsOm+MTsb
	DnoZ4hXBolP112iYHptldQ7V70VxUWSKG9CMqT9c49U4caA9krUkXIML7ygf/ZA=
X-Google-Smtp-Source: AGHT+IEP51Aqmfe3Bfzk8kmOA0IGeiTTP8O2AzNB3+NvDFoY42bUarDmeH/y6F2jG7NSxXJoREarQA==
X-Received: by 2002:a17:90b:3146:b0:2cb:5de9:842c with SMTP id 98e67ed59e1d1-2cf23813344mr4419892a91.25.1721928981433;
        Thu, 25 Jul 2024 10:36:21 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb75fff4esm3860041a91.51.2024.07.25.10.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 10:36:21 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:36:18 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net 0/2] ethtool: rss: small fixes to spec and GET
Message-ID: <ZqKNElpqYOVfBHWq@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com
References: <20240724234249.2621109-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724234249.2621109-1-kuba@kernel.org>

On Wed, Jul 24, 2024 at 04:42:47PM -0700, Jakub Kicinski wrote:
> Two small fixes to the ethtool RSS_GET over Netlink.
> Spec is a bit inaccurate and responses miss an identifier.
> 
> Jakub Kicinski (2):
>   netlink: specs: correct the spec of ethtool
>   ethtool: rss: echo the context number back
> 
>  Documentation/netlink/specs/ethtool.yaml     | 2 +-
>  Documentation/networking/ethtool-netlink.rst | 1 +
>  net/ethtool/rss.c                            | 8 +++++++-
>  3 files changed, 9 insertions(+), 2 deletions(-)

Thanks for fixing this.

Reviewed-by: Joe Damato <jdamato@fastly.com>

