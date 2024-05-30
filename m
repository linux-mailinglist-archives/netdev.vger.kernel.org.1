Return-Path: <netdev+bounces-99252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A06A8D434B
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 04:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137701F2154A
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 02:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFA0179BD;
	Thu, 30 May 2024 02:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6fHQnej"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397A71757E
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 02:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717034616; cv=none; b=r+ahUk5l30f/atcTri69LrwpPP9l74qWiU67BEbD9W5+boDqhtgQdpNI4+ImMh3wEvu9Mu8IgcH4wBFfsVdm/UmV89TmwT7UVehgcywlcKTt4NBzt3ejflZUlTZpbyQ6g4VyRm0tgaoc1el2XSJ+R7y7QcMpA4EgxRJlTkIOpgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717034616; c=relaxed/simple;
	bh=gIdH3BExBhcV/rnlLJf8QgLHBPyNFkOAKu+GdJdLHt8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N38mcr68SxKQO9ZhitSDjY9qlUtu5fV/fpvrK8oW6e16UXTms6nwenHnSJzVcyiFSPUtHC5ahBlBtVDDMT1nxzGCeoD4f2hTHTW+jxNnGNlK50pmHBKn8UJhcJstJPZcFY04jJqbnbMal5kN79rpXzsBT6Vat0Xk0k0RX5NGtbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6fHQnej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B14C116B1;
	Thu, 30 May 2024 02:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717034616;
	bh=gIdH3BExBhcV/rnlLJf8QgLHBPyNFkOAKu+GdJdLHt8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U6fHQnejFzu3hzNUao0XtJF2DJ3kLpofZ4o+AUTNCKPBBR//YTlG7/gcSr7WaEmed
	 c8wX/dwVT9b+ZwdC5zs7CVqDtRSEhWtJxh5v8ByhyL9FBBSJQKcqwuxTR8FJRInsfU
	 LGbwTC5p++VatfC4tOk9FueqsvCbkmgaBw6cqmMOZexDN6mgFLrQEb3ppBoewz6pPz
	 XW6DE+PfVR/RBa51KsvwbK2tw6JOP/H/YmXlYOb3J/DYr5WVh44msUtBbak1/2epUX
	 iIpnTwl608J7yp7rvusWlY9esqbBCvAteCPhGd+AZMojl3GKsDhF50U+SeYCVz/aAl
	 gq8W8att8VaEw==
Date: Wed, 29 May 2024 19:03:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Davide Caratti <dcaratti@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, i.maximets@ovn.org,
 jhs@mojatatu.com, jiri@resnulli.us, lucien.xin@gmail.com,
 marcelo.leitner@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
 xiyou.wangcong@gmail.com, echaudro@redhat.com
Subject: Re: [PATCH net-next v3 1/2] flow_dissector: add support for tunnel
 control flags
Message-ID: <20240529190334.5383f8ad@kernel.org>
In-Reply-To: <c038e68d8e336d3e2c80d616a4d418dac07c7f9d.1716911277.git.dcaratti@redhat.com>
References: <cover.1716911277.git.dcaratti@redhat.com>
	<c038e68d8e336d3e2c80d616a4d418dac07c7f9d.1716911277.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 May 2024 10:31:57 +0200 Davide Caratti wrote:
> +/**
> + * struct flow_dissector_key_enc_flags
> + * @flags: tunnel control flags

kernel-doc -Wall would like a short description:

include/net/flow_dissector.h:333: warning: missing initial short description on line:
 * struct flow_dissector_key_enc_flags
-- 
pw-bot: cr

