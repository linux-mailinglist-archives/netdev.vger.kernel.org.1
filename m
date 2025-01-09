Return-Path: <netdev+bounces-156783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3A2A07D0E
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2123B1881A04
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F22F2206BF;
	Thu,  9 Jan 2025 16:13:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809E5220681;
	Thu,  9 Jan 2025 16:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439198; cv=none; b=kv87YeU+vwaUAXl+Tui2lMF18jTU+GW2kUk0hLStPp7lz4jI5jqM9ZLv7a7xRumlFYl563zbbTW8wSioGSku17NxijN2LzJD3h84Le3DSJw95yneOa7v2/F8keOmFadXj5PEllX3Ws+nE+QCsVZJYh50d4jWjfu6tlGlwlBmqy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439198; c=relaxed/simple;
	bh=DJF4bqvWDQyKrhLkqDDsIw+w1q8VJqZZO0FFDoL67bQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OT2SSC6J5UcRmj23Kda2nJYOyYxVI7RnEOAtNR0H+rnLRlxrq/0O7fSIJECi6hBMaX/w0Vu2Lf9GtWMPZlithh8/VGkEntLWAPy8pJjzT1HgFecBB7a6e6BL9rrzXxYfh5C8S/fBmNaTAHdAnudS55PpAhpUMAuA9GoQW5cNoX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 4ED0948F8E;
	Thu,  9 Jan 2025 17:13:06 +0100 (CET)
Message-ID: <55eb832f-1297-46d2-9e34-b0e252c105c3@proxmox.com>
Date: Thu, 9 Jan 2025 17:13:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] openvswitch: fix lockup on tx to unregistering netdev
 with carrier
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Luca Czesla <luca.czesla@mail.schwarz>,
 Felix Huettner <felix.huettner@mail.schwarz>, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, Pravin B Shelar <pshelar@ovn.org>
References: <20250109122225.4034688-1-i.maximets@ovn.org>
Content-Language: en-US
From: Friedrich Weber <f.weber@proxmox.com>
In-Reply-To: <20250109122225.4034688-1-i.maximets@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/01/2025 13:21, Ilya Maximets wrote:
> [...]
> Fixes: 066b86787fa3 ("net: openvswitch: fix race on port output")
> Reported-by: Friedrich Weber <f.weber@proxmox.com>
> Closes: https://mail.openvswitch.org/pipermail/ovs-discuss/2025-January/053423.html
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>  net/openvswitch/actions.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

I've applied this patch on top of Arch Linux's 6.12.8-arch1-1 kernel,
and the reproducer [1] has not triggered a infinite loop / network
freeze yet in ~1h, whereas on unmodified 6.12.8-arch1-1 it usually
triggers one in 5-10min, hence:

Tested-by: Friedrich Weber <f.weber@proxmox.com>

If necessary, I can rerun the test on a mainline kernel.

Thank you for the quick fix!

[1]
https://mail.openvswitch.org/pipermail/ovs-discuss/2025-January/053423.html


