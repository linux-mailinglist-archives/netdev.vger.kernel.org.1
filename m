Return-Path: <netdev+bounces-149563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E480F9E63D3
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 02:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D99164BE3
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 01:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C5E13C8FF;
	Fri,  6 Dec 2024 01:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UedKjdLC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B733123918D;
	Fri,  6 Dec 2024 01:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733450358; cv=none; b=cd9XZ/sS8LIUbQn47TwZRwyQtDKOVrgD3UjzvR3YgBBC6aMexFAv1IaqhiISF58uD6izuIfLHr68Q3K0b4y+pWIWyrevz4kf4r8dDMGi8QAwXR2H7MVVLHGRcaNIAVBtLLX7w3mJSoi+Y1eVlEt6nizJW1EgAVt1B6K8QgeMtGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733450358; c=relaxed/simple;
	bh=OovP5Usy95Qw7SUPBcl/ecURq4J1gZ9MevjcjE34vpg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e0jbezStSuSWT44wnqQNzsxy2txF5JKVvRaI2A7wes/pIo+fKa5ZrEzmosmfVwKMEZZzsMLZumIKDYivWbwfoQDZrPdKjleDZKg23VzeF4d0AdALpLNnBOorT9Kg3BwhdDVhGHjZRCw+ixQ5bq5pBrzILhQSe/+R0iuWwdEEfPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UedKjdLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4745BC4CED6;
	Fri,  6 Dec 2024 01:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733450358;
	bh=OovP5Usy95Qw7SUPBcl/ecURq4J1gZ9MevjcjE34vpg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UedKjdLCQo7HLfBY6QGsBTLYFx5A6EafAwHoJBxqmkwLUDyvp2N550LAGEoT/XFef
	 QLSDgBFglH6jGLFQ+KVShwy1VHrSEJ0ztPVLmlPLJR67g63ddifngPJY15Cw5c6CUc
	 JmaXz46325gXhiN5IkzUFWqkALyv8iGqds8oqzkcfM7HrlB/3/gMIOI4+J7PliMnB/
	 5A5OyxCxiehB/MmduKHgz/ScnW2SRWiZLCArOuRPs9a5ViwjiaOOGSYuDyxJpd8ZrG
	 61uGkYXqy9Q3VzzhzDEPXxErxJcMW+0gcNgWLcYy9Ym82syjU3e3wUfzawbApQ3zz8
	 A7MZweELaDDPw==
Date: Thu, 5 Dec 2024 17:59:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
 <chenhao418@huawei.com>, <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>,
 <jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
 <salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <hkelam@marvell.com>
Subject: Re: [PATCH V4 RESEND net-next 6/7] net: hibmcge: Add reset
 supported in this module
Message-ID: <20241205175916.07d50c71@kernel.org>
In-Reply-To: <20241203150131.3139399-7-shaojijie@huawei.com>
References: <20241203150131.3139399-1-shaojijie@huawei.com>
	<20241203150131.3139399-7-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2024 23:01:30 +0800 Jijie Shao wrote:
> But the ethtool command already holds the rtnl lock in the dev_ethtool().
> So, the reset operation is not directly performed in
> ethtool_ops.reset() function. Instead, the reset operation
> is triggered by a scheduled task.

You can trivially factor out taking and releasing of the lock so that
ethtool path can execute just the logic inside, no?

