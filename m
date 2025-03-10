Return-Path: <netdev+bounces-173421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9B6A58BDF
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 07:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5576B188C68F
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 06:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128F71BDAA0;
	Mon, 10 Mar 2025 06:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/6qMKVg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6AC1AAC4;
	Mon, 10 Mar 2025 06:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741587665; cv=none; b=A+bMfjCmBHHA20ySAYJkU+SRfQAYjTAcvDJTcrB06lqzd40kA0N1REViJlBr8bbZxwRyW5EXEcN8xGTcIFaJQg6DGs5e70dFqrBDLNs7J+Z14UDxRwS7Ndcm9qXHHV0oPkMNPTfWIRzfcGXb0/yckk2+T7PapONDrAy6kzn78KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741587665; c=relaxed/simple;
	bh=awe0kgJv1quPThKEYHdH8vj2b77fohBRQ75QgGsIA/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leSN2fmf3DXaBa5j1Yg2D1Uf5BYsTWl7o5qEKh2pS4wLIcAkqyZ+dGKaN1WWnR8YbBOtSfuP9ZjTPTLvfJ1pu5TdVQy/Ksj4j1w5f7pJcAyTdM+2EY4QQbZ/KwiAiLnwh9ngo9nALwHwRqR8DmTvtaw4UjJvWTIST/2Zs7Cn3RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/6qMKVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00506C4CEE5;
	Mon, 10 Mar 2025 06:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741587664;
	bh=awe0kgJv1quPThKEYHdH8vj2b77fohBRQ75QgGsIA/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g/6qMKVg8p84n+s6afp5yJWkodf6ZJVxnfMUgNe6QfvbqKg4xrc7tun3grq59FbaG
	 ItHCKEHPdg8pUmYPbO7PHTY3R79sLVZHUvzPyaUw8p9CsLy6XoVkEVJz81gDZh6d2F
	 zUkUJqawHa3FgyN7UGGh4C076l9Z2b6pLRwL1E7dTd6L0P0otjYJ0ClL3lMkezGTFd
	 +fj3VdhayBQelOoN+N6qJeaIjTQWEN2i1oIWNOxk1yzpEb+ENpLd9w2j301ChEmSP2
	 /FIGlrNEPe5z3tvj9KQz5KNh7v4Ha6qQx+XYowsYUDlZKcTl3zQf8ofHRtIB9DXGpD
	 +gJekkZ8tF/Rg==
Date: Mon, 10 Mar 2025 06:20:56 +0000
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net] rtase: Fix improper release of ring list entries in
 rtase_sw_reset
Message-ID: <20250310062056.GC4159220@kernel.org>
References: <20250306070510.18129-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306070510.18129-1-justinlai0215@realtek.com>

On Thu, Mar 06, 2025 at 03:05:10PM +0800, Justin Lai wrote:
> Since rtase_init_ring, which is called within rtase_sw_reset, adds ring
> entries already present in the ring list back into the list, it causes
> the ring list to form a cycle. This results in list_for_each_entry_safe
> failing to find an endpoint during traversal, leading to an error.
> Therefore, it is necessary to remove the previously added ring_list nodes
> before calling rtase_init_ring.
> 
> Fixes: 079600489960 ("rtase: Implement net_device_ops")
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Reviewed-by: Simon Horman <horms@kernel.org>


