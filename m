Return-Path: <netdev+bounces-131344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7810D98E33B
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 20:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A6E28129C
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 18:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2431D1E84;
	Wed,  2 Oct 2024 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OD1zve4J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8254F1D0425;
	Wed,  2 Oct 2024 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727895453; cv=none; b=ab2jRPPjWiyZeMHnURMi+a0xc3sUSNuR2cnQ7KBtyKSi+SjnVBzHUyd2g17Tbu1umB/ifDNMLGWCbwY6SiGyTCrFR23UtmADJCdQF/JXe0y33RoOCq1/ff42CVuL8iYz1+jsvuNYe1r+ea/eGpx0Ms9oJv78Z+64HoV7amL1q5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727895453; c=relaxed/simple;
	bh=Xnt1YJ9ju2/c4oQh0I6rkxuPSnWHunzH7etL6wWGiEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JahmekkXqHmveAksXC7QsdnA+ymfwjQWp/LNs7SDxRtCmgIwGafWMFqrgDrvX9jSgMWFlWw9IWX5/GhRPPo5mvfcmuxzYLZfACtTSyQtsAODtjw0kGfQ/pJhNL+kARXjMebd0O6LDKEEPjKG1bgOC6YGA2EN6oJuTaMvw22E2vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OD1zve4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17FFC4CEC2;
	Wed,  2 Oct 2024 18:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727895453;
	bh=Xnt1YJ9ju2/c4oQh0I6rkxuPSnWHunzH7etL6wWGiEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OD1zve4J2QIDIDeQIaTA8HqEPY5TNpx32L/PNj8P26kTLmdAVPACDDz+H07kY6EoD
	 KyKzYpBn1URCLUM7Z/zBH/uxpK8RbeS6Bc1bumz2/q6w1Gh6Z+B/V3q5jx4P9ikK0A
	 vPOQZBk7CC1ERa4BjHohRH0NPQttAlmevlx+RrWFWTRMkrYnQoSSVFfMvpB4rnaoTh
	 55b3HJ/Y9zeoZ6+bo1lbHO5IWq6F4ftsThNiosTIiaXZkmBPM4RRQR2J4p3QjdjL1/
	 qkzcg0iyxYHrwzjvBIwHc4pJEf5og4I7SP7ysCDd6yVGAbTqyFzLl+DJywHMPyQfp5
	 D3NKcykGjIKlg==
Date: Wed, 2 Oct 2024 11:57:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Minda Chen <minda.chen@starfivetech.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v2] net: stmmac: dwmac4: Add ip payload error
 statistics
Message-ID: <20241002115732.00c05c63@kernel.org>
In-Reply-To: <tb2o2dhxcg7lykl743no3zkkjnqwuce56ls5ihrwreowigivwv@2mol7uc2qvto>
References: <20240930110205.44278-1-minda.chen@starfivetech.com>
	<20241002065801.595db51a@kernel.org>
	<tb2o2dhxcg7lykl743no3zkkjnqwuce56ls5ihrwreowigivwv@2mol7uc2qvto>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Oct 2024 21:35:30 +0300 Serge Semin wrote:
> It almost word-by-word matches to what is defined for the
> ERDES4_IP_PAYLOAD_ERR flag (part of the Extended RDES4 descriptor
> field) in DW GMAC v3.x HW-manual for which the
> stmmac_stats::ip_payload_err field has been added in the first place.
> Note the name of the flag in the descriptor matches to what is declared in
> the stmmac_stats structure.

I misread the ERDES4_IP_PAYLOAD_ERR as a Tx flag, somehow. All good
then.

