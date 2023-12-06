Return-Path: <netdev+bounces-54316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C198068F4
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 08:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67A228206D
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 07:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DC7182C5;
	Wed,  6 Dec 2023 07:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Wniyd2P3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DA6D44
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 23:51:58 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a1b68ae40f0so46171166b.0
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 23:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701849117; x=1702453917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eFp5uRjObHI5sx2KkKwRQYb2OVirn1mK3AeigSWlk4s=;
        b=Wniyd2P3RLg1FtMeuyUepKuWnMpXvFa+1qDMwmmnncFjQZiZno+vUPwkw/Rfewm33y
         /5rAdjVU0vckTkJaSDGBZh8+09F9lTiE6Ucfmq8i1A3LRu7tHV0KXwrJ9AOVVkbFn9so
         XGyVpv/sZ8NojMhTMv/+m0aeLgsNd+czXEylT5FgEcnadCvCb8C7g2N9UBYVeU1h3fQJ
         W5lPv/XFC/6/R3kpHz00ulRq0qP6abEv4haosB5GJeQIYJ4xlre0jXbhenVx8Ay2wAiY
         SmZnTHz9cGZAjaMPm1Yw3et2STDnl5j5lZGh/uQtCO4G76l9YFVQ0zeGHOvFEplDd0ts
         l+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701849117; x=1702453917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFp5uRjObHI5sx2KkKwRQYb2OVirn1mK3AeigSWlk4s=;
        b=detEayc6HweI9B4DT+Uq9EBc6Q2oLG8x5pZwrzymdjNySqt+qxF+ajTky2rLq5gZDU
         SdtqiQ0Tn3XHh1LmH3WiY2KzK3aF4LAmvTVXpVPxlu67XWBZRowrxoXF1/i8RL6u3Ejv
         av6mNkHpDAChiLzLW/YLelX0h7GoALh9elPnpjONbL6GQU4Hf/VYGyjoQ56rbnxAnm8B
         Mq00gfGPjPtCFfqWPVolEOlKa8gZB7J2TCstM/6pcQiYYiGqwi0oJn2nJhlHsUeoJ0xW
         W+KvepT9owcExZQLXd4Ds2Z1xPV/e/xE1fQnc9n1/g6H7XcqNs58P/thGWtSRD/r9zL8
         3lvQ==
X-Gm-Message-State: AOJu0YxpS4wQ+H7AxZspQmqKWADkJUMPRxMcpFGZJiNE/CFyqGk128pf
	q8W5YnLPhRk6Mq8QYzrCXOgHAmORQbbCnxLG0vU=
X-Google-Smtp-Source: AGHT+IHMzuY1meGvg3Pi+vDkWvago2/oB4Ztcse2n8A7UWRnbPN+dQ+ogzUsnIcWjEorXoxs4+bAgA==
X-Received: by 2002:a17:906:1cd:b0:a02:9891:29ba with SMTP id 13-20020a17090601cd00b00a02989129bamr269843ejj.15.1701849116698;
        Tue, 05 Dec 2023 23:51:56 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id q14-20020a1709064c8e00b009fc42f37970sm7915855eju.171.2023.12.05.23.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 23:51:56 -0800 (PST)
Date: Wed, 6 Dec 2023 08:51:54 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH net-next v5] netlink: specs: devlink: add some(not all)
 missing attributes in devlink.yaml
Message-ID: <ZXAoGhUnBFzQxD0f@nanopsycho>
References: <20231202123048.1059412-1-swarupkotikalapudi@gmail.com>
 <20231205191944.6738deb7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205191944.6738deb7@kernel.org>

Wed, Dec 06, 2023 at 04:19:44AM CET, kuba@kernel.org wrote:
>On Sat,  2 Dec 2023 18:00:48 +0530 Swarup Laxman Kotiaklapudi wrote:
>> Add some missing(not all) attributes in devlink.yaml.
>
>Hi Jiri,
>
>Do you want to take a closer look at the spec here?
>Looks fine to me, on a quick scroll.

Yep, will do that later today.

>
>> Suggested-by: Jiri Pirko <jiri@resnulli.us>
>> Suggested-by: Jakub Kicinski <kuba@kernel.org>
>> Fixes: f2f9dd164db0 ("netlink: specs: devlink: add the remaining command to generate complete split_ops")
>
>I'll drop these when / if applying, FWIW. 
>
>Swarup, for future reference if there are comments / changes suggested
>during normal review process you don't have to add the Suggested-by

My "suggested-by" is probably fine as I suggested Swarup to make the patch :)


>tag. The expectation is that the reviewer will send a Reviewed-by tag
>themselves at the end instead.

