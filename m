Return-Path: <netdev+bounces-117626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2678994E9A1
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 11:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC7B1F21157
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 09:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F2916D33B;
	Mon, 12 Aug 2024 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="tVh6VKW/"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E0816CD3D
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723454654; cv=none; b=U429fc+LrylCCVnaiI2k1CrzJ8VCXt8NVh+cn6Ac9gN/J/p4MQfi7dhprHQdmR3WUVpY0ud2rMMGa0NBFHWyXGwmQ8xEjOEGD/tZnvW15HJqtzi8r6mEvIVRZX258Cv/pvRlVJJX0qcLNkEHcmH+v1s75wpEQgzxmEZYJLSRilU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723454654; c=relaxed/simple;
	bh=xOQdU9jF2qwTVm5C0ZLXi8dTpsZrJjjDzYO5tNca+Ro=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=ozyNO358FPp18Dve8UfBbklLdpEuZWrhgcmEbL1KtS5//QiYBUzom8VJuA1EjwGR3O+B0q57ZB31wl9kJTUK8RkjagtHyhh3SvYuJ+5MTq3u6mCHjy0FwHf4Hunk+9gdVnh1kxrYf5lJ7X0VEqzSFyq2lJCmimX0p79N8siJ1YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=tVh6VKW/; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:1:e533:7058:72ab:8493] (unknown [IPv6:2a02:8010:6359:1:e533:7058:72ab:8493])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id E796D7D51B;
	Mon, 12 Aug 2024 10:24:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1723454652; bh=xOQdU9jF2qwTVm5C0ZLXi8dTpsZrJjjDzYO5tNca+Ro=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<6f0e2c8e-205c-71ae-2b93-02538122097a@katalix.com>|
	 Date:=20Mon,=2012=20Aug=202024=2010:24:11=20+0100|MIME-Version:=20
	 1.0|To:=20Cong=20Wang=20<xiyou.wangcong@gmail.com>|Cc:=20netdev@vg
	 er.kernel.org,=20davem@davemloft.net,=20edumazet@google.com,=0D=0A
	 =20kuba@kernel.org,=20pabeni@redhat.com,=20dsahern@kernel.org,=20t
	 parkin@katalix.com,=0D=0A=20horms@kernel.org,=20syzbot+0e85b10481d
	 2f5478053@syzkaller.appspotmail.com|References:=20<cover.172301156
	 9.git.jchapman@katalix.com>=0D=0A=20<2bdc4b63a4caea153f614c1f041f2
	 ac3492044ed.1723011569.git.jchapman@katalix.com>=0D=0A=20<Zrj6w89B
	 7so74jRU@pop-os.localdomain>|From:=20James=20Chapman=20<jchapman@k
	 atalix.com>|Subject:=20Re:=20[PATCH=20v2=20net-next=209/9]=20l2tp:
	 =20flush=20workqueue=20before=20draining=20it|In-Reply-To:=20<Zrj6
	 w89B7so74jRU@pop-os.localdomain>;
	b=tVh6VKW/hdBWuSikpVaOhxwXpwncc/QAWOmjMGKoCId7X8dGlRdsnTX5365r8q9Of
	 PH3AbSV/mSrjTfw4htNL+62jiP126PVng4wBB4g6IaISediXlH8Z3fEC/s0Bza6H/+
	 WSyt6+AuqDJ1jT1b6CuSDYPwQG4kNg9MtkRb/OYlzbTGgbp1+YxuVb6uVEDiWM0A9j
	 i+/NTnd88yYUKIATd+4UxItbswCQFreHQnmJDmFLQwG6CAMIQpVDxNzx05T7Ei6ya7
	 irEwdISTSsUnROeLlSBIVHlhcT5LeStGfLU/VTNkej1g1S8zAXdkH63xlaZiEmy2CI
	 mkizoGF1QWX+A==
Message-ID: <6f0e2c8e-205c-71ae-2b93-02538122097a@katalix.com>
Date: Mon, 12 Aug 2024 10:24:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, tparkin@katalix.com,
 horms@kernel.org, syzbot+0e85b10481d2f5478053@syzkaller.appspotmail.com
References: <cover.1723011569.git.jchapman@katalix.com>
 <2bdc4b63a4caea153f614c1f041f2ac3492044ed.1723011569.git.jchapman@katalix.com>
 <Zrj6w89B7so74jRU@pop-os.localdomain>
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: [PATCH v2 net-next 9/9] l2tp: flush workqueue before draining it
In-Reply-To: <Zrj6w89B7so74jRU@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/08/2024 18:54, Cong Wang wrote:
> On Wed, Aug 07, 2024 at 07:54:52AM +0100, James Chapman wrote:
>> syzbot exposes a race where a net used by l2tp is removed while an
>> existing pppol2tp socket is closed. In l2tp_pre_exit_net, l2tp queues
>> TUNNEL_DELETE work items to close each tunnel in the net. When these
>> are run, new SESSION_DELETE work items are queued to delete each
>> session in the tunnel. This all happens in drain_workqueue. However,
>> drain_workqueue allows only new work items if they are queued by other
>> work items which are already in the queue. If pppol2tp_release runs
>> after drain_workqueue has started, it may queue a SESSION_DELETE work
>> item, which results in the warning below in drain_workqueue.
>>
>> Address this by flushing the workqueue before drain_workqueue such
>> that all queued TUNNEL_DELETE work items run before drain_workqueue is
>> started. This will queue SESSION_DELETE work items for each session in
>> the tunnel, hence pppol2tp_release or other API requests won't queue
>> SESSION_DELETE requests once drain_workqueue is started.
>>
> 
> I am not convinced here.
> 
> 1) There is a __flush_workqueue() inside drain_workqueue() too. Why
> calling it again?

Once drain_workqueue starts, it considers any new work item queued 
outside of its processing as an unexpected condition. By doing 
__flush_workqueue first, we ensure that all TUNNEL_DELETE items are 
processed, which means that SESSION_DELETE work items are queued for all 
existing sessions before drain_workqueue starts. Now if an API request 
is processed to delete a session, l2tp_session_delete will do nothing 
because session->dead has already been set.

> 2) What prevents new work items be queued right between your
> __flush_workqueue() and drain_workqueue()?

Hmm, to do so, a new tunnel would need to be created and then deleted by 
API request once drain_workqueue starts. Is it possible to create new 
sockets in a net once a net's pre_exit starts? I didn't think so, but 
I'll recheck. Thanks!



