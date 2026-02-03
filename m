Return-Path: <netdev+bounces-256096-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CAiC3hhgWn6FwMAu9opvQ
	(envelope-from <netdev+bounces-256096-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 03:46:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF32ED3D81
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 03:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E070B300ACB8
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 02:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB9E31D371;
	Tue,  3 Feb 2026 02:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/bWSx1m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F682C17B3
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 02:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770086773; cv=none; b=mjYVSpgLzwY3XJTLZEo1fR73K6cgtvoRqOQGzFyEWpwomLRtQ/YTxQ+Bh/+cVJ88eZS5GaLE/t92ms3pgEr05uGi6OZu6Fqwkk3LWHV2D3v6lG8SGvbePru6dbkzGir4m4b4Wws1zjRK8bQUaEy+hwgkn3kSS4SNWCEqmFmYKhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770086773; c=relaxed/simple;
	bh=MHWjScnw2mHYNunesu3nSDK5qe3mHgj0G4SC4Jvr2XU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=MWerosauIN76pt54nlHOU7c+meLCzPhmGGz/HFCFHtksl4YAWC6vA1czulnuaUBluekoEoH864yZrXN7fU2HK2pmoXtGBu2o6erc+3vC4bmuze6p5HFAudWteCLFoG6jifsAhtz1IgTlGo+LwXuXcJdq02Mp8OGL8+7r8GDxUwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/bWSx1m; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-794cbd4bb51so19735637b3.3
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 18:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770086771; x=1770691571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LJpOCzBEdNG1mnFmQf3Sr/pCbkVsB2iWzX+wmEipxQ=;
        b=e/bWSx1mnIG/do42t27Hrj5Y82Wxg5+O5pLfb6baKO/a6JVoSXrQKoLKbG1C+Sjsio
         guF0sioWrypdRPjXbITgG7Kqjhjm+Ps2dEAnnapFFFVh3/kGNf9HzirhwP/mGFK8U0SE
         IK6au/P0aAoaQNb5+TcwTdlTOdqkxju13Srg1B7HjFCK0CZZUSnJ4o8To1p1bnvOXOJh
         gfn8Fn8G3TQV9v2Ia8bWli7/zMP83W6waDfh8gfVhd3gyHWY6IwVaAVPYLAc9IG9BalJ
         wlr3IaQTog+B3tav8uISY96TUXD856J2rirhtYIGfATMFG2K9Ppfce5ixkNh68cTRC8n
         4uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770086771; x=1770691571;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3LJpOCzBEdNG1mnFmQf3Sr/pCbkVsB2iWzX+wmEipxQ=;
        b=txQakTmBMFjOOYY2Gg7zN0SE2iTXseMVNRdudtHdTA7WF8Ot1eWo2in6ddGSPp502Q
         OnrFUsxSP5THAk3o7Y9H598LyIpzS+jObWb/FGEMOiGFyzMTiIyusLsT/hwwxqEaNHT6
         JdwX3Al0NwByR6f/9KQVHG3t8NUviecSTxhTXbKDSZ32ly33m1EUf+HxFQdETPi76nsd
         L6JS3fibzZd3UAe4ymK9Rco9xVi13g1fkfRZSilUfYLo0TR555eR3m2ycJcYcT0zZW/E
         qBrt3Hsk3WcH8GUhS70Hd6xyNgoFMfvl99v49Cb6Ta+jMjapEUQlxb5mZGijKpYZE3x6
         D03Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuU1pidIb5lx1GNf/Ee9yPignz8L4nhiWXSGmpEqRjiQXl1rGhzxcKcphovLg0dTe0Svx42xU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrOSFsvF+Tp5dQEd4oKWI/Oki05hQc3XWhjofq7TxrfQfYV9CZ
	lcdSaNtu6fBQooV1Kvx09bPc8d0nZOVS2FqsrOyUXuJ/jfPmsnF96zM0
X-Gm-Gg: AZuq6aJ86ld2O5vqKCchjic/moi5LgazkNDmlScmNAF4fzgq7Ig7BJHFGi3xuBI/DGO
	5BZGWbyIt+G8ZPax/rVNguwBn8PH9A0Fjs9xDysVXBYMzaD8nBNg7tvvE+zEz7xYUeLOem6+VmI
	mcYQngcs4q2al8OEQQ+Ac/IpjCYDoac3sA6poCDnrEM8Z2anc9Vt+ZiIwPuRA6UcBuz4MzPDRKA
	ROmSV2gC3rOXndO585KwpYCZbd0JFZx8e8hO602+yi3UacxmXhEHBLRKjzPLX0UvqtqBTAJbE2C
	ve3M9GOqbOqQl4Tjfa1bMtaqrR+eude9Eaxh/+e1maO7Xss9XHKvtCO3N8cMJoC8+RYiEHa8vYG
	PWK2ZM2hx1kps45ixEh8nXKTAt7SiKchzRD/TCfJp8MVyRPShINll4vBiPt/z3C2d2KZKqJ998H
	rKTwcaAIujf6/15qT1LYuAXZamxA/R6Hs0wVZGripxl+T1VcHJD7P5JWMQ1DQ=
X-Received: by 2002:a05:690c:6d8a:b0:793:c89a:b39e with SMTP id 00721157ae682-7949de6e22dmr119003187b3.14.1770086771441;
        Mon, 02 Feb 2026 18:46:11 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-794828cb304sm98485947b3.45.2026.02.02.18.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 18:46:10 -0800 (PST)
Date: Mon, 02 Feb 2026 21:46:09 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>, 
 Yin Fengwei <fengwei_yin@linux.alibaba.com>, 
 Dong Chenchen <dongchenchen2@huawei.com>
Message-ID: <willemdebruijn.kernel.31f40e7930810@gmail.com>
In-Reply-To: <20260202205217.2881198-1-edumazet@google.com>
References: <20260202205217.2881198-1-edumazet@google.com>
Subject: Re: [PATCH v3 net] net: add proper RCU protection to /proc/net/ptype
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com,linux.alibaba.com,huawei.com];
	TAGGED_FROM(0.00)[bounces-256096-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: BF32ED3D81
X-Rspamd-Action: no action

Eric Dumazet wrote:
> Yin Fengwei reported an RCU stall in ptype_seq_show() and provided
> a patch.
> 
> Real issue is that ptype_seq_next() and ptype_seq_show() violate
> RCU rules.
> 
> ptype_seq_show() runs under rcu_read_lock(), and reads pt->dev
> to get device name without any barrier.
> 
> At the same time, concurrent writers can remove a packet_type structure
> (which is correctly freed after an RCU grace period) and clear pt->dev
> without an RCU grace period.
> 
> Define ptype_iter_state to carry a dev pointer along seq_net_private:
> 
> struct ptype_iter_state {
> 	struct seq_net_private	p;
> 	struct net_device	*dev; // added in this patch
> };
> 
> We need to record the device pointer in ptype_get_idx() and
> ptype_seq_next() so that ptype_seq_show() is safe against
> concurrent pt->dev changes.
> 
> We also need to add full RCU protection in ptype_seq_next().
> (Missing READ_ONCE() when reading list.next values)
> 
> Many thanks to Dong Chenchen for providing a repro.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 1d10f8a1f40b ("net-procfs: show net devices bound packet types")
> Fixes: c353e8983e0d ("net: introduce per netns packet chains")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Yin Fengwei <fengwei_yin@linux.alibaba.com>
> Reported-by: Dong Chenchen <dongchenchen2@huawei.com>
> Closes: https://lore.kernel.org/netdev/CANn89iKRRKPnWjJmb-_3a=sq+9h6DvTQM4DBZHT5ZRGPMzQaiA@mail.gmail.com/T/#m7b80b9fc9b9267f90e0b7aad557595f686f9c50d
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks for the fix Eric! This one is super tricky.

