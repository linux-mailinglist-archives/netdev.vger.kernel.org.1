Return-Path: <netdev+bounces-56128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD71380DEC1
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FEED2825C6
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 22:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D1F55C3E;
	Mon, 11 Dec 2023 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/ayCjsP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75FA55C26
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 22:59:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5B7C433C8;
	Mon, 11 Dec 2023 22:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702335585;
	bh=t7nQKTTeGh65bU29w+Bc8SK2+uEhQ8nX0LrViq7JYqk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V/ayCjsP1FkvVFM17OEH03CfEKEOd2MP64ffO019moohHMBAdYMxM5wQ7lLiPowaw
	 gxescu6QOlqk99izlWGLWswXQLkz5ItDrmoIvvWQodLnU/faMboH+eT+XG0OrS1Q2h
	 tRi4+rt1enNLzJtYP+djQEOAHnND0Sz51/8/5xFqWeXdymJfoZ9AdvRT6fsuKu/EfF
	 WLPhwPCLSMFAewuDZvjD4tNBsUa3gJpGoyIren8v1orQnVNzQnDK1BDCpiYv7in+2X
	 sxXVAxPiGeW3FNMlzlnF2SAmfftk6XZwbbKVPltqcpp9HpRvIPK/zFqQpkdVC8UwhT
	 hfmR1+icdW39A==
Date: Mon, 11 Dec 2023 14:59:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Jianheng Zhang <Jianheng.Zhang@synopsys.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <Jose.Abreu@synopsys.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, "open list:STMMAC ETHERNET DRIVER"
 <netdev@vger.kernel.org>, "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>, "moderated list:ARM/STM32
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>, James Li <James.Li1@synopsys.com>, Martin
 McKenny <Martin.McKenny@synopsys.com>
Subject: Re: [PATCH net-next] net: stmmac: xgmac3+: add FPE handshaking
 support
Message-ID: <20231211145944.0be51404@kernel.org>
In-Reply-To: <zx7tfojtnzuhcpglkeiwg6ep265xpcb5lmz6fgjjugc2tue6qe@cmuqtneujsvb>
References: <CY5PR12MB63726FED738099761A9B81E7BF8FA@CY5PR12MB6372.namprd12.prod.outlook.com>
	<zx7tfojtnzuhcpglkeiwg6ep265xpcb5lmz6fgjjugc2tue6qe@cmuqtneujsvb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 14:14:00 +0300 Serge Semin wrote:
> Although in this case AFAICS the implementation is simpler and the
> only difference is in the CSR offset and the frame preemption residue
> queue ID setting. All of that can be easily solved in the same way as
> it was done for EST (see the link above).
> 
> Jakub, what do you think?

Yup, less code duplication would be great. Highest prio, tho, is to
focus on Vladimir's comment around this driver seemingly implementing
FPE but not using the common ethtool APIs to configure it, yet :(

