Return-Path: <netdev+bounces-251281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 942A5D3B7CE
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1527B30069BE
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88951299948;
	Mon, 19 Jan 2026 19:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVhUZEew"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666452BD0B
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 19:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768852632; cv=none; b=ee+c2MsnMO+/h42YokGBZKj87MEoOnpfi2DVecjA65QVeWVE+DVQU0tHh8NDETmPHjk/BlSxXvYh/m0aHsf8PR5xuYdEdC6luy4kTd1Qf150rD6a/+mo6t07P4yM++S7bcYtyWewxZhyeAS60jYIesOh8eRwmZmp7IOOsWHsbOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768852632; c=relaxed/simple;
	bh=L6lKQTsELvWQwFIGmSW9bT065pJpiDWMj+eoLUYLGh4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCiVAQ+zPRmQpykdj5UxGjPQPwMF7FRiLQKmX8YaNSkutMl/DuVlqRklNsbKxPy2wHOn6m4ZUvf3o6xTjCT7xeQNJ7mFGginRaKPSXkMH0yTpryq3Anf/AvbYBGwBAyVxXCKios2TEYxU7z2b+ptVveHVmRsyDfh4zUsGOLU9E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVhUZEew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E2EC116C6;
	Mon, 19 Jan 2026 19:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768852632;
	bh=L6lKQTsELvWQwFIGmSW9bT065pJpiDWMj+eoLUYLGh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QVhUZEewmfssyfLLbm1JX/JTVd+/6cGxyr0k8dhZm8z1W7yvA7LtcRnIXbQB1Qikc
	 dVs28FFhRMkTK7eG7oAGOkgrty/GRAX0PYhP2KwhlQDmwNURj9iYCG/sNYSz1kgk32
	 074xIczLsFa1uUD3hgDxRWOoFL48LZlMoIFhifLo4gqbNWaqY0mz6VGE6lNpJr/pou
	 mUOCrseuiv4svw6ZSPZBxk2Ch9xQNs9PmS8K8+sXk2m4ADnPJqBsD4aZSGfA3Qe6+C
	 DSpHfH5hIzep/9cU7N8q+zZIqtYieMY3IhRMpxgurbl9/hXdJUhyq7Czax4ypVXwvc
	 xZofzA1aqqv2g==
Date: Mon, 19 Jan 2026 11:57:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemb@google.com>
Cc: Kevin Yang <yyd@google.com>, Harshitha Ramamurthy
 <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, David Miller
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Joshua Washington <joshwash@google.com>, Gerhard
 Engleder <gerhard@engleder-embedded.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: extend ndo_get_tstamp for other
 timestamp types
Message-ID: <20260119115710.6fdde8c0@kernel.org>
In-Reply-To: <20260115222300.1116386-1-yyd@google.com>
References: <20260115222300.1116386-1-yyd@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 22:22:59 +0000 Kevin Yang wrote:
> Reviewed-by: Willem de Bruijn <willemb@google.com>

Other than expediency why implementing this in drivers makes sense?
There will be very little driver specific logic here.

After thinking about it for 1 minute my intuition would be for drivers
to just expose necessary information, in-kernel consumers should
"enable" the sync for all netdevs during init, and then convert
the timestamps into REALTIME / MONOTONIC by calling some helper?

Also AI code review says:

> +		mult = mult_frac(GVE_HWTS_REAL_CC_NOMINAL,
> +				 real_ns - priv->ts_real.last_sync_ns,
> +				 priv->last_sync_nic_counter - prev_nic);

Can this divide by zero? 
-- 
pw-bot: cr

