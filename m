Return-Path: <netdev+bounces-240875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A233CC7BB0B
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 21:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E7154E38A0
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 20:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6773002CA;
	Fri, 21 Nov 2025 20:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h42BLlMM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933002EB86C
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 20:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763758554; cv=none; b=V6fCHvdMkPF4Oj1dSvoAF0KYs4BZOds9uf6KjUIWcGrM9K7ZcGGwQbVnMCAIfzmCZeWIlOuKjc/cZwOaM3SlLiFfRgCKxkqtYntbgqyQ5sEQFx5kC3s3dU6Ex4Iypqvv4hfYdnC7+mN61JhScr1FlrQODOT76fXolX88a67Fr4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763758554; c=relaxed/simple;
	bh=lYUK59Z9lErXRf5Bg+aGnzF3C82gccjJNbgCi2t10u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9h/8pa6pXyUjTlEKuBXq3/wJmrV8lYGrAg38jR92QK21fbJDdNggUqOy5+7Ht16Vjs//SjtxUQ6C8G2PT0Nqwed/B1nlrG9w4aIWrS3wtcwyh4UjfPF0U5PAp27n1CHWTmxaUnf984CF0eARmRv5yQK9c6IDUXOPqmd63Q5uOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h42BLlMM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b53b336e6so206047f8f.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 12:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763758550; x=1764363350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SWLVJDOcbRGYcqao1ONr0boRiS6rHHZNiYodJCrm44Y=;
        b=h42BLlMMyKXqPMLsi4gNQ2+Ng3XSpkwmx0dC8ZAE2SnutTlyVFr9pY8+RilB9q+2d/
         HLxqtROSm0f1pebN7bNkNt6mHaYLXCkVEgAa9sL3UurrK4mIXrxbMsOxwEXrafDO9egE
         6suiAh9LszwJLTOOQayGxo49dWcQeGWLESyEXmTbhKRCVHW6w16KErywrUhFEY4o+EVs
         hKo+A+L87Fk5NmIC++Z7ox6IJ21nO/uSZQhYDw2ZEmWAtfWYr0grW/N+cP9ZmirQcPCf
         FeCJzutmNv/w9cdXxaoSDLwnRMCfQ2g6A4+lXPY3D+kf8LQEGaPk2MrsG1UAQDm0R4s3
         +nVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763758550; x=1764363350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWLVJDOcbRGYcqao1ONr0boRiS6rHHZNiYodJCrm44Y=;
        b=DVHeX2jxE/0s1e/AhKVR+xWBQ8DyvewYkx6cFRUiZwqlRwRz3cSgnr2In97OJ/EOoQ
         U55F2cMLWtlx9/ucU2hAB/dz6gTjKkFmAcUMO9xi9UMr7KzVTHWQDq+kkfxUg0ohs9hx
         G8x5OWFfujjq1al8gaqu5f54EaPwmf6iRpAlVu4tjJJZftgUSpt27xXUG6JG/OsimDml
         BWg9Tsreu5cs9LjB3KGwBA/pzl3yvU1dXYFyprh/s3Qv3ifdej5M3wL3j9ej5X1wPFe7
         s1qFdq5QfXVUgtKR7sdTDq8bFrF13WabppDltQgpKtyciQK3CgEn4KoZZoXtD3mClDYI
         KggA==
X-Forwarded-Encrypted: i=1; AJvYcCVDA2S2WFgHpFvqEfJm38DecxsnZHMRbpZUNfjcCN+wReq/VfbLSFD/hsDNMttuO/DQ23KALYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwvpXA5lJxtKGaMnkNfiqowpyvFNBQpgPghYlxbvrvIAS0BxYo
	z1NULD9EBHyYp2/GW02QANWzvYOizwt6QEQGPP5jGZkEiBMZl4Nd60MC
X-Gm-Gg: ASbGncv9Ex+CEyZbhdBZETOubmAbjhPp83td6fA8Fv49K8Sp2W+X68imNlkPU8zoPZK
	t9nXi99rrBGDu+VXmgL3M9sVf05oPic5ZbGyLDE6AkYYpbTpHWlnEr1dkeXZ8RzZ7maZuklKbEx
	24ged9oCpzf7ttLjag6aCgFaoP7zuToBg/o+4ZZwzkmwAOT6jE+pmF+Di4KPxWlqhEVhdlYJ6n/
	zs2LDHbcE9KTWhXtumlblRcmf4l7YnA7PLViO9Cx0IRKF8oqMqHAX7gA7VULejfWCLM/YmG5OrV
	PSkBkyo1cNe+tSkJe56Wzo5NuQ/pAE1M3ysL2nj9m1Fo9KTC5441aW4fKb6Rx7VrqF2Ai6I5wPN
	1E2df1xnwTZqBNhzymwBL7IA1ijhX4XGbpOvcNurYU+ToDaZDU4usHmPTF4MUpQJeMKwSky7kb4
	iLb34=
X-Google-Smtp-Source: AGHT+IEpBti2Vot/ywXlhz/7XNq56k24q9qvbPMpnhnia8lGLDa9AtxVQGq2oXuumoaffzRpt9mvgQ==
X-Received: by 2002:a05:6000:1ac9:b0:429:c851:69bb with SMTP id ffacd0b85a97d-42cc3f99224mr1830789f8f.5.1763758549737;
        Fri, 21 Nov 2025 12:55:49 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:b19f:2efa:e88a:a382])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e556sm12847859f8f.5.2025.11.21.12.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 12:55:48 -0800 (PST)
Date: Fri, 21 Nov 2025 22:55:46 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH net-next 08/11] net: dsa: rzn1-a5psw: Make DSA tag
 protocol configurable via OF data
Message-ID: <20251121205546.6bqpo2bn5sp3uxxu@skbuf>
References: <20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251121113553.2955854-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121113553.2955854-9-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Fri, Nov 21, 2025 at 11:35:34AM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Update the RZN1 A5PSW driver to obtain the DSA tag protocol from
> device-specific data instead of using a hard-coded value. Add a new
> `tag_proto` field to `struct a5psw_of_data` and use it in
> `a5psw_get_tag_protocol()` to return the appropriate protocol for
> each SoC.
> 
> This allows future SoCs such as RZ/T2H and RZ/N2H, which use the
> DSA_TAG_PROTO_RZT2H_ETHSW tag format, to share the same driver
> infrastructure without code duplication.

Again the twitching when reading the commit title. I thought this has
something to do with the "dsa-tag-protocol" property from
Documentation/devicetree/bindings/net/dsa/dsa-port.yaml. The tagger *is*
runtime-configurable if you implement the ds->ops->change_tag_protocol()
API, and it's also possible to trigger that API function from OF
properties. But this is not what the patch does, so it is confusing.

I think it would be more natural to say "choose tagging protocol based
on compatible string".

> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---

Anyway I'm not reviewing this commit until the reason why you added a
new name for this tagger becomes completely clear.

