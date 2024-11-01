Return-Path: <netdev+bounces-140903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB8F9B8934
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 03:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D5E1F23BCB
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52472136337;
	Fri,  1 Nov 2024 02:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUHBF/CQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FB361FF2;
	Fri,  1 Nov 2024 02:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730427396; cv=none; b=BRYi+xx+NpGnzdKlOpVg+o8VteI5PXmEHjQ8UF+UgU6Y8AZ9jHmWAuOusEUupggLb3n8ykCybuTU+v+JQIstPoMvPl4N4Y2RzUa/KSbS7OIWPIyiEmBO98NvEF6yzBCaW9YhPrcDnkF5MooUmorNvcSQapp9lgkw0DvPX8Ky7vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730427396; c=relaxed/simple;
	bh=/FdmqqSGllh9+zpaJJrObSitwP+gUvlbBlZmv39v+LI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AaRdEPSLdsKeTcR7nbuL3OSANyK/XSeGngh0r2I7ZMN+8w9yUrwdo4A/YKp0ZuJyytY3kNnH81xyZRnZHUvosB6nclpQD7aiLpSmlLHym7ka/NDM4ZXlCcpZ8nC7Y9xzw4CbWhnQ00fey3j4RYywLOrh/iECbCRq2BdeaFbbxa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUHBF/CQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AAEC4CEC3;
	Fri,  1 Nov 2024 02:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730427395;
	bh=/FdmqqSGllh9+zpaJJrObSitwP+gUvlbBlZmv39v+LI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mUHBF/CQ4f8fMJrGsdDh49JLUEGlxA3pC7aNJiQ6QeL1doAFraDlCta/Upm3/+KQa
	 WlAnoC/GhP0Xt6cxvXiytvR+U+yRf9nJjHoYWA+sP1lS81lMH416wZDfEzbwMIKK3G
	 cT8nFo6X8b7+HvoTFz6R6dIXDtHfkFM1MurFpTb4sj7JqMhtFaBXRbbzxfSicQ1JIn
	 J/1skIjyPAJ8uv0HQM/ruI+uZfMVquU8N/B4uEZ1pJNjHCeQUyuG+2iGSLNXfhkqGq
	 dh5op3aKDBQXHePQAfRNRBZx3ayNqxr+JbouB+ic643mNMcp+24nI8lxzeLx9+ka5p
	 vTLbuYGAgKVxg==
Date: Thu, 31 Oct 2024 19:16:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, chandrashekar.devegowda@intel.com,
 chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
 m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
 loic.poulain@linaro.org, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: wwan: t7xx: Fix off-by-one error in
 t7xx_dpmaif_rx_buf_alloc()
Message-ID: <20241031191633.79827a62@kernel.org>
In-Reply-To: <F9E73DD2-B898-440D-B35D-B6B10B8BC0E9@gmail.com>
References: <20241029125600.3036659-1-ruanjinjie@huawei.com>
	<F9E73DD2-B898-440D-B35D-B6B10B8BC0E9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 18:01:07 +0200 Sergey Ryazanov wrote:
> On October 29, 2024 2:56:00 PM, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> >The error path in t7xx_dpmaif_rx_buf_alloc(), free and unmap the already
> >allocated and mapped skb in a loop, but the loop condition terminates when
> >the index reaches zero, which fails to free the first allocated skb at
> >index zero.
> >
> >Check for >= 0 so that skb at index 0 is freed as well.
> >
> >Fixes: d642b012df70 ("net: wwan: t7xx: Add data path interface")
> >Suggested-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> >Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>  
> 
> Jakub, when applying, could you drop that suggested-by tag, please.
> My contribution was only a small suggestion to avoid an endless loop.
> In all other meanings this patch is original work made by Jinjie, and
> all creds should go to him.

TBH I find the while (i--) solution suggested by Ilpo more idiomatic,
too, let's do a v3 with that and without unnecessary Suggested-by tags.

