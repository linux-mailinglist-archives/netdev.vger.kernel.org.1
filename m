Return-Path: <netdev+bounces-126150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEBC96FF1A
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 04:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A711F239AF
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 02:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C728E4C62;
	Sat,  7 Sep 2024 02:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEnfWaYD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EF412B8B
	for <netdev@vger.kernel.org>; Sat,  7 Sep 2024 02:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725674625; cv=none; b=Mzj6WkwlQZN55AwX+g7m8pMKDf1NiPmDyDKF3zrFITgitIheTuyX3d6aPVgk4y8yclS/vfCJybl30KmLZ1Bi7RrQgMlwfDHFKRDvylvETd1b4wSFDhCBBVW0AAP0UwLhIp5f2dm/nogsVQMx9zQY9USy4cgVXPrvUsdbj5bHOT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725674625; c=relaxed/simple;
	bh=kotF0tEiYS5fhiJjeu9Pz2HkYeeYw4uk8UEexsEDswo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WD1CNkcOIu5Pkwd5rKajdAWMoKtXHxX8xGSG02EJvtU9pjgLaxbyX8eqRWom0xNQVdFOoVIdER+1caxo007CnLrhDLEImYDp+Av0FZ0Taqt5wy7o4+BLaYRwOAJowN28wZCy0TzPhbaoC+MhG01k9x1GnAX3y5aRErMlXLvwmUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEnfWaYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99C2C4CEC6;
	Sat,  7 Sep 2024 02:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725674625;
	bh=kotF0tEiYS5fhiJjeu9Pz2HkYeeYw4uk8UEexsEDswo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rEnfWaYDrZueCIGxZOBGifYECLRFwN4d/tM8v1xViqFTrv9/ApbmCV2qED2xDCIby
	 nySLYiPCYImCT3+7jbfpepo95+wgd0RgtvWGlhvD1lLf8DpVka/cvxx/ZcfQbo8+43
	 xARCKD6ANJ/tk8P0Lu1DUA/KaQreElD65O6oHqXPbFxvTi1ss7eIgTjdv1PXbYSLCd
	 SDMVLAkVHmUd3w0hKAG5QtT/pmPyc4x4M0VAs4XtDcpvM/7a2YKsw8BtUCldAhuLIe
	 u+WMDD22dycsW/FvBEPS00ac2UuFRjG6Xqo+cInoPtHA20ChZzvbLBJdiuYtFB9JPN
	 O6tiwUKOLM3rw==
Date: Fri, 6 Sep 2024 19:03:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <edward.cree@amd.com>
Cc: <linux-net-drivers@amd.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, Edward Cree
 <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
 <habetsm.xilinx@gmail.com>, <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 net-next 6/6] sfc: add per-queue RX and TX bytes
 stats
Message-ID: <20240906190344.2573fdd2@kernel.org>
In-Reply-To: <fe0d5819436883d3ba74a5103325de741d6c3005.1725550155.git.ecree.xilinx@gmail.com>
References: <cover.1725550154.git.ecree.xilinx@gmail.com>
	<fe0d5819436883d3ba74a5103325de741d6c3005.1725550155.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Sep 2024 16:41:35 +0100 edward.cree@amd.com wrote:
>   * @tx_packets: Number of packets sent since this struct was created

I think it's number of packets "enqueued", but the doc says:

        name: tx-packets
        doc: |
          Number of wire packets successfully sent. Packet is considered to be
          successfully sent once it is in device memory (usually this means
          the device has issued a DMA completion for the packet).

Not the end of the world if you prefer to keep as is, but if so maybe
just acknowledge in commit message or a code comment that this is not
100% in line with the definition?

> + * @tx_bytes: Number of bytes sent since this struct was created.  For TSO,
> + *	counts the superframe size, not the sizes of generated frames on the
> + *	wire (i.e. the headers are only counted once)

Hm. Hm. This is technically not documented but my intuition is that
tx_bytes should count wire bytes. tx_packets counts segments / wire
packets, looking at ef100_tx.c 
qstats "bytes" should be the same kind of bytes as counted by the MAC.
That way we can hopefully see how many packets "enter" the device from
queues, and how many "leave" via the MAC. Helping to calculate drops 
at various stages. That matters more for packets than bytes, but still..
-- 
pw-bot: cr

