Return-Path: <netdev+bounces-115911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53A394856D
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 00:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9070C2837D9
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 22:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A6914EC51;
	Mon,  5 Aug 2024 22:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CS0IRVqX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7526A14264C
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 22:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722896626; cv=none; b=O7vtuDKr96qfg9De10JNAWud7nEd/tnHvc4iIXlzEJyLo08pfFgrqBxV0POPjCbXfM5qF6QSTlr3fEkwfjAUBjzlBwsr+Z9vUhQ/esg2eR3WldlS7FuTZs9PmRTknNutr2AQxCg/fK/ppsXDbT7gStYMUBWF52tsTGLkpSqAbbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722896626; c=relaxed/simple;
	bh=hRF/9p18vNxoBlqUV/grX7it5yHvFaWOjODMZ1eYgsM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UB2tJL4Qb8WokfKjV9HUj8M1+xavGMfpG2J4tL8I1Irp89S7YIhMynQXUWDiw0pBQpVudCZPmFYZHgcqhyPVhenmIML8Am3RUS2CGwCPHtktg6/+RSQU7Wz5xTCYhVYo+4xtOJZ/AbghAUv/CeT5YcSKcVpyJNtmEcWAkpiD3mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CS0IRVqX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA8BC32782;
	Mon,  5 Aug 2024 22:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722896625;
	bh=hRF/9p18vNxoBlqUV/grX7it5yHvFaWOjODMZ1eYgsM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CS0IRVqXPeUhIkf8+wGT85UxFm4n9FOmvEeIAAiMqRvonIVLUPahfQwPZ65nwn7Vg
	 0Ounw/0M9uDH5UVZX761qgIs8t8ob4NXJ35/SptF+bPOVcwqt2BmNYa557yJyHm5vL
	 EUOVFAG45KI35Yl6mXjn0Z+BO7FTh1/AFEmVkYqJtvr57ieeJExAiR6NCMkAIvKovW
	 Bb3k4y7R+HxvocdW7dzy/jgxRKtyzy+RdYBBWz+KAzioKxK87O8kl/dL6tUQUCPXRH
	 dXpYR+ZvPTVKm5QMuyhvSDGxDZx1Ca/NWc4q9Tz63WWYnDUyK9S53/jlz3SjLE3jkk
	 75bD4FkReYpmg==
Date: Mon, 5 Aug 2024 15:23:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, "David Ahern"
 <dsahern@kernel.org>, Donald Sharp <sharpd@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 1/6] net: nexthop: Add flag to assert that
 NHGRP reserved fields are zero
Message-ID: <20240805152344.2aa5f237@kernel.org>
In-Reply-To: <ba50a38cbf211cc98bdbebfda53226a1785f73e7.1722519021.git.petrm@nvidia.com>
References: <cover.1722519021.git.petrm@nvidia.com>
	<ba50a38cbf211cc98bdbebfda53226a1785f73e7.1722519021.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Aug 2024 18:23:57 +0200 Petr Machata wrote:
> diff --git a/include/uapi/linux/nexthop.h b/include/uapi/linux/nexthop.h
> index dd8787f9cf39..2ed643207847 100644
> --- a/include/uapi/linux/nexthop.h
> +++ b/include/uapi/linux/nexthop.h
> @@ -33,6 +33,9 @@ enum {
>  #define NHA_OP_FLAG_DUMP_STATS		BIT(0)
>  #define NHA_OP_FLAG_DUMP_HW_STATS	BIT(1)
>  
> +/* Response OP_FLAGS. */
> +#define NHA_OP_FLAG_RESP_GRP_RESVD_0	BIT(0)

I guess these are op flags, so nobody should have a need to store them,
but having bits mean different things in and out make decoding and
binding generation much harder. Let's not do this unless absolutely
necessary. Perhaps you can start defining response flags from the 
"other end", i.e. bit 31? Chances are the two sides will never "meet".

