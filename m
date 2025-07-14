Return-Path: <netdev+bounces-206476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF18B033C2
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 02:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0E11888A43
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 00:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C557C1547C9;
	Mon, 14 Jul 2025 00:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYI+g2de"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C942E370A;
	Mon, 14 Jul 2025 00:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752453896; cv=none; b=i7Fg5QyPLKG9til+VbtzXHLTqCnZIhqD0kgGY0HwzhD22QIcWa3D2ZPlGCj6e/V200hTpWXQRR5dYeu3q6AIAKhLcHnEnmG0Clk+uC1kBh4+ihHY438ns5CvYrAOZmUW7UgyrTi3tXHfGpHUmUIbdPKf58B82EmL3kZhTspYALw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752453896; c=relaxed/simple;
	bh=aOgYGuJVDNzVBvVwPqsqAaluryen7EunH9oddumL+ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bPkRLb8YdlQlq0huJ9C8samBakIjqiitXwca8q30rqcOpVG/WBaynCcD8lK3VG/cCnENz14auDC3fNQKYQfQhX+yFZ6uqPac9lCtmaY9UGZh68LBfeUFT33DbiLz8G+DeQjnzKkyGTrL8wfj9LhqHN3K/FRK96Tj2SjX+lBG64I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYI+g2de; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-748e63d4b05so2157557b3a.2;
        Sun, 13 Jul 2025 17:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752453895; x=1753058695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLeYUFYsbjTuUrfuMR1HqB0mRDFpmVI0gLEVlp8hfmk=;
        b=CYI+g2deHc45CbO/hWxUJCgcjifDLU2UOhhYfhyXrEgrcfUhV8au8ykcuRqnH6xdnH
         4lU1CjFax1pT/9PAfNDTV5vG1V23GBADbNdVmz8Vpk9oYC7bpvxhGDjt5Xr6rvKKa+Iu
         /uFz9Ke2S6426LL3g3AYbIq9jVZ1GnBRSsDJQO8cCFjShqh+3UYHkoQTDjOCttWgBo4M
         GSDX7kJtVI/2vA5SPeB2NFwJmh0w80nEA1TL1f+MRAv7ZvgLE6FbNgEWDbMTS9bwX8SO
         UJhG5/in87dCv32yraGXBoaGdZmKbQ1bEkXNeL1va2O9V33LoU7VtqB4hC+naIxpoO3o
         ZsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752453895; x=1753058695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLeYUFYsbjTuUrfuMR1HqB0mRDFpmVI0gLEVlp8hfmk=;
        b=xBQkOy+WkPX0rZhJI1gT5eam6W0JFm7kTXFvqEw/iI1uOTqbRQhcEVklpbUG1aqYp8
         G7Bv+NwFnkZyOBtaAzy+hM72ZbT9hiakrh3+VSXOVcc9HjWK129D+xwdlGafb1bJNW0L
         rZEpUGJ+/zB/b8CQCBLrKyfnmNkVoPnXk/dEcKdBsBB/nJv1Pt4ktolTsfU8vRUeWXBb
         M63g0zfLXNRVnEPCriockDf7ks5H/Jysz4IYVxzc0Z2a2MoDkx45zs2Z372pGiPMPVbm
         wWjUhD2+1vXx1pPM7mIZh6Oibz74UD3VQlQEZ3wYIkfsUUQzqFWz40nXuLoJ0weoNl9D
         o8kA==
X-Forwarded-Encrypted: i=1; AJvYcCUtcBafTJy1cnX/O7VvtS6kel0N9Hp92kH94X5jDUlKzgTuMcUQlKtCZRl/EZzPUY+s5iHt/JuC@vger.kernel.org, AJvYcCXRXwHLo1Li4wF13q7WkhgPpKQPd/DYZ7jRCZiroFMikhX/nbeAZL+KH+ARJL/Cj6jl8oz9bMQlCmxE2FA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2fUHdTS9itvXXHRZe0SYM3KKoHHBrrP4AsfNGHB4Ip4w7kfOQ
	7iVeDdKUKj7/bXTCo5cQAijpCddYECdGXa4RAMsCXzG50m65yCQPWG7x
X-Gm-Gg: ASbGncui9FS/iTBlwqRxPsroDttWYxncA+YYUHO1CFAUuC5MwyBfHWpve8iKYQ5Nib5
	kNCaIJHP7AYwVgIpt/fByQPxkzGMQQt610x3kYN5s7kx4WvyULsHS/iMHtAz9Vmm3SFYevRAxZn
	nC90XUW6lwJoW4p9Jf6u0gTezfFQuJIUWsvK+ih7umjsnPW/1R3S+N+T44hp+9HZnw81gGH1gRY
	1YliCoGabsXCWy/+ulVRhPjc09xiHIySVWU34i04fWb0wRkYhFT+gc5uk7qZR0lhAaXLOtBnZBS
	0htVJdWapjuVgLjFzekhtyiqC1EPHZrgPoXhM8xKSzjZb/+dvffVjUyZEqGHRtOqw7KVs4cVdxB
	kNqDnQi8I2Tr/NCVAv4OPyw==
X-Google-Smtp-Source: AGHT+IE3o1PVbYcGVOeDDd2u9PBkS7qnGIBAlmbvXpp/v9MUV/Gw0EgVgPEcUGAR3AbyDFV8S3qXgg==
X-Received: by 2002:a05:6a00:1708:b0:748:2cbb:be45 with SMTP id d2e1a72fcca58-74ee2160164mr15089737b3a.15.1752453894571;
        Sun, 13 Jul 2025 17:44:54 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74eb9f8f35bsm9245897b3a.169.2025.07.13.17.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 17:44:54 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Zixian Zeng <sycamoremoon376@gmail.com>,
	Guo Ren <guoren@kernel.org>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>
Subject: Re: [PATCH v2] riscv: dts: sophgo: add ethernet GMAC device for sg2042
Date: Mon, 14 Jul 2025 08:44:34 +0800
Message-ID: <175245386393.141174.1523471014566184474.b4-ty@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250708064627.509363-1-inochiama@gmail.com>
References: <20250708064627.509363-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 08 Jul 2025 14:46:25 +0800, Inochi Amaoto wrote:
> Add ethernet GMAC device node for the sg2042.
> 
> 

Applied to for-next, thanks!

[1/1] riscv: dts: sophgo: add ethernet GMAC device for sg2042
      https://github.com/sophgo/linux/commit/d099560dcbade90c9d508cb745faa786ae230d0b

Thanks,
Inochi


