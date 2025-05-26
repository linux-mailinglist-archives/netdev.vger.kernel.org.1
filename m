Return-Path: <netdev+bounces-193410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD4FAC3D57
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 11:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABDE53AD262
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 09:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519FA1DF27F;
	Mon, 26 May 2025 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="HY3Cd3oG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B687A1F4601
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 09:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748253113; cv=none; b=CtJO963iQICMCaNXBkSkMrib+YwKh6WjBIdxpjmiPf+ZjK/roAIxP6jm8nC/b9ljtcY7n/pgY9u0kxKVK9f0ZkleJRPD23609FkUOYJXtFKAAH6Obx/yVKLKiYPhnQ86pDG34CzTfpXynhXYVJsHXXooh310NdclhrFyEdVGK2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748253113; c=relaxed/simple;
	bh=TLXHmWZ22NNH8blFf/DauL8X48ZlC3+IyN1TTLLW6fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boEtkvyBb3FsM2rra556s6V4BaaHAexVXjm7AuLSRE3UuJePytoeqh37USWnmGNqSeJr7gFTHw99niQFhxL7OUi9IhS1Wwpjm1/DNBx2SDubMBypdhGzj4OGA8iqjNa0KDbmYxA0R0xj1dv11XDCOb9EntelI+a0jVPumY4zKHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=HY3Cd3oG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so24427855e9.1
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 02:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1748253110; x=1748857910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TLXHmWZ22NNH8blFf/DauL8X48ZlC3+IyN1TTLLW6fo=;
        b=HY3Cd3oG/3VsuVWDOlEkFsjNzgg6ad1IYtLyKL/RrpIQjSdVVLiZhbGnS13R+EwoJ9
         B3E6NA59YyF3D3ipIBy1smNHFenKeFkDZtkWikzbChOhiAEtegmKnvwuZAI0dIASVjjK
         gu0JZirmsKYD4IQLOkMhNihFcFPcyZ1tKA9C+yyF2BH8qbKpHeDCd9bQAdqGlg3DXnms
         XyUw96UmPh4jrnHp6DrSeg4OZTDZcIICkOvYBXTT/zGe/t5HQLwJFhVqwjY5/g9UbUiU
         pcocu50dV/omKHua/RzjKVQXde+iBbu3viE9rc4G4OrzqqIKatVI8iI23pfew3EoIWUG
         jvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748253110; x=1748857910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLXHmWZ22NNH8blFf/DauL8X48ZlC3+IyN1TTLLW6fo=;
        b=itC8IMXUIknlyJH8t1TlHaSAIhpyHzcir+/AEGg8rYoNnp3b8u40i9D9DGfnvHuBN2
         mf2SxoqWdkx7FZRewjfR08hfagLI09dwj16zfug1NNR+hZHGaxlwoV2Pz6cDR/vvM7tW
         a75xIRRin+9YgthI8cXkIfXOR8V5+wxT5DQQjUNwVI03QI5VAzmr3EtVym8R5WZxK9WW
         tvX+9YcupxCuvkqwCnzrkMcVvw08pZdcrO3trnOoMpavCQU7mJ7jMc5BP3LbDaHhjBsk
         Bkf8oa+YUpAuA3yhkO/Q5V+VLR67NspwtG3qi/yHRVJ7unS3oY42VpTqSEwbSBEFeVYw
         03+w==
X-Forwarded-Encrypted: i=1; AJvYcCUoIa+DjCNUsDiqrX6FMY10vzr+EpEveTtVgUxnNd6mUQMeyrduPzSTDyYMJxnpgDTEqxirJ7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw19MjHtSYQF6fspXx5icSmoFYE/IfbNWffpcUSeqzJcjGIQyKY
	Ye//Y46mtFrvGvH6sMTONAApkEKxPOQBRugvy0oweumATcV2oX7B7LTAfv8YZ++NQq8=
X-Gm-Gg: ASbGncvNzriNPGysMYDqd6HYs45CU4vXwwSZeXU3BMLRV0/aD7evBi1yRKlXn5iEb4F
	DbFDRBkzpdKJbkLiY+fBuag0A2Had0LtkCzIBVLjIs0BkJ6fLCEiMZRddcrYHg1uCMcnMBhaCmX
	rrJsCaVIeSZQEPb1lDwoUEXqtPj3EcKjSQTZi2q7x99tuaA3NEiTTzFAaruZfo4NVngozLzXelp
	viOUWHlTfRa6pQeHhTihYquf/ea94PHjddtR0JWDWAsu4/Vk5C8r4+PKdh8FGGghLWSdBkcFb2M
	UM0SHq5A7ef2n9UEBgutaLMXrzNxAnh/gzudTEoAmP5N+zwRFYzHWdS4yWvuLWpeVGbBuFlz2Yz
	2zKM=
X-Google-Smtp-Source: AGHT+IE44uux+DyOqK1qMEv2nRUdNtdzs/HhoytUDuEJEKhkdLzZbypjicSdsCGfCLWn1+/un7MUqg==
X-Received: by 2002:a05:600c:5286:b0:43b:c0fa:f9cd with SMTP id 5b1f17b1804b1-44c91ad6c06mr69277355e9.7.1748253109835;
        Mon, 26 May 2025 02:51:49 -0700 (PDT)
Received: from jiri-mlt (37-48-1-197.nat.epc.tmcz.cz. [37.48.1.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44f706b9065sm6828165e9.13.2025.05.26.02.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 02:51:49 -0700 (PDT)
Date: Mon, 26 May 2025 11:51:46 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: David Arinzon <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, "Woodhouse, David" <dwmw@amazon.com>, 
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, 
	Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, 
	"Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, 
	"Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, 
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>, 
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, 
	"Bernstein, Amit" <amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, 
	"Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>, 
	"Machnikowski, Maciek" <maciek@machnikowski.net>, Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
	Gal Pressman <gal@nvidia.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Andrew Lunn <andrew@lunn.ch>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v11 net-next 4/8] devlink: Add new "enable_phc" generic
 device param
Message-ID: <2uuylwk5sp7fxxhybub3xuhm637ki3pbt2z3m34zzlguvjhgf2@djrmopbia6el>
References: <20250526060919.214-1-darinzon@amazon.com>
 <20250526060919.214-5-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526060919.214-5-darinzon@amazon.com>

Mon, May 26, 2025 at 08:09:14AM +0200, darinzon@amazon.com wrote:
>Add a new device generic parameter to enable/disable the
>PHC (PTP Hardware Clock) functionality in the device associated
>with the devlink instance.
>
>Signed-off-by: David Arinzon <darinzon@amazon.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

