Return-Path: <netdev+bounces-100644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 428AF8FB764
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 17:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1F11F28EA7
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE03B1487FF;
	Tue,  4 Jun 2024 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k88j9n7M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A69148823;
	Tue,  4 Jun 2024 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515046; cv=none; b=T5fDK6Hs1ulfa3JsReT2UNtiiKWo1l/4KZPAuhuyfXLutL55D8BUkD8n2D2VS27Ag88ESTfIp0lndiTA/OFt3RCJEHFVdpENlcbv//ybGMdmeORBUpcZWKUs/ZIP85lWZ5dhnZrvgrAAtHb7k6p8956hjjntt6zGgVy5j7CyG9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515046; c=relaxed/simple;
	bh=Q9gF5EgvOA5LLTK9cyxR6L7uKhJE03ZNCS1qXfNrvcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7rwmcnAbGDgi7DHecbYLEJ80UtgiwNTWNmUxeHQ/jZFAYdiTcY+tSNZjr6LW5s443k4aiGHq7wj4pCnUE9gZXycDdQJZo0wAs/bIzS6EbVgtRyc5zBhTzp+HQpu7zfQ8xcbyyuRpUi9Q0w/vCXJSQQA5mrsBUJvGBBC9jKCEA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k88j9n7M; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70249faa853so1142073b3a.3;
        Tue, 04 Jun 2024 08:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717515045; x=1718119845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4WUAd0a07uosayYjXtVChrzkP1MPzC+1BaRARn2bBEQ=;
        b=k88j9n7MFuzJcH33h4Oii2P9d7hsEwpYKpng7qGBCQDxrELyhBKRVYzQAD2pPfAbkP
         1dja4BEgz85f3ZCo9dYNdKUn2/jIYvXu/US8GCb9wZLIgVMFbNrBk6iEYvpPkqHBXcBT
         UZEjpKN6yTgG0YbKr/ZMG1PPe1wiy83lGnqjSy2v5/r/uyNoGJKz7OvwueYNbtX3yG6d
         CszHtMJVWYDgZQJr3ybruKVZ3q3EiVY/D5Vy1E77oUZVW3Cf3j9XaxCGfKiAtLQ1yT/0
         eqXJr7o2WCJOXs18UlxjRox6lV//CKfVp8gS+ApHGA0pffs/GnRHfr7HxX/+7HqEryZq
         Qjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717515045; x=1718119845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WUAd0a07uosayYjXtVChrzkP1MPzC+1BaRARn2bBEQ=;
        b=ZNk8VwnFEitVZu2bpQBqVdit1ThNVuAYd/JsusdofcEnz4gREdcNfLjDtJSOCNhlPr
         YW01sxbbVLJvy91bjUbuKh2NKZmACemnNqDRz2+rLenmkklgIajm/7fD2e3XV8lyuAks
         ck7bL+tBZbdvCYoR6tVOTrGpIbUZ1hXtLZc2M7IcPrPv7Qg7+dFxdd7IyfRicPSISLlH
         DZuTTs2yJYire8+yoXubUyWufs1oarCNL+ijn8i3IlkDDgIMRNcCKwdXjco59IXrud6b
         mTVdecTadaDBT66PFvri7lhzQkGdQR8XGTUaohuPrxTqSE7SDo9R8oiYc5a0shYKZ0kW
         sM8w==
X-Forwarded-Encrypted: i=1; AJvYcCWmVuZmZ0JVK9N7H7mo2aCjhh0QPHwCa7HLqL2UGaVyhze3c8Ru+GGH1e0cdhsaG80TdmaP+ZYL2Ob9/iH263UU02IQ7P56C6Ddn9RvDieyv7QGmRjXBx/fuTGuc0HuQkfAyW/P
X-Gm-Message-State: AOJu0Yw/6D6Ztpi0iujcV70RE4fV2Tr0AcYvS8CFhm83DJhguxn0rUpA
	PdF50Cqkm/RXHtfDe6KG8VuycP2K8KzlnkB4L0tG2tsG4KW3bqwf
X-Google-Smtp-Source: AGHT+IHtUBT0YoPw58DQPWj5WKfxhmZloZmO4RwctteaSvYZiFcb0RwT8INBmthrDxbbSs+ryxJOHQ==
X-Received: by 2002:a05:6a20:100e:b0:1af:fff9:1c5e with SMTP id adf61e73a8af0-1b26f23d529mr10932023637.43.1717515044674;
        Tue, 04 Jun 2024 08:30:44 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:274a:7c25:e246:a4c4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242ae89b0sm7190463b3a.101.2024.06.04.08.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 08:30:44 -0700 (PDT)
Date: Tue, 4 Jun 2024 08:30:43 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Hangyu Hua <hbh25y@gmail.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	vladbu@mellanox.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sched: sch_multiq: fix possible OOB write in
 multiq_tune()
Message-ID: <Zl8zI9qQDtNcB0F7@pop-os.localdomain>
References: <20240603071303.17986-1-hbh25y@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603071303.17986-1-hbh25y@gmail.com>

On Mon, Jun 03, 2024 at 03:13:03PM +0800, Hangyu Hua wrote:
> q->bands will be assigned to qopt->bands to execute subsequent code logic
> after kmalloc. So the old q->bands should not be used in kmalloc.
> Otherwise, an out-of-bounds write will occur.
> 
> Fixes: c2999f7fb05b ("net: sched: multiq: don't call qdisc_put() while holding tree lock")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>

Looks good to me.

Acked-by: Cong Wang <cong.wang@bytedance.com>

Thanks.

