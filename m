Return-Path: <netdev+bounces-133759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EA4996F8E
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BE341C21C58
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF96F1AD3E2;
	Wed,  9 Oct 2024 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWIQ2PBG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44601A2567;
	Wed,  9 Oct 2024 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486795; cv=none; b=KGU16lf1qP+gkxW4NxNaIhT0Oy6Vw8WjYXp9IWAaPH90/3Q6MWTH8/LnUGrXZaNaHOGtPq94eBKzP9rvVN4NC1ZJ0Ekg1P05+vbpxdyNo7oIBNd8C2KEHnLqF0NEbKybz4TkmYCoLn4BUzLqQ/sm9u/4/QL45IGhgY+v85nTMbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486795; c=relaxed/simple;
	bh=Lcs/OIfGqHO+nQ7yxrxBnpRFZWXRumxXSbhqNDMXzl0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQusdttak/ORmZHg+uUHXVddKTcq5zVPxKpbLd1iUtz9mOxgO+rZ6fUbvJmc1CVkpIcp8T+rjBSoApYUtOl2b+f2otnrejx8vSuwqQM7+yBdP8LuIimcraRh4Osmfazytt/4R28jjzpekVX45PDCLqMSbFAm+M+qTzsqh8RfdYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWIQ2PBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AC6C4CEC5;
	Wed,  9 Oct 2024 15:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728486795;
	bh=Lcs/OIfGqHO+nQ7yxrxBnpRFZWXRumxXSbhqNDMXzl0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iWIQ2PBGOj3IJTgc37P4Y5nLVzBQnrObXpDB9rVsA/3OXMpgMHkpHP1gN2Rvu6Sk+
	 A/hAi3dO+sMp4hoEAYFJTTx0mMod0Y9U/zGCfX/9BFLnN2qdwG+oj0NxghZlzgOtW1
	 zYU7s7GkkGRtE+gT7natUpj2I7jZSiaogIqSxDBXhhpfeS346mjJwjBswnq5wnkuHS
	 sjJAKgCjrV+OfEzDuSOUnT7YzJSUazEeSR4neAL7cWfLknsCXbK6O16kDN6EH9/Vrz
	 H5PeMpSjZ5GRkxUwM3Tmz+AJlAvbbVgrh/4Mldrz/od+XhDd1tyfEZ6D0NcMW9U1g4
	 1RjDpC+ysLVPg==
Date: Wed, 9 Oct 2024 08:13:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <liuyonglong@huawei.com>,
 <fanghaiqing@huawei.com>, <zhangkun09@huawei.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet
 <edumazet@google.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 1/2] page_pool: fix timing for checking and
 disabling napi_local
Message-ID: <20241009081314.611a5825@kernel.org>
In-Reply-To: <e420a11f-1c07-4a3f-85b4-b7679b4e50ce@huawei.com>
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
	<20240925075707.3970187-2-linyunsheng@huawei.com>
	<20241008174022.0b6d92b9@kernel.org>
	<e420a11f-1c07-4a3f-85b4-b7679b4e50ce@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Oct 2024 11:33:02 +0800 Yunsheng Lin wrote:
> Or I am missing something obvious here?

Seemingly the entire logic of how the safety of the lockless caching 
is ensured.

But I don't think you don't trust my opinion so I'll let others explain
this to you..

