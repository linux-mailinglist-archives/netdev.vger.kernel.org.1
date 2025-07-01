Return-Path: <netdev+bounces-202853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D72AEF644
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 13:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5531B446EB9
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 11:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C2B2727FD;
	Tue,  1 Jul 2025 11:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eSvTxrrG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AD1221281
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751368423; cv=none; b=rtM/DaRopaVGVUd0/egiCDkfCQe2/t01I9NKor7sBK7AD4OEgsHBSXbYK/PtO5+VqW4Inr+YXCGYxXGd9VZd3wOPC0m2cQJWA1F8TB5hKOulaI/KCoqngccyTopUlt5aUfSBTQsxSWp2BuiCCWuoG7U1fmtrwr3QlgYqaJKvdDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751368423; c=relaxed/simple;
	bh=8jDBnTO4KAeg7BWMwqi5hx2TF6/XIeEmV7vlcXF5FVc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dxs2Khvo4LXbIAz8mI4nyjSGz4zETML0OIQYR7SxDpIeoKHEYtrulOFgzqilGTUp557OOyZz5PZsxnDxVvbaIus80Pg4AhnpGOP4P9wqmrAg2izmkzDmwtRQj9lqZYPricmUX9dNzBmr1lnZ5Rl1RZJif//IFZhzZUs6pGkCah0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eSvTxrrG; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-addda47ebeaso1165917266b.1
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 04:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751368419; x=1751973219; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RNW7caVwKhgGVodSQGEfKDOFvOt0nWsTUGnawMeLUPI=;
        b=eSvTxrrGiiM4WD29qyqcewLjbEQgcoLgNIP6VKB5uAMX2vvciNcTrev3wphPfVzoSD
         TqSme+333VSnKjW7lpforxyIt3lis1G1X5y8RYUBbxjbHtsEVHmCrwW3use68w0mZKlk
         vSKMLmjOj++UDAWWpRHWE/6H+qJeUqjhRAZVGqmk8FQVhyuh2tigfojXo0HSQ0C/NGZu
         h+cEyNo7ik0XSkAwa9a5GvRQMSCXdp1Apcem8vfT5m2EiLe+QWrlVoAhN7IlVNR8Viv2
         sVp9V9lGCjyvM403BhmQEg/d5aLHzDvaogI2+v+O13qBAD6kVg8+c/Dyyj5qELbgE1sw
         2QoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751368419; x=1751973219;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNW7caVwKhgGVodSQGEfKDOFvOt0nWsTUGnawMeLUPI=;
        b=KwIIZWsqYoCrm2XhwGjym0B1DAXjwGyjB16FoCd10PlfMDUkmPnPQV2lnOco9RpSG3
         ock+gcS569P3wTgJ9ZekEIJtAZWKbXxm0iQpxiAyLWLTeAKVeBJE81aUjkcG3NnoYYva
         TSj0rczZQdEKmiYATHYUQDqcwqj5k8qtAWf2X99PEPaMDpz9uKY1MzUo0unAKyfBB7vp
         f/p77EIY6+cJuj+evhjWAOMrQAzh3ceGacp9g6J4ClhskBoVPCLIZU/n65mrIUzFTq1z
         4R8ThUT5iffUZCdf0tlpPgj6Y0iWS3d8v+WlpmnrmEKsU+iqP9GHz0coaBY+45nPAPVt
         IBxg==
X-Forwarded-Encrypted: i=1; AJvYcCVnC0MOkC2KjZQUTs9G+IV9HJt2P1eafj0c9+Yb85ch18XA541qBzhZk6uIEG/bvZcA7sRcRkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHyz2yOJ4fer+XBUgB5OBsTt5bhhTm0nxOpSRtptDoeWlh4R2n
	x0utY+qungrRueMOGlYNdky+KI6Xc7yg43+5w0nepdg18TOIIGQWqZ2N9m+prft0R1k=
X-Gm-Gg: ASbGncvh8/dUKRwWxwT90f/xqvKsk2y1M9lap3vJgQNoCA9+vdnM+upBul92Ej6aIsS
	qNxX1LIC8/xG7zgcRMBTiRR/2HbtzbiAZkh5FzGbPr5kZ+QeQRAZ8NZkeBv36z30JnlM22Fkfy3
	ra0Fsd/Z1r7mxRJRSygjQf1WBx6uhpFHp1bGOV0XHlb33TrBELhYfJoMelPZPgeOVeOAEXx+TNG
	tju6hkibmnIv8zUIo942ePDgWVQV7focSLDrYlQGrlP6muP3XY5MY4C2vXmxl3yLdGf/V2G1QNo
	/SOj4xdAs1cYPIwJYNe6KJgE8ieJpSjCFHfWha6t59WvpnPz26h9FFxkLhNvcjxp
X-Google-Smtp-Source: AGHT+IGvBYigzda5z3S/KyAtKqMZgrtoNPrhpPSo3Xu3AtEfuPsxhlo4U3j9SMiIgVPvUL9uq9r0ig==
X-Received: by 2002:a17:907:3e87:b0:add:f189:1214 with SMTP id a640c23a62f3a-ae34fee2af8mr1390797166b.24.1751368418911;
        Tue, 01 Jul 2025 04:13:38 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:21c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6bc08sm842446366b.131.2025.07.01.04.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:13:38 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: kernel test robot <lkp@intel.com>
Cc: bpf@vger.kernel.org,  oe-kbuild-all@lists.linux.dev,  Alexei Starovoitov
 <ast@kernel.org>,  Arthur Fabre <arthur@arthurfabre.com>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Jesper Dangaard
 Brouer <hawk@kernel.org>,  Jesse Brandeburg <jbrandeburg@cloudflare.com>,
  Joanne Koong <joannelkoong@gmail.com>,  Lorenzo Bianconi
 <lorenzo@kernel.org>,  Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?=
 <thoiland@redhat.com>,  Yan
 Zhai <yan@cloudflare.com>,  netdev@vger.kernel.org,
  kernel-team@cloudflare.com,  Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next 02/13] bpf: Helpers for skb dynptr
 read/write/slice
In-Reply-To: <202507010904.MkxDYPdY-lkp@intel.com> (kernel test robot's
	message of "Tue, 1 Jul 2025 10:03:30 +0800")
References: <20250630-skb-metadata-thru-dynptr-v1-2-f17da13625d8@cloudflare.com>
	<202507010904.MkxDYPdY-lkp@intel.com>
Date: Tue, 01 Jul 2025 13:13:37 +0200
Message-ID: <87frfgnoym.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 01, 2025 at 10:03 AM +08, kernel test robot wrote:
> Hi Jakub,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on bpf-next/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Sitnicki/bpf-Ignore-dynptr-offset-in-skb-data-access/20250630-225941
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20250630-skb-metadata-thru-dynptr-v1-2-f17da13625d8%40cloudflare.com
> patch subject: [PATCH bpf-next 02/13] bpf: Helpers for skb dynptr read/write/slice
> config: microblaze-allnoconfig (https://download.01.org/0day-ci/archive/20250701/202507010904.MkxDYPdY-lkp@intel.com/config)
> compiler: microblaze-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250701/202507010904.MkxDYPdY-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507010904.MkxDYPdY-lkp@intel.com/
>
> All error/warnings (new ones prefixed by >>):
>
>    In file included from kernel/sysctl.c:29:
>>> include/linux/filter.h:1788:1: error: expected identifier or '(' before '{' token
>     1788 | {
>          | ^
>    include/linux/filter.h:1795:1: error: expected identifier or '(' before '{' token
>     1795 | {
>          | ^
>>> include/linux/filter.h:1785:19: warning: 'bpf_dynptr_skb_write' declared 'static' but never defined [-Wunused-function]
>     1785 | static inline int bpf_dynptr_skb_write(const struct bpf_dynptr_kern *dst,
>          |                   ^~~~~~~~~~~~~~~~~~~~
>>> include/linux/filter.h:1792:21: warning: 'bpf_dynptr_skb_slice' declared 'static' but never defined [-Wunused-function]
>     1792 | static inline void *bpf_dynptr_skb_slice(const struct bpf_dynptr_kern *ptr,
>          |                     ^~~~~~~~~~~~~~~~~~~~
>
>
> vim +1788 include/linux/filter.h
>
> b5964b968ac64c Joanne Koong   2023-03-01  1784  
> e8b34e67737d71 Jakub Sitnicki 2025-06-30 @1785  static inline int bpf_dynptr_skb_write(const struct bpf_dynptr_kern *dst,
> e8b34e67737d71 Jakub Sitnicki 2025-06-30  1786  				       u32 offset, const void *src, u32 len,
> e8b34e67737d71 Jakub Sitnicki 2025-06-30  1787  				       u64 flags);
> b5964b968ac64c Joanne Koong   2023-03-01 @1788  {
> b5964b968ac64c Joanne Koong   2023-03-01  1789  	return -EOPNOTSUPP;
> b5964b968ac64c Joanne Koong   2023-03-01  1790  }
> 05421aecd4ed65 Joanne Koong   2023-03-01  1791  
> e8b34e67737d71 Jakub Sitnicki 2025-06-30 @1792  static inline void *bpf_dynptr_skb_slice(const struct bpf_dynptr_kern *ptr,
> e8b34e67737d71 Jakub Sitnicki 2025-06-30  1793  					 u32 offset, void *buf, u32 len);
> e8b34e67737d71 Jakub Sitnicki 2025-06-30  1794  

Copy-paste mistake - extra ';' in the stub definition when
CONFIG_NET=n. My bad.

Will fix and respin once people had more time to review.

