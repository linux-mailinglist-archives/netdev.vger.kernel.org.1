Return-Path: <netdev+bounces-185711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CB1A9B819
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 21:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03981B8313C
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 19:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB14B27F74D;
	Thu, 24 Apr 2025 19:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/i4MmGm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B2A28EB;
	Thu, 24 Apr 2025 19:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745522155; cv=none; b=hUzoyGx7aAmzAsuyN93jSpp0/mwaiGeYOva25qaEMj5zO6RA8bcQLGxfcgPzEZkhh5FiwYvkQq6fBQql+uE+egCEIIwtWXmAe3d1T2ioH54cuBN8fzl7jpTQbScaIiy6aPSYBuR3l37ot/EYz6i6maskCoqUJ6EC6f8yvTpWkkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745522155; c=relaxed/simple;
	bh=xaX9GfEYK9n44mlY1Zl6aj7j0/jFobvrb6dPwXaxJfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lD6DHUFa732MOSdBLBFfhiMehPTG+fVFBvVsJpRMhiAiskV6CPzm6rCrdJ5OkPP+8/ll90rE5plGAlnbDA+mWuXbn1Pq7XEj3O5h51jC1pOsk/BEuN94mj5G8v9XyeDitNbpzBjCQIhmNxr9jXfvMSSAx8WIkuMqCcc3m+yP8J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/i4MmGm; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39bf44be22fso1044988f8f.0;
        Thu, 24 Apr 2025 12:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745522152; x=1746126952; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fg/5CSYGx8pustO7TFATB5SoThu17c6gLk2jPxapenA=;
        b=S/i4MmGmZ3x33iKRapuN7SIfMHh3t1hvxsS/elwur8GpyRzx9Z07FXZAXrzfgm7z7F
         qeuPB6FZsC7dQfo1x1+5z7UG4Q5Wz2CTlapvSs492AYCfTLgsZyH9seAF3g7nzcSzEfU
         f4U7zS42OKn/HMnawgX4UnUrtORBn+zgstwpgdbm1jft1TT9cNSXUan6ZYuFUnGF4aFV
         lTWOT/UzbmJla/6lyYkj4zbQABns3eo7bJfIicof8z38jsWGwkJerCR9NJTm4eAuEYHV
         2CFtCUMghSUo0ti2DVUWOOsMGgyOPkL37MgCqPdmF8eSzF0HwYgTbIelnJKzmuh9WkMM
         Ewew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745522152; x=1746126952;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fg/5CSYGx8pustO7TFATB5SoThu17c6gLk2jPxapenA=;
        b=bD6ypI1hs51k5v1jSok+KqOD4unnWELWcuP2LQH7fAiG6HIRbBVzQehUdJSDfxARf7
         P3fYbpLPfdlJsOVYnTyo/fayAgXMIrpRPqTLy3efX4YMmuFsF6tC/0SgdeWe8EirzU+d
         bgQM6rwHViQdDHnl43uDxeWRTxGj4OBfRCVRRAGvO168jr7vbH292LGCUKCE0UASVfzC
         qAU2jAjacssmTuO6sEnnDRWdZmlbwMxE1ZSEP6xmUXt2RH1E/QC+GCoWKm3tjUUVluNl
         HKbWU0G4dfJZNbbfY657Cth8SDmInmJhUaimcRSuGQm/CGzgWFZpz6CF7H0CdfndhVp+
         m7qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCHgb5LanxMjAbs92QGYBEKg/qdtugoVe2BU5KP+vPZk/pbyRG2Akoq56xVhhziUr3I8VQpRRz@vger.kernel.org, AJvYcCVMHr4O0wp9oagfTQE7CF93Vo7Z9XSdNaEtJCl7SZewdzFm5jzvFFRVwEM1NidhuiuYVds2m1vVFJ2g@vger.kernel.org, AJvYcCXirzdz4vR39f/aEgWgM/aYneHPG3kknOW1yXyLnCzs4DDVZZDpj2KudiQkhZeBFHTz6HJfFkdYW2YObanC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2IMPDVXUuhtY5aSH8DNm8eNapWTudl7rv6mWvlJj7TZekC9lE
	lm8YkLAAWLXvPkfJCrdSfSdd1cLiVOcBn4Btcu6OGGwvJRKt4tAj
X-Gm-Gg: ASbGncsSJ6Sg0DfHjR/oNVAMZARaKWCUClke9NMG9WvZECw0pSLz9CmwWJTmcq8jmEm
	mGFQCgtysoCPcU26pSlNN3bzngCw4+2qtHLqH5vDPXjR0ZjAV8xnfiJvHc/eN252ZlDcjnGMVcy
	gXS5EXauD4TwaN2bklpxHFNvYUFpamqv1Vj4xep7DxzoSpblxo0z7T62imWtPYjno5uZ+QDBf3S
	QP1DOQwTSUpFx5i0HSO6p1GdNrchbg2hrLc67KrZMEba9PoiGi1Yl5f2iauJt4ibC3zhd4olvvi
	YIb/3jwOa/lUAjH8TP19y3rf6CfEiPFQuzT/f2envgYbtVmarCAo
X-Google-Smtp-Source: AGHT+IGDtJkWxzHCs3qBzGx1s0jq+yB7NCM4c9k0cZ/pHOBdBV+p+7aYjAospsSGtI/LXj666TeSig==
X-Received: by 2002:a05:6000:1ac6:b0:390:f6aa:4e80 with SMTP id ffacd0b85a97d-3a06cfb24abmr3545024f8f.53.1745522152219;
        Thu, 24 Apr 2025 12:15:52 -0700 (PDT)
Received: from Red ([2a01:cb1d:898:ab00:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a073c8ca99sm161810f8f.20.2025.04.24.12.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 12:15:51 -0700 (PDT)
Date: Thu, 24 Apr 2025 21:15:49 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andre Przywara <andre.przywara@arm.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 4/5] arm64: dts: allwinner: a527: add EMAC0 to Radxa
 A5E board
Message-ID: <aAqN5cKdDr_D10LX@Red>
References: <20250424-01-sun55i-emac0-v2-0-833f04d23e1d@gentoo.org>
 <20250424-01-sun55i-emac0-v2-4-833f04d23e1d@gentoo.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250424-01-sun55i-emac0-v2-4-833f04d23e1d@gentoo.org>

Le Thu, Apr 24, 2025 at 06:08:42PM +0800, Yixun Lan a écrit :
> On Radxa A5E board, the EMAC0 connect to an external YT8531C PHY,
> which features a 25MHz crystal, and using PH8 pin as PHY reset.
> 
> Tested on A5E board with schematic V1.20.
> 

Tested-by: Corentin LABBE <clabbe.montjoie@gmail.com>

Thanks

