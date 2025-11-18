Return-Path: <netdev+bounces-239281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70892C669FC
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 01:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2620C34FC19
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A1754652;
	Tue, 18 Nov 2025 00:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7zj6KuA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0037114A8B
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 00:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763424650; cv=none; b=RjF6InqWRvJXhENchGA7teJw3yTLwHDKtfUI1TDQbafVaZOxHw4iaKHWb0myhGmHFtgE31VdkcWBpAIPNx8t3zHBFPl5YIqPzaD8wpTJgYONjWPePB/OjRQukprEpDlQeLmGSV8rMcr0FvXeNDzHOoVLbB04Gz/C6udvNO0Nkgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763424650; c=relaxed/simple;
	bh=k/iOsbzQZyYAaHy0DymPB3JsA1vUj+SNK6O3heZQETo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8H3zzK5yTu6x4pcM3CZK+ckbYsTacD20t1pVzAJBIMd/D9+g27YtuF+6FvrtlR/P9gmHa7H3aiC29oJ8Qvjas25sGPF0ItVI1dTfXfHLc6GoDYclMA75gBWsxKhvXdC8wNrFbj2pZYeDxCz/3I1D2cMTuImiaVKS/mT6CrHNZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7zj6KuA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B202FC4AF0B;
	Tue, 18 Nov 2025 00:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763424648;
	bh=k/iOsbzQZyYAaHy0DymPB3JsA1vUj+SNK6O3heZQETo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q7zj6KuAfTnkf+RUZ/EbC4WsRNakmzG2pRiIFcqt74N6i+d1MCEl/0Y1GxQ1MSchm
	 GwiyZVgrVKZ1ratyIKLFMrBVdFK0ohJM41yoO8kBkkzqHxL4Kfi5IB0XLP9wlz99zR
	 5WdISp1ebfBBb6iK1VaNAPyOwUmb4uEJAboekA0H0e2gmQjBy+VMO/aXfzpddlLiO1
	 G8XqyeIFexOPllBFcwJG6YkTOGvjabDFfBeu/pQ2Lb7ZQb5o8nOpnFMRFKe275TKEr
	 xyAU8xPQUtyKEhvtdGdLex18sbFNZD21uTx4SjgFi/eWl8qaHmkvf7MRsd9n8SASM5
	 gSF8KLEanjANA==
Date: Mon, 17 Nov 2025 16:10:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marek Mietus <mmietus97@yahoo.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org, pabeni@redhat.com,
 davem@davemloft.net
Subject: Re: [PATCH net-next v4 02/14] net: skb: use dstref for storing dst
 entry
Message-ID: <20251117161045.10c9c7bd@kernel.org>
In-Reply-To: <39fbfcb8-20a4-4693-af24-ea59a726bbec@yahoo.com>
References: <20251112072720.5076-1-mmietus97@yahoo.com>
	<20251112072720.5076-3-mmietus97@yahoo.com>
	<aRS_SEUbglrR_MeX@krikkit>
	<5af3e1bd-6b20-432b-8223-9302a8f9fe44@yahoo.com>
	<CANn89i+qce6WJYUpjH93SMRKA8cQ6Wt-b81O6gu9V5GGnDeo_A@mail.gmail.com>
	<aRYgtN-nToS4MQ3r@krikkit>
	<39fbfcb8-20a4-4693-af24-ea59a726bbec@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Nov 2025 12:31:00 +0100 Marek Mietus wrote:
> > But IMO Jakub's comment about technical debt is not addressed by
> > pushing dstref all over the tunnel code.
> 
> I understood it differently. I thought the aforementioned debt referred
> to maintaining two different APIs that accomplish the same result, which
> is why I took the time to replace all callers in all of the tunnels to use
> the new API, and removed the old API. Maybe Jakub can clarify.

True, my direct complaint was about only converting a subset of tunnels.
But as Eric said you seem to have gone too far in the opposite direction
now :(

