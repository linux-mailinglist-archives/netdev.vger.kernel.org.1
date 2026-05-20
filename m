Return-Path: <netdev+bounces-289877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FY7LzyODWoIzQUAu9opvQ
	(envelope-from <netdev+bounces-289877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:34:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3865858BD3A
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D33BC30534D7
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C983D3D6CA5;
	Wed, 20 May 2026 10:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="mtxjvHgn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1612B3A3E90
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779272934; cv=none; b=nR/Gf+2ecTH7xxIqMsJTE+yk3jT2KjLzBCo72hatdMVNrB+OJWMceWz3RwKC4opWiaKL19pmRlEn8mhaGMNsgV2Fi1mYGKH1ojNwSOAvvYM9MTv+bjG47jlgU1Pjm/9N26M2qDSmqgggDT8fEBwxpEJLy4JlT0DxN1xxauZ49fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779272934; c=relaxed/simple;
	bh=OFg7gaIIJENLADZC81W1MxkKRviL+wIHPBMCeJeFUYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l04pKJCCIhRZwbDMeBHS9uWUepBncN/SZ9Rb3Pu89D9Jic4yL2ZMpaV+64hxgnh0gwDXUaYkiPtuBSUQM9aD03fQypbaDp219zDgw2GLvjJRVO//zWoJ6saoigonEivKUZhl+Nxcgu8WKwi7IBA4rhqWovt2uKWUSLpoWXeqjFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=mtxjvHgn; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45297094718so3616709f8f.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 03:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1779272927; x=1779877727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w6GwYArnaeioyDwurWj9r+Vzo/oXg0IJMt1SOHyO9K8=;
        b=mtxjvHgn0Vxgn1PLDvOf4Dz36AQ3TADAVca3vyAdj9+M1x4DvX0VuHf8V2SkE3hBwn
         +avCrGj2lKVj6ws9Cqu8dqMXRZLrMW++r7DDwsPNg16YvKcZvVvh5DHFhmITybxPVo7m
         epjYrODebC+MZ4UQsgWoYLYYb2tOcptgr01AfrXlkNtunrkiOhnvU7enZWT6yDbXFmJz
         BSg/kn32hVAs1kEMPonH6IpGaw+tsqDhfnfsSseNn10f41IVLUAtbiMZCF2TGFaP20PQ
         YhTL7q6v1f31hQvFFLo6sp2LMT3ZIZZSkLLhtLy7ZnRwvtXTe1I19rhJS7axIBQT/+7i
         SX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779272927; x=1779877727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6GwYArnaeioyDwurWj9r+Vzo/oXg0IJMt1SOHyO9K8=;
        b=ZBpQttiRAKoSofBjOnsLu2KwcMdke3E9XMTzQptkeQG+TsQAUUkez36axUu13FDuUq
         R5+H49TXpbLbYMYJn3WAfYTg3ccXBl1IHlbgxCpBT5zWEerfv88oEqP3cPWp+7CL2f7/
         73loGevXu3J5qucKbJWEGiPgdpIMvx2zRMwEnnWpB1mXYJOON9BpVOZr4UIBE6SfYdb6
         LOf5sQVT6wEb7kR9Ucv+0GjjZ34+LwOww1ScpPfO/VOD2uZDwmde5tLTeyoQJLkrm42M
         rna/HEP3lZOBQ8fXhiyU9PZj2EXoXWM9Gw36Ol2xG1oFpVJ5BCdaQBdgv4vN3ahZnNNa
         uNqg==
X-Gm-Message-State: AOJu0YwCKCjtuyFcSTCYnjnBMopTIC5DMGpIOWiO6uC4VABUzDfXrKcH
	UoqGMR6H/ihrBA9qGWhdYEJdFZv4As41vZaLp71E5CQaVYkWP8SgND2ciHWEzIhaM5M=
X-Gm-Gg: Acq92OE8PZriobwHp7eNPm2cJIDLaP9JYtOH99Eq6qPa+LUTb14j0MfD0JY19mHnJo5
	xSbLwvYZxWQhBO2ivw4cul83Y710LRRx9mL0DdO/USFAb0zbljm3N+yOdReMLKnXg4W8BMW70+e
	TO6upHhesWGWR40eGcL9zp/K1VAKOdbmKYt0NhDx1oyGl1O33eKkZZZPxE3sc8Y6Q/Pex10Z0/G
	XF0wdB+DDAKAWEX3aD0CJ5sl58Bh1keLDPHDiSP/kp4osAru0cYbwH/sODFhGd4jV2IFIdv4CAf
	HS6DQnN0NytQWLJKHHD/aBX7CZEYRoryG8savO+dyB7FLVD/F4sS7YoSCJ6isDBGO75/5AmvoP5
	KTmYTealUVCspKMdn1RrBS1HwKaydSbVCrA/D4QZ3JuV1LJ+jNOWjuPr6tT+QfC5COVgaAohQUz
	cBiLscUI8bgdWceMhq7I3x+PhfrVGirgvV3Q9AiNv6Mn9aXn1i443HaVPncQ==
X-Received: by 2002:a05:6000:24c6:b0:43d:7b7b:ab76 with SMTP id ffacd0b85a97d-45e5c36b3camr37115121f8f.10.1779272927444;
        Wed, 20 May 2026 03:28:47 -0700 (PDT)
Received: from localhost (176.111.185.220.kyiv.nat.volia.net. [176.111.185.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a562dsm53857603f8f.33.2026.05.20.03.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 03:28:47 -0700 (PDT)
Date: Wed, 20 May 2026 13:28:46 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org,
	petrm@nvidia.com, idosch@nvidia.com
Subject: Re: [PATCH iproute2-next 2/2] bridge: vlan: Add support for
 neigh_forward_grat
Message-ID: <ag2M3moiivqEvfNG@penguin>
References: <20260517082501.899009-1-danieller@nvidia.com>
 <20260517082501.899009-3-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517082501.899009-3-danieller@nvidia.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	TAGGED_FROM(0.00)[bounces-289877-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,blackwall.org:email,blackwall.org:dkim]
X-Rspamd-Queue-Id: 3865858BD3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026 at 11:25:01AM +0300, Danielle Ratson wrote:
> Add support for controlling gratuitous ARP and unsolicited NA
> forwarding at the per-VLAN level via the neigh_forward_grat option.
> 
> This allows configuring the option via:
> $ bridge vlan set dev <port> vid <vlan> neigh_forward_grat {on|off}
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> ---
>  bridge/vlan.c     | 18 ++++++++++++++++++
>  man/man8/bridge.8 | 15 ++++++++++++++-
>  2 files changed, 32 insertions(+), 1 deletion(-)
> 
 
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

