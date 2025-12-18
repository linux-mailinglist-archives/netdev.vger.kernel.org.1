Return-Path: <netdev+bounces-245310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB21DCCB45B
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 10:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99B5F3009824
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 09:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC26C30274D;
	Thu, 18 Dec 2025 09:53:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854CA331A7E
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 09:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766051603; cv=none; b=tawb/SinuelZqLGEHkC8BmfPPs8GjvJkk4d9Zb+Fe8k8qUK359oLP/SK5TB7pSFNi45m4XdeRRQIORnXYCSgz7CeJomgdxoOlDNUxJwO8kHhgO7AmfApczXFJrrm6B8gUvtL62ulj4iC/gzF7DQO2FbrCcOMck10SNh6anrUTWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766051603; c=relaxed/simple;
	bh=Y1zYvtM1CJh3dRA3GwjlMQkT2SDcc9ItRFo4Rht4O3Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UJvSzZCAlILY9/N4mx09Ma9CSPUzMJr5Xb0Vlty1WbTgGUcOC4qBQENUFWcCRw/auTCKzcFSG90qJ+eBsQnr/wPlUDSIOvrQDiGzAHZ9W3rizUlsl70Y6uvY+JZ8j8qY+AZQV+U8lnW7bAkIf/zeXzbHyjS158ncK5AdFAvCV9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5BI9rBEo092692;
	Thu, 18 Dec 2025 18:53:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5BI9rBEt092688
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 18 Dec 2025 18:53:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b4457da3-be2e-4de3-ae16-5580e1fb625c@I-love.SAKURA.ne.jp>
Date: Thu, 18 Dec 2025 18:53:08 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/core: flush gid_cache_wq WQ from disable_device()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Majd Dibbiny <majd@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, Yuval Shaia <yshaia@marvell.com>,
        Bernard Metzler <bernard.metzler@linux.dev>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
References: <30ec01df-6c32-490c-aa26-c41653f5a257@I-love.SAKURA.ne.jp>
 <8f90fba8-60b9-46e2-8990-45311c7b1540@I-love.SAKURA.ne.jp>
 <1722eff3-14c1-408b-999b-1be3e8fbfe5a@I-love.SAKURA.ne.jp>
 <9b4ce0df-1fbf-4052-9eb9-1f3d6ad6a685@I-love.SAKURA.ne.jp>
 <13f54775-7a36-48f2-b9cd-62ab9f15a82b@I-love.SAKURA.ne.jp>
 <ace1ebe4-4fdb-49f4-a3fa-bbf11e1b40ed@I-love.SAKURA.ne.jp>
 <20251216140512.GC6079@nvidia.com>
 <10caea5b-9ad1-44ce-9eaf-a0f4023f2017@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <10caea5b-9ad1-44ce-9eaf-a0f4023f2017@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav303.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/12/16 23:38, Tetsuo Handa wrote:
> I haven't confirmed that netdevice_event_work_handler() is called for
> releasing GID entry.
> But I'd like to try this patch in linux-next tree via my tree for testing.

I tried this patch in linux-next, but unfortunately this patch did not help.
I guess that we need to _explicitly_ invoke operations for deleting GIDs
rather than counting on WQ context.

Can somebody contact Matan Barak (the author of "IB/core: Add RoCE GID table
management" commit) for how default GID is supposed to be deleted, for
mellanox.com address is no longer reachable? 


