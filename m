Return-Path: <netdev+bounces-230636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54189BEC15A
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 02:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA83407A13
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 00:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD21211F;
	Sat, 18 Oct 2025 00:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bp/2Vy3l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35EB3C38;
	Sat, 18 Oct 2025 00:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760746027; cv=none; b=cy3MlLB4911Ct48icrqBE76cajPBo2XsUc4B+an9lJ9QQW4kbu+wYflO8sYGp5onUiVMizjE3W87CWifuPeX3BoCRFEIGh5AF++gBwK8Rl4Wxd4b3hHYUvHRYM3ofjdDBj3xE1/vkLwPdYWpGMm2HKz71L/eoa5i1sTzIIoY4yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760746027; c=relaxed/simple;
	bh=gPSNbnjBtOCUa5ln4W2zbljLfIvxRxCkd4IVH6e8Q0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UC5GKC0WU5Obo9tQ6uuZAPgubJv9KkiPip+RSJStozNwF+KLqzX6yqICEV7G3PUXNXswdn/rZHUbgGLAK1uJR6SYWmtQFvk+FJc4MQQjKiu5ClSJRqzXsZ7CCt96OMEDgSKcWhBZJa5/zwTWm8Z2M2MjBjwUcxZOI7CETbCSJQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bp/2Vy3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0569AC4CEE7;
	Sat, 18 Oct 2025 00:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760746024;
	bh=gPSNbnjBtOCUa5ln4W2zbljLfIvxRxCkd4IVH6e8Q0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bp/2Vy3l9h80sMSvacC4USqL24noFTC5hvvOO3FjJPewnWsL+6GIrkoJGSObEtreZ
	 bPq2nui9460sv7olanEV+GYIFhfz/Y79VfPZbUOcLU14SeiZaCexRPfjkS6ksjk8Jq
	 YfxffmLYPaPfqhQ6f2eAWeYkgwAPRwoaR5AUkLHbxxdEmx9QFz5WOENR92B5UXlow1
	 sEAQo6lofOE8MbVuKNnvagfygZrstiinunaeg2XjHAyblxgGgRdNfMzFuk/vkLR+By
	 UrxtkSXlOnOVJjDSuCA1As2/xO8+ZdpReTfjLadTv0Y577e954bETGeMtrdn2rcLq0
	 Nmh/jAakh5Gxg==
Date: Fri, 17 Oct 2025 17:07:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dong Yibo <dong100@mucse.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, andrew+netdev@lunn.ch,
 danishanwar@ti.com, vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v14 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <20251017170703.3c2dba37@kernel.org>
In-Reply-To: <20251014072711.13448-4-dong100@mucse.com>
References: <20251014072711.13448-1-dong100@mucse.com>
	<20251014072711.13448-4-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 15:27:09 +0800 Dong Yibo wrote:
> +struct mucse_mbx_stats {
> +	u32 msgs_tx; /* Number of messages sent from PF to fw */
> +	u32 msgs_rx; /* Number of messages received from fw to PF */
> +	u32 acks; /* Number of ACKs received from firmware */
> +	u32 reqs; /* Number of requests sent to firmware */
> +};

Probably no point adding these stats until you can expose them to the
user..

