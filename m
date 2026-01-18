Return-Path: <netdev+bounces-250758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75055D391DB
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 01:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA9ED3013EA0
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 00:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597054594A;
	Sun, 18 Jan 2026 00:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFqc6NJw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A0250094E
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 00:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768695962; cv=none; b=jiwAW87OSSS9HZq2OTjy0aPvjwehgtA+BKnL4PixxivJezAko2cCnlEq/ttrEqBoL/T/DfIn8EzhcDuAv8jBgmvu9Ka5uLTtZAxdCZrOl2jAicDAn6X3v/std3rGmFIB5XT83idMZ1mP5s08btDlZFhq2JlQ21nBeKHUvlIN+RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768695962; c=relaxed/simple;
	bh=jhpuDUyXIvq4vPWT4zB35cUmLMJphxlTGlX9gyUFk+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UrtPpVd02uabYmryVXL6csssvIgDyl1y4Y50tpt5Ciob8XTB6C7j5eWIghAKmPwm9A9RkEasGLdR7HMOwDYmW0AU8SFaU7bX7PsF+1Ozz7lQqokr5fZRFizuGw7b43xW3wJo+qbiQtAKLsHE/QQTh7aRrrd+6ECMp+Xe4D5/8qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFqc6NJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E6CC4CEF7;
	Sun, 18 Jan 2026 00:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768695961;
	bh=jhpuDUyXIvq4vPWT4zB35cUmLMJphxlTGlX9gyUFk+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WFqc6NJwUuc4D77Ym3QEFtEHWrkH9BqE38RA+FXhYAeD2XtxefC3y3EGKkCEL/9fj
	 v7LxyZ3HOME9uWHCwgAVu/XLb43avfPic3o0ZwsMgRrLHFfRLCMzMdo/69FUWYVlMU
	 vs3i3eC9LPqfkGycmmvDheoYEVRygnNyRP3fU+fZSiQAUYhqbbm49+gufCFBzAB7Jz
	 2VXaUnwpkUb5tKGtPum7B5ocFj6ZbSIMckbwrZKis61fCOZWK2UrhC0QuVbi0YXoJX
	 VKT+EcqoOlI3WY1+f/TR/mlwPBTCZN9yiBbmxQvOI6X8nyp/sWKSsdNR634N2DNsdr
	 9eJO7MqsTpMMA==
From: Jakub Kicinski <kuba@kernel.org>
To: dhowells@redhat.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [net,v2] rxrpc: Fix data-race warning and potential load/store tearing
Date: Sat, 17 Jan 2026 16:24:28 -0800
Message-ID: <20260118002427.1037338-2-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <89226.1768426612@warthog.procyon.org.uk>
References: <89226.1768426612@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is an AI-generated review of your patch.
Bit of a nit pick but... I guess so..?

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
rxrpc: Fix data-race warning and potential load/store tearing

This commit fixes a KCSAN data-race warning on peer->last_tx_at by changing
it from time64_t to unsigned int (to prevent tearing on 32-bit) and adding
WRITE_ONCE/READ_ONCE annotations for the accesses.

Closes: https://lore.kernel.org/r/695e7cfb.050a0220.1c677c.036b.GAE@google.com/

> diff --git a/net/rxrpc/peer_event.c b/net/rxrpc/peer_event.c
> index 7f4729234957..9d02448ac062 100644

[ ... ]

> +static time64_t rxrpc_peer_get_tx_mark(const struct rxrpc_peer *peer, time64_t base)
> +{
> +	s32 last_tx_at = READ_ONCE(peer->last_tx_at);

[ ... ]

> diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
> index d803562ca0ac..ce4fd1af79ba 100644
> --- a/net/rxrpc/proc.c
> +++ b/net/rxrpc/proc.c
> @@ -296,13 +296,13 @@ static int rxrpc_peer_seq_show(struct seq_file *seq, void *v)
>
>  	now = ktime_get_seconds();
>  	seq_printf(seq,
> -		   "UDP   %-47.47s %-47.47s %3u %4u %5u %6llus %8d %8d\n",
> +		   "UDP   %-47.47s %-47.47s %3u %4u %5u %6ds %8d %8d\n",
>  		   lbuff,
>  		   rbuff,
>  		   refcount_read(&peer->ref),
>  		   peer->cong_ssthresh,
>  		   peer->max_data,
> -		   now - peer->last_tx_at,
> +		   (s32)now - (s32)peer->last_tx_at,
                                 ^^^^^^^^^^^^^^^^^

Should this read use READ_ONCE(peer->last_tx_at) for consistency with the
data-race fix?  The new rxrpc_peer_get_tx_mark() uses READ_ONCE for the
same field, and the same seq_printf uses READ_ONCE for recent_srtt_us and
recent_rto_us on the following lines.

> +		   READ_ONCE(peer->recent_srtt_us),
> +		   READ_ONCE(peer->recent_rto_us));
-- 
pw-bot: cr

