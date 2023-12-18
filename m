Return-Path: <netdev+bounces-58686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1AE817D34
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 23:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB471F2147D
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 22:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBCB74E08;
	Mon, 18 Dec 2023 22:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9ifHZim"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A368B7349B
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 22:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EF3C433C7;
	Mon, 18 Dec 2023 22:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702938131;
	bh=fuCOkRcNRCuYL1taZEuX2hFpkxyQ/vwD/0ZY5a7CGrI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L9ifHZimYhi8PkYVefJFqoj9Ejncq0P/YnBYXB1PcDYWDaUiZPpgSefCcWf0D59Jx
	 +++XR12FIpfSd/6eFjfoYmH/RB3cTRnrrNhBLrJJUMu0cgPUnflTtiuCtgGBiOnamp
	 J3ogThJn9eUq5Rp6GXQFLdsJdQ7q5WuQImtHMVqiyjLICr8EggvUyS9lSsOcIT+VTF
	 Lvc9+kgos7HOPHrDVoNHFlbSwz0VKgEIrYmNcLKI+CFSGYGvNwGUFiwWK1ogFakSuB
	 EM4LmOX+BVdzrON1R2njK331Tv+OQpu9+sMaQMFptqFhdpszsHGIZzRW5pBClTZdLi
	 8uRPd1lfTjipw==
Date: Mon, 18 Dec 2023 14:22:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/3] tools: ynl-gen: use correct len for string
 and binary
Message-ID: <20231218142209.64b0a2ab@kernel.org>
In-Reply-To: <ZX1hXMhJLwgg5S1v@Laptop-X1>
References: <20231215035009.498049-1-liuhangbin@gmail.com>
	<20231215035009.498049-2-liuhangbin@gmail.com>
	<20231215180603.576748b1@kernel.org>
	<ZX1hXMhJLwgg5S1v@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Dec 2023 16:35:40 +0800 Hangbin Liu wrote:
> The max-len / min-len / extact-len micro are used by binary. For string we
> need to use "len" to define the max length. e.g.
> 
> static const struct nla_policy
> team_nl_option_policy[TEAM_ATTR_OPTION_MAX + 1] = {
>         [TEAM_ATTR_OPTION_UNSPEC]               = { .type = NLA_UNSPEC, },
>         [TEAM_ATTR_OPTION_NAME] = {
>                 .type = NLA_STRING,
>                 .len = TEAM_STRING_MAX_LEN,
>         },

max-len / min-len / extact-len are just the names in the spec.
We can put the value provided in the spec as max-len inside
nla_policy as len, given that for string spec::max-len == policy::len 

Am I confused? 

