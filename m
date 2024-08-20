Return-Path: <netdev+bounces-119966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9446957AF9
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 03:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DABB31C22D68
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 01:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3C912E71;
	Tue, 20 Aug 2024 01:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaKRNBAK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9326F2E405;
	Tue, 20 Aug 2024 01:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724117443; cv=none; b=BqB8hIJvwcf3h514bxVUq1KL/iMYE/h8pSrlDDaXFp0KXLeuV9qRwDFHPHgkTrkNoK0S5cFFNT3O5Fk6W3dKAfoC5wXxI43OqW4/fmBPNTqJEn1Fnd2ACeflahxVTrVQnYeBCpbUqACx1/QhKtLmmfzgKb6e8E+vdJNFWyta9BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724117443; c=relaxed/simple;
	bh=Yr+3Isy3zlBM+gRcVbOEwYmbxCbZ9TlULM7aDsDTb7c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ni8YAaEjMKbacmtGIbNff9dHo5ZUF2G+x9wyXj8HyhxI5P+QaidDM72Ae22sBknP1sOEoK/9MWSrPRbyHjeRR5JmbnilvU7mWJGU4oG05iKubvnQEf8RRXI5uKwfOBD8aLmoyGNni+P7sljBzu7jxDPuZD6V99q/ce+M7nuSy78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaKRNBAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A81C32782;
	Tue, 20 Aug 2024 01:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724117443;
	bh=Yr+3Isy3zlBM+gRcVbOEwYmbxCbZ9TlULM7aDsDTb7c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DaKRNBAKEr5IcCQ8bXseEj0SW1YW6WNw7jj5h/gw+ovFFGaKOKShsR1Rh8RPYsoFX
	 8RNyBznmnC/kDtpSYGIpRRVuAyWdDElweKQdoCuWFGDh/wynEIET4+h8pitcR5FI1i
	 mck6Sol6X3MWeQdC88/G8VowkVci13/a5HghFvhBsvBpYIjuRwEWXvaAacXqRSTzBg
	 31l7NpGXUYwR+z1EMLNX7mTEBxWQMXmYwzLIw449HCw1yiX5/YAt1RQ5W3qaHPXxv2
	 kS9QUICsGT2vUOUnuEA5tu50HdfdxMcsSDe+bAmRFekK3JdUN3MCazgRtCHw8ImBMo
	 PvePUyfnb28OQ==
Date: Mon, 19 Aug 2024 18:30:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Andrew
 Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org, Michal Simek
 <michal.simek@amd.com>, Daniel Borkmann <daniel@iogearbox.net>,
 linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v2 1/5] net: xilinx: axienet: Always disable
 promiscuous mode
Message-ID: <20240819183041.2b985755@kernel.org>
In-Reply-To: <20240815193614.4120810-2-sean.anderson@linux.dev>
References: <20240815193614.4120810-1-sean.anderson@linux.dev>
	<20240815193614.4120810-2-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 15:36:10 -0400 Sean Anderson wrote:
> If promiscuous mode is disabled when there are fewer than four multicast
> addresses, then it will to be reflected in the hardware. Fix this by

it will *not* be reflected?
Something is off with this commit messages, or at least I can't parse

> always clearing the promiscuous mode flag even when we program multicast
> addresses.
> 
> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")

I think we should ship it as a fix to net?

