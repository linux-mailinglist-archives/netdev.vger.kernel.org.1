Return-Path: <netdev+bounces-42069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF797CD10B
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 01:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A37281292
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 23:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB7A335AC;
	Tue, 17 Oct 2023 23:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCbx8Cfj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9FB2E3ED
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 23:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104ADC433C7;
	Tue, 17 Oct 2023 23:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697586643;
	bh=DX4eQLbDH4WkaayNMxaAdYWcxQIc3Jkh/CQPfojaQEU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OCbx8CfjXQDmgOK+IJZIpXLto/5Ledwx9z5n0guSGwzj4YeTet2MByosXF+VEl/wp
	 qmzX/92ZHeZ7aX3X3PuDjXgoLqgaj36J1sVU5ESBfbRxfhb99DTacmhIG/E4YYmRQG
	 IZ64NtUjRYNYda1jZo1oz1iRGrgia7TtQ8yBw4Rzo8o+UYZfeHdrymVvZuSuXbOOkU
	 EKcYUfpWl4HbuRg/Y4DWEx+5IUqF98ANbnRmz0G8zEcIs82xvoQ8IZZhcgd14ILbXd
	 Mg/lEa2uAginD05ObCUe9yLe7v8eHWpzhr63VADWExW27TmJ5PGz1j8CtaiRV++fJQ
	 KNnsfUF2hZNxQ==
Date: Tue, 17 Oct 2023 16:50:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Johannes Zink <j.zink@pengutronix.de>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>, Kurt
 Kanzenbach <kurt@linutronix.de>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, linux-stm32@st-md-mailman.stormreply.com,
 Eric Dumazet <edumazet@google.com>, Jose Abreu <joabreu@synopsys.com>,
 Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 patchwork-jzi@pengutronix.de
Subject: Re: [PATCH net-next 2/5] net: stmmac: fix PPS capture input index
Message-ID: <20231017165042.30fa9061@kernel.org>
In-Reply-To: <20231017-transfer-refurbish-5cfaf12a524c-mkl@pengutronix.de>
References: <20231010-stmmac_fix_auxiliary_event_capture-v1-0-3eeca9e844fa@pengutronix.de>
	<20231010-stmmac_fix_auxiliary_event_capture-v1-2-3eeca9e844fa@pengutronix.de>
	<20231014144428.GA1386676@kernel.org>
	<004d6ce9-7d15-4944-b31c-c9e628e7483a@pengutronix.de>
	<20231017082618.4558ad06@kernel.org>
	<20231017-transfer-refurbish-5cfaf12a524c-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Oct 2023 22:27:41 +0200 Marc Kleine-Budde wrote:
> > Would be good to clarify what impact on device operation the problem
> > has. How would end user notice the problem?
> > Does it mean snapshots were always or never enabled, previously?  
> 
> On all dwmac devices not covered by dwmac-intel.c (INTEL 10/100/1000
> Ethernet PCI driver), PPS capture can be requested from user-space, but
> is not enabled in HW. There is no error message or other feedback to the
> user space. The user space will not get any PPS events.
> 
> As this change also affects the Intel driver, and we don't have any
> hardware to test, I think it's better that this goes via net-next to
> give it a bit more time of testing.

SGTM, we can chalk it up to "never worked, doesn't hurt anyone"
and put it in net-next. But then the Fixes tag must go.

