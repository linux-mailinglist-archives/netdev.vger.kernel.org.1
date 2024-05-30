Return-Path: <netdev+bounces-99461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D09128D4FA9
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CADF1C223EF
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2F8210E4;
	Thu, 30 May 2024 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WK48dhGa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728CE24B29;
	Thu, 30 May 2024 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717085612; cv=none; b=rnJvT3gl1+wGhMepD9UEvoZrN+/kEm6nOgCUejuITWJMBlQCYEiIckufkq4ZUKNTllRaTKebe3Hac8nq0ZtdqZNsf3E4opq91f6SApz6kGGe7JbHdJnQqvNoB/kJhl0KwcBSD624pMIlJ/vXIGttpsDP24EpHBhiVjJ5/AWRQU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717085612; c=relaxed/simple;
	bh=PfJbQricCfe6xXO/btTWODyoQHxmmR7NyBEvK16OrTA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sXj2qp0fAyy24mTvmeeKrRxZLMnQa81NJwEai5dVPCys8+b211kbGXieJ6S5G0NelJAXudpjSBnhxTRmj/Iibmqggd0sMP8j/VPQHMpsaX+y1a0L/t0BhXqD5CjSfmez2Ot4q9g5iSbK9ZK+eWj5IAYyiv1s+oyVb5C/Stiukrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WK48dhGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B350C2BBFC;
	Thu, 30 May 2024 16:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717085612;
	bh=PfJbQricCfe6xXO/btTWODyoQHxmmR7NyBEvK16OrTA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WK48dhGa24x2IlutQf0BRwlTmhjcJlIUaUgtVU3SxywObeSgfOJGvUMWBMScFTAZd
	 ISDSGqUTgClDZZTlYoGtEf/UlzzFy6UaOtFHAPMLMSt6tdRgF92PHNHBBmMFk3zdHN
	 yxJobDk4Afff/dA5r5fsiYOhGbD/zTIms4wkhdDAotURS+wxmbKq+76k7fDHnwrRFw
	 lSLl1g/OXNSmV36nqyWL/3hN6l9oYgI9iRMwmcIQBbiU6L8ccc7dAv3lMdsmNkcZIG
	 CFUfsxqHZkfCtM88aDNPUJjZn/N8RZvJikGOTNXk5cIK/kzYUWyTuX/5bmFRR4OmAB
	 Wcoq2bkwa8kmA==
Date: Thu, 30 May 2024 09:13:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vladimir Oltean <olteanv@gmail.com>, Xiaolei Wang
 <xiaolei.wang@windriver.com>, Andrew Lunn <andrew@lunn.ch>,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [net v2 PATCH] net: stmmac: Update CBS parameters when speed
 changes after linking up
Message-ID: <20240530091330.13a20fdc@kernel.org>
In-Reply-To: <ZliBzo7eETml/+bl@shell.armlinux.org.uk>
References: <20240530061453.561708-1-xiaolei.wang@windriver.com>
	<f8b0843f-7900-4ad0-9e70-c16175e893d9@lunn.ch>
	<20240530132822.xv23at32wj73hzfj@skbuf>
	<ZliBzo7eETml/+bl@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 14:40:30 +0100 Russell King (Oracle) wrote:
> I think what you're proposing leads to the hardware being effectively
> "de-programmed" for CBS while "tc qdisc show" will probably report
> that CBS is active on the interface - which clearly would be absurd.

FWIW the "switch-offloaded" qdiscs do support reporting that they got
"de-programmed" given that more complex hierarchies can easily go out
of what HW is capable of.

They call the driver from the .dump callback, nominally to get
stats (e.g. red_dump() -> red_dump_offload_stats()) but it also
refreshes the offloaded state (see qdisc_offload_dump_helper()).

For "NIC-offloaded" qdiscs (i.e. all traffic passes thru the host,
rather than being forwarded) the stats callback makes less sense.
But all this is to say that there _is_ precedent for clearing
qdisc "offloaded" bits.

