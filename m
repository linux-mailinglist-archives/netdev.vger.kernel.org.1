Return-Path: <netdev+bounces-159114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DABA14704
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 01:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77FF23A947A
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 00:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8D825A650;
	Fri, 17 Jan 2025 00:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2xnr22s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC501C32;
	Fri, 17 Jan 2025 00:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737073633; cv=none; b=UEDJcNqjGr0RuvDPEL+VRF7h7jnNRNQ17IxMs4NVkU21NmSWFb4F3cQjA5U8CwC/48Fb/4p6w32rKO1Z+wBrm9qZq1HA7sPq60gTSQC17TzSyXqd1Zib0pAxhxuekiNTAc6x2ND03RNuqaIjHNGB4rRt4pXrQg4YkubckGUjmWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737073633; c=relaxed/simple;
	bh=dESk8X92BLtzB+2p85epCK0l5JJoQ+ZXkqgvn/ACGxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gzgpWhxRKNkrf3feTv++yZ2Leyt6zqNDsjtgiVACw2KkwmvrcnMVOFUQvlcBW0Tf2Tua2FseMkDN+JdxwACAQHwWplf/uP5sgN20QjjAU5LYFvyVe76ptuzzNWMosuihSyPL9HfVhW1CLxTMdCj7azHSVvjU4laJ/LiOK6ZExDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2xnr22s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C00C4CED6;
	Fri, 17 Jan 2025 00:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737073632;
	bh=dESk8X92BLtzB+2p85epCK0l5JJoQ+ZXkqgvn/ACGxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H2xnr22sElZA6qSaQ0kbrKobOyJreQxK9F1Anii6UlZEOo4iRY8gYRlt792S8QGnm
	 BcIYvdCZLNSDrMs2vLm0WIA9KksmJgnaDSRC51OXgusQkDUvqVyVZDK1ao1EGkKPWw
	 3ghIeTTYfUGeiLk/2DbH4BkFqQHnFZJ47K8Cy6sFI/j0PveFRq/wRRGKa8uTx8TGO8
	 4WEJis1e5O1phdU4gL8XcpdJRJUBKm/egDOfi5boQ0A1CC74u4zHDcZMmCrsQxwYlQ
	 o2ul5Cu/oInfP/IJQD8fJhiDZFxZlQGTlb3jd6HlsI2zrs0ougRJY/QxwTp6BE/X9Q
	 f/+kOsfzvWwHg==
Date: Thu, 16 Jan 2025 16:27:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Shinas Rasheed <srasheed@marvell.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <hgani@marvell.com>, <sedara@marvell.com>,
 <vimleshk@marvell.com>, <thaller@redhat.com>, <wizhao@redhat.com>,
 <kheib@redhat.com>, <konguyen@redhat.com>, <horms@kernel.org>,
 <einstein.xue@synaxg.com>, Veerasenareddy Burru <vburru@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net v8 2/4] octeon_ep: update tx/rx stats locally for
 persistence
Message-ID: <20250116162711.71d74e10@kernel.org>
In-Reply-To: <Z4klGpVVsxOPR3RZ@lzaremba-mobl.ger.corp.intel.com>
References: <20250116083825.2581885-1-srasheed@marvell.com>
	<20250116083825.2581885-3-srasheed@marvell.com>
	<Z4klGpVVsxOPR3RZ@lzaremba-mobl.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 16:26:18 +0100 Larysa Zaremba wrote:
> > +	for (q = 0; q < oct->num_ioq_stats; q++) {
> > +		tx_packets += oct->stats_iq[q].instr_completed;
> > +		tx_bytes += oct->stats_iq[q].bytes_sent;
> > +		rx_packets += oct->stats_oq[q].packets;
> > +		rx_bytes += oct->stats_oq[q].bytes;  
> 
> Correct me if I am wrong, but the interface-wide statistics should not change 
> when changing queue number. In such case maybe it would be a good idea to 
> always iterate over all OCTEP_MAX_QUEUES queues when calculating the stats.

Good catch!
-- 
pw-bot: cr

