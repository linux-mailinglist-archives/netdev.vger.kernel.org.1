Return-Path: <netdev+bounces-118679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A5A9526E4
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 02:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40C72B21405
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 00:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A35A35;
	Thu, 15 Aug 2024 00:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjynN5md"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229E44A04
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 00:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723681670; cv=none; b=edqdsfFtBRAToL/EByJOWhYjMLYdlhwkK7NhA4W1Dl6Xol39vC91vPP888ABdinyP4CFD9hXde/qX/7qf/daN53Az4hnS/JNGytUg9jqMZ5/qh2GHev12vsHH7+VirGzzFE80NyN6FgjSPSM6YBhiaGVUtQba6A62PfCq+6pA7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723681670; c=relaxed/simple;
	bh=gH092xCWmq+fCYXUHAsOxr/Qq1mBD+GzGPTUIFNBmdM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pbd9AY9VVmgswS2+iCeeMxG4+GB3PTcqlJpEHOgRocRzJPJ8AHSiDrZOGKTJvC8t9rK28xSB9ZffIuc6pvGBf5TP3FQqj5WudxPzyLV05/+L2nYnzgON+wV9CVNJdIW7cZwRxjxweKMVGdYAd1e5EsiQqXrrP3m7dD24Le0ZDOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjynN5md; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744EBC116B1;
	Thu, 15 Aug 2024 00:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723681669;
	bh=gH092xCWmq+fCYXUHAsOxr/Qq1mBD+GzGPTUIFNBmdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WjynN5md5IUW52QWE6UcU3q9ljs7pHe/1F4LzBCZYk15LaBD1kC8EoLM2pZfr8dBu
	 CZMN/nsZtzyJHmn8JcILNFQp6ztPUslIdtRezVVOnsb6utCwPFcz2OB2Op0FfRGNRc
	 NweJLVayeQ5x5ciNYhovSdIRqSUTAHG4wP7vggPbvV/dgFym/4D2iK4F/jsJ7z52TN
	 XlO03Dwj+eP0px87ZZJVcNmeqIedtzN2c5xK0SoZZrJu3HF6OKod1LqqE5NYEGizoU
	 PvxalJmj4gJTFM3MAUfqLUa4t+6aOuEix8DsMes8+e8MjF0mD9tyVaJOfHoSgpV9AQ
	 6FKh6vwrlOk6A==
Date: Wed, 14 Aug 2024 17:27:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Brett Creeley <brett.creeley@amd.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <shannon.nelson@amd.com>
Subject: Re: [PATCH net 1/2] ionic: Fix napi case where budget == 0
Message-ID: <20240814172748.594a33c8@kernel.org>
In-Reply-To: <20240813234122.53083-2-brett.creeley@amd.com>
References: <20240813234122.53083-1-brett.creeley@amd.com>
	<20240813234122.53083-2-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 16:41:21 -0700 Brett Creeley wrote:
> The change in the fixes allowed the ionic_tx_cq_service() function
> to be called when budget == 0, but no packet completions will
> actually be serviced since it returns immediately when budget is
> passed in as 0. Fix this by not checking budget before entering
> the completion servicing while loop. This will allow a single
> cq entry to be processed since ++work_done will always be greater
> than work_to_do.
> 
> With this change a simple netconsole test as described in
> Documentation/networking/netconsole.txt works as expected.

I think I see a call to XDP cleanup as part of Tx processing.
XDP can't be handled with budget of 0 :(
-- 
pw-bot: cr

