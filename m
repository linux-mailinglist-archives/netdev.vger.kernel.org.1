Return-Path: <netdev+bounces-239640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF20C6AC0F
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 17:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58C974E2C9E
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 16:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F5D2367D3;
	Tue, 18 Nov 2025 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b="FZehUgHs"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCABE28B7EA
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763484474; cv=pass; b=obANWG0dYlOGNcxtFcRP2V3Atb7dkBBpB7pubIRS5cKckqplBZRmHstpq2jN3djdhFANYT/kNHSKjJb0IEYwotmrIelSsnh9Kwu/7VJp1E80bj+8y/yBaE+e70vP5U/n33URDuTxRqj0lq60kSemygouiNTtbQjsrMcKN4td4eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763484474; c=relaxed/simple;
	bh=JlCS5GW4sqHt3yWhmf8zH5asKAma6LzrWHaSuz6VD44=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=S+V/zQ86E6rTx6jo7b+mfyy3ZqF9RJjbPXpVlGNxV30TKb+krDb+Fd9/QGDOZepbVTiI8wnOuo5zUlLDvvnvhUO0R9xn2m7YRbxKo07xn7paI9cFmKthtlJ0lPbM9+/MrL48rsRneAQEYlpPwM4/ZCrCqR9p9shqN7MzSOGYubg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net; spf=pass smtp.mailfrom=azey.net; dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b=FZehUgHs; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=azey.net
ARC-Seal: i=1; a=rsa-sha256; t=1763484430; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=U0iKvXThW3pGEKZSroOlxXurla/Yf991+az9I+3tFRgrpxZe+tFb9S7WneXfhj0IEhb+nNA63d09rq9e71BgptcaCrv150597wmUlfMjto4ZEZ2ZT1Qp+U/ycVOgdRxJlM5o0yhuQsu4nitlevvsjKI2VeQIP8Q0NcYE6T3LbYo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1763484430; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=diqTIO2zTfM7PmHgBODRwlkYbwi60CFhQACuYbkrqGY=; 
	b=S9kTkO9c2gTFkFiRJJ8wnvJugi6vwr8Gsqk8q6df6wBTrCvWizat/s8SquHJVWgEn5M6MtlgkjdXfeC+qqyA9rBYOX0pWKgY9ttNMkPGThSFuIrnnsFEnA4wb+JKnzvJz0a6te1v++077rQpF4ibPK+a4PUVCQ3CB0s619m5Dn4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=azey.net;
	spf=pass  smtp.mailfrom=me@azey.net;
	dmarc=pass header.from=<me@azey.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763484430;
	s=zmail; d=azey.net; i=me@azey.net;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=diqTIO2zTfM7PmHgBODRwlkYbwi60CFhQACuYbkrqGY=;
	b=FZehUgHsTDE4iYhzqXygtcWZhTYHB8TQ3cfefwF/wPsVab7Qv9+IqmrF2RWq1sYz
	ay6ZO+ENwS0Of37EXO0QNHYOQmEQTG5Cu+CbPtMUeko6vRTNyUnQbNG+s2pjz0XkLZj
	8fLK9SBdqSPCgIdmwQrAPTiD3vjzq01ZUNsFJH74=
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 1763484427811366.6806018179959; Tue, 18 Nov 2025 17:47:07 +0100 (CET)
Date: Tue, 18 Nov 2025 17:47:07 +0100
From: azey <me@azey.net>
To: "David Ahern" <dsahern@kernel.org>
Cc: "nicolasdichtel" <nicolas.dichtel@6wind.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
	"netdev" <netdev@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19a97dce5fc.10e4ece0319525.6646442146487396729@azey.net>
In-Reply-To: <e5e7b1cd-b733-40d5-9e78-b27a1a352cec@kernel.org>
References: <a6vmtv3ylu224fnj5awi6xrgnjoib5r2jm3kny672hemsk5ifi@ychcxqnmy5us>
 <7a4ebf5d-1815-44b6-bf77-bc7b32f39984@kernel.org>
 <a4be64fb-d30e-43e3-b326-71efa7817683@6wind.com>
 <19a969f919b.facf84276222.4894043454892645830@azey.net> <e5e7b1cd-b733-40d5-9e78-b27a1a352cec@kernel.org>
Subject: Re: [PATCH] net/ipv6: allow device-only routes via the multipath
 API
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

On 2025-11-18 17:04:38 +0100,  David Ahern <dsahern@kernel.org> wrote:
> There is really no reason to take a risk of a regression. If someone
> wants ecmp with device only nexthops, then use the new nexthop infra to
> do it.

My initial reason was that device-only ECMP via `ip route` works with IPv4
but not IPv6, so I thought it'd make sense to unify functionality - but if
this is final I won't argue any further.

Thanks again for the reviews, and sorry for potentially wasting your time.

