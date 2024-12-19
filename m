Return-Path: <netdev+bounces-153397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 140EC9F7D5C
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071981894CA3
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99FE86343;
	Thu, 19 Dec 2024 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zp7pVRp2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4E338FB9
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734619956; cv=none; b=Zj7Lg1c67+nuI24+LuVLGQxMzCImTIMlj3SRDW1YQsRfY2LDAtwejfcdJ2dxCppD0w2bxspPeI9Hb0BmjWHSbNuZJgw4v/ujgZoYnWmBT9zmzesTG0JoR9eHpjC6JYentLxy4WgRQ9lb9HoO+30jR3vsuUFkfyVFlmpemaklVic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734619956; c=relaxed/simple;
	bh=OEwAoSJCW328UWZEmMkywUE4J+Pji6qPDmmJp1k3cKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRtc9h+5pj5o+70ZRoDNaJxdOpQYQHWj4RlkFtrNvGmvofs4WyvM8RhKjeL3U8NAfHQ3EJQQ7HpgjbJQ0btWiBpS7OHsOfFdDeDvnNuV4uO826FavyhoiznOJmWKUj/HwXofRLXVtdkrHAIMnsOJVt8fFoF3CbUOFp/ogUMDDYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zp7pVRp2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434f398a171so1267095e9.2
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 06:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734619953; x=1735224753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nPlbkHxZJObTZGKDGU22yyxdCIuxxhqJHh9p7lFB1Tg=;
        b=Zp7pVRp2tMOiKRMUS8GZqvLFZpVZg+lYu2yCSKiomA9VTKO0/2uAXJtN54NrYIcEjp
         KzMvgIyAu9K+wcOLctuqgTllxUDG3a0Eg+9e5dF2qo57HkAPEkfLR5rLrP+lLM0FC8Gm
         kgMOi5e4Nh+56hDGZIxAb5LqwNxKW5zp6bc6VoiZYMoT+7ewkNu72vi1mdlKYSM9O3KX
         tk/WZ65vktz8U/4y3wmKm7dh+ZacRSlXOoax57tWhzz1mZ/aRrS5pmpOU+XLNV7iH4UI
         svwIL8qFVhTNT5rg98dblf1/1U/0/Ta048GQK5ZaDfcO/RjUAD7ENn8gYt9xutwsAANm
         hHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734619953; x=1735224753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPlbkHxZJObTZGKDGU22yyxdCIuxxhqJHh9p7lFB1Tg=;
        b=Ut34Hx4YEMf5ZDc1eDFYBOkic8Op/Ncnr2qPHyRLmx4dK+LaFO5hPhkpebx1M2oL6U
         LUc0CgDdpYfCoIqUj5ZqI2uhQ/+LGVoTrwEjoHoGeYiBxJcTvIaG6XwUfalgUFxagx3o
         pQjgCo+sBIHWXab0MJAwF64wb/TYpkR8d1XtdJfm5Xlu8v1XCwnUYCcjTAumcyCyXJda
         IW5fceogVJp/z0QHe3W4GInBql3qtYwTB/kqNKjFZNjHjrLUmx8yWCtcTtpIgYvTj+ap
         5N2ONXWNgfBx/U82cDEP2/94zfCWMPnDGtEaxnrP2V74RJsfQWXYEn8jdKDm8ndvFVZu
         G+fA==
X-Forwarded-Encrypted: i=1; AJvYcCXhToL/pcNMo84YOCg18mv5lBwu7Dm1u1EUtvJt8K2ssejZ+mZkyooX1mRoGVcZC/DdyDppGrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YycEcgadvJR9jVboqzvBzzzmA1PGyn+3dh3nqW33zU1d+WlMX0O
	xQDDjhdVAJfc73B9PrROmT1Rf3TAC3a/8vvQ6YR9LnVGdSlXcRtOHzhGGhVL
X-Gm-Gg: ASbGncvmUI3XkAUybeIrpJAajnoxoyvpk5u9RIYhLyE5NGWSDeBr7o5HVCw92hTg/Fz
	guP/BZSRyN5WQctZ9agUwc9/szFO6gtYf2dZB/8W2lFpsCuSqZxNwWC7PBAVqtK78NV1/4MdfIL
	GBRDfJVwo5F7NbixlcGM8mE3q3YP5F4jJZ3/DFiM/+shYXtmlVK8OXTEZg/DfgeuI2OrV3Br+5r
	ioTvprsZpXENYj8uD0w7NZ3Rk77zpW8iPT+okFOUm2e
X-Google-Smtp-Source: AGHT+IE1jQkhyMOa/HoOfM0mBN7DtxYGCd+rxRCcHrxoRdIrgSGHTwTQTpZWY+enY1sJnzXlVFIUMw==
X-Received: by 2002:a05:600c:4e06:b0:434:f7f0:189c with SMTP id 5b1f17b1804b1-43655401970mr26650405e9.7.1734619953244;
        Thu, 19 Dec 2024 06:52:33 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661218f43sm20149615e9.19.2024.12.19.06.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 06:52:32 -0800 (PST)
Date: Thu, 19 Dec 2024 16:52:29 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, netdev@vger.kernel.org, linux@armlinux.org.uk,
	chris.packham@alliedtelesis.co.nz, pabeni@redhat.com
Subject: Re: [PATCH v2 net 4/4] net: dsa: mv88e6xxx: Limit rsvd2cpu policy to
 user ports on 6393X
Message-ID: <20241219145229.2uy3d3pnjqmimq66@skbuf>
References: <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-5-tobias@waldekranz.com>
 <20241219123106.730032-5-tobias@waldekranz.com>
 <20241219140541.qmzzheu5ruhjjc63@skbuf>
 <875xnf91x8.fsf@waldekranz.com>
 <20241219144208.dp7pfbh566htfc4v@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219144208.dp7pfbh566htfc4v@skbuf>

On Thu, Dec 19, 2024 at 04:42:08PM +0200, Vladimir Oltean wrote:
> The other driver with tx_fwd_offload, sja1105,

Correction: I forgot there is one more driver with tx_fwd_offload:
vsc73xx, but that doesn't properly support link-local traffic yet at all,
according to the vsc73xx_port_stp_state_set() comment. So we can ignore it.

> is going to drop any
> packet coming from the host_port which isn't sent through a management
> route (set up by sja1105_defer_xmit()). So it's more than likely bugged.
> 
> We can't fix this from sja1105_xmit() by reordering sja1105_imprecise_xmit()
> and sja1105_defer_xmit(). It's not just the order of operations in the
> tagger. It's the fact that the bridge thinks it doesn't need to clone
> the skb, and it does.

Another correction: we could probably make a best-effort attempt to
honor skb->offload_fwd_mark in sja1105_mgmt_xmit() by setting mgmt_route.destports
to the bit mask of all other ports that are in dsa_port_bridge_dev_get(dp).
But it gets unpleasantly difficult to manage, plus I think we still don't
get MAC SA learning from these packets.

> So yes, it's probably best to exclude link-local from skb->offload_fwd_mark.

So I'm still of this opinion :) I think the effort to handle the corner
cases isn't worth it relative to the benefit of offloading the forwarding
of slow protocols.

