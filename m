Return-Path: <netdev+bounces-173410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52750A58B2D
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 05:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCC3A188D6D7
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 04:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2D11BCA0E;
	Mon, 10 Mar 2025 04:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMPTrF+8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7221537A7;
	Mon, 10 Mar 2025 04:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741580595; cv=none; b=WW/SMKDfQpKGCHuN9vX9ZvcnowJ7++uJUHXWMJWhj/zZ1SHpN4mJ295t/A5O4R44r2qAwz8Zv6kvdkXhXNcH1EivRnAOxz7GT8inx6KjBLLKu4ncYH4tmiRposk6ZxdKaZ02IGquBG8SRCIh13qMxW2xNmEfKQOzR7iXiVvoG7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741580595; c=relaxed/simple;
	bh=62c0RD+YxE4Wo9QO1+8kjeiytsGGNxXazNbcwI6B09k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lvqoMGwCb1GTKmQCWDOtMg6+EFEEXsZceShkIEOzC9OadMnhLgXmUoB6AF02bWG5qTOhvkKVouL1J6vLwmWrAH63A4f+q28a3sSL+cyN3ehmFTIlQV7cV9++d56gp5xNabKqloym0OTKIUAZFZ+TW+78TzyUKgF1h48+WB7LZc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMPTrF+8; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-471fe5e0a80so32775401cf.1;
        Sun, 09 Mar 2025 21:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741580593; x=1742185393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0gvF91ZJdA8vs8FXl/3hN19Y7G+bneODyyzgzAJB8U=;
        b=DMPTrF+8y+FgmJ9oWrS7PfV7kNInEqE2enCns/o79jrLpbPMKrugPuI435oexBBr6f
         fuqzBQvEAOQiec+oPb2BmvGc/HI4/5RFR/K8gUV++Jz+lKCv+5GfAs5XNOH1orGGuIUZ
         5UZilmLkbltzS0MR0evqyVeIdUGUtvUwovBsyricc/tBa0S+dvnm0vdJ7sJkdo/8hT+j
         CjuZUS+LjIjuWc/buem+Huf0cTlbaXVZLCD4olsE/yxdwWlym6AaR/eCj0gAie3NlpxA
         C4kP7Fb/iA1TVjRvMVjHnAD+858kvWfWuxSUrnPv4sOTaTEdpYYiKs2+iZC0gq5H0SAp
         rdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741580593; x=1742185393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0gvF91ZJdA8vs8FXl/3hN19Y7G+bneODyyzgzAJB8U=;
        b=kmvXig6LAe4PVJuITv62aS2a4UxJjoKcA7KtavtZMyhaMNqPELSUAPOEWfR1wblTec
         n6kHtRp9TK7WYLtEuFBdAh7cW1FVmEtYwtRvxNqb7KMEJBEbYstT5qzFj70vFMR5jiDV
         YhLZBa71wVl775OFNAYahzqxVy1+08O3iXg+U5qnI5xpFNPp5+QYh3hVoFEu6BglEBgQ
         nMbGFef4QlHwLP4e6IxVnOGneuBQr83Cc9CH3AAJK2ztc9Wh0aAuYt2fCQvuTfVl7jrs
         nphtG2nOerYhFaskYbRBsJQUWJfmXhDR/vR/Qs+Ms9uYzXaAgJlbh95d8bpKkNscH6SU
         vakw==
X-Forwarded-Encrypted: i=1; AJvYcCUKz32HWo/vPEKlMr+ZfJqdirSayK5aTDrTaiPcNizs5i0Cdj7DQpjdKPzIjBUpTaB9N8Zz0S/2@vger.kernel.org, AJvYcCUNHwD9KGor2MXpQQq+HW6c1gPk5yJDmDaYhRv6Hi7+KHqw8mn2FpEBC9hSWEnqHR5dQR6pSfUOGu5/Dm1a@vger.kernel.org, AJvYcCWHp/wO7yC9jIVEhGjVTcvACvp9dAG5CGh1GPqnGVOrUOr2PLTIYjjyzoZTeONKXlshibrVV7blOO24@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9n9azFSvhbR0HDAzrDzt1znQqEiJmsWjjIQUd4IaEnXCxYdll
	fCGd78ZacdiCcgrHzfMdyJfx7VBunvnNAZqOGnZp70W1BZlpjEvH
X-Gm-Gg: ASbGncvhplWenrdER20Y7YJUbR8iI8ExUIaxKTFL3XDAbNPJb7GTARlupFqVAihjhVU
	j9F+XwLjgv+0Hwb9fghqYBEXNdIq/Zli8Qa9tKfyjFVGPfjn1om+IUHU1yPMWKV4eyU9lBn3Ddq
	KsJHY/QY23IUIM9EZoUesv62t2awlWK0EOTsTLKZLIXNrDS0gmxu+YkJU07x/CHWlQE6epMg4fR
	tJ8tGbtcqW9fez6GTYMXldpnfUePDOTSFcX1aj0nC5AbThPq/ncjta89F1JGtaF1zR7HmMmv8vz
	mZtbYtYVozJbG0gy008I
X-Google-Smtp-Source: AGHT+IFa5FvD8Q+HfgrKvsdng+6SJ6uYosnhp53MikJ0vblkdZDvMi04uamcmlnlcuzE7xdu4K+eFg==
X-Received: by 2002:a05:622a:15ca:b0:475:a5a:113d with SMTP id d75a77b69052e-4761097d4e8mr175686521cf.14.1741580592911;
        Sun, 09 Mar 2025 21:23:12 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4768344ab36sm13774281cf.9.2025.03.09.21.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 21:23:12 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v3 0/2] clk: sophgo: add SG2044 clock controller support
Date: Mon, 10 Mar 2025 12:23:03 +0800
Message-ID: <174158054219.311416.9651103100123387748.b4-ty@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226232320.93791-1-inochiama@gmail.com>
References: <20250226232320.93791-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 27 Feb 2025 07:23:17 +0800, Inochi Amaoto wrote:
> The clock controller of SG2044 provides multiple clocks for various
> IPs on the SoC, including PLL, mux, div and gates. As the PLL and
> div have obvious changed and do not fit the framework of SG2042,
> a new implement is provided to handle these.
> 
> Changed from v2:
> 1. Applied Chen Wang' tag
> 2. patch 2: fix author mail infomation
> 
> [...]

Applied to sg2044/for-next, thanks!

[1/2] dt-bindings: clock: sophgo: add clock controller for SG2044
      https://github.com/sophgo/linux/commit/c90eac0946162efb7436098f25e21f02bc483ada
[2/2] clk: sophgo: Add clock controller support for SG2044 SoC
      https://github.com/sophgo/linux/commit/135418add3878dcd44483d0f2851f6f470a85395

Thanks,
Inochi


