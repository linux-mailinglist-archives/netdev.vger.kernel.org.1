Return-Path: <netdev+bounces-241922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A876C8A857
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 16:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E39424EFA0F
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 14:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4642FAC17;
	Wed, 26 Nov 2025 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuQ5eUKN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1470626281;
	Wed, 26 Nov 2025 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764169105; cv=none; b=cmE+jvhnfMo7EA31bDEgB0s32q86KehxLPXcVCYUBB+VhHzf7YJ73SEdT0K0maCQKkFvlgUYZq60Xw/TK9a2mN3rMxtqTGRY1os8yyIcjmkNOYxpnx2vZG5hrw02F+/phznPdNykzLGLuJIqP2eSW6lEDjuuZo7RMyHZ8zHuGxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764169105; c=relaxed/simple;
	bh=gLYuQLwh55tMarci9HPqWgNoL6uNZakmgR9lPo8pYUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKy+lMKUbnPlmJj7qcQQlc35jrhVc1Zd4CRskQGbpQPW5zwuCHwh8KrePeyrmvEZC8N5gmXhaNPPlhDaFu6rpK9ncuYlXCi1HIFZKzkCJzZ9SR+dYtnbT0E10oeuNdjZ6HDohO9XQVuaMNQ4u5YrhBD48BJcovkly7G+blWmx7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuQ5eUKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72739C4CEF7;
	Wed, 26 Nov 2025 14:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764169104;
	bh=gLYuQLwh55tMarci9HPqWgNoL6uNZakmgR9lPo8pYUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BuQ5eUKNRbhA5uBOyfKvtUqSsornRNY6OmI54QA6c3q6QS/X9At+Ffo9+Cl54ewjy
	 aHyT+R8VdlgHoqF/9Xqu3S5mge5lwr97jluwWmG/JuZU03m+9u7papgT+b3lwpNowG
	 xfRc4rS4dzLyji0+Nd0h+uxC0v+kxH11Q5Oj3yosrkpDNBFbeyn/JOBOcESevWFgtb
	 nTxWCUQhJvEoFhamljRAlJrC1sXnQH0WMy+X8oOwoCHjDj3YzUzCmtCNqr+ffmXp9+
	 2F0rLI3zvwNiKFLIL6ERdXfNcxdqu+NG5eqrKDK32UaGzOURmsmATUkMOs6ZFl3etB
	 4Hh8EFEW1eWCw==
Date: Wed, 26 Nov 2025 06:58:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yumei Huang <yuhuang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sbrivio@redhat.com, david@gibson.dropbear.id.au, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org
Subject: Re: [PATCH] ipv6: preserve insertion order for same-scope addresses
Message-ID: <20251126065818.581b2c9b@kernel.org>
In-Reply-To: <20251126083714.115172-1-yuhuang@redhat.com>
References: <20251126083714.115172-1-yuhuang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 16:37:14 +0800 Yumei Huang wrote:
> IPv6 addresses with the same scope were returned in reverse insertion
> order, unlike IPv4. For example, when adding a -> b -> c, the list was
> reported as c -> b -> a, while IPv4 preserved the original order.
> 
> This patch aligns IPv6 address ordering with IPv4 for consistency.

This breaks the ioam6.sh test:
https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/402461/16-ioam6-sh/stdout
https://netdev-3.bots.linux.dev/vmksft-net/results/402461/14-ioam6-sh/stdout
-- 
pw-bot: cr

