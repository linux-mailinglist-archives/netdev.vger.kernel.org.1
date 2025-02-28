Return-Path: <netdev+bounces-170874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC508A4A5E9
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 23:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090701899CE4
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 22:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899A21DE4F1;
	Fri, 28 Feb 2025 22:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/z8Ds7/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655DB1DE4C7
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 22:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781698; cv=none; b=KfEkRAKQMAgB+MxD20bH8zacupQZ0btX2uXIhScBoCDrsZdllM5LGeC15LauglaumWtip9UvLuIWitFGirNegSaUJHhvBWRQi32dDqDvdmUGoGrwvzGtwcIIO/k3iIeiJ0aFaHRzGS9mURG36Dxg1/zWa9bmdsun/1cB65KOAaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781698; c=relaxed/simple;
	bh=9/Hlf9sufrSSecR3DLLPnB/RAXtQUhkzzAqfIbGJ2mg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=je+6rcK3tQKANe9r6nay9QaksiXwYrMKgrpZiBy9P9mTzpe8h2wxz6stpNJUUspAZPlxIjWTxg7D3T+qp01ruCrVLswXvuKR7ERVb1hkf04rF1Opnrj6wTvoL4f+BYfXfDYDn+nEM4yxMxDT2D562JimCWKaA/aSZwk27NjNMUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/z8Ds7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825EAC4CED6;
	Fri, 28 Feb 2025 22:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740781697;
	bh=9/Hlf9sufrSSecR3DLLPnB/RAXtQUhkzzAqfIbGJ2mg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a/z8Ds7/Pq1vvnYhU32EmHhUrOJz8cMQt/jOu0FxBfXMVhqx57zIeRvvS+hJb7bmF
	 Hb3x3P9f66qzOcMsDJTCB6gZOR/X7GOkTuQymZbiJ0x/8QxJM2AnXszoQmJankzvlH
	 COBjeTSPR7Y8bhOojvmP1YsIdrokLTO0OyTeB6/NcgkYL7wKDL1VDADvymxgVxDADa
	 gnVhm30fbC/aIZFtIg1ZlcfeAvdSCTLxZ1nPmhBqifpyWciKNp55xISyf6MihKGMhX
	 uHMx0Mdoc9n4gvu4aZwlDaiz+1F6RZPYko3xBkM5sm+ijRTwUbb2u/prCwmO51jDyX
	 9QKckA6VyJyiQ==
Date: Fri, 28 Feb 2025 14:28:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 2/6] tcp: add four drop reasons to
 tcp_check_req()
Message-ID: <20250228142816.3077420d@kernel.org>
In-Reply-To: <20250228132248.25899-3-edumazet@google.com>
References: <20250228132248.25899-1-edumazet@google.com>
	<20250228132248.25899-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Feb 2025 13:22:44 +0000 Eric Dumazet wrote:
> +	/** @SKB_DROP_TCP_REASON_LISTEN_OVERFLOW: listener queue full. */
> +	     SKB_DROP_REASON_TCP_LISTEN_OVERFLOW,

nit: TCP_REASON vs REASON_TCP
-- 
pw-bot: cr

