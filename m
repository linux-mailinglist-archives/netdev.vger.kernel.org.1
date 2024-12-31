Return-Path: <netdev+bounces-154629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0BA9FEF17
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 12:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9CB161F98
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 11:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6823318A6D2;
	Tue, 31 Dec 2024 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uB+jrwLc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437382AEE9
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735644858; cv=none; b=EZGamiRLNTpwt0DRUvrDi6jFchq4hx4FMlh1C3YlNXGWNC2Xd+6Xet1O5G4n+j7yJo80kKD4XFzbp58Pxbyfqleo7jQqWI5OXTRfL83Uu5A8BuVMx2dmyX9QoL9BenvoaTAnj0RYqGQxaV1oBx75CuXWcuqdZ2CAWGaGU3X6zpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735644858; c=relaxed/simple;
	bh=qPly/i0jWvWheqr5XMLw0ftPVk0TNrBFOM2j13Pmf9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPiQAVSJBN5FEt+9YHvJAcOdSrmbMWUUvxlScQSwTMTGh971XXqlnASNSkxAplCQbxFEX/XGEB+nmKezMNEkT2IEjkmKwt7Ow06LIsEOywvYCyq6Z6RvNTlQlXWl8cbJdDP+jouwm8HnyuvM/OfvN0AGpMRlGrz5ITYO6g4frqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uB+jrwLc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088F6C4CED2;
	Tue, 31 Dec 2024 11:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735644857;
	bh=qPly/i0jWvWheqr5XMLw0ftPVk0TNrBFOM2j13Pmf9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uB+jrwLc/STdx12WsStrVHHImYoYnLajy2tTvmUnkJqWpuzpM8+0zparRmqV/BUOL
	 PNrl5STi0UN7jQ+zhk7NJyBRuCzw68oqtqZFA62swXM/PVd6FP23p5yUrpx0UwEe86
	 Ga7ZPtlkK+ZkZJVHe4JEWuW2rRHtLTS3tysV78TIsQcxa872YkCL9KKr//1JZ+c110
	 SgeaisKvDNsfdY8wx94z8U5mucEKztHHGZedfbaQYShIPvytKPXiOD2V/1VuwneENf
	 ZC5zTECalKO/gIiAlOqBeIHPrzYpFUJUSblNSf2AalTEw6raeUKtyac/xf1mrzu0/E
	 TrbWB+qlm5hCA==
Date: Tue, 31 Dec 2024 13:34:12 +0200
From: Leon Romanovsky <leon@kernel.org>
To: tianx <tianx@yunsilicon.com>
Cc: Andrew Lunn <andrew@lunn.ch>, weihonggang <weihg@yunsilicon.com>,
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
	jeff.johnson@oss.qualcomm.com, przemyslaw.kitszel@intel.com,
	wanry@yunsilicon.com
Subject: Re: [PATCH v2 08/14] net-next/yunsilicon: Add ethernet interface
Message-ID: <20241231113412.GC81460@unreal>
References: <20241230101513.3836531-1-tianx@yunsilicon.com>
 <20241230101528.3836531-9-tianx@yunsilicon.com>
 <9409fd96-6266-4d8a-b8e9-cc274777cd2c@lunn.ch>
 <98a2deaf-5403-4f85-a353-00bfe12f5b13@yunsilicon.com>
 <45dfc294-76d8-4482-b857-4e3093ac829d@lunn.ch>
 <a09b9cda-5961-452b-84cb-844262e5b71a@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a09b9cda-5961-452b-84cb-844262e5b71a@yunsilicon.com>

On Tue, Dec 31, 2024 at 05:40:15PM +0800, tianx wrote:
> On 2024/12/31 13:12, Andrew Lunn wrote:
> > On Tue, Dec 31, 2024 at 12:13:23AM +0800, weihonggang wrote:
> >> Andrew, In another module(xsc_pci), we check xdev_netdev is NULL or not
> >> to see whether network module(xsc_eth) is loaded. we do not care about
> >> the real type,and we do not want to include the related header files in
> >> other modules. so we use the void type.
> > Please don't top post.
> >
> > If all you care about is if the module is loaded, turn it into a bool,
> > and set it true.
> >
> > 	Andrew
> 
>   Hi, Andrew
> 
> Not only the PCI module, but our later RDMA module also needs the netdev 
> structure in xsc_core_device to access network information. To simplify 
> the review, we haven't submitted the RDMA module, but keeping the netdev 
> helps avoid repeated changes when submitting later.

Don't worry about RDMA at this point, your driver structure doesn't fit
current multi-subsystem design.

You will need to completely rewrite your "net-next/yunsilicon: Device and
interface management" patch anyway when you will send us RDMA part.

Please use auxiliary bus infrastructure to split your driver to separate
it separate modules, instead of reinventing it.

Thanks

> 
> Best regards,
> 
> Xin
> 

