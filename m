Return-Path: <netdev+bounces-141358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DF49BA884
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 23:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F571281F37
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 22:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C2318C932;
	Sun,  3 Nov 2024 22:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omfeuZ2y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F3518C926;
	Sun,  3 Nov 2024 22:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730672373; cv=none; b=UfejJzUhJMXCdTOlexcoHK5VLTJP0TvIT56bGSPljNx3VEz5t7amrNBNvXF74Lz7Eu/p2RJoYdQ8sjQ1qMR7aH5ndpd+wPGuM/DOo4gB/prEFLv7IxwuTO4P1nnu69I3UQLzC/2HzBa4Dsvu00PJ9YBCIjGivVEloVpb/xHgmok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730672373; c=relaxed/simple;
	bh=zjTzWQFZbOVzDhYxqUbkTA1hljL7a4C6h4pCeLPJkko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+Xo1XAUTyb+ng+dCDlh1W5cKik6kIA2UI+XiA+L5p3p0q35QHfG8PdZM+/qCvDOXTZHnzZNHz+YV44ilGms0h/d8sSEfTv1euBFtV6DhRIzDVLKmbA7BhRXF4f1fAwIGV2wnQO1V8CDpmI31X6t82+jM3XtrZ1Ko4UnlkKkskE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omfeuZ2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F9CC4CECD;
	Sun,  3 Nov 2024 22:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730672372;
	bh=zjTzWQFZbOVzDhYxqUbkTA1hljL7a4C6h4pCeLPJkko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=omfeuZ2yotEo7GHaaOw1DLthoyyES8T87pfkkuRIl49kOucDl/vA8G9/+aabszCvf
	 nMzerWbxNz3gcVvgIslsqEJKkxjMu+PaHSDsrrXVes40tEukmK+hwOKl6Kg0rfpOD6
	 iNYD3538KRpJp6OdorJ6/BL9s8fuao7iv2EOpbjvU+erYxYdcG4oyB81Lgg6BOVXAB
	 pgof7i6UuSbo1Q2gNVCe+SvT9tosc5ayOf8utCVOq/wlgSOgg/knyUd5Ug09TUPgTr
	 9aYgBaCx/wupS8prC7TLCYyXRqIPmpO3pedObnZY5ZVAgUL7HJyhapta6XZDcEL8RQ
	 ddr9oz35hy0uA==
Date: Sun, 3 Nov 2024 14:19:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: 'Andrew Lunn' <andrew@lunn.ch>, "Gongfan (Eric, Chip)"
 <gongfan1@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Cai
 Huoqing <cai.huoqing@linux.dev>, "Guoxin (D)" <guoxin09@huawei.com>,
 shenchenyang <shenchenyang1@hisilicon.com>, "zhoushuai (A)"
 <zhoushuai28@huawei.com>, "Wulike (Collin)" <wulike1@huawei.com>, "shijing
 (A)" <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>
Subject: Re: [RFC net-next v01 1/1] net: hinic3: Add a driver for Huawei 3rd
 gen NIC
Message-ID: <20241103141930.271ea070@kernel.org>
In-Reply-To: <000201db2e2d$82ad67d0$88083770$@huawei.com>
References: <cover.1730290527.git.gur.stavi@huawei.com>
	<ebb0fefe47c29ffed5af21d6bd39d19c2bcddd9c.1730290527.git.gur.stavi@huawei.com>
	<20241031193523.09f63a7e@kernel.org>
	<000001db2dec$10d92680$328b7380$@huawei.com>
	<661620c5-acdd-43df-8316-da01b0d2f2b3@lunn.ch>
	<000201db2e2d$82ad67d0$88083770$@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 3 Nov 2024 22:17:55 +0200 Gur Stavi wrote:
> Breaking a 10KLoC submission into a few 4KLcC (or less) patches helps to
> review specific patches (and ignore other patches) but all lines still need
> to be approved at once so someone must review them.
> 
> Breaking 10KLoC into multiple submissions is easier to review and approve
> (in parts), but merged code will be non-functional until the last
> submission.
> It will compile fine, do no harm, and nobody will pick it except for allyes
> builds.

The driver not being fully functional after the first submission is
fine.

This is a better example, although some parts could have still be
delayed to the second chunk:

https://lore.kernel.org/all/172054602727.1305884.10973465571854855750.stgit@ahduyck-xeon-server.home.arpa/

