Return-Path: <netdev+bounces-250027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 395CBD23095
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36CF13007185
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 08:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9423C32D45B;
	Thu, 15 Jan 2026 08:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b="PzX+Io4W"
X-Original-To: netdev@vger.kernel.org
Received: from gmmr-3.centrum.cz (gmmr-3.centrum.cz [46.255.225.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313612D3EC1;
	Thu, 15 Jan 2026 08:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.225.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768464838; cv=none; b=htVpuzW6w6HdbDjktzqHv0Y7eFspokknThO51QquWHPeCJ3qR3zJlEPfhqEwdwFW/ARZNtDdZxf/0k1IhvWKfjUX2x32k7b8j1Wn8DujbuNjOFT8crSPwRWtY6vqjU7gJh0UIVVCZHVqdA3/iUlJH1ypTE70OD2GhzSOcY9Dmmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768464838; c=relaxed/simple;
	bh=RVJsit++Thv4QFWpjxk1A5tPUotoM8QUBIxSFIY+aiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=id98HfPtdVkvdy8iVvhS1pZ2faJ1UN+yVns3kIs5V+YUkRyiSAqsEwCvCvjZxldYZjHQ++jbwpWcYiQp6+TLWEA1Ldsm8PDoOoKSb6NcmhNiASG+9s7azhhhnH5n7cJXYSunvhug9fBC4NKLKFjYZljjd0JgQ8ajBReZ3D8wl1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz; spf=pass smtp.mailfrom=atlas.cz; dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b=PzX+Io4W; arc=none smtp.client-ip=46.255.225.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlas.cz
Received: from gmmr-3.centrum.cz (localhost [127.0.0.1])
	by gmmr-3.centrum.cz (Postfix) with ESMTP id E9921205FFE0;
	Thu, 15 Jan 2026 09:12:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atlas.cz; s=mail;
	t=1768464740; bh=8xs4Ur+iyrRIuci3J+LzFqMJp6PbKveiLreGF9YV6j8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PzX+Io4WQTvytOktzlWe8zZStzEvkGKY9E5an3T2xojbmYzqOc8dKrmF5Yc8nFoyL
	 9WsjJ1Fso/HOLad3FPdu1GTYKPxUbUXU1mxYwI/sZ+bF/ymyL93xa3a5Gct0GXtMCD
	 Cx4cuPtzfJqoTK9mWHikSAeEgT9+TlxHD62r1/Js=
Received: from antispam102.centrum.cz (antispam102.cent [10.30.208.102])
	by gmmr-3.centrum.cz (Postfix) with ESMTP id E4D1E20241B8;
	Thu, 15 Jan 2026 09:12:20 +0100 (CET)
X-CSE-ConnectionGUID: JIz2WijUQpieEWqCpfKtUg==
X-CSE-MsgGUID: SVgMl3xhSHqvlnkbrVU6cg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2H/BwBCoGhp/0vj/y5agQkJi1GRd1WLIoY1gSCEAYZhg?=
 =?us-ascii?q?WsPAQEBAQEBAQEBCVEEAQGFBwKMdic4EwECBAEBAQEDAgMBAQEBAQEBAQEBA?=
 =?us-ascii?q?QsBAQYBAQEBAQEGBgECgR2GCVOCW4QIAQUjBFIQCw0BCgICJgICVgaDFYI6A?=
 =?us-ascii?q?TmuY38zGgJl3HcCgSVigSwVgQouiFMBhH5xhHhCgg2EPz6EDgESAYN8gmkEg?=
 =?us-ascii?q?iKBDoFFik6IAVJ4HANZLAFVExcLBwWBI0MDgQYjSwUtHYEjIR0XEx9YGwcFE?=
 =?us-ascii?q?yOBHAYbBhwSAgMBAgI6UwyBdgICBIIQe4IBD4cQgQAFLm8aDiICQzUDC209N?=
 =?us-ascii?q?xQbBJV7gRMgG8ZggxyBCoROnSQzg3EBlAsDkmsumFipQYFRLoEPcDMiMIMjU?=
 =?us-ascii?q?RnSLoEzAgcLAQEDCYI7j2OBSwEB?=
IronPort-PHdr: A9a23:GzdngRAVN7V5rxfn4nOgUyQUC0UY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZua4xygeRFtyBtq8fw8Pt8IneGkU4qa6bt34DdJEeHzQksu4x2yEGPouuJHa/EsTXaTcnF
 t9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFRrlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5/I
 hq7oR/NusUKjoduN7g9xxvJr3ZGZu9b2X5mKVWPkhnz4cu94IRt+DlKtfI78M5AX6T6f6AmQ
 rFdET8rLWM76tD1uBfaVQeB6WMSXWoPnhdWDAbL8Qn2UZjtvCT0sOp9wzSaMtbtTb8oQzSi7
 rxkRwHuhSwaKjM26mDXish3jKJGvBKsogF0zoDIbI2JMvd1Y6XQds4YS2VcRMZcTyJPDIOiY
 YYREuQPPuhYoIbhqFQTrxSzHhWsCP/1xzNUmnP6wa833uI8Gg/GxgwgGNcOvWzOotrrKKcSS
 /2+w6bSwjXFcfZW2ir25Y/SfRA7ovGDR7dwftDLyUQ0DQzFklGQppb+Pz+PyusMsnGW4ux9X
 u2gl2ApsRt+oiSzxsgykInJgJoYxk3Y+Chlz4s4J9+1RVNmbdOmH5VduSGXOop5TM4sTW9lp
 ig0xLIGtJKmYiUG1ZQqyh7fZfCbcoWG7BbuWPiRLDp+mXlre6q/ig69/EWh0OHwSMm53VZQo
 iZbjNXBtGoB2h7T58SfVPdx40ms1SyR2wzN9u1IO144mKXHJ5I7xrM9l5weulnZECDsgkX5l
 qqWe10h+uiv9uvofK3rpoSZN49okgH+NbkumtCnDeQ4LAcOW2+b9Pyz1L3m5EH5W7BKjuEuk
 qXErZzWP9gUqbC/Aw9JyIYj9hO/Ay2639UZhXUHLVRFdwybj4XxNFzDIer0Aem/jlmsijtn2
 e7KM7/7DpjPLnXPiLLhcqx8605Yxgoz19df55dMB74bOvLzWVX+tNnCAR8jKAG72frnCNFn2
 YMFQ26AHq6YPLvIsVCU/uIvP/WMZIgNtTfzMfcl4fHujXEkmV8GfampwIEYaHGjE/t9OUqZY
 GfjgsobHWgWuQo+SfTmiEeeXj5Le3ayQ6U86ykmB428E4fMWIWtjaec0yihAJ1ZeGVGClSLE
 Xfma4WIQfEMZzyOIsN5iDwLSaChS5M91RGprAL11adoLvfR+iICtJPsysR16vbclRE18jx0A
 MCd3H+XQ25omWMIQic63Lpjrkxl1leDza94juRbFdxO/PxGSBw3NZ3CwOxgDdD9RAbBcs2OS
 Fa8TdWqGSsxQc4pw98Sf0Z9HM2vjh7e3yqxA78ViqaEBJ0u/qPSxXfxIcl9xm3C1KkgiVkmX
 8ROOXe7iaFh6QjfH5TJnFmBl6a2aaQc2zbA9HmZwmWTvUFYVRR8UavbUn8CYUvWt8r25kXBT
 7+pErknNgpBycifKqpFcNHmkEtJROn7NNTEf22xg3uwBQqPxr6UYovqen8d0zvSCEgZiQ8T5
 2uJOBM6BieguGLeECduGUjuYkLj7+VxtHy2QlUowAGNak1tz6C19QINhfyAV/MT2aoJtz0nq
 zppBlaywdzXB92GpwV/YKVTfM0y4Elc2GLdqgx9OJqgI7p+iV4eIExLuBbM3hZqAM1jkMMrq
 mgpzUImKr+S2XtCeime0JS2PafYfDrc5heqPpbbxkuW7t+QWaRHvP0iqFzmtRuBH1Ym+m4h2
 MsDgCjU3YnDEAdHCcG5aU0w7RUv/9nn
IronPort-Data: A9a23:KRK5N6NKSab0qJ/vrR0WlsFynXyQoLVcMsEvi/4bfWQNrUoqgWcHm
 GMXCz+FPPmLMDbzedB3Pojg8xhTscDSxtNkT3M5pCpnJ55oRWspJjg7wmPYZX76whjrFRo/h
 ykmQoCeaphyFDmF/03F3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZg6mJTqYb/WVrlV
 e/a+ZWFZgf8gmMsawr41orawP9RlKWv0N8nlgNmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwOhxIktl
 YoX5fRcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KUNv5
 6YnKTIwVwiCis+J2ZmjRMpwu8t2eaEHPKtH0p1h5T7cSO0jXYiaGuPB6NlExio1wMtcdRrcT
 5ZHL2AyMVKaOUIJZQp/5JEWxY9EglH2aT5RrVuPjaMr52HIigdjuFToGIOJIoHRHJoIwi50o
 Er9wWvcBkoKNOe/0CSB9HGmnNHywyj0Ddd6+LqQs6QCbEeo7nMaDhIYSEC7vPC4okS3Wt5Cb
 UcT/0IGoaEs+UmDQtDjUhi8p3CY+BgRR7J4HuEn7Qifx7b87AGeCWwJCDVGbbQOt9I8TBQp2
 0WPktevAiZg2JWbVGmd676V6yy7Pyc9KW4EeD9CQQYbi/H9qY0yi1TBQ9pkCqOzjdrdHTD23
 iDMoCUg750MjNQG2Liy51zvhzO3uoOPXB5v7VmRVWWghitwYoK/apPr71XH4fteBIKESF/Ht
 3hss9CX5u0IDLmXmSCNSflLF7asj96BMTvBkRtsEoMn+jCF5XGuZ8ZT7St4KUMvNdwLERfvb
 VPftB15+pBeJj2pYLVxbob3DN4lpYDCHM/iUNjGfoBFPt56cwrvwc11TRLOmTqwzQ52y/55Z
 srznduQMEv2wJ9PlFKeL9rxG5dymkjSGUu7qUjH8ima
IronPort-HdrOrdr: A9a23:2bgCWKt2UQHsy+T32PlbOIEF7skDYdV00zEX/kB9WHVpmwKj+P
 xGuM5rsCMc6QxhOk3I9urrBEDtex7hHNtOkO0s1NSZLWrbUQmTTb2KhLGKq1bd8m/FltK1vp
 0PT0ERMrHNMWQ=
X-Talos-CUID: =?us-ascii?q?9a23=3AylOexGqUfdOXsIpV1xSkjbzmUeIEYCfizXXtGle?=
 =?us-ascii?q?5BEtWUZaNR3yMxawxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AOTmOVA8+3PYVdYCLRGzlJd2Qf/xW7IGqU1ANqrU?=
 =?us-ascii?q?fpc2CNiZqBQrDhzviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,226,1763420400"; 
   d="scan'208";a="140531754"
Received: from unknown (HELO gm-smtp11.centrum.cz) ([46.255.227.75])
  by antispam102.centrum.cz with ESMTP; 15 Jan 2026 09:12:14 +0100
Received: from arkam (ip-213-220-240-96.bb.vodafone.cz [213.220.240.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gm-smtp11.centrum.cz (Postfix) with ESMTPSA id 077331004FFCE;
	Thu, 15 Jan 2026 09:12:14 +0100 (CET)
Date: Thu, 15 Jan 2026 09:12:13 +0100
From: Petr =?utf-8?B?VmFuxJtr?= <arkamar@atlas.cz>
To: Jakub Kicinski <kuba@kernel.org>
Cc: fushuai.wang@linux.dev, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	vadim.fedorenko@linux.dev, Jason@zx2c4.com,
	wireguard@lists.zx2c4.com, wangfushuai@baidu.com
Subject: Re: [net-next, v3] wireguard: allowedips: Use kfree_rcu() instead of
 call_rcu()
Message-ID: <202611581213-aWihXdQpdnhXv606-arkamar@atlas.cz>
References: <20260112130633.25563-1-fushuai.wang@linux.dev>
 <20260115033237.1545400-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115033237.1545400-1-kuba@kernel.org>

Hi Jakub,

Minor side note: I noticed a small typo in the AI review foreword. I
assume this is part of a template:

On Wed, Jan 14, 2026 at 07:32:37PM -0800, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least pausible.
                                                        ^~~~~~~~
pausible -> plausible

Best,
Petr

