Return-Path: <netdev+bounces-71692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABFA854C2D
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 16:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473CB281F2F
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 15:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BDE5B671;
	Wed, 14 Feb 2024 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxEaiVIx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B12755E6F;
	Wed, 14 Feb 2024 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923351; cv=none; b=IlVJQoq9kXWmf7uZrbGrmEssdmq5DD+VnIKcXFHbhmR3BpzfJwEf+h4PqeVQWoFlvoiNDHhC/3HwGvae7w7TON701Fr9p/QHGJrKQWA5C0DW8SqeUtaVcQtltGhf4LU/vXHJcPvrN1qARoaRwdM1iYzWdxnFcK5vWhFq6gxRoFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923351; c=relaxed/simple;
	bh=mizirLimmUEE322weHnkCcj0GE0VAoxA+iLLMUv1o/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VpikaNuA7IjURZGjBiKWYH3G5yMIqKKYYqNpcd2tFAdFeygnD9X/KIidMIEzzDykc8/muDSDAPIOJiBEZ9Bke3eZcioTayh06JZ2Rp39i+mrzNSmBwIL+nIeOX9sjQTYRVQcd2RtMgrMy9+r7WwsUDcvLlSniKATy4QucDt7jmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxEaiVIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F27C433C7;
	Wed, 14 Feb 2024 15:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707923350;
	bh=mizirLimmUEE322weHnkCcj0GE0VAoxA+iLLMUv1o/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cxEaiVIxo/98rw8dZulsMR6qfja+BcJwnthjlX389X5xIoL+cjn4nkFkjlwI/oVrD
	 2Pnx49FszyK6E5BmjdEvFxmAC7/q2LIJLit/McOquFQWxgpax9BQpw5QqqAVzwBipW
	 fL33htjlqVcHGZWIf2jBlExk486Ei4unn0LXdh+pC8rvD6jUMtMn3cAjvuoMum2eGk
	 UuN7HlyoW2PtoRujPlvMuOk7dVVFuAZj6Kdw0+5fdOt00LxDS80NsYMfsNePR4G9mP
	 quNWlKt6u4Gbcu3bsp2Li5SCCZRgBm1D4nye0Gt78nYbv9tp7DFF6ZaNot1SoLkabW
	 vrC7Vrw0Ky7jg==
Date: Wed, 14 Feb 2024 07:09:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <lars.povlsen@microchip.com>,
 <Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
 <UNGLinuxDriver@microchip.com>, <u.kleine-koenig@pengutronix.de>,
 <rmk+kernel@armlinux.org.uk>, <vladimir.oltean@nxp.com>,
 <jacob.e.keller@intel.com>, <yuehaibing@huawei.com>,
 <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: sparx5: Add spinlock for frame
 transmission from CPU
Message-ID: <20240214070908.37b49ddf@kernel.org>
In-Reply-To: <20240214081442.w533wvcvqpvq5352@DEN-DL-M31836.microchip.com>
References: <20240213121705.4070598-1-horatiu.vultur@microchip.com>
	<5476743f-3648-4038-97f8-a9df22c0f507@gmail.com>
	<20240214081442.w533wvcvqpvq5352@DEN-DL-M31836.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 09:14:42 +0100 Horatiu Vultur wrote:
> > Any reason you targeted 'net-next' rather than 'net', as this appears to
> > be clearly a bug fix here?  
> 
> Yes, it is a bug but it is not something that happens all the
> time and I thought this fits more into the lines of 'This could be a
> problem ...' therefore I had targeted 'net-next'.
> But if you consider that I should target 'net' instead of 'net-next' I
> can do that.

Definitely a bug fix worthy of net, yes, please.

