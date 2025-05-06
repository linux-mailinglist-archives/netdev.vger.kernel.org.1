Return-Path: <netdev+bounces-188500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0C7AAD1B1
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 01:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3D41BC59D8
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 23:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BC621D5BA;
	Tue,  6 May 2025 23:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiPHhhQZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25B0214815;
	Tue,  6 May 2025 23:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746575367; cv=none; b=NxglABRp1oi25lR4ekPBJKoG5IUBPQsIgmHu8F6q5DFEXy579M/erEZFNWSIqOTFMLKzrNHZj8ueDH9pHD1B1x7jANpARszTr+MAgFaaoKlJHZesHM6GdhncT5VDFQ+y6ehN4dd3AZmHJ9g1tRyQ0JVRhaW1BWsyICEBc7IG8lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746575367; c=relaxed/simple;
	bh=bN6Xre6GbjWnrrHg6esYssYxyunEvPUSznLL1o7vQYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HfY1+JMiG5EQBqn+lxwYB10azz1WIErabxrtlhzd/MbvTSfT08aDYB9qObIpSShKmUZ9xfse1uL4NsB/OCE3qH9jWNet6qGyDWF33t5nLASmuAkkbAl4XrzGNVg1JmGYb/pYYbUR94xTv7nNE0OoPmhLLr0MESUUIc8mhXLpGFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiPHhhQZ; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c56a3def84so639874585a.0;
        Tue, 06 May 2025 16:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746575364; x=1747180164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLfEz//YxlWSQrp0pxzZLIDi5MwZhlRnzYF53iBHKBc=;
        b=IiPHhhQZhSdi0GKGu2f2hiqIwIhFEVgR7jxdBoNWOgKlcJNTE32DydpKmebAk5irRg
         rfVcWvEXPaHyLVyd/NrhGqo84s9+Wnq50bhSgv6IkPUowihP/EsP1Qbcj5Exyiwa+90j
         cg5AnnRhtTZoU764bH7NfjZ+EdFRvM2zPyRSdfephAtTe78EP0dF4CkSSrvB2ILd1+36
         N9JcqbqpguVzXuYsnODut1sfb53btZzh+uIchFaaaLMeOGb2zrEs/s2iXjQbGLOcu9Vo
         hcO/4+3D+j/UXFV2w4g0OOrlPcwUfKXahPO4SGdqzcxeuWJ54dH2t0NQW3Hrf7S00enh
         y/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746575364; x=1747180164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLfEz//YxlWSQrp0pxzZLIDi5MwZhlRnzYF53iBHKBc=;
        b=bi/OvKbHWz6AB+in4NpXxePxJeSyEpnXNUCs34VqX7ve/sgZgeJKSBUwBP/9e0HczX
         dsCZQ0KjKm9egxDGz72likz6Uu8jADZEoMw4jA8KVgS2y4QSLBqWdjk9nGqub2dc57o8
         8hbTWPjuWv3Z5qRiY0WKwx+XkYOwuOwM2aehV0voIfrTq3cA1VPu3clPD+8n2qujDfd1
         dWWfjeLckm6DSTbu65xRRgrScDdr6nd07rFm/oa1lVu58gqHXPHWs2eWzKW/5ryRsK36
         z5Zg0UInDCnwR1NiGr5FOri3kIjDHPZ3mUkeIDPFolSrKEv7PDWqrKt/irGDlHB7lxT0
         BLug==
X-Forwarded-Encrypted: i=1; AJvYcCUTpz7rxS4xBn54+k1qENc+D5kSPCR2OF28HWHWgHwMYVHanlNVgO+IcNVVJkmdUQeK7SgxlEDo@vger.kernel.org, AJvYcCUanD9MkAxqBx4edOEN8W3ASjsd1MXy1uMDYP4iSzDkBv76txS2zOAwL6exz23H8ilYv+Bu+iv8LBtg@vger.kernel.org, AJvYcCXn4B9Ixsw2COMwXZoiUvgWtvNlnNSo9X7NCT9nDC5fEdkHvjYE/b4AEJfi/6QBiTzM2Vb6FeMC3FzUbQOq@vger.kernel.org
X-Gm-Message-State: AOJu0YwDGXww7dbAknumRpdn93mRlOdC5YoTkZ/ZbGBpVDaLt9Zo9IXx
	iMWuIzvR31ZGV9CC15e1/LpXvfVJ+6xsSJ6CC8fBD2QXMR5fh4Ll
X-Gm-Gg: ASbGncsSRaR37p1A5qkwHkslI2r/UVDGnvyFLkF6AIFiLTh5lh97UhWlJeDIOMiUHX9
	NLJp8NKS4M+plPZeaEbGvG9XbxLwy2F75U0zxYUZSz5yT8NhMYwBPGw0eIqxgDw64xPBHWCu6L8
	xksB0KaLLi3xu7VpnNCJFMH6KMxu7Lt9TPa4KjeoHZSB1Bypgp1nWd2W58jL3bjNU/VrlyduBTw
	0KwkhEjGLEhE1kQhiothleYdIpQbLs3k8uoif72lVHv+ahJrXQmnRzzWi8ecxyJOz6/gVur9Bf8
	n1dU++U7lx3YyEdF
X-Google-Smtp-Source: AGHT+IFNc9H3OqbhDKWVWD4by0j8urZWA+6ou0PeVS7Ar9B3flHhOj6AnypYnW3OvckJNbDCCZLsQg==
X-Received: by 2002:a05:620a:f12:b0:7c7:a5cd:5bd3 with SMTP id af79cd13be357-7caf73b1a87mr181273185a.28.1746575363534;
        Tue, 06 May 2025 16:49:23 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7caf752b635sm48956385a.43.2025.05.06.16.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 16:49:23 -0700 (PDT)
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
Date: Wed,  7 May 2025 07:48:58 +0800
Message-ID: <174657533290.212327.15123615268219732476.b4-ty@gmail.com>
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

Applied to soc-for-next, thanks!

[2/5] soc: sophgo: sg2044: Add support for SG2044 TOP syscon device
      https://github.com/sophgo/linux/commit/f18198c0de56ea636c74312bd09b9d67273412d8

Thanks,
Inochi


