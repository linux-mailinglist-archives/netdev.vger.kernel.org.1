Return-Path: <netdev+bounces-228158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1649BC31C9
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 03:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55811899EE2
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 01:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8C6296BBE;
	Wed,  8 Oct 2025 01:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3/Iw7Ql"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5E3296BB0;
	Wed,  8 Oct 2025 01:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759887444; cv=none; b=X+tXVFOmTA5+9UTuJKEyURSGm2oh4eGaqi4/w9qpSodbrnT8VQsod4IgVrXNRtVLPrgWZoCe5V+NCoEEnXfKhb5u7gXxwgnbfkWDuQeGKSvAvT6PCx8DknBwgO9+SrwRNV6FfLC3lvGdy0DRxsu635IrvDUFzyYN+4GgFN52E+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759887444; c=relaxed/simple;
	bh=SNkg7PdWeOkZ0cZHsU7MVwGayf6b/gdX6bGhefI8TuE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JEhAW8e+TBQKw39ShDljtIqueQy+uNkIc7lTr3vwiHyyY3grFATmI68Fu9eYAXwD0nYMvO7A3Bb2m/7oilpzY9r+Yv+frXpq7KdquBlpKBxjh1Mq1MrNZs5BLq1u/ppInGhZRNEYdeULdNzaU4+Y05v8p4vj/TxKaKNUYocT5xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3/Iw7Ql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870DEC4CEF1;
	Wed,  8 Oct 2025 01:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759887444;
	bh=SNkg7PdWeOkZ0cZHsU7MVwGayf6b/gdX6bGhefI8TuE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b3/Iw7QlBOCpGqPLjtxGIgozOMXW/Z4FQunlVHPZwUgI7BcnKiPypZ5sFTqFnS6ko
	 UXDJWIFUT2lpDycIFHrvWC2bjvr15LQnBJR2NK5Nlvrzf5o5RyvRPj/8sp8GnSr6DX
	 7r643peFu6HgNrTEJ//02rBG5ropd+1BO3yq9/XAjeebKz+auSsF7Vkv+Xn/Agk+ba
	 OFh4Tr7XP0/V49XbPk3ID2PlUIoBTz2wbQyu+XtmDt3Sz9CnFVwBWgUhGcGlATG6Ry
	 G7rkBC3kIxwMCwC9Ch5Q6jNzeEigP3vwHpy4QkMCZJHPwpwi01Bsvq74oj+QRjNxBD
	 gfWWE5NsaaLyA==
Date: Tue, 7 Oct 2025 18:37:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>
Cc: dima@arista.com, "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Tom Herbert
 <tom@herbertland.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Florian Westphal <fw@strlen.de>, Francesco
 Ruggeri <fruggeri05@gmail.com>
Subject: Re: [PATCH] net/ip6_tunnel: Prevent perpetual tunnel growth
Message-ID: <20251007183721.7654cd3c@kernel.org>
In-Reply-To: <20251007-ip6_tunnel-headroom-v1-1-c1287483a592@arista.com>
References: <20251007-ip6_tunnel-headroom-v1-1-c1287483a592@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 07 Oct 2025 07:08:36 +0100 Dmitry Safonov via B4 Relay wrote:
> +	static const unsigned int max_allowed = 512;

nit: could we drop this 'static' while we move the code?

