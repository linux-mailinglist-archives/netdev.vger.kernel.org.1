Return-Path: <netdev+bounces-117345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F53594DA8C
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8141C21819
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 03:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15DD1311B5;
	Sat, 10 Aug 2024 03:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yj/FXNJ6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4D653A7
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 03:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723262239; cv=none; b=VPrJb8ndOyAqF0qsiXuMFruBE5VWRzf3dJMs83vAAPoZ5R3fNHwAASi60cduA7q1864lnxSwIczoAQVISmwjqCzblgsjCMp7yTJdFu6pE5XYrC0p3aEXGQPPNvdqBy6fmvEaEX3jf3GWTAlR/PVSMJ3ZBp7pO//c+Za4+Wq+7oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723262239; c=relaxed/simple;
	bh=xEPbBk1VA07L0o43Q5bq31n4KUXD3hlTdV3SUs2ur3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1uj1gicKCTTaIq5Jd5rIM4G48lDgoG/YOC6mRxacT1dlDpBdd0R+VPsmYo/fpGjldnvJgBJd8PLqs+t1hT3GbSb+2W7cw9Moc5LBVgp5sDgiwOp4cj0DZ8FDNlxYQuCNN73ogbweVG0FhoW9TbazGvf0/a+QfvpkAyLZTglorQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yj/FXNJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F80C32781;
	Sat, 10 Aug 2024 03:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723262239;
	bh=xEPbBk1VA07L0o43Q5bq31n4KUXD3hlTdV3SUs2ur3Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yj/FXNJ6Drg4UU/Y4wxZ9kgvxSYzU6Um5KBIshkVX/88rUPdsmgLX/SPba+00oIpO
	 XYhCSrqiFiDvg4rkzvHMuA0pK3O/vrwJitUyqfGyO9gjL2VeXo0rYpgYmuOYSFBqQi
	 6jvhubgmy1UsmOUh6f+1mhqWPbU/VBu9wIJVIdZpqo9jXkJv/18G5FX9NEsOPk586d
	 6TFQg72qAqRNq38/eoIQwhAS5tGcIG9VLtEpyQNkfxcaAjm1XiW3OysjtVfApQVKz5
	 2MUK4sB0Z95lYwWxX0EC/w+ZEoat0vXGb1F+tUy2R1Kb0Sp0aVyp9yN06VvrMD/tpg
	 3CGns5b4xu3Ow==
Date: Fri, 9 Aug 2024 20:57:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yonglong Liu <liuyonglong@huawei.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, <netdev@vger.kernel.org>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <ilias.apalodimas@linaro.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [RFC net] net: make page pool stall netdev unregistration to
 avoid IOMMU crashes
Message-ID: <20240809205717.0c966bad@kernel.org>
In-Reply-To: <758b4d47-c980-4f66-b4a4-949c3fc4b040@huawei.com>
References: <20240806151618.1373008-1-kuba@kernel.org>
	<523894ab-2d38-415f-8306-c0d1abd911ec@huawei.com>
	<20240807072908.1da91994@kernel.org>
	<977c3d82-e2f0-4466-9100-7ea781e91ce1@huawei.com>
	<20240808070511.0befbdde@kernel.org>
	<758b4d47-c980-4f66-b4a4-949c3fc4b040@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Aug 2024 14:06:02 +0800 Yonglong Liu wrote:
> [ 7724.272853] hns3 0000:7d:01.0: page_pool_release_retry(): eno1v0 
> stalled pool shutdown: id 553, 82 inflight 6706 sec (hold netdev: 1855491)

Alright :( You gotta look around for those 82 pages somehow with drgn.
bpftrace+kfunc the work that does the periodic print to get the address
of the page pool struct and then look around for pages from that pp.. :(

