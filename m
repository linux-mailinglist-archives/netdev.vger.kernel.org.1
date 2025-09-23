Return-Path: <netdev+bounces-225468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DE9B93E35
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 03:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 222817B3644
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 01:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1E52571DE;
	Tue, 23 Sep 2025 01:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tV9Zr299"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22B52459C5;
	Tue, 23 Sep 2025 01:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758591291; cv=none; b=VokL8kkgFQmPdWOXT3oSg3qNVoL9Aep2gmnpMeZakGkE7l+ktzPOnhjhBC3v4i0pz8JgM0olZEkPexidG2sQ4KAUEkQ8qbCUuAHHGZpwgtfCk4/qRCiC6ePbf0apEL4oGOYQa8UxywLkfcYeQ0K/aefvVwAOwn7jviRuYhIqxDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758591291; c=relaxed/simple;
	bh=gtDkFTXgVv7DVN2MGnyG5Te3hs9DML1Nc18YcEC6RcU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWnJ0P0/74oPgwZSOR8c6nOapgoga2zE8cxh1Zwpcfko2AoUEk1hOWqGDbbmUA5s71tzUPcalNCm9klVXVGoQJV6/DeNTMEJ3J+shhSQjK4JHwn7ewtvZAVQJopMHd2kBAsHzP/ATcpBNrjg0ashIeM27Be6ZxdGe8Zhze30hPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tV9Zr299; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF079C4CEF0;
	Tue, 23 Sep 2025 01:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758591290;
	bh=gtDkFTXgVv7DVN2MGnyG5Te3hs9DML1Nc18YcEC6RcU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tV9Zr299U02d6u/knfZlLHQJVREt8q+9ETvgNLv6uf2JPJMMq0AXM1jodepIfbsqt
	 dzXOaw0nDR7L/HMOuMtnMXtuwMEwAzCMzLjXGTjRB8MIDolVV6ZYdgcUCOpTOWCC0M
	 wg2K+mowzdMtexR1W1S9HuLC+qYB3g9sRSN8t9EXGkOuCdNjfD8JluUqc89r9GllVB
	 ffmKpe6DiW2qMcdl7ZO4UDZe8i5N0g6oBtfphvcIBxST18tcZ+lGpWJs1zt1HZsPnp
	 2o88msP8TRlg4CRlBs1JnZ+SZWeqF8ZqV9oy3YbFkglJrK6hnTznEIFZ0vSfFNxHAj
	 4umf2hGIE9kXg==
Date: Mon, 22 Sep 2025 18:34:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 07/20] net, ethtool: Disallow mapped real rxqs
 to be resized
Message-ID: <20250922183449.40abf449@kernel.org>
In-Reply-To: <20250919213153.103606-8-daniel@iogearbox.net>
References: <20250919213153.103606-1-daniel@iogearbox.net>
	<20250919213153.103606-8-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Sep 2025 23:31:40 +0200 Daniel Borkmann wrote:
> Similar to AF_XDP, do not allow queues in a physical netdev to be
> resized by ethtool -L when they are peered.

I think we need the same thing for the ioctl path.
Let's factor the checks out to a helper in net/ethtool/common.c ?

