Return-Path: <netdev+bounces-49046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0195A7F07A9
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 17:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B4F1F22308
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 16:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF4014A83;
	Sun, 19 Nov 2023 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="wbzQOQcX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434F7C2
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 08:53:56 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-35ab17957c3so13769395ab.3
        for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 08:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1700412835; x=1701017635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUS1v3wNMMoGJxYMVaBxxhfLYqoOUIyNu6oyB8+7CoY=;
        b=wbzQOQcXZjPccipsqkggz9I7/TGZ7HrYMG6u5StgQPR/7lrAu0oK1CDxNdjYo4dFNM
         yz1XWPaVCXhAXfPE1QRk8aGqqtYvJXdDpWNvt6l6hRjXt0jEadYcIhFqmRL6t8VsdsJD
         7uglHbQUC4YRD3y9WUKVp2ePcZIMB5oVH2mNNXegVVj9JRGCXFjO3v5qAlZ+XCI+45a9
         ZeRAJsEo/YP/l0XJm7xCjt7z0U/8IsYwGvSN0zUMXGnUmXPGR1AANwHwFOrWt0GcJ5LC
         CInrVPuCDy0PcjfaTcOfVaXtit6hmJl+SBVckbveiuZor29rZfzKAtGLq0FiS/a/VkA7
         dwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700412835; x=1701017635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUS1v3wNMMoGJxYMVaBxxhfLYqoOUIyNu6oyB8+7CoY=;
        b=bm4chYnEk0AiVQW6xfWg+sVMQWYqbdX7Uy1z2LSpTK6nepLRvwm/YuuHQjk5vizPJg
         2metApZ/VhkYyoO91BF+x5UiGN+PpfK+djwD9SGvTxWLL13OjYORO4aF4WDZNtIpVztV
         M6Hd36k7nZw12nEE19ECKRD5dv3Z/JfYVAPj3dy+gV7Va5AbsnKnBJI3lCywEIbWWMnb
         Wfl3Ph8JQJHPfu/vRQ5Oz7RAmDykQn15uQoixMwuBAOInw0JO2jSa2fLp8/cUJ494KrL
         RICtaTqlDgd3meAtSk5x8EGjpXdIaqnJET66/E9OnJ69Al8hXd/KKXZ5fU7RGgCAZXK3
         +/2Q==
X-Gm-Message-State: AOJu0Yx3CmYNpJ9++3zlbfm6LjLqwXAc8R0rCsW42oQ5KS3OY6QTsMi3
	lSLTLjaPYkkzNh6heZVZByNNxQ==
X-Google-Smtp-Source: AGHT+IGZk8yR7OXDxLijh8akMDnL2tiCC7udbApOFmoHTqjULbw6221/2olHGvdVIKe0x5tKMk3c7w==
X-Received: by 2002:a05:6e02:154f:b0:357:6bd2:b2ad with SMTP id j15-20020a056e02154f00b003576bd2b2admr7366973ilu.22.1700412835617;
        Sun, 19 Nov 2023 08:53:55 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id fh6-20020a056a00390600b0069343e474bcsm4537415pfb.104.2023.11.19.08.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 08:53:55 -0800 (PST)
Date: Sun, 19 Nov 2023 08:53:53 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, kys@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 linux-kernel@vger.kernel.org, Long Li <longli@microsoft.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH net,v5, 3/3] hv_netvsc: Mark VF as slave before exposing
 it to user-mode
Message-ID: <20231119085353.757792c1@hermes.local>
In-Reply-To: <1700411023-14317-4-git-send-email-haiyangz@microsoft.com>
References: <1700411023-14317-1-git-send-email-haiyangz@microsoft.com>
	<1700411023-14317-4-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Nov 2023 08:23:43 -0800
Haiyang Zhang <haiyangz@microsoft.com> wrote:

> From: Long Li <longli@microsoft.com>
> 
> When a VF is being exposed form the kernel, it should be marked as "slave"
> before exposing to the user-mode. The VF is not usable without netvsc
> running as master. The user-mode should never see a VF without the "slave"
> flag.
> 
> This commit moves the code of setting the slave flag to the time before
> VF is exposed to user-mode.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0c195567a8f6 ("netvsc: transparent VF management")
> Signed-off-by: Long Li <longli@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Acked-by: Stephen Hemminger <stephen@networkplumber.org>



