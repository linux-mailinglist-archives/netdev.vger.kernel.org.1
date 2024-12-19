Return-Path: <netdev+bounces-153525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD58D9F8817
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 23:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8400B189050D
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 22:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABA31D86C3;
	Thu, 19 Dec 2024 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="t0rhhzjp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46A81D79A3;
	Thu, 19 Dec 2024 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734648672; cv=none; b=qMzcoQv9h8X5kvUN5+ksKHlcUfDC8xtojly5SGfyo3F1BHYczqiKNrFVgcKQzmUdZkB3JKniigr1sBFCJ8UFlXiDgpRuXJyQEX1FT6wZSHdCvi7I+VB/TIKazVOvKfqvVlWJvJPyXcY0tAhQIumELz4g5Ks2PHsjfoxycl3sWtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734648672; c=relaxed/simple;
	bh=vn2Y7HOGnDiERqHrmWj9W5nFrgVwON2deCzXDJZ+tIw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Nte2wqMOU8bDneMdPdq2IiDrXtscWmHRYJRXFSv3nv5BSjfj4PMPBJnhPx1LpAqB2NSmPDE2uW8iZ3nFCjQjZgZPKL6cLM3QPtpp7NZdM5QsuQ4Q4o+fGlBCmyfs8OIrlHayVtXA/kz6G7G1Eul5ymdBSfSLf6LWUuiybFptUzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=t0rhhzjp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE18C4CECE;
	Thu, 19 Dec 2024 22:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1734648671;
	bh=vn2Y7HOGnDiERqHrmWj9W5nFrgVwON2deCzXDJZ+tIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t0rhhzjpz1vdogEA28Fuz6THqQkcz06UXa/pxjoJwkMHEOkW2Hoc0+OlDTF1h93YH
	 kXPOg9U0/QVr1oW9unJNYie8W/5guioFlUO/vGigsJsCVETXNdy4yRVsOUoNUkUpAu
	 H7efylqhoOToOqhPLENNK395OTBawe7wI9jBDNg8=
Date: Thu, 19 Dec 2024 14:51:10 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Gal Pressman <gal@nvidia.com>, Dennis Zhou <dennis@kernel.org>, Tejun
 Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 netdev@vger.kernel.org
Subject: Re: [PATCH] percpu: Remove intermediate variable in PERCPU_PTR()
Message-Id: <20241219145110.a4815019ca69d6d5c36f1fdf@linux-foundation.org>
In-Reply-To: <CAFULd4ZcSY+1WPn2T9dHVJZyyg1p+YaexQMJzAXHnCDy90j2fA@mail.gmail.com>
References: <20241219121828.2120780-1-gal@nvidia.com>
	<CAFULd4YHFFKBzaF28f8n3z8WcOzom1WUe_hfRBx0ehhCpT9xnQ@mail.gmail.com>
	<CAFULd4Z0PSzwvsFx_5deMKb7tV34uJWcHEadYGdk+D72QuHonA@mail.gmail.com>
	<CAFULd4ZcSY+1WPn2T9dHVJZyyg1p+YaexQMJzAXHnCDy90j2fA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Dec 2024 18:03:47 +0100 Uros Bizjak <ubizjak@gmail.com> wrote:

> > Actually, you can simplify the above a bit by writing it as:
> >
> > #define PERCPU_PTR(__p)                            \
> >     ((typeof(*(__p)) __force __kernel *)(__force unsigned long)(__p)) \
> 
> Andrew, please find attached a substitute patch "[PATCH 4/6] percpu:
> Use TYPEOF_UNQUAL() in *_cpu_ptr() accessors" for your MM tree
> relative to the above hotfix. The whole patch series (+ hotfix) has
> been re-tested against the current mainline defconfig (+ KASAN),
> compiled once with gcc-11.4.1 and once with gcc-14.2.1.

Updated, thanks.

>  #define PERCPU_PTR(__p)							\
> -	((typeof(*(__p)) __force __kernel *)(__force unsigned long)(__p)) \
> +	((TYPEOF_UNQUAL(*(__p)) __force __kernel *)(__force unsigned long)(__p)) \
>

I removed that final " \".


