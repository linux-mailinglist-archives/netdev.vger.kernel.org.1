Return-Path: <netdev+bounces-243568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C23CA3D35
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 14:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE5CB30EB5D4
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 13:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06FF341AC0;
	Thu,  4 Dec 2025 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvAQPnzO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B3C340DA7;
	Thu,  4 Dec 2025 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764854883; cv=none; b=SO/wM4vP6EhV0xXc2Ecara/UKs8y87uVderrPLJJL0LUsrnuyPiuEw/Jw9lreHxLJ4IXt/k60nAdPtX0ZnOVN/5O4xi6g+lbYfV6mZQZh/3VsGQcMy+WVWsHxo85KOHngaNJeYPicm4X8+UWnrZKrl+aBYLF3ZwImy7v353djS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764854883; c=relaxed/simple;
	bh=rD5yyonfk65KCDCsfGo40Ulfz3gWxfONd4CUiRG924U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWDElpXeFVLPIJlW0rrLKbvtFIem41BANV3l65Z0tPjiKuUJasCrn3w6+lTqrrzjvcWAD68YdB3uGG7x58gUkgcELN+dY7WxUtwftJyT/gdmDw6bKmO/rQ8zPPNppQlRbcR8AkS5LoFLCNN2jtKJY6CgeyEy56IV2iw/VfVQxMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvAQPnzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729C8C116B1;
	Thu,  4 Dec 2025 13:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764854883;
	bh=rD5yyonfk65KCDCsfGo40Ulfz3gWxfONd4CUiRG924U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LvAQPnzOrRwigQuKfphqxnfZzhKPIL3KfbKyjmeHmHSNCiM3KjfpOhpNY1R8mU4wj
	 pyzmlkAUaIKzgcHmvLlU8l1grgDGS51ow7y0zat99MNfiXH2o7VucKANJLqcvIBNNw
	 0t43MPgnAoOHBkRzaT75+GrwMT47PYp+qbsPC18dp6AjY7SShBQCYlPeMuVYOr3neQ
	 ZDymy4QpdrKEMwZ3lBhXHTmlyoF5CENB3xRtSj2ANjMBb0vjNaFgIWoM7sRM+K0yno
	 AkQ1xV6FtTrRnQVTvAWaihIUF9W64ijiLg5Nmho16gmSnNHjdyzZ8Rq3RcZ5SOjCEe
	 9wWGgeST5wkBA==
Date: Thu, 4 Dec 2025 13:27:59 +0000
From: Simon Horman <horms@kernel.org>
To: Minseong Kim <ii4gsp@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 0/1] atm: mpoa: Fix UAF on qos_head list in procfs
Message-ID: <aTGMX7FddV4zgEgY@horms.kernel.org>
References: <20251204062421.96986-1-ii4gsp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204062421.96986-1-ii4gsp@gmail.com>

On Thu, Dec 04, 2025 at 03:24:20PM +0900, Minseong Kim wrote:
> Changes since v2:
>   - Replace atm_mpoa_search_qos() with atm_mpoa_get_qos() to avoid
>     returning an unprotected pointer.
>   - Add atm_mpoa_delete_qos_by_ip() so search+unlink+free is atomic
>     under qos_mutex, preventing double-free/UAF.
>   - Update all callers accordingly.
> 
> Minseong Kim (1):
>   atm: mpoa: Fix UAF on qos_head list in procfs

Please slow down a bit and allow at least 24h between posting
updated patches. This is to allow time for review to occur.
And reduce load on shared CI infrastructure.

Please see: https://docs.kernel.org/process/maintainer-netdev.html

