Return-Path: <netdev+bounces-193727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D63AC582F
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 19:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 422337ADBFB
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 17:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AAD27D786;
	Tue, 27 May 2025 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuD9k6Uf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3C342A9B;
	Tue, 27 May 2025 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367724; cv=none; b=L56tdBhPEKBRdtqVsymk4OFwujEmTgdaqI2uoJVdJ5pGIRZE1x4AQTq5mBgY9QyfWrDIEOjLFiTxlzqBAPNVkNqu9qgj+UB8zCGxXRkUN6AsvAD6CZVq60Gb0XQ1cbm9rUwQOSRyHa71VKiBSR77Z05ks1Qm9S9FB4cZCbgSFqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367724; c=relaxed/simple;
	bh=bKGnwor4FFrnBW7SQUQtkeTFuC79AM3NHWJjxMW/tuw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BwBcL2Ygdl9bZ6woss0UiObzJUbZoOsb5a2VYVURuTXlr4DJrZmxjFrnrhs5ENizV7oOGlZlhrUUOa0D8Ck5vkhIM/qZA7VTkrqPikOVn/24h0o+QHexMq0Bb927fCN/0N4IPEqsLdkMPXAM70oa+6I4MwYPaQGKFSSN99b/1lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuD9k6Uf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E867C4CEE9;
	Tue, 27 May 2025 17:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748367723;
	bh=bKGnwor4FFrnBW7SQUQtkeTFuC79AM3NHWJjxMW/tuw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SuD9k6UfXUCk5S4dotzHJQbUlwIpoPdSQarz5o4a/rjYC2RKQyYXk8BK6idjNheaj
	 IME6I08W451JW7WqdpGUpvCU7D85xSAZEu7dHAykUNo1123ILOOD0Zi+yIC4eL+j+k
	 A4jcnaP8fNEfeFYxYZy9do5rzd/juPRYqJftf6QRB6vB//Y1uXTcWVRkFMFzHqQ9Xk
	 AFKVYsYac2FnC19Y/LfsOlM2IxxaPZNdp2rqPnl+tnmnadXWlYmXIcEdUvkuMkLTkK
	 KqEeWt6P3GxJkjIm97IslhryEtEvy7WnYQDKA6h4JUFY+xKMh9tNKqrnRM5KmjMgCD
	 sOfrjsklGwndQ==
Date: Tue, 27 May 2025 10:42:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, yangbo.lu@nxp.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ptp: remove ptp->n_vclocks check logic in
 ptp_vclock_in_use()
Message-ID: <20250527104202.7fbb916c@kernel.org>
In-Reply-To: <CAO9qdTHuDb9Uqu3zqjnV6PdX9ExWv24Q9_JfQ8FbKigipDrN+Q@mail.gmail.com>
References: <20250520160717.7350-1-aha310510@gmail.com>
	<20250522145037.4715a643@kernel.org>
	<CAO9qdTHuDb9Uqu3zqjnV6PdX9ExWv24Q9_JfQ8FbKigipDrN+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 May 2025 20:00:53 +0900 Jeongjun Park wrote:
> If you need to check n_vclocks when checking
> whether ptp virtual clock is in use, it means that caller function has
> already performed work related to n_vclocks, and in this case, it is
> appropriate to perform n_vclocks check and n_vclocks_mux lock in caller
> function.

Can you be a little less abstract in this explanation, given that
ptp_vclock_in_use() only has a handful of callers?
For ptp_clock_freerun() do you mean the ->has_cycles check?

