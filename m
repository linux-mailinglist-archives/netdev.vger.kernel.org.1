Return-Path: <netdev+bounces-218857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 193ABB3EDF8
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F14E1A8551A
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 18:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38B7324B25;
	Mon,  1 Sep 2025 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLR//H/P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A811521B195;
	Mon,  1 Sep 2025 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756751998; cv=none; b=sMhfP73kzKMEPnwxEpH3t+mlSPhSTcMgPsa4BrX/9ZiGwUd9UeAEzyo/M1IjSPJIpQsUbAsGEkz0YV7uXvYdHZPNYNYi9JbQe4UCSvBQGIumJj6G93kQjUunfPTJv1VN2kuRZEFeq2c6frDOxlWT/Xp/Mqt8LGL4pu+0ycFY4pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756751998; c=relaxed/simple;
	bh=hTalmf3FxSTJ4/XJJAwc4bWVa8A9jMCmVmNjtccJ3w4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qGRSCsthGr2S4Xr4iFkk0SlnnkOQlbCIQe+ibMtJjt8iYfSPKmatC2Pqc4syAuTfa1FonEIluL0BQekWJH1dMtyeaMK0LzlcrLeTVz2QI0m9B0NvyAVfQuBtLPxHsVE17UVttbP4V0JlY/5T9mDSbWS0xefj9VItUTNynMm1a2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLR//H/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8837AC4CEF0;
	Mon,  1 Sep 2025 18:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756751998;
	bh=hTalmf3FxSTJ4/XJJAwc4bWVa8A9jMCmVmNjtccJ3w4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XLR//H/PFe9BfF4ZvtaoozkUIs9ZCLZiXesyaj7AcTILECR/e8blAQhj9dUJ4jXmG
	 U/qOb1kuK0llCNjbjKdNUhuScVlCGqE6VR5yfIZ7xyYBrc6h0EKD6NPt0jWC5jGHnR
	 VFaB1rLIfWfkMXXY6UOuhJEXA3Li3nl1YgCqNeapLL1wQmKKuEpnkxUGG7OcdELIUy
	 HpzwxwupP0WOyvwiUGhIWc8v+9lSnfdwahwU6g87lWholwOFbVX5rnqRObmFtzWkqw
	 sWxoauNxN7uvjrA0fn2vYE59mKKnzyfVuKhsuCu9uN9Uv5Uf8h7VQtLz9X+9Tij5Vm
	 nDMOhuwzQ36oQ==
Date: Mon, 1 Sep 2025 11:39:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: chuck.lever@oracle.com, kernel-tls-handshake@lists.linux.dev,
 donald.hunter@gmail.com, edumazet@google.com, horms@kernel.org,
 hare@kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, wilfred.mallawa@wdc.com, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH] net/tls: allow limiting maximum record size
Message-ID: <20250901113844.339aa80d@kernel.org>
In-Reply-To: <20250901053618.103198-2-wilfred.opensource@gmail.com>
References: <20250901053618.103198-2-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Sep 2025 15:36:19 +1000 Wilfred Mallawa wrote:
> During a handshake, an endpoint may specify a maximum record size limit.
> Currently, the kernel defaults to TLS_MAX_PAYLOAD_SIZE (16KB) for the
> maximum record size. Meaning that, the outgoing records from the kernel
> can exceed a lower size negotiated during the handshake. In such a case,
> the TLS endpoint must send a fatal "record_overflow" alert [1], and
> thus the record is discarded.
> 
> Upcoming Western Digital NVMe-TCP hardware controllers implement TLS
> support. For these devices, supporting TLS record size negotiation is
> necessary because the maximum TLS record size supported by the controller
> is less than the default 16KB currently used by the kernel.
> 
> This patch adds support for retrieving the negotiated record size limit
> during a handshake, and enforcing it at the TLS layer such that outgoing
> records are no larger than the size negotiated. This patch depends on
> the respective userspace support in tlshd [2] and GnuTLS [3].

I don't get why you are putting this in the handshake handling code.
Add a TLS setsockopt, why any TLS socket can use, whether the socket 
is opened by the kernel or user. GnuTLS can call it directly before 
it returns the socket to kernel ownership.

I feel like I already commented to this effect. If you don't understand
comments from the maintainers - ask for clarifications.

