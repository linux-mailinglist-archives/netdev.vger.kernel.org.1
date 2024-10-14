Return-Path: <netdev+bounces-135180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C81FE99CA34
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 14:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83942285DB2
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 12:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B0E1A38D3;
	Mon, 14 Oct 2024 12:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgsUt0mp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD01D1A00CB
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 12:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728909137; cv=none; b=d7CSlSGcpeFxUbdgG1kS8Cn0idrUuxC6FW6Q+q+4/lr/wC4xr0VFW43IVpoGbhcQApr5m6528xFU9d/QSL6ILb4lghpdDFqDBtHNUIXfcFiz2gegxKz6BAGgYMyvA+mOYXMhTSM3DqiEjE8rGVwotVAohytl4QIcKNLeTPEF2Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728909137; c=relaxed/simple;
	bh=OOEfJ964NOXidFlJCxWO/BQQ6mRRZNpmQ44JUkreyqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6MLYWklZswhkhv7D5V5tZJvTScOeq2/1uG/ZHnTijEtSsUG/o/33tg4d7PGB8qMZ5uiPZeIAUSPaIt+epaSWlTIqshsskplM7dY8g1tKhvtwu2IVh+GDq+eBIctT55ZxLfWsZ9+nXFzUMkw9hiVWp2JPkbJx0yHmZXIeLdmRW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgsUt0mp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A34C4CED0;
	Mon, 14 Oct 2024 12:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728909137;
	bh=OOEfJ964NOXidFlJCxWO/BQQ6mRRZNpmQ44JUkreyqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hgsUt0mpbXg9eLmJls9LHDCjRw4us9itcXK6bdW1TZyT4fDu+/dJ4aJjJVMO5+J1h
	 vMH1QOBIbA+0AZl1G/olJ5pTYj1u6nLk/KQiFy95bRLvajqVNWFfDuzgqif+56IdCh
	 BDaaq/tOpKJBU0ihMJ9atgkzTJvSpdXPrvslaErppXSdGkGOSEn+YedIirhGn7HmPy
	 2G61dighsKcsQcpxVGKKf3QjgAoxTnUlMg1NtFCFOrsHE+otj0huNOdsQLC99wXnAo
	 gTuMNuCQanP4pk8Kim69TkN9MDJawO6RFUuzOkuENcbOuIqr2vAiyN18eVh54wsY5z
	 PLqV/jZ4jPiXw==
Date: Mon, 14 Oct 2024 13:32:15 +0100
From: Simon Horman <horms@kernel.org>
To: Li RongQing <lirongqing@baidu.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH][v2] net/smc: Fix searching in list of known pnetids in
 smc_pnet_add_pnetid
Message-ID: <20241014123215.GV77519@kernel.org>
References: <20241014115321.33234-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014115321.33234-1-lirongqing@baidu.com>

On Mon, Oct 14, 2024 at 07:53:21PM +0800, Li RongQing wrote:
> pnetid of pi (not newly allocated pe) should be compared
> 
> Fixes: e888a2e8337c ("net/smc: introduce list of pnetids for Ethernet devices")
> Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
> Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Reviewed-by: Simon Horman <horms@kernel.org>


