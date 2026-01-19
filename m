Return-Path: <netdev+bounces-251219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E538CD3B543
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E5833008C94
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449AF2DB7BB;
	Mon, 19 Jan 2026 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiCqToJo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225567405A
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768846368; cv=none; b=A6NgdyYgxYGzmZdsFLh18TN2ZQDSAXCRsDuqCtcjURSuE4FjlKOxkilrd6l84pv4sOxfEAnzASgPGTbZV2y1GaLScpYPwCMf0PcSzvsJXrCNhRQzP8gllNsQsFWRM+ZeLIfNzgDTRYsIf+p5BGyg/EmnWjX6BXTMDXObuldWwms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768846368; c=relaxed/simple;
	bh=uH6XlEX6ZOLU0byYbPUUue73Or4AApUEyknjvJIsyCo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BWMgw2rCXnGrpjiil2uEZMEcm8Nu75mCceMXo4waxtK8lW39oa4hMBkSPWaQ0s13Dkt+cZufSzNnGuwZIVRReZx+tcIpGF7ENHnoebhQHp6qurOFE5q7vYb+PnsvAhTn+TEpuA/itT30Q9cdSIh2b5Ek30HfNEP39DolhhyxOoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiCqToJo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3493C116C6;
	Mon, 19 Jan 2026 18:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768846367;
	bh=uH6XlEX6ZOLU0byYbPUUue73Or4AApUEyknjvJIsyCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TiCqToJoad/GiIae5IU7tqVBhS8L/XeXjChpshhxRaX5B1jcFNFw8Jmi8B2kfcKjA
	 j725CQYryPBAM9zRGljjWpANaq/vyOJ2lH0nP+vkNtVwigl8fiBXqYLduD3JyHoDlp
	 UOUWkeWU+F4yG1nrksLKBx8231WXn3pC+5tFc/t0Kkyyc2I9nrEY6M/msgxnUQBjKE
	 /A/txnEvreqK1Jquy1PjyJzIjP1kxxHaPxdtpxtxSVeav6WrF65jF1weG0tVUWvHvd
	 p+UvJIYlEp21caD2HHfjyhMFUDVYAmY1z/C5a6DQNfe6W5pj2Ff1W16gOuhPeKcehM
	 ZrW/NtTiZXjjA==
Date: Mon, 19 Jan 2026 10:12:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: sd@queasysnail.net, bbhushan2@marvell.com, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 sbhatta@marvell.com, jerinj@marvell.com, hkelam@marvell.com,
 gakula@marvell.com, lcherian@marvell.com, sgoutham@marvell.com,
 george.cherian@marvell.com, netdev@vger.kernel.org,
 alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH net-next] octeontx2: cn10k: fix RX flowid TCAM mask
 handling
Message-ID: <20260119101246.420acd4a@kernel.org>
In-Reply-To: <20260116164724.2733511-1-alok.a.tiwari@oracle.com>
References: <20260116164724.2733511-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Jan 2026 08:47:12 -0800 Alok Tiwari wrote:
> The RX flowid programming initializes the TCAM mask to all ones, but
> then overwrites it when clearing the MAC DA mask bits. This results
> in losing the intended initialization and may affect other match fields.
> 
> Update the code to clear the MAC DA bits using an AND operation, making
> the handling of mask[0] consistent with mask[1], where the field-specific
> bits are cleared after initializing the mask to ~0ULL.

In the future - if the code exists in Linus's tree the fix must have 
a Fixes tag and target net.

