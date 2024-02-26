Return-Path: <netdev+bounces-74920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C55B8675AD
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 13:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD60E1C23505
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 12:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D88180044;
	Mon, 26 Feb 2024 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Z9O9xi7d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB488EC7
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952037; cv=none; b=L9DHcq1wR2T7fCWAKVZAD+r2B+Xrmgf5wSeAMtHfSTZzlRmu5mRbe8Qm0bi4I1XfgIAcXwc54OWm7ceK0/DP8sq4ujVrjRRjIcgs7FocNz9D6i8Aam/3FdVkSmlnD3FFaJatFkpSDNn5WfpRPonduq0HVLM2D4jdq5jkuiK+g7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952037; c=relaxed/simple;
	bh=M9B5Uvew9xAvuUMjh9ofeJ7p8pQRcV7VkL83dSaI60U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPPyk3QB1c6gbVAZj9feKvEFD3qhP/ma3IbH6YqcPSWVyjeXSnIKVrwQqZNm71S59Ntbq4M2ix28ecH22Pb6d40jk1mjj8ynuFmoK9EcRB9YE7O4ZQLhkv8QCywpXB0SeAQzdYv/5WG3c63fwkyZARwEK/6wAW++0PTMFGushRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Z9O9xi7d; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412a958d525so1090655e9.3
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 04:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708952033; x=1709556833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M9B5Uvew9xAvuUMjh9ofeJ7p8pQRcV7VkL83dSaI60U=;
        b=Z9O9xi7dxpp7cx8NUpGPeXLqnAP2bM+5vufZEBB1FbO1LLRHK0w7C3uEnE0ZZcUk7D
         124lgXKsnGfHmrA4JsiSP9SPRg6yLCczezFbJmprkr4qxQGgqoodV328KJV9p/fclPlL
         /t1CMNe2Ivu9vZ8Tu6DAz2EvfMxiNvPiex+FxhEdSLVFJLxnMkwEBk2DlQoAD7PIkBRg
         0d/DI1vyiMjIvrtg4lYKZ6NPl2oNtwZf0mjP7vOsdtIC2KZNrVV4S80W6wyYSyyt8edq
         hcgoawZbKD/+Y5FuVunhZxUj5foe0vgWFjwODqpyV6rtD6MrnCp1Edqam0jlnvdiZ2jm
         85hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708952033; x=1709556833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9B5Uvew9xAvuUMjh9ofeJ7p8pQRcV7VkL83dSaI60U=;
        b=ABwAwAQIdVg3KTSplZLvpI/Wtwjqd5j4pmryri+pwrpytj/XQ4A3OGkT6c1i7ImyU2
         NkiCOr4D/8LDLf3fZ0oim6SDd6nNvfGqWR8AhWB95YlHL9jnT7S945xhpw83FkYyPtA5
         LHmMf7SW6qpslZxO9cEE9cr2lcndMdYd3F0EQ+dcS+wMYvW5SiHinRoSQEgDKmlcC8NT
         HEW+AJ8U5Kmp5YU6gG9S3xIzaCmz94VFzYdt8J60LlFatFMvenRgHrhs9Vl7XEChhowo
         shhb1l5GgKQhQuJtAGCBbmBcrzOuPMeDNMCWQWOa63wPiCtWTt6cnIf7fzswIrvGvWTk
         EMJw==
X-Gm-Message-State: AOJu0Yxl1P27n2xdymtEsKN1P6i7xuKBOiKZRGXh1lXpm7Kd+l++UgcB
	Ll9VVCUKUOWDvFxu4xcQ/BiLBiAB/fhosYoBOdw7i2mUPGufNVInx4sUJ5cBy2CMUq2ooyPotvf
	0
X-Google-Smtp-Source: AGHT+IH2HngUcMJC48WFCod9LwDdU8GV8wk6wSxDPAdNYGXBCkBvfwODhTqtj1uuUDkwMZa8j7vurA==
X-Received: by 2002:a5d:5b85:0:b0:33d:87e9:5900 with SMTP id df5-20020a5d5b85000000b0033d87e95900mr4608962wrb.62.1708952033028;
        Mon, 26 Feb 2024 04:53:53 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id g16-20020adffc90000000b0033d3b8820f8sm8172448wrr.109.2024.02.26.04.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 04:53:52 -0800 (PST)
Date: Mon, 26 Feb 2024 13:53:51 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jones Syue =?utf-8?B?6Jab5oe35a6X?= <jonessyue@qnap.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"j.vosburgh@gmail.com" <j.vosburgh@gmail.com>,
	"andy@greyhouse.net" <andy@greyhouse.net>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] bonding: 802.3ad replace MAC_ADDRESS_EQUAL
 with __agg_has_partner
Message-ID: <ZdyJ32Ne-qKs-RDP@nanopsycho>
References: <SI2PR04MB5097BCA8FF2A2F03D9A5A3EEDC5A2@SI2PR04MB5097.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SI2PR04MB5097BCA8FF2A2F03D9A5A3EEDC5A2@SI2PR04MB5097.apcprd04.prod.outlook.com>

Mon, Feb 26, 2024 at 03:24:52AM CET, jonessyue@qnap.com wrote:
>Replace macro MAC_ADDRESS_EQUAL() for null_mac_addr checking with inline
>function__agg_has_partner(). When MAC_ADDRESS_EQUAL() is verifiying
>aggregator's partner mac addr with null_mac_addr, means that seeing if
>aggregator has a valid partner or not. Using __agg_has_partner() makes it
>more clear to understand.
>
>In ad_port_selection_logic(), since aggregator->partner_system and
>port->partner_oper.system has been compared first as a prerequisite, it is
>safe to replace the upcoming MAC_ADDRESS_EQUAL() for null_mac_addr checking
>with __agg_has_partner().
>
>Delete null_mac_addr, which is not required anymore in bond_3ad.c, since
>all references to it are gone.
>
>Signed-off-by: Jones Syue <jonessyue@qnap.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

