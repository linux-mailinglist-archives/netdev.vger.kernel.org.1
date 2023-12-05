Return-Path: <netdev+bounces-53925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 418C6805382
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 12:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEFA52813B1
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A704859E2A;
	Tue,  5 Dec 2023 11:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="o4IWNUIK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391BB135
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 03:51:56 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c9ea37ac87so46395671fa.3
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 03:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701777114; x=1702381914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=saCupLAeyujtNtMuwV42nMPC/GftoIxNg1bwcti056Y=;
        b=o4IWNUIKrsB6SF389bBczu6v5bXGLis2JvfShLPXnpu4st4RV0i5as0rAe/8Ad/y1+
         wk3Yv3dW9ZIfxSZG5Q6JMrxgtgPb0n8QFfYQrVnJeAHyw1vSUWvEwKCA1PRTy43b+4Tr
         7UdIzVU+iIWjwQGr7r7ALWfFY5UWEMlxYWZjpL4RX03TB1MResJwO18PBDe7RwFztJZW
         9Nihx7cUXkr6u1GN8KH4959srfcucgGyX3Zf3VE1bVWB9iVz7RG3CceQyOqS5dIPqSu9
         XIaXavOkvzMalQuRSo/SUXeyqSS7cow6O/81pJ3lCv+2RYspriFc6dyvCDtoe4XPdZWt
         CYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701777114; x=1702381914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saCupLAeyujtNtMuwV42nMPC/GftoIxNg1bwcti056Y=;
        b=SMAqaje0JC3Z9MKxQmIE+v1hVIuMcNU8fYOgS4o8FHg33OAu8ugieffWL72RxEHLOg
         3n5ZzimAPnXZX9FF45PcQAHUsvwVL2RIIh5/gmVY4kKXJbV2x3/zq/NAF/edJpyFBzNT
         GtFr+lwwsn4DqfjAioAkBH7Fgh0uXWlDqb+PpdCKmDFkppnluacGL5vdGI52i2JENKff
         Qq0rMBcouV04alfP2ERU87crUuZJ8vq+YdmV1Y23EWk51DckYbe1ptDWeNEFsxvix/7I
         9yqnCF0I700BWzUghCXtTui+N7DN0ES/O/eyPcIBm51C/LLZ8Q6vYOZkTbNhhPn+z28i
         ldTw==
X-Gm-Message-State: AOJu0YxAyVU2lPMHD3A9BhqT3eMqLzmcsKoZIxVG/OZHco/ED+8XIpxc
	FJ/YNmnL5CKIlb0lySTV2UjLcw==
X-Google-Smtp-Source: AGHT+IFk0VqlKcMR+pWTvLMHa+VkWjOgVcf1cpUfyU+hUxBj2azQElVybyX81VQExlEUsS6PI8t0Ww==
X-Received: by 2002:a2e:9c0c:0:b0:2ca:69:d65c with SMTP id s12-20020a2e9c0c000000b002ca0069d65cmr1694569lji.91.1701777114501;
        Tue, 05 Dec 2023 03:51:54 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id uz14-20020a170907118e00b009e5db336137sm6532982ejb.196.2023.12.05.03.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:51:54 -0800 (PST)
Date: Tue, 5 Dec 2023 12:51:52 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, marcelo.leitner@gmail.com,
	vladbu@nvidia.com
Subject: Re: [PATCH net-next v2 5/5] net/sched: cls_api: conditional
 notification of events
Message-ID: <ZW8O2KKxMM7ySr14@nanopsycho>
References: <20231204203907.413435-1-pctammela@mojatatu.com>
 <20231204203907.413435-6-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204203907.413435-6-pctammela@mojatatu.com>

Mon, Dec 04, 2023 at 09:39:07PM CET, pctammela@mojatatu.com wrote:
>As of today tc-filter/chain events are unconditionally built and sent to
>RTNLGRP_TC. As with the introduction of tc_should_notify we can check
>before-hand if they are really needed. This will help to alleviate
>system pressure when filters are concurrently added without the rtnl
>lock as in tc-flower.
>
>Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

