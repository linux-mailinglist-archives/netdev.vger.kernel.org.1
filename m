Return-Path: <netdev+bounces-218423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AA1B3C60D
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 02:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602A7A2719B
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 00:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3333E20B22;
	Sat, 30 Aug 2025 00:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZcIlotZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034674A01;
	Sat, 30 Aug 2025 00:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756512950; cv=none; b=h/tP7I/cCJCtgRGNYiDIA8Y9AmNEezPVtkoQROKwewk0NTL7HNoZ5dJthSTzqLg87radfi8Gk1uETKBBWZlnn2drK3bYZiPppIA09n9v8/IyBS1jPXSiBcPduKTa7eTWVubrFKEtk0DgqpDtZKU8/YAMDKG0spnDxHJcJ0MySLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756512950; c=relaxed/simple;
	bh=HNjsx0i8x73tfae/eOHpgGMql3FZ9c4OcgiZIKPT95A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XL0vpzg/jVv6JCW44sE0/OQScF93hYczemnjq2DMRD/5dOSvtjvoxyktj6uJGPHxHAmtRPHMDQ/PePxzwg83GBCFZXElCVy1cfD6sulNTn1rRsh14FIrHuasXlTuSQiM/GFGXGftuwJAMosm5WjG2qPvGFLxUTsMTyTt9DWDk80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZcIlotZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69F4C4CEF0;
	Sat, 30 Aug 2025 00:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756512949;
	bh=HNjsx0i8x73tfae/eOHpgGMql3FZ9c4OcgiZIKPT95A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iZcIlotZnZmYfFdJ1Oc7Aza4lrGYWrNZzw/6UYGujc8KDIerJaO5eBS6aelA9SVTs
	 F1Qd0OE53bMMH8UD7Zo+6xBzYE51rblRUFPngwx7Tx2ttc6T0E6BxmAlywblHOGk5P
	 DFp3ugjyLE3dB6YoEs1jItpKh9Dkop1IZW3FzveZ15VAag0BKj5hsrogEjPZHHH6xF
	 reqOMqsi76TkbVCuJ7JiBbZQhYUDls+OE7hDTaVfoL9FhUC5q6N8P7/Vzd3LZCF/AZ
	 +kNp/ihIF/4CyQ2y2AfRmC18FgtNmpJ6NOePp9MR9ZIfDcrbqflq5ol6hB9696od81
	 4fG97Zov1H3zw==
Date: Fri, 29 Aug 2025 17:15:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>, Richard Cochran
 <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/2] drivers: net: stmmac: handle start time
 set in the past for flexible PPS
Message-ID: <20250829171548.68d7addd@kernel.org>
In-Reply-To: <57196414-5ab5-41b7-b2e3-ff6831589811@foss.st.com>
References: <20250827-relative_flex_pps-v3-0-673e77978ba2@foss.st.com>
	<20250827-relative_flex_pps-v3-1-673e77978ba2@foss.st.com>
	<20250827193105.47aaa17b@kernel.org>
	<57196414-5ab5-41b7-b2e3-ff6831589811@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Aug 2025 12:51:40 +0200 Gatien CHEVALLIER wrote:
> On 8/28/25 04:31, Jakub Kicinski wrote:
> > On Wed, 27 Aug 2025 13:04:58 +0200 Gatien Chevallier wrote:  
> >> +		curr_time = ns_to_timespec64(ns);
> >> +		if (target_ns < ns + PTP_SAFE_TIME_OFFSET_NS) {
> >> +			cfg->start = timespec64_add_safe(cfg->start, curr_time);  
> > 
> > Is there a strong reason to use timespec64_add_safe()?
> > It's not exported to modules:
> > ERROR: modpost: "timespec64_add_safe" [drivers/net/ethernet/stmicro/stmmac/stmmac.ko] undefined!  
> 
> Hello Jakub,
> 
> you're absolutely right. I don't know how I did not encounter the build
> error while performing some tests, that I'm getting now as well.
> 
> The handling of overflows is already done in that function. Either
> I can make a patch to export the symbol or handle the computation in the
> driver. What do you think is best?

The odds of me being right about time related code are only slightly
better than 50/50, and I don't know what "flexible PPS" is :)
But in principle, if the reason you need to check for overflow is valid
-- add the export. The time maintainers will tell us if they don't
want it.

