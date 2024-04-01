Return-Path: <netdev+bounces-83763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60303893C35
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 16:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1835B20C37
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 14:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F71E405CF;
	Mon,  1 Apr 2024 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZJ9hCKR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6CCF9DF
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711981632; cv=none; b=rsHhPVwx8Gpr2WA+D8IHlUHYaLoeIYv9eCZWjtpASMgJnM7GEu13SZwK2gxRq8juJSNB8m1Wic1CzeMnq0nJJyHv9qmnJIte0TzL/PBQ7rdSvJypwhIF/0iC9Lxfn9TlO5iQcB8CGEDDiDtJZcGHGp153wK8euO00QEseSkOlao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711981632; c=relaxed/simple;
	bh=AZ6BgRdKE7tIBDPvfNp4cK821iYghvM7N4QxOERC6Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMvQ++Jj+jweJhUIST2jmAR4CU7G5XcPmrRvJcWgb7QQVwkSc9qv3eVKNl4YcSLME75vR9HP6Gn8Z3jFNKC1VgYS8/3FQqytHzlXDa0qi9IduTBg7gakzZMV6W25QtwG9107DqrweJGg1IKRs1cNpMCjS9zRtob2Ubs923dnDgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZJ9hCKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED27EC433F1;
	Mon,  1 Apr 2024 14:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711981631;
	bh=AZ6BgRdKE7tIBDPvfNp4cK821iYghvM7N4QxOERC6Gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GZJ9hCKRX/Y3+61r9c1gz46FCVAijEcB2TOZRWn5XTscpjfApMmxcng+6E5spG8du
	 Zb7Ki3WMEcsZirvCz3F/SeOFmXGKtFYvzcnxadKRg5ctX6XaFUbRJsunEWT2w2N/AP
	 ypT/xyGS/IaFNXpzb/bHHoYgBIgoL8zaxDopluz/AUHKgU7K4InTGXaMzdqFrIxuQW
	 KmaGIJRgCT3n6FnbhrxJSM/tPVBTKPmS0T42bNCeMz/kJr5uhWOX8T7s/2zbmYU2ss
	 8i/HIihtdxNYK9URWstI1l9M6E2/nm8kdnoa/4dbPf3hSouwgBn0NTkJdZ74uncCr0
	 E5t/GH4SDMm0Q==
Date: Mon, 1 Apr 2024 17:27:07 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Feng Wang <wangfe@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net
Subject: Re: [PATCH] [PATCH ipsec] xfrm: Store ipsec interface index
Message-ID: <20240401142707.GD73174@unreal>
References: <20240318231328.2086239-1-wangfe@google.com>
 <20240319084235.GA12080@unreal>
 <CADsK2K_65Wytnr5y+5Biw=ebtb-+hO=K7hxhSNJd6X+q9nAieg@mail.gmail.com>
 <ZfpnCIv+8eYd7CpO@gauss3.secunet.de>
 <CADsK2K-WFG2+2NQ08xBq89ty-G-xcoV517Eq5D7kNePcT4z0MQ@mail.gmail.com>
 <20240321093248.GC14887@unreal>
 <CADsK2K8=B=Yv4i6rzNdbuc-C6yc-pw6RSuRvKbsL2qYjsO9seg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADsK2K8=B=Yv4i6rzNdbuc-C6yc-pw6RSuRvKbsL2qYjsO9seg@mail.gmail.com>

On Fri, Mar 22, 2024 at 12:14:44PM -0700, Feng Wang wrote:
> Hi Leon and Steffen,
> 
> Thanks for providing me with the information. I went through the offload
> driver code but I didn't find any solution for my case.  Is there any
> existing solution available?  For example, there are 2 IPSec sessions with
> the same xfrm_selector results, when trying to encrypt the packet, how to
> find out which session this packet belongs to?

HW catches packets based on match criteria of source and destination. If
source, destination and other match criteria are the same for different
sessions, then from HW perspective, it is the same session.

Thanks

