Return-Path: <netdev+bounces-136833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FE89A32EA
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49902B21778
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F570381C4;
	Fri, 18 Oct 2024 02:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="E5MpfvRy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638172CA5;
	Fri, 18 Oct 2024 02:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218797; cv=none; b=baMn0AcG46tfpGYCNoN0Cql0nqqz/mxIjvyGA87EKMxiDYoOEM4VgBuLL4hLZ/VjDhJXVC6nrRbLOjbXxcUfPSei8hP3X8DQiPfNkH0QbsksxRkljOowk9T9QktkPHWu4FQWQvPKAWp9aYcSZ3gHTuQF7gy+ofTETzEIBzP6KG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218797; c=relaxed/simple;
	bh=U7+lIfcx743bjmHl2HiphHVyK9Nmc5jiCxeFyXuSLMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+t8fr1jUERysnboBwZTs/MU0SUjAgRwurBq3eqTpfpH2jCQ/jeSRQ7tibRBJGd7I0k14GTW4uhpX8MWsDn6JUXQas1+BlvsoE0zrn1Btl2ORHve7/VvctYSVrq6r0HqgvjDgVEAOfkYPP9WIyTdB9Xzr3vZ0jdHF2mXQnRCekM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=E5MpfvRy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FDJn4XXIjtyq1C4WRBOEnHEbGl9tvoFq7BB0FTlNUn4=; b=E5MpfvRyOOAbCVMvQjDs7hrWjD
	B6mlxRZ8DnBTSxKsn/lH+6wCOcSDhKUIjNwent6D9SpdmpbOY8sJp960hsjO1pIshOGLW7eZjM6TE
	uNZIttKZmebHFASK7dFjRgJsfBXy7lSTAUvJdNBW64ydSibRSIBJMIhErJyv1dRmaNpI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t1cnR-00AJ0Z-VP; Fri, 18 Oct 2024 04:32:57 +0200
Date: Fri, 18 Oct 2024 04:32:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Furong Xu <0x1207@gmail.com>
Cc: Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>, Rob Herring <robh@kernel.org>,
	kernel@quicinc.com
Subject: Re: [PATCH v3] net: stmmac: allocate separate page for buffer
Message-ID: <8677a11c-8735-43c7-ae5b-6dc894d94677@lunn.ch>
References: <20241015121009.3903121-1-quic_jsuraj@quicinc.com>
 <20241017194258.000044b3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017194258.000044b3@gmail.com>

On Thu, Oct 17, 2024 at 07:42:58PM +0800, Furong Xu wrote:
> Hi Suraj,
> 
> Thanks for this fix.
> 
> I tested your patch on XGMAC 3.20a, all goes well, except a performance
> drop of ~10%
> Like Jakub Kicinski said in V2, this involves more dma_map() and does add
> overhead :-/
> 
> I might have a better fix for this, I will send to review and CC it to you.

Lets mark this as changed-requested, due to the performance drop

It also introduces one more kdoc warning.


    Andrew

---
pw-bot: cr

