Return-Path: <netdev+bounces-280504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id naxXKtj46GnLSQIAu9opvQ
	(envelope-from <netdev+bounces-280504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:35:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B12F7448BC0
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA5D9303AA3D
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DFC38237E;
	Wed, 22 Apr 2026 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gw2eeVD6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47705382F04
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875497; cv=none; b=t1ttZ+TMHQD97VMcVd45TjU+vspacXHP/viPp9ubg2eGMYtnTKIyaCiQCo37uQ96EbDi1QrsxxsmCRpSNGon/xfYbqMZjkTato9zzaxIYjP9JmihPoDjcp9+SqmhriLCanEr8VlSO36/dXZFeMI7ZNWGJ2U8AapaS1eOh4vTHMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875497; c=relaxed/simple;
	bh=3ujk49r9hJpxD6QzWI53EPI7jhtl4wumqKjl5sGJSQQ=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:Subject:Content-Type; b=Sr9AmStmV28ukze09ZSfol4utBcDxEBABu4F2VCWVZIDv78PvhOUocp13gFjEdb50uxC6PRAZs3a3F41X/0+bIxAUpSV3nDuXhDyagq0JCQhRYlz/Tp7hxhfUagoBgyhXyWuVg+zgHl4rxGNlzJxSAvg3LL8xLw7zZRmUzN/KXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gw2eeVD6; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7dbff06e4a6so5488176a34.1
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776875495; x=1777480295; darn=vger.kernel.org;
        h=subject:in-reply-to:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4wYh0G9rovuK1N6AZh4Q/4rSlW66xtu4/puuvsD2R/4=;
        b=Gw2eeVD6nzB0I1BYiWFyTfTS/UemiGpGxnkRgsUlSKJvak6C+B1wGCAMzws0tK7Xzj
         w+2T6mz9rbrUkp0UuYoCE+16k0Hikl/hc7GoMa2NAgi0G1Z6szZ4aMm8W/Fqh5eFMZ8Y
         0D/4lpuqgcY9eJhJ7ckAXVjDzowl1c1hJbhveecs8XPcS9T3lhvysmzh6MW3hrUEVC5u
         SO4fUhO52ax9Z2b7lXt4yjydL5sguPBSxsbvujmzGNW229k19J9xH8cEo8hh4cbFCHeH
         oW1vQ7LIK917YbvCrLhwP9755fWs7HwgXxjlkRRWOJY1s0W5rbjCgOJl5jQ5MAa6jm2r
         m6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776875495; x=1777480295;
        h=subject:in-reply-to:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4wYh0G9rovuK1N6AZh4Q/4rSlW66xtu4/puuvsD2R/4=;
        b=HJ4UJ+zWNRK8twKEE91yClLT1s+0LGUMl/+lRfaLCYVi4AmH9VYdQdWU979OEztuUu
         +FCM49IhtbyuGNJ3yUp13xbvGl2HhUKUCZ1/mEqiRiaur2CbMcDmM6BY9tYcXUMglcPG
         +EjxSPaPQf2OCo0OUE85UC7cCvQThbvtfqme/tTEVecBgPr59D9A5sjXIluHhYCs9mQZ
         CKhapu3zzOQUIfj2OlaKalRKoJkexBjsPGmmKccbPaxaONwDoKqq+fMP69b9Ue63pKnh
         uY+sraH1MgdegEKzjwo7ZMnH4WVtt+1H7+D1MR2tb3WBJGXdpQ9q/X71ZfBixLyFrWMv
         4rjg==
X-Forwarded-Encrypted: i=1; AFNElJ9VOPuY+v4iiDe1kBcJzAa4saFio45u06hWwBWcFoaFHG0UVdFDx2494U470sM/LyNEE49qe5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTp+FbncHAJ8437h+MZGKiCY1nZZVGYjngPY8/pcVTr9z7HoFR
	ZCR7JNuibBgRJDTYYFYDakAohZp/fEMbAgWpI2vTzdn9zSqvPkNhYxmY
X-Gm-Gg: AeBDietn2q5J9TEwAaZbty/KWp9M1OC8YU739jt0y+dyYu/4K1qyN23CVS3jJ0b50QO
	MwZfzU060xVGhQRVkGfpoiVs85wd06Qzu3p16ssfhPapakuPlAF0aXtqb3W0n6ADluvL1HUs7l6
	q/7/UrrdsszIDH4hAi5iHN/uvhav/BAGoaacBujKLGWadk4hMZVduL9qx4NqZy0Q4SmwTRL0pHQ
	upnoAC3JYJMLmWbVoCS0T+KOIzh/fx5/SvZbG1BEAn1yxCNL/ncqH4Pt4Qi0pdtqS7XG/Y7LYpP
	idH8Aaj5VH40krEe23U0LDKWoW1bPTZDkuHrmF1e2gcNTVtO7lz+va7LlghiA4bu+Lxmq1CVFTh
	2Tm84KQD2a5JM51UgLqF5Z43HL59ChhR6XKjtrfPlasnWKNMyxbZLd5xkI1Y0uS+D7nROMh10Mq
	CEjvikh4Cy+NTLuTjwqNk3gyqJ5mLn
X-Received: by 2002:a05:6830:67ec:b0:7dd:e032:3cdd with SMTP id 46e09a7af769-7dde03240e9mr1511113a34.18.1776875494493;
        Wed, 22 Apr 2026 09:31:34 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:74::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd164d2c3sm5895751a34.24.2026.04.22.09.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:31:34 -0700 (PDT)
Date: Wed, 22 Apr 2026 09:31:33 -0700
Message-ID: <f019ae7f3c2ec5fafddfe942eddd6591.sdf.kernel@gmail.com>
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
In-Reply-To: <20260422033650.68457-6-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v3 5/8] xsk: avoid skb leak in XDP_TX_METADATA case
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
	TAGGED_FROM(0.00)[bounces-280504-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: B12F7448BC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Jason Xing <kernelxing@tencent.com>
> 
> Fix it by explicitly adding kfree_skb() before returning back to its
> caller.
> 
> How to reproduce it in virtio_net:
> 1. the current skb is the first one (which means no frag and xs->skb is
>    NULL) and users enable metadata feature.
> 2. xsk_skb_metadata() returns a error code.
> 3. the caller xsk_build_skb() clears skb by using 'skb = NULL;'.
> 4. there is no chance to free this skb anymore.
> 
> Closes: https://lore.kernel.org/all/20260415085204.3F87AC19424@smtp.kernel.org/
> Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate function")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 88ec6d2cbbcf..c49b58199d2f 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -741,8 +741,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  		skb_reserve(skb, hr);
>  		if (desc->options & XDP_TX_METADATA) {
>  			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
> -			if (unlikely(err))
> +			if (unlikely(err)) {
> +				kfree_skb(skb);
>  				return ERR_PTR(err);
> +			}
>  		}
>  	} else {
>  		struct xsk_addrs *xsk_addr;
> --
> 2.41.3
>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

