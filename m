Return-Path: <netdev+bounces-209434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D92B0F905
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D293586243
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C70C21CA1E;
	Wed, 23 Jul 2025 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIyuol24"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EEE21ABC1
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 17:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291803; cv=none; b=P7rgpb0fOaxLy6dIDnNYkHkWY3GTU7XDpuEDgtG01MQtSjkmqsAPWDYNQklG/YQUbLnmEU2pci9b71OcCZo9JXP9bV/sGh7UR0OO+Pgc7gLSumx1A2KHtQMhca31IYZ+XATxv7t2bp79REtnBVLoQd3SBNrsPU5cGKzzOj/S+bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291803; c=relaxed/simple;
	bh=6Il1/NREKeYW4tkzuLCF2BvgGkU+nTorZoaA9GIKNAM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F9wgQzvC4qja2oYw764m0pr3ydooiYa+kI+IAi/zy2KNNLdLB51LrKmbfYMRD66H+ZXOfgMIF9zAj4mMq0Hm358h331p/THfgpmlYe6kQbpOOfWyHqIZWrBVMq3YUm3yUOrCumsoqGYLaXBF7PkOk3lTfkQbdKyBvJd1I6evMsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIyuol24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDB9C4CEE7;
	Wed, 23 Jul 2025 17:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753291802;
	bh=6Il1/NREKeYW4tkzuLCF2BvgGkU+nTorZoaA9GIKNAM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VIyuol2477JFGlMfkU8HZXU2s8Ur2LaMghw5WrcmU9IPCMjvnl+FccwOMZNLeZcxF
	 CwC3cVtc7JOAtY+4ZlsF3RKK8Isa2N2Z5q4rNl6iEU2Dfu+NVU35rlGd5FgzyxBrH4
	 IpDtg4wXOQ0aHhXz3YxrG6SI1gEcg/A95mngpN1zakAFPo5AbXt+vdzmXaTbBsRgBy
	 D4Q/MIMhG3L6AfBR9Uj+vHBl8hdsfag6752G2J7J0J90E93wRhBWpFifGXpfxOSVL/
	 wWRug95gda4rv28dWz6HwTVeR4fpfJskR4LYk5wvOXkPZ/HfxR6hBxeJeoUK3o0sv0
	 lzpaaITTuQBxg==
Date: Wed, 23 Jul 2025 10:30:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, pavan.chebbi@broadcom.com, gal@nvidia.com,
 andrew@lunn.ch, willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next v2 3/4] eth: bnxt: support RSS on IPv6 Flow
 Label
Message-ID: <20250723103001.79eb35fa@kernel.org>
In-Reply-To: <CACKFLi=EdZ1zisGZHZYQzqttQZx+8-vnoq5==mD98Tv80d1qxA@mail.gmail.com>
References: <20250722014915.3365370-1-kuba@kernel.org>
	<20250722014915.3365370-4-kuba@kernel.org>
	<CACKFLi=EdZ1zisGZHZYQzqttQZx+8-vnoq5==mD98Tv80d1qxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 00:57:14 -0700 Michael Chan wrote:
> Here, it needs to be something like this so that we only set the flag
> for 2-tuple or 3-tuple.  The FW call will fail if both flags are set:
> 
> if (!tuple || tuple == 2)
>         rss_hash_cfg &= ~VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6;
> if (tuple == 2) {
>         if (cmd->data & RXH_IP6_FL)
>                 rss_hash_cfg |=
>                         VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6_FLOW_LABEL;
>         else
>                 rss_hash_cfg |= VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6;
> }

Thanks for the help! Thinking thru this carefully I'm worried this will
leave the FLOW_LABEL bit in place if we switch from FL to 4-tuple.
Tho, I'm not clear on how 0-tuple to 4-tuple switch works at present.

Would this look good to you?

	case TCP_V6_FLOW:
	case UDP_V6_FLOW:
	case SCTP_V6_FLOW:
	case AH_ESP_V6_FLOW:
	case AH_V6_FLOW:
	case ESP_V6_FLOW:
	case IPV6_FLOW:
		rss_hash_cfg &= ~(VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6 |
				  VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6_FLOW_LABEL);
		if (!tuple)
			break;
		if (cmd->data & RXH_IP6_FL)
			rss_hash_cfg |=
				VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6_FLOW_LABEL;
		else
			rss_hash_cfg |= VNIC_RSS_CFG_REQ_HASH_TYPE_IPV6;
		break;

or should the else branch have 

	else if (tuple == 2)

?

