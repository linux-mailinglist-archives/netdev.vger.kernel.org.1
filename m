Return-Path: <netdev+bounces-159187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DE8A14AFD
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 09:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 547D8163E90
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 08:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D911F76D5;
	Fri, 17 Jan 2025 08:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="pkKjoPdr"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18C61F7577
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737101863; cv=none; b=orlOshKpTJ93Fb0dqO4oZD3TBBwONn0FhRPlQ5laSSr5pmLm+OlQ/5HNozcBvtK0/Ijh4I+H7WQJAAtt30ro0nejpt/VDJIf8q+zcTbz34Jqwvoc/D5xSieXo07aI2Fd/xB9cFGn0xmfoXT/+ly3Zn6jxAODdM7XQVBz2v5lzzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737101863; c=relaxed/simple;
	bh=sWJ/i70D26N65vc3m73IcxnA2Jj/KIecFnN7LFDcA4k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmB8dLoISpqpGO6bYbNFEQhZ/8a+mRwXJWEMpkL7FvkZ4gfPbIWy3DMXaZjFN7mDNlHRpVOCQdS6/jeptcaKDP+zmreZU32ZSY0LPtGi4KISLfaeIE7abKgE1Wk4nTONfheTtg+lXLc3y7PPLFBusE6eFexSuAjMNAC6TVb9gSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=pkKjoPdr; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id CC2432082E;
	Fri, 17 Jan 2025 09:17:39 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mFX9332V3SAq; Fri, 17 Jan 2025 09:17:39 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 5701A20520;
	Fri, 17 Jan 2025 09:17:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 5701A20520
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1737101859;
	bh=hxHBIjNmAZgPp0m0U32GkAKttGdABrRrKQgFKUpmF8M=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=pkKjoPdrcQE+6wyDCIEIHvEPVOuLqzI7iWIDeAgVKhJBC2fzBzJzx/Z+4v0JWVr94
	 kJBqoKjXLYJ+S7a8YyCIefWHGdjw4W3u9fyiDExYxYI1H40mV6lUsNiSzHLY5qj0Hg
	 MT+OXD7ZCMhatHJs+rvo2LqFiaEAGfplFRP3GJzAN8WAcRWXddjWoDarxg2GNgf9zB
	 MpDYtY/eYtbC+wyiGRc0xuXTfgGMOLPHYQqn0cWdNC7NT+rFksih7JWjhxYYFNjD8x
	 t60sLKY8/7xRSYuW9tQx8ynw0H+6AmtIzBrHjCbd9ZrEY8yhVEOehg4mqpMfymcSZ0
	 p2S23N+8c0Hsw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 Jan 2025 09:17:39 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 09:17:38 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 952DD3183DFF; Fri, 17 Jan 2025 09:17:38 +0100 (CET)
Date: Fri, 17 Jan 2025 09:17:38 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sebastian Sewior <bigeasy@linutronix.de>
CC: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Network Development
	<netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: xfrm in RT
Message-ID: <Z4oSIkXb8e3GJSaC@gauss3.secunet.de>
References: <CAADnVQKkCLaj=roayH=Mjiiqz_svdf1tsC3OE4EC0E=mAD+L1A@mail.gmail.com>
 <Z2KImhGE2TfpgG4E@gauss3.secunet.de>
 <20241218154426.E4hsgTfF@linutronix.de>
 <20241218160745.G1WJ-lWR@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241218160745.G1WJ-lWR@linutronix.de>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Dec 18, 2024 at 05:07:45PM +0100, Sebastian Sewior wrote:
> On 2024-12-18 16:44:27 [+0100], To Steffen Klassert wrote:
> > time (your current get_cpu() -> put_cpu() span) you could do something
> > like
> 
> While at, may I promote rcuref? This would get rid of your cmpxchg()
> loop that you have otherwise in refcount_inc_not_zero(). In case you
> have performance test:

I have currently no test setup running that could show a performance
difference, but anyway the change looks OK to me.

