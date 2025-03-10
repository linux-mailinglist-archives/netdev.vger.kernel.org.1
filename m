Return-Path: <netdev+bounces-173409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 730B2A58B11
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 05:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F4837A4A4A
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 04:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B38C1BD9CE;
	Mon, 10 Mar 2025 04:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQBdQ3m0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73B5188A3B;
	Mon, 10 Mar 2025 04:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741579729; cv=none; b=nYb0f+KjQoYCuK39N4rJWarUhgere7Vsu/F1fmjuwwqkA3MnUFxfGsHxAp6IiQBEQw3dqQTTfi3slEcID07tPtwQLtu2+ZmHqAOJPPRdUF7mVn0uCtY4aVEoCS8s4kp71V93+fKU0tWj4G1HrnmLTJvAY2vXVTnuyVWFQdm01s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741579729; c=relaxed/simple;
	bh=fJYoS5wlG8QstMdby11IKTbGL41o3ycq8U79HfpMshw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lVKlfAy6kBRMrD3qae6TVi6q3KcLOTpKPLxc2mM3Zb9qJBlBSBsokpLQac05ZCjzjyOxwFTH1mpiNpqO6TSXARonLB6DU+keQ3zJHC8Zj7mFe7vauRhKjJZnA7rAvbtjUX8ebFb1ksuuJWknj6xNp9IhMRTxZqpU5R4OnO+8iaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQBdQ3m0; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c2303a56d6so439836485a.3;
        Sun, 09 Mar 2025 21:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741579727; x=1742184527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VOuggK65iHL1WrZt7LgIkYldFFZ7T+Rk2QuSTsMBqc=;
        b=FQBdQ3m0QJuiE3A7xh7CiR6DUEDSgWd2eYrSpucSak0S+iQ5681go16guNxM8lzUPY
         exAYQxZCZEfofFZ2w4E6AmVX+JVJw1gervWaMTVM0+Cs/Th05azKQo16t0x+GG0fvuw7
         W1/xG/ESGPA8c5aogpMUUA9QqoVdVmjUn0RZlzLWs9AQU/zydlth2sKQPaYSHEeWAH2F
         mCJ7vYhzGeEBIMDwyU7LBW5dV7M8Jd3OVaRvKYkVb4hdrSq3Nt7zUpCYWTG8UKtgzGwD
         uHMevUExe22+yrD3VFNvxNtplUBNC+shkX33VydZ918F9FlMxsB2sY76cY2fqiSwlK9T
         vxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741579727; x=1742184527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VOuggK65iHL1WrZt7LgIkYldFFZ7T+Rk2QuSTsMBqc=;
        b=rK7JIHJ5ggIapSAZxxbFWHTdV2N40e3nr+xObnZ6CiTCRuN1yLcpv1X1GoSiZodECn
         qAj0jodZqnCmggqlnZvg0PKyec2fhU7JIrjY1o+lAFBQipdZDFlCGg+mSndiJJrJebCT
         +/poGWi4CQAe2cR11xrtNJpzwiAAxIDE+GX438XzKeSYa37aWfYqyi028HFreCHauNo7
         EFbia5uSs5s0FCC6vFb6nsY7w/A74NsVUpX9mBXBOgFY4jTY+XkAZobDFR8hPsgYdyv5
         YIk2xGAooaz14LjjBt8XRs+fyu/ZUDJjSRy78zchlVCYqHZ7hnGrVhPTd7XmkPqmDzel
         96OA==
X-Forwarded-Encrypted: i=1; AJvYcCU5ZcLwMAeceKqJh54cfTQdbcr1GtErWRRX0aZO+HxwoPAphR+2H9vVbjqPP7nBjLz/K4eFtR+ld3dcHLUv@vger.kernel.org, AJvYcCV3hKLU7GrCowYr6PEMxTQmdqxYEDBkm3ON/sw1H6V3B64B3oWxZLXzBVocnvRHX7xvXJVpvy3g@vger.kernel.org, AJvYcCWnYUcr+XdVx+S32l2gcaOVcCV4tKTr/cLwExLM76RsuP5VZptIgA2a/8GUnbUo4n7YDt+Xxcm49WuE@vger.kernel.org
X-Gm-Message-State: AOJu0YziTVrZ0LetCAfdCttCNLYiNNStt0KrsIttiy6xqryYsWYKyklF
	GYpUcU8SZR4fcp+zkiwFm+WNbTiUrtY1FnwyNObLsgxJntiBuqkg
X-Gm-Gg: ASbGncv0q9c0kVkKdXPtTDc8azB4V8MTj2b9mldpoHGG+N9HZOrElOshOsKRDwy+dtl
	8qHdP+2cAv44L3hTWfXN+tGus7R/nERoO7vpxaZcZ8Et7Yp2ABxgwvE22XC4GvS1VwZrnH0nFtY
	rH9UBiHRFNnR/6bLZmZ8ovQVwgCqOYm0TGKpyWdg45xICzAYC9gHXmMxrRQ+mURKB4hOTEYvua+
	/2nZCooL2dipjBsgKYS4USl80iWHsP+9vErRLV+QGzlzeEXqZZRP36cELypfnyEnh1Tb9tBIb8L
	s+ecYlCw+On7Bj2xa8GZ
X-Google-Smtp-Source: AGHT+IF48MIEuo2MOFTyOtajCaIZ0VDeA9fTgytDQQC+qHk6FufxDgXmhh2qYRm3u0obvO/2DLZIOQ==
X-Received: by 2002:a05:620a:278a:b0:7c3:c421:3e92 with SMTP id af79cd13be357-7c4e167830emr1619956585a.10.1741579726778;
        Sun, 09 Mar 2025 21:08:46 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c557e08ecasm36964685a.98.2025.03.09.21.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 21:08:46 -0700 (PDT)
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
Date: Mon, 10 Mar 2025 12:08:32 +0800
Message-ID: <174157953239.287836.12496608762621997429.b4-ty@gmail.com>
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

Applied to for-next, thanks!

[1/2] dt-bindings: clock: sophgo: add clock controller for SG2044
      https://github.com/sophgo/linux/commit/0332ae22ce09ce64f5e54fc2a24ed22073dbeb9d
[2/2] clk: sophgo: Add clock controller support for SG2044 SoC
      https://github.com/sophgo/linux/commit/fcee6f2173e7f7fb39f35899faea282fd9b5ea30

Thanks,
Inochi


