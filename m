Return-Path: <netdev+bounces-78908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA15876F28
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 05:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57EB281D7A
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 04:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA72F3612D;
	Sat,  9 Mar 2024 04:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQ5h2oVX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A657833FE
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 04:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709958596; cv=none; b=lHvPDk58UPIR2xXWWqMbgTygnTtjY6/3TiT2fLyUfjEdrgyp+ECUOgWJMtl4hfpNb37P9EsVAbVhDgwkCCL98UXepDC10lU0QG9e98eqJb2vvsNPJM+35HeJk8z3zxhltGlluh4b95V3hR89lFb0KBU3TLD3otGo/j5K6/1oz2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709958596; c=relaxed/simple;
	bh=RGFnVYzNPi4SfNeA0HUCrnBbOdfvh7/1mjhl9j9zAl0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hWiD1VZgk69o8EhkGpGJh2laPHnfaD8m3cn9KWzkFp2vOW60FuM6FQdtyyoDdz0bIPA2RdGoyFCjaflKnlwK1d5UngBgfVdT6uRLHByQgEmAsYhjL20/mQ6Hh83+lBr85wpUugDqB5ibSJ7Iyrur/Qu9FC2FqwDBGp9Q4lgTV7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQ5h2oVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0DCC433F1;
	Sat,  9 Mar 2024 04:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709958596;
	bh=RGFnVYzNPi4SfNeA0HUCrnBbOdfvh7/1mjhl9j9zAl0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MQ5h2oVXED4UAR+Kmq0nKFqvGDE9GK/aXRoh/M6j4xidcm/C38y4XXCJ+FKRPWrhV
	 GOmePX4U8WhvSi8FBK5QvO3Bwf+oYrzLWO0pm/Lbgg+SQZZgHFdUG/TmHdkxtD0mWO
	 LELiHLD9aHIyhrYBO9lC6fgaihII95pJ7Z4KA2ZPpOJWPAdXLD88Er8SzL7+GCUsoJ
	 +TgUcvYZrQeddW5gZx59sEqmOxMdS9RYMUFfKzDwdsoODrna/DzSlkJW4e2Mop3bAg
	 0hA5o1FV2tDPWzx2mKAF08NaWqDhKZWdkL3E2arq9rwjRCrIGExUSHXd8WhsSKLy8S
	 LBltLei7DboVw==
Date: Fri, 8 Mar 2024 20:29:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Wander Lairson Costa <wander@redhat.com>, Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH v4 net-next 0/4] net: Provide SMP threads for backlog
 NAPI
Message-ID: <20240308202954.1cca595a@kernel.org>
In-Reply-To: <20240308153302.AmmDp45Q@linutronix.de>
References: <20240305120002.1499223-1-bigeasy@linutronix.de>
	<20240308153302.AmmDp45Q@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Mar 2024 16:33:02 +0100 Sebastian Andrzej Siewior wrote:
> The v4 is marked as "Changes Requested". Is there anything for me to do?
> I've been asked to rebase v3 on top of net-next which I did with v4. It
> still applies onto net-next as of today.

Hm, I tried to apply and it doesn't, sure you fetched?
Big set of changes from Eric got applied last night.

