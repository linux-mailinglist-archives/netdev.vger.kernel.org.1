Return-Path: <netdev+bounces-249645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA0CD1BC3D
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 01:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39C333016340
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 00:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7230B35581D;
	Wed, 14 Jan 2026 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NeCMgxIZ"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7C530E84A
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 00:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768348813; cv=none; b=aV34G6GPYIw1fBI8m7QbvgLWe7ATY3umyam8aGbwLk30OcbIOg7bw+9ihAJBkZ8zOTKufV5j81cIfOQPgUa6SHkfnMlsxSVkYYFQ8peYyzPaD4H1ENoc+53hCUXFOgzn+rsdYtqLyWErVQrgRbDpWQMJnmZnUUo6BjFSCUf7zT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768348813; c=relaxed/simple;
	bh=cgBDizAyonfYIqSrnhGl9fQcV2GBbnTgA7hDpPmfvpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RUhik+ncU4KY9fFtKuLXztkBFA3bVTDp1Hm7rxsSB2JuB+WxBZXGtUsGLKiwLbFvoq68aByZoQVQCfOzddmASA/G2jc0VMxxwpUYFPDEg0QL8inzQ+yNRXogmILLTxOqGnsuTsWcja8/qQzjFfD9i1k9a/VS8AQij5S9EPQqzjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NeCMgxIZ; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d9b9bd69-e232-45ff-b210-c21229946427@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768348809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9vkd5Vwe8NUqXXhB8w9t5WgfI6zx49RL54i6l3mSiy8=;
	b=NeCMgxIZFYORfPiqkPhw0ubF/LKtnDoREbEhJZj+5PNdx2fhTBr79+ZxqC9HCVeINtrLLD
	z+W9sS4e8uBeVZmCuZfbF14cXcwYLj0Ma15qRQ/Uaqlwc94Qsv1x8tlw5PFSY1tA2wR6+I
	WI0fQeJdBF3zkOK0BdNIGGZe1Qj612A=
Date: Wed, 14 Jan 2026 00:00:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] bnxt_en: Fix build break on non-x86 platforms
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, sfr@canb.auug.org.au,
 kernel test robot <lkp@intel.com>
References: <20260113183422.508851-1-michael.chan@broadcom.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260113183422.508851-1-michael.chan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/01/2026 18:34, Michael Chan wrote:
> From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> Commit c470195b989fe added .getcrosststamp() interface where
> the code uses boot_cpu_has() function which is available only
> in x86 platforms. This fails the build on any other platform.
> 
> Since the interface is going to be supported only on x86 anyway,
> we can simply compile out the entire support on non-x86 platforms.
> 
> Cover the .getcrosststamp support under CONFIG_X86
> 
> Fixes: c470195b989f ("bnxt_en: Add PTP .getcrosststamp() interface to get device/host times")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202601111808.WnBJCuWI-lkp@intel.com
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

