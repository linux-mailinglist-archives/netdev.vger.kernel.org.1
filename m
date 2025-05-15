Return-Path: <netdev+bounces-190734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20478AB88D3
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 16:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE843BF543
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 14:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A82158538;
	Thu, 15 May 2025 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crAxC2ps"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06B321348;
	Thu, 15 May 2025 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747317772; cv=none; b=GUVEoIxjrPwISdPs+Zwr5EA0vncHXEpSizV8b5SXBx1XCACHn5EIAob6l44c0nJAZcUo1Eaj6KptkjC+MhELxSYTgKXXcxCES2WfprNn5zl9odoBU7SST5MDNPrTvr39dFVizQO6JCk2uJjycpOta4a7edpqezkMoI4mnNrYj70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747317772; c=relaxed/simple;
	bh=mq6q8tMKFsLMsxQl4TmrA95ppM54MLXCnX6P35eldbI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HAHlrvTj9ymHw8qz7Dj7rD09IKY9Xv/FmLR8AjYzYvgba9U4PcvO8zX14iIUivRYjzQujfKZhchbGxH7nY8u22lLwPEsF20xSfeYEKV3umdymxkuyqlapY1SIMDIDosydB0/xGzDBsF5MSoJdeWhjpP8+demPmMULU5spG4nATU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crAxC2ps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3C5C4CEE7;
	Thu, 15 May 2025 14:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747317772;
	bh=mq6q8tMKFsLMsxQl4TmrA95ppM54MLXCnX6P35eldbI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=crAxC2psxrOJxlCtiUQr4YkP4rkVh5c8HrsZePmHlM4P/jNdSEPr3zfk55EtslGJt
	 qBrIqaSc4c337MoOAYb95wb/zKYRvheomidybi3OWq2IRJx5PuYbjOCiG55qrER7dZ
	 XQHoE0bTl1ReAOU+vy0wVDIltREBxvtNCROfp2PAlfLjL0THvnUWWpCfiGxi5Bz++A
	 +A3+4jxRKZNzydy/NqQBXHDbBANkgeydRgo6aKogQjgrq19MzkCCjfvWXJA49AZ60J
	 hKJ6dEJeKrEpCoE4VQwKlODwFpzSSGv2NCvYMXaK4Z9XmUDiX5gldJcQNR5nL9h5Hn
	 WsH2+zspW4AzA==
Date: Thu, 15 May 2025 07:02:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ronak Doshi <ronak.doshi@broadcom.com>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Guolin Yang <guolin.yang@broadcom.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net] vmxnet3: correctly report gso type for UDP tunnels
Message-ID: <20250515070250.7c277988@kernel.org>
In-Reply-To: <20250513210504.1866-1-ronak.doshi@broadcom.com>
References: <20250513210504.1866-1-ronak.doshi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 21:05:02 +0000 Ronak Doshi wrote:
> +				skb->encapsulation = 1;
>  			}
>  			WARN_ON_ONCE(!(gdesc->rcd.tcp || gdesc->rcd.udp) &&
>  				     !(le32_to_cpu(gdesc->dword[0]) &
> @@ -1465,6 +1466,7 @@ vmxnet3_rx_csum(struct vmxnet3_adapter *adapter,
>  			if ((le32_to_cpu(gdesc->dword[0]) &
>  				     (1UL << VMXNET3_RCD_HDR_INNER_SHIFT))) {
>  				skb->csum_level = 1;
> +				skb->encapsulation = 1;

IIRC ->encapsulation means that ->inner.. fields are valid, no?
And I don't see you setting any of these.

Paolo, please keep me honest, IIUC you have very recent and very
relevant experience with virtio.

