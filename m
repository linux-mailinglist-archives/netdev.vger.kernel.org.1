Return-Path: <netdev+bounces-232733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61654C08644
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 02:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EFB9400656
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 00:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53956F06A;
	Sat, 25 Oct 2025 00:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvjSGeHh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808DD13AF2
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 00:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761351891; cv=none; b=N2ROMzzFJjpb3KTHCcphDlY+Jxr5dIuVBwDH51Bwe5epHCrap12wbQEJdMrTxkYGGiWBwcVtZrMdrgrcSQer7vjl8sQEU6ki8NeC+0CmQFSOUnazNDmz3q1fluCsuBmR3g7yUkqdP2C36IqmExUTaQZqhb4PhtQ+bjT0rGLV0fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761351891; c=relaxed/simple;
	bh=92SDw0dbnGSJRQRJPh0ru3LQk8s1jsnrX92IFLKqQbU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gt8cQE1MK3y+SrVttF5XvmzyIjT7pmie73qEPH2X8i6ybqHXe7hTJ6eBJ2tqTkwfTB9vpci9Pr4emPCHQpa0atADbPETbE6nH/G4fgSxUycQMl9Bqcrbs61qSeyGapg4W4xmye29RT9Ht/5wWcy7T7dhL3gamp0nLGyex18AGKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvjSGeHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BEDC4CEF1;
	Sat, 25 Oct 2025 00:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761351891;
	bh=92SDw0dbnGSJRQRJPh0ru3LQk8s1jsnrX92IFLKqQbU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uvjSGeHhI1DabbFVd7vHkJviLlmaZLGoxIEWVvMWrFYt5/6fzPLwdpXSqCdc3pTMb
	 8hgW77xRfGUG7tzZ5duZWpWN3E1cX2Md4gVeUWw83fpNl6Xjl1F6ZjhrAEZKGOm2u4
	 Kxd3U/L/orrX15QbTaE8SSKnGjOzaPbkKToqJWaC9vXUiWBcYJPGsn07FzrHv2P4Gn
	 xiamNQH7xGhmW0yJj2xPS6B4jMcdCCXs7PWohOIcPsvlYEBB58RjQ3An5QM653dtLI
	 A0crMcup+Ve1FjpTSRwIpLhsu5u1Z/cVE8uHdgXdfGcV9B2tw7af4erWJslGhKNkSN
	 KbOmvKhv4gcAA==
Date: Fri, 24 Oct 2025 17:24:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net v2 1/2] net: ip: add drop reasons when handling ip
 fragments
Message-ID: <20251024172449.59d14f9f@kernel.org>
In-Reply-To: <1761301212-34487-2-git-send-email-liyonglong@chinatelecom.cn>
References: <1761301212-34487-1-git-send-email-liyonglong@chinatelecom.cn>
	<1761301212-34487-2-git-send-email-liyonglong@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Oct 2025 18:20:11 +0800 Yonglong Li wrote:
> Subject: [PATCH net v2 1/2] net: ip: add drop reasons when handling ip fragments

net-next, please read the whole doc Eric linked

> 1, add new drop reason FRAG_FAILED/FRAG_OUTPUT_FAILED
> 2, use drop reasons in ip_fragment

Personally IDK if this is sufficiently semantically significant
to warrant merging. FRAG_FAILED means "unidentified error during
fragmentation"? ip_frag_next() only returns -ENOMEM and
SKB_DROP_REASON_NOMEM already exists, so just use that.

FRAG_OUTPUT_FAILED means something failed in output so it'd be more
meaningful to figure out what failed there, instead of adding 
a bunch of ${CALLER}_OUTPUT_FAILED

