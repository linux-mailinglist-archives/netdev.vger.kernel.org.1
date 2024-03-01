Return-Path: <netdev+bounces-76584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D229F86E48E
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 16:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 724D0B24127
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 15:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEBF40BE5;
	Fri,  1 Mar 2024 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XvanUWxU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F41E3A8E3
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709307635; cv=none; b=TB33uSmmLp3JCZHZ3e4OmZr7OOZ4Kd9+Y5LbvNpK14gdgQy5Snf8jPKwSRT6bZSaOf7IPqGtSKI5a3BxMi06SeNqcWM1Ti8OKQci/GeNh+DlXsaPxcV8D7gxcZMyLero9X8lfC9QAcasmJZrCdPvoEg0gXksWKPGvEchta04Kvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709307635; c=relaxed/simple;
	bh=ubl8WDkwRwz9VAn/qi4hksfJ7hM26ZV4VhFXq4nQGyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuF6KgaLcvcUpuyekCtk330iD54uINcUZKoLf9JK9bkAqDXP0XRfQXwVPlQobxT2t739N3qHOnnOlddTuKjsmwfPIR8ZvmQopUhL9yCqINYB7b2329+kemkh6oJzJS827nIdMyh0vhhu/E4NyRVcGj4pYRylsv56Hwdjqenelrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=XvanUWxU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412cd73ca83so1585525e9.2
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 07:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709307631; x=1709912431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ubl8WDkwRwz9VAn/qi4hksfJ7hM26ZV4VhFXq4nQGyo=;
        b=XvanUWxUeFLnKPROmX1l7ccuiwuuCmRccL1oqM5CUFvgAw7NBQBGDiiGjauBtAJFKS
         RwpfH3EAeyYaci9Amlq7AgFrnGcoy8d7hNA3ep43Hld6wi7bBaLxRrjj4o7xoivVxqYP
         CA4rVGITgnURRFoabzSrZ2WEWiSG1OUAHJmTggPKaiew9FEp2EuhCOk3DF722m7U33p1
         Q0mEUoqAn7nE/Q81IkrMOFWC72Dnb7HBP7hEiYSxcR33BJ4RBGsPIpsXhsyFbqbNdw5V
         n+fZM6n02wLezgaqbn0gmxt0CGmuzG+/It4EurU8lgPpnVjre3n2CwKS1if3iVgLOqA9
         lw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709307631; x=1709912431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubl8WDkwRwz9VAn/qi4hksfJ7hM26ZV4VhFXq4nQGyo=;
        b=b//S3Tm3tiopz3bmWOQnOhqwxUJqcGOhiWhMen/JqFUwC5ee0dzC9d5PwQehGHhZKs
         wvlBHnWD/3gKe5BXYJaNmYHQ+me8Ze4noiI4otMMTswqEzamlza4LgaJLIl908yVAJt7
         Y21t77RV67jl/8Una8mDxTU7ckn1O1dr8Kuc1cx4K5jQiLtYw7/cFjp+EkArNxSk4qz/
         al8YMzhfF5CgiKiWO4O/D9rlT14YkBkq1vF5yK88P1xvqllnghJ0JFIl6PmL2DbxSaJC
         7FTFf6KVeFPJABP1gTPBcNF0+fBHxFOUMaUZ4Rb1LRiwjnSiRWUSRctwgUCg0KwMRFri
         jBxw==
X-Forwarded-Encrypted: i=1; AJvYcCXy5C6L1lWwTFmazJDtQnHu0V9u8CrjsQX2Y5s0pin1mdv7ZxjpFlBu45VY3MI+JcKpkPkrJDGkh1QY/psORbzn6izVnZ2I
X-Gm-Message-State: AOJu0YxTZsWWXL9f5QkVHJLL4rIg/TU6FyDVt7vYF+AAX2ABIBqvNdJY
	CMnXmCLmpC86POI9bAbV9PK/8KB8ANieULwM3VZqwstW+efq0vERbLG9zFP/Oaw=
X-Google-Smtp-Source: AGHT+IE7iHX86WUR/fjnmt5Vs7vscSE4rQkydrRZuojOYy2b4SXCbAC8OlkxZVfayGT9PxjcHlsmTg==
X-Received: by 2002:a5d:4806:0:b0:33b:131b:d8c1 with SMTP id l6-20020a5d4806000000b0033b131bd8c1mr1594298wrq.66.1709307630962;
        Fri, 01 Mar 2024 07:40:30 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id p18-20020adf9d92000000b0033e18f5714esm2786131wre.59.2024.03.01.07.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:40:29 -0800 (PST)
Date: Fri, 1 Mar 2024 16:40:26 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com
Subject: Re: [PATCH net-next] dpll: avoid multiple function calls to dump
 netdev info
Message-ID: <ZeH26t7WPkfwUnhs@nanopsycho>
References: <20240301001607.2925706-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301001607.2925706-1-kuba@kernel.org>

Fri, Mar 01, 2024 at 01:16:07AM CET, kuba@kernel.org wrote:
>Due to compiler oddness and because struct dpll_pin is defined
>in a private header we have to call into dpll code to get
>the handle for the pin associated with a netdev.
>Combine getting the pin pointer and getting the info into
>a single function call by having the helpers take a netdev
>pointer, rather than expecting a pin.
>
>The exports are note needed, networking core can't be a module.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>


>---
>BTW is the empty nest if the netdev has no pin intentional?

The user can tell if this is or is not supported by kernel easily.

>Should we add a comment explaining why it's there?

Yeah.


