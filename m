Return-Path: <netdev+bounces-162061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A423A258D2
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 13:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03041881827
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 11:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68812066DE;
	Mon,  3 Feb 2025 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UY++Gbq5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5332063F3
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738583773; cv=none; b=VscRd8FkhgsxWRWEbJyGz3MqD9gTiAn3lC2hSxUR85kzz1ApATCbPa/sNNAJAHapEfwXesGa9SLwFFl/dlM6bt2b0wTwOmnbmQwpOW/PYRiOjmfWnyuONQwZHV2CvW3wUWXcdF9ThtVx0pjYfl5HWHGbK0OXD07i7WW4VAoccKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738583773; c=relaxed/simple;
	bh=5VO8qxHdPv1GlCfSqdK9sL6Lqc78mt2FtDInjR+r4xE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=STzXzAenSMqWqXFDKuP5idcz+MOiZuBQbfNNuTl2gpL4LN1sJZDCi0bjLFKkAZYnlFvFNpoKeruaIQThdNcM2V3KvLUTYAdzkHlnY7wKRjLUATne/SWulc1yNz5a52TQiavq79DxdhxkkJmSkTk0Ig/toGNBcJCnUjKTRTY4wFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UY++Gbq5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434f398a171so5644415e9.2
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 03:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738583770; x=1739188570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hf+nXVuq0n7+9Hzbsc1pHZN283D6/tls331wlf2T5UA=;
        b=UY++Gbq5oALjic2kiOL6Y6hx3NYz7TLaTEuDiFgSUfyOd/d5KoeixoJEi0gmy8Bpbd
         RAc4vqJkhwL+BIrCT1teZYSX0kEof3cFT61U1ZL9GDqTE3x8qfK5+g33EddyXkzCmIgI
         QakZntsvRsbN8TyFRl2O43OKnHuPTskB/5702h5bZzjupoHlZmIKHY0YBljxaGrWmyzi
         povy+oQIk3MeQthGJj91UNlkbLdn8blPqaJL8EPoJPCgqA6SpNkV1k6WZQF8oiuKqxIk
         DHDge6l9jKS6mn+ZFPQgW2O5oQl2tzP5BGeAHVj138Sv3onnk/MA9UL7qVu5ghlT73K8
         KM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738583770; x=1739188570;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hf+nXVuq0n7+9Hzbsc1pHZN283D6/tls331wlf2T5UA=;
        b=GgGS1xVrdrudW5qet20rFuAlZDEhbuQk2dXJUbF1M/WRYTKSQn1C8qfAcBXl3pcEsv
         A7kC+Ips+6aEp7pVUJvlQqgK+6smVhW28s2eYpekqzY+MrzU2EuG7cdjFrQOldsRpA8L
         zUjxKeoP1zMJefIW9K9ZmMRO6Px6pkVpmMyxvwyMK3x3bfyPlbqQUC61tKo/4vVOsQfG
         O0B547rVDpsy3X46EZE4Vbn1VOBeSYqsSCNs6QfGiplc9WDPzWyCD9qM2m9IPPzjw+JB
         quef5NpVX2N2mWfr0mjfItjz0kxVMinT/1pN7VyRuV15mDoqWo78P7U+WpP19HgogQL/
         iq1g==
X-Forwarded-Encrypted: i=1; AJvYcCUIRStekZlyszkXDUb4jazynegoZk5Yj0SGZ6ddP3x4wp7sOsFf0Mo8a0DD9k0Jk3pmpjJXqng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKYbzDxOIp0Vxs+KIBds+r8Tx1eYzgmlGCd0I2Y+xHnAdTnkMr
	h4fyKXL6AkL7n7KIYNeThYlnTQ1X0uzHiQD7aNRzh1TPMo7nRGMorEHcQVOzz0k=
X-Gm-Gg: ASbGncslfrEVbJZZqGsBUx0mXYmIZf2ZTABJKK+N7kWy70Ln7mtrh69NDO1G5tEB45v
	++hWJ25D1ck0PyqADsvTpPCx32iQqdnDltS8oObhkRS+wHC/MIe663pkaDb/vg3ndn5LVP5QOf1
	+Wx2t1hR3EA+nAbXkMp/9CoPNI+zSFhTnMO0h90icmImVlNYC43ZfGz/mjy7CF2UAvGZsfKaLSz
	8nyb9xWkh+mdTrOCl9VKdh+YJYLnq3v5IR0TdoYuL4OV8mg2EihyT3t5SHvbHfFkxsrZsib2IhF
	Y66ZDcyTCV67Apj2yf688O+Oity7yv8=
X-Google-Smtp-Source: AGHT+IFQbSU80i6YQYi6YzPYyBsllYWbDkIcbgELZu/FC2dJYOz3ZShx5Senfvr4yJ63Nm+XoGt8PA==
X-Received: by 2002:a05:600c:1994:b0:434:f5f8:22cd with SMTP id 5b1f17b1804b1-438dc331eb2mr74266625e9.0.1738583769775;
        Mon, 03 Feb 2025 03:56:09 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438d7558ba2sm166790545e9.0.2025.02.03.03.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 03:56:09 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, netdev@vger.kernel.org, 
 linux-rtc@vger.kernel.org, Huisong Li <lihuisong@huawei.com>
Cc: oss-drivers@corigine.com, matt@ranostay.sg, mchehab@kernel.org, 
 irusskikh@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
 louis.peens@corigine.com, hkallweit1@gmail.com, linux@armlinux.org.uk, 
 kabel@kernel.org, alexandre.belloni@bootlin.com, krzk@kernel.org, 
 zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, liuyonglong@huawei.com
In-Reply-To: <20250124022635.16647-9-lihuisong@huawei.com>
References: <20250124022635.16647-1-lihuisong@huawei.com>
 <20250124022635.16647-9-lihuisong@huawei.com>
Subject: Re: (subset) [PATCH v1 8/9] w1: w1_therm: w1: Use
 HWMON_CHANNEL_INFO macro to simplify code
Message-Id: <173858376808.132674.4568544450122043067.b4-ty@linaro.org>
Date: Mon, 03 Feb 2025 12:56:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 24 Jan 2025 10:26:34 +0800, Huisong Li wrote:
> Use HWMON_CHANNEL_INFO macro to simplify code.
> 
> 

Applied, thanks!

[8/9] w1: w1_therm: w1: Use HWMON_CHANNEL_INFO macro to simplify code
      https://git.kernel.org/krzk/linux-w1/c/33c145297840dddf0dc23d5822159c26aba920d3

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


