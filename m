Return-Path: <netdev+bounces-243303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 689F4C9CB84
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 20:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50F2A4E346F
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 19:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47B22D2381;
	Tue,  2 Dec 2025 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkSvLBRE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C23D21D3C5;
	Tue,  2 Dec 2025 19:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764702488; cv=none; b=b81zOGDYQlm1/C/seu8Evxg5NahquMCRA7G9glb0Yn9clWHS+wOa7JMSySyPYtQZxqFgz8A2lmXoPiMmQew1paoojk0fmeDG+obJ78HUkatJvn1aUvRzYyFe7VbiALAxcOFYxMyc9yLgwiCaaFrkWKmmhvC2/fdZ1CFsTmwtgxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764702488; c=relaxed/simple;
	bh=qzF6qpnCYLfLMh/GEXQ0ExYLuCvljL6XKotj2oFdnBE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y2vKdHg5/ah21cVQGx/yLZClfjZwk3p+qzr//KYQql4GsCpQ3VTU9vUNe02sBhvlrvX93461qtkyjoe8Dn3ofV0r4tJ4bCIsmf5skmot3LQ00SoVx0YAwJGCeiZcD3A6CU/GmhC5jwGxTYGAbHUVkFE5SgLimOClQX/0JdYzeOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkSvLBRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F46C4CEF1;
	Tue,  2 Dec 2025 19:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764702487;
	bh=qzF6qpnCYLfLMh/GEXQ0ExYLuCvljL6XKotj2oFdnBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SkSvLBREnRcZrNhP9XyGgIseNO+qMt4yRTev6PRVBjxYy9xmtLcq2FUdqxYgMOGkK
	 4u5VgOcEki8jvh1rxFw8tWOZJPJVnEr93/sdYMFSK15ShWtytOJR1/Rfqf7QxfKNR1
	 /11zxPxEL/pJetGsUgyBeb9wiUl3TJz/j1pYNLGQDiCnHUslQnvHL6SaoBdF+9Ufzi
	 SiZ3CCiyVcTaSN9fkA8HZ2lU+Dce3JKdzBvSstDnW86QT9KnTOBg04lgZMqUmX8ewi
	 5WQkmc5Sf6bby8yhbDuMaX6GJ2TxM4wNGtcUAzlozw+0O1CurZ175660uO4Elqod4P
	 oXZ9UH7d2b9Pg==
Date: Tue, 2 Dec 2025 11:08:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mikhail Lobanov <m.lobanov@rosa.ru>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, David Bauer <mail@david-bauer.net>, James Chapman
 <jchapman@katalix.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH net-next v6] l2tp: fix double dst_release() on
 sk_dst_cache race
Message-ID: <20251202110805.765fa71d@kernel.org>
In-Reply-To: <20251202180545.18974-1-m.lobanov@rosa.ru>
References: <20251202180545.18974-1-m.lobanov@rosa.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Dec 2025 21:05:43 +0300 Mikhail Lobanov wrote:
> A reproducible rcuref - imbalanced put() warning is observed under
> IPv6 L2TP (pppol2tp) traffic with blackhole routes, indicating an
> imbalance in dst reference counting for routes cached in
> sk->sk_dst_cache and pointing to a subtle lifetime/synchronization
> issue between the helpers that validate and drop cached dst entries.

Breaks allmodconfig build:

ERROR: modpost: "ip_options_build" [net/l2tp/l2tp_core.ko] undefined!

Please note that net-next is closed for the duration of the merge
window. If you want to repost this (after waiting the customary 24h)
please do so as an RFC.
-- 
pw-bot: cr

