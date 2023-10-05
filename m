Return-Path: <netdev+bounces-38308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9DB7BA3FC
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D723F281A2A
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553663398A;
	Thu,  5 Oct 2023 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ts6Rx3A2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3479C26E1E
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 16:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702F6C433C8;
	Thu,  5 Oct 2023 16:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696521809;
	bh=JnZVC2wJ3fKcjdODT+BG4eYptEYlKbfXzSVnEr9a20U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ts6Rx3A2Il1thlCLn+UTX+hJm4/xqTA68R0jdddsYcl12k/Q9/V7KNV/X36sda5Rr
	 5XZW8uY7QYFY9whY6I9P/HowW89AubeyFHsvdHD80sTITTsBVj0AjHSK10j+HVQs8h
	 2UhuOZBiBvicj6elJs8xT6paaw8jzCDc+buv0y0J/4DVhi90Vn5qq1z7m4uCfjxdze
	 dUyy2ALi+p8E4gyUj2s/9hl+y3A1QlLseHqhEcDqHVljniWlVQIfG73ktygqqVtyWM
	 10jwrPDvqBiGwwgwASTqiSoigS9irq9GZ/hgUkdVTcsghrh+iOYBnsoYDeL5JgC7v1
	 +GIbgWAozi7Vw==
Date: Thu, 5 Oct 2023 09:03:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Kahurani <k.kahurani@gmail.com>
Cc: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
 netdev@vger.kernel.org, wei.liu@kernel.org, paul@xen.org
Subject: Re: [PATCH] net/xen-netback: Break build if netback slots >
 max_skbs + 1
Message-ID: <20231005090328.73e87e71@kernel.org>
In-Reply-To: <CAAZOf27_Cy8jaJBnjKV7YgyaKO2WohYrxcftV5BdOdm66g_Apw@mail.gmail.com>
References: <20230927082918.197030-1-k.kahurani@gmail.com>
	<20231004114758.44944e5d@kernel.org>
	<CAAZOf27_Cy8jaJBnjKV7YgyaKO2WohYrxcftV5BdOdm66g_Apw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Oct 2023 18:39:51 +0300 David Kahurani wrote:
> > MAX_SKB_FRAGS can now be set via Kconfig, this allows us to create
> > larger super-packets. Can XEN_NETBK_LEGACY_SLOTS_MAX be made relative
> > to MAX_SKB_FRAGS, or does the number have to match between guest and
> > host?  
> 
> Historically, netback driver allows for a maximum of 18 fragments.
> With recent changes, it also relies on the assumption that the
> difference between MAX_SKB_FRAGS and XEN_NETBK_LEGACY_SLOTS_MAX is one
> and MAX_SKB_FRAGS is the lesser value.
> 
> Now, look at Ubuntu kernel for instance( a change has been made and,
> presumably, with good reason so we have reason to assume that the
> change will persist in future releases).
> 
> /* To allow 64K frame to be packed as single skb without frag_list we
>  * require 64K/PAGE_SIZE pages plus 1 additional page to allow for
>  * buffers which do not start on a page boundary.
>  *
>  * Since GRO uses frags we allocate at least 16 regardless of page
>  * size.
>  */
> #if (65536/PAGE_SIZE + 1) < 16
> #define MAX_SKB_FRAGS 16UL
> #else
> #define MAX_SKB_FRAGS (65536/PAGE_SIZE + 1)
> #endif
> 
> So, MAX_SKB_FRAGS can sometimes be 16. This is exactly what we're
> trying to avoid with this patch. I host running with this change is
> vulnerable to attack by the guest(though, this will only happen when
> PAGE_SIZE > 4096).

My bad, you're protecting from the inverse condition than I thought.

But to be clear the code you're quoting (the defines for MAX_SKB_FRAGS)
are what has been there upstream forever until 3948b059 was merged.
Not 100% sure why 3948b059 switched the min from 16 to 17, I think it
was just to keep consistency between builds.

If this change gets backported to 6.1 stable it will break ppc build
of stable, right? Since ppc has 64k pages.

