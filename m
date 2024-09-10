Return-Path: <netdev+bounces-126840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5D9972A4A
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 09:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2958C283816
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 07:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277C917BB1A;
	Tue, 10 Sep 2024 07:10:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321C613A242
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 07:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952237; cv=none; b=aENvCyHutk79S8K1vdB48gFHFeypsyjSPZKy6oP6bt0M3uTyNiOzqzHmaF+zsUNQ5ahiNMzYhXfJN2jXW/9Z5HpC12scKdWeSc0ofPxm35J6ttrf/8V9JoLiohtjlRFIGahTFiA3Gu/Vd3i6yJFJGZ6K+5gHoWEuNvqgVuaQkrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952237; c=relaxed/simple;
	bh=pZCljvw97/rZNI8yaSH090YkIecfoC8uFHFATXJANM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfnq+fHYZYUfJPwNg7TuPM5OUQv1a5oOQxL7DTV0m4T9ENCfSQd9fULBREyfcWzXOMTdXo2/VLSTuRfFpxeOs6T6gRkk2pJGT6I3jYO4nyANtGx8TMi6VwJGmvAJX7jXQkwOGc6frSku2cyvNskcBWGuoK4pgyhYwmx2DTc1oVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.12.127] (g127.RadioFreeInternet.molgen.mpg.de [141.14.12.127])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 20F1561E5FE05;
	Tue, 10 Sep 2024 09:09:38 +0200 (CEST)
Message-ID: <09022c4f-37bf-4119-bf64-87e82af3673e@molgen.mpg.de>
Date: Tue, 10 Sep 2024 09:09:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v7 net-next 01/15] genetlink: extend
 info user-storage to match NL cb ctx
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Donald Hunter <donald.hunter@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, edumazet@google.com,
 Madhu Chittim <madhu.chittim@intel.com>, anthony.l.nguyen@intel.com,
 Simon Horman <horms@kernel.org>, przemyslaw.kitszel@intel.com,
 Jakub Kicinski <kuba@kernel.org>, intel-wired-lan@lists.osuosl.org,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>
References: <cover.1725919039.git.pabeni@redhat.com>
 <4bd304768d7ef1fdee5033b8fe1788092ac0af38.1725919039.git.pabeni@redhat.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <4bd304768d7ef1fdee5033b8fe1788092ac0af38.1725919039.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Paolo,


Thank you for your patch.

Am 10.09.24 um 00:09 schrieb Paolo Abeni:
> This allows a more uniform implementation of non-dump and dump
> operations, and will be used later in the series to avoid some
> per-operation allocation.
> 
> Additionally rename the NL_ASSERT_DUMP_CTX_FITS macro, to
> fit a more extended usage.

Should a resent be necessary, you could also mention the new name 
`NL_ASSERT_CTX_FITS` in the commit message. (Maybe even a separate 
commit, so the actual change is easier to review.)

> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>   drivers/net/vxlan/vxlan_mdb.c        | 2 +-
>   include/linux/netlink.h              | 5 +++--
>   include/net/genetlink.h              | 8 ++++++--
>   net/core/netdev-genl.c               | 2 +-
>   net/core/rtnetlink.c                 | 2 +-
>   net/devlink/devl_internal.h          | 2 +-
>   net/ethtool/rss.c                    | 2 +-
>   net/netfilter/nf_conntrack_netlink.c | 2 +-
>   net/netlink/genetlink.c              | 4 ++--
>   9 files changed, 17 insertions(+), 12 deletions(-)

[…]

With this:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

