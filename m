Return-Path: <netdev+bounces-215740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC61BB3017B
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 19:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84713188A117
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14C2308F02;
	Thu, 21 Aug 2025 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rf/wFcWQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F2920B80B;
	Thu, 21 Aug 2025 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798720; cv=none; b=j81zIQuTRrtmg/P+1a49vDKtTIQipS5e9r/P1iLaIpGsFeSLKwg5Q2C3R6X59RJdRsHbMw/Y0SWskG4WBqjSfNhH//wwpWgiGpCcNJnOHXaGrFijymocGnrtyA3WdAEAdypuxFqT0thC/WzpuO6tXKqj1rtO40l4PZj+Iun8nu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798720; c=relaxed/simple;
	bh=EAiMVGfZpwWbfNqfC6/9BaIdVSxGmCT+aYtWsrPjhiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PctrR5/k+7xnVwBh1zODbW2cjqR3a5gdB3B7YD/wc4Qcvn0YJVaN4QdgVN2y/oiVOklNxUCjwMJWLSGyULlBryoQZhe6+uNsw8lLUZFYUA6B+K+by6TVx0QqAJTdfGP+rQow65qemUEajijbUDilHjUmKw53Ihmyg69X8vfrbD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rf/wFcWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2963EC4CEF4;
	Thu, 21 Aug 2025 17:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755798720;
	bh=EAiMVGfZpwWbfNqfC6/9BaIdVSxGmCT+aYtWsrPjhiQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rf/wFcWQ0oVxCbPg8aMxu8vtJPzX044cHIIOjWJsLl4gSV8E68vUXzCY1A5b5Mmdd
	 y3JmZ7Km6/hPOa1Ulbs7fZx7UmgJPHkvlc6Mm8B0DPf45f56Az4uTb57YxPgei1QQ+
	 6enyGQa4FQsVVqer1/iGMmERRx1KWjQ5PJZjLQhyL33IAuzZa+XD5Q/swjazBn34SZ
	 TpRru/HapVai/rZ7x25lPN0bvg4WkAVCZEYiFNZS2+ZUsL7AJjUmYq5ww4pyZ4sXLN
	 vLmeebk5w09P4sDPNuHmNI+A2t4CJy0CjRWIp8fxkpcRit1bY0lknHx7kJs/Z2Wxkh
	 lWJlTqyF5mTqQ==
Date: Thu, 21 Aug 2025 10:51:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org,
 ecree.xilinx@gmail.com, dsahern@kernel.org, ncardwell@google.com,
 kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me,
 aleksander.lobakin@intel.com, florian.fainelli@broadcom.com,
 willemdebruijn.kernel@gmail.com, alexander.duyck@gmail.com,
 linux-kernel@vger.kernel.org, linux-net-drivers@amd.com
Subject: Re: [PATCH net-next v3 0/5] net: gso: restore outer ip ids
 correctly
Message-ID: <20250821105158.6f2fc95e@kernel.org>
In-Reply-To: <20250821073047.2091-1-richardbgobert@gmail.com>
References: <20250821073047.2091-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 09:30:42 +0200 Richard Gobert wrote:
> GRO currently ignores outer IPv4 header IDs for encapsulated packets
> that have their don't-fragment flag set. GSO, however, always assumes
> that outer IP IDs are incrementing. This results in GSO mangling the
> outer IDs when they aren't incrementing. For example, GSO mangles the
> outer IDs of IPv6 packets that were converted to IPv4, which must
> have an ID of 0 according to RFC 6145, sect. 5.1.
> 
> GRO+GSO is supposed to be entirely transparent by default. GSO already
> correctly restores inner IDs and IDs of non-encapsulated packets. The
> tx-tcp-mangleid-segmentation feature can be enabled to allow the
> mangling of such IDs so that TSO can be used.
> 
> This series fixes outer ID restoration for encapsulated packets when
> tx-tcp-mangleid-segmentation is disabled. It also allows GRO to merge
> packets with fixed IDs that don't have their don't-fragment flag set.


This series appears to break GSO_PARTIAL:

https://netdev-3.bots.linux.dev/vmksft-fbnic-qemu/results/263201/6-tso-py/stdout
-- 
pw-bot: cr

