Return-Path: <netdev+bounces-51584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13677FB408
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 09:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D133A1C20E1C
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2162718033;
	Tue, 28 Nov 2023 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1tiEpBen"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F359A18D
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:25:24 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-543456dbd7bso11610428a12.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701159923; x=1701764723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pD9luI1l5jrhJbiWfDvrdw3rSL5YKUjJGuw2r4yf6Wk=;
        b=1tiEpBen0N96pDubdYi/elSlSbupqCEIGb62sfb1684ALGfBS/+f1u0nsPy5yYG40M
         6/FFn/sM3BaNjIqMqsxJ6zQL78KcMxOhAyjMmot82Zizk13IZYLnKg67yInkYP1GvPhM
         hUBpig+SkiSrr45UZYlpoevvVUiW7KXPvgFXFVsmYYDfUrpshkLNSkAZOhedp0rHHyL5
         A7qgdTtrOZhzWnbo5EHGpeji+KOCMG2X/ahQP0DqXX2wYOPsCZAvbY2ZPIwvlSpRiDFK
         C66aMHQ2azNtyrY3iCjFs+GQ1fMv1jSCowwPU4h3vJOvxJsrOYPZhWah7zoq5VX50LRe
         nS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701159923; x=1701764723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pD9luI1l5jrhJbiWfDvrdw3rSL5YKUjJGuw2r4yf6Wk=;
        b=YxSAvs8lcD1NXDw5HJSCFIw0IUztZ1bLajD5U40MX+NsySXJLWJzAl9S0d7aCa+P8G
         L37OZOhIZfYzHz6uYU8Qkj3Ow30wi4umgVEqlvfJLdgyte0py3Tt+AR1pjUee5YIT4yW
         1+dJdVJaC5MdFZ5/Ac+0LCCbUuxXVlZRNUwZ+xpU07tejA7+g6oPDsteIz3mK+jB2rkE
         lUyn6U9WJHQCsCflyeMxoX2iSZ6DUPjVyqpRA5JxOc05OnA+loatCnz/ot4J+ZE+NTeX
         xsYejSSKLT0ZYjXu4RRlc9qU0D1afOGaDzgWl3vmEpxPa8Qp81wESfCDydjrCZkiFL3e
         3UGA==
X-Gm-Message-State: AOJu0YyvctnhqXjj+VHhdhz9MZLAUw6wcxbt4S5Mmc7halWHairGBXeM
	je2cb8i3R9XFUXYY9/PZuXyBGA==
X-Google-Smtp-Source: AGHT+IH6hkqfY5D68yskr4EWHJB4qheNP/KI1VJ+QiK3MT484jKaACoTYKWLVtL07FCaxYkCL1c0xg==
X-Received: by 2002:a17:906:220b:b0:a0e:3ba4:4eac with SMTP id s11-20020a170906220b00b00a0e3ba44eacmr6896409ejs.27.1701159923404;
        Tue, 28 Nov 2023 00:25:23 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id mf8-20020a170906cb8800b009e776cc92dcsm6568585ejb.181.2023.11.28.00.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:25:22 -0800 (PST)
Date: Tue, 28 Nov 2023 09:25:21 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v4 5/9] genetlink: introduce per-sock family
 private pointer storage
Message-ID: <ZWWj8VZF5Puww2gm@nanopsycho>
References: <20231123181546.521488-1-jiri@resnulli.us>
 <20231123181546.521488-6-jiri@resnulli.us>
 <20231127144626.0abb7260@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127144626.0abb7260@kernel.org>

Mon, Nov 27, 2023 at 11:46:26PM CET, kuba@kernel.org wrote:
>On Thu, 23 Nov 2023 19:15:42 +0100 Jiri Pirko wrote:
>> +	void __rcu		*priv;
>
>How many times did I say "typed struct" in the feedback to the broken
>v3 of this series? You complain so much about people not addressing
>feedback you've given them, it's really hypocritical.

I did what I thought is best. Since this is struct netlink_sock, it is
not related only to genetlink. So other implementations may in theory
use this pointer for something else. Looked a bit odd to put
genetlink-specific pointer here, but as you wish.

>
>Put the xarray pointer here directly. Plus a lock to protect the init.

Okay, just to make this clear. You want me to have:
	struct xarray __rcu		*family_privs;

in struct netlink_sock, correct?


Why I need a lock? If I read things correctly, skbs are processed in
serial over one sock. Since this is per-sock, should be safe.


>
>The size of the per-family struct should be in family definition,
>allocation should happen on first get automatically. Family definition

Yes, I thought about that. But I decided to do this lockless, allocating
new priv every time the user sets the filter and replace the xarray item
so it could be accessed in rcu read section during notification
processing.

What you suggest requires some lock to protect the memory being changed
during filter set and suring accessing in in notify. But okay,
if you insist.


>should also hold a callback to how the data is going to be freed.

If it is alloceted automatically, why is it needed?





>-- 
>pw-bot: cr

