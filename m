Return-Path: <netdev+bounces-166667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B73A6A36E95
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 14:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CBAF7A4235
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 13:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6463A1CDFAC;
	Sat, 15 Feb 2025 13:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wtRd1PZg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8836A1C6FF3
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739626978; cv=none; b=ts8by48qj6Y/kNRPO4lcMdp2oa/0Zu0SPafFYkHXJ7VJtTXqO0GcP0he2M2E/74eeh9/Y8jdp7S4Fb/zMQ4VjQHtSJ4tC0iTprHKmPkjd3RnkkGC3NEOcw9O14iEMLh1gB8hT0Grg9WsAR96qR69VJsCU8CNfbB7CF6rkB5oKJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739626978; c=relaxed/simple;
	bh=B5G7i3ixrYG9/fNbWmw5bNg42KOUv3/6jvQJNxtOKiI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XfwY5Ju7YFwFX5D9f0WSn9Y9a/5ffJNH6MsxMjtDMoTLMYBGOI+dJSl85gwoeBuXCj+wl1NQ+ntKVn9jiZxJnJ7Tes8RUw0+MbzXKs9APXj71IdM1xYTEUw7Fy/cIgvtacZWYhpJM86ViQumW7xFb3Uhc3eftKpWi0BjK1WSLtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wtRd1PZg; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38e1cad9e27so366583f8f.1
        for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 05:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739626975; x=1740231775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bzb9KoEVAxpceRAqAhOtXPFddy5YM0ujKSt02fGNR/I=;
        b=wtRd1PZgmsyreHIrgo3S84qyMn71Dx1kQ9tkOsJ/TsnRimIrn84ihavQ65v2BWfZWe
         8yqEcYXSnNVau1S8pz3e3ZZjfIM4qcwIbQX7E6syiiI9v2UBkLMR73yPav9eUrDjON0K
         AVLQUz78R6hBH2JWfOVoCQtpQvn9KTVKETFkNZ8GvssRGmtUjyQ/ZtDGIlMx0wk1+T/K
         uX0btv+slYZI5DK7pyg6SVKP8RN5uh3V+iOY343rDxsCEjtZT53ed1rRsXq3e9PW7ZJu
         Yg1pfVBOmhHdlJS+6mZarfJ3gAE0QB838HQL6gziTGAWO1MR8Ml7Nd6lcq5nQ0Q8URIi
         rJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739626975; x=1740231775;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bzb9KoEVAxpceRAqAhOtXPFddy5YM0ujKSt02fGNR/I=;
        b=sGaawnqJ6KbTbDoDE03PdtYdAVkESJaI9TeoUUClqwGkwOydCP7JmoHwh+QiD0815B
         IciTwpEzQPArri9Dby8itgkUiI5oZiFfWroab82OFlgNkoInL6mYsXyw7M8SYHjCSPcQ
         Vsoo1cTZuDlLCh9X0FIRD7yZb/HB/pDhom102xc3XU8eze3Tqn49TZSHsd9FlIebyl8I
         dc9XOdV06HcrcfPwvEAHRMif2SVlt7WNuoCETakQzHy/JrHQAm7ysnuWLIuQmoQeCIHh
         LpGEHbzBhIKuRueSom/cnL08o/uHhXeluuHCGE76E77kvyvWQOan37ZUGjkOapQRhoJ0
         Ab7w==
X-Forwarded-Encrypted: i=1; AJvYcCVNRxseoER7w5+VFlO7+JeX4pA/bu/qV6VspPGZgdDNMWGgyQasGr1FuBN7lot/in4WSInQC2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJpoAn0G/qzropIr7T9WBek/m//6EJOdjiXUBh3quENmeb7bxl
	fqPQrj4coml9iQALIYMSQ1lRiDpqz7Xr8IjCVdc24wT5fWtPiQaJp2asWrmWci0=
X-Gm-Gg: ASbGncvfIjuFs2qF8mEAaFs/0fro7gMp6WU1smbg8yY9DTMYXFrtMvfLPlh442tVwve
	iZvK3bGlvKWy6RD1rPg/9WUA9N3k/QzYJem0L6MSrDBL0cfNWgnmvUxwIYo0ewN/EWsgD2f7T9u
	kMm1tb4MUbhzgk7nZiBGvJkD3cM9m7CEZTlUJp9Dr0nW90sVaVE/A/CTCW8mx45yK8eHlyUOc1Y
	I3yjcwqs6PC6PodfHFRvwiYPl2Gv3X9pxAssR73+ISuB6tq5e8T7GLycv54nFjgAv5nL6DDzxNJ
	Sr1NT+yjdiszH3YdoFQo+TvD03m2VaU=
X-Google-Smtp-Source: AGHT+IGDxXB1E+X6jTSdESQDd36Tzc/wr84k6EKAU8sGUlvYMhjz/DzYT3hbSvKe0KicE5yIGLmyJQ==
X-Received: by 2002:a05:600c:3ba5:b0:439:5a37:814e with SMTP id 5b1f17b1804b1-4396e78789emr14566145e9.7.1739626974755;
        Sat, 15 Feb 2025 05:42:54 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4396181026fsm69929005e9.18.2025.02.15.05.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 05:42:54 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: krzk@kernel.org, alim.akhtar@samsung.com, richardcochran@gmail.com, 
 Chenyuan Yang <chenyuan0y@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20250212213518.69432-1-chenyuan0y@gmail.com>
References: <20250212213518.69432-1-chenyuan0y@gmail.com>
Subject: Re: [PATCH] soc: samsung: exynos-chipid: Add NULL pointer check in
 exynos_chipid_probe()
Message-Id: <173962697359.235665.7938168679485045244.b4-ty@linaro.org>
Date: Sat, 15 Feb 2025 14:42:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 12 Feb 2025 15:35:18 -0600, Chenyuan Yang wrote:
> soc_dev_attr->revision could be NULL, thus,
> a pointer check is added to prevent potential NULL pointer dereference.
> This is similar to the fix in commit 3027e7b15b02
> ("ice: Fix some null pointer dereference issues in ice_ptp.c").
> 
> This issue is found by our static analysis tool.
> 
> [...]

Applied, thanks!

[1/1] soc: samsung: exynos-chipid: Add NULL pointer check in exynos_chipid_probe()
      https://git.kernel.org/krzk/linux/c/c8222ef6cf29dd7cad21643228f96535cc02b327

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


