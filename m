Return-Path: <netdev+bounces-33729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A16379FB46
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 07:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECDFF1F21F06
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 05:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D2725112;
	Thu, 14 Sep 2023 05:47:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B37A250FC
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 05:47:25 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6776E4D
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 22:47:24 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59b52554914so8852517b3.0
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 22:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694670444; x=1695275244; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tS5rZvk+JQ82ZNIv0TH5Yi0ePQfGELuD7tGPhOL+JYg=;
        b=JJsu+zvXz4xlIkQi2s39lZUMWsulckQVhIA8PIlJqAzDbjCyhzBF/dR28dY8VSaNof
         HirQgVEkS09wtAZQs7V27kiHtQjDpsaBEUM+Mp/sar19WwJ2sukwT1VZyfZiOYXCeAK3
         mliPuZcVl5IabVDiUHToiVXsaLE0ej31w1GmjO6xMOGm9Tv+ugQYY5D0FhqWNdly1h/o
         UGiHubetQE2aFly8LGeh8xfkDnZueFye+DCzuOCSyUmQ4bxovf1bq+f6luTVGdzbbsfx
         mTM5fNw5DLdQrPOJr8V2CwotWZW2dIGj6ARTVGpYj4YNlesn2rsYbbMJUE7O/UKbsl0a
         Jd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694670444; x=1695275244;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tS5rZvk+JQ82ZNIv0TH5Yi0ePQfGELuD7tGPhOL+JYg=;
        b=ednHO+HDACiuoRFvKuLrEGoRCkmAg4fy2fIeKKRSnwKcy59N5I5r4h2Qsn93y99Bgs
         8ZUpL1aBADelBG9pkAWuA4zzwFE+ZM3A25xYR0iJq5DWUGgeH6daBjJc2Z7//k2vkJjD
         plgbgarIq/8EzHoUj30uhbHw8ac82XCq3nMOCzeBEXyFJUrsL+rJNhrdOmFcIUd2uNHL
         XfedszxDLmZcvhjZdv/Wgmu+TQP54VEERKjPNo/tLO1U/HoosbxZeTvky3cL2JHZaJY0
         OqV7RHOrGZnP44KoaaHtzMc9GEIyanE9ovazJgtkx9OPJl5FRYXezofaozSnn5HWELkM
         umGg==
X-Gm-Message-State: AOJu0Yw2DG6zC6YujL8LlequZfzGAX66C5QeRvYHxMUuxfWO5EblW+5f
	2HJ0GrdUGodOHVgGpA1fHFm93xbsMUOZYA==
X-Google-Smtp-Source: AGHT+IG6p2OhgSYYFCejxWmLnsMS9maAkvo3+M0NMvomjvoXTGY12ej1IMxp2jnwMQibdFuQBsfPZY8GukgG6A==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:690c:fd0:b0:59b:c6bb:bab9 with SMTP
 id dg16-20020a05690c0fd000b0059bc6bbbab9mr122311ywb.3.1694670443972; Wed, 13
 Sep 2023 22:47:23 -0700 (PDT)
Date: Thu, 14 Sep 2023 05:47:21 +0000
In-Reply-To: <20230901062141.51972-2-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230901062141.51972-1-wuyun.abel@bytedance.com> <20230901062141.51972-2-wuyun.abel@bytedance.com>
Message-ID: <20230914054721.kaojkal2kcfz7drb@google.com>
Subject: Re: [RFC PATCH net-next 1/3] sock: Code cleanup on __sk_mem_raise_allocated()
From: Shakeel Butt <shakeelb@google.com>
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Yafang Shao <laoar.shao@gmail.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, David Howells <dhowells@redhat.com>, 
	Jason Xing <kernelxing@tencent.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 01, 2023 at 02:21:26PM +0800, Abel Wu wrote:
> Code cleanup for both better simplicity and readability.
> No functional change intended.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>

This is simple cleanup and can be included independently.

Acked-by: Shakeel Butt <shakeelb@google.com>

