Return-Path: <netdev+bounces-244569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D26EECB9FD3
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 23:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9316930361D9
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 22:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7420C2DA762;
	Fri, 12 Dec 2025 22:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHPCMHnc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC2E25F96D;
	Fri, 12 Dec 2025 22:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765579833; cv=none; b=YyWnZ340Vw5klNbpq8ui62fBboBsQX5KjBRnH7Rnr7se0jvInZ29E0wDRP74V96GoUXsKnJAo15SCZMoOsh+uOlWqSvqF0RD7iDG2leQmGcTRCfxg6MVjhHzyXCj4TGxaaKxj86VrHhxz6pdUbs80C6JjVZT8oTM5vDeTKZNxq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765579833; c=relaxed/simple;
	bh=K3OUR/kNXzqGUHaKdtKMqclLlrFTdQ9fQxwZ4t7N58U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aGIZlMMHvEEcDR6u56+5Q4TE1bHjeLT1IRenUTCUqWbElJiRAY5NMbVuGgdslfDIyfAQVcv/x6wUjE8RHkXIeqYP1Zpp7yK0ifO+HbOf/8lgAvEcr0ozuA2YwBuPEDUcO5NSOJrCR3jtWKN14IM42wWTci2Wqvq0A6cRnJWVjOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHPCMHnc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39550C4CEF1;
	Fri, 12 Dec 2025 22:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765579832;
	bh=K3OUR/kNXzqGUHaKdtKMqclLlrFTdQ9fQxwZ4t7N58U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cHPCMHncLJ+Uo7qbmB3RieIgY2KGWzkaABnfY4nG6znvsoPad9ExIFvXZ4wfulcgV
	 qh8W84rkvRX/NTz6e9LwYxQL/X0zlOu8THNrQWCyn28cfuDFHy3kO9AmGVeHCo5+5V
	 2yCmZ/ADFEFu84fcjU09EErMSFXZBUbdPq+CL2+W15IlhGIv2XbSINt+Z2u3rWVsdM
	 Pjq83u8WlWa8K/SyqsO60K6i38DSjKiVhOKQoznD7mUKmmwF4OniF5tiw00wPeIvBj
	 D9IhtbVbw4rUqYG0GbZOkQWNJvnSv/XZOpBr7Mq1J1+WQV0SYinjKPjSeA0NQp1RQl
	 H/kUJKiMZwEhA==
Date: Sat, 13 Dec 2025 07:50:28 +0900
From: Jakub Kicinski <kuba@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: Richard Cochran <richardcochran@gmail.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/2] ptp: introduce Alibaba CIPU PHC driver
Message-ID: <20251213075028.2f570f23@kernel.org>
In-Reply-To: <c92b47cf-3da0-446d-8b8f-674830256143@linux.alibaba.com>
References: <20251030121314.56729-1-guwen@linux.alibaba.com>
	<20251030121314.56729-2-guwen@linux.alibaba.com>
	<20251031165820.70353b68@kernel.org>
	<8a74f801-1de5-4a1d-adc7-66a91221485d@linux.alibaba.com>
	<20251105162429.37127978@kernel.org>
	<34b30157-6d67-46ec-abde-da9087fbf318@linux.alibaba.com>
	<20251127083610.6b66a728@kernel.org>
	<f2afb292-287e-4f2f-b131-50a1650bbb1d@linux.alibaba.com>
	<20251128102437.7657f88f@kernel.org>
	<9a75e3b2-4d1c-4911-81e4-cab988c24b77@linux.alibaba.com>
	<c92b47cf-3da0-446d-8b8f-674830256143@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Dec 2025 14:50:13 +0800 Wen Gu wrote:
> Given that net-next is closed and the EOY break is here, I was wondering
> whether the review discussion might continue during this period or should
> wait until after the break.

This is a somewhat frustrating thing to hear. My position is that
net-next is not the right home for this work, so its status should 
be irrelevant.

