Return-Path: <netdev+bounces-121082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABFA95B98D
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 17:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6582858C4
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260FD1CCB47;
	Thu, 22 Aug 2024 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntFNBRGB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32991CCB41;
	Thu, 22 Aug 2024 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339538; cv=none; b=jH7bpe6869eJ18cVi+SPIOQTwtwg6MbZCboobUEsbkLrRtu+nc4BElYxnlh8+kAjxCAGzSNBq/nAkps3OOUPYjQdqdkor8PfohL38OiwnSDmahbD3vd4re32Yi80hOLfU9Yw+QhDBHZpC8t7wzZDaAyeFq1faPQXNwZIDSABMnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339538; c=relaxed/simple;
	bh=BG/jbKcKbD5vdjEhhTKbOXzvNIOD9+PGWQh6++o2UHo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dnzpzxiGZmc6T2XdyjT6xf3kljbfgdDPyZnBSyLDuKqJK8GKOw07JuAlN5n3JsCjwkAOwph7qSnevaF0CFR2eXCHUfEHHEdB1aLzqnaV48IleQJK89V+nIlm3l92pWKHcJVdXFGiS0IXe47lwdKFe71v3FM37Siuz0Vxqlg8UGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntFNBRGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2FFC32782;
	Thu, 22 Aug 2024 15:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724339537;
	bh=BG/jbKcKbD5vdjEhhTKbOXzvNIOD9+PGWQh6++o2UHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ntFNBRGBKInNNBmuLq3tHESjRia0wIV+mqCQrXNqiOAJhkWeP8L4yTvx6n0Q7xwgy
	 nLCYRC/8BOrMvTqRFbCsTx4IunQWLo4qfrMoLlFqIRCK+q6veDGSZV51bzZewuPDiO
	 Zxb6rlSga+NGfO2mDZAZL1QWNSs+dItjJoF1tGWVgT0P9M0sQ6fqJBL5rkNG0ZsGHV
	 0kYQJ6Qwj+9YutAFBZH2N1hc/ROqP0R7+YprfkCm0D2sOFEqKXN9/9UDzdnEdJoq0W
	 SUKWeN8iiwY3ifxX1zbl3i6aojy8vtSZ2Lvde6zcsmuc17LT6XPJYBglod2rwNXRAj
	 8mlgFMz5Y4NEA==
Date: Thu, 22 Aug 2024 08:12:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xi Huang <xuiagnh@gmail.com>
Cc: madalin.bucur@nxp.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] net: dpaa:reduce number of synchronize_net() calls
Message-ID: <20240822081216.78b3a0de@kernel.org>
In-Reply-To: <20240822072042.42750-1-xuiagnh@gmail.com>
References: <20240822072042.42750-1-xuiagnh@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 15:20:42 +0800 Xi Huang wrote:
> In the function dpaa_napi_del(), we execute the netif_napi_del()
> for each cpu, which is actually a high overhead operation
> because each call to netif_napi_del() contains a synchronize_net(),
> i.e. an RCU operation. In fact, it is only necessary to call
>  __netif_napi_del and use synchronize_net() once outside of the loop.
> This change is similar to commit 2543a6000e593a ("gro_cells: reduce
> number of synchronize_net() calls") and commit 5198d545dba8ad (" net:
> remove napi_hash_del() from driver-facing API") 5198d545db.
> 
> Signed-off-by: Xi Huang <xuiagnh@gmail.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

You missed the part of Eric's response that told you to wait 24 hours:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
-- 
pv-bot: 24h

