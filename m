Return-Path: <netdev+bounces-57325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 145DB812E3F
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80EB1C213BD
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B263F8CE;
	Thu, 14 Dec 2023 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJJ2q2/R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB0F8E
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:12:32 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-336420a244dso1109773f8f.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702552351; x=1703157151; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uO1hG1vZ7ZWIGwLzkNxY8fFI8Azc1ZFjI/NCyP4Q4j0=;
        b=OJJ2q2/RDNW2w2uGcbZ8UwX3BmzihcuH69UAcEn5qQ3RhYAAl/BvFZTTOMckKaWcfW
         4Ck5KhicMf14cRCo3jrJYp3ykICTszgyaSHAnT2265NBuhoA0OfN70Fql4yAFMbMiAAV
         DhXwjQmbPWL5Wn1NN+noVVHHxqM3EsZF0iL7q+Gudm/Ysq6EimJQ2nhGS6sHuiMl7in3
         a5eqwaDhvmFbwkVJx3kxUgQt8J4fgyNCnEBBYXMEFKWLY01g4fp5GamEfRxxtUDrLQiM
         zcOjhonGHGzfc4O48cmAYhihIlfwr3+hWuQpc/JdIJAzNrK7uQjJMXIGXdyeGsC5x6Df
         IWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702552351; x=1703157151;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uO1hG1vZ7ZWIGwLzkNxY8fFI8Azc1ZFjI/NCyP4Q4j0=;
        b=WOXiimoPlkpK0uAP5bIhGmR2SlDvxYs8YPoNzneVBMLjyRk9Z8Irvm+bejr06BB5wf
         DXUxqo8mzSMkwBdzN2ib64/gRzQljPIXsrHB08IEzyJcyLnSjQYCiQ01pRpQ3mXzFliO
         uroM4qD/N/Ku+A+8y3MiNuYOLzJn7/gE00gSQWuvepAUv++dxdnzrx/PAJZChREmU6eG
         uoG3egxPIl7b5dnzoYk4xw25E5so0A9Ge6wWDAqxk2irWj3XBHEVDsv0nBCKUagOQXdY
         obZNvWgECYdbDmdtuYP1GtzphUO6Yk9JRCncJf5P1dVac5lL4WP7qjXxMeTG/9NuCbnD
         Pqrw==
X-Gm-Message-State: AOJu0Yw3ms9B/HLy3A/cyUVtJryB+GRpvngljT7Uql0I1cGYgXcBGieE
	CCUcMZN6Zrk9tTajdvSd0Jcbh4fbDs5QrQ==
X-Google-Smtp-Source: AGHT+IH0WncYFkVnjMxGpDcdgYwQiEvGN5XE+cDAKDM8BTFYD4MmePA2kEEf5/BCtz8ueka4/yQ6qQ==
X-Received: by 2002:a5d:6448:0:b0:333:2fd2:4b01 with SMTP id d8-20020a5d6448000000b003332fd24b01mr4381024wrw.125.1702552350767;
        Thu, 14 Dec 2023 03:12:30 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:7840:ddbd:bbf:1e8f])
        by smtp.gmail.com with ESMTPSA id a4-20020a056000100400b00333371c7382sm15832389wrx.72.2023.12.14.03.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:12:30 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com
Subject: Re: [PATCH net-next 1/3] netlink: specs: ovs: remove fixed header
 fields from attrs
In-Reply-To: <20231213232822.2950853-2-kuba@kernel.org> (Jakub Kicinski's
	message of "Wed, 13 Dec 2023 15:28:20 -0800")
Date: Thu, 14 Dec 2023 08:40:03 +0000
Message-ID: <m2sf455g9o.fsf@gmail.com>
References: <20231213232822.2950853-1-kuba@kernel.org>
	<20231213232822.2950853-2-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Op's "attributes" list is a workaround for families with a single
> attr set. We don't want to render a single huge request structure,
> the same for each op since we know that most ops accept only a small
> set of attributes. "Attributes" list lets us narrow down the attributes
> to what op acctually pays attention to.
>
> It doesn't make sense to put names of fixed headers in there.
> They are not "attributes" and we can't really narrow down the struct
> members.
>
> Remove the fixed header fields from attrs for ovs families
> in preparation for C codegen support.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

