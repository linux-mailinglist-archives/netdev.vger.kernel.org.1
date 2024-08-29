Return-Path: <netdev+bounces-123532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8341965367
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 01:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975B3282C17
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 23:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9576518EFE6;
	Thu, 29 Aug 2024 23:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLsA9Gl3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7152E18E778
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 23:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724974120; cv=none; b=TkXpGcbhpLm2bbn/L+KoJ6yXg11KKogfF85/NDD/BQOcrS03Tj6bp9BU7461X3482F4mWMuk9bmgJr1azAOXeFKznMv7YlFFKR77XPlSUvIcSrT/EHUrWYrafSofXgQFM6FiC405J7aOygbjlkBvFXmODiZ+iQxVwvr8sSRImmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724974120; c=relaxed/simple;
	bh=MPUQcmEZ+62dUDUHfQl9jb8uQTyQwWdBgr9Bxmjdj4o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=evnel7Ipoac0viknCr2E+eFz4/NLIy++DNn5WFHzsRUjY3WcA4B82V9RKs4pBhhdNMiLcTTs7I3TddlP4R9pCbJDA6KbKsFDk4ZBhrYDNdyA3nYFIkvVoqzR/xs2lTrRRA6873MG8R7zQLgmUg2hXs/cJL4s5e7nAJWcg4LoHrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLsA9Gl3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A84BC4CEC1;
	Thu, 29 Aug 2024 23:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724974120;
	bh=MPUQcmEZ+62dUDUHfQl9jb8uQTyQwWdBgr9Bxmjdj4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BLsA9Gl3JbGxRyto6QIrtcJZ8BlBuFQZGb0OBUDd23qIIIpLY2WdH+nswz85i1l5M
	 Z370/7R2nWTEO7Nk3qmqWjaMFlig8vTG+NRTsfzZof1tuegec943qZ9JDi3cRGOaTH
	 w26EuFf9TJi0QER5ENj23EobMYdUJK5TzK9W7tkCuya9SR9MXoQu0Dme8gHcf6/iTq
	 0PxDLjnfNcshnZqhwg2m7cMQ68QjzQ9MPYUBzmXoKGmChjys0L8y60S+jvus3BH6Zp
	 pIc2dojadSUmaY41vzKITebK7tXxBRkggGCRcnhkld3clTT9Gp2ZfgxuRJG7688VOt
	 uEe//uqOsZGlA==
Date: Thu, 29 Aug 2024 16:28:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com
Subject: Re: [PATCH v5 net-next 02/12] net-shapers: implement NL get
 operation
Message-ID: <20240829162838.17444e57@kernel.org>
In-Reply-To: <53077d35a1183d5c1110076a07d73940bb2a55f3.1724944117.git.pabeni@redhat.com>
References: <cover.1724944116.git.pabeni@redhat.com>
	<53077d35a1183d5c1110076a07d73940bb2a55f3.1724944117.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 17:16:55 +0200 Paolo Abeni wrote:
> +	xa_for_each_range(&data->shapers, index, shaper, ctx->start_index,
> +			  U32_MAX) {
> +		net_shaper_index_to_handle(index, &handle);
> +		ret = net_shaper_fill_one(skb, binding, &handle, shaper, info);
> +		if (ret)
> +			return ret;
> +
> +		ctx->start_index = index;

75% sure this should say index + 1, or the xa_for_each.. should use
start_index + 1. start position is inclusive.

XA iterators are hard to get right in netlink, I'd suggest using the
same form of iteration as for_each_netdev_dump()..

