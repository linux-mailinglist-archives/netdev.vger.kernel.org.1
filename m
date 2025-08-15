Return-Path: <netdev+bounces-214153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36791B285F0
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D705E75F9
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B402E092F;
	Fri, 15 Aug 2025 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOqzMUi6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3022F9C35
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755283506; cv=none; b=kM86hwp8XkKzdQGr5v0IvCbEL/ktr6LP2FfiaKZ4h559v3SKAOIlrr6geOSJMK81KJyDzRMiHozNV8xzfd6eLAQ17UgU/UI+lU0icpR07Fxv6/8CWNuX0p35FANF9mvW8X43woX7U449NTeXTwjv0ysYrWUtusgy/imExslStbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755283506; c=relaxed/simple;
	bh=PvBk3YnQsoD/rfAnOV8nHlVG/9qJ3Oh0w7+jO4t158k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8NhIuUM8zcju+yOFrRiyUWW07fuJtNjZc0iJbvWf1TKkNDxEoozx+81rKN66MAzzyu3s/PT47CKsoNe8ufc5vX9D3FrFJ4Vj27Nje8mXxCoLI22xs+fX35/FHWP2skCAf9tw7CVtV3wgJG9c31Y/xMic++5rDMpVf6qS/ODFTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOqzMUi6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDA8C4CEEB;
	Fri, 15 Aug 2025 18:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755283506;
	bh=PvBk3YnQsoD/rfAnOV8nHlVG/9qJ3Oh0w7+jO4t158k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WOqzMUi6QG1yD54aLP+oRdr+FEwWLzjK3w1ASMqgzNIQHFr494azn/UX/lMd+G0mw
	 KdQ9ew3/AG5l+sZDgG2Ro9nMWbCj1yM6KaYwuXHTzaRAdy/Y5ySD7odQHiD3btqU14
	 h1dJrT+iLSqJWmVMziyxEVnRbe7ITPgOr+0pZMl97sUR8CIqC6GChEIDoZubrEMnXp
	 VlT3yhwmR2UjSSfecuABzlCbozC8ck9VfHwoPAyVNz64Vyoq/mRLCLHcltyoUkI4Nj
	 Xrzoztrel1BQnMvTVBH9+0biUxLUX711zubJH4kAJl0N2gH1Rrhkii+eOGQLp7cpV2
	 GQOyiJYL2y4rQ==
Date: Fri, 15 Aug 2025 11:45:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xin Guo <guoxin0309@gmail.com>
Cc: ncardwell@google.com, edumazet@google.com, davem@davemloft.net,
 dsahern@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] Check in_sack firstly in
 tcp_match_skb_to_sack()
Message-ID: <20250815114505.2d65b80e@kernel.org>
In-Reply-To: <20250812152322.19336-1-guoxin0309@gmail.com>
References: <20250812152322.19336-1-guoxin0309@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 23:23:22 +0800 Xin Guo wrote:
> This is because only when in_sack is equal to false
> the pkt_len can be greater than or equal to skb->len,
> so checking the in_sack firstly will make the logic
> more clear.

no acks/review tags seem to be forthcoming so not sure this 
is enough of an improvement to justify patching

