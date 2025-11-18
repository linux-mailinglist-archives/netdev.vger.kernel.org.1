Return-Path: <netdev+bounces-239616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB585C6A42B
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 16:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id A84052B344
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51EE2F360A;
	Tue, 18 Nov 2025 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="D0idrpsJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C198261B91;
	Tue, 18 Nov 2025 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763478961; cv=none; b=GehOxkltrqP7uJjVQ6kKRqczHfbsratOeaqhdWgyo/kTSGxRB/NYAG7zg3PNuUFXhYdeVILQH6gAZYv/iy1rtDXthh+ctJ9S0IfgVBYEetxS1aYOnwofHwjTOJwUBgHmKIalnWFayMkfirAeuYqod+RcPJajFQfyWhWIdk2vFE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763478961; c=relaxed/simple;
	bh=Q3duBZSGflUSL/GDeTdz6fRXMK3HgvgGy6X7ydA69T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8TE0GCSgfYplqZxhPpkTJ7MynJJxhGu3FjjNjFxZwbA6OVxfeiWqkVbVpyeDq+cT5M9LryegqSkCotFvh68eWiXbQToIGt4DfJnUgGgUe0pFmu5wCp6SWYzofaPTecLQQLmFJWt+HW7WfV7pv/y8mRu+5iYjbuFRRo7RD90m5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=D0idrpsJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931C3C4CEFB;
	Tue, 18 Nov 2025 15:15:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="D0idrpsJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1763478958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3duBZSGflUSL/GDeTdz6fRXMK3HgvgGy6X7ydA69T8=;
	b=D0idrpsJ2Z5TMt+ykjafJyw4xEnkzq+HEze9VXF0odyux4ParJDQnXWsqbBeU1AmXSRiFR
	Q9oMkiYrCa4IBj2s4HfxM7F9EtSpAPP8j2afheNY6t2ZlEndVJIWI1wminrWe9f/0RqGjX
	ZnLZIMXP/l3edWLpfMIsjXwIv9xicmk=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2832a4aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Nov 2025 15:15:57 +0000 (UTC)
Date: Tue, 18 Nov 2025 16:15:55 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jordan Rife <jordan@jrife.io>
Subject: Re: [PATCH net-next v3 03/11] wireguard: netlink: enable strict
 genetlink validation
Message-ID: <aRyNq_-PrpqtsC5Z@zx2c4.com>
References: <20251105183223.89913-1-ast@fiberby.net>
 <20251105183223.89913-4-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251105183223.89913-4-ast@fiberby.net>

On Wed, Nov 05, 2025 at 06:32:12PM +0000, Asbjørn Sloth Tønnesen wrote:
> Wireguard is a modern enough genetlink family, that it doesn't

WireGuard, capital G.

