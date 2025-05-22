Return-Path: <netdev+bounces-192859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BE0AC163B
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 23:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5BC3AD73D
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 21:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F3F25A339;
	Thu, 22 May 2025 21:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+j4D+Vk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC43325A329;
	Thu, 22 May 2025 21:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747950639; cv=none; b=OInGNuHvoMZRrrtmWgxkf9/kuZfoDPhosqako+mEvRxtOqF4w7vV8RVsV8ZSQfcQ8AvGKgc6Kn8EcMot486+RkabWAT0JcHkz3eVl7sMY0FwRgtiWospETbHiA5KAgm396+oNo0WwLHgdCsdRXkoCfZFLkJq8TKjx+VQS4/Lkvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747950639; c=relaxed/simple;
	bh=YsEX8iJmRXHLOWQa2eCkZ0fQ3VoXQ18HSFk8v3HdH8E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1DMixAayTGn8dNy4WwDr4Bnjv1wcKqOMkB2SiUvdPuCILtBA1eXJtGKNB54fM3p53J0R3AdXVt8jRLkZU6Joz43HCNmumINs9V5RzjFF023flbqetCT4ewY00sY39UfzLxNf8irN1GR0qfQVce1mXwbjfV7Xfa25fpXQd8li5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+j4D+Vk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE499C4CEE4;
	Thu, 22 May 2025 21:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747950638;
	bh=YsEX8iJmRXHLOWQa2eCkZ0fQ3VoXQ18HSFk8v3HdH8E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J+j4D+Vk89zgD7OQl6PdrCkqLp1x2uM0o4eudzawyPSsfUXmoYhCHBT4E2yCKuO3L
	 8yrIIFuowRAMRh8BzQw4wcAZ+ujvzIDxTX65XqSq/BwQEmjtr2GM2x8c/D4L6S93vD
	 gKYbj6o6e62HQW82ktcMy5eBXCZtSeP/nOGaGfT/NahnSpk74Z2SyxfKDfBcOmqAbX
	 yZkVURMcC+7n1AxnO9kpFxYkX5ETonmAcXo1HiF7TtKq41fR0vgLiP2WgFDYETNyNY
	 aSMXuJrDwXu/BTlfLCdxg7+YBvlsO21i+rYaHI7TKVGHoMblz7ZhPKQ5fhmf3MfOzh
	 OCk1cWdg74sEg==
Date: Thu, 22 May 2025 14:50:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, yangbo.lu@nxp.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ptp: remove ptp->n_vclocks check logic in
 ptp_vclock_in_use()
Message-ID: <20250522145037.4715a643@kernel.org>
In-Reply-To: <20250520160717.7350-1-aha310510@gmail.com>
References: <20250520160717.7350-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 May 2025 01:07:17 +0900 Jeongjun Park wrote:
> The reason why this is appropriate is that any path that uses
> ptp->n_vclocks must unconditionally check if ptp->n_vclocks is greater
> than 0 before unregistering vclocks, and all functions are already
> written this way. And in the function that uses ptp->n_vclocks, we
> already get ptp->n_vclocks_mux before unregistering vclocks.

What about ptp_clock_freerun()? We seem to call it for clock ops
like settime and it does not check n_vclocks.

> Therefore, we need to remove the redundant check for ptp->n_vclocks in
> ptp_vclock_in_use() to prevent recursive locking.

IIUC lockdep is complaining that we are trying to lock the vclock's
n_vclocks_mux, while we already hold that lock for the real clock's
instance. It doesn't understand that the two are in a fixed hierarchy
so the deadlock is not possible.

If my understanding is correct could you please clearly state in the
commit message that this is a false positive? And if so isn't a better
fix to _move_ the !ptp->is_virtual_clock check before the lock in
ptp_vclock_in_use()? that way we preserve current behavior for real
clocks, but vclocks can return early and avoid confusing lockdep?
-- 
pw-bot: cr

