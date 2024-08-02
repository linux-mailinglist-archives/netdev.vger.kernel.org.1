Return-Path: <netdev+bounces-115417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EBB9464C8
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 23:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833C91C215CB
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 21:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583A954660;
	Fri,  2 Aug 2024 21:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WqadluUq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75D54D8D1
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 21:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632687; cv=none; b=r5uFsEC77cLWOlFf+zMUbs17H01SSWyKCtx2RMnHywRVkiszG/VoyZ0giJAh3Xmyluhf+sNjD25ZwXzt05TgodTo4cbNWe326OTWInymaVCptxdLQfz6mwdCV7DinMQHGE4vR/HvNtUpoCFqdRD9i0DsIbqVBESDc6Vf6oh9hBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632687; c=relaxed/simple;
	bh=aDLyGh7bJYGOVqjx0U4lXYCia0yq4G2ZZHzfarZrrAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VaQbEHTyuIpADjgxaUoUOcS+PsjUCwWRAVUKTb/6nDLBAAt+kRiIc+Akii9hys3WzLoaUhAUJxNkVECw5MNS+GxFAczLm6Upx5DeKHsnVmxcGIrqsV8tfE/JmoXnTvLmHwcCl4kkH8/6ZHkw7p0KmtBRMHmuDaXY7A0EXelGwuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WqadluUq; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52f01613acbso4281515e87.1
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 14:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722632684; x=1723237484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDLyGh7bJYGOVqjx0U4lXYCia0yq4G2ZZHzfarZrrAs=;
        b=WqadluUqJOO021HQwey2CpEDXaUzDzzmyl1slKJPNs2BkZDw9qUSPIviYlvUrhR+54
         nPeOoSKIDkWUsKY/9z8P3MikEyLmYF/av//WgKgU1zumnp5ItELcapOE+y3KI5XXuJF1
         /HyEIWtdLL9tmc0ev4OzZE28U6W7rd3SjBPYMFyXcYu3HNeEEDujj1dpi0fbS2VUVS6V
         DiavI/Y6ozEX5KJcVKUPTS0d/s2K7PBgfImQh9Tw4kQigEoYJMTB8j29dm1lGjHNKaE5
         x/YFPV0S+CiFGr9YW8cQbWct2DBdSMcBrNJIItpOn6Rc5NbMiIilhBlXCCQMR/wj/8WM
         yQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722632684; x=1723237484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDLyGh7bJYGOVqjx0U4lXYCia0yq4G2ZZHzfarZrrAs=;
        b=kPxzQp4ah2oBQ9d9gzLDyxMLpgxCL7OFvmFKdKeMPUqAvrNJCNnN+iVw2qmNILOqtX
         dtmu91L8pHC7thP1DFwhgXL+fFp0m8NNjU81cp8R4coPzKYT1xWtBJt6n/69V/+UpWbg
         4sePR8TCeQysI/dQzhB8c7SrBi7mTsJzw459Wfzyb13kfgbP9dzWqdfi46sQadsowXGh
         aLCp0iL39Li6au0tGRM0iiwEkTI2Ge8BE2mlNmxKKgOZuKr2fuYIxVei+bpEhuSse1nP
         Vhq4LXTI+nMqrGEMQuOwMW0qyASJ3hlqgj89rk+2FnZ6QqfjFGwutbik+6OlznPNRbil
         QFpw==
X-Gm-Message-State: AOJu0YyC2LCQNYvpc9Z0VQn671fFGRz+M7UlK9aD0x1sAQ+a9jvDERJk
	zxvGbWp0Kz5yZMKoNirCxoPSgNsuXwqizlUgk/KMLmpy/14pbpo4QsKw3HrLpD57MH+ODJOTChj
	03nPClSCXkHfpxkudjghziubRSyMUxdMeBlOl+w==
X-Google-Smtp-Source: AGHT+IE2f7ue0e7xkgTEx3gmrv6xArEBww4Gfh261DIr3CTE/+LgbXg6yQqeUwGjCYmnNUcu3A7uOInp8L6uRFgcmU0=
X-Received: by 2002:a05:6512:3e0a:b0:52f:3c:a79 with SMTP id
 2adb3069b0e04-530b8d098famr1823700e87.7.1722632683707; Fri, 02 Aug 2024
 14:04:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802080403.739509-1-paweldembicki@gmail.com> <20240802080403.739509-5-paweldembicki@gmail.com>
In-Reply-To: <20240802080403.739509-5-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Aug 2024 23:04:32 +0200
Message-ID: <CACRpkdZ6T7e3eYod-c38tKhNfLLXAFXuOBV1trBgn40-u25tKA@mail.gmail.com>
Subject: Re: [PATCH net 4/6] net: dsa: vsc73xx: check busy flag in MDIO operations
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 10:04=E2=80=AFAM Pawel Dembicki <paweldembicki@gmail=
.com> wrote:

> The VSC73xx has a busy flag used during MDIO operations. It is raised
> when MDIO read/write operations are in progress. Without it, PHYs are
> misconfigured and bus operations do not work as expected.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Haven't seen the issue but it looks reasonable.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

