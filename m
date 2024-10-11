Return-Path: <netdev+bounces-134531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE1699A01B
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 11:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93ACA1F22DB3
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 09:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C01220ADC7;
	Fri, 11 Oct 2024 09:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSUwXnvA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F3020B1F3;
	Fri, 11 Oct 2024 09:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638694; cv=none; b=E0jA8P2pX8vzuZa8pB/hLshO7FmGs4GG9BxEPtSBTDMhpjd6duvgdhb+1RoTwBAyB2vh0mEUkV6bUzVHqrKTeesYmrY35wP6oEgRmq74fDYM6VJNK9jLAydnbe8iCTnUF97Y6PWMP19nFeUs0Itn50gYUTet8OfvINOp+XM4gXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638694; c=relaxed/simple;
	bh=29JTHK8TtoAbpThuxLfdJOUJ6pvzU1TbMc+KdwGPaZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1cpVnee3YtKY4IRSR7iWLGqAtGd5GnaUBiJPdZ5gnBLZ9zlN1TXun4tOiYK05eyFtWz0anNrRkiQItnVQjVvq94iGt/fGuPxdAV52sav6/oQeQPvteexz0tyOVVhvCQBlaQaRi2aUgHBV/hPunbfmO7rbkGRm5LNkC+FoV/C2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSUwXnvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8171FC4CEC3;
	Fri, 11 Oct 2024 09:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728638694;
	bh=29JTHK8TtoAbpThuxLfdJOUJ6pvzU1TbMc+KdwGPaZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tSUwXnvAF8ga5/iEGs4FXVgxQJ9dkQV1S0UKyO+0mi/vWcKqXakdEsU2uC4l3Wt2y
	 AoLojPTX7Y/dJ248yjJOrwGm2dhXCBUofB2zl3F05UXXjtep9yhHc4igBL9ou9II3L
	 ENAeYXotK+wWpj+0o4LDVNUGXtBLPSvS2gS4OJbyFysKmSRcRQe13/yiygB8/4Z6ki
	 1ehiS6MH9i6PHkKQ5wIO71DziOC535ec49xWJqu3nPp6xGiNETDezTznOsNixdXFQt
	 Nb5MHqvbILWyXIx7oOl/anaBR4WDnFlwzaQp3jzoLVBvBj3I3kLEkO8KjN2yGv+Rxm
	 mjgXL8GBv5cEQ==
Date: Fri, 11 Oct 2024 10:24:49 +0100
From: Simon Horman <horms@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jensemil.schulzostergaard@microchip.com,
	UNGLinuxDriver@microchip.com, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: microchip: vcap api: Fix memory leaks in
 vcap_api_encode_rule_test()
Message-ID: <20241011092449.GD66815@kernel.org>
References: <20241010130231.3151896-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010130231.3151896-1-ruanjinjie@huawei.com>

On Thu, Oct 10, 2024 at 09:02:31PM +0800, Jinjie Ruan wrote:
> Commit a3c1e45156ad ("net: microchip: vcap: Fix use-after-free error in
> kunit test") fixed the use-after-free error, but introduced below
> memory leaks by removing necessary vcap_free_rule(), add it to fix it.
> 
> 	unreferenced object 0xffffff80ca58b700 (size 192):
> 	  comm "kunit_try_catch", pid 1215, jiffies 4294898264
> 	  hex dump (first 32 bytes):
> 	    00 12 7a 00 05 00 00 00 0a 00 00 00 64 00 00 00  ..z.........d...
> 	    00 00 00 00 00 00 00 00 00 04 0b cc 80 ff ff ff  ................
> 	  backtrace (crc 9c09c3fe):
> 	    [<0000000052a0be73>] kmemleak_alloc+0x34/0x40
> 	    [<0000000043605459>] __kmalloc_cache_noprof+0x26c/0x2f4
> 	    [<0000000040a01b8d>] vcap_alloc_rule+0x3cc/0x9c4
> 	    [<000000003fe86110>] vcap_api_encode_rule_test+0x1ac/0x16b0
> 	    [<00000000b3595fc4>] kunit_try_run_case+0x13c/0x3ac
> 	    [<0000000010f5d2bf>] kunit_generic_run_threadfn_adapter+0x80/0xec
> 	    [<00000000c5d82c9a>] kthread+0x2e8/0x374
> 	    [<00000000f4287308>] ret_from_fork+0x10/0x20

I guess that the rest of the log could be trimmed from the
commit message. But I don't feel strongly about that.

Also, it is probably not necessary to repost just because of this,
but as a bug fix this patch should be targeted at the net tree
and that should be indicated in the subject.

  [PATCH net] ...

...

> Cc: stable@vger.kernel.org
> Fixes: a3c1e45156ad ("net: microchip: vcap: Fix use-after-free error in kunit test")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


