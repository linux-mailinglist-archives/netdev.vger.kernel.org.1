Return-Path: <netdev+bounces-161055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BAFA1D0AC
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 06:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D47F1884F07
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 05:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B340B14D28C;
	Mon, 27 Jan 2025 05:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="OKJ+Q6u/"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6718B25A638
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 05:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737956007; cv=none; b=GjOoJPQdxo2rNL+eC07rYOktCc+ySxwGBP00C3Gu7Ptu65Ai0dZle2ObIvfDLA30FLfv+/0gnzAR+NoVdYwNZ1H+9+mta4j/44ojmZJ5Px9G7TF8BLV+LIK+RKzrlTBe8PwyG2eSboT3ItX0FaWLEjVG03SKSF+7Nq1EiPHrN2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737956007; c=relaxed/simple;
	bh=tqMjuFnxL/wMfBZS5h5++RWPag8Q8eTAmd8EPKRjWl0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZaA0+YCh3d1hp9hrqtjpdu7aviWVE81w9vNNFGar6arW61xBlPFIWEC+wM9XE5IEUUQo3SkIBspdWPJMZZvCAj6NR3DW5+h+vz8kj60hOpjaK0XIJCwpPuwzArrDSjcxtzl6V0Dpmgo0mqlPOwxVY4KAtGu2A/Qfcql8gQ3kDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=OKJ+Q6u/; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 0FCCF201E2;
	Mon, 27 Jan 2025 06:33:16 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C_F78iBvWQuY; Mon, 27 Jan 2025 06:33:14 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id B4A7C201D3;
	Mon, 27 Jan 2025 06:33:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com B4A7C201D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1737955994;
	bh=NpcBqL/NRz5Oh8DZg1crefWZGzW8vO9DQNHjekXBgug=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=OKJ+Q6u/VMj9Gy7meIaawSKeVDXcxEVyNndi+Jnu93jUJlmppdn8DwwOhDtisXZT7
	 U39j3rBCAVBOdyOseSUS2e1oYdsjNtDAPD33BGVwIhXUmExJULNPC7Kky6yfdzONk/
	 c0d9//aG6J8rKLLFYNUcvC7wmRBbALR3TA3xP+bceUPGBQRO36rJeN96ibZB8wC2u5
	 +e7SW3JEb7yY1sQhABVFpeswdg3C5/G+siZYwmSKzUBbRbY+oHoNRYOx5MHyz9ynQj
	 SCKlARxcecD995qib1V9hAYUS4o/f3ny4TavAE4sdhwTJsQoX8n2wfEG7quY9/kybb
	 38aFoRXvXAw6Q==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 Jan 2025 06:33:14 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 27 Jan
 2025 06:33:14 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 0E94C3180A76; Mon, 27 Jan 2025 06:33:14 +0100 (CET)
Date: Mon, 27 Jan 2025 06:33:13 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sebastian Sewior <bigeasy@linutronix.de>
CC: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Network Development
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net] xfrm: Don't disable preemption while looking up
 cache state.
Message-ID: <Z5camQoZ0KYWvyQ0@gauss3.secunet.de>
References: <CAADnVQKkCLaj=roayH=Mjiiqz_svdf1tsC3OE4EC0E=mAD+L1A@mail.gmail.com>
 <Z2KImhGE2TfpgG4E@gauss3.secunet.de>
 <20241218154426.E4hsgTfF@linutronix.de>
 <Z4oOldW33zFbYQ6/@gauss3.secunet.de>
 <20250123162045.INxxt33y@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250123162045.INxxt33y@linutronix.de>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Jan 23, 2025 at 05:20:45PM +0100, Sebastian Sewior wrote:
> For the state cache lookup xfrm_input_state_lookup() first disables
> preemption, to remain on the CPU and then retrieves a per-CPU pointer.
> Within the preempt-disable section it also acquires
> netns_xfrm::xfrm_state_lock, a spinlock_t. This lock must not be
> acquired with explicit disabled preemption (such as by get_cpu())
> because this lock becomes a sleeping lock on PREEMPT_RT.
> 
> To remain on the same CPU is just an optimisation for the CPU local
> lookup. The actual modification of the per-CPU variable happens with
> netns_xfrm::xfrm_state_lock acquired.
> 
> Remove get_cpu() and use the state_cache_input on the current CPU.
> 
> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Closes: https://lore.kernel.org/all/CAADnVQKkCLaj=roayH=Mjiiqz_svdf1tsC3OE4EC0E=mAD+L1A@mail.gmail.com/
> Fixes: 81a331a0e72dd ("xfrm: Add an inbound percpu state cache.")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Applied to the ipsec tree, thanks a lot Sebastian!

