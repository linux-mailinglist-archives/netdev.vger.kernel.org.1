Return-Path: <netdev+bounces-240863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C17DC7B8F1
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 20:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF15B35317F
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 19:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7532FFF81;
	Fri, 21 Nov 2025 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggqFK1/3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FEC30102F
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 19:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753851; cv=none; b=AfCmBqL24LLUE+1M0u2J1WsBBbeCs57E3do1xFTQKiBT22p0+LqP9FamSXzhVBkWk8DChI7799Lu3c7i23+XummvhJHxW2ouVRnCOvKD6gqDwAG7HOFyVIklVlPhUsRuj37BhksoMwmSxze/OUO1tFTLH6NnNEpX/x4QVAw/GkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753851; c=relaxed/simple;
	bh=UgSKme/gXLmu4ztikSvSNsXda91TqjSZ+q1O4KdLtDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9sLNIRedFL0pENBdSdocw8ST3Is9GLxE3ENCR7EUnmHwBnjAPRvoX3V6G/wZBvjBRzhRMoEovaPsie0qJ8toUhwA39ZFcpScvkzRepxxwEdpabH8r9EYldDBahmINbqfsGQAM0+pSkJHowvatVxusx83UcYVudih4ujJbRVjA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggqFK1/3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b2dd19681so284253f8f.3
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 11:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763753848; x=1764358648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qJM1mZpGIoqjTJBi+7n1u/HmWUJqp4d9cJ4oHyspqrY=;
        b=ggqFK1/3NFUxooi9DrUFK4RKVfxIZXkvAptbyEqsHhd3oHk8T9uH2PGZD4k/SvJK4v
         RVfSgY96+bJwa4jhAm5Bid+duA2Zl5cKI8AsvaCNfswjNtE4BzfNm6LWihLFgYeyXogM
         oBRxMwna+KdkUyJ9oWiB8jzPkFo/MsFKtXAVxZ6FXh/CoVm+7rWGJR/uHd52G1pvPfAb
         5rSaUzXg208AyojoJqX8/kBRJk/iaFExb3rsByQyg5VLF1sdJqTafkpXgTPYOqdxZWFk
         1RfxkCMsqZ+GELGbWYKMjBb3JxusG09oejiCBLcZb4hwa37rfzT8ftLWSG+J+0+wlGCQ
         2bIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763753848; x=1764358648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJM1mZpGIoqjTJBi+7n1u/HmWUJqp4d9cJ4oHyspqrY=;
        b=htfOd0qMuy8Oxh9ef0t/cWiWx6FWsu18zbELRNXgaiNsOX3RzNul+znadSv/B0VISo
         mfBlBX0Bha7aLdABAR0tdrXBmNDYvgxYeucxuVpHjZlVMGSRNb1EeHCuSInNxi7V7C2i
         oUqNCYtdhrP0ty7VrvxnGiFJZeuDy5m6VnM4/gdKmGykuU9CBrcoWltWzVqE3Mf9onk7
         nYn7GfmIHUCsp91m7ViMHi59a9/S/Kdz8pbauVT1MaUhgziExjdM22SWzdSAd7xD/Bpq
         CKNMZ/lNjqY6pNJ2CMSp0xerIsJfmd28pKweLwJoSL6Z0+UNqmGO4yzA7Iolp2gOONFH
         C8xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxPYU8E8Hn3bwRUVrUZ72augdP3M35dTb00NQV3IWqtnySo4Ubaz46YddcVzd/PUrOvBre5cE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiuGBwgKB89h7lDZGWKUdKeE+E3w4InEWT58aQX66k5VKHN8sg
	f5XJfcGfdMnQxYl/I4PUj4YXiVVXS6Folow1fd04dSERdWglYnrrRrGm
X-Gm-Gg: ASbGnctideuBcimg9iLGm4KSsks54kcnpwInuPf1WuiZzfgJOBO2PlLzPhJ65HEFCFW
	QL0EtcfzqWoTbJbQA/3tB8LyPeG0RtNsQsRHso20Ou9QxCMRgacMYiUk/wIn9S4uZNbdqH/fNzx
	gcDH0rdUVHpaObTaWpruw0eXrAUXWNC4zCUvo9JpxTk4sR0PbEjsC7dHBzJHkXgTz2NM61P4UGn
	HP2O4vRgtIGcJ/ihiJv8sygwLGGWiljKcwKS8ctWsS+dGDbRDQe5XmIEM7EiotvLzkpg5jeI7ZO
	EQOYcyetnRjKojcVJY/rHWkRAMPQjKMJ9zPhfIyH2y9M3/Q0ThRNSyUb3O4sOcbY47rEnu05PRr
	BmEPjO4dshYsRxyAoZllc/RiwmcoWRvbjQ+ER5KxQMK6y11M1u5S3zz1am8mZY1EwCIX5IVmfZH
	Gk8l4=
X-Google-Smtp-Source: AGHT+IE3zswDLhAtOxPxtN3e0zQWCopDK2avgOY05M1JcEMvCUwdTqXrYP7mxELJXsHw+IAadTlULQ==
X-Received: by 2002:a05:600c:3514:b0:477:a450:7aa2 with SMTP id 5b1f17b1804b1-477c016c020mr19801875e9.1.1763753848160;
        Fri, 21 Nov 2025 11:37:28 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:b19f:2efa:e88a:a382])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f3635bsm12773438f8f.17.2025.11.21.11.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 11:37:27 -0800 (PST)
Date: Fri, 21 Nov 2025 21:37:24 +0200
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
Subject: Re: [PATCH net-next 05/11] net: dsa: rzn1-a5psw: Add support for
 optional reset control
Message-ID: <20251121193724.djjtzqg3q3r3pl45@skbuf>
References: <20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251121113553.2955854-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251121113553.2955854-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121113553.2955854-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251121113553.2955854-6-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Fri, Nov 21, 2025 at 11:35:31AM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Add support for an optional reset control to the RZN1 A5PSW driver.
> Obtain the reset line using
> devm_reset_control_get_optional_exclusive_deasserted() during probe
> to ensure that the Ethernet switch (ETHSW) block is properly released
> from reset before initialization.
> 
> This change prepares the driver for use on Renesas RZ/T2H and RZ/N2H
> SoCs, where the ETHSW IP block is connected to a dedicated reset line
> that must be controlled by software.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

