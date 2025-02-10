Return-Path: <netdev+bounces-164603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3D4A2E768
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9CB13A4C9A
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBDD1BCA19;
	Mon, 10 Feb 2025 09:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CceZQDOI"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD5343151
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739178812; cv=none; b=X/cegZJP6HaHKSie59FnripCgU4UrqFmtMjZiBs6EUgd5gnzG+Nk4zOP/avFKcuGogoH60LmC+/y4bQCJgn7k+siHJmIsmOLvnQlCT/8DZxlJW1r/g9RElojSdvli/gwgJUCcaV3+bZdOq6PkY6JYMc5J0ZKgp141cNoQ4I4ScI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739178812; c=relaxed/simple;
	bh=SO2WLT9I1fEp6/tddXypx3LT/ZM5k7PH/JAeb+PsiFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sKfmGH2v7ZUOLk19ACs9QSq2LRkUWGwqJpWgFVRK4acqJYF9K+GmLSV1oEYUZ18b1g+lBLYYkTwrtROe9Kx9v66f/3JVKeCORSdK+AdebMc9AT1692aENVrins7FfJNGxN+DGYa3VW0/sXznxAGqacosKP+Xh1NHj6AgREIJdIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CceZQDOI; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bfa55bd5-a5a1-4ef5-bb89-cb38eaec2cc0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739178806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pAf4xxjMd3bido3OYSPc5jm1TyPEocE6gMB8ihRh6EI=;
	b=CceZQDOIpIJ8DujjXQhLHKVWH2biBmI5Huqn7vs2vKD0wInknLcSiw0ug8ybSVw31/wGSA
	pAg4L7EctJLJwQ+rbnRuARQfnE90KGoW3tgf12xeCsT5UvsVWtAqdVpo0wdgK4brGzauFv
	1Yn1hubC91lNdczFV9oeCK6v96EmPYA=
Date: Mon, 10 Feb 2025 09:13:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] net: e1000e: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
To: Piotr Wejman <wejmanpm@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250208154350.75316-1-wejmanpm@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250208154350.75316-1-wejmanpm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/02/2025 15:43, Piotr Wejman wrote:
> Update the driver to use the new hardware timestamping API added in commit
> 66f7223039c0 ("net: add NDOs for configuring hardware timestamping").
> Use Netlink extack for error reporting in e1000e_hwtstamp_set.
> Align the indentation of net_device_ops.
> 
> Signed-off-by: Piotr Wejman <wejmanpm@gmail.com>
> ---
> Changes in v2:
>    - amend commit message
>    - use extack for error reporting
>    - rename e1000_mii_ioctl to e1000_ioctl
>    - Link to v1: https://lore.kernel.org/netdev/20250202170839.47375-1-piotrwejman90@gmail.com/
> 

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>


