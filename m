Return-Path: <netdev+bounces-124113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4964C96819B
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 10:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93B71F2132D
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 08:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D594F17A5BD;
	Mon,  2 Sep 2024 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BrFvO7MY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA046152E12
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265392; cv=none; b=U5YSzsJYmNyknN4xv/vSrJY1UyMb+30zhVJAbqKcP8ocv7yqtIobbFNfzfldRuusFAlQoyAuMTj/hgTymuuKnt2iI/eIl4x7ISfQvIOjDDdLtQhIli84AvYJBvTN3zXQ5+go8jrz/xDqo/dp1GBrcGxSREaCU5D9rBQttBGohDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265392; c=relaxed/simple;
	bh=XQq/D4lV27FYzTNjf3gFkYUSIKcxiur4dtzJLIKtst0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOYVcRt+WTGRTldXcLRqTlzrkUSH8DlE/RVMvDusfuk12EazkAgAO8bQCvA7zXM6bW5/7bn5npY7NrDWYFHPo//WE2cyvIWASoMUZ5jlTMHUN0JqFhkwFpIhYWPCXKGNabvi6LTMC/62t9yJCSHkFfE3W8y5IIGSh02LpKq1O5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BrFvO7MY; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f3f0bdbcd9so45761151fa.1
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 01:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725265388; x=1725870188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQq/D4lV27FYzTNjf3gFkYUSIKcxiur4dtzJLIKtst0=;
        b=BrFvO7MYZuXw9u3+mDz0LoaoZiAN1AR64v+Ca3zFX4b+XaFGZ+1OcWt/uRC+TORH8g
         q3vmm3zh15OFs9tZPCUP2vC+1I8CI5q2SfYo0q6eP2IEiDl5kpu/TRJhqTW+umUXOK6O
         GJbbrMJ5JvkR+1Yevnh9eGOA4v3Q4xhwxgR/ebXT0pWa8qnvPnRJw9aqsLY2qc0Q0tVA
         JXOCMBOg5s9QZGsJt3gUGfOZbK6tnmcwa3KLT039K4WAKZ+eCd9s7VH852MQOWvO3bUr
         b5xuM0ZKmLNGLFsgp6bI7I+FewvIXdIsokoBGCYtdeqeFDSHuBu8xphdO/HhW15wiUjJ
         N2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725265388; x=1725870188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQq/D4lV27FYzTNjf3gFkYUSIKcxiur4dtzJLIKtst0=;
        b=SeQCAC9wgxcf0xdp6LdIzIz8PdOlpb2P1mZpOsIsj1waydKA12B2b3Xhgo84pM5Eu0
         mcSIHTBwkArm4qGcOsR4QYHHB4TeTLG6N8wv6RJduTpxtVGCP4oECXGJ5RXtNrhC36VK
         3Pu3z+1lQ5aREjpNYE7FzrnPfBLRSeb7XoHZZcCKtvNxZ4ItsQ/ZdL6d5RdV77G+rfG5
         131CnlYLIvGg+Rwcr9bhfoH9H+nkubQ58oZ9vXN3jKsR25oRB5HtXYBq8ZWi15Fypt6C
         HlGHh6BAZyJRTc7FVU46haJRtVguNTjghbWhvdIbnwPu+tmAXzlTbPW4Zk8b8gEqdN+7
         +l7A==
X-Forwarded-Encrypted: i=1; AJvYcCUUNA5RQMiqJmppdO0ybNBF9cnNgCQYdsECvTga/5DNpgzCduwOcegWk3tOsL2T7f/VVuFrGm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgDwsoegfVdASjeuZYLb8c25McaRNgecnGGPz4Tp9ngEZbw483
	7UIsdOEdAH5iogXDznAshNyG4d0vUPAWYC8FPEpbLHTrwt1SsVAxrqPHI9M4RhR+Airml+C8iJt
	G0g8Y0N4TubYIA5lp3CVVOYgIy+3ldYSrt2hsNw==
X-Google-Smtp-Source: AGHT+IGOsbWk+h5fSydwDiIytPpQSxAoU7GXpQxygF+8ahTjkzoifYF0BEllNauSFfQHoLbA8weKozExCyYDDMJzjoo=
X-Received: by 2002:a05:6512:b94:b0:535:3dfb:a4fc with SMTP id
 2adb3069b0e04-53546b0548dmr7633008e87.22.1725265387226; Mon, 02 Sep 2024
 01:23:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830031325.2406672-1-ruanjinjie@huawei.com> <20240830031325.2406672-3-ruanjinjie@huawei.com>
In-Reply-To: <20240830031325.2406672-3-ruanjinjie@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 2 Sep 2024 10:22:56 +0200
Message-ID: <CACRpkdat9Y0vJXUbBEeoNP7QG3UGRTU3rOYD3PAi4frk05bSKA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/8] net: dsa: realtek: Use for_each_child_of_node_scoped()
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: woojung.huh@microchip.com, andrew@lunn.ch, f.fainelli@gmail.com, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, alsi@bang-olufsen.dk, justin.chen@broadcom.com, 
	sebastian.hesselbarth@gmail.com, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com, wens@csie.org, 
	jernej.skrabec@gmail.com, samuel@sholland.org, hkallweit1@gmail.com, 
	linux@armlinux.org.uk, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	krzk@kernel.org, jic23@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 5:06=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:

> Avoid need to manually handle of_node_put() by using
> for_each_child_of_node_scoped(), which can simplfy code.
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

