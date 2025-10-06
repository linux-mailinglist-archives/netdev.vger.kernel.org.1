Return-Path: <netdev+bounces-227986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFB8BBEA19
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 18:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C69F4F019A
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 16:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DAB2DBF7C;
	Mon,  6 Oct 2025 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R8ZDGmNn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654B12DF6F6
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759767731; cv=none; b=WtycUMaOOQgPnEvmTa+ETgPCvslx9XioQAa5m4EfCIepj0DWugCqpbEIXugs4XgU+GbIUXTaQ3kWTClvvi4Ihb73EJMIriRv4XL7bAUsUpedMbMCxpN8rTSXyAlX8BFUEK+s/uzIlO6QWBa8RTDVU1ker59/z/Dr6WREJ8HZz9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759767731; c=relaxed/simple;
	bh=1wF4anmXmSDTGcRxx7vjv8LeYiQZk0/9h7MUqtNAHIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgsIsUV10g563pXTiDHvE5ho4/Jm3d9F5Z2xm0UrffjcP5t9KjR4+o4EvYfxf9fL/bGDob1RY1//Ujv5ZoQJuXmQ40M6FecAXfZlfbB8pfQeV60r7qjnKpTU1KcQEZ4WouTjICVvvzZLIRQURQgNyjPcJXi1rWqTncE+w0CCxzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=R8ZDGmNn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=mlq2c0HBdvO351Ompx+ApyBG17JwI3IgCYdls8YTnXA=; b=R8
	ZDGmNntFIkfGpw0/Ol9VW49vNHOqwOvGBjv3wRP/2jdvFie7h2EVvi8Y0/lVpIMQgfnGKeptiPwyc
	/ScAEz43KcNfg09utaDl8y0AoDJyMoahPlKYInApvarOLTcAAVY2pmfVZvzVuWQvlimzGL+mCbuIJ
	7F8JPP86ef8aAHA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v5ny9-00AJ9Z-9p; Mon, 06 Oct 2025 18:21:49 +0200
Date: Mon, 6 Oct 2025 18:21:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Jakub Kicinski <kuba@kernel.org>, jgg@ziepe.ca,
	Michael Chan <michael.chan@broadcom.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Gospodarek <gospo@broadcom.com>,
	Linux Netdev List <netdev@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net-next v4 0/5] bnxt_fwctl: fwctl for Broadcom Netxtreme
 devices
Message-ID: <ab203d1c-7a56-4d44-813d-e4a884bf4e43@lunn.ch>
References: <20250927093930.552191-1-pavan.chebbi@broadcom.com>
 <CALs4sv0T=AL354Mj2UCQGwaqWAznjDoaPQX=7zLsXz9=WxAiGQ@mail.gmail.com>
 <20250929114611.4dc6f2c2@kernel.org>
 <CALs4sv2tRYnDV5vOWum9+JQSr61i-ng1Gaok17bi+JSP-uLSNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs4sv2tRYnDV5vOWum9+JQSr61i-ng1Gaok17bi+JSP-uLSNg@mail.gmail.com>

On Tue, Sep 30, 2025 at 05:55:38AM +0530, Pavan Chebbi wrote:
> 
> 
> On Tue, 30 Sept, 2025, 12:16 am Jakub Kicinski, <kuba@kernel.org> wrote:
> 
>     On Sun, 28 Sep 2025 12:05:36 +0530 Pavan Chebbi wrote:
>     > Dear maintainers, my not-yet-reviewed v4 series is moved to 'Changes
>     Requested'.
>     > I am not sure if I missed anything. Can you pls help me know!
> 
>     There is
> 
>     drivers/fwctl/bnxt/main.c:303:14-21: WARNING opportunity for memdup_user
> 
> 
> Shouldn't it be treated more as a suggestion than a real warning? Are you
> insisting that I should change to use it? 

There is some danger of "Cannot see the forest for the trees". If you
ignore this warning, are you going to miss other warnings which should
be addressed because you have got used to just ignoring warnings? It
is much better if your code is totally free of warnings.

	Andrew

