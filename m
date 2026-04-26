Return-Path: <netdev+bounces-281155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGWdG14Q7mndqQAAu9opvQ
	(envelope-from <netdev+bounces-281155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 15:17:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB59469EE0
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 15:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E04C300A7C3
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 13:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F380C347BDC;
	Sun, 26 Apr 2026 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWXx/g9Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE4D36164D
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777209432; cv=none; b=Ovro4JIE2C+TlokAsQZ8vtcPbCyuLxVGtvJZaatjin4FpchnTocspVD+NhgJTOxZY/d/WLtypOMiAEqbksDjIZeic8g6cCq7W0RZ9H3e7ZQGJtsm3w1j0qoPPmByGPCOdfYmcTVhOazyu+0M1sUcN+T55rPZTw7kOb3Qbq4Y8cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777209432; c=relaxed/simple;
	bh=x+YYTxWMWBTUs8+xGvsnwglC/8O2WZrLZrMExkdN7Ys=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=rgwljfTYdRNaHUAJokQKs5vv+mgRBVh8bbKlsaW4tRTzdx53gO67Qcl131334gMzUp0WFViOMyX59z2pvkZQ+kEKrnOrzWgR074O6ocmKeDgnvUc8qPXkFIeBZL8EQJ6gfrC9hHXXmSs3n08yvETvZV2PszQjkA3JSjODFqt3Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWXx/g9Y; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79ab3e26cceso84067067b3.3
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 06:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777209430; x=1777814230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHs0YRZHBGD67vbxwSlbpv9/TtMO58IvmgOpPAVdTog=;
        b=gWXx/g9YJWzTr9dU5q1MVxVahov59zr2J5YpwlKpDyxmtfwWrv33G3VM0f6Sn1dtJi
         W+PTzQhqR8w0/8cDSPArNGCYtLWJNSX9h6tjmHOhRcjnI4Gka4Qt+42zMmb16/7L8OYJ
         DiDllHeFE12Xp7+nFJujHP/kuihUI0yRcI2uPC6wCagdlODdwwOKwzYng8d6e6NRS68D
         CXLp5pFi6QY3qqE9JN5ga8OFztLFg6OrXLrPZyiDQY23+l2SGZUsbFTd/ngy0TJBrYzk
         lKvwBKAzteKYaXFN6K2OqmQolI1AR07+0FBzXVXIs3fi92oqM3LIl7LN20MAMYFnIhxo
         FxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777209430; x=1777814230;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dHs0YRZHBGD67vbxwSlbpv9/TtMO58IvmgOpPAVdTog=;
        b=Ylltqf8h01PajOKfcXs1qOqfZjTotAjjC5p+vjQjBRqlJKkcpPyZJYHCLq8mIDP0Ge
         3Ql0iA7JYL2YPVBbtVo0k+5JDEf9ZyFKLqUcV4aXgOzAQfcMJYAFhMkSrtYDgcQzS1LI
         jFvCp4I7mZ8dAakAcNTFAB0QICgN2/1cFpA594v/ttn20ClFJt6PE3FIVGyrs92o7zIb
         E37Q4+jWVJnHAt13JuZtIbM60AE7pwuxu3rKWheQGTE6Y5CHIO82LCQjb650dQAys1vh
         o9n320Ywd9LJtWuW3s8Ef64EUcFMXS1/k+uWRVPJPljyStmgga5Svi+xnUTG4WcGBFVl
         0AJA==
X-Forwarded-Encrypted: i=1; AFNElJ8WthM8/Gs9g0l8kJ/fav+6vvr+IImkGol7X6oZnzbAWW5vP2wQTDStiTxVrSI6U33RMOjNHF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjnhT4GQKOflabl+F6Wc05k/xodCu/414gRFdUMKuwyXW+Dh0C
	Yq29kxQOrI7Kqu7RtcPnTQ+kQulQT9LPoOZnGScsV/roAkeMeR8DOdzC
X-Gm-Gg: AeBDietVbWIR6ypw92+tgW+83WAa+7bHH1KQSge0FhmY/2KUY80vmYwXgUU1Z43LQq6
	LpTmC8xcLg4NUbmij2dz+TUJsJttQzuL14dSqEslRD4BOvTFg3g3kuPwC3KiinX5JGr3brVnNYW
	uhGn1S2Xr86JA+p7AJOXbuKxTbcYU3+rWZZbkFj+v2xya09xo1XJqq3zhP8iP9hssdKyxjb0E3F
	/h/hb8lZKRgMKvMAaxuFdeZCa+AhO28GwVdt1n1yg5G6rv5ZdOaXOBIdFnUXVUQ9PQzpxYx9rzr
	FeE9WYOODNCcRQWVLl6vUmeUaxnAc22HBjZoeCJao1rYiqppIk8k5aw7KtzMyDVKz7nL45AreaW
	QKzZcaqGj+dMzW7VOxgL+cSPaUJ5/wcTl9zNgoVUkkF/2OmI3dPVc43oaQFUrN0Gi0PtxwuN+VK
	cKl2Gqcn0pFQlrxRHK59Warj3qZwKFU3TggmNKTkk02ph4JXlECGUzlwtyf1s26JpBDpYtZSG0m
	UIHn9AoveARjZc=
X-Received: by 2002:a05:690c:e3e9:b0:7b3:9175:30c5 with SMTP id 00721157ae682-7b9ecfdaf23mr390919617b3.35.1777209430402;
        Sun, 26 Apr 2026 06:17:10 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee9b22e2sm113515307b3.34.2026.04.26.06.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 06:17:09 -0700 (PDT)
Date: Sun, 26 Apr 2026 09:17:08 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tariq Toukan <tariqt@nvidia.com>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>
Cc: Boris Pismenny <borisp@nvidia.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, 
 Daniel Zahka <daniel.zahka@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Cosmin Ratiu <cratiu@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Kees Cook <kees@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Gal Pressman <gal@nvidia.com>
Message-ID: <willemdebruijn.kernel.2f90e0de4485b@gmail.com>
In-Reply-To: <20260426083819.208937-2-tariqt@nvidia.com>
References: <20260426083819.208937-1-tariqt@nvidia.com>
 <20260426083819.208937-2-tariqt@nvidia.com>
Subject: Re: [PATCH net V2 1/2] net/mlx5e: psp: Fix invalid access on PSP dev
 registration fail
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CFB59469EE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281155-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]

Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> priv->psp->psp is initialized with the PSP device as returned by
> psp_dev_create(). This could also return an error, in which case a
> future psp_dev_unregister() will result in unpleasantness.
> 
> Avoid that by using a local variable and only saving the PSP device when
> registration succeeds.
> Also apply some light refactoring of the functions managing the PSP
> device in order to make them more readable/safe.

This is generally discouraged as it obfuscates the fix.

That said, the fix on its own makes sense.

> In case psp_dev_create() fails, priv->psp and steering structs are left
> in place, but they will be inert. The unchecked access of priv->psp in
> mlx5e_psp_offload_handle_rx_skb() won't happen because without a PSP
> device, there can be no SAs added and therefore no packets will be
> successfully decrypted and be handed off to the SW handler.
> 
> Fixes: 89ee2d92f66c ("net/mlx5e: Support PSP offload functionality")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

