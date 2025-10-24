Return-Path: <netdev+bounces-232725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87613C084A5
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 01:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7195B1B21522
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 23:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FB330ACE1;
	Fri, 24 Oct 2025 23:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxZSvoWr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F852F5A22;
	Fri, 24 Oct 2025 23:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761348236; cv=none; b=pETpt17OQcAMUv4//0MLCJNvF4qg8ad0Q07SAmuEHqISaQJtddZbsjVIBi8/GnBnxmmDLFN9GzFbwQDkp4hRq1Ooqwc80IP6Q3uIWlRNZzXrCXBaKZ3uh4WNrnEvCTedXrCQuMl58gvdth8k4fmLDKieIm6oylVaM06opivd9aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761348236; c=relaxed/simple;
	bh=mJgi27QQ6jGkOZoP1D1icVgDHg4Ho/QiWSgxFXIv1B0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XPGmJq+a4x/5vTO6xF493bkzyxgSSMA2V99Pc0IKlpoHD+5f4laR00kGlcL6mgPg67OsC079dh3P09Z/3b0RBL4IYHT5ewVvKlLngznpSE08DhWNMPiXMQ7RVI5HPdfBdan24V/SZgW418amk9WJxclj1Z4vK+mC+OL8asszVbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxZSvoWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73B2C4CEF1;
	Fri, 24 Oct 2025 23:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761348236;
	bh=mJgi27QQ6jGkOZoP1D1icVgDHg4Ho/QiWSgxFXIv1B0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LxZSvoWrqcwzut50YnkRw0qWjGhutOdT/UHS9cPqzvJVr/ZyR+ROyLxrGi5WyfRa8
	 NeuBP4mBmHHQfkg87gcCKS/Wiq26DJKcQu/7RfZcZdrJTiiCxra5jrwiQG2RVX9Fxw
	 ZPPpYnyNKqjXbBqedpTgvZbTu9dtHEXBwMcWxPpl2cYSz9DGnzDCJSLvxUFU6N5meM
	 ea7jfYKxRmsJeuWy6+fXZAGSFpj+oVqPnSZKWRuwvSH2p4gxW5bshCNPhTUqUTBCpj
	 AgX0eSPsvK4KA4iRL+oUrzoQ1C1LuxGI/PRcNNt51V20pGx2elEQ4MJGEprzmniB33
	 1noSlhN5JcGAQ==
Date: Fri, 24 Oct 2025 16:23:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: inet_sock.h: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
Message-ID: <20251024162354.0a94e4b1@kernel.org>
In-Reply-To: <949f472c-baca-4c2f-af23-7ba76fff1ddc@embeddedor.com>
References: <aPdx4iPK4-KIhjFq@kspp>
	<20251023172518.3f370477@kernel.org>
	<949f472c-baca-4c2f-af23-7ba76fff1ddc@embeddedor.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Oct 2025 12:24:09 +0100 Gustavo A. R. Silva wrote:
> On 10/24/25 01:25, Jakub Kicinski wrote:
> > On Tue, 21 Oct 2025 12:43:30 +0100 Gustavo A. R. Silva wrote:  
> >>   struct ip_options_data {
> >> -	struct ip_options_rcu	opt;
> >> -	char			data[40];
> >> +	TRAILING_OVERLAP(struct ip_options_rcu, opt, opt.__data,
> >> +			 char			data[40];
> >> +	);
> >>   };  
> > 
> > Is there a way to reserve space for flexible length array on the stack
> > without resorting to any magic macros? This struct has total of 5 users.  
> 
> Not that I know of. That's the reason why we had to implement macros like
> TRAILING_OVERLAP(), DEFINE_FLEX(), DEFINE_RAW_FLEX().
> 
> Regarding these three macros, the simplest and least intrusive one to use is
> actually TRAILING_OVERLAP(), when the flex-array member is not annotated with
> the counted_by attribute (otherwise, DEFINE_FLEX() would be preferred).
> 
> Of course, the most straightforward alternative is to use fixed-size arrays
> if flex arrays are not actually needed.

Honestly, I'm tired of the endless, nasty macros for no clear benefit.
This patch is not happening.

