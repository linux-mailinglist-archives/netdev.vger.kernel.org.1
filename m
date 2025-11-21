Return-Path: <netdev+bounces-240861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A5DC7B81D
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 20:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33C6F4E74E8
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 19:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525942FFDC1;
	Fri, 21 Nov 2025 19:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUmURNMk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90045229B18
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 19:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753229; cv=none; b=X0rDymMntzzjsMNMp9yWZd71WUds+lq+wKDrEMKPYjdZDhSza7Asui/HFiKr1cNpR08D8Ff2aFiK9JKJj9e+aefdlvUBfAvU11q3lkMvc9QnzjzTHKi6PSy0uBq5g66xmWjJU5EKpTNPzqIFY6CREeo8qUl5HhLPY1izocU6HG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753229; c=relaxed/simple;
	bh=FpPmrNBuKiuzYquOiGtXWIrHTqyVgbm4VpSHg+nibLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iy39P7BXTMkiUW0PePJ4pL1+Spf6ZSvAzJ6f2tmTx3axzlxEH61wt8qrTU/v4KsTwsCJFn69q4KoD8LnxcNARrIXLt5V+SGQ4a0gTz+miTcagp4wOrNhe3n2gKYqTkdIlS2zInR201Vdcl3OLFT7QW7VbmD8walsxpP04lcF36k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUmURNMk; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b2dd19681so282816f8f.3
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 11:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763753225; x=1764358025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ky8MNRO/KnATv6ZPDH12/iyZld6BKAT4bhit2Vz/NhE=;
        b=NUmURNMkSSSvu/Pt6XrIvcoVrYsa+RYkvGHH+1jx6uywXx8A1PiN/H/Cwyrk40dmEH
         S/iRmkHfSBzpaz+vWnM/aKo4xJSwRe0TdbOrCJLdjlfqSdgvaSjI69fEn0duBILZy+cE
         y5VPz7xTI3x9k++cpiQgFAo/zlnchHgEOgJwJGs9IidFQkA8KMSXgV4tu9uV+KaEgbH3
         930Fo4NQzD1ktM5fvXAzwCVN5WS17MVP5r4FN2G1k01C+wDkj31HuujZWfbthOAwNDHu
         0AL9TzvgCN7zQ6JibJvuse3opHfD+jhmmxW8VSY4SFPjFw480j3vw7/M5iLjbln3KlWF
         d0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763753225; x=1764358025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ky8MNRO/KnATv6ZPDH12/iyZld6BKAT4bhit2Vz/NhE=;
        b=FYrnXCMez3TLDqFq/+dr5YmKBu3oFrKy1nWU9TSRdjc96/jDcHXq+5VcWQMBjTxoei
         ttOCGp37sBYgWTuiEAUlrsBlnH2RhzmPUkCBEATbgCmmlqclE8MIEMqvkFTRPrM6+VQW
         B2jbfAvUwkXfCOfEMG9lpFTnFBa+/TjKUa3aEjuZomiSgbzwcjDvMr1NBY/h6uMaTpRk
         2kdO2+igsmP6dfMwTRdfhQevpC7HW1D+8wavkPJEnOzZ9UBSevn9hgi+F1OfhUP/M4uE
         GL/Ke3nm8mn8MDatLBEGvcFEgJvK3zopvzHRpqqP1feDEjcV9I+KPXN/0O+VGme/Y4CO
         fQsg==
X-Forwarded-Encrypted: i=1; AJvYcCWLZykKYw0eQ2fwEVk07Ljeqk3P3qdl9LHEZgQABA7Xz/clZQ5shov9GdkjsQFBclPUUtcbTqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPsCQ3R/mLLgFdV+W+JrehHyXhPrFJiAPuWmByFEhS72Op3x/m
	Nnh6Ua1pEw0YmV+ZR7gVglGRZCleLmqNq2OeV7gEg0mxEXU+1xE5OI0h
X-Gm-Gg: ASbGncsFMeXouc1uSZvm+BIx6HwrGOxWI1ZHpQIpfqBnLI0GcgLYQpgc5QCtL7jHjBX
	FfW8nZ+5h1OrHr8wUgXZ9eNA5IyHSgYNKqAEnnWQadbvbcec29mvUOrSWZ7Q+U8IwurmkBUJ2y0
	Ryb5ngk3arRO+ARBu1tJ3FTz4HfGF14FLfBrtPs7VajwaDzAJTPnruYVd0tM/1z5NVVkuUNAnAF
	SHBzAHUVJUB/5SypqLqEAmk6LSeVl8ga8VTKyPcqAUKQp4qO0rlv0Ob/bnWB7CtXFXYAd1mkqZZ
	6R1fbpNvgYtGPW4MwX+j42qWkqaRAT/cKU8A0WtEqsqXsNPYg0/oa5QVB/3/lgGsKT91MZDm8IY
	2WtHnsS+KINre3PrEA/5NdgyrRcwldpgSjZfmIOcEWHje5zQxy9/4k2skBzO8Dp7We+T10uQrc9
	ZEd2g=
X-Google-Smtp-Source: AGHT+IE348ikYusVnT2VGIZWl+evV/447ueHW9w22vcPuRfWXrW3lvJtPVVGuCPdYxsayq5bsL3b5A==
X-Received: by 2002:a05:6000:1863:b0:429:d725:40f0 with SMTP id ffacd0b85a97d-42cc1d13128mr1881881f8f.5.1763753224516;
        Fri, 21 Nov 2025 11:27:04 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:b19f:2efa:e88a:a382])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f34fddsm13036413f8f.14.2025.11.21.11.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 11:27:03 -0800 (PST)
Date: Fri, 21 Nov 2025 21:27:00 +0200
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
Subject: Re: [PATCH net-next 02/11] net: dsa: tag_rzn1_a5psw: Add RZ/T2H
 ETHSW tag protocol and register ethsw tag driver
Message-ID: <20251121192700.3eg5h2eqk7bruxeu@skbuf>
References: <20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251121113553.2955854-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251121113553.2955854-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121113553.2955854-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251121113553.2955854-3-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Fri, Nov 21, 2025 at 11:35:28AM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Add an explicit tag protocol for the RZ/T2H ETHSW and register a separate
> ethsw tag driver so the existing A5PSW tag implementation can be reused
> for RZ/T2H without code duplication.
> 
> The ETHSW IP on RZ/T2H shares substantial commonality with the A5PSW IP on
> RZ/N1, and the current tag driver does not touch the register fields that
> differ between the two blocks.

Tagging protocol drivers are specifically written to not deal with
register fields. I would like a clarification that this is a phrasing
mistake and you mean the packet header fields that differ between the
ETHSW and the A5PSW tag format.

> Expose a distinct DSA protocol and a second dsa_device_ops to let
> consumers select the RZ/T2H tag format while keeping the proven A5PSW
> handling unchanged.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---

