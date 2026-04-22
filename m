Return-Path: <netdev+bounces-280503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIShBML46GkgSQIAu9opvQ
	(envelope-from <netdev+bounces-280503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:35:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E22448BA8
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3FBD8303783B
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F583815E6;
	Wed, 22 Apr 2026 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHpm4dTo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D043563FA
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875495; cv=none; b=uR13KG0my9eulhzHYpwdLxiMWw/YNYayzWCO2p9tOE4rNmjml+ACO/uFz7B5xVWLtbX7aSlwpDER64o+8NBw97STk5Uyg14aro5PmwRaNz/y598opagTNNv9/59w9qrSl6BumglNlVCg7AvYE1k7EhdVwH466mSpJ5Puirnb5ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875495; c=relaxed/simple;
	bh=ZhN0moLeND6THuDELm2QNMsMkjLuTrdx5gIvE1VuA6w=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:Subject:Content-Type; b=jEhjlhXcJ0mv1EUFPjPyZzqv++os9Lb0P8thFtaoDFfZPQfjNZ4CMbCQHDYk1Hq+zcjIpSo0ZXU1TNRsfNs1WPs6PIBcnF0qyHLILysOz1PB39hvkCGZDvChMCu95f7sX9QBHZ1F51oX+TUPhRYEJhBL3/50fi7c1omin7w8klk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHpm4dTo; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7d9bba96f7dso3298709a34.1
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776875493; x=1777480293; darn=vger.kernel.org;
        h=subject:in-reply-to:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XYSB4MPFe35gJkP7o6kqvgTpyWAy68boQJL3k4gHv3k=;
        b=bHpm4dTo7yWotFXK1bcBNxicoY4DVz9nSwTGZoYrqGVCxjFLqp6IJIMvKdj6ZzoHY+
         XHeaJyu7u6GpbyzNKsF2SquBJH3HO2FJLDwcEK0gsftq4xCRs7eC38EDLn8hw5+eKJjs
         loKmpbIe4ZFkxgaXKXTdAH7ZfQCa/QxOBk3KM3q6d6y5nlg55TwG2R+M9Oun9m2x3sZT
         uJgGhB4K0GsxxJMaNh2jUCZodHcirCyHhmxaEdtyTlMEgQSf4H6Bp9G4WuwInuBrWenw
         Lmfe8Y2bGnBWEYxCs+d0F0TRg3YMerJVyDW0G4UBraZTpXnUZdnS1b3LZYWBhuoYZfAB
         yEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776875493; x=1777480293;
        h=subject:in-reply-to:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYSB4MPFe35gJkP7o6kqvgTpyWAy68boQJL3k4gHv3k=;
        b=M/BMhDXtGNqmme26En06VVAXPeOfVuJetVRqQlOUysoCvw1w35xHsLGkRH51Ugw/Du
         TdTRbwE1bsGWGnFvBuaIWRj6yjzZQ0ZmAkXFBzY2KmW8gm6ivqIZ7goYGfreDCgPfrur
         rbym8IwpY96dK8He4S7C5V/0g8qpGskUKvNwRh4iYp+dDJXBfCPdyL/yxUc6KTbBbwn3
         2hJ0zff/NrWY65JZPzIAlfyz5l76bYnWVy4E1fcuApeyS0oLSWWuFB9LdeLx2Iq3kVkO
         UiHyenRVKsnMzWmMcyVOE9NHhIQRiyKYPnvGG/eJnuhAmMHlTaxTuvAip2cAUcJuo8hD
         yG8w==
X-Forwarded-Encrypted: i=1; AFNElJ/95F/b3sNukXSHsyulbTqpLzEomF2MssAM4jq+orrd8VdYLeKRcbsP32loUe5bBv7qbfOowX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgPEujXKdqUscTWNv3iV8n0RaRw2bhDuZg2Dq56u2cDI7Zq3gG
	7Sj9yvPJ2OjBWtNsFBrmwNrnr8/L1pIsmWH+IgB6MvRwaI3D9CiQMjUL
X-Gm-Gg: AeBDietXVQOKObeMNynzQ1MpBwKF8K3/drn2wx31SzxWfneZ4s+zl63KWvuPLJXrQj2
	vea5nIVgB0zYoCDkIwEq1hAHLIpfdManP7wuym776u5FnfiuyL52/3/fZshurLHkB5dwwCFSDeD
	LXOhdA70Z2x13ti6V4olJKI1uoAHAUV5usxzRdo1BSy6S4S7egizRCCZW7H2R93sHb78d2tcqan
	vuPBoHjtrQG4g2nUgCJrdBgBvEYOVkOTgAVvxfZggaG7UJ2lgolyJ8kzWxe8Vf2ISb8ZYlGEF7Q
	fn2bFbP+FD/5DbSV1oXvzZrk7FaQwJN5JSN0RedaH3y9pPWqGKrBOBIPLbrvwRvnhW3IlMHopjL
	wqoPcYZ4WLDZb8eNHJB0vpRc91lrF900dVwXwp9kI7gqe05lFKgANJMD2YDeG288DPNv3QZq+Am
	A4GbfohKo/oO66adH1umV6sEJJNgZAavxFN1H02w==
X-Received: by 2002:a05:6830:8d1:b0:7d7:5b78:ef31 with SMTP id 46e09a7af769-7dc94fdf204mr14413587a34.12.1776875493446;
        Wed, 22 Apr 2026 09:31:33 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:4::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dce5c346adsm2386228a34.27.2026.04.22.09.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:31:33 -0700 (PDT)
Date: Wed, 22 Apr 2026 09:31:32 -0700
Message-ID: <e3906107e27c4fbb9276d94ac3362066.sdf.kernel@gmail.com>
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
In-Reply-To: <20260422033650.68457-5-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v3 4/8] xsk: prevent CQ desync when freeing half-built
 skbs in xsk_build_skb()
Content-Type: text/plain
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280503-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,fomichev.me:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1E22448BA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Jason Xing <kernelxing@tencent.com>
> 
> Once xsk_skb_init_misc() has been called on an skb, its destructor is
> set to xsk_destruct_skb(), which submits the descriptor address(es) to
> the completion queue and advances the CQ producer. If such an skb is
> subsequently freed via kfree_skb() along an error path - before the
> skb has ever been handed to the driver - the destructor still runs and
> submits a bogus, half-initialized address to the CQ.
> 
> Postpone the init phase when we believe the allocation of first frag is
> successfully completed. Before this init, skb can be safely freed by
> kfree_skb().
> 
> Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kernel.org/
> Fixes: c30d084960cf ("xsk: avoid overwriting skb fields for multi-buffer traffic")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index d23d1b14b8b4..88ec6d2cbbcf 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -739,8 +739,6 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  			return ERR_PTR(err);
>  
>  		skb_reserve(skb, hr);
> -
> -		xsk_skb_init_misc(skb, xs, desc->addr);
>  		if (desc->options & XDP_TX_METADATA) {
>  			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
>  			if (unlikely(err))
> @@ -834,7 +832,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  			if (unlikely(err))
>  				goto free_err;
>  
> -			xsk_skb_init_misc(skb, xs, desc->addr);
>  			if (desc->options & XDP_TX_METADATA) {
>  				err = xsk_skb_metadata(skb, buffer, desc,
>  						       xs->pool, hr);
> @@ -884,6 +881,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  		}
>  	}
>  
> +	if (!xs->skb)
> +		xsk_skb_init_misc(skb, xs, desc->addr);
>  	xsk_inc_num_desc(skb);
>  
>  	return skb;
> --
> 2.41.3
>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

