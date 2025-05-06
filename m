Return-Path: <netdev+bounces-188499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A358DAAD1AA
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 01:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213FE4E7C24
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 23:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFDD21FF40;
	Tue,  6 May 2025 23:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3NNdfOb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F9321D3CD;
	Tue,  6 May 2025 23:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746575189; cv=none; b=u3jNTkPlDjKshzWpZDWOe3zO/iLh3nvj2SYfWarRgZ+YzNJdeAbJ8E1+fX56Aum6yYHvatwix3r2Ai74lNzmMFAKKvNe5LWh1ZWyU3VDF3ZcmMO1EmTOfaZOX71jN11MOfqZQpXcQLsRpoO9YcNYPc/ljdmtL7jMUzbZmMExixE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746575189; c=relaxed/simple;
	bh=BVt+VRnTimWp4JzuHa95+Dqz8viq8EbnD6FOmmPQr/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/NBEsfeVJYBToWznoo/ex3gjaYid3FxVbjyloDEi7ww/JOv0XilecXsTOuXmP5Z6qSlzula97ciiSTcKOFELfV9vg2JDzQbdATpTc/XbFaYpgkMSsI+p1DUr78lA4My1E7TUmFIXZyw3jM8+2lpRL7ihb+YVYJ+4Z77VDXc11c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3NNdfOb; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6f53c42cea6so10296816d6.0;
        Tue, 06 May 2025 16:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746575187; x=1747179987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZFBhA4aKbh9bxYzKReOwT6rRAW6REfyh6NppyF3T58=;
        b=P3NNdfObSVRJxQejBqYUOeh4MaotvPrFpFf+nwFQNy8jFVxzfYEv/50c99umEUM977
         mEFcJ2DH84tKKA7Y+j/ZEtJ1B2DshsugncFW6TDeGpIe34cXusyKOGLQit7kobBDAJmB
         9rWbzCHiMJf3f+MuCYCB25LaF73xvPOxqC9K42Nwulphui0fVw5ANT/HlLPnBQhq0KZF
         smoTQDzT6s8zEl8/QaZVki8+1P8QuIefY72pFn22n2XZlZnN2rrwWJuccyJcU0u5fo6V
         Ss7vImBb3pEV75IDotvr1ZVysfOtCI3qTlFz+AIThp+6EYafB1JshAApfG9dPRist2mD
         ZWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746575187; x=1747179987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZFBhA4aKbh9bxYzKReOwT6rRAW6REfyh6NppyF3T58=;
        b=jfrQrr2LWn2kkLkieCogwWRHqwZfgMNCXs0kqjo+NgsSuX2vd22Yv6TsBj5bw48Vm6
         tOs6tTTupBXwd4YWxxRBsLweqzheozj+aO+TJ8COJD6kKyvowlh7S2RVdCe/9B0L2Ha9
         B5s0+l5d28zwWWB1UdH3NLjqjJ95ZlOz7KOmHoiCx1tCT0XAayqwQNsgRw6r9dwWsYcx
         SrAlR6Gd/1CRbL3piTH0Yr0DFvuWY9LZXWafOwNf63/E7JtfiRIpbotETnwFYU1k8o15
         zGWj4xzodOgZf0bKbG/S7ZYN03Er3eRvSTz0kPs+1HLfCk4Z67K1wPBmscIxVBoNqLlj
         jFuw==
X-Forwarded-Encrypted: i=1; AJvYcCUOI8OXYEZW+hg8Z9o4jyWvTyEG6NjTC/8M9FLYWAMXcHjqhTKGxwF6dSCAq1D2SvEE7aiVxKKX7BlP@vger.kernel.org, AJvYcCWfvsIH9TembGIVzXBlkyxZzNiR6PF5eSHfrey3JKip10xsTKcAmkqetdVUVpWAlQEMZMDHSx1Ul1vznzJL@vger.kernel.org, AJvYcCX0ieEjcFClUYNAyHlcGu0zK6HHJNZPN2SKiuczuDomiVqepdTAQR7r4cjurhhsPFtcK4KWLnIk@vger.kernel.org
X-Gm-Message-State: AOJu0YxUK9f/qi0PqYXPbHjSvECV3mjI328I7lkTz6xKU8p0gWCmq4hS
	rny+xRlTHg1WrNAI0MocBAuUYHBXrp8o9XpU0PByuZ/kCqgLPDoh
X-Gm-Gg: ASbGnct+PxU5dyV4vjNA3VC53Go4503Ng/BtinNGU60uglOM/KwCJzScDqT9MDTWfjT
	Or8vqO5PpjpdQqWyX+6TO2FA+2B1oxNIkwuc5GIG4o8TgvatoWkxtL86vahc220+fSW51lz8y6Z
	T9PcpP13Zh2sfHSBxOI/8mv1e6U+Cs+c/7f7wvmU4FeCTKsBsyeJvj5Z78AW8IoPlOBzL1DQIuM
	NIecB4oqzxHjcjsik2y3tDW4aWSJjy+idFuhdrVtb8klUeCNzkwSBzQ1IIPzWXqNhaA/Nl4QHPK
	fZj9f4lsobk5z92x
X-Google-Smtp-Source: AGHT+IEjDlSavtkzKmbSQrqTC2t30r5tt5AL3W9m2wrwiZipklrvf6FkHZGOwnr9K59YfepX2GVs3A==
X-Received: by 2002:a05:6214:f04:b0:6e8:f4e2:26ef with SMTP id 6a1803df08f44-6f542acd327mr19125306d6.31.1746575187083;
        Tue, 06 May 2025 16:46:27 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f5427e2023sm4083916d6.125.2025.05.06.16.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 16:46:26 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: (subset) [PATCH v5 0/5] clk: sophgo: add SG2044 clock controller support
Date: Wed,  7 May 2025 07:45:54 +0800
Message-ID: <174657514016.201370.7208767895794181355.b4-ty@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418020325.421257-1-inochiama@gmail.com>
References: <20250418020325.421257-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 18 Apr 2025 10:03:19 +0800, Inochi Amaoto wrote:
> The clock controller of SG2044 provides multiple clocks for various
> IPs on the SoC, including PLL, mux, div and gates. As the PLL and
> div have obvious changed and do not fit the framework of SG2042,
> a new implement is provided to handle these.
> 
> Changed from v4:
> 1. patch 1,3: Applied Krzysztof's tag.
> 2. patch 1: fix header path in description.
> 3. patch 4: drop duplicated module alias.
> 4. patch 5: make sg2044_clk_desc_data const.
> 
> [...]

Applied to sophgo-clk-for-6.16-rc1, thanks!

[1/5] dt-bindings: soc: sophgo: Add SG2044 top syscon device
      https://github.com/sophgo/linux/commit/e4b700d38957526fbcec6d7bb5890ad4c1192241
[3/5] dt-bindings: clock: sophgo: add clock controller for SG2044
      https://github.com/sophgo/linux/commit/1a215904986e48ce04ac8f24ecb5b18cb6beaf43
[4/5] clk: sophgo: Add PLL clock controller support for SG2044 SoC
      https://github.com/sophgo/linux/commit/ff5240793b0484187a836f6e1b7f0e376e0776ed

Thanks,
Inochi


