Return-Path: <netdev+bounces-244919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D63E9CC23CA
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 12:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A579302EB10
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 11:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751AA3446C5;
	Tue, 16 Dec 2025 11:28:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BAD3446C0
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 11:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765884496; cv=none; b=CqS68Nf7qqSD0H1AR2rkDxIMcIpUZnC6Uc1jpFUsS70fdz7AAd0JIH9zkNODdhUs7KyFR8S6B9jBGTQBhUQSTAepDdopmJdi17bMwaACzzcpA4pOcorV29CqtpHnCbCN0sEdYxQQw9NyRHf53kQpt9unRmQcTWNH48Kh14+5e/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765884496; c=relaxed/simple;
	bh=UGFWnCxFcjrh2fiNCYLsDLnIcmo9rYQmXNxZfEskWq8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=t6c5hb0vsHPnWqOZyuSPyamtTqRPylq4cRxm525wZAdKN/xS1zo0dn8N1kPSmSqzrSQZPqV0eOFL+zP8kw7Le/9+C9VLQ44UPVeJPzN8LTZNRKMAodeU688orZOZemCk1RstC240tFBoFHcybkBPe6Rc04lH2A3BnXP/Gy81fsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5BGBSAD3015761;
	Tue, 16 Dec 2025 20:28:10 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5BGBSAu0015755
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 16 Dec 2025 20:28:10 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <13f54775-7a36-48f2-b9cd-62ab9f15a82b@I-love.SAKURA.ne.jp>
Date: Tue, 16 Dec 2025 20:28:08 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [not-yet-signed PATCH] RDMA/core: flush gid_cache_wq WQ from
 disable_device()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Leon Romanovsky <leon@kernel.org>, Majd Dibbiny <majd@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
        Yuval Shaia <yshaia@marvell.com>
Cc: Bernard Metzler <bernard.metzler@linux.dev>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
References: <30ec01df-6c32-490c-aa26-c41653f5a257@I-love.SAKURA.ne.jp>
 <8f90fba8-60b9-46e2-8990-45311c7b1540@I-love.SAKURA.ne.jp>
 <1722eff3-14c1-408b-999b-1be3e8fbfe5a@I-love.SAKURA.ne.jp>
 <9b4ce0df-1fbf-4052-9eb9-1f3d6ad6a685@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <9b4ce0df-1fbf-4052-9eb9-1f3d6ad6a685@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav403.rs.sakura.ne.jp
X-Virus-Status: clean

Hello, Jason Gunthorpe.

Commit 0df91bb67334 ("RDMA/devices: Use xarray to store the client_data")
says

    Since xarray can store 'going_down' using a mark just entirely eliminate
    the struct ib_client_data and directly store the client_data value in the
    xarray. However this does require a special iterator as we must still
    iterate over any NULL client_data values.

and started using DEVICE_REGISTERED mark. But It seems to me that that commit
has missed that ib_enum_roce_netdev() from ib_enum_all_roce_netdevs() is called
asynchronously from WQ context. Due to that commit, ib_enum_roce_netdev() became
no longer being called as soon as DEVICE_REGISTERED is cleared in
ib_unregister_device(); I guess that that commit needed to wait for pending
work items in gid_cache_wq WQ to complete. What do you think?

On 2025/12/15 23:09, Tetsuo Handa wrote:
> On 2025/12/11 22:24, Tetsuo Handa wrote:
>> Since a reproducer for this bug is not available, I haven't verified
>> whether this is a bug syzbot is currently reporting in
>> https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84 .
>> But I'd like to add Reported-by: syzbot if netdevice_event_work_handler()
>> is supposed to be called for releasing GID entry upon NETDEV_UNREGISTER
>> event. Thus, please review this change.
> 
> I can observe using simple atomic_t counters that there are sometimes pending
> netdevice_event() works as of immediately before clearing DEVICE_REGISTERED flag.
> That is, clearing DEVICE_REGISTERED flag without flushing pending netdevice_event()
> works results in failing to process some of netdev events.
> 
> I considered resolving DEVICE_REGISTERED flag inside netdevice_event() and then
> flush pending netdevice_event() works after clearing DEVICE_REGISTERED flag (diff
> is shown below). But I immediately got circular locking dependency problem by just
> executing "rdma link add siw0 type siw netdev lo" command line. Therefore, I guess
> that the reason RDMA code defers netdevice_event() handling to WQ context is to
> avoid circular locking dependency problem. But I guess that due to lack of reliable
> flushing mechanism when clearing DEVICE_REGISTERED flag, sometimes operations for
> deleting GID entry are not invoked, and syzbot is reporting refcount leak...

