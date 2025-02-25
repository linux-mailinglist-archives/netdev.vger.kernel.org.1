Return-Path: <netdev+bounces-169287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC5BA43361
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 04:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73BB43B2B22
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 03:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B74713D531;
	Tue, 25 Feb 2025 03:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qds7/a+x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84A3199B9;
	Tue, 25 Feb 2025 03:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740452949; cv=none; b=sdLgVJeWQGMEenMwsuFWodQVQNZUcTw63BEKrHIwOld0uy5PZz6/Sao2qs5AX9OvYodDj/W1NARVjqTVAJajFujFC09ruBK+uKA3C5xRdntJCt2LbtkZt4h2C1ZYPttFv8v3avDgYGdaRtuljJ6ZMgOywgWke0LYGoAKqEzj/fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740452949; c=relaxed/simple;
	bh=Gu/8lJ9QVz5G73e/GMvq7QOK+xTz3/H/pqcRLEym0C0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RgmYxEPqmvpRyv9xND5QNhbgcwRy6Ck8fZXngoLH2OTI4+spJZGg5xbninqO7DQhL613u2qXGQrxHONuvGPsF10etOq8qbJIKzatuHWpqPOWKHU+eDpYf54seUkwgXZof/OITTwocpreNuPgSr5tJ8pyATcI+FJWAkst8G/43zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qds7/a+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2621C4CED6;
	Tue, 25 Feb 2025 03:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740452949;
	bh=Gu/8lJ9QVz5G73e/GMvq7QOK+xTz3/H/pqcRLEym0C0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qds7/a+xSfZmt4rw0TlIjjFaZg+C7tC5FM+j/J5A0cvt6vnIAzCIKY2b3d82Pi5TJ
	 ajkHzb26UeC5kxcKr9Z3cyKEGhwcas8crf4Vplqj1y5ip8rU+894PYR86/rKjxTLw2
	 qg9FuaoEMU+56B0jpgqF7VRysLvhpHPY3PyXJJXBywFcmEJ4ZTfRUlzQ+ZHhA4n/d7
	 8Y4vSjMesYLyOlA3Tvs+4D9iU+pwnsRppdZGBUwCJYAOUtf/sYsPyFm8YwH0oACeVA
	 IW80/Jocp9Hrpa2kiE9gjmiCyQ8aV1mH94xyCU/xe/U3xxqcHhXSeVji6yTwr/uI+Y
	 Mglf9aRrmDqTQ==
Date: Mon, 24 Feb 2025 19:09:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
 <chenhao418@huawei.com>, <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>,
 <jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
 <salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH v3 net-next 4/6] net: hibmcge: Add support for mac link
 exception handling feature
Message-ID: <20250224190908.1a5ba74e@kernel.org>
In-Reply-To: <20250221115526.1082660-5-shaojijie@huawei.com>
References: <20250221115526.1082660-1-shaojijie@huawei.com>
	<20250221115526.1082660-5-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 19:55:24 +0800 Jijie Shao wrote:
> +	if (!(priv->stats.np_link_fail_cnt % HBG_NP_LINK_FAIL_RETRY_TIMES)) {

This adds a 64b divide which breaks the build on some 32b arches:

ERROR: modpost: "__umoddi3" [drivers/net/ethernet/hisilicon/hibmcge/hibmcge.ko] undefined!
-- 
pw-bot: cr

