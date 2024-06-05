Return-Path: <netdev+bounces-101120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5523A8FD68B
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 21:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4208289374
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 19:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E22314F9DC;
	Wed,  5 Jun 2024 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8I8TKnO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ED72E3FE
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717615923; cv=none; b=PI7UOC98fcd3ZQlLVxW1L6nBPnGRUJccLOE2zORYzAtuTrotIYJbvf52+INRZdOh9OKfLQx8ZaNN2r15m+0UFUZ/KXiWc5VTsFNUuDa6swfV2swbJlIXZSVeRJH3WYmUCUPk1O3SgCd/HLVVJejuUUPL8rtjRmuZAD8BoNd0nIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717615923; c=relaxed/simple;
	bh=m0CXhwJL3QSo1uinEHiWUBm+QL6SC5BUk6YFU+VFrX4=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHzHtO1kIxI+MeEcao1t5VCTM+kJSvwX2BuLvpKit9PlH4jx7wspQKUQvF7Wou7WKeORQv3MX7+BXWewluePVkYrwngdFivrsQZ3eoMbk2EVLdBSdp26BpacrrIDTgkojfcgqBCR16l9pNo3HO7j5UG2j6zGoZwuvJCLzt+N38U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8I8TKnO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717615919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wAUzjKjHQT48MT1CEnySduYKvPnHNLGmCrzOZbluMf0=;
	b=f8I8TKnOc+FCYN9XY7t8dkZa9m+TZ555aDpvOU6YYIzdpoU798JiftVRJA3PA6hRSYJZXE
	KpatAOQDzZqAnXyP/dWjaeDm6fkmOJ9MlyDzDIub+lqheL+YXG+yMJnRE8CCAd1JQUhIuE
	e1dsY4JnH+ZeYMo9+fUR1JYRhOWtOt8=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-aTGfRqo4MIq9DhXpHP4KyQ-1; Wed, 05 Jun 2024 15:31:58 -0400
X-MC-Unique: aTGfRqo4MIq9DhXpHP4KyQ-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5ba761a255dso102664eaf.0
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 12:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717615917; x=1718220717;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAUzjKjHQT48MT1CEnySduYKvPnHNLGmCrzOZbluMf0=;
        b=Q01HmrneFTRz5YSpO6t6zjU/qhFKd8Osm0KD1QcWWHPrn0ZsTEtCvmJugExNkah81z
         Y3NlBKGmUi5xQrl2DtZnZZaMhaLBo7ta7EaG55vsSjDqLwDM7UFikcyPSKWqfXL0Uuhv
         lVInzF76ywt6T5/JWZ0Noyb2XslXHWvc1BYu6PsjN3vqY2AHTYNxZZPUyhgrphRHJrIg
         egJAvquc2eMKHsina44dB3i/eG1n29GNHqXkPIFxgbxHXIIbdENFZCHa24VWRA2fPHKf
         ECNxIocvegAoqmPyG2qs67JwGunhVDFac27UPCQXUNPZHpPxltT62PDW7KHMsaIbUVg7
         2Ztw==
X-Gm-Message-State: AOJu0YzffVg7XLe4t25pmHQWQma5TwLeRBpq17V2sU0qUF58/rX7UpdE
	PlToXzJBD/YgGmPM1y7g8uesxkl9+lVp22FFjnXuuvPfxE0z/ky3ZmuZytnVrUAZMLMXQRRX0+5
	qJdsi7rZGNvGbpgvRfvCIK8w22joEMhWTIh7xDtYctxGzOsR4IKfPmZuXdeDbBZMuYj5tjIxRwi
	iGU/KAX3aYYVKJhTuyWzuh+f6ZJiIX
X-Received: by 2002:a05:6359:4103:b0:183:612d:44a1 with SMTP id e5c5f4694b2df-19c6ca19ed9mr443020055d.28.1717615917169;
        Wed, 05 Jun 2024 12:31:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqzqeFCvtmsiZCw2U1K3HXxO/IPPSvtKOjW3/Ru2mn4jCUk47tlrWhigUB8CObse5CiTfalvEzZeA4Lp6TeH8=
X-Received: by 2002:a05:6359:4103:b0:183:612d:44a1 with SMTP id
 e5c5f4694b2df-19c6ca19ed9mr443017355d.28.1717615916756; Wed, 05 Jun 2024
 12:31:56 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Jun 2024 19:31:55 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603185647.2310748-6-amorenoz@redhat.com> <202406050852.hDtfskO0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202406050852.hDtfskO0-lkp@intel.com>
Date: Wed, 5 Jun 2024 19:31:55 +0000
Message-ID: <CAG=2xmOQBaUki43jpUnP7F-RvkxXroQ46_CuXvbQyps=MvvYAg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/9] net: openvswitch: add emit_sample action
To: kernel test robot <lkp@intel.com>
Cc: netdev@vger.kernel.org, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, aconole@redhat.com, echaudro@redhat.com, 
	horms@kernel.org, i.maximets@ovn.org, dev@openvswitch.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Pravin B Shelar <pshelar@ovn.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 05, 2024 at 08:29:22AM GMT, kernel test robot wrote:
> Hi Adrian,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Adrian-Moreno/net-psample-add-user-cookie/20240604-030055
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20240603185647.2310748-6-amorenoz%40redhat.com
> patch subject: [PATCH net-next v2 5/9] net: openvswitch: add emit_sample action
> config: s390-randconfig-002-20240605 (https://download.01.org/0day-ci/archive/20240605/202406050852.hDtfskO0-lkp@intel.com/config)
> compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240605/202406050852.hDtfskO0-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406050852.hDtfskO0-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    s390x-linux-ld: net/openvswitch/actions.o: in function `do_execute_actions':
> >> actions.c:(.text+0x1d5c): undefined reference to `psample_sample_packet'
>

Thanks robot!

OK, I think I know what's wrong. There is an optional dependency with
PSAMPLE. Openvswitch module does compile without PSAMPLE but there is a
link error if OPENVSWITCH=y and PSAMPLE=m.

Looking into how to express this in the Kconfig, I'm planning to add the
following to the next version of the series.

diff --git a/net/openvswitch/Kconfig b/net/openvswitch/Kconfig
index 29a7081858cd..2535f3f9f462 100644
--- a/net/openvswitch/Kconfig
+++ b/net/openvswitch/Kconfig
@@ -10,6 +10,7 @@ config OPENVSWITCH
 		   (NF_CONNTRACK && ((!NF_DEFRAG_IPV6 || NF_DEFRAG_IPV6) && \
 				     (!NF_NAT || NF_NAT) && \
 				     (!NETFILTER_CONNCOUNT || NETFILTER_CONNCOUNT)))
+	depends on PSAMPLE || !PSAMPLE
 	select LIBCRC32C
 	select MPLS
 	select NET_MPLS_GSO


