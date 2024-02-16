Return-Path: <netdev+bounces-72232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2357A857260
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 01:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76529B22462
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 00:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CC6170;
	Fri, 16 Feb 2024 00:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRVAiIaM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C9628F1;
	Fri, 16 Feb 2024 00:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708042684; cv=none; b=Y+aOZ0dS0SliFQ4/tO85fMcbvoyfJ1p7QZohRf3/prvClhlR+NZlGGNAnisMZ0o+XRbT6GpYxQooXX+q3UhrDTx1f5is5IhbTnR7DM95AYzE32GgWtCoJW6lIfo8nofXbmugSDrOC5QeuOCwiXQUk36ECGOOVZiutDzMPWzv0F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708042684; c=relaxed/simple;
	bh=4PbgQsfGQ3x3R7D6HGJW1HkpIAtBaVUF/26+mLivtJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+QfkdvjySatCw9FZdc081cjUpFm39wDVqqNvtH98rfFgLNwzG/EqQP3rcg2d1bQAxDDEdfAfRndKeFllIGADPrZRY7k+PkNUfKU2JF5cXlOSdHSGq51JABf4tUPTClcKSgznnkki29UT54sa8KOYIFe0RIMTKUOP3SQLYnrY58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRVAiIaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5477C433C7;
	Fri, 16 Feb 2024 00:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708042684;
	bh=4PbgQsfGQ3x3R7D6HGJW1HkpIAtBaVUF/26+mLivtJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nRVAiIaM0fl19nBK+PivSO4b9I0/DsU1tb56IZkDp3wFnNNFjbTuE6fk3QlKjWCY7
	 7OII8D0Vhn5Vqa2HGcQHnvznDrzNGJxTchQtTkO7gpQIRLI7uJjnw8J+EZG8juLLBo
	 cRD7IzpBCNPwYH4wAOOS02RxE1lVWlHa6zahuD1PO6K+DSHcRvsm/MshUAqoXX1aa1
	 rGqvc0EdIZ3FMHoyDXFT6xBBXwkaTarDB0s2X8xm9WV+vCT8zwnqtIStZkId7FFpIg
	 x/P90r6wR5Nd6A3IOPI/252STNJVRaqTXDRWi/iS48/CFVR+4T4qA4eAYnzSHLORyo
	 st2J7UtkRaklA==
Date: Thu, 15 Feb 2024 16:18:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rand Deeb <rand.sec96@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, deeb.rand@confident.ru,
 lvc-project@linuxtesting.org, voskresenski.stanislav@confident.ru
Subject: Re: [PATCH] dl2k: Fix potential NULL pointer dereference in
 receive_packet()
Message-ID: <20240215161802.73c0ece3@kernel.org>
In-Reply-To: <CAN8dotmVcmpqxO0SyPvit20Ny-tU3OMHr0LLoXRQ3bpPTS5WqA@mail.gmail.com>
References: <20240213200900.41722-1-rand.sec96@gmail.com>
	<20240214170203.5bf20e2d@kernel.org>
	<CAN8dotmVcmpqxO0SyPvit20Ny-tU3OMHr0LLoXRQ3bpPTS5WqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 02:32:54 +0300 Rand Deeb wrote:
> Regarding your comment on using `(!skb)` instead of `(skb == NULL)`, I
> understand that `(!skb)` is more common and is also recommended by `
> checkpatch.pl`. However, I chose to keep the original code style and logic
> to maintain consistency and avoid confusion, especially for other
> developers who might be familiar with the existing format. The same
> applies to the `printk` statement. In the same function, there is an exact
> block of code used; should I fix it too?

Don't worry about surrounding code if it's written in a clearly
outdated style.

If the style is different intentionally, that's different, but
for old code using more modern style helps bring the code base
forward little by little.

