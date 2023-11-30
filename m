Return-Path: <netdev+bounces-52719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D977FFE27
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 23:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18C0328179B
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 22:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1D05EE6E;
	Thu, 30 Nov 2023 21:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TQ9pbjhK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E343710DC
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 13:59:54 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cddc59e731so1340387b3a.1
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 13:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381594; x=1701986394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c42AEDWMN7hJC14TW3ZzrgHN/RRiE6AQecjZVC97Rac=;
        b=TQ9pbjhKrU5rFQvy+B1+FAg+X9JVsucoA3CuPnU/XHjtqk31ej/8NAiYDrGhpJ6X9E
         7/94nJmCozCed82FI4dkFZXQE5cXSut5U47nXLX91GT3FZ08XXIZuLpUBNYRheSTIO7W
         oiu4PPQPMAQgWPMA3ypSZNo1yq1gvGIegDfLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381594; x=1701986394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c42AEDWMN7hJC14TW3ZzrgHN/RRiE6AQecjZVC97Rac=;
        b=YTM5FQeCQdjP77JXdQVHe16uJN4zMnbvC/Cfl/NpYj4m9AEHo5TICp+iS5GbcACazw
         2lvTn4r92d135eIlevXtu3w+C9ADatiU3C1eERD6AuIMC1xk2tPDnydNmxGp2ng6ILK4
         60kQekJ0p3c3gETmEDHI/tzvntJfJy8w9o9lqxIhOgbtRv7FeFTrHZmsGdbFR1gOC5KT
         8UYu0LYdZ6klPGtdyiMxxk5oR8uJikvUV/00hSddrenSqCMMTaSVlUiM7JJXJXKKnpZ9
         5XHy7Vji0g6CfU2reDe9n25/F4ve23LFPoR4yPqhfxFkIfbQ7wopdOuEO/h3OzMO3zCD
         0oZw==
X-Gm-Message-State: AOJu0Yz8jut9yDZl8wFVSt45K0kyBh+b8ZHvEVGYOv+uGFQKberJNTLh
	anLxhpRcpFyVYgSyJd2ar3CMjg==
X-Google-Smtp-Source: AGHT+IFop+NWNhZlt3dMNp594BdhHVQM6A0+JlzJPIGXbIDsGz+ug3GkLRQiPue5S2QQlbddVCJDDQ==
X-Received: by 2002:a05:6a20:3d0d:b0:18c:52d:8f79 with SMTP id y13-20020a056a203d0d00b0018c052d8f79mr24539635pzi.62.1701381594434;
        Thu, 30 Nov 2023 13:59:54 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902c38500b001cf658f20ecsm1891636plg.96.2023.11.30.13.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:59:53 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: ena: replace deprecated strncpy with strscpy
Date: Thu, 30 Nov 2023 13:59:48 -0800
Message-Id: <170138158571.3648714.3841499997574845448.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v1-1-ba4879974160@google.com>
References: <20231005-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v1-1-ba4879974160@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 05 Oct 2023 00:56:08 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> NUL-padding is not necessary as host_info is initialized to
> `ena_dev->host_attr.host_info` which is ultimately zero-initialized via
> alloc_etherdev_mq().
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] net: ena: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/111f5a435d33

Take care,

-- 
Kees Cook


