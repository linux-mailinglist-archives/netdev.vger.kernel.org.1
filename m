Return-Path: <netdev+bounces-116319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAB7949EB4
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 05:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 705E61F24F6C
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 03:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDA617ADF9;
	Wed,  7 Aug 2024 03:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eMI2d0Kv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD84917ADE2
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 03:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723003006; cv=none; b=OLOfoq85FOu7UODwT/478pMuwz5fdQEcUaj9St84hqN+aIs6oTAyoTVEL9QSOLG842OpRQkqxWKi0bfJPrYpqptEMi6AcmMS6cCDV+9A0B7MhfNq4mM7y/N7bEkG1Bz8ZUGAm64Thbbd84ULuLEaKu5O5Axe5HXR72ubwnaQgac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723003006; c=relaxed/simple;
	bh=YgUfMaNzL3UADJGUO92OFlmfk5HEWoBHoAR7fXeAsU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pYkNkidEi+E0lBU4rFcDGSo9fpS1Gb5BQ8XG00pHmmYYRU3vQwJ5/PSpvv/ZhZuyOvlfrfZl5I4+gMa/9WAiRjWVlbtlR3Uj9AKJaKhypjq2MzCflQeA18/O+i8FlMvRaTq/wGUS35Bp4oYFNAWCrxiHf5ukRY/L19XfvUAv5kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eMI2d0Kv; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723003004; x=1754539004;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=YgUfMaNzL3UADJGUO92OFlmfk5HEWoBHoAR7fXeAsU4=;
  b=eMI2d0Kv3LEoV/9zeTx+H9biPTMfquJCP+dAivPU3OVn4icpHTyTTzR3
   6jrz2sAStmDy2sYp3gZbPRJwmku6d/C9NGlsbYC42g5tglE8Hz16v1tDT
   5po2ENOl6pZL0+uKMduKlq4PlYLrD+bgBnTbd+A2MZ/DnUNdHXhnqH6+H
   d5MdaDdYzvwRSXsIj4YvO02jbnQc8T0g2PNFT7pQpaA7MBUuDxuBFRz6m
   sMYx3ZXPXbFSx38kmabWMuJu4jLqQcrZPQcJ22QstiWvCpL7ynVtGe7tJ
   HbhwLzJ3kYA3aerRGY6RgRL4/GBVW3uVyiTKDoXNPybwhbbQFVHNtT5a9
   Q==;
X-CSE-ConnectionGUID: WPvt+4CsTLyDvzFYY84y7Q==
X-CSE-MsgGUID: sM1wnsJDSu6c/SL7jPAiwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="31720789"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="31720789"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 20:56:43 -0700
X-CSE-ConnectionGUID: nBXjBcXzTySWJGjaFuz6pA==
X-CSE-MsgGUID: WjZe6HDQTxCHRaoRAyJPaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="61530028"
Received: from sramkris-mobl1.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.220.76])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 20:56:42 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, lvc-project@linuxtesting.org, Dmitry Antipov
 <dmantipov@yandex.ru>,
 syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com
Subject: Re: [PATCH] net: sched: fix use-after-free in taprio_change()
In-Reply-To: <20240805135145.37604-1-dmantipov@yandex.ru>
References: <20240805135145.37604-1-dmantipov@yandex.ru>
Date: Tue, 06 Aug 2024 20:56:41 -0700
Message-ID: <87sevhx9xi.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Dmitry Antipov <dmantipov@yandex.ru> writes:

> In 'taprio_change()', 'admin' pointer may become dangling due to sched
> switch / removal caused by 'advance_sched()', and critical section
> protected by 'q->current_entry_lock' is too small to prevent from such
> a scenario (which causes use-after-free detected by KASAN). Fix this
> by prefer 'rcu_replace_pointer()' over 'rcu_assign_pointer()' to update
> 'admin' immediately before an attempt to schedule freeing.
>
> Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")
> Reported-by: syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b65e0af58423fc8a73aa
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  net/sched/sch_taprio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index cc2df9f8c14a..59fad74d5ff9 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -1963,7 +1963,8 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
>  
>  		taprio_start_sched(sch, start, new_admin);
>  
> -		rcu_assign_pointer(q->admin_sched, new_admin);
> +		admin = rcu_replace_pointer(q->admin_sched, new_admin,
> +					    lockdep_rtnl_is_held());

What I am thinking if, for consistency, the same change could be applied
to the other branch of this comparison (the txtime one). Could be a
separate patch, as the txtime branch is not going to race with
advance_sched().

For this patch:

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

