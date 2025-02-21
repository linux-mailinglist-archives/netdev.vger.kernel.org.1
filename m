Return-Path: <netdev+bounces-168634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F08A3FF35
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 20:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744BC705BA7
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 19:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F4D2528EE;
	Fri, 21 Feb 2025 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="UNYvQFMm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6B0250C01
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740164448; cv=none; b=GoCYeVa+JP9Yk5/DZNceRrrP3Z9DqUbRrpzdd+5O/UmmWc+l0KRQhDs1zb/lEV/oNgg31ikWeo5Iuiv6k62LA9gaIob8qsW3dVi4L0enlLf/JT0Glxz4K/OmgvXesD+OLLfITj1BEeaPnPORP6gkl5M3FcvkRFErqUdVabXopyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740164448; c=relaxed/simple;
	bh=8DcTK+BWqvLFgfUlFyhU8LrkRaYzJUE29H3MUIQ1fWs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pn6MoBFi8koK9EAe61pDn/BKf8X1ucX+u+67FjYj646L2kwx800vJVFXnaWDf6gKF+5qVz0D4M69zAzcpHuNOTNRjebTL7HxXjzV/sXE0z6G4crIkx5Do7N8Zu4N6axygYV036gdvWOuKoKV0IGiD9/k6JfHEyGTfqrunNuDvik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=UNYvQFMm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-221050f3f00so56563325ad.2
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 11:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740164445; x=1740769245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77hh0wQ+sFBBrkK6MEd/a6yvUwrcItGhllYO30mC8s0=;
        b=UNYvQFMm8ipUKK4diYQfDub/mJ3b9O2f8Chy60VevlYCmcNPan3W66AyRVIA6wmHxj
         sEdXQvtj4pUx/R+o/c+9Zmw89vLM6qGHXoczVYe/kus4+VnTjeJqo+ISOq5INGRV0add
         81hc29lvOOsp3WQW7s36p2Duld12MGGM3TexmriVIleBupxJSOy6Al3Ql+53xA39jkAm
         tQzBJ5C2lr01f30oCQlgv9W7TdqF81kI7Go8YQ7NMuL+vxuNhMzx0DOGJQ7rvDh4FUnV
         XCi9V8cVRDRleYhP/B6LzIiZc5tevohGrxttxwEdHxmKo7ox8fUQiKFYEXmpgPzY9T2p
         XsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740164445; x=1740769245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77hh0wQ+sFBBrkK6MEd/a6yvUwrcItGhllYO30mC8s0=;
        b=NJIBkdSmCMZYwUZJ5Y24G6XmzVNXbABRyXV8EdDJcxJENItL4Se4IT2nUVNFdAVPVv
         1i8m/IbQAdS8VJ25S5M9GDobSoiKW7FRjdjJE+Z538KWhnPeQnQDPJKPK5r0zFjt6L4e
         qB3q/FjlDVn/cblbUikrRgAKhk7k0hz2FaznY7gFRtAMZwMhiuJl+Znua0Ilu1LuhcXk
         c/Zq2fg6Ty85QmWSDf3wOM0y80WUbRGNB7w5Empbq8oQFY0bfjLkcsRSBzeSnBfSbkY0
         MEc0ita0bYM3aj17PP5/WUEq12lSOzmkfzsdlgGDh0XarZNv3JjKAdSBxnuNEc+YrXDb
         NXbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWppBQL6ND0iO7VNiuE433rpV9YPmY7YeQRHtoTG6N2AiRP5yyYcqjvD3+iL4Y3c/PKvWOgH54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzr8Br8pM2oaK6TK4UIGeJsixp8sk49YZb/dbpNZ4a0Nu35LK/
	dv1LKWb5bDiAwitSyacpDlAHOLYxAQGYpkdNaZTHGyX9frBAIlaj1X2ppyiuR7Q=
X-Gm-Gg: ASbGncuP7FPliCkziFpD/dlF/tn19JpaZ9r9Wu/Yvew8N9N0cZKA9aNcLfPlsZ+E/Fj
	6++/dDp7jjoE4xz5soU95nNkGDUdWPRudKXBPfl3ex1iR/YrujGYsR0WzYnSglQdb2IdlmG1JwU
	bdmML177hwZhXelWVgApDghWJG9J96U7dMQ7hLi7J+vjHRGwmocSDdxXFtj7jicwOLnR69QGUfo
	m1jSNDGelqeazhLxuvRd7Ymjx4IzdXqr1mVA57RjR29HOm0Y6cpnkwgAecNNQFrHrBOlQbKK5vy
	67WpmooRsMJ3hdNQ/vtkb/y+25Y9O7zcQllk6SmtLSbdOzII4u5TBUt5tlA06KOyA9hHC9CK/ry
	z7NQ=
X-Google-Smtp-Source: AGHT+IGGJurj1ywGFGfMqLad+W4V0w/HWPMlDvnZ5WiNoOtzbXCiXiC9jiI+n/maSmmLogJdgVe5uw==
X-Received: by 2002:a17:903:2346:b0:21f:6fb9:9299 with SMTP id d9443c01a7336-2219ff5e7c8mr68299995ad.27.1740164445571;
        Fri, 21 Feb 2025 11:00:45 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5364676sm141352715ad.82.2025.02.21.11.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 11:00:45 -0800 (PST)
Date: Fri, 21 Feb 2025 11:00:42 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon
 <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter
 Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Thomas
 Gleixner <tglx@linutronix.de>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>, Eric Dumazet
 <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Johannes Berg
 <johannes@sipsolutions.net>, "Jamal Hadi Salim" <jhs@mojatatu.com>, Cong
 Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jason
 Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>, Lee
 Jones <lee@kernel.org>, Thomas Graf <tgraf@suug.ch>, Christoph Hellwig
 <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
 <robin.murphy@arm.com>, "Miquel Raynal" <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Zijun Hu <zijun_hu@icloud.com>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-wireless@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH *-next 00/18] Remove weird and needless 'return' for
 void APIs
Message-ID: <20250221110042.2ec3c276@hermes.local>
In-Reply-To: <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com>
References: <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 05:02:05 -0800
Zijun Hu <quic_zijuhu@quicinc.com> wrote:

> This patch series is to remove weird and needless 'return' for
> void APIs under include/ with the following pattern:
> 
> api_header.h:
> 
> void api_func_a(...);
> 
> static inline void api_func_b(...)
> {
> 	return api_func_a(...);
> }
> 
> Remove the needless 'return' in api_func_b().
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> Zijun Hu (18):
>       mm/mmu_gather: Remove needless return in void API tlb_remove_page()
>       cpu: Remove needless return in void API suspend_enable_secondary_cpus()
>       crypto: api - Remove needless return in void API crypto_free_tfm()
>       crypto: scomp - Remove needless return in void API crypto_scomp_free_ctx()
>       sysfs: Remove needless return in void API sysfs_enable_ns()
>       skbuff: Remove needless return in void API consume_skb()
>       wifi: mac80211: Remove needless return in void API _ieee80211_hw_set()
>       net: sched: Remove needless return in void API qdisc_watchdog_schedule_ns()
>       ipv4/igmp: Remove needless return in void API ip_mc_dec_group()
>       IB/rdmavt: Remove needless return in void API rvt_mod_retry_timer()
>       ratelimit: Remove needless return in void API ratelimit_default_init()
>       siox: Remove needless return in void API siox_driver_unregister()
>       gpiolib: Remove needless return in two void APIs
>       PM: wakeup: Remove needless return in three void APIs
>       mfd: db8500-prcmu: Remove needless return in three void APIs
>       rhashtable: Remove needless return in three void APIs
>       dma-mapping: Remove needless return in five void APIs
>       mtd: nand: Do not return void function in void function
> 
>  include/asm-generic/tlb.h           |  2 +-
>  include/crypto/internal/scompress.h |  2 +-
>  include/linux/cpu.h                 |  2 +-
>  include/linux/crypto.h              |  2 +-
>  include/linux/dma-mapping.h         | 12 ++++++------
>  include/linux/gpio.h                |  4 ++--
>  include/linux/igmp.h                |  2 +-
>  include/linux/mfd/dbx500-prcmu.h    |  6 +++---
>  include/linux/mtd/nand.h            | 18 ++++++++++++------
>  include/linux/pm_wakeup.h           |  6 +++---
>  include/linux/ratelimit.h           |  4 ++--
>  include/linux/rhashtable.h          |  6 +++---
>  include/linux/siox.h                |  2 +-
>  include/linux/skbuff.h              |  2 +-
>  include/linux/sysfs.h               |  2 +-
>  include/net/mac80211.h              |  2 +-
>  include/net/pkt_sched.h             |  2 +-
>  include/rdma/rdmavt_qp.h            |  2 +-
>  18 files changed, 42 insertions(+), 36 deletions(-)
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250221-rmv_return-f1dc82d492f0
> 
> Best regards,

Is this something that could be done with a coccinelle script?

