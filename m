Return-Path: <netdev+bounces-111448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE536931133
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 11:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8411C21EA8
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 09:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9B51836D9;
	Mon, 15 Jul 2024 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z407GHRp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB1B199A2
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721035810; cv=none; b=hsKvK5pNEF28dOXEvuPXU17NlOPrbVvaqFVyXUjqI+o3IRGzhkwyiEnVavN/yvi/z7Zvm1BTNZB3453u3nh2zCwa8GkXP6NwjTVzf4VCP6LXcmBj0j6Bbm2ea5WOfCnyLW4e0dfj4U4tCX/OQRRSZVCSDmlWMKWGe7KqZd3d6X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721035810; c=relaxed/simple;
	bh=K3TLk/jad0OE5wriHa2BqHHQsyqPlrIX29Jx2rBLyd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjUyo8w4rUSL0MIdak8eUmSZZAUR2GVsJumiPCopH12m/lNBRF2hxHH5Y2ENUokC0RH70qq+mGVauZmayYOCL08aFHu5cfWSEKbka8g1/GLbExaGjCDd56tDxxrXry9f6ODMy5wX9tjrD8uKmxuML52DKck1Lo0bvOEAtQ9vwIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z407GHRp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABD5C32782;
	Mon, 15 Jul 2024 09:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721035810;
	bh=K3TLk/jad0OE5wriHa2BqHHQsyqPlrIX29Jx2rBLyd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z407GHRpmKbP1fMTB6oPINK9cogyCZVhefLfmfj7+9awQSUuZt4NeOptuLz4+H3eb
	 BFiNu/LeKjWvXOIX76AblpH2BHRRI2yQ8wIPpP+dDFXc5C6ZP3PIqv3YWi/Q2vXSmp
	 e3HhHoX9/p3u/yGYMrV/yvP90RcZETvn29EC8YbbVEzv/vzSu4xySidjXVypUWj6+Y
	 n5ueDWsGkYywztsPTjFRQHqtewVv0/hb0rphb1UV55+2mdgMU7hpd4KowZUgYUu04P
	 V3izdNFakKvZg0b2D1UG2pYOHKyweq6trwTthZ+gqeuqiFmusVPoAEh6/VrpfY/Cxm
	 QY6Qfjtf+B8ww==
Date: Mon, 15 Jul 2024 10:30:06 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: Re: [PATCH net-next 6/9] bnxt_en: Remove register mapping to support
 INTX
Message-ID: <20240715093006.GI8432@kernel.org>
References: <20240713234339.70293-1-michael.chan@broadcom.com>
 <20240713234339.70293-7-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713234339.70293-7-michael.chan@broadcom.com>

On Sat, Jul 13, 2024 at 04:43:36PM -0700, Michael Chan wrote:
> In legacy INTX mode, a register is mapped so that the INTX handler can
> read it to determine if the NIC is the source of the interrupt.  This
> and all the related macros are no longer needed.
> 
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>



