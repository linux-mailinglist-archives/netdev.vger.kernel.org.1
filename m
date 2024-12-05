Return-Path: <netdev+bounces-149489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AD89E5C4E
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 17:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1C61883BAA
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688B922259A;
	Thu,  5 Dec 2024 16:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsksfZd0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408D9222593;
	Thu,  5 Dec 2024 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417741; cv=none; b=SUiCwUJ/yvaQuVPEN97OOcwirZkJgg0GPac+hgMk9iARsgAkThA5MgU9kxVWqUTKIiygQBF1gHcjjCkYbFFBJ6ZbvFDNQGcnOM/65I/feDJa6ZiK1eJznZ5VNTygMXS4zgX8H++Az5PTFxE4vZVI+7MilRJYLONIphQXc4ID2T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417741; c=relaxed/simple;
	bh=EY2JQ1OUdq1nkq0OdGBKVLh8IN+KP3uYIHf4Esw6NRo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJKnXqkqcqrxBLYASydxPVMoujq9S4y/91dGHsE7MHhQRZgL01cfMOSJ7+npx/6ashg1yuoci8QNNHZNmSXEAzv9EfbNFwP+YoPDdgPNP13L9CBLlS8YMfEAchdIbGYUjvcPr3k7PM+TlPUaN/14SqQE2Gz+QbJ4TP2eMqWwHYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsksfZd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A48C4CED1;
	Thu,  5 Dec 2024 16:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733417740;
	bh=EY2JQ1OUdq1nkq0OdGBKVLh8IN+KP3uYIHf4Esw6NRo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FsksfZd0UGkgpt4kFjDeehzYfX1wWHKpJRUTy8PStAUQmjAv0rzo+gYYiM0Kpv8gd
	 TwSsdqFrZdUqGcTCRan1r1FKO8vrCp3xTCeZpByPwNiIImHynYkIoUE+EYAIJ4TiNz
	 bwjQnhdE3oi9sBxJen7FRV3c2WxvzrwLpe72KQ11wIqcMcfG4mMefh9IZ0Yqg0XTD3
	 kz3Sh2R83u3gQU2cA+Cg0ujPk6IM6ih32Uiacv1lH0DKkfin+77+2M/fYrgAS6ZTCc
	 JxEM2KSVCnU9CkGK/K/Shy2FD3JouWHu0xfygwPBQZ4z9oQHwZqWtDeue+SIByIYFX
	 n8MdRot1Ly8YQ==
Date: Thu, 5 Dec 2024 08:55:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Furong Xu <0x1207@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 andrew+netdev@lunn.ch, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com, Jon Hunter
 <jonathanh@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH net v1] net: stmmac: TSO: Fix unaligned DMA unmap for
 non-paged SKB data
Message-ID: <20241205085539.0258e5fb@kernel.org>
In-Reply-To: <Z1HYKh9eCwkYGlrA@shell.armlinux.org.uk>
References: <20241205091830.3719609-1-0x1207@gmail.com>
	<Z1HYKh9eCwkYGlrA@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Dec 2024 16:43:22 +0000 Russell King (Oracle) wrote:
> I'm slightly disappointed to have my patch turned into a commit under
> someone else's authorship before I've had a chance to do that myself.
> Next time I won't send a patch out until I've done that.

Yes, this is definitely not okay. LMK if you dropped this from your
TODO already, otherwise I'm tossing this patch and expecting the fix
from the real author.

Side rant - the Suggested-by tag is completely meaningless, maybe we
should stop using it. The usage ranges from crediting people pointing
out issues in basic code review, to crediting authors when stealing
their code. What is the point.

