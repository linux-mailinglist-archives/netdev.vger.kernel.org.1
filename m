Return-Path: <netdev+bounces-52722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D2D7FFE31
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 23:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D22B28195F
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 22:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DCB5EE9C;
	Thu, 30 Nov 2023 22:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kmWyZYe4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74182170D
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 14:00:37 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5c206572eedso1156255a12.0
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 14:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381637; x=1701986437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apCUn8ziR5/FQTht29aZVAPAp67cMYlwQgKj/BLw0E0=;
        b=kmWyZYe4DOYklbG9UarMNCNjUL8JZj1Inpz1uVCsowBt8ItHYjJn4csGXm8HSJc5x9
         Vi2sv6F7ek9jDNhHoVD1e+mIMUUCZ90/Hwk3lv7TXdkWRDzkXzGyfZSd4i51MyV6SuFG
         to2+LyOO9H6/lwU7UBc9qsJF5IaYmMLkNLXQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381637; x=1701986437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apCUn8ziR5/FQTht29aZVAPAp67cMYlwQgKj/BLw0E0=;
        b=EqCatJQpykcuQRSMTizVe077X1bUTepcNG8nEsLA8XNMd+/XZYaTS/0pJtAmKKiu/Z
         0zwFEvdf+DzUiLe8rYVkt9FH8hIgLYbmgdYFpzAIAf9s0Fjk5dgpHF+XaZ+qckYyu9tN
         68ab5KSsD+ThL9HNvn7+H9py8XHiH99a6i4lX/dX+mY010v5rvrpjyIyhUNgy0b4mmvc
         qas3RZNRBvSw3s7S4R3UWjcHwgi4O5mNWYvHSfMUz09GKOwf6icwuf8jxx4LvLBBuGiI
         4ThykpwyJTBLvIsuDSsiaxD9974LxCR+do3RUih1RNzwVUsYKgHkamhctXWyHa7+tsPF
         zopQ==
X-Gm-Message-State: AOJu0YwedF3nHijOtkANaHiaRl/Pq0e7fzMhBWr7tozMvHkImnC3pFqC
	A4lZ0oTggay56PzVt9PwZOrb3g==
X-Google-Smtp-Source: AGHT+IHeAXmsob0OovCgW5d5X0eNhEXfkTQ2ooTHhsGgT4RIS2FKAgLtfXERMjmGZkCm01B3myg7hw==
X-Received: by 2002:a17:90b:4d8b:b0:27d:9f6:47a3 with SMTP id oj11-20020a17090b4d8b00b0027d09f647a3mr26842962pjb.31.1701381636781;
        Thu, 30 Nov 2023 14:00:36 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a11-20020a17090ad80b00b0028649b84907sm956190pjv.16.2023.11.30.14.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:00:36 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: mdio: replace deprecated strncpy with strscpy
Date: Thu, 30 Nov 2023 14:00:33 -0800
Message-Id: <170138163205.3649164.7210516802378847737.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012-strncpy-drivers-net-mdio-mdio-gpio-c-v1-1-ab9b06cfcdab@google.com>
References: <20231012-strncpy-drivers-net-mdio-mdio-gpio-c-v1-1-ab9b06cfcdab@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 12 Oct 2023 21:43:02 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect new_bus->id to be NUL-terminated but not NUL-padded based on
> its prior assignment through snprintf:
> |       snprintf(new_bus->id, MII_BUS_ID_SIZE, "gpio-%x", bus_id);
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] net: mdio: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/3247bb945786

Take care,

-- 
Kees Cook


