Return-Path: <netdev+bounces-210081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 952C8B1217A
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 18:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B441CC0EE0
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 16:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E245A2EE606;
	Fri, 25 Jul 2025 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="mmGwHMU5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A792BB17
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753459941; cv=none; b=ZehsP0Kf11t8L4wX8DjG0R7OMf/FjxTdYlV0CvA3jm36Z3B3IY5twguaH03RFwxP6T614vqntqc5MHPP0geRNaIQe5V5osdtn4Pn1JXD79A25etrfTRReY2N6MTEPYDVDSm2v1cgsGRVBw6wfTWE8jHCVYvIMVzz14aDlTOLWQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753459941; c=relaxed/simple;
	bh=9RXaPBzusmc4gEGjKmhFAjScsE/bdLvBPIpYISHdso8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODWwAkcucMhQ+THCU+oHKhBmJZywXqZFo4y2X0pck2K3DiEHnSDlRs5mKPw34rotxf5SSgrvvzntYWI8heKgtghY5rbohfqgFD7Deh7wmdOlrjwq9vS11fue0asrzuCGwGCsMH1VvUQpo59XhDUdZaL/xdIFE9sDivsnhibUYls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=mmGwHMU5; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=N/UH60VefhwxeSvSADQXBksC/DoLzJcerAXQ2HN65UE=; t=1753459940; x=1754323940; 
	b=mmGwHMU5dCVdcDh8MceazdEI5rxEHpJ05I7zOsZRjSE7ptFyODKp9wzLIUGUu+xI/bltO6aUPfU
	HhWK91JNeEcSh1/x0Wuy/aq1rm46l8LHSKYQXW1DFR9+Otg/Oen+y9kS9aL+BGIy9yHfi1NqJNc1n
	Hb/NuJgLcV7bwWAagrUombLEKeVd8CLnVcTd30xkfvzZm5IPkrrmL2Q5G7sS9eJI9enSt7jWoT944
	xIdXkSOwIGQbK1/iMXNoAmCcbbX8Kc1jedVNOBVcWSv8PRfbQ5Maw+Ufa0akfK+j4csYB1pxEI2kY
	gTvGZqoEJHjI+Y58dcymBcdq32RZFiwsOrrA==;
Received: from mail-oi1-f181.google.com ([209.85.167.181]:59397)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1ufL1v-0004U2-1q
	for netdev@vger.kernel.org; Fri, 25 Jul 2025 09:12:19 -0700
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-41b357ba04fso1190822b6e.2
        for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 09:12:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8hBRNA7fvHul0jwP8gvfdqjvgyDz4LmsfuR32z9EcvPTZXhdz3ytjDjPrYEJmw6fo1m+3yRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsyzqxtU5JvmeI//gGnMnbyK9gWqxsyI84i0WOdu5AJZQPTUZx
	4hMXxp8TL+VIYO7xV5dJe5PBh4NIoZ+BjPcuQUwbzw+w8Ium4y4s1ute4fOcni4O6/sWi6Zqry3
	u19me8agmHN+xNgq7QC6+kNIDkk4LzLM=
X-Google-Smtp-Source: AGHT+IEk179aXI8m1oiZ1IDVWKK9FV196RLu72Vd6W77tsZkN0AxRDGBICODPViz2u3CkSFxH1sVgqbsxCKQN/DdZaw=
X-Received: by 2002:a05:6808:1409:b0:401:e721:8b48 with SMTP id
 5614622812f47-42bb7eb8adamr1322760b6e.8.1753459938390; Fri, 25 Jul 2025
 09:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724184050.3130-15-ouster@cs.stanford.edu> <20250724194001.1623075-1-kuniyu@google.com>
In-Reply-To: <20250724194001.1623075-1-kuniyu@google.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 25 Jul 2025 09:11:42 -0700
X-Gmail-Original-Message-ID: <CAGXJAmysy06MEwRfdoYHiUO_CDi74TfU81kcmU77HZVy=Gdi+Q@mail.gmail.com>
X-Gm-Features: Ac12FXwSeRpf8KaQYgY5WcRvYGpGH5zKM8RJAo3Nps1h665C1f-FVgtx7JAkQlo
Message-ID: <CAGXJAmysy06MEwRfdoYHiUO_CDi74TfU81kcmU77HZVy=Gdi+Q@mail.gmail.com>
Subject: Re: [PATCH net-next v12 14/15] net: homa: create homa_plumbing.c
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: dcedbbeaec314583a5a6d4e37e27e533

On Thu, Jul 24, 2025 at 12:40=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> From: John Ousterhout <ouster@cs.stanford.edu>
> Date: Thu, 24 Jul 2025 11:40:47 -0700
> > diff --git a/net/homa/homa_plumbing.c b/net/homa/homa_plumbing.c
> > new file mode 100644
> > index 000000000000..694eb18cde00
> > --- /dev/null
> > +++ b/net/homa/homa_plumbing.c
> > @@ -0,0 +1,1115 @@
> > +// SPDX-License-Identifier: BSD-2-Clause
>
> IANAL, but I think this file is also licensed under GPL-2.0 from
> the doc below (and as you state by MODULE_LICENSE()), so you
> may want to follow other similar files throughout this series.
>
>   $ grep -rnI SPDX net | grep GPL | grep BSD
>
>
> Documentation/process/license-rules.rst
> ---8<---
> The license described in the COPYING file applies to the kernel source
> as a whole, though individual source files can have a different license
> which is required to be compatible with the GPL-2.0::
>
>     GPL-1.0+  :  GNU General Public License v1.0 or later
>     GPL-2.0+  :  GNU General Public License v2.0 or later
>     LGPL-2.0  :  GNU Library General Public License v2 only
>     LGPL-2.0+ :  GNU Library General Public License v2 or later
>     LGPL-2.1  :  GNU Lesser General Public License v2.1 only
>     LGPL-2.1+ :  GNU Lesser General Public License v2.1 or later
>
> Aside from that, individual files can be provided under a dual license,
> e.g. one of the compatible GPL variants and alternatively under a
> permissive license like BSD, MIT etc

Thanks for pointing this out; I will switch the SPDX notices to dual-licens=
e.

-John-

