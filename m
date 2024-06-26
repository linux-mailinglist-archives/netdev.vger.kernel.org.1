Return-Path: <netdev+bounces-106969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43329184D6
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F18E28B580
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEF31850A9;
	Wed, 26 Jun 2024 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrMF3SoW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23506185091;
	Wed, 26 Jun 2024 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719413479; cv=none; b=MU08EZ5ZkCYxqjqdzNE5q6HEX3HUvMUTUuTm/Pyye2zhxmVj5rw7M6RfrUxylphQVgDmLC3Geaz6+KWRpbD9KWIIukFSY+MzZBxhCHWzVH5cq/jwp2KIzRGCjDeeCbYNsSkT0aCTdtfh6V+U7uz4/OrrHCjrrfWOZpXdtZlTHh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719413479; c=relaxed/simple;
	bh=CSsJfVEUk0CEqbSZnNyO0CexjujJdQgyreLc/rlBhPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/5d0v7ZJDOW/PgJArCmSDdv4rj1wLMH1uL19sfN7MvK9gcIw+sn36o4ant9jVFoWCqAUuAWsGzdwoPgZ0st5jUNy/tsSbAMMKUi7iYcdpQ0In4fRcd4Qw5d9f4rn+o9S3Lj0zO4T7uZ1bFmojmVc6rv2oz99rwysk2UrkTdJ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrMF3SoW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597A2C2BD10;
	Wed, 26 Jun 2024 14:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719413478;
	bh=CSsJfVEUk0CEqbSZnNyO0CexjujJdQgyreLc/rlBhPU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LrMF3SoWx0sQGD78jCcw2pMfAlGqJYdpaA1GCtAbI9zVs165eeGQEahhTfe1U2LFj
	 WJ26ubs2kRq5DCv+Gi3n5+71n40b4octIOsG+AN3+pXu7jBDCNHJ7B7IunHgwVm2ZZ
	 j7pcmHcjUw90H+GpOecyqMOiRYUZ939pxkzqpcg9SsmtBx6NV89d9PwSgqqPNxY7LM
	 kUCqCPClX1FFdONwQvpRblh4VMQWkyySGh1EHjv/98q5H7+BsUyaeOzbEKygGgNe7w
	 zhOR9H5smRTzNOEXvHsKVnNgclJ2dFHTtvTLRt7cZGN3CK4HW5fmNmoGStHBkNfjHg
	 jeJepKRfCEQWw==
Date: Wed, 26 Jun 2024 07:51:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn
 <andrew@lunn.ch>, nex.sw.ncis.osdt.itp.upstreaming@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/5] netdevice: convert private flags > BIT(31)
 to bitfields
Message-ID: <20240626075117.6a250653@kernel.org>
In-Reply-To: <20240625114432.1398320-2-aleksander.lobakin@intel.com>
References: <20240625114432.1398320-1-aleksander.lobakin@intel.com>
	<20240625114432.1398320-2-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 13:44:28 +0200 Alexander Lobakin wrote:
> +	struct_group(__priv_flags,
> +		unsigned long		priv_flags:32;
> +		unsigned long		see_all_hwtstamp_requests:1;
> +		unsigned long		change_proto_down:1;
> +	);

I don't think we should group them indiscriminately. Better to add the
asserts flag by flag. Neither of the flags you're breaking out in this
patch are used on the fast path.

Or is the problem that CACHELINE_ASSERT_GROUP_MEMBER doesn't work on
bitfields?

