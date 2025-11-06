Return-Path: <netdev+bounces-236097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B355BC3877B
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 01:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 063EC3AEAD4
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 00:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EE85464F;
	Thu,  6 Nov 2025 00:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKi1X5tb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA7AE571;
	Thu,  6 Nov 2025 00:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762388673; cv=none; b=LRRxlI15tZ2GQjL0n6eDWEx1ZHIysY8ai9ipPHIsogH9Vj4fP29TAeDShaoRJzrBUKJ5Wtw1cXFTTzpxGuku23R+Cnh21CgQUCzrc/6z9WdkMOOGG3tZ+koRIRV3m0R/PQjtnEIZw2oyHf/NYxUoCIANdrpqCUnS+nddhrn+x44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762388673; c=relaxed/simple;
	bh=cyoWoWBVCUlnvIKaD2wnyG3BjdQVmpDpVXxUsc24x7o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjLFBaRd0qgIn9kyJxgU87QUWw6UvF7KGL+Hp0k0Qw3xJ/ytfdLav2YEftzO3DyYRcyh+WCxT2lTdKGnGfWit/dDkrU3LvQ0KArSYC1pgaSfFNRrhX2rCaSfB/DhMoxZ+IMKnbuDoibGdj3Wey84PiFj1HN1ro2jPgGGuFTi3Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKi1X5tb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D41C4CEF8;
	Thu,  6 Nov 2025 00:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762388671;
	bh=cyoWoWBVCUlnvIKaD2wnyG3BjdQVmpDpVXxUsc24x7o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GKi1X5tbxCEitNKwd6eWSQZ5S8zSKsVgxy8lbvQUgxzXq+YFCY6wucgtNAIJYJ36n
	 39ZLyikSr7UYQOJu0sJGaYaX2sqDBaoZYOuLERL7JCrh5cUzqkA3j4vwqxsfBjPfUd
	 5z6IYCr0PAs2pEN6YYP3SCCGJpM80+SjD0DU6+DNH3CtsfmLjtLV/XY0WPv64t9BCJ
	 PyY7GN54gyjuGja3n06/Zc7LraGIpJ7fdYdPxknTxPKPbRJTkdzNi0l/JiLFUs/Zzl
	 nRXEGBH8XL9Q1kD4uZ6pRsXAlUKCCApFGWfJmAOXlRU0UXEHjc0mtS5ynFz8Z+3CxV
	 On90OxzbhbuSQ==
Date: Wed, 5 Nov 2025 16:24:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
 dust.li@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/2] ptp: introduce Alibaba CIPU PHC driver
Message-ID: <20251105162429.37127978@kernel.org>
In-Reply-To: <8a74f801-1de5-4a1d-adc7-66a91221485d@linux.alibaba.com>
References: <20251030121314.56729-1-guwen@linux.alibaba.com>
	<20251030121314.56729-2-guwen@linux.alibaba.com>
	<20251031165820.70353b68@kernel.org>
	<8a74f801-1de5-4a1d-adc7-66a91221485d@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Nov 2025 18:22:19 +0800 Wen Gu wrote:
> On 2025/11/1 07:58, Jakub Kicinski wrote:
> > On Thu, 30 Oct 2025 20:13:13 +0800 Wen Gu wrote:  
> >> This adds a driver for Alibaba CIPU PTP clock. The CIPU, an underlying
> >> infrastructure of Alibaba Cloud, synchronizes time with atomic clocks
> >> via the network and provides microsecond or sub-microsecond precision
> >> timestamps for VMs and bare metals on cloud.
> >>
> >> User space processes, such as chrony, running in VMs or on bare metals
> >> can get the high precision time through the PTP device exposed by this
> >> driver.  
> > 
> > As mentioned on previous revisions this is a pure clock device which has
> > nothing to do with networking and PTP.  
> 
> I don't quite agree that this has nothing to do with PTP.
> 
> What is the difference between this CIPU PTP driver and other PTP drivers
> under drivers/ptp? such as ptp_s390, ptp_vmw, ptp_pch, and others. Most of
> these PTP drivers do not directly involve IEEE 1588 or networking as well.

We can't delete existing drivers. It used to be far less annoying
until every cloud vendor under the sun decided to hack up their own
implementation of something as simple as the clock.

> > There should be a separate class
> > for "hypervisor clocks", if not a common driver.  
> 
> 'hypervisor clock' is not very accurate. CIPU PTP can be used in VM and
> bare metal scenarios, and bare metals do not need hypervisors.

I know.

