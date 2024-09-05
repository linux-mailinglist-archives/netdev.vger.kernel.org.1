Return-Path: <netdev+bounces-125532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785A996D91F
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6971C22CAE
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3329819CD07;
	Thu,  5 Sep 2024 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ToMBkDqW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA1A19AD48
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540147; cv=none; b=l9ho27RgdKtIl/gqpbKVpGe2kgTzhkPTKBRhaKFYmxclhWAh9CHZcJX1rBI3neNMXb8SB0VUYP89afuAoe5DxyZDVO4d40frntXbnGzWgLDV0SgZyRjb1h9+g2lsD6QIH6zQBXahxC/htv2ab51ZmjtyDctm6vPyoKPXZ3jjj9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540147; c=relaxed/simple;
	bh=3Txl3DLy0KLe9eWh2Fp8vSVoXzAHzfgAcLrNQ3eU9Y8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JW5z/YTNFclya29wQOXz8n2LGtopry14S7m1fIKUljDXuwqKxNtSg7tKhhQNvqcYFTBBFKd91bmSjvnz0ybuNQXHlQO/IXJ6vTKVnqAB/meo/+/BgQRiEUAOkef/nM5gJ4ogLQxSjT4S2q2cuDNLwMZVFjVjNel7i97bx6Xilq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ToMBkDqW; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725540145; x=1757076145;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=3Txl3DLy0KLe9eWh2Fp8vSVoXzAHzfgAcLrNQ3eU9Y8=;
  b=ToMBkDqW216egQhkSxun4jxgCHO4lFYyIYPbf3DgE2QHnEUmELg/Kyea
   a51m6IEp2hAtqBYGCahfEwp3JzMDJAwVqoFlBInCUHrnrbK8FZpt4U58r
   +8rYgeNOXUZTCOoxiCPfMIcVySE8eiz+lw7qy7suhu4k9N3g05u4f/xqh
   k+ot3meNKA74HL2mGzgJvbA/r2BxBeEGvXqFcSnUeVtwtNEW3rWYyGr4X
   7FLDD0ag72cM4iM7QN3b1LlVnEzarsYzS7Sk2hP7OORP5sbCmjeV22NfT
   dlm/2BOsnalsjyjPY1/W8UjDKfRM8NpaWVY9OayDtLjWOuiO9mU1Tmq9u
   Q==;
X-CSE-ConnectionGUID: W8r4h78DQ8aVhc2K92nu9A==
X-CSE-MsgGUID: VzuWjjzQSta3XZnn269oaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="28141163"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="28141163"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 05:42:24 -0700
X-CSE-ConnectionGUID: tI1V3CMZS6WBngplFr3Dpg==
X-CSE-MsgGUID: E6bq7acDT1OrvWA2ee9r2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="88855307"
Received: from gargmani-mobl1.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.222.46])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 05:42:22 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH net-next v5] net: sched: consistently use
 rcu_replace_pointer() in taprio_change()
In-Reply-To: <20240904115401.3425674-1-dmantipov@yandex.ru>
References: <20240904115401.3425674-1-dmantipov@yandex.ru>
Date: Thu, 05 Sep 2024 09:42:18 -0300
Message-ID: <87wmjqnufp.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Antipov <dmantipov@yandex.ru> writes:

> According to Vinicius (and carefully looking through the whole
> https://syzkaller.appspot.com/bug?extid=b65e0af58423fc8a73aa
> once again), txtime branch of 'taprio_change()' is not going to
> race against 'advance_sched()'. But using 'rcu_replace_pointer()'
> in the former may be a good idea as well.
>
> Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v5: cut from the series, add syzbot link an re-target to net-next
> v4: adjust subject to target net tree
> v3: unchanged since v2
> v2: added to the series
> ---

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

