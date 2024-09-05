Return-Path: <netdev+bounces-125533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311B296D932
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6077A1C21206
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144A519DF95;
	Thu,  5 Sep 2024 12:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HXRU3E+4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F6F19DF94
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540238; cv=none; b=LluoxsTAOZkiZdNmK3mNgXEBaEtwdEVeQs1p6ZjBFx6bzueryNxtpBB77cxtR9nDI2RS7wBcvg/oaDarFs3RWb0FlDud2oxtgb3KCBPFkHo7n2m3coiwXT+Va14p18W9t3i0nwOjdMWSjfEaQWGbcjygr16FKVmsqz0zf46HRNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540238; c=relaxed/simple;
	bh=ZsB4kpfUAg5wSSkLTXGd/WAglrh5CzzkCmXeZba09So=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L3x7fhh1hDcajw3xyWvDWkVRfqQyz4KleD+qOmW2gkrvtp6ExzsH0eooQafgYpN8DGq2vUfDyHcnKYrt7VIY71h+aTq5eiJVzSYCjQ1fH4zPRvDHyHo4jPCyOY0a4IamgAVu83g380RIo71AFJP4P8ulxkvTp6eIjiHcPYtsO9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HXRU3E+4; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725540236; x=1757076236;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ZsB4kpfUAg5wSSkLTXGd/WAglrh5CzzkCmXeZba09So=;
  b=HXRU3E+4snUSb67mEps2y0ajsi1ktCrphvgPgpToSo9EdWBZPwYUU+4z
   5ymb3Cn4xGCZcG4JmZybxdEWUVEJyVidwa+KclYqk+kL3t7HpqtSsbuDZ
   wv08UFeaq5gDgYPZvt/HFyTeNFUKLSwTERscm8DHDxYPu19IFiWstMPLg
   5ArTU2j7c57evrktvigyFnQS/ZMY9XEhYJ2zB8wh5P9l9Jm5dXRYH3HHr
   7GxXFUQXWZ63sD4AhJpWGc3OkpDPec7CqDZwclykik6JqAu5A7bsaCyIe
   IEffqR0NnppoIh5Ok6oSxDMIeQOWW7Zfhnpn/d+uMy9M793UNOeaD+oSm
   g==;
X-CSE-ConnectionGUID: z+j2RnY0SYSk/FsEB+649Q==
X-CSE-MsgGUID: HafEehCqQiCbrMrDtG7c+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="34919572"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="34919572"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 05:43:55 -0700
X-CSE-ConnectionGUID: 52f1Y7oZTpOYdwFiAchCBA==
X-CSE-MsgGUID: PrEK0exxQCGHF1NlKgLQoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="65931783"
Received: from gargmani-mobl1.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.222.46])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 05:43:53 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>,
 syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com
Subject: Re: [PATCH net v5 1/2] net: sched: fix use-after-free in
 taprio_change()
In-Reply-To: <20240904120842.3426084-1-dmantipov@yandex.ru>
References: <20240904120842.3426084-1-dmantipov@yandex.ru>
Date: Thu, 05 Sep 2024 09:43:49 -0300
Message-ID: <87seuenud6.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

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
> v5: unchanged since v4 but resend due to series change
> v4: adjust subject to target net tree
> v3: unchanged since v2
> v2: unchanged since v1
> ---

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

