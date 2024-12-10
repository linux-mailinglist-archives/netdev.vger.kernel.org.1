Return-Path: <netdev+bounces-150429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 616799EA36C
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 01:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528AD165088
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 00:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA291801;
	Tue, 10 Dec 2024 00:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPXqfpMC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAA5A31;
	Tue, 10 Dec 2024 00:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789502; cv=none; b=m54ta+PSWMd0u0L6ZzarEKhqjndMR5Dn1a1tuXjd2piJ0P7jfiApNQoF/f3yUR3D2uESi43cj0ADfCSbIaectAQSacqzKz6jrwBVhi6CdrLjayA15q8oDbkyWWLwp4suj2kLFdNTrLswjG8yT558XmRYueiiGjKPE9V4Y0xZBg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789502; c=relaxed/simple;
	bh=f9f0CDxJJeYE/UVnxbZ7hAN5C4xRGw1Z+6BYv4lkA0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gaSufwWyfPOp5Gh6DBons+PsJfOzuK0FjcoAYweiuaZiG5KIIxN6csi/e/2eCMmAXWI1jgWqh38e/ZmbLJcKWmae87U+xyns6knyoGvaKLgLk/hhKCk+f3Nyqdq/2lAwdAby1EtRjdqNQ7SiNKQXeUpcrnZbOKSNEClwXPDyLyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPXqfpMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4FDC4CED1;
	Tue, 10 Dec 2024 00:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733789502;
	bh=f9f0CDxJJeYE/UVnxbZ7hAN5C4xRGw1Z+6BYv4lkA0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pPXqfpMCgvZz+uhwWI/1lTgGfFoDQmbju1ImQ7e3nkgzmfUaeLQ4ZK49ysCIpF16M
	 Xsh1FOWmKMQv2RPSdDYJTD3NOjUMiJPKpwsEaC37Ujlzf2RRbOzT5GX8cLOtMpcdPD
	 TnsSdgqJILwvKD5T9bwgLlVmu/9ZOP9cwForNXtvH28iPyzU0x3XZm3+diUWDvPWbH
	 zylAN6dXDKGmv7/AWrCJyZSTBxl90+ZA9AN39abZADdrDZbk2VNxQfn1Pk/YW0ZRGF
	 LJmHDVBT0+suPavjmrPBIj+oql3PHD17IV9xpNErWKvTdbNm10PFzvrSW3VpMyEtDL
	 IwtY8VJv6OK1A==
Date: Mon, 9 Dec 2024 16:11:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
 <jacob.e.keller@intel.com>
Subject: Re: [PATCH net v3 2/2] net: ethernet: oa_tc6: fix tx skb race
 condition between reference pointers
Message-ID: <20241209161140.3b8b5c7b@kernel.org>
In-Reply-To: <20241204133518.581207-3-parthiban.veerasooran@microchip.com>
References: <20241204133518.581207-1-parthiban.veerasooran@microchip.com>
	<20241204133518.581207-3-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Dec 2024 19:05:18 +0530 Parthiban Veerasooran wrote:
> @@ -1210,7 +1213,9 @@ netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb)
>  		return NETDEV_TX_OK;
>  	}
>  
> +	mutex_lock(&tc6->tx_skb_lock);
>  	tc6->waiting_tx_skb = skb;
> +	mutex_unlock(&tc6->tx_skb_lock);

start_xmit runs in BH / softirq context. You can't take sleeping locks.
The lock has to be a spin lock. You could possibly try to use the
existing spin lock of the tx queue (__netif_tx_lock()) but that may be
more challenging to do cleanly from within a library..

Please make sure you test with builds including the
kernel/configs/debug.config Kconfigs.
-- 
pw-bot: cr

