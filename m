Return-Path: <netdev+bounces-67809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96865844FEC
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 04:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4653D287D86
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 03:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EEF3B197;
	Thu,  1 Feb 2024 03:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="CR/3qrOV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3593A8EE
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 03:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706759367; cv=none; b=kG0VZiJqd6kBNKNatct3ql48m8NvgPjWTwMMYSvPwmy30mNKjnXiFJrFp/KtOJyNJ2lh52cT5bxP4YOwn+Twcf8HvXkr77YexXf3nA2gK6HvZ0qunh/+jRqf87MoEY3ieCBJx6cfpXREkgs98O4X7LYvQGgh52UfLmh/IFjwD4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706759367; c=relaxed/simple;
	bh=yjVe4kQRj3zahvnTfboJZpOW7Tot/quiUrYZyOIwy98=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c6AfqH46BhrRl4J0n1wfQ9iqtijOQlSsK3leVm5rno4BwZ61QHTVpcLGaLOgqztQKr9ZUBLJcbFerxDkO8T43Y6t0YGEF9nB/kAwLy/+SMOJd0ia2VERyQX8IkfK5pGF0KhKf9K5Tjno843iCShxm8zI/5FLW4mDlAHGMRKmroU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=CR/3qrOV; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6dddf4fc85dso360630b3a.0
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 19:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1706759365; x=1707364165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjVe4kQRj3zahvnTfboJZpOW7Tot/quiUrYZyOIwy98=;
        b=CR/3qrOVNNvStlfw9s204zbiXovrWlUpkgYSSdejOSevsQbuAJiEMjfL5P5Yk1Cg8A
         jlK/+R1SzdqpvDuQ3WQjuflLHRwFqe8RxYIFselhnkc6k5+LrGXZi0nreCx3Qj3nmTgY
         Z8AdQxucUy7OiZimlYxpiA2sToMpklgh0ltnoyPDkyIuFtT7CRS6gepd/r1ZQk1YNthq
         eKHvkpey6PTV0HzwYXVtNN6MUp7ZUPDEQid5WhmvFntRfZ4RdTzElfq0vzHskZKAOfsf
         AvrEmPP0Gbe5VY69ap3SwZWvszECmUm1cdg/ftEIHsZb4SnZ3+kgBaqqOLuxUxCrDvTR
         fBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706759365; x=1707364165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjVe4kQRj3zahvnTfboJZpOW7Tot/quiUrYZyOIwy98=;
        b=q9aVysyjDG8oKdRLmY70DzbEKtG7viPMWOKbPnoUTraxJT46uhf6u453Gw7FlKKHMw
         3labDWw+AC0XOVOsfKeUIyloiJtMTEZEg71YB9mCumTxOdPHLpAh2A/OJ2dfdYgll2zb
         btJ+pWoLyP1jh5isM1VWSa+jPqv9oXK22p/CG2xU0lATQJFjVHeuomne+vRNE25kUi4C
         +KOW4KnXkGVypBRGm/Jb85Ijs+1ig2qSYbDExa9ZIOTAh6E+W1CFtiJRXjhpjdmNEzqG
         nRv823kQwsNXnlOcO/7Xi8CmnEHoPfbqJUkTDr3P7cVRiAhpBt9chpodO2tF8SByMTJR
         XCVQ==
X-Gm-Message-State: AOJu0YwAg5e+mqEv427+ytXh1m4XkaxNsT5t7ppMU2MChR1n7kxm36Xj
	AGHN/zFxmaDDNK0Nd1zHyt7CmhW2E7gMkV2jxYrS7MO36z6GI7ddhiJ3ZN2jJ1U=
X-Google-Smtp-Source: AGHT+IEpkoNaCJ+Qpl5+dRI+pDxjWMtvfFoIau1mYdxCVGbGtdA8Va5RMpbSnsZiG8iHDHa5wqkL5A==
X-Received: by 2002:a62:b608:0:b0:6dd:86c9:f54a with SMTP id j8-20020a62b608000000b006dd86c9f54amr3257651pff.17.1706759365620;
        Wed, 31 Jan 2024 19:49:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXi4kKmjSLsSLOirl391nhRMOsh1jt3ExFKM6f05jRWIyn2QXn/m0N+709PzAtxhUBXz2OiEdouR6Uu5zRxKecChMOA1HvT14JWteN+Lexq+zwHV1vdODEmfstPKPXG/d0Om2Xivtcrd7Glbkxp47CEU7wjfukkYj9ilES1AKnqfkQKAMa7U1o1LMGgvXocV4Bk0tlX6/WqHV/me1mQMr3pRkaZnCPKXGXSngJh92G9hcC7h2OEQzUbvC8Bpw==
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id i1-20020a056a00004100b006d0a29ad0aasm10647970pfk.5.2024.01.31.19.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 19:49:25 -0800 (PST)
Date: Wed, 31 Jan 2024 19:49:23 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: netdev@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 0/8] Intel On Demand: Add netlink interface for SPDM
 attestation
Message-ID: <20240131194923.0da36482@hermes.local>
In-Reply-To: <20240201010747.471141-1-david.e.box@linux.intel.com>
References: <20240201010747.471141-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 17:07:39 -0800
"David E. Box" <david.e.box@linux.intel.com> wrote:

> This patch series primarily adds support for a new netlink ABI in the
> Intel On Demand driver for performing attestation of the hardware state.

Are there any tools (in iproute2) or tests to support this interface?

