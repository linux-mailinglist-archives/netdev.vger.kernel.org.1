Return-Path: <netdev+bounces-187264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FF2AA5FDE
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 16:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090784C4AE7
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 14:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1281F12F8;
	Thu,  1 May 2025 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lipgT58T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9761918C930;
	Thu,  1 May 2025 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746109411; cv=none; b=oGtZA8JASOI7epKFMWXLDI98Q+xvUXwL/Dpw5P+jc7oDmdOeWR7GionkffJtmDZHchNRR+IodQ7Sxa68A5yFwV6AtFJYcxKOdcVwgPzfy5j3zmhEFZdb5iNE5Nf8jnytNDZHhWojSGa9prZE1ZNlX5cIRHorcKWvRfx+SBxHOnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746109411; c=relaxed/simple;
	bh=sRz0mesXKY2QWf9bTxKjxQP1ZU6ljqpVt5gMZiM+hVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NYGVRafXBzalvQlm8dPBkLKAjrTipcJLBmSOqRUh3wbPSI6YbtwBSjcpB9EV2laL6HmPD05vmuoRcx8PTpnxq/aqW29rqCBhFXyfrGUEXE2F/x+GCScs8MwNWTAq9/jfNtrF5zw0SqnxpRJllla+A9+gSE7Jd8gPOpIAsiSj5Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lipgT58T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1B4C4CEE3;
	Thu,  1 May 2025 14:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746109411;
	bh=sRz0mesXKY2QWf9bTxKjxQP1ZU6ljqpVt5gMZiM+hVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lipgT58TEq1jiq3ta7iu9/BJj8eGdw2o0LEhgMeQM/shybSBaDrTBzfhrbC2zZqxd
	 phUpqd0DJ78MxpGI7RSEy8LNzL64/33QRqCax9QiY1imYNONrBGDEynd96/jxNtro0
	 AmEEgCbTy3FoBPp52qui0izu8nK2jpeIUKkAfhLrZv4BuwzeabcbnCr9bBeIdTYIfh
	 umiJNRtCH397iS4ifNlLnMRNfSzFRMyXdXVaTsFo9BdlmBRYJCLmBLwl8tbdiepL7f
	 x0b3y7vhmvZxSdds1GsvOLQYusFqto6x4/MWb5v5q7+xHEa3YzZWM691vdujez+hX2
	 m04bgb49DDt6Q==
Date: Thu, 1 May 2025 07:23:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
 <chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
 <shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/2] net: hibmcge: fix wrong ndo.open() after reset
 fail issue.
Message-ID: <20250501072329.39c6304a@kernel.org>
In-Reply-To: <20250430093127.2400813-3-shaojijie@huawei.com>
References: <20250430093127.2400813-1-shaojijie@huawei.com>
	<20250430093127.2400813-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Apr 2025 17:31:27 +0800 Jijie Shao wrote:
> If the driver reset fails, it may not work properly.
> Therefore, the ndo.open() operation should be rejected.

Why not call netif_device_detach() if the reset failed and let the core
code handle blocking the callbacks?
-- 
pw-bot: cr

