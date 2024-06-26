Return-Path: <netdev+bounces-106715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D782917567
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 03:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B059CB2242E
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 01:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51F49474;
	Wed, 26 Jun 2024 01:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gq3W58PR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE109BE4D;
	Wed, 26 Jun 2024 01:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719363855; cv=none; b=HPzrQBi9PF9WGTCT4ZpPgVVrWoDZeuGse5FhfK6IJQXfMUvWm1cvvzkQ9xKQZCwU1GBA8j9e/oA3Znl3a/9NeYhJOrX4KhNtmWVgjqFg4lLx475uYHJEu8oGq0WMCLXjSHls/hksnig0BFNFkOgoMEUXp90tx+MQpeAO945y9ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719363855; c=relaxed/simple;
	bh=+ZcT9RCprQS3oWPHZ0tGnhTqxIuSVscBhObBEiXlA94=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E6CXig+WorS5snaacyUgc0kmW5I16jonbuN6p2P4EUsUo8vWkF1ED8kZUzq1rUliNCSOnAqWRrD+m0dRKRVMhMY7bzyIGN7dwWZB9fwGBWX8cXOARMFDkBemSE1l9b1HzdfbH+3tN72CXTXNBGJ89jq8vcWdH85IRC/IPrinxpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gq3W58PR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E9AC32781;
	Wed, 26 Jun 2024 01:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719363855;
	bh=+ZcT9RCprQS3oWPHZ0tGnhTqxIuSVscBhObBEiXlA94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gq3W58PRfbsoTw9LyuiK3M8qbhNBLCJ1wDaGTEeEz1ETI/rrrsFHZvH947EUZUbPA
	 eLQY2gD0okQwoqXBL+y55sKGqncZrkDXRiat3B6LQO1SSp5LND/cXhQsHsJJ9sez3c
	 uysxTfcSAEQxI4yMb1oL58pCOdvW+4QqLBIyG/r8YnR/e5W8q5egu6l0Ehr71oSr57
	 7m/XwNvcDnA0X88XYrlp/E2lyXque4/NzDj8i/bY2XeNhGF1akwsjivl1FHAfNBPuU
	 XHhTFNqx29XNNA0T7Cte+Uv0GlCokIpYp7PbX35IyZS1YZuwz5N+w8n1Y1p9rAPe2K
	 ZsB1m6+XAieTQ==
Date: Tue, 25 Jun 2024 18:04:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
 <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
 <jerinj@marvell.com>, <markus.elfring@web.de>
Subject: Re: [net PATCH v2 1/7] octeontx2-af: Fix klockwork issue in cgx.c
Message-ID: <20240625180414.302fab44@kernel.org>
In-Reply-To: <20240625173350.1181194-2-sumang@marvell.com>
References: <20240625173350.1181194-1-sumang@marvell.com>
	<20240625173350.1181194-2-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 23:03:43 +0530 Suman Ghosh wrote:
> Variable "cgx_dev" and "lmac" was getting accessed without NULL checks
> which can lead to pointer exception in some erroneous scenarios.
> This patch fixes the same by adding the required NULL checks.

Please remove the name of the tool from the subject, too.

You can add something like:

Addresses klockwork warning ${the warning generated or such}

at the end of the commit message.

If there's a path which can lead to a crash please describe it.
If there's no real issue, it's not a fix (no Fixes and net-next).

But really, we tend to avoid addressing issues just to please
overzealous static code analysis tools. And we advise against
defensive programming, so please make sure the patches actually 
make sense. I don't think patch 6 does, picking a random one to check..

