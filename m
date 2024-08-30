Return-Path: <netdev+bounces-123903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB08966C2F
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 00:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C911285027
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 22:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579A21C1754;
	Fri, 30 Aug 2024 22:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QyxgQiBS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9BD1C173A
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 22:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725056277; cv=none; b=Q3e2q7w3aMEFAjU1rDuzY4HsWgIMGen9JB27nAGClEtfXcd+FvhS60q+5KaFK9DNdxk7doOJTbXRyHa0sirIsSouczYw6VcEQItZYmEv67IWECR0MfT3f62FtYe3uIlGpBU+Wx9bZkn+yeaU4JLJPTr0lRTiE5wIMsqukD1DUOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725056277; c=relaxed/simple;
	bh=k5WO4QDBBlsQUtbcAzwg6NCzLWWJqOLIFTUVIpEZcoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDMsEuLharhHgGBQaGlbBe0Y4G5e0qINzhA/gDLj0dL7K47arOLaQfPW3XDfLcuHN2Rr9be3jo2o9trtCYcFeUbVowxkbGLZjpzzafbAioiiSZNeyG9jb+WcD4Mim2OoS5O107Gl66k0m8SPhAK9qY/5v1FwmJAMuHXijzldVPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QyxgQiBS; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e1a7f1597bbso794441276.0
        for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 15:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725056274; x=1725661074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5WO4QDBBlsQUtbcAzwg6NCzLWWJqOLIFTUVIpEZcoU=;
        b=QyxgQiBSq+KXSXH66XgHsHC9AHoz78OEpswWAmLCMBL8ZWtJwQX2s45iUPwS/oiWw7
         gDB9m34IotELmdsinHrjlseK+xFHfqrVe+rn+QGkr5Tiv3SxVXeL54lwtnT8shlX49d8
         qjuos5ZNgcQBQtuUdYC/RLXxKpHa3MuDlHoGUUGXTBVNTxPpDAaiW4aF0OfpUZlRAA0R
         npekk402BCaABiTNbj1IMm1o7dRTr8oHrnhW91RLS5gaNh6Psq1lzORnQ9VEQws//gp0
         b+td32i6JxRSDXw7Qhao+C39NDGx24uDgQIY61ne4XIgSTfocStqeohQJNqxYvzGHNil
         PzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725056274; x=1725661074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5WO4QDBBlsQUtbcAzwg6NCzLWWJqOLIFTUVIpEZcoU=;
        b=eTqd2giyLYhS4KFPWymiSn75k85oWlB9KWpOooq2Z2aYxHu+vjMO9dtBwrqOAV8G9V
         5VMXTIWHj93O1/Q0K9UR1bXk12t3lhN2OhOyoCMdc5ThOI6DLBvPBG/R6Ton1UBKJsJC
         s1R7LrplX0YPRGTmzi1KzhhuxjZtPd/aH9f1X7rb/hH7StKvQsP/sHONhO0gPl6oGafm
         TBhSrA5kyayAYF0RxqCD/vdZtNKSQB4WzJhnGmyv8etVIeSLcV+Fya97Xd7AcpGUvfzs
         QrQCKYJRtZqJjX3AeUc8/4jZBLBL3NMdELIv1eURijZwtrFd3VMkLRkrxNDG3j7GywL8
         EXWw==
X-Forwarded-Encrypted: i=1; AJvYcCWc0n+aKA5CWvfXov7jOSjQaarjFS6xg/I9VvBSPxI/wSo5NOMv4aPFhCBFcujlDvRJQWnKGTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQkpSGXpKfUV/NlJ0H05ceGcDLTyhb3V9E3tgWvPkzSZJmRyyo
	YY/0BxM460EqrGk/4W8xnZDHMiJxBCFXjMxfCUgD9g/xnwBLouVy3uUhElLfybwiYguqdNNEE9a
	0eeSlKoSCLiVmaWSL9fA5U7JzGzZRq3yqsBnrug==
X-Google-Smtp-Source: AGHT+IEmUy2IA6mF/xZvxmao3unx9PJZHOnyHquLRhrCfhleDGsJQGbKCiuRac4ps36sc2viLuEP9uTKmgAJ4mvsDS0=
X-Received: by 2002:a05:6902:1ac5:b0:e1a:7033:73b2 with SMTP id
 3f1490d57ef6-e1a7a3d8163mr3422353276.24.1725056274315; Fri, 30 Aug 2024
 15:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827075219.3793198-1-ruanjinjie@huawei.com> <20240827075219.3793198-3-ruanjinjie@huawei.com>
In-Reply-To: <20240827075219.3793198-3-ruanjinjie@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 31 Aug 2024 00:17:41 +0200
Message-ID: <CACRpkdayBQ6TrV0Nn9jWX45YaP6repY0FU6CP=FnubLbonpEbQ@mail.gmail.com>
Subject: Re: [PATCH -next 2/7] net: dsa: realtek: Use for_each_child_of_node_scoped()
 and __free()
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: woojung.huh@microchip.com, andrew@lunn.ch, f.fainelli@gmail.com, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, alsi@bang-olufsen.dk, justin.chen@broadcom.com, 
	sebastian.hesselbarth@gmail.com, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com, wens@csie.org, 
	jernej.skrabec@gmail.com, samuel@sholland.org, hkallweit1@gmail.com, 
	linux@armlinux.org.uk, ansuelsmth@gmail.com, UNGLinuxDriver@microchip.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	krzk@kernel.org, jic23@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 9:45=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:

> Avoid need to manually handle of_node_put() by using
> for_each_child_of_node_scoped() and __free(), which can simplfy code.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Neat!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

